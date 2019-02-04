Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352B8C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCC72082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 19:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="wBgvOm4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbfBDTFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 14:05:11 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:48136 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbfBDTFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 14:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1549307107; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qkSNK56RCQ81k52KqSoC5t2wkuAc1YskBDvukcxxDMQ=;
        b=wBgvOm4x3dieaa5Su60jFz3/LIA/mcymsUwe3izurU/6uKG9zdS/ULEgggl0pm/50zNPwR
        hxjFj3t9odAZjr32ZIP4h/Wt119m/j2auGjlmGourV42gnIihEvfgQwRp8WPJBYU1ccCO+
        grc3IPftOH23iOoJ+EjCGkH7E+4R5Sk=
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
Subject: [PATCH v3 6/9] mtd: rawnand: ingenic: Separate top-level and SoC specific code
Date:   Mon,  4 Feb 2019 16:04:23 -0300
Message-Id: <20190204190426.11618-6-paul@crapouillou.net>
In-Reply-To: <20190204190426.11618-1-paul@crapouillou.net>
References: <20190204190426.11618-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ingenic-nand driver uses an API provided by the jz4780-bch driver.
This makes it difficult to support other SoCs in the jz4780-bch driver.
To work around this, we separate the API functions from the SoC-specific
code, so that these API functions are SoC-agnostic.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Changes:

v2: Add an optional .probe() callback. It is used for instance to set
    the clock rate in the JZ4780 backend.

v3: The common code is now inside the ingenic-ecc module. Each
    SoC-specific ECC code is now in its own module, which leaves to the
    user the choice of which (if any) ECC code should be supported.

 drivers/mtd/nand/raw/ingenic/Kconfig        |  17 +++
 drivers/mtd/nand/raw/ingenic/Makefile       |   5 +-
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.c  | 157 +++++++++++++++++++++++++
 drivers/mtd/nand/raw/ingenic/ingenic_ecc.h  |  84 ++++++++++++++
 drivers/mtd/nand/raw/ingenic/ingenic_nand.c |  38 +++----
 drivers/mtd/nand/raw/ingenic/jz4780_bch.c   | 170 +++++-----------------------
 drivers/mtd/nand/raw/ingenic/jz4780_bch.h   |  40 -------
 7 files changed, 308 insertions(+), 203 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
 create mode 100644 drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
 delete mode 100644 drivers/mtd/nand/raw/ingenic/jz4780_bch.h

diff --git a/drivers/mtd/nand/raw/ingenic/Kconfig b/drivers/mtd/nand/raw/ingenic/Kconfig
index 67806c87b2c4..4bf7d7af3b0a 100644
--- a/drivers/mtd/nand/raw/ingenic/Kconfig
+++ b/drivers/mtd/nand/raw/ingenic/Kconfig
@@ -11,3 +11,20 @@ config MTD_NAND_JZ4780
 	help
 	  Enables support for NAND Flash connected to the NEMC on JZ4780 SoC
 	  based boards, using the BCH controller for hardware error correction.
+
+if MTD_NAND_JZ4780
+
+config MTD_NAND_INGENIC_ECC
+	tristate
+
+config MTD_NAND_JZ4780_BCH
+	tristate "Hardware BCH support for JZ4780 SoC"
+	select MTD_NAND_INGENIC_ECC
+	help
+	  Enable this driver to support the BCH error-correction hardware
+	  present on the JZ4780 SoC from Ingenic.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called jz4780-bch.
+
+endif # MTD_NAND_JZ4780
diff --git a/drivers/mtd/nand/raw/ingenic/Makefile b/drivers/mtd/nand/raw/ingenic/Makefile
index af2d5de21f60..f3c3c0f230b0 100644
--- a/drivers/mtd/nand/raw/ingenic/Makefile
+++ b/drivers/mtd/nand/raw/ingenic/Makefile
@@ -1,2 +1,5 @@
 obj-$(CONFIG_MTD_NAND_JZ4740) += jz4740_nand.o
