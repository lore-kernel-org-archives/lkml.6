Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D01C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722B42082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="XpOqmtb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfBDTFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:05:23 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:48206 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbfBDTFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549307119; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wAiM7jnSpLBygzfIT3XGQyT9HqwO63Xp6JVtETB746A=;
        b=XpOqmtb0LhqGPd0yhjkreLsT0mge0uo8e5rytEZmOKtHWuYE8hCuop+UP4dnYNsWhZsU/p
        o/CdpHXFBoZC+Lmqc5rERv4j0/AwUhzo/TEN5XMTij57Ac4hJ21lGKeNGMUvUDkL72Ku50
        OgVEV78sFYK3+TkWGsCCE+RvqjrECBw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 8/9] mtd: rawnand: ingenic: Add support for the JZ4725B
Date:   Mon,  4 Feb 2019 16:04:25 -0300
Message-Id: <20190204190426.11618-8-paul@crapouillou.net>
In-Reply-To: <20190204190426.11618-1-paul@crapouillou.net>
References: <20190204190426.11618-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The boot ROM of the JZ4725B SoC expects a specific OOB layout on the
NAND, so we use it unconditionally in the ingenic-nand driver.

Also add the jz4725b-bch driver to support the JZ4725B-specific BCH
hardware.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: Instead of forcing the OOB layout, leave it to the board code or
    devicetree to decide if the jz4725b-specific layout should be used
    or not.

v3: - Revert the change in v2, as the previous behaviour was correct.
    - Also add support for the hardware BCH of the JZ4725B in this
      patch.

 drivers/mtd/nand/raw/ingenic/Kconfig        |  10 ++
 drivers/mtd/nand/raw/ingenic/Makefile       |   1 +
 drivers/mtd/nand/raw/ingenic/ingenic_nand.c |  48 +++++-
 drivers/mtd/nand/raw/ingenic/jz4725b_bch.c  | 251 ++++++++++++++++++++++++++++
 4 files changed, 309 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/raw/ingenic/jz4725b_bch.c

diff --git a/drivers/mtd/nand/raw/ingenic/Kconfig b/drivers/mtd/nand/raw/ingenic/Kconfig
index cc663cc15119..497b46b144f2 100644
--- a/drivers/mtd/nand/raw/ingenic/Kconfig
+++ b/drivers/mtd/nand/raw/ingenic/Kconfig
@@ -27,6 +27,16 @@ config MTD_NAND_JZ4740_ECC
 	  This driver can also be built as a module. If so, the module
 	  will be called jz4740-ecc.
 
+config MTD_NAND_JZ4725B_BCH
+	tristate "Hardware BCH support for JZ4725B SoC"
+	select MTD_NAND_INGENIC_ECC
+	help
+	  Enable this driver to support the BCH error-correction hardware
+	  present on the JZ4725B SoC from Ingenic.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called jz4725b-bch.
+
 config MTD_NAND_JZ4780_BCH
 	tristate "Hardware BCH support for JZ4780 SoC"
 	select MTD_NAND_INGENIC_ECC
diff --git a/drivers/mtd/nand/raw/ingenic/Makefile b/drivers/mtd/nand/raw/ingenic/Makefile
index 563b7effcf59..ab2c5f47e5b7 100644
--- a/drivers/mtd/nand/raw/ingenic/Makefile
+++ b/drivers/mtd/nand/raw/ingenic/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_MTD_NAND_JZ4780) += ingenic_nand.o
 
 obj-$(CONFIG_MTD_NAND_INGENIC_ECC) += ingenic_ecc.o
 obj-$(CONFIG_MTD_NAND_JZ4740_ECC) += jz4740_ecc.o
+obj-$(CONFIG_MTD_NAND_JZ4725B_BCH) += jz4725b_bch.o
 obj-$(CONFIG_MTD_NAND_JZ4780_BCH) += jz4780_bch.o
diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
index 3fd078920b17..0e6d79993ff3 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
@@ -34,6 +34,7 @@ struct jz_soc_info {
 	unsigned long data_offset;
 	unsigned long addr_offset;
 	unsigned long cmd_offset;
+	const struct mtd_ooblayout_ops *oob_layout;
 };
 
 struct ingenic_nand_cs {
@@ -71,6 +72,41 @@ static inline struct ingenic_nfc *to_ingenic_nfc(struct nand_controller *ctrl)
 	return container_of(ctrl, struct ingenic_nfc, controller);
 }
 
