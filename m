Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbeB0NVz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 08:21:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:37759 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753081AbeB0NVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 08:21:53 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,401,1515484800";
   d="asc'?scan'208";a="31016967"
From: Felipe Balbi <felipe.balbi@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: HRTimer causing rtctest to fail
Date: Tue, 27 Feb 2018 15:20:58 +0200
Message-ID: <87vaei601x.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi folks,

I'm facing an odd problem with v4.16-rc2 (also reproducible on v4.15
final) where rtctest fails sometimes which PIE coming too late with
frequencies >=3D 1024 Hz.

I've modified rtctest.c a bit so that it continues running even after
first failure just so I could get a glimpse of how many times it fails.

Here are the results:

Error 1024Hz i 17/20 diff 1089/976

Error 2048Hz i 2/20 diff 538/488
Error 2048Hz i 9/20 diff 558/488
Error 2048Hz i 16/20 diff 560/488

Error 4096Hz i 2/20 diff 305/244
Error 4096Hz i 7/20 diff 288/244
Error 4096Hz i 9/20 diff 285/244
Error 4096Hz i 11/20 diff 310/244
Error 4096Hz i 16/20 diff 284/244
Error 4096Hz i 20/20 diff 317/244


I added a few trace_printk() calls around rtc_dev_read() (and some other
functions) and captured the time for entry and exit of that function. I
noticed that HRTimer fires way too late and also way too early
sometimes. On the order of 100+ us.

For example with iterations 17 of 1024 Hz (seen above) and 18 (also of
1024 Hz) I captured the following time stamps (all in uS):

|    Start |      End | Expected End | Diff |
|----------+----------+--------------+------|
| 35900626 | 35901711 |     35901603 | -108 | (too late)
| 35901826 | 35902628 |     35902803 |  174 | (too early)

I can't come up with a proper explanation as to why HRTimer is firing at
such wildly odd extremes. On most of the measurements, HRTimer executes
within 5 uS of scheduled time and I can't convince myself that
scheduling latency would get so high all of a sudden. Specially
considering I'm testing with a 4 core machine and there's nothing else
running on it. It's mostly idle.

Any hints as to how to track down this problem further? Also, do folks
agree that rtctest's 10% slack should also be considered for too early
firing times? I mean:

diff --git a/tools/testing/selftests/timers/rtctest.c b/tools/testing/selft=
ests/timers/rtctest.c
index 411eff625e66..99aa46fc556c 100644
=2D-- a/tools/testing/selftests/timers/rtctest.c
+++ b/tools/testing/selftests/timers/rtctest.c
@@ -317,7 +317,8 @@ int main(int argc, char **argv)
                        gettimeofday(&end, NULL);
                        timersub(&end, &start, &diff);
                        if (diff.tv_sec > 0 ||
=2D                           diff.tv_usec > ((1000000L / tmp) * 1.10)) {
+                           diff.tv_usec > ((1000000L / tmp) * 1.10) ||
+                           diff.tv_usec < ((1000000L / tmp) * 0.9)) {
                                fprintf(stderr, "\nPIE delta error: %ld.%06=
ld should be close to 0.%06ld\n",
                                       diff.tv_sec, diff.tv_usec,
                                       (1000000L / tmp));

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlqVWzwACgkQzL64meEa
mQazKw/+NoEqe2xY6+Cs21C5icYpntTss2D5HP0WE1YPKeU5EjuHQBlzISY8OLc9
7lByfyqdoghbtLRzU8DzC23ZWzow06TQf1sDd4BRm0RkYIWC634yXiYpAi9nQ9Bf
4pfHnCYzjEZDEWwBsYi0ieZxfZZuCpn1hoog45WDx/b7BDeD37yiFFk37D4kqb1E
/q1YfnCLjD//C8iwSsneS537dR63QZ4O3TEIk5zEorwfS05VqqrRg9fp2icqwktW
JCD42hXRHszCSB24TnwGu2kHHvR8obyQRMNxNFdDtFbeN4YBJRYyciTMUgNVnjsn
oedVddN+gn4g9nSqqhQJ13zfe4IuPz9FMar9Q7qP0DDSB7hA9GRF59ozo/cqXLUr
inOrAfT+cGOXKd9YIgllFf6Vi9/0XzSAT0g1ITIDQmszmgagZ+NCEFCuURey9D8L
ES5l/JDX34NR7NuhQidGLKPxCGgOdmDkad0FtXIz4MlNbuAenBWoWUwOcwKuBgCs
doorihntGElgijWAW4KI2v/9w0u9wilNOmrCsdOQggzq1wWUBMLRL3qVc5taLENl
CLzjfmynC7Ph8KxXbye5J7XxNBEsZiIu6+fOa6f6EpjLL06mAhno3DoaCePdP4JF
6tplIf04myrL2JVeA2tZOxC2vniPyH82MpJGYYhwmYyqVhJqFs8=
=vem4
-----END PGP SIGNATURE-----
--=-=-=--
