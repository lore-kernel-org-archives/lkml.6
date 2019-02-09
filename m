Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5C6C282CC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A4D21916
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="HivDEbU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfBITXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 14:23:34 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:42208 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbfBITXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 14:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549740211; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IBnrvLm/CuhDgm6WMEETEN6lnr413251EOLYRQaxvzc=;
        b=HivDEbU8G6/n22Y7JMbATV+lhtJ/qxSOPuRz7xgUjmJufOowkNzVWgZ2mHQ2o3GED0iajC
        j4bJuoCHFoS9VylWQI2sYtTgJ06CfB5LRip7OaOZH7SJaJEFxtiGx6jpTWuvwlTIg3oC53
        Jex/UCZuSY/yVc8ZTLGRfPwITDpcDgM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 3/9] mtd: rawnand: Move drivers for Ingenic SoCs to subfolder
Date:   Sat,  9 Feb 2019 16:22:59 -0300
Message-Id: <20190209192305.4434-3-paul@crapouillou.net>
In-Reply-To: <20190209192305.4434-1-paul@crapouillou.net>
References: <20190209192305.4434-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before adding support for more SoCs and seeing the number of files for
these drivers grow, we move them to their own subfolder to keep it tidy.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: New patch

v3: No change

v4: No change

 drivers/mtd/nand/raw/Kconfig                     | 14 +-------------
 drivers/mtd/nand/raw/Makefile                    |  3 +--
 drivers/mtd/nand/raw/ingenic/Kconfig             | 13 +++++++++++++
 drivers/mtd/nand/raw/ingenic/Makefile            |  2 ++
 drivers/mtd/nand/raw/{ => ingenic}/jz4740_nand.c |  0
 drivers/mtd/nand/raw/{ => ingenic}/jz4780_bch.c  |  0
 drivers/mtd/nand/raw/{ => ingenic}/jz4780_bch.h  |  0
 drivers/mtd/nand/raw/{ => ingenic}/jz4780_nand.c |  0
 8 files changed, 17 insertions(+), 15 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/ingenic/Kconfig
 create mode 100644 drivers/mtd/nand/raw/ingenic/Makefile
 rename drivers/mtd/nand/raw/{ => ingenic}/jz4740_nand.c (100%)
 rename drivers/mtd/nand/raw/{ => ingenic}/jz4780_bch.c (100%)
 rename drivers/mtd/nand/raw/{ => ingenic}/jz4780_bch.h (100%)
 rename drivers/mtd/nand/raw/{ => ingenic}/jz4780_nand.c (100%)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 1a55d3e3d4c5..d886be2fc174 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -470,19 +470,7 @@ config MTD_NAND_NUC900
 	  This enables the driver for the NAND Flash on evaluation board based
 	  on w90p910 / NUC9xx.
 
-config MTD_NAND_JZ4740
-	tristate "Support for JZ4740 SoC NAND controller"
-	depends on MACH_JZ4740 || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  Enables support for NAND Flash on JZ4740 SoC based boards.
-
-config MTD_NAND_JZ4780
-	tristate "Support for NAND on JZ4780 SoC"
-	depends on JZ4780_NEMC
-	help
-	  Enables support for NAND Flash connected to the NEMC on JZ4780 SoC
-	  based boards, using the BCH controller for hardware error correction.
+source "drivers/mtd/nand/raw/ingenic/Kconfig"
 
 config MTD_NAND_FSMC
 	tristate "Support for NAND on ST Micros FSMC"
diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 57159b349054..f419d373d090 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -45,8 +45,7 @@ obj-$(CONFIG_MTD_NAND_NUC900)		+= nuc900_nand.o
 obj-$(CONFIG_MTD_NAND_MPC5121_NFC)	+= mpc5121_nfc.o
 obj-$(CONFIG_MTD_NAND_VF610_NFC)	+= vf610_nfc.o
 obj-$(CONFIG_MTD_NAND_RICOH)		+= r852.o
-obj-$(CONFIG_MTD_NAND_JZ4740)		+= jz4740_nand.o
-obj-$(CONFIG_MTD_NAND_JZ4780)		+= jz4780_nand.o jz4780_bch.o
+obj-y					+= ingenic/
 obj-$(CONFIG_MTD_NAND_GPMI_NAND)	+= gpmi-nand/
 obj-$(CONFIG_MTD_NAND_XWAY)		+= xway_nand.o
 obj-$(CONFIG_MTD_NAND_BCM47XXNFLASH)	+= bcm47xxnflash/
diff --git a/drivers/mtd/nand/raw/ingenic/Kconfig b/drivers/mtd/nand/raw/ingenic/Kconfig
new file mode 100644
index 000000000000..67806c87b2c4
--- /dev/null
+++ b/drivers/mtd/nand/raw/ingenic/Kconfig
@@ -0,0 +1,13 @@
+config MTD_NAND_JZ4740
+	tristate "Support for JZ4740 SoC NAND controller"
+	depends on MACH_JZ4740 || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Enables support for NAND Flash on JZ4740 SoC based boards.
+
+config MTD_NAND_JZ4780
+	tristate "Support for NAND on JZ4780 SoC"
+	depends on JZ4780_NEMC
+	help
+	  Enables support for NAND Flash connected to the NEMC on JZ4780 SoC
+	  based boards, using the BCH controller for hardware error correction.
diff --git a/drivers/mtd/nand/raw/ingenic/Makefile b/drivers/mtd/nand/raw/ingenic/Makefile
new file mode 100644
index 000000000000..44c2ca053d24
--- /dev/null
+++ b/drivers/mtd/nand/raw/ingenic/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_MTD_NAND_JZ4740) += jz4740_nand.o
+obj-$(CONFIG_MTD_NAND_JZ4780) += jz4780_nand.o jz4780_bch.o
diff --git a/drivers/mtd/nand/raw/jz4740_nand.c b/drivers/mtd/nand/raw/ingenic/jz4740_nand.c
similarity index 100%
rename from drivers/mtd/nand/raw/jz4740_nand.c
rename to drivers/mtd/nand/raw/ingenic/jz4740_nand.c
diff --git a/drivers/mtd/nand/raw/jz4780_bch.c b/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
similarity index 100%
rename from drivers/mtd/nand/raw/jz4780_bch.c
rename to drivers/mtd/nand/raw/ingenic/jz4780_bch.c
diff --git a/drivers/mtd/nand/raw/jz4780_bch.h b/drivers/mtd/nand/raw/ingenic/jz4780_bch.h
similarity index 100%
rename from drivers/mtd/nand/raw/jz4780_bch.h
rename to drivers/mtd/nand/raw/ingenic/jz4780_bch.h
diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/ingenic/jz4780_nand.c
similarity index 100%
rename from drivers/mtd/nand/raw/jz4780_nand.c
rename to drivers/mtd/nand/raw/ingenic/jz4780_nand.c
-- 
2.11.0

