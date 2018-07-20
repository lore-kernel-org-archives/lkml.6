Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E606ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9EA206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE9EA206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388249AbeGTQEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:04:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54567 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388058AbeGTQEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:04:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 94264209AD; Fri, 20 Jul 2018 17:16:00 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id E2EEE209AD;
        Fri, 20 Jul 2018 17:15:42 +0200 (CEST)
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
Subject: [PATCH v4 25/35] mtd: rawnand: vf610: convert driver to nand_scan()
Date:   Fri, 20 Jul 2018 17:15:17 +0200
Message-Id: <20180720151527.16038-26-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180720151527.16038-1-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/vf610_nfc.c | 127 ++++++++++++++++++++-------------------
 1 file changed, 66 insertions(+), 61 deletions(-)

diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf610_nfc.c
index d5a22fc96878..6f6dcbf9095b 100644
--- a/drivers/mtd/nand/raw/vf610_nfc.c
+++ b/drivers/mtd/nand/raw/vf610_nfc.c
@@ -747,6 +747,69 @@ static void vf610_nfc_init_controller(struct vf610_nfc *nfc)
 	}
 }
 
+static int vf610_nfc_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
+
+	vf610_nfc_init_controller(nfc);
+
+	/* Bad block options. */
+	if (chip->bbt_options & NAND_BBT_USE_FLASH)
+		chip->bbt_options |= NAND_BBT_NO_OOB;
+
+	/* Single buffer only, max 256 OOB minus ECC status */
+	if (mtd->writesize + mtd->oobsize > PAGE_2K + OOB_MAX - 8) {
+		dev_err(nfc->dev, "Unsupported flash page size\n");
+		return -ENXIO;
+	}
+
+	if (chip->ecc.mode != NAND_ECC_HW)
+		return 0;
+
+	if (mtd->writesize != PAGE_2K && mtd->oobsize < 64) {
+		dev_err(nfc->dev, "Unsupported flash with hwecc\n");
+		return -ENXIO;
+	}
+
+	if (chip->ecc.size != mtd->writesize) {
+		dev_err(nfc->dev, "Step size needs to be page size\n");
+		return -ENXIO;
+	}
+
+	/* Only 64 byte ECC layouts known */
+	if (mtd->oobsize > 64)
+		mtd->oobsize = 64;
+
+	/* Use default large page ECC layout defined in NAND core */
+	mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
+	if (chip->ecc.strength == 32) {
+		nfc->ecc_mode = ECC_60_BYTE;
+		chip->ecc.bytes = 60;
+	} else if (chip->ecc.strength == 24) {
+		nfc->ecc_mode = ECC_45_BYTE;
+		chip->ecc.bytes = 45;
+	} else {
+		dev_err(nfc->dev, "Unsupported ECC strength\n");
+		return -ENXIO;
+	}
+
+	chip->ecc.read_page = vf610_nfc_read_page;
+	chip->ecc.write_page = vf610_nfc_write_page;
+	chip->ecc.read_page_raw = vf610_nfc_read_page_raw;
+	chip->ecc.write_page_raw = vf610_nfc_write_page_raw;
+	chip->ecc.read_oob = vf610_nfc_read_oob;
+	chip->ecc.write_oob = vf610_nfc_write_oob;
+
+	chip->ecc.size = PAGE_2K;
+
+	return 0;
+}
+
+static const struct nand_controller_ops vf610_nfc_controller_ops = {
+	.attach_chip = vf610_nfc_attach_chip,
+};
+
 static int vf610_nfc_probe(struct platform_device *pdev)
 {
 	struct vf610_nfc *nfc;
@@ -827,67 +890,9 @@ static int vf610_nfc_probe(struct platform_device *pdev)
 
 	vf610_nfc_preinit_controller(nfc);
 
-	/* first scan to find the device and get the page size */
-	err = nand_scan_ident(mtd, 1, NULL);
-	if (err)
-		goto err_disable_clk;
-
-	vf610_nfc_init_controller(nfc);
-
-	/* Bad block options. */
-	if (chip->bbt_options & NAND_BBT_USE_FLASH)
-		chip->bbt_options |= NAND_BBT_NO_OOB;
-
-	/* Single buffer only, max 256 OOB minus ECC status */
-	if (mtd->writesize + mtd->oobsize > PAGE_2K + OOB_MAX - 8) {
-		dev_err(nfc->dev, "Unsupported flash page size\n");
-		err = -ENXIO;
-		goto err_disable_clk;
-	}
-
-	if (chip->ecc.mode == NAND_ECC_HW) {
-		if (mtd->writesize != PAGE_2K && mtd->oobsize < 64) {
-			dev_err(nfc->dev, "Unsupported flash with hwecc\n");
-			err = -ENXIO;
-			goto err_disable_clk;
-		}
-
-		if (chip->ecc.size != mtd->writesize) {
-			dev_err(nfc->dev, "Step size needs to be page size\n");
-			err = -ENXIO;
-			goto err_disable_clk;
-		}
-
-		/* Only 64 byte ECC layouts known */
-		if (mtd->oobsize > 64)
-			mtd->oobsize = 64;
-
-		/* Use default large page ECC layout defined in NAND core */
-		mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
-		if (chip->ecc.strength == 32) {
-			nfc->ecc_mode = ECC_60_BYTE;
-			chip->ecc.bytes = 60;
-		} else if (chip->ecc.strength == 24) {
-			nfc->ecc_mode = ECC_45_BYTE;
-			chip->ecc.bytes = 45;
-		} else {
-			dev_err(nfc->dev, "Unsupported ECC strength\n");
-			err = -ENXIO;
-			goto err_disable_clk;
-		}
-
-		chip->ecc.read_page = vf610_nfc_read_page;
-		chip->ecc.write_page = vf610_nfc_write_page;
-		chip->ecc.read_page_raw = vf610_nfc_read_page_raw;
-		chip->ecc.write_page_raw = vf610_nfc_write_page_raw;
-		chip->ecc.read_oob = vf610_nfc_read_oob;
-		chip->ecc.write_oob = vf610_nfc_write_oob;
-
-		chip->ecc.size = PAGE_2K;
-	}
-
-	/* second phase scan */
-	err = nand_scan_tail(mtd);
+	/* Scan the NAND chip */
+	chip->dummy_controller.ops = &vf610_nfc_controller_ops;
+	err = nand_scan(mtd, 1);
 	if (err)
 		goto err_disable_clk;
 
-- 
2.14.1