-obj-$(CONFIG_MTD_NAND_JZ4780) += ingenic_nand.o jz4780_bch.o
+obj-$(CONFIG_MTD_NAND_JZ4780) += ingenic_nand.o
+
+obj-$(CONFIG_MTD_NAND_INGENIC_ECC) += ingenic_ecc.o
+obj-$(CONFIG_MTD_NAND_JZ4780_BCH) += jz4780_bch.o
diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
new file mode 100644
index 000000000000..a5b2f31803ff
--- /dev/null
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * JZ47xx ECC common code
+ *
+ * Copyright (c) 2015 Imagination Technologies
+ * Author: Alex Smith <alex.smith@imgtec.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include "ingenic_ecc.h"
+
+/**
+ * ingenic_ecc_calculate() - calculate ECC for a data buffer
+ * @ecc: ECC device.
+ * @params: ECC parameters.
+ * @buf: input buffer with raw data.
+ * @ecc_code: output buffer with ECC.
+ *
+ * Return: 0 on success, -ETIMEDOUT if timed out while waiting for ECC
+ * controller.
+ */
+int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
+			  struct ingenic_ecc_params *params,
+			  const u8 *buf, u8 *ecc_code)
+{
+	return ecc->ops->calculate(ecc, params, buf, ecc_code);
+}
+EXPORT_SYMBOL(ingenic_ecc_calculate);
+
+/**
+ * ingenic_ecc_correct() - detect and correct bit errors
+ * @ecc: ECC device.
+ * @params: ECC parameters.
+ * @buf: raw data read from the chip.
+ * @ecc_code: ECC read from the chip.
+ *
+ * Given the raw data and the ECC read from the NAND device, detects and
+ * corrects errors in the data.
+ *
+ * Return: the number of bit errors corrected, -EBADMSG if there are too many
+ * errors to correct or -ETIMEDOUT if we timed out waiting for the controller.
+ */
+int ingenic_ecc_correct(struct ingenic_ecc *ecc,
+			struct ingenic_ecc_params *params,
+			u8 *buf, u8 *ecc_code)
+{
+	return ecc->ops->correct(ecc, params, buf, ecc_code);
+}
+EXPORT_SYMBOL(ingenic_ecc_correct);
+
+/**
+ * ingenic_ecc_get() - get the ECC controller device
+ * @np: ECC device tree node.
+ *
+ * Gets the ECC controller device from the specified device tree node. The
+ * device must be released with ingenic_ecc_release() when it is no longer being
+ * used.
+ *
+ * Return: a pointer to ingenic_ecc, errors are encoded into the pointer.
+ * PTR_ERR(-EPROBE_DEFER) if the device hasn't been initialised yet.
+ */
+static struct ingenic_ecc *ingenic_ecc_get(struct device_node *np)
+{
+	struct platform_device *pdev;
+	struct ingenic_ecc *ecc;
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev || !platform_get_drvdata(pdev))
+		return ERR_PTR(-EPROBE_DEFER);
+
+	get_device(&pdev->dev);
+
+	ecc = platform_get_drvdata(pdev);
+	clk_prepare_enable(ecc->clk);
+
+	return ecc;
+}
+
+/**
+ * of_ingenic_ecc_get() - get the ECC controller from a DT node
+ * @of_node: the node that contains a bch-controller property.
+ *
+ * Get the bch-controller property from the given device tree
+ * node and pass it to ingenic_ecc_get to do the work.
+ *
+ * Return: a pointer to ingenic_ecc, errors are encoded into the pointer.
+ * PTR_ERR(-EPROBE_DEFER) if the device hasn't been initialised yet.
+ */
+struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *of_node)
+{
+	struct ingenic_ecc *ecc = NULL;
+	struct device_node *np;
+
+	np = of_parse_phandle(of_node, "ingenic,bch-controller", 0);
+
+	if (np) {
+		ecc = ingenic_ecc_get(np);
+		of_node_put(np);
+	}
+	return ecc;
+}
+EXPORT_SYMBOL(of_ingenic_ecc_get);
+
+/**
+ * ingenic_ecc_release() - release the ECC controller device
+ * @ecc: ECC device.
+ */
+void ingenic_ecc_release(struct ingenic_ecc *ecc)
+{
+	clk_disable_unprepare(ecc->clk);
+	put_device(ecc->dev);
+}
+EXPORT_SYMBOL(ingenic_ecc_release);
+
+int ingenic_ecc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ingenic_ecc *ecc;
+	struct resource *res;
+	int ret = 0;
+
+	ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
+	if (!ecc)
+		return -ENOMEM;
+
+	ecc->ops = device_get_match_data(dev);
+	if (!ecc->ops)
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ecc->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ecc->base))
+		return PTR_ERR(ecc->base);
+
+	ecc->ops->disable(ecc);
+
+	ecc->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(ecc->clk)) {
+		dev_err(dev, "failed to get clock: %ld\n", PTR_ERR(ecc->clk));
+		return PTR_ERR(ecc->clk);
+	}
+
+	mutex_init(&ecc->lock);
+
+	ecc->dev = dev;
+	platform_set_drvdata(pdev, ecc);
+
+	if (ecc->ops->probe)
+		ret = ecc->ops->probe(ecc);
+
+	return ret;
+}
+EXPORT_SYMBOL(ingenic_ecc_probe);
diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
new file mode 100644
index 000000000000..6dfb19f54c9b
--- /dev/null
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DRIVERS_MTD_NAND_INGENIC_ECC_INTERNAL_H__
+#define __DRIVERS_MTD_NAND_INGENIC_ECC_INTERNAL_H__
+
+#include <linux/compiler_types.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <uapi/asm-generic/errno-base.h>
+
+struct clk;
+struct device;
+struct ingenic_ecc;
+struct platform_device;
+
+/**
+ * struct ingenic_ecc_params - ECC parameters
+ * @size: data bytes per ECC step.
+ * @bytes: ECC bytes per step.
+ * @strength: number of correctable bits per ECC step.
+ */
+struct ingenic_ecc_params {
+	int size;
+	int bytes;
+	int strength;
+};
+
+#ifdef CONFIG_MTD_NAND_INGENIC_ECC
+int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
+			  struct ingenic_ecc_params *params,
+			  const u8 *buf, u8 *ecc_code);
+int ingenic_ecc_correct(struct ingenic_ecc *ecc,
+			struct ingenic_ecc_params *params, u8 *buf,
+			u8 *ecc_code);
+
+void ingenic_ecc_release(struct ingenic_ecc *ecc);
+struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *np);
+#else /* CONFIG_MTD_NAND_INGENIC_ECC */
+int ingenic_ecc_calculate(struct ingenic_ecc *ecc,
+			  struct ingenic_ecc_params *params,
+			  const u8 *buf, u8 *ecc_code)
+{
+	return -ENODEV;
+}
+
+int ingenic_ecc_correct(struct ingenic_ecc *ecc,
+			struct ingenic_ecc_params *params, u8 *buf,
+			u8 *ecc_code)
+{
+	return -ENODEV;
+}
+
+void ingenic_ecc_release(struct ingenic_ecc *ecc)
+{
+}
+
+struct ingenic_ecc *of_ingenic_ecc_get(struct device_node *np)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif /* CONFIG_MTD_NAND_INGENIC_ECC */
+
+struct ingenic_ecc_ops {
+	int (*probe)(struct ingenic_ecc *ecc);
+	void (*disable)(struct ingenic_ecc *ecc);
+	int (*calculate)(struct ingenic_ecc *ecc,
+			 struct ingenic_ecc_params *params,
+			 const u8 *buf, u8 *ecc_code);
+	int (*correct)(struct ingenic_ecc *ecc,
+			struct ingenic_ecc_params *params,
+			u8 *buf, u8 *ecc_code);
+};
+
+struct ingenic_ecc {
+	struct device *dev;
+	const struct ingenic_ecc_ops *ops;
+	void __iomem *base;
+	struct clk *clk;
+	struct mutex lock;
+};
+
+int ingenic_ecc_probe(struct platform_device *pdev);
+
+#endif /* __DRIVERS_MTD_NAND_INGENIC_ECC_INTERNAL_H__ */
diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
index 8c73f7c5be9a..0f51fd15fe79 100644
--- a/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
+++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand.c
@@ -22,7 +22,7 @@
 
 #include <linux/jz4780-nemc.h>
 
