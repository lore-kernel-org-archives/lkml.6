Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB13ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D514020684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D514020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbeGSXqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:46:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54244 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731668AbeGSXqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:46:15 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 68A1420994; Fri, 20 Jul 2018 01:00:58 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id F2AB42095C;
        Fri, 20 Jul 2018 01:00:56 +0200 (CEST)
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
Subject: [PATCH v3 14/33] mtd: rawnand: mtk: convert driver to nand_scan()
Date:   Fri, 20 Jul 2018 01:00:07 +0200
Message-Id: <20180719230026.8741-15-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/mtk_nand.c | 75 ++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index 7bc6be3f6ec0..4376adc433a6 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -1250,13 +1250,54 @@ static int mtk_nfc_ecc_init(struct device *dev, struct mtd_info *mtd)
 	return 0;
 }
 
+static int mtk_nfc_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct device *dev = mtd->dev.parent;
+	struct mtk_nfc *nfc = nand_get_controller_data(chip);
+	struct mtk_nfc_nand_chip *mtk_nand = to_mtk_nand(chip);
+	int len;
+	int ret;
+
+	if (chip->options & NAND_BUSWIDTH_16) {
+		dev_err(dev, "16bits buswidth not supported");
+		return -EINVAL;
+	}
+
+	/* store bbt magic in page, cause OOB is not protected */
+	if (chip->bbt_options & NAND_BBT_USE_FLASH)
+		chip->bbt_options |= NAND_BBT_NO_OOB;
+
+	ret = mtk_nfc_ecc_init(dev, mtd);
+	if (ret)
+		return ret;
+
+	ret = mtk_nfc_set_spare_per_sector(&mtk_nand->spare_per_sector, mtd);
+	if (ret)
+		return ret;
+
+	mtk_nfc_set_fdm(&mtk_nand->fdm, mtd);
+	mtk_nfc_set_bad_mark_ctl(&mtk_nand->bad_mark, mtd);
+
+	len = mtd->writesize + mtd->oobsize;
+	nfc->buffer = devm_kzalloc(dev, len, GFP_KERNEL);
+	if (!nfc->buffer)
+		return  -ENOMEM;
+
+	return 0;
+}
+
+static struct nand_controller_ops mtk_nfc_controller_ops = {
+	.attach_chip = mtk_nfc_attach_chip,
+};
+
 static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
 				  struct device_node *np)
 {
 	struct mtk_nfc_nand_chip *chip;
 	struct nand_chip *nand;
 	struct mtd_info *mtd;
-	int nsels, len;
+	int nsels;
 	u32 tmp;
 	int ret;
 	int i;
@@ -1287,6 +1328,7 @@ static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
 
 	nand = &chip->nand;
 	nand->controller = &nfc->controller;
+	nand->controller->ops = &mtk_nfc_controller_ops;
 
 	nand_set_flash_node(nand, np);
 	nand_set_controller_data(nand, nfc);
@@ -1324,36 +1366,7 @@ static int mtk_nfc_nand_chip_init(struct device *dev, struct mtk_nfc *nfc,
 
 	mtk_nfc_hw_init(nfc);
 
-	ret = nand_scan_ident(mtd, nsels, NULL);
-	if (ret)
-		return ret;
-
-	/* store bbt magic in page, cause OOB is not protected */
-	if (nand->bbt_options & NAND_BBT_USE_FLASH)
-		nand->bbt_options |= NAND_BBT_NO_OOB;
-
-	ret = mtk_nfc_ecc_init(dev, mtd);
-	if (ret)
-		return -EINVAL;
-
-	if (nand->options & NAND_BUSWIDTH_16) {
-		dev_err(dev, "16bits buswidth not supported");
-		return -EINVAL;
-	}
-
-	ret = mtk_nfc_set_spare_per_sector(&chip->spare_per_sector, mtd);
-	if (ret)
-		return ret;
-
-	mtk_nfc_set_fdm(&chip->fdm, mtd);
-	mtk_nfc_set_bad_mark_ctl(&chip->bad_mark, mtd);
-
-	len = mtd->writesize + mtd->oobsize;
-	nfc->buffer = devm_kzalloc(dev, len, GFP_KERNEL);
-	if (!nfc->buffer)
-		return  -ENOMEM;
-
-	ret = nand_scan_tail(mtd);
+	ret = nand_scan(mtd, nsels);
 	if (ret)
 		return ret;
 
-- 
2.14.1

