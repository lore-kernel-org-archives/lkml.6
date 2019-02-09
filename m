Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41D6C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5C72070B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="HPneg/Zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfBITXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 14:23:55 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:42336 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbfBITXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 14:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549740231; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=u/LMN/xwn+eauOm/oXsBtN+sOYxtes0sf3ro+KZy+ks=;
        b=HPneg/Zp+/dU9i439xYrNHF6iS1cnzMd5hrWXJFKDPOQqrRyKcQ0HDjNrQLx2YiHywG9Sq
        0i0EPHI1YVdUZqJ6ZoHvFLXthqJ1bl+OiCSBIaYMrYIN7lUekpWPvlbTw9De/cFt+iyUp3
        YsY8MOJuijMI6RckKHE9Flg4l0EdznY=
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
Subject: [PATCH v4 7/9] mtd: rawnand: ingenic: Add support for the JZ4740
Date:   Sat,  9 Feb 2019 16:23:03 -0300
Message-Id: <20190209192305.4434-7-paul@crapouillou.net>
In-Reply-To: <20190209192305.4434-1-paul@crapouillou.net>
References: <20190209192305.4434-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing the ingenic-nand driver on the JZ4740 SoC from
Ingenic, and the jz4740-ecc driver to support the JZ4740-specific
ECC hardware.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: New patch

v3: Also add support for the hardware ECC of the JZ4740 in this patch

v4: - Fix formatting issues
    - Add MODULE_* macros

 drivers/mtd/nand/raw/ingenic/Kconfig        |  10 ++
 drivers/mtd/nand/raw/ingenic/Makefile       |   1 +
 drivers/mtd/nand/raw/ingenic/ingenic_nand.c |  48 +++++--
 drivers/mtd/nand/raw/ingenic/jz4740_ecc.c   | 196 ++++++++++++++++++++++++++++
 4 files changed, 244 insertions(+), 11 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/ingenic/jz4740_ecc.c

diff --git a/drivers/mtd/nand/raw/ingenic/Kconfig b/drivers/mtd/nand/raw/ingenic/Kconfig
index 4bf7d7af3b0a..cc663cc15119 100644
--- a/drivers/mtd/nand/raw/ingenic/Kconfig
+++ b/drivers/mtd/nand/raw/ingenic/Kconfig
@@ -17,6 +17,16 @@ if MTD_NAND_JZ4780
 config MTD_NAND_INGENIC_ECC
 	tristate
 
+config MTD_NAND_JZ4740_ECC
+	tristate "Hardware BCH support for JZ4740 SoC"
+	select MTD_NAND_INGENIC_ECC
+	help
+	  Enable this driver to support the Reed-Solomon error-correction
+	  hardware present on the JZ4740 SoC from Ingenic.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called jz4740-ecc.
+
 config MTD_NAND_JZ4780_BCH
 	tristate "Hardware BCH support for JZ4780 SoC"
 	select MTD_NAND_INGENIC_ECC
diff --git a/drivers/mtd/nand/raw/ingenic/Makefile b/drivers/mtd/nand/raw/ingenic/Makefile
index f3c3c0f230b0..563b7effcf59 100644
--- a/drivers/mtd/nand/raw/ingenic/Makefile
+++ b/drivers/mtd/nand/raw/ingenic/Makefile
@@ -2,4 +2,5 @@ obj-$(CONFIG_MTD_NAND_JZ4740) += jz4740_nand.o
 obj-$(CONFIG_MTD_NAND_JZ4780) += ingenic_nand.o
 
 obj-$(CONFIG_MTD_NAND_INGENIC_ECC) += ingenic_ecc.o
+obj-$(CONFIG_MTD_NAND_JZ4740_ECC) += jz4740_ecc.o
 obj-$(CONFIG_MTD_NAND_JZ4780_BCH) += jz4780_bch.o
diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
index 0f51fd15fe79..036938fdad51 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -26,13 +27,15 @@
 
 #define DRV_NAME	"ingenic-nand"
 
-#define OFFSET_DATA	0x00000000
-#define OFFSET_CMD	0x00400000
-#define OFFSET_ADDR	0x00800000
-
 /* Command delay when there is no R/B pin. */
 #define RB_DELAY_US	100
 
