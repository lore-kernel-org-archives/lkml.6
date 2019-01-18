Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C42C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91FE42086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="FqGBXvaX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfARBHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:07:33 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:33592 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfARBHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547773650; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Omx15frAzVyJadifK39eZ16uWs9JSfFkiSFAT6zYU5E=;
        b=FqGBXvaXhmCXUjYeAdj8WO/ayVTHPfE+zGjg5eaHxzY0soHFZDC/NP2PZFb20LAelnkZRH
        rEw4jFm76ZyNEaASn35GpF+Jsj9lvtDCpyIX7HArMlFpOBP11tRX3w7BIYPc5qLFu5qVpv
        6V8nYcrjWwObICPVKvUNdumOi3iz3lY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 8/8] mtd: rawnand: jz4780-bch: Add support for the JZ4725B
Date:   Thu, 17 Jan 2019 22:06:34 -0300
Message-Id: <20190118010634.27399-8-paul@crapouillou.net>
In-Reply-To: <20190118010634.27399-1-paul@crapouillou.net>
References: <20190118010634.27399-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the backend code for the jz4780-bch driver to support the JZ4725B
SoC from Ingenic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mtd/nand/raw/Makefile              |   2 +-
 drivers/mtd/nand/raw/jz4725b_bch.c         | 234 +++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/jz4780_bch_common.c   |   1 +
 drivers/mtd/nand/raw/jz4780_bch_internal.h |   1 +
 4 files changed, 237 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/raw/jz4725b_bch.c

diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 6dacc9cf38d5..99cc9317a218 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -47,7 +47,7 @@ obj-$(CONFIG_MTD_NAND_VF610_NFC)	+= vf610_nfc.o
 obj-$(CONFIG_MTD_NAND_RICOH)		+= r852.o
 obj-$(CONFIG_MTD_NAND_JZ4740)		+= jz4740_nand.o
 obj-$(CONFIG_MTD_NAND_JZ4780)		+= jz4780_nand.o jz4780_bch_common.o \
-					   jz4780_bch.o
+					   jz4780_bch.o jz4725b_bch.o
 obj-$(CONFIG_MTD_NAND_GPMI_NAND)	+= gpmi-nand/
 obj-$(CONFIG_MTD_NAND_XWAY)		+= xway_nand.o
 obj-$(CONFIG_MTD_NAND_BCM47XXNFLASH)	+= bcm47xxnflash/
diff --git a/drivers/mtd/nand/raw/jz4725b_bch.c b/drivers/mtd/nand/raw/jz4725b_bch.c
new file mode 100644
index 000000000000..54f9c5796e83
--- /dev/null
+++ b/drivers/mtd/nand/raw/jz4725b_bch.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * JZ4780 backend code for the jz4780-bch driver
+ *
+ * Copyright (C) 2018 Paul Cercueil <paul@crapouillou.net>
+ *
+ * Based on jz4780_bch.c
+ */
+
+#include <linux/bitops.h>
+#include <linux/iopoll.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/device.h>
+
+#include "jz4780_bch.h"
+#include "jz4780_bch_internal.h"
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
+static void jz4725b_bch_init(struct jz4780_bch *bch,
+			     struct jz4780_bch_params *params, bool encode)
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
+static void jz4725b_bch_disable(struct jz4780_bch *bch)
+{
+	writel(readl(bch->base + BCH_BHINT), bch->base + BCH_BHINT);
+	writel(BCH_BHCR_BCHE, bch->base + BCH_BHCCR);
+}
+
+static void jz4725b_bch_write_data(struct jz4780_bch *bch, const u8 *buf,
+				   size_t size)
+{
+	while (size--)
+		writeb(*buf++, bch->base + BCH_BHDR);
+}
+
+static void jz4725b_bch_read_parity(struct jz4780_bch *bch, u8 *buf,
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
+static bool jz4725b_bch_wait_complete(struct jz4780_bch *bch, unsigned int irq,
+				     u32 *status)
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
+static int jz4725b_calculate(struct jz4780_bch *bch,
+			     struct jz4780_bch_params *params,
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
+static int jz4725b_correct(struct jz4780_bch *bch,
+			   struct jz4780_bch_params *params,
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
+const struct jz4780_bch_ops jz4780_bch_jz4725b_ops = {
+	.disable = jz4725b_bch_disable,
+	.calculate = jz4725b_calculate,
+	.correct = jz4725b_correct,
+};
diff --git a/drivers/mtd/nand/raw/jz4780_bch_common.c b/drivers/mtd/nand/raw/jz4780_bch_common.c
index 573b079e6cbe..5b5ab4e66c49 100644
--- a/drivers/mtd/nand/raw/jz4780_bch_common.c
+++ b/drivers/mtd/nand/raw/jz4780_bch_common.c
@@ -152,6 +152,7 @@ static int jz4780_bch_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id jz4780_bch_dt_match[] = {
+	{ .compatible = "ingenic,jz4725b-bch", .data = &jz4780_bch_jz4725b_ops},
 	{ .compatible = "ingenic,jz4780-bch", .data = &jz4780_bch_jz4780_ops },
 	{},
 };
diff --git a/drivers/mtd/nand/raw/jz4780_bch_internal.h b/drivers/mtd/nand/raw/jz4780_bch_internal.h
index 7162e4f872f4..cc12b782a8d9 100644
--- a/drivers/mtd/nand/raw/jz4780_bch_internal.h
+++ b/drivers/mtd/nand/raw/jz4780_bch_internal.h
@@ -29,6 +29,7 @@ struct jz4780_bch {
 	struct mutex lock;
 };
 
+extern const struct jz4780_bch_ops jz4780_bch_jz4725b_ops;
 extern const struct jz4780_bch_ops jz4780_bch_jz4780_ops;
 
 #endif /* __DRIVERS_MTD_NAND_JZ4780_BCH_INTERNAL_H__ */
-- 
2.11.0

