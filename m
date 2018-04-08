Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751615AbeDHHE7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 03:04:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:39906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750810AbeDHHE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 03:04:58 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "Cc"
From: NeilBrown <neil@brown.name>
To: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Marek Vasut <marek.vasut@gmail.com>
Date: Sun, 08 Apr 2018 17:04:44 +1000
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: clear Extended Address Reg on switch to 3-byte addressing.
Message-ID: <874lkmw54j.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


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

This patch adds code to implement that recommendation.  Without this,
my GNUBEE-PC1 will not successfully reboot, as the Extended Address
Register is left with a value of '1'. When the SOC attempts to read
(in 3-byte address mode) the boot loader, it reads from the wrong
location.

Signed-off-by: NeilBrown <neil@brown.name>
=2D--
 drivers/mtd/spi-nor/spi-nor.c | 10 ++++++++++
 include/linux/mtd/spi-nor.h   |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d445a4d3b770..c303bf0d2982 100644
=2D-- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -269,6 +269,7 @@ static inline int set_4byte(struct spi_nor *nor, const =
struct flash_info *info,
 	int status;
 	bool need_wren =3D false;
 	u8 cmd;
+	u8 val;
=20
 	switch (JEDEC_MFR(info)) {
 	case SNOR_MFR_MICRON:
@@ -283,6 +284,15 @@ static inline int set_4byte(struct spi_nor *nor, const=
 struct flash_info *info,
 		status =3D nor->write_reg(nor, cmd, NULL, 0);
 		if (need_wren)
 			write_disable(nor);
+		if (!status && !enable &&
+		    nor->read_reg(nor, SPINOR_OP_RDXA, &val, 1) =3D=3D 0 &&
+		    val !=3D 0) {
+			/* need to reset the Extended Address Register */
+			write_enable(nor);
+			val =3D 0;
+			nor->write_reg(nor, SPINOR_OP_WRXA, &val, 1);
+			write_disable(nor);
+		}
=20
 		return status;
 	default:
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index de36969eb359..42954419cfdf 100644
=2D-- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -62,6 +62,8 @@
 #define SPINOR_OP_RDCR		0x35	/* Read configuration register */
 #define SPINOR_OP_RDFSR		0x70	/* Read flag status register */
 #define SPINOR_OP_CLFSR		0x50	/* Clear flag status register */
+#define SPINOR_OP_RDXA		0xc8	/* Read Extended Address Register */
+#define SPINOR_OP_WRXA		0xc5	/* Write Extended Address Register */
=20
 /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
 #define SPINOR_OP_READ_4B	0x13	/* Read data bytes (low frequency) */
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrJvwwACgkQOeye3VZi
gbkV3A/+NvOnM5VU3pW4nS9rZnQ4zrCRmGF5IqmTm95eLLRRbhMlUXymQxToVFjW
wFdPvnogqaFvUnBBE/YuzLvWwuwLk4YCSt3du0fxWXAN60jCRRm2PM4ATxrYjaDK
qFu4exU2aWf/BFnuNgH3ydH9uhU69b9oEc1RQ+MqRam1SLDucg1grGFsbFRVR3bV
L77Q0TsxCwGqLBS7Znc+A+kUJ1M1Pq2Uw55JZhB/3178d+K0A951LjUXBLG95jjh
hURozyDaJpqeWVaIHbMn2lANt2WXDC9b/fj02/8gScACcYrEfuHbGtYJAMDktX4I
eO8QTPqQ1aKPlYWrUpm+etHFjoHu1n6yUSd6OP9Abg+L3B0PQrMWX3mX/AAbn/AV
Gh1Mk4V3DDERZz1Yibnb9drRxK5R3X2Y3Rxbm+5Yn+5QlYeHFeg7ZOkW9iZuVA+n
K7Ke7xCmeLBE6wJHO0PNHYTEJT+LNbU6XIfQoPnEiU7W1rvjdxkWXOo6ggKi3rSn
N+64yqOrqj+ZqR1ndSe9GsCewxcUIcE80VvyDerxNlGepDVrQvaybANC4zFRt5hB
ZVygUBI9LMdA3kKw8egve0B0ylAY0ViWIVVmA7462KlAjVZ4q8BY6KpjWlnsf3nb
RCt0R4tQa5Mje2rf5kanzsYQdFSLIP61DiC6EYkynloKOPnWsBs=
=S+TY
-----END PGP SIGNATURE-----
--=-=-=--