+struct jz_soc_info {
+	unsigned long data_offset;
+	unsigned long addr_offset;
+	unsigned long cmd_offset;
+};
+
 struct ingenic_nand_cs {
 	unsigned int bank;
 	void __iomem *base;
@@ -41,6 +44,7 @@ struct ingenic_nand_cs {
 struct ingenic_nfc {
 	struct device *dev;
 	struct ingenic_ecc *ecc;
+	const struct jz_soc_info *soc_info;
 	struct nand_controller controller;
 	unsigned int num_banks;
 	struct list_head chips;
@@ -100,9 +104,9 @@ static void ingenic_nand_cmd_ctrl(struct nand_chip *chip, int cmd,
 		return;
 
 	if (ctrl & NAND_ALE)
-		writeb(cmd, cs->base + OFFSET_ADDR);
+		writeb(cmd, cs->base + nfc->soc_info->addr_offset);
 	else if (ctrl & NAND_CLE)
-		writeb(cmd, cs->base + OFFSET_CMD);
+		writeb(cmd, cs->base + nfc->soc_info->cmd_offset);
 }
 
 static int ingenic_nand_dev_ready(struct nand_chip *chip)
@@ -160,8 +164,13 @@ static int ingenic_nand_attach_chip(struct nand_chip *chip)
 	struct ingenic_nfc *nfc = to_ingenic_nfc(chip->controller);
 	int eccbytes;
 
-	chip->ecc.bytes = fls((1 + 8) * chip->ecc.size)	*
-				(chip->ecc.strength / 8);
+	if (chip->ecc.strength == 4) {
+		/* JZ4740 uses 9 bytes of ECC to correct maximum 4 errors */
+		chip->ecc.bytes = 9;
+	} else {
+		chip->ecc.bytes = fls((1 + 8) * chip->ecc.size)	*
+				  (chip->ecc.strength / 8);
+	}
 
 	switch (chip->ecc.mode) {
 	case NAND_ECC_HW:
@@ -270,8 +279,8 @@ static int ingenic_nand_init_chip(struct platform_device *pdev,
 		return -ENOMEM;
 	mtd->dev.parent = dev;
 
-	chip->legacy.IO_ADDR_R = cs->base + OFFSET_DATA;
-	chip->legacy.IO_ADDR_W = cs->base + OFFSET_DATA;
+	chip->legacy.IO_ADDR_R = cs->base + nfc->soc_info->data_offset;
+	chip->legacy.IO_ADDR_W = cs->base + nfc->soc_info->data_offset;
 	chip->legacy.chip_delay = RB_DELAY_US;
 	chip->options = NAND_NO_SUBPAGE_WRITE;
 	chip->legacy.select_chip = ingenic_nand_select_chip;
@@ -353,6 +362,10 @@ static int ingenic_nand_probe(struct platform_device *pdev)
 	if (!nfc)
 		return -ENOMEM;
 
+	nfc->soc_info = device_get_match_data(dev);
+	if (!nfc->soc_info)
+		return -EINVAL;
+
 	/*
 	 * Check for ECC HW before we call nand_scan_ident, to prevent us from
 	 * having to call it again if the ECC driver returns -EPROBE_DEFER.
@@ -390,8 +403,21 @@ static int ingenic_nand_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct jz_soc_info jz4740_soc_info = {
+	.data_offset = 0x00000000,
+	.cmd_offset = 0x00008000,
+	.addr_offset = 0x00010000,
+};
+
+static const struct jz_soc_info jz4780_soc_info = {
+	.data_offset = 0x00000000,
+	.cmd_offset = 0x00400000,
+	.addr_offset = 0x00800000,
+};
+
 static const struct of_device_id ingenic_nand_dt_match[] = {
-	{ .compatible = "ingenic,jz4780-nand" },
+	{ .compatible = "ingenic,jz4740-nand", .data = &jz4740_soc_info },
+	{ .compatible = "ingenic,jz4780-nand", .data = &jz4780_soc_info },
 	{},
 };
 MODULE_DEVICE_TABLE(of, ingenic_nand_dt_match);
diff --git a/drivers/mtd/nand/raw/ingenic/jz4740_ecc.c b/drivers/mtd/nand/raw/ingenic/jz4740_ecc.c
new file mode 100644
index 000000000000..83b42881720e
--- /dev/null
+++ b/drivers/mtd/nand/raw/ingenic/jz4740_ecc.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * JZ4740 ECC controller driver
+ *
+ * Copyright (c) 2019 Paul Cercueil <paul@crapouillou.net>
+ *
+ * based on jz4740-nand.c
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include "ingenic_ecc.h"
+
+#define JZ_REG_NAND_ECC_CTRL	0x00
+#define JZ_REG_NAND_DATA	0x04
+#define JZ_REG_NAND_PAR0	0x08
+#define JZ_REG_NAND_PAR1	0x0C
+#define JZ_REG_NAND_PAR2	0x10
+#define JZ_REG_NAND_IRQ_STAT	0x14
+#define JZ_REG_NAND_IRQ_CTRL	0x18
+#define JZ_REG_NAND_ERR(x)	(0x1C + ((x) << 2))
+
+#define JZ_NAND_ECC_CTRL_PAR_READY	BIT(4)
+#define JZ_NAND_ECC_CTRL_ENCODING	BIT(3)
+#define JZ_NAND_ECC_CTRL_RS		BIT(2)
+#define JZ_NAND_ECC_CTRL_RESET		BIT(1)
+#define JZ_NAND_ECC_CTRL_ENABLE		BIT(0)
+
+#define JZ_NAND_STATUS_ERR_COUNT	(BIT(31) | BIT(30) | BIT(29))
+#define JZ_NAND_STATUS_PAD_FINISH	BIT(4)
+#define JZ_NAND_STATUS_DEC_FINISH	BIT(3)
+#define JZ_NAND_STATUS_ENC_FINISH	BIT(2)
+#define JZ_NAND_STATUS_UNCOR_ERROR	BIT(1)
+#define JZ_NAND_STATUS_ERROR		BIT(0)
+
+static const uint8_t empty_block_ecc[] = {
+	0xcd, 0x9d, 0x90, 0x58, 0xf4, 0x8b, 0xff, 0xb7, 0x6f
+};
+
+static void jz4740_ecc_init(struct ingenic_ecc *ecc, bool encode)
+{
+	uint32_t reg;
+
+	/* Clear interrupt status */
+	writel(0, ecc->base + JZ_REG_NAND_IRQ_STAT);
+
+	/* Initialize and enable ECC hardware */
+	reg = readl(ecc->base + JZ_REG_NAND_ECC_CTRL);
+	reg |= JZ_NAND_ECC_CTRL_RESET;
+	reg |= JZ_NAND_ECC_CTRL_ENABLE;
+	reg |= JZ_NAND_ECC_CTRL_RS;
+	if (encode)
+		reg |= JZ_NAND_ECC_CTRL_ENCODING;
+	else
+		reg &= ~JZ_NAND_ECC_CTRL_ENCODING;
+
+	writel(reg, ecc->base + JZ_REG_NAND_ECC_CTRL);
+}
+
+static int jz4740_ecc_calculate(struct ingenic_ecc *ecc,
+				struct ingenic_ecc_params *params,
+				const u8 *buf, u8 *ecc_code)
+{
+	uint32_t reg, status;
+	unsigned int timeout = 1000;
+	int i;
+
+	jz4740_ecc_init(ecc, true);
+
+	do {
+		status = readl(ecc->base + JZ_REG_NAND_IRQ_STAT);
+	} while (!(status & JZ_NAND_STATUS_ENC_FINISH) && --timeout);
+
+	if (timeout == 0)
+		return -ETIMEDOUT;
+
+	reg = readl(ecc->base + JZ_REG_NAND_ECC_CTRL);
+	reg &= ~JZ_NAND_ECC_CTRL_ENABLE;
+	writel(reg, ecc->base + JZ_REG_NAND_ECC_CTRL);
+
+	for (i = 0; i < params->bytes; ++i)
+		ecc_code[i] = readb(ecc->base + JZ_REG_NAND_PAR0 + i);
+
+	/* If the written data is completely 0xff, we also want to write 0xff as
+	 * ecc, otherwise we will get in trouble when doing subpage writes.
+	 */
+	if (memcmp(ecc_code, empty_block_ecc, ARRAY_SIZE(empty_block_ecc)) == 0)
+		memset(ecc_code, 0xff, ARRAY_SIZE(empty_block_ecc));
+
+	return 0;
+}
+
+static void jz_nand_correct_data(uint8_t *buf, int index, int mask)
+{
+	int offset = index & 0x7;
+	uint16_t data;
+
+	index += (index >> 3);
+
+	data = buf[index];
+	data |= buf[index + 1] << 8;
+
+	mask ^= (data >> offset) & 0x1ff;
+	data &= ~(0x1ff << offset);
+	data |= (mask << offset);
+
+	buf[index] = data & 0xff;
+	buf[index + 1] = (data >> 8) & 0xff;
+}
+
+static int jz4740_ecc_correct(struct ingenic_ecc *ecc,
+			      struct ingenic_ecc_params *params,
+			      u8 *buf, u8 *ecc_code)
+{
+	int i, error_count, index;
+	uint32_t reg, status, error;
+	unsigned int timeout = 1000;
+
+	jz4740_ecc_init(ecc, false);
+
+	for (i = 0; i < params->bytes; ++i)
+		writeb(ecc_code[i], ecc->base + JZ_REG_NAND_PAR0 + i);
+
+	reg = readl(ecc->base + JZ_REG_NAND_ECC_CTRL);
+	reg |= JZ_NAND_ECC_CTRL_PAR_READY;
+	writel(reg, ecc->base + JZ_REG_NAND_ECC_CTRL);
+
+	do {
+		status = readl(ecc->base + JZ_REG_NAND_IRQ_STAT);
+	} while (!(status & JZ_NAND_STATUS_DEC_FINISH) && --timeout);
+
+	if (timeout == 0)
+		return -ETIMEDOUT;
+
+	reg = readl(ecc->base + JZ_REG_NAND_ECC_CTRL);
+	reg &= ~JZ_NAND_ECC_CTRL_ENABLE;
+	writel(reg, ecc->base + JZ_REG_NAND_ECC_CTRL);
+
+	if (status & JZ_NAND_STATUS_ERROR) {
+		if (status & JZ_NAND_STATUS_UNCOR_ERROR)
+			return -EBADMSG;
+
+		error_count = (status & JZ_NAND_STATUS_ERR_COUNT) >> 29;
+
+		for (i = 0; i < error_count; ++i) {
+			error = readl(ecc->base + JZ_REG_NAND_ERR(i));
+			index = ((error >> 16) & 0x1ff) - 1;
+			if (index >= 0 && index < params->size)
+				jz_nand_correct_data(buf, index, error & 0x1ff);
+		}
+
+		return error_count;
+	}
+
+	return 0;
+}
+
+static void jz4740_ecc_disable(struct ingenic_ecc *ecc)
+{
+	u32 reg;
+
+	writel(0, ecc->base + JZ_REG_NAND_IRQ_STAT);
+	reg = readl(ecc->base + JZ_REG_NAND_ECC_CTRL);
+	reg &= ~JZ_NAND_ECC_CTRL_ENABLE;
+	writel(reg, ecc->base + JZ_REG_NAND_ECC_CTRL);
+}
+
+static const struct ingenic_ecc_ops jz4740_ecc_ops = {
+	.disable = jz4740_ecc_disable,
+	.calculate = jz4740_ecc_calculate,
+	.correct = jz4740_ecc_correct,
+};
+
+static const struct of_device_id jz4740_ecc_dt_match[] = {
+	{ .compatible = "ingenic,jz4740-ecc", .data = &jz4740_ecc_ops },
+	{},
+};
+MODULE_DEVICE_TABLE(of, jz4740_ecc_dt_match);
+
+static struct platform_driver jz4740_ecc_driver = {
+	.probe		= ingenic_ecc_probe,
+	.driver	= {
+		.name	= "jz4740-ecc",
+		.of_match_table = jz4740_ecc_dt_match,
+	},
+};
+module_platform_driver(jz4740_ecc_driver);
+
+MODULE_AUTHOR("Paul Cercueil <paul@crapouillou.net>");
+MODULE_DESCRIPTION("Ingenic JZ4740 ECC controller driver");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

