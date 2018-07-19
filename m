Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66962ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D52E20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D52E20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbeGSXq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:46:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54394 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730798AbeGSXq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:46:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 907692095C; Fri, 20 Jul 2018 01:01:40 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6B0DB2093C;
        Fri, 20 Jul 2018 01:01:09 +0200 (CEST)
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
Subject: [PATCH v3 21/33] mtd: rawnand: sunxi: convert driver to nand_scan()
Date:   Fri, 20 Jul 2018 01:00:14 +0200
Message-Id: <20180719230026.8741-22-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/sunxi_nand.c | 43 +++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 07f3ff9a28f2..de2bf752142b 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -1816,12 +1816,21 @@ static void sunxi_nand_ecc_cleanup(struct nand_ecc_ctrl *ecc)
 	}
 }
 
-static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
-			       struct device_node *np)
+static int sunxi_nand_attach_chip(struct nand_chip *nand)
 {
-	struct nand_chip *nand = mtd_to_nand(mtd);
+	struct mtd_info *mtd = nand_to_mtd(nand);
+	struct nand_ecc_ctrl *ecc = &nand->ecc;
+	struct device_node *np = nand_get_flash_node(nand);
 	int ret;
 
+	if (nand->bbt_options & NAND_BBT_USE_FLASH)
+		nand->bbt_options |= NAND_BBT_NO_OOB;
+
+	if (nand->options & NAND_NEED_SCRAMBLING)
+		nand->options |= NAND_NO_SUBPAGE_WRITE;
+
+	nand->options |= NAND_SUBPAGE_READ;
+
 	if (!ecc->size) {
 		ecc->size = nand->ecc_step_ds;
 		ecc->strength = nand->ecc_strength_ds;
@@ -1846,6 +1855,10 @@ static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
 	return 0;
 }
 
+static struct nand_controller_ops sunxi_nand_controller_ops = {
+	.attach_chip = sunxi_nand_attach_chip,
+};
+
 static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 				struct device_node *np)
 {
@@ -1911,6 +1924,8 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 	/* Default tR value specified in the ONFI spec (chapter 4.15.1) */
 	nand->chip_delay = 200;
 	nand->controller = &nfc->controller;
+	nand->controller->ops = &sunxi_nand_controller_ops;
+
 	/*
 	 * Set the ECC mode to the default value in case nothing is specified
 	 * in the DT.
@@ -1927,30 +1942,10 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
 	mtd = nand_to_mtd(nand);
 	mtd->dev.parent = dev;
 
-	ret = nand_scan_ident(mtd, nsels, NULL);
+	ret = nand_scan(mtd, nsels);
 	if (ret)
 		return ret;
 
-	if (nand->bbt_options & NAND_BBT_USE_FLASH)
-		nand->bbt_options |= NAND_BBT_NO_OOB;
-
-	if (nand->options & NAND_NEED_SCRAMBLING)
-		nand->options |= NAND_NO_SUBPAGE_WRITE;
-
-	nand->options |= NAND_SUBPAGE_READ;
-
-	ret = sunxi_nand_ecc_init(mtd, &nand->ecc, np);
-	if (ret) {
-		dev_err(dev, "ECC init failed: %d\n", ret);
-		return ret;
-	}
-
-	ret = nand_scan_tail(mtd);
-	if (ret) {
-		dev_err(dev, "nand_scan_tail failed: %d\n", ret);
-		return ret;
-	}
-
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
 		dev_err(dev, "failed to register mtd device: %d\n", ret);
-- 
2.14.1

