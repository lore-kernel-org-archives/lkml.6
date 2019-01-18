Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76D5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646512086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 01:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="jXDN9osz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfARBH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 20:07:28 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:33458 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfARBH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 20:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1547773644; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZTyT6/10sVr7oEKNafuh3OneCF2L8idqrA2JwlhTVkQ=;
        b=jXDN9osz0vrRGf69E7+wmLKZDVjh8OwgWeWZPPms1iQEqBayY1d2H90LczzLsdSBUHlxjc
        IqW2PliVag+ca4iGL21/z8JZ95i779/a6XzW31UFIy5ETuT9c0ykb3nw9KpGECG4K6kQoj
        58jo7X2HWzDwijtRqdeQFHk050AL+L8=
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
Subject: [PATCH 7/8] mtd: rawnand: jz4780-bch: Separate top-level and SoC specific code
Date:   Thu, 17 Jan 2019 22:06:33 -0300
Message-Id: <20190118010634.27399-7-paul@crapouillou.net>
In-Reply-To: <20190118010634.27399-1-paul@crapouillou.net>
References: <20190118010634.27399-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jz4780-nand driver uses an API provided by the jz4780-bch driver.
This makes it difficult to support other SoCs in the jz4780-bch driver.
To work around this, we separate the API functions from the SoC-specific
code, so that these API functions are SoC-agnostic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/mtd/nand/raw/Makefile              |   3 +-
 drivers/mtd/nand/raw/jz4780_bch.c          | 173 +++--------------------------
 drivers/mtd/nand/raw/jz4780_bch_common.c   | 172 ++++++++++++++++++++++++++++
 drivers/mtd/nand/raw/jz4780_bch_internal.h |  34 ++++++
 4 files changed, 222 insertions(+), 160 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/jz4780_bch_common.c
 create mode 100644 drivers/mtd/nand/raw/jz4780_bch_internal.h

diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index 57159b349054..6dacc9cf38d5 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -46,7 +46,8 @@ obj-$(CONFIG_MTD_NAND_MPC5121_NFC)	+= mpc5121_nfc.o
 obj-$(CONFIG_MTD_NAND_VF610_NFC)	+= vf610_nfc.o
 obj-$(CONFIG_MTD_NAND_RICOH)		+= r852.o
 obj-$(CONFIG_MTD_NAND_JZ4740)		+= jz4740_nand.o
-obj-$(CONFIG_MTD_NAND_JZ4780)		+= jz4780_nand.o jz4780_bch.o
+obj-$(CONFIG_MTD_NAND_JZ4780)		+= jz4780_nand.o jz4780_bch_common.o \
+					   jz4780_bch.o
 obj-$(CONFIG_MTD_NAND_GPMI_NAND)	+= gpmi-nand/
 obj-$(CONFIG_MTD_NAND_XWAY)		+= xway_nand.o
 obj-$(CONFIG_MTD_NAND_BCM47XXNFLASH)	+= bcm47xxnflash/
diff --git a/drivers/mtd/nand/raw/jz4780_bch.c b/drivers/mtd/nand/raw/jz4780_bch.c
index 161d3821e1c4..1dfc960067b3 100644
--- a/drivers/mtd/nand/raw/jz4780_bch.c
+++ b/drivers/mtd/nand/raw/jz4780_bch.c
@@ -1,25 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * JZ4780 BCH controller
+ * JZ4780 backend code for the jz4780-bch driver
  *
  * Copyright (c) 2015 Imagination Technologies
  * Author: Alex Smith <alex.smith@imgtec.com>
  */
 
 #include <linux/bitops.h>
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/init.h>
 #include <linux/iopoll.h>
-#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
-#include <linux/platform_device.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
+#include <linux/device.h>
 
 #include "jz4780_bch.h"
+#include "jz4780_bch_internal.h"
 
 #define BCH_BHCR			0x0
 #define BCH_BHCCR			0x8
@@ -60,13 +54,6 @@
 /* Timeout for BCH calculation/correction. */
 #define BCH_TIMEOUT_US			100000
 
