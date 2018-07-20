Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BA2ECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EF2204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4EF2204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387954AbeGTQEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:04:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54215 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387775AbeGTQEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:04:35 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CE3DA20893; Fri, 20 Jul 2018 17:15:49 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 93F97208FF;
        Fri, 20 Jul 2018 17:15:32 +0200 (CEST)
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
Subject: [PATCH v4 07/35] mtd: rawnand: fsmc: convert driver to nand_scan()
Date:   Fri, 20 Jul 2018 17:14:59 +0200
Message-Id: <20180720151527.16038-8-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/fsmc_nand.c | 148 +++++++++++++++++++++------------------
 1 file changed, 78 insertions(+), 70 deletions(-)

diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 59524d181bfe..f418236fa020 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -919,6 +919,82 @@ static int fsmc_nand_probe_config_dt(struct platform_device *pdev,
 	return 0;
 }
 
+static int fsmc_nand_attach_chip(struct nand_chip *nand)
+{
+	struct mtd_info *mtd = nand_to_mtd(nand);
+	struct fsmc_nand_data *host = mtd_to_fsmc(mtd);
+
+	if (AMBA_REV_BITS(host->pid) >= 8) {
+		switch (mtd->oobsize) {
+		case 16:
+		case 64:
+		case 128:
+		case 224:
+		case 256:
+			break;
+		default:
+			dev_warn(host->dev,
+				 "No oob scheme defined for oobsize %d\n",
+				 mtd->oobsize);
+			return -EINVAL;
+		}
+
+		mtd_set_ooblayout(mtd, &fsmc_ecc4_ooblayout_ops);
+
+		return 0;
+	}
+
+	switch (nand->ecc.mode) {
+	case NAND_ECC_HW:
+		dev_info(host->dev, "Using 1-bit HW ECC scheme\n");
+		nand->ecc.calculate = fsmc_read_hwecc_ecc1;
+		nand->ecc.correct = nand_correct_data;
+		nand->ecc.bytes = 3;
+		nand->ecc.strength = 1;
+		break;
+
+	case NAND_ECC_SOFT:
+		if (nand->ecc.algo == NAND_ECC_BCH) {
+			dev_info(host->dev,
+				 "Using 4-bit SW BCH ECC scheme\n");
+			break;
+		}
+
+	case NAND_ECC_ON_DIE:
+		break;
+
+	default:
+		dev_err(host->dev, "Unsupported ECC mode!\n");
+		return -ENOTSUPP;
+	}
+
+	/*
+	 * Don't set layout for BCH4 SW ECC. This will be
+	 * generated later in nand_bch_init() later.
+	 */
+	if (nand->ecc.mode == NAND_ECC_HW) {
+		switch (mtd->oobsize) {
+		case 16:
+		case 64:
+		case 128:
+			mtd_set_ooblayout(mtd,
+					  &fsmc_ecc1_ooblayout_ops);
+			break;
+		default:
+			dev_warn(host->dev,
+				 "No oob scheme defined for oobsize %d\n",
+				 mtd->oobsize);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static const struct nand_controller_ops fsmc_nand_controller_ops = {
+	.attach_chip = fsmc_nand_attach_chip,
+};
+
 /*
  * fsmc_nand_probe - Probe function
  * @pdev:       platform device structure
@@ -1048,76 +1124,8 @@ static int __init fsmc_nand_probe(struct platform_device *pdev)
 	/*
 	 * Scan to find existence of the device
 	 */
-	ret = nand_scan_ident(mtd, 1, NULL);
-	if (ret) {
-		dev_err(&pdev->dev, "No NAND Device found!\n");
-		goto release_dma_write_chan;
-	}
-
-	if (AMBA_REV_BITS(host->pid) >= 8) {
-		switch (mtd->oobsize) {
-		case 16:
-		case 64:
-		case 128:
-		case 224:
-		case 256:
-			break;
-		default:
-			dev_warn(&pdev->dev, "No oob scheme defined for oobsize %d\n",
-				 mtd->oobsize);
-			ret = -EINVAL;
-			goto release_dma_write_chan;
-		}
-
-		mtd_set_ooblayout(mtd, &fsmc_ecc4_ooblayout_ops);
-	} else {
-		switch (nand->ecc.mode) {
-		case NAND_ECC_HW:
-			dev_info(&pdev->dev, "Using 1-bit HW ECC scheme\n");
-			nand->ecc.calculate = fsmc_read_hwecc_ecc1;
-			nand->ecc.correct = nand_correct_data;
-			nand->ecc.bytes = 3;
-			nand->ecc.strength = 1;
-			break;
-
-		case NAND_ECC_SOFT:
-			if (nand->ecc.algo == NAND_ECC_BCH) {
-				dev_info(&pdev->dev, "Using 4-bit SW BCH ECC scheme\n");
-				break;
-			}
-
-		case NAND_ECC_ON_DIE:
-			break;
-
-		default:
-			dev_err(&pdev->dev, "Unsupported ECC mode!\n");
-			goto release_dma_write_chan;
-		}
-
-		/*
-		 * Don't set layout for BCH4 SW ECC. This will be
-		 * generated later in nand_bch_init() later.
-		 */
-		if (nand->ecc.mode == NAND_ECC_HW) {
-			switch (mtd->oobsize) {
-			case 16:
-			case 64:
-			case 128:
-				mtd_set_ooblayout(mtd,
-						  &fsmc_ecc1_ooblayout_ops);
-				break;
-			default:
-				dev_warn(&pdev->dev,
-					 "No oob scheme defined for oobsize %d\n",
-					 mtd->oobsize);
-				ret = -EINVAL;
-				goto release_dma_write_chan;
-			}
-		}
-	}
-
-	/* Second stage of scan to fill MTD data-structures */
-	ret = nand_scan_tail(mtd);
+	nand->dummy_controller.ops = &fsmc_nand_controller_ops;
+	ret = nand_scan(mtd, 1);
 	if (ret)
 		goto release_dma_write_chan;
 
-- 
2.14.1

