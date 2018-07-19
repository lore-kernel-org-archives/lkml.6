Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF42ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0655020684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0655020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731974AbeGSXrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:47:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54599 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731925AbeGSXrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:47:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B6070209C0; Fri, 20 Jul 2018 01:01:53 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 67BE7209CA;
        Fri, 20 Jul 2018 01:01:25 +0200 (CEST)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Wenyou Yang <wenyou.yang@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Han Xu <han.xu@nxp.com>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Stefan Agner <stefan@agner.ch>
Cc:     linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 31/33] mtd: rawnand: tegra: convert driver to nand_scan()
Date:   Fri, 20 Jul 2018 01:00:24 +0200
Message-Id: <20180719230026.8741-32-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180719230026.8741-1-miquel.raynal@bootlin.com>
References: <20180719230026.8741-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/tegra_nand.c | 162 +++++++++++++++++++++-----------------
 1 file changed, 88 insertions(+), 74 deletions(-)

diff --git a/drivers/mtd/nand/raw/tegra_nand.c b/drivers/mtd/nand/raw/tegra_nand.c
index 31c0d9ca9d23..c40a53066cee 100644
--- a/drivers/mtd/nand/raw/tegra_nand.c
+++ b/drivers/mtd/nand/raw/tegra_nand.c
@@ -906,74 +906,13 @@ static int tegra_nand_select_strength(struct nand_chip *chip, int oobsize)
 				       bits_per_step, oobsize);
 }
 
