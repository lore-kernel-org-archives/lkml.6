Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C403C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E3520873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfAPS4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:56:33 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:60512 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729085AbfAPS4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:56:32 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8108:4840:8f74:a08c:f56:b2dd:7ae0])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPA id 8BBFBB00583;
        Wed, 16 Jan 2019 19:56:13 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-kernel@vger.kernel.org
Cc:     Alban Bedel <albeu@free.fr>, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-mips@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: [PATCH 3/6] spi: ath79: Enable support for compile test
Date:   Wed, 16 Jan 2019 19:55:46 +0100
Message-Id: <20190116185549.23295-3-albeu@free.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190116185549.23295-1-albeu@free.fr>
References: <20190116185549.23295-1-albeu@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow building this driver in compile test we need to remove all
dependency on headers from arch/mips/include. To allow this we
explicitly define all the registers locally instead of using
ar71xx_regs.h and we move the platform data struct definition to
include/linux/platform_data/spi-ath79.h.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/ath79/dev-spi.h                         |  2 +-
 drivers/spi/Kconfig                               |  2 +-
 drivers/spi/spi-ath79.c                           | 15 ++++++++++++---
 .../linux/platform_data/spi-ath79.h               |  0
 4 files changed, 14 insertions(+), 5 deletions(-)
 rename arch/mips/include/asm/mach-ath79/ath79_spi_platform.h => include/linux/platform_data/spi-ath79.h (100%)

diff --git a/arch/mips/ath79/dev-spi.h b/arch/mips/ath79/dev-spi.h
index d732565ca736..6e15bc8651be 100644
--- a/arch/mips/ath79/dev-spi.h
+++ b/arch/mips/ath79/dev-spi.h
@@ -13,7 +13,7 @@
 #define _ATH79_DEV_SPI_H
 
 #include <linux/spi/spi.h>
-#include <asm/mach-ath79/ath79_spi_platform.h>
+#include <linux/platform_data/spi-ath79.h>
 
 void ath79_register_spi(struct ath79_spi_platform_data *pdata,
 			 struct spi_board_info const *info,
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 128892c7e21e..71d3d2d5e5d1 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -63,7 +63,7 @@ config SPI_ALTERA
 
 config SPI_ATH79
 	tristate "Atheros AR71XX/AR724X/AR913X SPI controller driver"
-	depends on ATH79
+	depends on ATH79 || COMPILE_TEST
 	select SPI_BITBANG
 	help
 	  This enables support for the SPI controller present on the
diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index edf695a359f4..09c4fb7fcf7a 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -23,15 +23,24 @@
 #include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-
-#include <asm/mach-ath79/ar71xx_regs.h>
-#include <asm/mach-ath79/ath79_spi_platform.h>
+#include <linux/platform_data/spi-ath79.h>
 
 #define DRV_NAME	"ath79-spi"
 
 #define ATH79_SPI_RRW_DELAY_FACTOR	12000
 #define MHZ				(1000 * 1000)
 
+#define AR71XX_SPI_REG_FS		0x00	/* Function Select */
+#define AR71XX_SPI_REG_CTRL		0x04	/* SPI Control */
+#define AR71XX_SPI_REG_IOC		0x08	/* SPI I/O Control */
+#define AR71XX_SPI_REG_RDS		0x0c	/* Read Data Shift */
+
+#define AR71XX_SPI_FS_GPIO		BIT(0)	/* Enable GPIO mode */
+
+#define AR71XX_SPI_IOC_DO		BIT(0)	/* Data Out pin */
+#define AR71XX_SPI_IOC_CLK		BIT(8)	/* CLK pin */
+#define AR71XX_SPI_IOC_CS(n)		BIT(16 + (n))
+
 struct ath79_spi {
 	struct spi_bitbang	bitbang;
 	u32			ioc_base;
diff --git a/arch/mips/include/asm/mach-ath79/ath79_spi_platform.h b/include/linux/platform_data/spi-ath79.h
similarity index 100%
rename from arch/mips/include/asm/mach-ath79/ath79_spi_platform.h
rename to include/linux/platform_data/spi-ath79.h
-- 
2.19.1

