Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeCUDCS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 23:02:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:56943 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751524AbeCUDCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 23:02:18 -0400
From: NeilBrown <neil@brown.name>
To: John Crispin <john@phrozen.org>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Date: Wed, 21 Mar 2018 14:02:10 +1100
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] MIPS: ralink: fix booting on mt7621
In-Reply-To: <87605r9mwf.fsf@notabene.neil.brown.name>
References: <87efkf9z0o.fsf@notabene.neil.brown.name> <87605r9mwf.fsf@notabene.neil.brown.name>
Message-ID: <871sge872l.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


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
returns garbage.  So I added a call to __sync().

Fixes: 3af5a67c86a3 ("MIPS: Fix early CM probing")
Signed-off-by: NeilBrown <neil@brown.name>
=2D--
 arch/mips/ralink/mt7621.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/arch/mips/ralink/mt7621.c b/arch/mips/ralink/mt7621.c
index 1b274742077d..d2718de60b9b 100644
=2D-- a/arch/mips/ralink/mt7621.c
+++ b/arch/mips/ralink/mt7621.c
@@ -170,6 +170,28 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
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
+		__sync();
+	}
+
 	n0 =3D __raw_readl(sysc + SYSC_REG_CHIP_NAME0);
 	n1 =3D __raw_readl(sysc + SYSC_REG_CHIP_NAME1);
=20
@@ -194,26 +216,6 @@ void prom_soc_init(struct ralink_soc_info *soc_info)
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

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlqxyzIACgkQOeye3VZi
gbkyiA//WcDe/Lw0u1r6cPEEBwG2nmNfaSUtB2Gx7nKRr2GqZrUmhrik60RZCA78
q7h17ofR2+g2hhloHh+HQ4n7k+/BlVcwGx5gPX34WemNijbwNKTnqKQSLQABfDou
8V9QB+fsoQ2ykKlOF6eoRKrO0LDa+/DuypcJCIYIg+cRmZ9XfynKKs5DNptOWpWt
RlXQZSGnAh2TuU4Jp9zZPZN5o5hxLY44RZKZvHCbkmwUkc5G1g+dkZndyxadAQkp
TKu5Ibe4ra3gNW0QVkJPE21sCmiUNFwcj6dpgyglemyAPYm9rDvb53hNMAoESj67
l8owbnzsLty94AX9QZCbCuKhfyv84aSo6R6Tyo8O7C48LvlR+tnQxpMdMT6JPKE5
OMQXaRwgbC0yJebFsQ4tLRwq7iYK44Ef/alyZHOAqxSQry8OcRTh7+mqtf6jK5lx
CbFKmK3FK4v7nEqPQrgfgpsC9Un9NjbZW8MWjyGWeTnbIr8nvd056XFSiDgPsSeb
zZE8rcuGTs6UCxRjuycSOB553y7O75dB3uOtoEufWi0eTLi2cY+uutdiWCEWDWwQ
tJfEhgfE2xcNK/XDvec1fmrK21PM1EWtu0Zp6+JgfDlpSQsIfBOLRaGW4W5xzAAT
NlsffJ02qNVJN+9t1KrHPDedgcFYKdjf8YB+rAb0qYGzFqm48v4=
=L1Wt
-----END PGP SIGNATURE-----
--=-=-=--