+static int jz4725b_ooblayout_ecc(struct mtd_info *mtd, int section,
+				 struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+
+	if (section || !ecc->total)
+		return -ERANGE;
+
+	oobregion->length = ecc->total;
+	oobregion->offset = 3;
+
+	return 0;
+}
+
+static int jz4725b_ooblayout_free(struct mtd_info *mtd, int section,
+				  struct mtd_oob_region *oobregion)
+{
+	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+
+	if (section)
+		return -ERANGE;
+
+	oobregion->length = mtd->oobsize - ecc->total - 3;
+	oobregion->offset = 3 + ecc->total;
+
+	return 0;
+}
+
+const struct mtd_ooblayout_ops jz4725b_ooblayout_ops = {
+	.ecc = jz4725b_ooblayout_ecc,
+	.free = jz4725b_ooblayout_free,
+};
+
 static void ingenic_nand_select_chip(struct nand_chip *chip, int chipnr)
 {
 	struct ingenic_nand *nand = to_ingenic_nand(nand_to_mtd(chip));
@@ -211,7 +247,7 @@ static int ingenic_nand_attach_chip(struct nand_chip *chip)
 		return -EINVAL;
 	}
 
-	mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
+	mtd_set_ooblayout(mtd, nfc->soc_info->oob_layout);
 
 	return 0;
 }
@@ -407,16 +443,26 @@ static const struct jz_soc_info jz4740_soc_info = {
 	.data_offset = 0x00000000,
 	.cmd_offset  = 0x00008000,
 	.addr_offset = 0x00010000,
+	.oob_layout = &nand_ooblayout_lp_ops,
+};
+
+static const struct jz_soc_info jz4725b_soc_info = {
+	.data_offset = 0x00000000,
+	.cmd_offset  = 0x00008000,
+	.addr_offset = 0x00010000,
+	.oob_layout = &jz4725b_ooblayout_ops,
 };
 
 static const struct jz_soc_info jz4780_soc_info = {
 	.data_offset = 0x00000000,
 	.cmd_offset  = 0x00400000,
 	.addr_offset = 0x00800000,
+	.oob_layout = &nand_ooblayout_lp_ops,
 };
 
 static const struct of_device_id ingenic_nand_dt_match[] = {
 	{ .compatible = "ingenic,jz4740-nand", .data = &jz4740_soc_info },
+	{ .compatible = "ingenic,jz4725b-nand", .data = &jz4725b_soc_info },
 	{ .compatible = "ingenic,jz4780-nand",  .data = &jz4780_soc_info  },
 	{},
 };