-struct jz4780_bch {
-	struct device *dev;
-	void __iomem *base;
-	struct clk *clk;
-	struct mutex lock;
-};
-
 static void jz4780_bch_init(struct jz4780_bch *bch,
 			    struct jz4780_bch_params *params, bool encode)
 {
@@ -165,18 +152,9 @@ static bool jz4780_bch_wait_complete(struct jz4780_bch *bch, unsigned int irq,
 	return true;
 }
 
-/**
- * jz4780_bch_calculate() - calculate ECC for a data buffer
- * @bch: BCH device.
- * @params: BCH parameters.
- * @buf: input buffer with raw data.
- * @ecc_code: output buffer with ECC.
- *
- * Return: 0 on success, -ETIMEDOUT if timed out while waiting for BCH
- * controller.
- */
-int jz4780_bch_calculate(struct jz4780_bch *bch, struct jz4780_bch_params *params,
-			 const u8 *buf, u8 *ecc_code)
+static int jz4780_calculate(struct jz4780_bch *bch,
+			    struct jz4780_bch_params *params,
+			    const u8 *buf, u8 *ecc_code)
 {
 	int ret = 0;
 
@@ -195,23 +173,10 @@ int jz4780_bch_calculate(struct jz4780_bch *bch, struct jz4780_bch_params *param
 	mutex_unlock(&bch->lock);
 	return ret;
 }
-EXPORT_SYMBOL(jz4780_bch_calculate);
-
-/**
- * jz4780_bch_correct() - detect and correct bit errors
- * @bch: BCH device.
- * @params: BCH parameters.
- * @buf: raw data read from the chip.
- * @ecc_code: ECC read from the chip.
- *
- * Given the raw data and the ECC read from the NAND device, detects and
- * corrects errors in the data.
- *
- * Return: the number of bit errors corrected, -EBADMSG if there are too many
- * errors to correct or -ETIMEDOUT if we timed out waiting for the controller.
- */
-int jz4780_bch_correct(struct jz4780_bch *bch, struct jz4780_bch_params *params,
-		       u8 *buf, u8 *ecc_code)
+
+static int jz4780_correct(struct jz4780_bch *bch,
+			  struct jz4780_bch_params *params,
+			  u8 *buf, u8 *ecc_code)
 {
 	u32 reg, mask, index;
 	int i, ret, count;
@@ -257,119 +222,9 @@ int jz4780_bch_correct(struct jz4780_bch *bch, struct jz4780_bch_params *params,
 	mutex_unlock(&bch->lock);
 	return ret;
 }
-EXPORT_SYMBOL(jz4780_bch_correct);
-
-/**
- * jz4780_bch_get() - get the BCH controller device
- * @np: BCH device tree node.
- *
- * Gets the BCH controller device from the specified device tree node. The
- * device must be released with jz4780_bch_release() when it is no longer being
- * used.
- *
- * Return: a pointer to jz4780_bch, errors are encoded into the pointer.
- * PTR_ERR(-EPROBE_DEFER) if the device hasn't been initialised yet.
- */
-static struct jz4780_bch *jz4780_bch_get(struct device_node *np)
-{
-	struct platform_device *pdev;
-	struct jz4780_bch *bch;
-
-	pdev = of_find_device_by_node(np);
-	if (!pdev || !platform_get_drvdata(pdev))
-		return ERR_PTR(-EPROBE_DEFER);
-
-	get_device(&pdev->dev);
-
-	bch = platform_get_drvdata(pdev);
-	clk_prepare_enable(bch->clk);
-
-	return bch;
-}
-
-/**
- * of_jz4780_bch_get() - get the BCH controller from a DT node
- * @of_node: the node that contains a bch-controller property.
- *
- * Get the bch-controller property from the given device tree
- * node and pass it to jz4780_bch_get to do the work.
- *
- * Return: a pointer to jz4780_bch, errors are encoded into the pointer.
- * PTR_ERR(-EPROBE_DEFER) if the device hasn't been initialised yet.
- */
-struct jz4780_bch *of_jz4780_bch_get(struct device_node *of_node)
-{
-	struct jz4780_bch *bch = NULL;
-	struct device_node *np;
 
-	np = of_parse_phandle(of_node, "ingenic,bch-controller", 0);
-
-	if (np) {
-		bch = jz4780_bch_get(np);
-		of_node_put(np);
-	}
-	return bch;
-}
-EXPORT_SYMBOL(of_jz4780_bch_get);
-
-/**
- * jz4780_bch_release() - release the BCH controller device
- * @bch: BCH device.
- */
-void jz4780_bch_release(struct jz4780_bch *bch)
-{
-	clk_disable_unprepare(bch->clk);
-	put_device(bch->dev);
-}
-EXPORT_SYMBOL(jz4780_bch_release);
-
-static int jz4780_bch_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct jz4780_bch *bch;
-	struct resource *res;
-
-	bch = devm_kzalloc(dev, sizeof(*bch), GFP_KERNEL);
-	if (!bch)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	bch->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(bch->base))
-		return PTR_ERR(bch->base);
-
-	jz4780_bch_disable(bch);
-
-	bch->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(bch->clk)) {
-		dev_err(dev, "failed to get clock: %ld\n", PTR_ERR(bch->clk));
-		return PTR_ERR(bch->clk);
-	}
-
-	mutex_init(&bch->lock);
-
-	bch->dev = dev;
-	platform_set_drvdata(pdev, bch);
-
-	return 0;
-}
-
-static const struct of_device_id jz4780_bch_dt_match[] = {
-	{ .compatible = "ingenic,jz4780-bch" },
-	{},
+const struct jz4780_bch_ops jz4780_bch_jz4780_ops = {
+	.disable = jz4780_bch_disable,
+	.calculate = jz4780_calculate,
+	.correct = jz4780_correct,
 };
-MODULE_DEVICE_TABLE(of, jz4780_bch_dt_match);
-
-static struct platform_driver jz4780_bch_driver = {
-	.probe		= jz4780_bch_probe,
-	.driver	= {
-		.name	= "jz4780-bch",
-		.of_match_table = of_match_ptr(jz4780_bch_dt_match),
-	},
-};
-module_platform_driver(jz4780_bch_driver);
-
-MODULE_AUTHOR("Alex Smith <alex@alex-smith.me.uk>");
-MODULE_AUTHOR("Harvey Hunt <harveyhuntnexus@gmail.com>");
-MODULE_DESCRIPTION("Ingenic JZ4780 BCH error correction driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/mtd/nand/raw/jz4780_bch_common.c b/drivers/mtd/nand/raw/jz4780_bch_common.c
new file mode 100644
index 000000000000..573b079e6cbe
--- /dev/null
+++ b/drivers/mtd/nand/raw/jz4780_bch_common.c
@@ -0,0 +1,172 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * JZ4780 BCH controller
+ *
+ * Copyright (c) 2015 Imagination Technologies
+ * Author: Alex Smith <alex.smith@imgtec.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include "jz4780_bch_internal.h"
+#include "jz4780_bch.h"
+
+/**
+ * jz4780_bch_calculate() - calculate ECC for a data buffer
+ * @bch: BCH device.
+ * @params: BCH parameters.
+ * @buf: input buffer with raw data.
+ * @ecc_code: output buffer with ECC.
+ *
+ * Return: 0 on success, -ETIMEDOUT if timed out while waiting for BCH
+ * controller.
+ */
+int jz4780_bch_calculate(struct jz4780_bch *bch, struct jz4780_bch_params *params,
+			 const u8 *buf, u8 *ecc_code)
+{
+	return bch->ops->calculate(bch, params, buf, ecc_code);
+}
+EXPORT_SYMBOL(jz4780_bch_calculate);
+
+/**
+ * jz4780_bch_correct() - detect and correct bit errors
+ * @bch: BCH device.
+ * @params: BCH parameters.
+ * @buf: raw data read from the chip.
+ * @ecc_code: ECC read from the chip.
+ *
+ * Given the raw data and the ECC read from the NAND device, detects and
+ * corrects errors in the data.
+ *
+ * Return: the number of bit errors corrected, -EBADMSG if there are too many
+ * errors to correct or -ETIMEDOUT if we timed out waiting for the controller.
+ */
+int jz4780_bch_correct(struct jz4780_bch *bch, struct jz4780_bch_params *params,
+		       u8 *buf, u8 *ecc_code)
+{
+	return bch->ops->correct(bch, params, buf, ecc_code);
+}
+EXPORT_SYMBOL(jz4780_bch_correct);
+
+/**
+ * jz4780_bch_get() - get the BCH controller device
+ * @np: BCH device tree node.
+ *
+ * Gets the BCH controller device from the specified device tree node. The
+ * device must be released with jz4780_bch_release() when it is no longer being
+ * used.
+ *
+ * Return: a pointer to jz4780_bch, errors are encoded into the pointer.
+ * PTR_ERR(-EPROBE_DEFER) if the device hasn't been initialised yet.
+ */
+static struct jz4780_bch *jz4780_bch_get(struct device_node *np)
+{
+	struct platform_device *pdev;
+	struct jz4780_bch *bch;
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev || !platform_get_drvdata(pdev))
+		return ERR_PTR(-EPROBE_DEFER);
+
+	get_device(&pdev->dev);
+
+	bch = platform_get_drvdata(pdev);
+	clk_prepare_enable(bch->clk);
+
+	return bch;
+}
+
+/**
+ * of_jz4780_bch_get() - get the BCH controller from a DT node
+ * @of_node: the node that contains a bch-controller property.
+ *
+ * Get the bch-controller property from the given device tree
+ * node and pass it to jz4780_bch_get to do the work.
+ *
+ * Return: a pointer to jz4780_bch, errors are encoded into the pointer.
+ * PTR_ERR(-EPROBE_DEFER) if the device hasn't been initialised yet.
+ */
+struct jz4780_bch *of_jz4780_bch_get(struct device_node *of_node)
+{
+	struct jz4780_bch *bch = NULL;
+	struct device_node *np;
+
+	np = of_parse_phandle(of_node, "ingenic,bch-controller", 0);
+
+	if (np) {
+		bch = jz4780_bch_get(np);
+		of_node_put(np);
+	}
+	return bch;
+}
+EXPORT_SYMBOL(of_jz4780_bch_get);
+
+/**
+ * jz4780_bch_release() - release the BCH controller device
+ * @bch: BCH device.
+ */
+void jz4780_bch_release(struct jz4780_bch *bch)
+{
+	clk_disable_unprepare(bch->clk);
+	put_device(bch->dev);
+}
+EXPORT_SYMBOL(jz4780_bch_release);
+
+static int jz4780_bch_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct jz4780_bch *bch;
+	struct resource *res;
+
+	bch = devm_kzalloc(dev, sizeof(*bch), GFP_KERNEL);
+	if (!bch)
+		return -ENOMEM;
+
+	bch->ops = device_get_match_data(dev);
+	if (!bch->ops)
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	bch->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(bch->base))
+		return PTR_ERR(bch->base);
+
+	bch->ops->disable(bch);
+
+	bch->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(bch->clk)) {
+		dev_err(dev, "failed to get clock: %ld\n", PTR_ERR(bch->clk));
+		return PTR_ERR(bch->clk);
+	}
+
+	mutex_init(&bch->lock);
+
+	bch->dev = dev;
+	platform_set_drvdata(pdev, bch);
+
+	return 0;
+}
+
+static const struct of_device_id jz4780_bch_dt_match[] = {
+	{ .compatible = "ingenic,jz4780-bch", .data = &jz4780_bch_jz4780_ops },
+	{},
+};
+MODULE_DEVICE_TABLE(of, jz4780_bch_dt_match);
+
+static struct platform_driver jz4780_bch_driver = {
+	.probe		= jz4780_bch_probe,
+	.driver	= {
+		.name	= "jz4780-bch",
+		.of_match_table = of_match_ptr(jz4780_bch_dt_match),
+	},
+};
+module_platform_driver(jz4780_bch_driver);
+
+MODULE_AUTHOR("Alex Smith <alex@alex-smith.me.uk>");
+MODULE_AUTHOR("Harvey Hunt <harveyhuntnexus@gmail.com>");
+MODULE_DESCRIPTION("Ingenic JZ4780 BCH error correction driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mtd/nand/raw/jz4780_bch_internal.h b/drivers/mtd/nand/raw/jz4780_bch_internal.h
new file mode 100644
index 000000000000..7162e4f872f4
--- /dev/null
+++ b/drivers/mtd/nand/raw/jz4780_bch_internal.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DRIVERS_MTD_NAND_JZ4780_BCH_INTERNAL_H__
+#define __DRIVERS_MTD_NAND_JZ4780_BCH_INTERNAL_H__
+
+#include <linux/compiler_types.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+struct jz4780_bch_params;
+struct jz4780_bch;
+struct device;
+struct clk;
+
+struct jz4780_bch_ops {
+	void (*disable)(struct jz4780_bch *bch);
+	int (*calculate)(struct jz4780_bch *bch,
+			 struct jz4780_bch_params *params,
+			 const u8 *buf, u8 *ecc_code);
+	int (*correct)(struct jz4780_bch *bch,
+			struct jz4780_bch_params *params,
+			u8 *buf, u8 *ecc_code);
+};
+
+struct jz4780_bch {
+	struct device *dev;
+	const struct jz4780_bch_ops *ops;
+	void __iomem *base;
+	struct clk *clk;
+	struct mutex lock;
+};
+
+extern const struct jz4780_bch_ops jz4780_bch_jz4780_ops;
+
+#endif /* __DRIVERS_MTD_NAND_JZ4780_BCH_INTERNAL_H__ */
-- 
2.11.0

