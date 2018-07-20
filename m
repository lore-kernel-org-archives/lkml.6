Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCFAECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA59B204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:15:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA59B204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbeGTQEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:04:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54290 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387933AbeGTQEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:04:37 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1889920935; Fri, 20 Jul 2018 17:15:51 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6DE7B2093A;
        Fri, 20 Jul 2018 17:15:35 +0200 (CEST)
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
Subject: [PATCH v4 12/35] mtd: rawnand: lpc32xx_slc: convert driver to nand_scan()
Date:   Fri, 20 Jul 2018 17:15:04 +0200
Message-Id: <20180720151527.16038-13-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/lpc32xx_slc.c | 77 +++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 42820aa1abab..a4e8b7e75135 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -779,6 +779,46 @@ static struct lpc32xx_nand_cfg_slc *lpc32xx_parse_dt(struct device *dev)
 	return ncfg;
 }
 
+static int lpc32xx_nand_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
+
+	/* OOB and ECC CPU and DMA work areas */
+	host->ecc_buf = (uint32_t *)(host->data_buf + LPC32XX_DMA_DATA_SIZE);
+
+	/*
+	 * Small page FLASH has a unique OOB layout, but large and huge
+	 * page FLASH use the standard layout. Small page FLASH uses a
+	 * custom BBT marker layout.
+	 */
+	if (mtd->writesize <= 512)
+		mtd_set_ooblayout(mtd, &lpc32xx_ooblayout_ops);
+
+	/* These sizes remain the same regardless of page size */
+	chip->ecc.size = 256;
+	chip->ecc.bytes = LPC32XX_SLC_DEV_ECC_BYTES;
+	chip->ecc.prepad = 0;
+	chip->ecc.postpad = 0;
+
+	/*
+	 * Use a custom BBT marker setup for small page FLASH that
+	 * won't interfere with the ECC layout. Large and huge page
+	 * FLASH use the standard layout.
+	 */
+	if ((chip->bbt_options & NAND_BBT_USE_FLASH) &&
+	    mtd->writesize <= 512) {
+		chip->bbt_td = &bbt_smallpage_main_descr;
+		chip->bbt_md = &bbt_smallpage_mirror_descr;
+	}
+
+	return 0;
+}
+
+static const struct nand_controller_ops lpc32xx_nand_controller_ops = {
+	.attach_chip = lpc32xx_nand_attach_chip,
+};
+
 /*
  * Probe for NAND controller
  */
@@ -884,41 +924,8 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	}
 
 	/* Find NAND device */
-	res = nand_scan_ident(mtd, 1, NULL);
-	if (res)
-		goto release_dma;
-
-	/* OOB and ECC CPU and DMA work areas */
-	host->ecc_buf = (uint32_t *)(host->data_buf + LPC32XX_DMA_DATA_SIZE);
-
-	/*
-	 * Small page FLASH has a unique OOB layout, but large and huge
-	 * page FLASH use the standard layout. Small page FLASH uses a
-	 * custom BBT marker layout.
-	 */
-	if (mtd->writesize <= 512)
-		mtd_set_ooblayout(mtd, &lpc32xx_ooblayout_ops);
-
-	/* These sizes remain the same regardless of page size */
-	chip->ecc.size = 256;
-	chip->ecc.bytes = LPC32XX_SLC_DEV_ECC_BYTES;
-	chip->ecc.prepad = chip->ecc.postpad = 0;
-
-	/*
-	 * Use a custom BBT marker setup for small page FLASH that
-	 * won't interfere with the ECC layout. Large and huge page
-	 * FLASH use the standard layout.
-	 */
-	if ((chip->bbt_options & NAND_BBT_USE_FLASH) &&
-	    mtd->writesize <= 512) {
-		chip->bbt_td = &bbt_smallpage_main_descr;
-		chip->bbt_md = &bbt_smallpage_mirror_descr;
-	}
-
-	/*
-	 * Fills out all the uninitialized function pointers with the defaults
-	 */
-	res = nand_scan_tail(mtd);
+	chip->dummy_controller.ops = &lpc32xx_nand_controller_ops;
+	res = nand_scan(mtd, 1);
 	if (res)
 		goto release_dma;
 
-- 
2.14.1

