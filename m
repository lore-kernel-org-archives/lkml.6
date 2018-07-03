Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248A1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE770223B6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE770223B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753389AbeGCWCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:02:01 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53361 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933259AbeGCWB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:01:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 424492093F; Wed,  4 Jul 2018 00:01:25 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id C7CEA2093C;
        Wed,  4 Jul 2018 00:01:23 +0200 (CEST)
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
Subject: [PATCH v2 30/32] mtd: rawnand: jz4740: convert driver to nand_scan()
Date:   Wed,  4 Jul 2018 00:00:27 +0200
Message-Id: <20180703220029.19565-31-miquel.raynal@bootlin.com>
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
---
 drivers/mtd/nand/raw/jz4740_nand.c | 42 +++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/raw/jz4740_nand.c b/drivers/mtd/nand/raw/jz4740_nand.c
index 613b00a9604b..2e95b618dc47 100644
--- a/drivers/mtd/nand/raw/jz4740_nand.c
+++ b/drivers/mtd/nand/raw/jz4740_nand.c
@@ -59,6 +59,7 @@
 
 struct jz_nand {
 	struct nand_chip chip;
+	struct platform_device *pdev;
 	void __iomem *base;
 	struct resource *mem;
 
@@ -329,8 +330,8 @@ static int jz_nand_detect_bank(struct platform_device *pdev,
 	writel(ctrl, nand->base + JZ_REG_NAND_CTRL);
 
 	if (chipnr == 0) {
-		/* Detect first chip. */
-		ret = nand_scan_ident(mtd, 1, NULL);
+		/* Detect the first chip and register it */
+		ret = nand_scan(mtd, 1);
 		if (ret)
 			goto notfound_id;
 
@@ -367,6 +368,21 @@ static int jz_nand_detect_bank(struct platform_device *pdev,
 	return ret;
 }
 
+static int jz_nand_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct jz_nand *nand = mtd_to_jz_nand(mtd);
+	struct device *dev = mtd->dev.parent;
+	struct jz_nand_platform_data *pdata = dev_get_platdata(dev);
+
+	if (pdata && pdata->ident_callback) {
+		pdata->ident_callback(nand->pdev, mtd, &pdata->partitions,
+				      &pdata->num_partitions);
+	}
+
+	return 0;
+}
+
 static int jz_nand_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -397,6 +413,7 @@ static int jz_nand_probe(struct platform_device *pdev)
 	mtd		= nand_to_mtd(chip);
 	mtd->dev.parent = &pdev->dev;
 	mtd->name	= "jz4740-nand";
+	nand->pdev	= pdev;
 
 	chip->ecc.hwctl		= jz_nand_hwctl;
 	chip->ecc.calculate	= jz_nand_calculate_ecc_rs;
@@ -410,6 +427,7 @@ static int jz_nand_probe(struct platform_device *pdev)
 	chip->chip_delay = 50;
 	chip->cmd_ctrl = jz_nand_cmd_ctrl;
 	chip->select_chip = jz_nand_select_chip;
+	chip->hwcontrol.attach_chip = jz_nand_attach_chip;
 
 	if (nand->busy_gpio)
 		chip->dev_ready = jz_nand_dev_ready;
@@ -450,20 +468,10 @@ static int jz_nand_probe(struct platform_device *pdev)
 		else
 			nand->banks[chipnr] = 0;
 	}
+
 	if (chipnr == 0) {
 		dev_err(&pdev->dev, "No NAND chips found\n");
-		goto err_iounmap_mmio;
-	}
-
-	if (pdata && pdata->ident_callback) {
-		pdata->ident_callback(pdev, mtd, &pdata->partitions,
-					&pdata->num_partitions);
-	}
-
-	ret = nand_scan_tail(mtd);
-	if (ret) {
-		dev_err(&pdev->dev,  "Failed to scan NAND\n");
-		goto err_unclaim_banks;
+		goto err_nand_release;
 	}
 
 	ret = mtd_device_parse_register(mtd, NULL, NULL,
@@ -472,15 +480,13 @@ static int jz_nand_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to add mtd device\n");
-		goto err_nand_release;
+		goto err_unclaim_banks;
 	}
 
 	dev_info(&pdev->dev, "Successfully registered JZ4740 NAND driver\n");
 
 	return 0;
 
-err_nand_release:
-	nand_release(mtd);
 err_unclaim_banks:
 	while (chipnr--) {
 		unsigned char bank = nand->banks[chipnr];
@@ -488,6 +494,8 @@ static int jz_nand_probe(struct platform_device *pdev)
 					 nand->bank_base[bank - 1]);
 	}
 	writel(0, nand->base + JZ_REG_NAND_CTRL);
+err_nand_release:
+	nand_release(mtd);
 err_iounmap_mmio:
 	jz_nand_iounmap_resource(nand->mem, nand->base);
 err_free:
-- 
2.14.1

