Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753002AbeDTWyu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 18:54:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:33712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752496AbeDTWyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 18:54:49 -0400
From: NeilBrown <neil@brown.name>
To: Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Sat, 21 Apr 2018 08:54:40 +1000
Subject: [PATCH v4] mtd: spi-nor: clear Winbond Extended Address Reg on switch to 3-byte addressing.
In-Reply-To: <967de310-3b9a-1853-3377-71f71fd8ac27@gmail.com>
References: <874lkmw54j.fsf@notabene.neil.brown.name> <87sh7wrq8p.fsf@notabene.neil.brown.name> <20180420215440.7b078f6c@bbrezillon> <87h8o5po1h.fsf@notabene.neil.brown.name> <967de310-3b9a-1853-3377-71f71fd8ac27@gmail.com>
Message-ID: <87o9ido5e7.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Winbond spi-nor flash 32MB and larger have an 'Extended Address
Register' as one option for addressing beyond 16MB (Macronix
has the same concept, Spansion has EXTADD bits in the Bank Address
Register).

According to section
   8.2.7 Write Extended Address Register (C5h)

of the Winbond W25Q256FV data sheet (256M-BIT SPI flash)

   The Extended Address Register is only effective when the device is
   in the 3-Byte Address Mode.  When the device operates in the 4-Byte
   Address Mode (ADS=3D1), any command with address input of A31-A24
   will replace the Extended Address Register values. It is
   recommended to check and update the Extended Address Register if
   necessary when the device is switched from 4-Byte to 3-Byte Address
   Mode.

So the documentation suggests clearing the EAR after switching to
3-byte mode.  Experimentation shows that the EAR is *always* one after
the switch to 3-byte mode, so clearing the EAR is mandatory at
shutdown for a subsequent 3-byte-addressed reboot to work.

Note that some SOCs (e.g. MT7621) do not assert a reset line at normal
reboot, so we cannot rely on hardware reset.  The MT7621 does assert a
reset line at watchdog-reset.

Acked-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
=2D--

Changes since v3:
 Removed Fixes/stable tags. Added Acked-by from Marek.
Changes sinc3 v2:
  Fixed comment style.


 drivers/mtd/spi-nor/spi-nor.c | 14 ++++++++++++++
 include/linux/mtd/spi-nor.h   |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 5bfa36e95f35..42ae9a1529bb 100644
=2D-- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -284,6 +284,20 @@ static inline int set_4byte(struct spi_nor *nor, const=
 struct flash_info *info,
 		if (need_wren)
 			write_disable(nor);
=20
+		if (!status && !enable &&
+		    JEDEC_MFR(info) =3D=3D SNOR_MFR_WINBOND) {
+			/*
+			 * On Winbond W25Q256FV, leaving 4byte mode causes
+			 * the Extended Address Register to be set to 1, so all
+			 * 3-byte-address reads come from the second 16M.
+			 * We must clear the register to enable normal behavior.
+			 */
+			write_enable(nor);
+			nor->cmd_buf[0] =3D 0;
+			nor->write_reg(nor, SPINOR_OP_WREAR, nor->cmd_buf, 1);
+			write_disable(nor);
+		}
+
 		return status;
 	default:
 		/* Spansion style */
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index de36969eb359..e60da0d34cc1 100644
=2D-- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -62,6 +62,8 @@
 #define SPINOR_OP_RDCR		0x35	/* Read configuration register */
 #define SPINOR_OP_RDFSR		0x70	/* Read flag status register */
 #define SPINOR_OP_CLFSR		0x50	/* Clear flag status register */
+#define SPINOR_OP_RDEAR		0xc8	/* Read Extended Address Register */
+#define SPINOR_OP_WREAR		0xc5	/* Write Extended Address Register */
=20
 /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
 #define SPINOR_OP_READ_4B	0x13	/* Read data bytes (low frequency) */
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrab7AACgkQOeye3VZi
gblb3Q//TfYXzEnxPuFGZ00QVYAXV2mn98CHGUYcJOpAs7MezhrCYT6ze+VJBuOC
V+uy3bu/vXbo4D4PRBXjSnfhuPPbCZ7KWGhCVyGVm1lp3jV2iiXAzWaWyT645NUN
n1t2uAm3RlHeb0D/iyTH8chnGFhgr+7lP6yTk5jlk8m0wHLkPlNsI+AzSppyvXTI
DeUYs0GEqlnf95007KwgJxxf8KgFRO/l9Pe2Z6HHIOCUD66ufSWygWspaIBBGpI8
kpk5LX20a/8kATbZBr1NB0gYtnQVReNHTFYxC+5pJxIwAQ5smCN2yBQPmyutddOY
k5ski0VEhIQEOQYom1IuFir6lo0506gzWyekOFrb7DnAN0aSqz7sgIQO+veY1GEB
xYyrfLZH4Zni2DYZx6nrXrEH5sTxrR9aHK3fbiy2EavYErz6UXUVeBiVXI9h2uhP
+iH5Ci3EjpEv3W4P+117nn0F+d/sKDFpPqV1iJ59otOUYPeHn6v48XNsL4YOufB0
iNhTtL7YVBaLdn+FzVhvampJ64s9IEEyefC0Hkacjl0A+0lnZ2QVYTc6S2hxvzz+
t7s89vHkbhiWgPiv8Pr76x+38HxbZbFlUvREdsdQg7rNzA7D44GPLlarMVUsZ+jg
I+wb6O7mLN8p9PMtX/iwmKcE0kVMm15yMd/zQMhSCpV7HWAdq/4=
=k5K+
-----END PGP SIGNATURE-----
--=-=-=--