diff --git a/drivers/mtd/nand/raw/ingenic/jz4725b_bch.c b/drivers/mtd/nand/raw/ingenic/jz4725b_bch.c
new file mode 100644
index 000000000000..66be454be383
--- /dev/null
+++ b/drivers/mtd/nand/raw/ingenic/jz4725b_bch.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * JZ4725B BCH controller driver
+ *
+ * Copyright (C) 2018 Paul Cercueil <paul@crapouillou.net>
+ *
+ * Based on jz4780_bch.c
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include "ingenic_ecc.h"
+
+#define BCH_BHCR			0x0
+#define BCH_BHCSR			0x4
+#define BCH_BHCCR			0x8
+#define BCH_BHCNT			0xc
+#define BCH_BHDR			0x10
+#define BCH_BHPAR0			0x14
+#define BCH_BHERR0			0x28
+#define BCH_BHINT			0x24
+#define BCH_BHINTES			0x3c
+#define BCH_BHINTEC			0x40
+#define BCH_BHINTE			0x38
+
+#define BCH_BHCR_BSEL_SHIFT		2
+#define BCH_BHCR_BSEL_MASK		(0x1 << BCH_BHCR_BSEL_SHIFT)
+#define BCH_BHCR_ENCE			BIT(3)
+#define BCH_BHCR_INIT			BIT(1)
+#define BCH_BHCR_BCHE			BIT(0)
+
+#define BCH_BHCNT_DEC_COUNT_SHIFT	16
+#define BCH_BHCNT_DEC_COUNT_MASK	(0x3ff << BCH_BHCNT_DEC_COUNT_SHIFT)
+#define BCH_BHCNT_ENC_COUNT_SHIFT	0
+#define BCH_BHCNT_ENC_COUNT_MASK	(0x3ff << BCH_BHCNT_ENC_COUNT_SHIFT)
+
+#define BCH_BHERR_INDEX0_SHIFT		0
+#define BCH_BHERR_INDEX0_MASK		(0x1fff << BCH_BHERR_INDEX0_SHIFT)
+#define BCH_BHERR_INDEX1_SHIFT		16
+#define BCH_BHERR_INDEX1_MASK		(0x1fff << BCH_BHERR_INDEX1_SHIFT)
+
+#define BCH_BHINT_ERRC_SHIFT		28
+#define BCH_BHINT_ERRC_MASK		(0xf << BCH_BHINT_ERRC_SHIFT)
+#define BCH_BHINT_TERRC_SHIFT		16
+#define BCH_BHINT_TERRC_MASK		(0x7f << BCH_BHINT_TERRC_SHIFT)
+#define BCH_BHINT_ALL_0			BIT(5)
+#define BCH_BHINT_ALL_F			BIT(4)
+#define BCH_BHINT_DECF			BIT(3)
+#define BCH_BHINT_ENCF			BIT(2)
+#define BCH_BHINT_UNCOR			BIT(1)
+#define BCH_BHINT_ERR			BIT(0)
+
+/* Timeout for BCH calculation/correction. */
+#define BCH_TIMEOUT_US			100000
+
+static void jz4725b_bch_init(struct ingenic_ecc *bch,
+			     struct ingenic_ecc_params *params, bool encode)
+{
+	u32 reg;
+
+	/* Clear interrupt status. */
+	writel(readl(bch->base + BCH_BHINT), bch->base + BCH_BHINT);
+
+	/* Initialise and enable BCH. */
+	writel(0x1f, bch->base + BCH_BHCCR);
+	writel(BCH_BHCR_BCHE, bch->base + BCH_BHCSR);
+
+	if (params->strength == 8)
+		writel(BCH_BHCR_BSEL_MASK, bch->base + BCH_BHCSR);
+	else
+		writel(BCH_BHCR_BSEL_MASK, bch->base + BCH_BHCCR);
+
+	if (encode)
+		writel(BCH_BHCR_ENCE, bch->base + BCH_BHCSR);
+	else
+		writel(BCH_BHCR_ENCE, bch->base + BCH_BHCCR);
+
+	writel(BCH_BHCR_INIT, bch->base + BCH_BHCSR);
+
+	/* Set up BCH count register. */
+	reg = params->size << BCH_BHCNT_ENC_COUNT_SHIFT;
+	reg |= (params->size + params->bytes) << BCH_BHCNT_DEC_COUNT_SHIFT;
+	writel(reg, bch->base + BCH_BHCNT);
+}
+
+static void jz4725b_bch_disable(struct ingenic_ecc *bch)
+{
+	writel(readl(bch->base + BCH_BHINT), bch->base + BCH_BHINT);
+	writel(BCH_BHCR_BCHE, bch->base + BCH_BHCCR);
+}
+
+static void jz4725b_bch_write_data(struct ingenic_ecc *bch, const u8 *buf,
+				   size_t size)
+{
+	while (size--)
+		writeb(*buf++, bch->base + BCH_BHDR);
+}
+
+static void jz4725b_bch_read_parity(struct ingenic_ecc *bch, u8 *buf,
+				    size_t size)
+{
+	size_t size32 = size / sizeof(u32);
+	size_t size8 = size % sizeof(u32);
+	u32 *dest32;
+	u8 *dest8;
+	u32 val, offset = 0;
+
+	dest32 = (u32 *)buf;
+	while (size32--) {
+		*dest32++ = readl(bch->base + BCH_BHPAR0 + offset);
+		offset += sizeof(u32);
+	}
+
+	dest8 = (u8 *)dest32;
+	val = readl(bch->base + BCH_BHPAR0 + offset);
+	switch (size8) {
+	case 3:
+		dest8[2] = (val >> 16) & 0xff;
+	case 2:
+		dest8[1] = (val >> 8) & 0xff;
+	case 1:
+		dest8[0] = val & 0xff;
+		break;
+	}
+}
+
+static bool jz4725b_bch_wait_complete(struct ingenic_ecc *bch, unsigned int irq,
+				      u32 *status)
+{
+	u32 reg;
+	int ret;
+
+	/*
+	 * While we could use interrupts here and sleep until the operation
+	 * completes, the controller works fairly quickly (usually a few
+	 * microseconds) and so the overhead of sleeping until we get an
+	 * interrupt quite noticeably decreases performance.
+	 */
+	ret = readl_poll_timeout(bch->base + BCH_BHINT, reg,
+				 (reg & irq) == irq, 0, BCH_TIMEOUT_US);
+	if (ret)
+		return false;
+
+	if (status)
+		*status = reg;
+
+	writel(reg, bch->base + BCH_BHINT);
+	return true;
+}
+
+static int jz4725b_calculate(struct ingenic_ecc *bch,
+			     struct ingenic_ecc_params *params,
+			     const u8 *buf, u8 *ecc_code)
+{
+	int ret = 0;
+
+	mutex_lock(&bch->lock);
+	jz4725b_bch_init(bch, params, true);
+	jz4725b_bch_write_data(bch, buf, params->size);
+
+	if (jz4725b_bch_wait_complete(bch, BCH_BHINT_ENCF, NULL)) {
+		jz4725b_bch_read_parity(bch, ecc_code, params->bytes);
+	} else {
+		dev_err(bch->dev, "timed out while calculating ECC\n");
+		ret = -ETIMEDOUT;
+	}
+
+	jz4725b_bch_disable(bch);
+	mutex_unlock(&bch->lock);
+	return ret;
+}
+
+static int jz4725b_correct(struct ingenic_ecc *bch,
+			   struct ingenic_ecc_params *params,
+			   u8 *buf, u8 *ecc_code)
+{
+	u32 reg, errors, bit;
+	unsigned int i;
+	int ret = 0;
+
+	mutex_lock(&bch->lock);
+
+	jz4725b_bch_init(bch, params, false);
+	jz4725b_bch_write_data(bch, buf, params->size);
+	jz4725b_bch_write_data(bch, ecc_code, params->bytes);
+
+	if (!jz4725b_bch_wait_complete(bch, BCH_BHINT_DECF, &reg)) {
+		dev_err(bch->dev, "timed out while correcting data\n");
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	if (reg & (BCH_BHINT_ALL_F | BCH_BHINT_ALL_0)) {
+		/* Data and ECC is all 0xff or 0x00 - nothing to correct */
+		ret = 0;
+		goto out;
+	}
+
+	if (reg & BCH_BHINT_UNCOR) {
+		/* Uncorrectable ECC error */
+		ret = -EBADMSG;
+		goto out;
+	}
+
+	errors = (reg & BCH_BHINT_ERRC_MASK) >> BCH_BHINT_ERRC_SHIFT;
+
+	/* Correct any detected errors. */
+	for (i = 0; i < errors; i++) {
+		if (i & 1) {
+			bit = (reg & BCH_BHERR_INDEX1_MASK) >> BCH_BHERR_INDEX1_SHIFT;
+		} else {
+			reg = readl(bch->base + BCH_BHERR0 + (i * 4));
+			bit = (reg & BCH_BHERR_INDEX0_MASK) >> BCH_BHERR_INDEX0_SHIFT;
+		}
+
+		buf[(bit >> 3)] ^= BIT(bit & 0x7);
+	}
+
+out:
+	jz4725b_bch_disable(bch);
+	mutex_unlock(&bch->lock);
+	return ret;
+}
+
+static const struct ingenic_ecc_ops jz4725b_bch_ops = {
+	.disable = jz4725b_bch_disable,
+	.calculate = jz4725b_calculate,
+	.correct = jz4725b_correct,
+};
+
+static const struct of_device_id jz4725b_bch_dt_match[] = {
+	{ .compatible = "ingenic,jz4725b-bch", .data = &jz4725b_bch_ops },
+	{},
+};
+MODULE_DEVICE_TABLE(of, jz4725b_bch_dt_match);
+
+static struct platform_driver jz4725b_bch_driver = {
+	.probe		= ingenic_ecc_probe,
+	.driver	= {
+		.name	= "jz4725b-bch",
+		.of_match_table = jz4725b_bch_dt_match,
+	},
+};
+module_platform_driver(jz4725b_bch_driver);
-- 
2.11.0

