Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A82DC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7D7223B6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A7D7223B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbeGCWCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:02:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53289 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933197AbeGCWBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:01:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6D2DC208FA; Wed,  4 Jul 2018 00:01:19 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 071AF20949;
        Wed,  4 Jul 2018 00:01:17 +0200 (CEST)
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
Subject: [PATCH v2 26/32] mtd: rawnand: atmel: convert driver to nand_scan()
Date:   Wed,  4 Jul 2018 00:00:23 +0200
Message-Id: <20180703220029.19565-27-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/atmel/nand-controller.c | 70 +++++++++++-----------------
 1 file changed, 27 insertions(+), 43 deletions(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index e686fe73159e..0b5695b3c8c1 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -202,7 +202,7 @@ struct atmel_nand_controller_ops {
 	int (*remove)(struct atmel_nand_controller *nc);
 	void (*nand_init)(struct atmel_nand_controller *nc,
 			  struct atmel_nand *nand);
-	int (*ecc_init)(struct atmel_nand *nand);
+	int (*ecc_init)(struct nand_chip *chip);
 	int (*setup_data_interface)(struct atmel_nand *nand, int csline,
 				    const struct nand_data_interface *conf);
 };
@@ -1133,9 +1133,8 @@ static int atmel_nand_pmecc_init(struct nand_chip *chip)
 	return 0;
 }
 
-static int atmel_nand_ecc_init(struct atmel_nand *nand)
+static int atmel_nand_ecc_init(struct nand_chip *chip)
 {
-	struct nand_chip *chip = &nand->base;
 	struct atmel_nand_controller *nc;
 	int ret;
 
@@ -1170,12 +1169,11 @@ static int atmel_nand_ecc_init(struct atmel_nand *nand)
 	return 0;
 }
 
-static int atmel_hsmc_nand_ecc_init(struct atmel_nand *nand)
+static int atmel_hsmc_nand_ecc_init(struct nand_chip *chip)
 {
-	struct nand_chip *chip = &nand->base;
 	int ret;
 
-	ret = atmel_nand_ecc_init(nand);
+	ret = atmel_nand_ecc_init(chip);
 	if (ret)
 		return ret;
 
@@ -1558,22 +1556,6 @@ static void atmel_hsmc_nand_init(struct atmel_nand_controller *nc,
 	chip->select_chip = atmel_hsmc_nand_select_chip;
 }
 
-static int atmel_nand_detect(struct atmel_nand *nand)
-{
-	struct nand_chip *chip = &nand->base;
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct atmel_nand_controller *nc;
-	int ret;
-
-	nc = to_nand_controller(chip->controller);
-
-	ret = nand_scan_ident(mtd, nand->numcs, NULL);
-	if (ret)
-		dev_err(nc->dev, "nand_scan_ident() failed: %d\n", ret);
-
-	return ret;
-}
-
 static int atmel_nand_unregister(struct atmel_nand *nand)
 {
 	struct nand_chip *chip = &nand->base;
@@ -1595,7 +1577,6 @@ static int atmel_nand_register(struct atmel_nand *nand)
 	struct nand_chip *chip = &nand->base;
 	struct mtd_info *mtd = nand_to_mtd(chip);
 	struct atmel_nand_controller *nc;
-	int ret;
 
 	nc = to_nand_controller(chip->controller);
 
@@ -1626,21 +1607,6 @@ static int atmel_nand_register(struct atmel_nand *nand)
 		}
 	}
 
-	ret = nand_scan_tail(mtd);
-	if (ret) {
-		dev_err(nc->dev, "nand_scan_tail() failed: %d\n", ret);
-		return ret;
-	}
-
-	ret = mtd_device_register(mtd, NULL, 0);
-	if (ret) {
-		dev_err(nc->dev, "Failed to register mtd device: %d\n", ret);
-		nand_cleanup(chip);
-		return ret;
-	}
-
-	list_add_tail(&nand->node, &nc->chips);
-
 	return 0;
 }
 
@@ -1755,6 +1721,8 @@ static int
 atmel_nand_controller_add_nand(struct atmel_nand_controller *nc,
 			       struct atmel_nand *nand)
 {
+	struct nand_chip *chip = &nand->base;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 	int ret;
 
 	/* No card inserted, skip this NAND. */
@@ -1765,15 +1733,31 @@ atmel_nand_controller_add_nand(struct atmel_nand_controller *nc,
 
 	nc->caps->ops->nand_init(nc, nand);
 
-	ret = atmel_nand_detect(nand);
-	if (ret)
+	chip->controller->attach_chip = nc->caps->ops->ecc_init;
+	ret = nand_scan(mtd, nand->numcs);
+	if (ret) {
+		dev_err(nc->dev, "NAND scan failed: %d\n", ret);
 		return ret;
+	}
 
-	ret = nc->caps->ops->ecc_init(nand);
+	ret = atmel_nand_register(nand);
 	if (ret)
-		return ret;
+		goto cleanup_nand;
+
+	ret = mtd_device_register(mtd, NULL, 0);
+	if (ret) {
+		dev_err(nc->dev, "Failed to register mtd device: %d\n", ret);
+		goto cleanup_nand;
+	}
+
+	list_add_tail(&nand->node, &nc->chips);
+
+	return 0;
+
+cleanup_nand:
+	nand_cleanup(chip);
 
-	return atmel_nand_register(nand);
+	return ret;
 }
 
 static int
-- 
2.14.1

