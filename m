Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B8FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3E720855
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3E720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933667AbeGCWF3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:05:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53048 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932831AbeGCWBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:01:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C87BA208C5; Wed,  4 Jul 2018 00:01:00 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 57F51208B3;
        Wed,  4 Jul 2018 00:00:59 +0200 (CEST)
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
Subject: [PATCH v2 13/32] mtd: rawnand: lpc32xx_slc: convert driver to nand_scan()
Date:   Wed,  4 Jul 2018 00:00:10 +0200
Message-Id: <20180703220029.19565-14-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/lpc32xx_slc.c | 73 ++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 42820aa1abab..c31efac1f9f5 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -779,6 +779,42 @@ static struct lpc32xx_nand_cfg_slc *lpc32xx_parse_dt(struct device *dev)
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
 /*
  * Probe for NAND controller
  */
@@ -884,41 +920,8 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
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
+	chip->hwcontrol.attach_chip = lpc32xx_nand_attach_chip;
+	res = nand_scan(mtd, 1);
 	if (res)
 		goto release_dma;
 
-- 
2.14.1