-static int tegra_nand_chips_init(struct device *dev,
-				 struct tegra_nand_controller *ctrl)
+static int tegra_nand_attach_chip(struct nand_chip *chip)
 {
-	struct device_node *np = dev->of_node;
-	struct device_node *np_nand;
-	int nsels, nchips = of_get_child_count(np);
-	struct tegra_nand_chip *nand;
-	struct mtd_info *mtd;
-	struct nand_chip *chip;
+	struct tegra_nand_controller *ctrl = to_tegra_ctrl(chip->controller);
+	struct tegra_nand_chip *nand = to_tegra_chip(chip);
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int bits_per_step;
 	int ret;
-	u32 cs;
-
-	if (nchips != 1) {
-		dev_err(dev, "Currently only one NAND chip supported\n");
-		return -EINVAL;
-	}
-
-	np_nand = of_get_next_child(np, NULL);
-
-	nsels = of_property_count_elems_of_size(np_nand, "reg", sizeof(u32));
-	if (nsels != 1) {
-		dev_err(dev, "Missing/invalid reg property\n");
-		return -EINVAL;
-	}
-
-	/* Retrieve CS id, currently only single die NAND supported */
-	ret = of_property_read_u32(np_nand, "reg", &cs);
-	if (ret) {
-		dev_err(dev, "could not retrieve reg property: %d\n", ret);
-		return ret;
-	}
-
-	nand = devm_kzalloc(dev, sizeof(*nand), GFP_KERNEL);
-	if (!nand)
-		return -ENOMEM;
-
-	nand->cs[0] = cs;
-
-	nand->wp_gpio = devm_gpiod_get_optional(dev, "wp", GPIOD_OUT_LOW);
-
-	if (IS_ERR(nand->wp_gpio)) {
-		ret = PTR_ERR(nand->wp_gpio);
-		dev_err(dev, "Failed to request WP GPIO: %d\n", ret);
-		return ret;
-	}
-
-	chip = &nand->chip;
-	chip->controller = &ctrl->controller;
-
-	mtd = nand_to_mtd(chip);
-
-	mtd->dev.parent = dev;
-	mtd->owner = THIS_MODULE;
-
-	nand_set_flash_node(chip, np_nand);
-
-	if (!mtd->name)
-		mtd->name = "tegra_nand";
-
-	chip->options = NAND_NO_SUBPAGE_WRITE | NAND_USE_BOUNCE_BUFFER;
-	chip->exec_op = tegra_nand_exec_op;
-	chip->select_chip = tegra_nand_select_chip;
-	chip->setup_data_interface = tegra_nand_setup_data_interface;
-
-	ret = nand_scan_ident(mtd, 1, NULL);
-	if (ret)
-		return ret;
 
 	if (chip->bbt_options & NAND_BBT_USE_FLASH)
 		chip->bbt_options |= NAND_BBT_NO_OOB;
@@ -982,7 +921,8 @@ static int tegra_nand_chips_init(struct device *dev,
 	chip->ecc.size = 512;
 	chip->ecc.steps = mtd->writesize / chip->ecc.size;
 	if (chip->ecc_step_ds != 512) {
-		dev_err(dev, "Unsupported step size %d\n", chip->ecc_step_ds);
+		dev_err(ctrl->dev, "Unsupported step size %d\n",
+			chip->ecc_step_ds);
 		return -EINVAL;
 	}
 
@@ -1004,14 +944,15 @@ static int tegra_nand_chips_init(struct device *dev,
 	}
 
 	if (chip->ecc.algo == NAND_ECC_BCH && mtd->writesize < 2048) {
-		dev_err(dev, "BCH supports 2K or 4K page size only\n");
+		dev_err(ctrl->dev, "BCH supports 2K or 4K page size only\n");
 		return -EINVAL;
 	}
 
 	if (!chip->ecc.strength) {
 		ret = tegra_nand_select_strength(chip, mtd->oobsize);
 		if (ret < 0) {
-			dev_err(dev, "No valid strength found, minimum %d\n",
+			dev_err(ctrl->dev,
+				"No valid strength found, minimum %d\n",
 				chip->ecc_strength_ds);
 			return ret;
 		}
@@ -1039,7 +980,7 @@ static int tegra_nand_chips_init(struct device *dev,
 			nand->config_ecc |= CONFIG_TVAL_8;
 			break;
 		default:
-			dev_err(dev, "ECC strength %d not supported\n",
+			dev_err(ctrl->dev, "ECC strength %d not supported\n",
 				chip->ecc.strength);
 			return -EINVAL;
 		}
@@ -1062,17 +1003,17 @@ static int tegra_nand_chips_init(struct device *dev,
 			nand->bch_config |= BCH_TVAL_16;
 			break;
 		default:
-			dev_err(dev, "ECC strength %d not supported\n",
+			dev_err(ctrl->dev, "ECC strength %d not supported\n",
 				chip->ecc.strength);
 			return -EINVAL;
 		}
 		break;
 	default:
-		dev_err(dev, "ECC algorithm not supported\n");
+		dev_err(ctrl->dev, "ECC algorithm not supported\n");
 		return -EINVAL;
 	}
 
-	dev_info(dev, "Using %s with strength %d per 512 byte step\n",
+	dev_info(ctrl->dev, "Using %s with strength %d per 512 byte step\n",
 		 chip->ecc.algo == NAND_ECC_BCH ? "BCH" : "RS",
 		 chip->ecc.strength);
 
@@ -1095,7 +1036,8 @@ static int tegra_nand_chips_init(struct device *dev,
 		nand->config |= CONFIG_PS_4096;
 		break;
 	default:
-		dev_err(dev, "Unsupported writesize %d\n", mtd->writesize);
+		dev_err(ctrl->dev, "Unsupported writesize %d\n",
+			mtd->writesize);
 		return -ENODEV;
 	}
 
@@ -1106,7 +1048,79 @@ static int tegra_nand_chips_init(struct device *dev,
 	nand->config |= CONFIG_TAG_BYTE_SIZE(mtd->oobsize - 1);
 	writel_relaxed(nand->config, ctrl->regs + CONFIG);
 
-	ret = nand_scan_tail(mtd);
+	return 0;
+}
+
+static const struct nand_controller_ops tegra_nand_controller_ops = {
+	.attach_chip = &tegra_nand_attach_chip,
+};
+
+static int tegra_nand_chips_init(struct device *dev,
+				 struct tegra_nand_controller *ctrl)
+{
+	struct device_node *np = dev->of_node;
+	struct device_node *np_nand;
+	int nsels, nchips = of_get_child_count(np);
+	struct tegra_nand_chip *nand;
+	struct mtd_info *mtd;
+	struct nand_chip *chip;
+	int ret;
+	u32 cs;
+
+	if (nchips != 1) {
+		dev_err(dev, "Currently only one NAND chip supported\n");
+		return -EINVAL;
+	}
+
+	np_nand = of_get_next_child(np, NULL);
+
+	nsels = of_property_count_elems_of_size(np_nand, "reg", sizeof(u32));
+	if (nsels != 1) {
+		dev_err(dev, "Missing/invalid reg property\n");
+		return -EINVAL;
+	}
+
+	/* Retrieve CS id, currently only single die NAND supported */
+	ret = of_property_read_u32(np_nand, "reg", &cs);
+	if (ret) {
+		dev_err(dev, "could not retrieve reg property: %d\n", ret);
+		return ret;
+	}
+
+	nand = devm_kzalloc(dev, sizeof(*nand), GFP_KERNEL);
+	if (!nand)
+		return -ENOMEM;
+
+	nand->cs[0] = cs;
+
+	nand->wp_gpio = devm_gpiod_get_optional(dev, "wp", GPIOD_OUT_LOW);
+
+	if (IS_ERR(nand->wp_gpio)) {
+		ret = PTR_ERR(nand->wp_gpio);
+		dev_err(dev, "Failed to request WP GPIO: %d\n", ret);
+		return ret;
+	}
+
+	chip = &nand->chip;
+	chip->controller = &ctrl->controller;
+	chip->controller->ops = &tegra_nand_controller_ops;
+
+	mtd = nand_to_mtd(chip);
+
+	mtd->dev.parent = dev;
+	mtd->owner = THIS_MODULE;
+
+	nand_set_flash_node(chip, np_nand);
+
+	if (!mtd->name)
+		mtd->name = "tegra_nand";
+
+	chip->options = NAND_NO_SUBPAGE_WRITE | NAND_USE_BOUNCE_BUFFER;
+	chip->exec_op = tegra_nand_exec_op;
+	chip->select_chip = tegra_nand_select_chip;
+	chip->setup_data_interface = tegra_nand_setup_data_interface;
+
+	ret = nand_scan(mtd, 1);
 	if (ret)
 		return ret;
 
-- 
2.14.1

