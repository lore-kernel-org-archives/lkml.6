Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F39C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEA8223B6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEA8223B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932821AbeGCWA7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:00:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53010 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932355AbeGCWA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:00:57 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4930520875; Wed,  4 Jul 2018 00:00:55 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6796F207DA;
        Wed,  4 Jul 2018 00:00:53 +0200 (CEST)
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
Subject: [PATCH v2 11/32] mtd: rawnand: jz4780: convert driver to nand_scan()
Date:   Wed,  4 Jul 2018 00:00:08 +0200
Message-Id: <20180703220029.19565-12-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180703220029.19565-1-miquel.raynal@bootlin.com>
References: <20180703220029.19565-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Harvey Hunt <harveyhuntnexus@gmail.com>
---
 drivers/mtd/nand/raw/jz4780_nand.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/nand/raw/jz4780_nand.c b/drivers/mtd/nand/raw/jz4780_nand.c
index e69f6ae4c539..dd8c2facdef5 100644
--- a/drivers/mtd/nand/raw/jz4780_nand.c
+++ b/drivers/mtd/nand/raw/jz4780_nand.c
@@ -157,9 +157,8 @@ static int jz4780_nand_ecc_correct(struct mtd_info *mtd, u8 *dat,
 	return jz4780_bch_correct(nfc->bch, &params, dat, read_ecc);
 }
 
-static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *dev)
+static int jz4780_nand_attach_chip(struct nand_chip *chip)
 {
-	struct nand_chip *chip = &nand->chip;
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct jz4780_nand_controller *nfc = to_jz4780_nand_controller(chip->controller);
 	int eccbytes;
@@ -170,7 +169,8 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
 	switch (chip->ecc.mode) {
 	case NAND_ECC_HW:
 		if (!nfc->bch) {
-			dev_err(dev, "HW BCH selected, but BCH controller not found\n");
+			dev_err(nfc->dev,
+				"HW BCH selected, but BCH controller not found\n");
 			return -ENODEV;
 		}
 
@@ -179,15 +179,16 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
 		chip->ecc.correct = jz4780_nand_ecc_correct;
 		/* fall through */
 	case NAND_ECC_SOFT:
-		dev_info(dev, "using %s (strength %d, size %d, bytes %d)\n",
-			(nfc->bch) ? "hardware BCH" : "software ECC",
-			chip->ecc.strength, chip->ecc.size, chip->ecc.bytes);
+		dev_info(nfc->dev, "using %s (strength %d, size %d, bytes %d)\n",
+			 (nfc->bch) ? "hardware BCH" : "software ECC",
+			 chip->ecc.strength, chip->ecc.size, chip->ecc.bytes);
 		break;
 	case NAND_ECC_NONE:
-		dev_info(dev, "not using ECC\n");
+		dev_info(nfc->dev, "not using ECC\n");
 		break;
 	default:
-		dev_err(dev, "ECC mode %d not supported\n", chip->ecc.mode);
+		dev_err(nfc->dev, "ECC mode %d not supported\n",
+			chip->ecc.mode);
 		return -EINVAL;
 	}
 
@@ -199,7 +200,7 @@ static int jz4780_nand_init_ecc(struct jz4780_nand_chip *nand, struct device *de
 	eccbytes = mtd->writesize / chip->ecc.size * chip->ecc.bytes;
 
 	if (eccbytes > mtd->oobsize - 2) {
-		dev_err(dev,
+		dev_err(nfc->dev,
 			"invalid ECC config: required %d ECC bytes, but only %d are available",
 			eccbytes, mtd->oobsize - 2);
 		return -EINVAL;
@@ -279,15 +280,8 @@ static int jz4780_nand_init_chip(struct platform_device *pdev,
 	chip->controller = &nfc->controller;
 	nand_set_flash_node(chip, np);
 
-	ret = nand_scan_ident(mtd, 1, NULL);
-	if (ret)
-		return ret;
-
-	ret = jz4780_nand_init_ecc(nand, dev);
-	if (ret)
-		return ret;
-
-	ret = nand_scan_tail(mtd);
+	chip->controller->attach_chip = jz4780_nand_attach_chip;
+	ret = nand_scan(mtd, 1);
 	if (ret)
 		return ret;
 
-- 
2.14.1

