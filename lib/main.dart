import 'package:flutter/material.dart';

// --- Model Data Profil ---
class UserProfile {
  final String fullName;
  final String nim;
  final String address;
  final String phoneNumber;
  final String description;

  const UserProfile({
    required this.fullName,
    required this.nim,
    required this.address,
    required this.phoneNumber,
    required this.description,
  });
}

// Data Dummy Profil
const UserProfile dummyProfile = UserProfile(
  fullName: 'Sultan Akhsanuddin Adillah',
  nim: '221080200028',
  address: 'Jl. Masjid RT 04 RW 02 Desa Kemiri,Sidoarjo, Jawa Timur',
  phoneNumber: '+62 881-0248-7662',
  description:
      'Mahasiswa aktif semester 7 di Program Studi Teknik Informatika. Memiliki minat yang kuat di bidang pengembangan aplikasi mobile menggunakan Flutter dan desain UI/UX. Bersemangat untuk belajar teknologi baru dan berkontribusi pada proyek inovatif.',
);

void main() {
  runApp(const MyApp());
}

// Widget utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Halaman Profil Mahasiswa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan.shade800),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const ProfilePage(profile: dummyProfile),
    );
  }
}

// ============================================
// HALAMAN PROFIL
// ============================================
class ProfilePage extends StatefulWidget {
  final UserProfile profile;
  const ProfilePage({super.key, required this.profile});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Variabel baru untuk mengontrol tampilan Keterangan Diri
  bool _isDescriptionVisible = false;
  // Variabel untuk mengontrol transparansi (opacity) konten utama
  double _contentOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Animasi Fade-In
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _contentOpacity = 1.0;
        });
      }
    });
  }

  // --- FUNGSI BARU: Mengubah status tampil/sembunyi Keterangan Diri ---
  void _toggleDescriptionVisibility() {
    setState(() {
      _isDescriptionVisible = !_isDescriptionVisible;
    });
    // Scroll ke bagian bawah jika Keterangan Diri ditampilkan
    if (_isDescriptionVisible) {
      // Tidak perlu scrollController karena SingleChildScrollView menangani overflow
    }
  }

  // --- FUNGSI: Melihat Detail Gambar Profil ---
  void _showImageDetail(BuildContext context, String tag) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
          ),
          body: Center(
            child: Hero(
              tag: tag,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white54, width: 4),
                ),
                child: const CircleAvatar(
                  radius: 150,
                  backgroundColor: Colors.white10,
                  child: Icon(
                    Icons.account_circle,
                    size: 180,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget pembantu untuk menampilkan setiap baris detail
  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color accentColor = Theme.of(context).colorScheme.secondary;
    final Color backgroundColor = Theme.of(
      context,
    ).colorScheme.surfaceVariant.withOpacity(0.2);
    final String heroTag = 'profile-avatar-${widget.profile.nim}';

    // Aksi untuk tombol KIRIM PESAN
    void handleActionButton() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Aksi kontak dilakukan untuk: ${widget.profile.fullName}',
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: primaryColor,
        ),
      );
    }

    // Aksi untuk InkWell (Toggle Keterangan Diri)
    void handleCardTap() {
      _toggleDescriptionVisibility();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isDescriptionVisible
                ? 'Keterangan Diri Ditampilkan!'
                : 'Keterangan Diri Disembunyikan.',
          ),
          duration: const Duration(milliseconds: 700),
          backgroundColor: primaryColor.withOpacity(0.8),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Profil Mahasiswa',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- FOTO PROFIL (Lihat Detail) ---
            GestureDetector(
              onTap: () => _showImageDetail(context, heroTag),
              child: Hero(
                tag: heroTag,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: accentColor.withOpacity(0.1),
                    child: Icon(
                      Icons.account_circle,
                      size: 85,
                      color: primaryColor.withOpacity(0.8),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Nama Lengkap & NIM
            Text(
              widget.profile.fullName,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: primaryColor.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'NIM: ${widget.profile.nim}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 30),

            // --- KONTEN PROFIL (dengan Animasi Fade-In) ---
            AnimatedOpacity(
              opacity: _contentOpacity,
              duration: const Duration(milliseconds: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- AREA KARTU DETAIL (Toggle Keterangan Diri) ---
                  Material(
                    color: Colors.white,
                    elevation: 2,
                    borderRadius: BorderRadius.circular(15),
                    child: InkWell(
                      onTap: handleCardTap, // Panggil fungsi toggle
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Informasi Kontak (Ketuk untuk Detail Diri)',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor,
                              ),
                            ),
                            Divider(color: Colors.grey.shade200, height: 20),

                            _buildDetailRow(
                              icon: Icons.phone,
                              label: 'Nomor Telepon',
                              value: widget.profile.phoneNumber,
                            ),
                            _buildDetailRow(
                              icon: Icons.location_on,
                              label: 'Alamat Saat Ini',
                              value: widget.profile.address,
                            ),

                            // Tambahkan indikator visual
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Center(
                                child: Icon(
                                  _isDescriptionVisible
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // --- KETERANGAN DIRI (Menggunakan AnimatedContainer/SizeTransition) ---
                  // Menggunakan AnimatedSwitcher untuk transisi tampil/sembunyi yang halus
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      // Menggunakan SizeTransition untuk animasi buka/tutup yang elegan
                      return SizeTransition(
                        sizeFactor: animation,
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: _isDescriptionVisible
                        ? Container(
                            key: const ValueKey(
                              'visibleDescription',
                            ), // Key unik untuk AnimatedSwitcher
                            width: double.infinity,
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'Keterangan Diri',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.profile.description,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    height: 1.5,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink(
                            key: ValueKey('hiddenDescription'),
                          ), // Widget kosong saat tersembunyi
                  ),

                  // SizedBox dihilangkan dari atas jika tidak tampil, digantikan jarak 20px
                  if (_isDescriptionVisible)
                    const SizedBox(height: 40)
                  else
                    const SizedBox(height: 20),

                  // --- TOMBOL AKSI ---
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: handleActionButton,
                      icon: const Icon(Icons.send, size: 20),
                      label: const Text(
                        'Kirim Pesan',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