-#include "jz4780_bch.h"
+#include "ingenic_ecc.h"
 
 #define DRV_NAME	"ingenic-nand"
 
@@ -40,7 +40,7 @@ struct ingenic_nand_cs {
 
 struct ingenic_nfc {
 	struct device *dev;
-	struct jz4780_bch *bch;
+	struct ingenic_ecc *ecc;
 	struct nand_controller controller;
 	unsigned int num_banks;
 	struct list_head chips;
@@ -124,10 +124,10 @@ static int ingenic_nand_ecc_calculate(struct nand_chip *chip, const u8 *dat,
 {
 	struct ingenic_nand *nand = to_ingenic_nand(nand_to_mtd(chip));
 	struct ingenic_nfc *nfc = to_ingenic_nfc(nand->chip.controller);
-	struct jz4780_bch_params params;
+	struct ingenic_ecc_params params;
 
 	/*
-	 * Don't need to generate the ECC when reading, BCH does it for us as
+	 * Don't need to generate the ECC when reading, ECC does it for us as
 	 * part of decoding/correction.
 	 */
 	if (nand->reading)
@@ -137,7 +137,7 @@ static int ingenic_nand_ecc_calculate(struct nand_chip *chip, const u8 *dat,
 	params.bytes = nand->chip.ecc.bytes;
 	params.strength = nand->chip.ecc.strength;
 
-	return jz4780_bch_calculate(nfc->bch, &params, dat, ecc_code);
+	return ingenic_ecc_calculate(nfc->ecc, &params, dat, ecc_code);
 }
 
 static int ingenic_nand_ecc_correct(struct nand_chip *chip, u8 *dat,
@@ -145,13 +145,13 @@ static int ingenic_nand_ecc_correct(struct nand_chip *chip, u8 *dat,
 {
 	struct ingenic_nand *nand = to_ingenic_nand(nand_to_mtd(chip));
 	struct ingenic_nfc *nfc = to_ingenic_nfc(nand->chip.controller);
-	struct jz4780_bch_params params;
+	struct ingenic_ecc_params params;
 
 	params.size = nand->chip.ecc.size;
 	params.bytes = nand->chip.ecc.bytes;
 	params.strength = nand->chip.ecc.strength;
 
-	return jz4780_bch_correct(nfc->bch, &params, dat, read_ecc);
+	return ingenic_ecc_correct(nfc->ecc, &params, dat, read_ecc);
 }
 
 static int ingenic_nand_attach_chip(struct nand_chip *chip)
@@ -165,8 +165,8 @@ static int ingenic_nand_attach_chip(struct nand_chip *chip)
 
 	switch (chip->ecc.mode) {
 	case NAND_ECC_HW:
-		if (!nfc->bch) {
-			dev_err(nfc->dev, "HW BCH selected, but BCH controller not found\n");
+		if (!nfc->ecc) {
+			dev_err(nfc->dev, "HW ECC selected, but ECC controller not found\n");
 			return -ENODEV;
 		}
 
@@ -176,7 +176,7 @@ static int ingenic_nand_attach_chip(struct nand_chip *chip)
 		/* fall through */
 	case NAND_ECC_SOFT:
 		dev_info(nfc->dev, "using %s (strength %d, size %d, bytes %d)\n",
-			 (nfc->bch) ? "hardware BCH" : "software ECC",
+			 (nfc->ecc) ? "hardware ECC" : "software ECC",
 			 chip->ecc.strength, chip->ecc.size, chip->ecc.bytes);
 		break;
 	case NAND_ECC_NONE:
@@ -354,12 +354,12 @@ static int ingenic_nand_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/*
-	 * Check for BCH HW before we call nand_scan_ident, to prevent us from
-	 * having to call it again if the BCH driver returns -EPROBE_DEFER.
+	 * Check for ECC HW before we call nand_scan_ident, to prevent us from
+	 * having to call it again if the ECC driver returns -EPROBE_DEFER.
 	 */
-	nfc->bch = of_jz4780_bch_get(dev->of_node);
-	if (IS_ERR(nfc->bch))
-		return PTR_ERR(nfc->bch);
+	nfc->ecc = of_ingenic_ecc_get(dev->of_node);
+	if (IS_ERR(nfc->ecc))
+		return PTR_ERR(nfc->ecc);
 
 	nfc->dev = dev;
 	nfc->num_banks = num_banks;
@@ -369,8 +369,8 @@ static int ingenic_nand_probe(struct platform_device *pdev)
 
 	ret = ingenic_nand_init_chips(nfc, pdev);
 	if (ret) {
-		if (nfc->bch)
-			jz4780_bch_release(nfc->bch);
+		if (nfc->ecc)
+			ingenic_ecc_release(nfc->ecc);
 		return ret;
 	}
 
@@ -382,8 +382,8 @@ static int ingenic_nand_remove(struct platform_device *pdev)
 {
 	struct ingenic_nfc *nfc = platform_get_drvdata(pdev);
 
-	if (nfc->bch)
-		jz4780_bch_release(nfc->bch);
+	if (nfc->ecc)
+		ingenic_ecc_release(nfc->ecc);
 
 	ingenic_nand_cleanup_chips(nfc);
 
diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_bch.c b/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
index 7e4e5e627603..1e86a1037d62 100644
--- a/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
+++ b/drivers/mtd/nand/raw/ingenic/jz4780_bch.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * JZ4780 BCH controller
+ * JZ4780 BCH controller driver
  *
  * Copyright (c) 2015 Imagination Technologies
  * Author: Alex Smith <alex.smith@imgtec.com>
@@ -8,18 +8,15 @@
 
 #include <linux/bitops.h>
 #include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
-#include <linux/sched.h>
-#include <linux/slab.h>
 
-#include "jz4780_bch.h"
+#include "ingenic_ecc.h"
 
 #define BCH_BHCR			0x0
 #define BCH_BHCCR			0x8
@@ -62,15 +59,8 @@
 /* Timeout for BCH calculation/correction. */
 #define BCH_TIMEOUT_US			100000
 
-struct jz4780_bch {
-	struct device *dev;
-	void __iomem *base;
-	struct clk *clk;
-	struct mutex lock;
-};
-
-static void jz4780_bch_init(struct jz4780_bch *bch,
-			    struct jz4780_bch_params *params, bool encode)
+static void jz4780_bch_init(struct ingenic_ecc *bch,
+			    struct ingenic_ecc_params *params, bool encode)
 {
 	u32 reg;
 
@@ -90,13 +80,13 @@ static void jz4780_bch_init(struct jz4780_bch *bch,
 	writel(reg, bch->base + BCH_BHCR);
 }
 
-static void jz4780_bch_disable(struct jz4780_bch *bch)
+static void jz4780_bch_disable(struct ingenic_ecc *bch)
 {
 	writel(readl(bch->base + BCH_BHINT), bch->base + BCH_BHINT);
 	writel(BCH_BHCR_BCHE, bch->base + BCH_BHCCR);
 }
 
-static void jz4780_bch_write_data(struct jz4780_bch *bch, const void *buf,
+static void jz4780_bch_write_data(struct ingenic_ecc *bch, const void *buf,
 				  size_t size)
 {
 	size_t size32 = size / sizeof(u32);
@@ -113,7 +103,7 @@ static void jz4780_bch_write_data(struct jz4780_bch *bch, const void *buf,
 		writeb(*src8++, bch->base + BCH_BHDR);
 }
 
-static void jz4780_bch_read_parity(struct jz4780_bch *bch, void *buf,
+static void jz4780_bch_read_parity(struct ingenic_ecc *bch, void *buf,
 				   size_t size)
 {
 	size_t size32 = size / sizeof(u32);
@@ -143,7 +133,7 @@ static void jz4780_bch_read_parity(struct jz4780_bch *bch, void *buf,
 	}
 }
 
-static bool jz4780_bch_wait_complete(struct jz4780_bch *bch, unsigned int irq,
+static bool jz4780_bch_wait_complete(struct ingenic_ecc *bch, unsigned int irq,
 				     u32 *status)
 {
 	u32 reg;
@@ -167,18 +157,9 @@ static bool jz4780_bch_wait_complete(struct jz4780_bch *bch, unsigned int irq,
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
+static int jz4780_calculate(struct ingenic_ecc *bch,
+			    struct ingenic_ecc_params *params,
+			    const u8 *buf, u8 *ecc_code)
 {
 	int ret = 0;
 
@@ -197,23 +178,10 @@ int jz4780_bch_calculate(struct jz4780_bch *bch, struct jz4780_bch_params *param
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
+static int jz4780_correct(struct ingenic_ecc *bch,
+			  struct ingenic_ecc_params *params,
+			  u8 *buf, u8 *ecc_code)
 {
 	u32 reg, mask, index;
 	int i, ret, count;
@@ -259,113 +227,29 @@ int jz4780_bch_correct(struct jz4780_bch *bch, struct jz4780_bch_params *params,
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
-
-	np = of_parse_phandle(of_node, "ingenic,bch-controller", 0);
-
-	if (np) {
-		bch = jz4780_bch_get(np);
-		of_node_put(np);
-	}
-	return bch;
-}
-EXPORT_SYMBOL(of_jz4780_bch_get);
 
-/**
- * jz4780_bch_release() - release the BCH controller device
- * @bch: BCH device.
- */
-void jz4780_bch_release(struct jz4780_bch *bch)
+static int jz4780_bch_probe(struct ingenic_ecc *bch)
 {
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
 	clk_set_rate(bch->clk, BCH_CLK_RATE);
 
-	mutex_init(&bch->lock);
-
-	bch->dev = dev;
-	platform_set_drvdata(pdev, bch);
-
 	return 0;
 }
 
+static const struct ingenic_ecc_ops jz4780_bch_ops = {
+	.probe = jz4780_bch_probe,
+	.disable = jz4780_bch_disable,
+	.calculate = jz4780_calculate,
+	.correct = jz4780_correct,
+};
+
 static const struct of_device_id jz4780_bch_dt_match[] = {
-	{ .compatible = "ingenic,jz4780-bch" },
+	{ .compatible = "ingenic,jz4780-bch", .data = &jz4780_bch_ops },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4780_bch_dt_match);
 
 static struct platform_driver jz4780_bch_driver = {
-	.probe		= jz4780_bch_probe,
+	.probe		= ingenic_ecc_probe,
 	.driver	= {
 		.name	= "jz4780-bch",
 		.of_match_table = of_match_ptr(jz4780_bch_dt_match),
diff --git a/drivers/mtd/nand/raw/ingenic/jz4780_bch.h b/drivers/mtd/nand/raw/ingenic/jz4780_bch.h
deleted file mode 100644
index 451e0c770160..000000000000
--- a/drivers/mtd/nand/raw/ingenic/jz4780_bch.h
+++ /dev/null
@@ -1,40 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * JZ4780 BCH controller
- *
- * Copyright (c) 2015 Imagination Technologies
- * Author: Alex Smith <alex.smith@imgtec.com>
- */
-
-#ifndef __DRIVERS_MTD_NAND_JZ4780_BCH_H__
-#define __DRIVERS_MTD_NAND_JZ4780_BCH_H__
-
-#include <linux/types.h>
-
-struct device;
-struct device_node;
-struct jz4780_bch;
-
-/**
- * struct jz4780_bch_params - BCH parameters
- * @size: data bytes per ECC step.
- * @bytes: ECC bytes per step.
- * @strength: number of correctable bits per ECC step.
- */
-struct jz4780_bch_params {
-	int size;
-	int bytes;
-	int strength;
-};
-
-int jz4780_bch_calculate(struct jz4780_bch *bch,
-				struct jz4780_bch_params *params,
-				const u8 *buf, u8 *ecc_code);
-int jz4780_bch_correct(struct jz4780_bch *bch,
-			      struct jz4780_bch_params *params, u8 *buf,
-			      u8 *ecc_code);
-
-void jz4780_bch_release(struct jz4780_bch *bch);
-struct jz4780_bch *of_jz4780_bch_get(struct device_node *np);
-
-#endif /* __DRIVERS_MTD_NAND_JZ4780_BCH_H__ */
-- 
2.11.0

