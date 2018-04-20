Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeDTV0s (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 17:26:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:53305 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751478AbeDTV0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 17:26:47 -0400
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "To"
From: NeilBrown <neil@brown.name>
To: Boris Brezillon <boris.brezillon@bootlin.com>
To: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Marek Vasut <marek.vasut@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Brian Norris" <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Sat, 21 Apr 2018 07:26:34 +1000
Subject: [PATCH v3] mtd: spi-nor: clear Winbond Extended Address Reg on switch to 3-byte addressing.
In-Reply-To: <20180420215440.7b078f6c@bbrezillon>
References: <874lkmw54j.fsf@notabene.neil.brown.name> <87sh7wrq8p.fsf@notabene.neil.brown.name> <20180420215440.7b078f6c@bbrezillon>
Message-ID: <87h8o5po1h.fsf@notabene.neil.brown.name>
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

This problem is not a regression.  However the commit identified below
added support for resetting an spi-nor chip at shutdown, but didn't
achieve the goal for all spi-nor chips.  So this patch can be seen as
fixing that one.

Fixes: 59b356ffd0b0 ("mtd: m25p80: restore the status of SPI flash when exi=
ting")
Cc: stable@vger.kernel.org (v4.16)
Signed-off-by: NeilBrown <neil@brown.name>
=2D--
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

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlraWwoACgkQOeye3VZi
gbmWew/+PyOFPURJGUfsYjHdaVrSW/gwINL41xepcR1aswxpHM/VQ35iC0NddLQt
w28F3m5fyBkPAMh8LLJhpctXuS55OmUAd8t9HdRvn6JPx2+wZJFr9B1LHjM3vxMZ
JzWdm4NYAeYNa6sMG+tR/+VwL0p6X5Rxxf5DRzm0cCWG6TCQUEiILFB7reyLmjbB
74jKNFcG0ZRzxvCCvR88jj/PIKoVVLDBMZPkhvRkCDqmEPNSm+5k1VUuL3mR1CrX
spvcbTTrvfA0YKj1Iiv/tH1/CMkGLiosLcVKKvmMQ7NPiCZu/1bixBm+r/UEBg5C
Lkrb9+YsRI5eq9z/Ihi7co0Yoj6v4wiw04Mdwd+7aEfwEWQs+dMrnjlzOxef6fYc
EGsfPiIc4QyYwzrtZfcLI9xBu4uvD6PoACY6slMygoIXefDBDU6+ZfuAca70iw/x
VYnlTC5LR3/PEfda31i9wpWVJOQOFTzgCYCaFQ6wSvX9afkQ2Euy9BZk2Tfq5mNB
UxI84DBfuN5hjXUW4B9BnhN03PIfPaXSpbwwWeDjUEkcbtYNMt9eGDlcEbQXkFkd
M//sjPdWp9sGlGqRAx2iMECi7Sfc8bJtJeHQEgLzAWbeYZ2iGX2Pp43mSal8mm4n
15vNmkmMaI3g+9bl4CzDH9cGYAxRrmtlNl+1A8UWbCLMINVYMKM=
=FUbh
-----END PGP SIGNATURE-----
--=-=-=--
