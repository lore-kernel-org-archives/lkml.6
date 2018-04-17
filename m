Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752800AbeDQK36 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 06:29:58 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41198 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752709AbeDQK33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 06:29:29 -0400
X-Google-Smtp-Source: AIpwx496nWnV9YoXhj+XZbktriQWfg8Ni0FBp3DcsUXCzFIKCjLiUTKg8bRSNVFNFHBuckABLx2/6w==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 3/4] ARM: davinci: add aemif & nand support to da850-lcdk in legacy mode
Date: Tue, 17 Apr 2018 12:29:16 +0200
Message-Id: <20180417102917.7794-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417102917.7794-1-brgl@bgdev.pl>
References: <20180417102917.7794-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We now have support for aemif & nand from board files. As an example
add support for nand to da850-lcdk in legacy mode.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 132 ++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 6c997c59a3cd..9c3de56b54e4 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -16,6 +16,11 @@
 #include <linux/gpio.h>
 #include <linux/gpio/machine.h>
 #include <linux/platform_data/gpio-davinci.h>
+#include <linux/platform_data/ti-aemif.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/platform_data/mtd-davinci.h>
+#include <linux/platform_data/mtd-davinci-aemif.h>
 #include <linux/regulator/machine.h>
 
 #include <asm/mach-types.h>
@@ -162,6 +167,129 @@ static __init void omapl138_hawk_mmc_init(void)
 	gpiod_remove_lookup_table(&mmc_gpios_table);
 }
 
+static struct mtd_partition omapl138_hawk_nandflash_partition[] = {
+	{
+		.name		= "u-boot env",
+		.offset		= 0,
+		.size		= SZ_128K,
+		.mask_flags	= MTD_WRITEABLE,
+	 },
+	{
+		.name		= "u-boot",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= SZ_128K,
+		.mask_flags	= MTD_WRITEABLE,
+	},
+	{
+		.name		= "free space",
+		.offset		= MTDPART_OFS_APPEND,
+		.size		= MTDPART_SIZ_FULL,
+		.mask_flags	= 0,
+	},
+};
+
+static struct davinci_aemif_timing omapl138_hawk_nandflash_timing = {
+	.wsetup		= 24,
+	.wstrobe	= 21,
+	.whold		= 14,
+	.rsetup		= 19,
+	.rstrobe	= 50,
+	.rhold		= 0,
+	.ta		= 20,
+};
+
+static struct davinci_nand_pdata omapl138_hawk_nandflash_data = {
+	.parts		= omapl138_hawk_nandflash_partition,
+	.nr_parts	= ARRAY_SIZE(omapl138_hawk_nandflash_partition),
+	.ecc_mode	= NAND_ECC_HW,
+	.ecc_bits	= 4,
+	.bbt_options	= NAND_BBT_USE_FLASH,
+	.options	= NAND_BUSWIDTH_16,
+	.timing		= &omapl138_hawk_nandflash_timing,
+	.mask_chipsel	= 0,
+	.mask_ale	= 0,
+	.mask_cle	= 0,
+};
+
+static struct resource omapl138_hawk_nandflash_resource[] = {
+	{
+		.start	= DA8XX_AEMIF_CS3_BASE,
+		.end	= DA8XX_AEMIF_CS3_BASE + SZ_32M,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= DA8XX_AEMIF_CTL_BASE,
+		.end	= DA8XX_AEMIF_CTL_BASE + SZ_32K,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct resource omapl138_hawk_aemif_resource[] = {
+	{
+		.start	= DA8XX_AEMIF_CTL_BASE,
+		.end	= DA8XX_AEMIF_CTL_BASE + SZ_32K,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct aemif_abus_data omapl138_hawk_aemif_abus_data[] = {
+	{
+		.cs	= 3,
+	}
+};
+
+static struct platform_device omapl138_hawk_aemif_devices[] = {
+	{
+		.name		= "davinci_nand",
+		.id		= 1,
+		.dev		= {
+			.platform_data	= &omapl138_hawk_nandflash_data,
+		},
+		.resource	= omapl138_hawk_nandflash_resource,
+		.num_resources	= ARRAY_SIZE(omapl138_hawk_nandflash_resource),
+		.id		= 0,
+	}
+};
+
+static struct aemif_platform_data omapl138_hawk_aemif_pdata = {
+	.cs_offset = 2,
+	.abus_data = omapl138_hawk_aemif_abus_data,
+	.num_abus_data = ARRAY_SIZE(omapl138_hawk_aemif_abus_data),
+	.sub_devices = omapl138_hawk_aemif_devices,
+	.num_sub_devices = ARRAY_SIZE(omapl138_hawk_aemif_devices),
+};
+
+static struct platform_device omapl138_hawk_aemif_device = {
+	.name		= "ti-aemif",
+	.dev = {
+		.platform_data	= &omapl138_hawk_aemif_pdata,
+	},
+	.resource	= omapl138_hawk_aemif_resource,
+	.num_resources	= ARRAY_SIZE(omapl138_hawk_aemif_resource),
+	.id		= -1,
+};
+
+static const short omapl138_hawk_nand_pins[] = {
+	DA850_EMA_WAIT_1, DA850_NEMA_OE, DA850_NEMA_WE, DA850_NEMA_CS_3,
+	DA850_EMA_D_0, DA850_EMA_D_1, DA850_EMA_D_2, DA850_EMA_D_3,
+	DA850_EMA_D_4, DA850_EMA_D_5, DA850_EMA_D_6, DA850_EMA_D_7,
+	DA850_EMA_D_8, DA850_EMA_D_9, DA850_EMA_D_10, DA850_EMA_D_11,
+	DA850_EMA_D_12, DA850_EMA_D_13, DA850_EMA_D_14, DA850_EMA_D_15,
+	DA850_EMA_A_1, DA850_EMA_A_2,
+	-1
+};
+
+static int omapl138_hawk_register_aemif(void)
+{
+	int ret;
+
+	ret = davinci_cfg_reg_list(omapl138_hawk_nand_pins);
+	if (ret)
+		pr_warn("%s: NAND mux setup failed: %d\n", __func__, ret);
+
+	return platform_device_register(&omapl138_hawk_aemif_device);
+}
+
 static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id);
 static da8xx_ocic_handler_t hawk_usb_ocic_handler;
 
@@ -294,6 +422,10 @@ static __init void omapl138_hawk_init(void)
 
 	omapl138_hawk_usb_init();
 
+	ret = omapl138_hawk_register_aemif();
+	if (ret)
+		pr_warn("%s: aemif registration failed: %d\n", __func__, ret);
+
 	ret = da8xx_register_watchdog();
 	if (ret)
 		pr_warn("%s: watchdog registration failed: %d\n",
-- 
2.17.0
