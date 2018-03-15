Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932354AbeCOCrc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 22:47:32 -0400
Received: from ozlabs.org ([103.22.144.67]:41011 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751700AbeCOCr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 22:47:28 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 15 Mar 2018 13:46:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jesper Nilsson <jesper@jni.nu>
Subject: linux-next: manual merge of the nand tree with the asm-generic tree
Message-ID: <20180315134657.05fbcbb6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WxOyjJmb+5OHHRY_bxf+RpN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WxOyjJmb+5OHHRY_bxf+RpN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Boris,

Today's linux-next merge of the nand tree got a conflict in:

  drivers/mtd/nand/Kconfig
  (mostly moved to drivers/mtd/nand/raw/Kconfig)
  drivers/mtd/nand/Makefile
  (mostly moved to drivers/mtd/nand/raw/Makefile)
  drivers/mtd/nand/bf5xx_nand.c
  (renamed to drivers/mtd/nand/raw/bf5xx_nand.c)
  arch/cris/arch-v32/drivers/mach-a3/nandflash.c
  arch/cris/arch-v32/drivers/mach-fs/nandflash.c

between commits:

  2180873c59e1 ("mtd: nand: remove bf5xx_nand driver")
  77b0b77f7812 ("CRIS: Drop support for the CRIS port")

from the asm-generic tree and commits:

  93db446a424c ("mtd: nand: move raw NAND related code to the raw/ subdir")
  187c54488ead ("mtd: nand: State when references to other drivers are no l=
onger valid")

from the nand tree.

I fixed it up:

    I removed:
	drivers/mtd/nand/raw/bf5xx_nand.c
	arch/cris/arch-v32/drivers/mach-a3/nandflash.c
	arch/cris/arch-v32/drivers/mach-fs/nandflash.c
    added the following merge fix patch

and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 15 Mar 2018 13:43:02 +1100
Subject: [PATCH] mtd: nand: fix up for blackfin removal

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/mtd/nand/raw/Kconfig  | 32 --------------------------------
 drivers/mtd/nand/raw/Makefile |  1 -
 2 files changed, 33 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 605ec8cce67b..0f2b6f348a0a 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -116,38 +116,6 @@ config MTD_NAND_AU1550
 	  This enables the driver for the NAND flash controller on the
 	  AMD/Alchemy 1550 SOC.
=20
-config MTD_NAND_BF5XX
-	tristate "Blackfin on-chip NAND Flash Controller driver"
-	depends on BF54x || BF52x
-	help
-	  This enables the Blackfin on-chip NAND flash controller
-
-	  No board specific support is done by this driver, each board
-	  must advertise a platform_device for the driver to attach.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called bf5xx-nand.
-
-config MTD_NAND_BF5XX_HWECC
-	bool "BF5XX NAND Hardware ECC"
-	default y
-	depends on MTD_NAND_BF5XX
-	help
-	  Enable the use of the BF5XX's internal ECC generator when
-	  using NAND.
-
-config MTD_NAND_BF5XX_BOOTROM_ECC
-	bool "Use Blackfin BootROM ECC Layout"
-	default n
-	depends on MTD_NAND_BF5XX_HWECC
-	help
-	  If you wish to modify NAND pages and allow the Blackfin on-chip
-	  BootROM to boot from them, say Y here.  This is only necessary
-	  if you are booting U-Boot out of NAND and you wish to update
-	  U-Boot from Linux' userspace.  Otherwise, you should say N here.
-
-	  If unsure, say N.
-
 config MTD_NAND_S3C2410
 	tristate "NAND Flash support for Samsung S3C SoCs"
 	depends on ARCH_S3C24XX || ARCH_S3C64XX
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index f16f59a197a3..165b7ef9e9a1 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_MTD_NAND_DENALI)		+=3D denali.o
 obj-$(CONFIG_MTD_NAND_DENALI_PCI)	+=3D denali_pci.o
 obj-$(CONFIG_MTD_NAND_DENALI_DT)	+=3D denali_dt.o
 obj-$(CONFIG_MTD_NAND_AU1550)		+=3D au1550nd.o
-obj-$(CONFIG_MTD_NAND_BF5XX)		+=3D bf5xx_nand.o
 obj-$(CONFIG_MTD_NAND_S3C2410)		+=3D s3c2410.o
 obj-$(CONFIG_MTD_NAND_TANGO)		+=3D tango_nand.o
 obj-$(CONFIG_MTD_NAND_DAVINCI)		+=3D davinci_nand.o
--=20
2.16.1

--=20
Cheers,
Stephen Rothwell

--Sig_/WxOyjJmb+5OHHRY_bxf+RpN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqp3qEACgkQAVBC80lX
0GyKuAf/cZTcNDIT0EufU08KO8QSEOG1KjPQItJWHv+49YDUoflTvQINEoGacgqU
bBQyup3qgiXgfKT+GF3vg5j0TDvDpSvL+48JNbvwogHq54kHyLlrAPB3lAun8DZC
70xkfkEipJk0Lm6qMQ6/yx/fHGCog/MVrbUS8P6JZMJqGHUQf8sOjj74uOJ3CuAJ
oT+P3IqRoS0qG6c63ZUuWL0mtx+zFFqugiWos+wdz9xiJn1HZWcvkjE/7r4aDKyB
SnwpGWNEysHoBGwPFdV7jXdehHug3YRZUMZ9vNhniH8E5FZhMK61RAtKGzzAKP2l
+NJqUKwywEBVX6CNT7I+zobHEnGvlA==
=HpFs
-----END PGP SIGNATURE-----

--Sig_/WxOyjJmb+5OHHRY_bxf+RpN--
