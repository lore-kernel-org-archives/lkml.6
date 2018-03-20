Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751837AbeCTIWy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:22:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:36210 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750991AbeCTIWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:22:50 -0400
From: NeilBrown <neil@brown.name>
To: John Crispin <john@phrozen.org>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Date: Tue, 20 Mar 2018 19:22:40 +1100
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] MIPS: ralink: fix booting on mt7621
In-Reply-To: <87efkf9z0o.fsf@notabene.neil.brown.name>
References: <87efkf9z0o.fsf@notabene.neil.brown.name>
Message-ID: <87605r9mwf.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Further testing showed that the original version of this
patch wasn't 100% reliable.  Very occasionally the read
of SYSC_REG_CHIP_NAME0 returns garbage.  Repeating the
read seems to be reliable, but it hasn't happened enough
for me to be completely confident.
So this version repeats that first read.

Thanks,
NeilBrown


=2D---------------8<--------------------
Since commit 3af5a67c86a3 ("MIPS: Fix early CM probing") the MT7621
has not been able to boot.

This patched caused mips_cm_probe() to be called before
mt7621.c::proc_soc_init().

prom_soc_init() has a comment explaining that mips_cm_probe()
"wipes out the bootloader config" and means that configuration
registers are no longer available.  It has some code to re-enable
this config.

Before this re-enable code is run, the sysc register cannot be
read, so when SYSC_REG_CHIP_NAME0 is read, a garbage value
is returned and panic() is called.

If we move the config-repair code to the top of prom_soc_init(),
the registers can be read and boot can proceed.

Very occasionally, the first register read after the reconfiguration
returns garbage.  So repeat that read to be on the safe side.

Fixes: 3af5a67c86a3 ("MIPS: Fix early CM probing")
Signed-off-by: NeilBrown <neil@brown.name>
=2D--
 arch/mips/ralink/mt7621.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index 1b274742077d..c37716407fbe 100644
=2D-- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -170,6 +170,29 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
 	u32 n1;
 	u32 rev;
=20
+	/* Early detection of CMP support */
+	mips_cm_probe();
+	mips_cpc_probe();
+
+	if (mips_cps_numiocu(0)) {
+		/*
+		 * mips_cm_probe() wipes out bootloader
+		 * config for CM regions and we have to configure them
+		 * again. This SoC cannot talk to pamlbus devices
+		 * witout proper iocu region set up.
+		 *
+		 * FIXME: it would be better to do this with values
+		 * from DT, but we need this very early because
+		 * without this we cannot talk to pretty much anything
+		 * including serial.
+		 */
+		write_gcr_reg0_base(MT7621_PALMBUS_BASE);
+		write_gcr_reg0_mask(~MT7621_PALMBUS_SIZE |
+				    CM_GCR_REGn_MASK_CMTGT_IOCU0);
+	}
+
+	n0 =3D __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
+	/* Sometimes first read returns garbage, so try again to be safe */
 	n0 =3D __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
 	n1 =3D __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
=20
@@ -194,26 +217,6 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
=20
 	rt2880_pinmux_data =3D mt7621_pinmux_data;
=20
=2D	/* Early detection of CMP support */
=2D	mips_cm_probe();
=2D	mips_cpc_probe();
=2D
=2D	if (mips_cps_numiocu(0)) {
=2D		/*
=2D		 * mips_cm_probe() wipes out bootloader
=2D		 * config for CM regions and we have to configure them
=2D		 * again. This SoC cannot talk to pamlbus devices
=2D		 * witout proper iocu region set up.
=2D		 *
=2D		 * FIXME: it would be better to do this with values
=2D		 * from DT, but we need this very early because
=2D		 * without this we cannot talk to pretty much anything
=2D		 * including serial.
=2D		 */
=2D		write_gcr_reg0_base(MT7621_PALMBUS_BASE);
=2D		write_gcr_reg0_mask(~MT7621_PALMBUS_SIZE |
=2D				    CM_GCR_REGn_MASK_CMTGT_IOCU0);
=2D	}
=20
 	if (!register_cps_smp_ops())
 		return;
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqwxNAACgkQOeye3VZi
gbkmVBAAi3Nd636K1+EkS6U9RpLeTJvWp58517DnxsEVAIRYKxAOX7zZ+OBUtOck
biplfu56/9sWcxvLol5MUlGeU/fATAgEM9A8CT+tAbgMCS3mKQ8Age2TCvE2QdkA
hYd+KGyNxJYFl7PHU7zeo0VC45HgSYLKXyOctxqNN9/Va6c43ZnHC6WQyVJGtbsZ
6hOxXJfH0oVzkSUBqSyvCyY5J8M4RWfXceTcBZW2Df7pBEjTYmdvpWuN8Nnnu/F2
IYqABbYIFVSfX4ud7uN60cNSLwu55asBpS5htfMHlLiRVmrB6WVXqAn5zyCBQmcd
ahqj3iPwZueylQNEzy4EWKDcUe9QQdX9cjdYC5t30cEB9ZXl48ZGI5nNthcpruRA
vFWdcFYo8Znb+yKElmF7Gn3H/7/HJfvlOEyEKUftIfCP/HKQ1c6nx/lOaGr5Cpgh
gLn3sk7RlI1EC8TdAQU7qDN1zyIKEijPSUjItHY7lfSghRtTXb0832QFHh5cw1b/
YPI2Q+D7UJV2C83MQkrsgtpGbDDjQsSg9hKXySqlaVS63dy4/bqDFZi4wkerJemv
/iFN4ZINW08d9On5fCxESevjy+WCLvsTDedNu0WhCvUD1r5HCPzu1snKGC8EsmO4
msHf8jpkS/so1YmIBcXe5NXXWC/na7BDsTSY6ZAHoEHcLC6Pov0=
=FILq
-----END PGP SIGNATURE-----
--=-=-=--
