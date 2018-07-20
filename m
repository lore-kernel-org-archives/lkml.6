Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD5AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D599F204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D599F204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbeGTQEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:04:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54328 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387962AbeGTQEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:04:37 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A7BB120943; Fri, 20 Jul 2018 17:15:51 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-78-122.w90-88.abo.wanadoo.fr [90.88.20.122])
        by mail.bootlin.com (Postfix) with ESMTPSA id 053032093C;
        Fri, 20 Jul 2018 17:15:36 +0200 (CEST)
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
Subject: [PATCH v4 13/35] mtd: rawnand: marvell: convert driver to nand_scan()
Date:   Fri, 20 Jul 2018 17:15:05 +0200
Message-Id: <20180720151527.16038-14-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/marvell_nand.c | 205 +++++++++++++++++++-----------------
 1 file changed, 108 insertions(+), 97 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index bd5f9a4b7b16..7e5ffef0da76 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2290,6 +2290,111 @@ static int marvell_nfc_setup_data_interface(struct mtd_info *mtd, int chipnr,
 	return 0;
 }
 
+static int marvell_nand_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct marvell_nand_chip *marvell_nand = to_marvell_nand(chip);
+	struct marvell_nfc *nfc = to_marvell_nfc(chip->controller);
+	struct pxa3xx_nand_platform_data *pdata = dev_get_platdata(nfc->dev);
+	int ret;
+
+	if (pdata && pdata->flash_bbt)
+		chip->bbt_options |= NAND_BBT_USE_FLASH;
+
+	if (chip->bbt_options & NAND_BBT_USE_FLASH) {
+		/*
+		 * We'll use a bad block table stored in-flash and don't
+		 * allow writing the bad block marker to the flash.
+		 */
+		chip->bbt_options |= NAND_BBT_NO_OOB_BBM;
+		chip->bbt_td = &bbt_main_descr;
+		chip->bbt_md = &bbt_mirror_descr;
+	}
+
+	/* Save the chip-specific fields of NDCR */
+	marvell_nand->ndcr = NDCR_PAGE_SZ(mtd->writesize);
+	if (chip->options & NAND_BUSWIDTH_16)
+		marvell_nand->ndcr |= NDCR_DWIDTH_M | NDCR_DWIDTH_C;
+
+	/*
+	 * On small page NANDs, only one cycle is needed to pass the
+	 * column address.
+	 */
+	if (mtd->writesize <= 512) {
+		marvell_nand->addr_cyc = 1;
+	} else {
+		marvell_nand->addr_cyc = 2;
+		marvell_nand->ndcr |= NDCR_RA_START;
+	}
+
+	/*
+	 * Now add the number of cycles needed to pass the row
+	 * address.
+	 *
+	 * Addressing a chip using CS 2 or 3 should also need the third row
+	 * cycle but due to inconsistance in the documentation and lack of
+	 * hardware to test this situation, this case is not supported.
+	 */
+	if (chip->options & NAND_ROW_ADDR_3)
+		marvell_nand->addr_cyc += 3;
+	else
+		marvell_nand->addr_cyc += 2;
+
+	if (pdata) {
+		chip->ecc.size = pdata->ecc_step_size;
+		chip->ecc.strength = pdata->ecc_strength;
+	}
+
+	ret = marvell_nand_ecc_init(mtd, &chip->ecc);
+	if (ret) {
+		dev_err(nfc->dev, "ECC init failed: %d\n", ret);
+		return ret;
+	}
+
+	if (chip->ecc.mode == NAND_ECC_HW) {
+		/*
+		 * Subpage write not available with hardware ECC, prohibit also
+		 * subpage read as in userspace subpage access would still be
+		 * allowed and subpage write, if used, would lead to numerous
+		 * uncorrectable ECC errors.
+		 */
+		chip->options |= NAND_NO_SUBPAGE_WRITE;
+	}
+
+	if (pdata || nfc->caps->legacy_of_bindings) {
+		/*
+		 * We keep the MTD name unchanged to avoid breaking platforms
+		 * where the MTD cmdline parser is used and the bootloader
+		 * has not been updated to use the new naming scheme.
+		 */
+		mtd->name = "pxa3xx_nand-0";
+	} else if (!mtd->name) {
+		/*
+		 * If the new bindings are used and the bootloader has not been
+		 * updated to pass a new mtdparts parameter on the cmdline, you
+		 * should define the following property in your NAND node, ie:
+		 *
+		 *	label = "main-storage";
+		 *
+		 * This way, mtd->name will be set by the core when
+		 * nand_set_flash_node() is called.
+		 */
+		mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL,
+					   "%s:nand.%d", dev_name(nfc->dev),
+					   marvell_nand->sels[0].cs);
+		if (!mtd->name) {
+			dev_err(nfc->dev, "Failed to allocate mtd->name\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static const struct nand_controller_ops marvell_nand_controller_ops = {
+	.attach_chip = marvell_nand_attach_chip,
+};
+
 static int marvell_nand_chip_init(struct device *dev, struct marvell_nfc *nfc,
 				  struct device_node *np)
 {
@@ -2432,105 +2537,11 @@ static int marvell_nand_chip_init(struct device *dev, struct marvell_nfc *nfc,
 	marvell_nand->ndtr1 = readl_relaxed(nfc->regs + NDTR1);
 
 	chip->options |= NAND_BUSWIDTH_AUTO;
-	ret = nand_scan_ident(mtd, marvell_nand->nsels, NULL);
-	if (ret) {
-		dev_err(dev, "could not identify the nand chip\n");
-		return ret;
-	}
-
-	if (pdata && pdata->flash_bbt)
-		chip->bbt_options |= NAND_BBT_USE_FLASH;
-
-	if (chip->bbt_options & NAND_BBT_USE_FLASH) {
-		/*
-		 * We'll use a bad block table stored in-flash and don't
-		 * allow writing the bad block marker to the flash.
-		 */
-		chip->bbt_options |= NAND_BBT_NO_OOB_BBM;
-		chip->bbt_td = &bbt_main_descr;
-		chip->bbt_md = &bbt_mirror_descr;
-	}
-
-	/* Save the chip-specific fields of NDCR */
-	marvell_nand->ndcr = NDCR_PAGE_SZ(mtd->writesize);
-	if (chip->options & NAND_BUSWIDTH_16)
-		marvell_nand->ndcr |= NDCR_DWIDTH_M | NDCR_DWIDTH_C;
-
-	/*
-	 * On small page NANDs, only one cycle is needed to pass the
-	 * column address.
-	 */
-	if (mtd->writesize <= 512) {
-		marvell_nand->addr_cyc = 1;
-	} else {
-		marvell_nand->addr_cyc = 2;
-		marvell_nand->ndcr |= NDCR_RA_START;
-	}
-
-	/*
-	 * Now add the number of cycles needed to pass the row
-	 * address.
-	 *
-	 * Addressing a chip using CS 2 or 3 should also need the third row
-	 * cycle but due to inconsistance in the documentation and lack of
-	 * hardware to test this situation, this case is not supported.
-	 */
-	if (chip->options & NAND_ROW_ADDR_3)
-		marvell_nand->addr_cyc += 3;
-	else
-		marvell_nand->addr_cyc += 2;
-
-	if (pdata) {
-		chip->ecc.size = pdata->ecc_step_size;
-		chip->ecc.strength = pdata->ecc_strength;
-	}
-
-	ret = marvell_nand_ecc_init(mtd, &chip->ecc);
-	if (ret) {
-		dev_err(dev, "ECC init failed: %d\n", ret);
-		return ret;
-	}
-
-	if (chip->ecc.mode == NAND_ECC_HW) {
-		/*
-		 * Subpage write not available with hardware ECC, prohibit also
-		 * subpage read as in userspace subpage access would still be
-		 * allowed and subpage write, if used, would lead to numerous
-		 * uncorrectable ECC errors.
-		 */
-		chip->options |= NAND_NO_SUBPAGE_WRITE;
-	}
-
-	if (pdata || nfc->caps->legacy_of_bindings) {
-		/*
-		 * We keep the MTD name unchanged to avoid breaking platforms
-		 * where the MTD cmdline parser is used and the bootloader
-		 * has not been updated to use the new naming scheme.
-		 */
-		mtd->name = "pxa3xx_nand-0";
-	} else if (!mtd->name) {
-		/*
-		 * If the new bindings are used and the bootloader has not been
-		 * updated to pass a new mtdparts parameter on the cmdline, you
-		 * should define the following property in your NAND node, ie:
-		 *
-		 *	label = "main-storage";
-		 *
-		 * This way, mtd->name will be set by the core when
-		 * nand_set_flash_node() is called.
-		 */
-		mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL,
-					   "%s:nand.%d", dev_name(nfc->dev),
-					   marvell_nand->sels[0].cs);
-		if (!mtd->name) {
-			dev_err(nfc->dev, "Failed to allocate mtd->name\n");
-			return -ENOMEM;
-		}
-	}
 
-	ret = nand_scan_tail(mtd);
+	chip->controller->ops = &marvell_nand_controller_ops;
+	ret = nand_scan(mtd, marvell_nand->nsels);
 	if (ret) {
-		dev_err(dev, "nand_scan_tail failed: %d\n", ret);
+		dev_err(dev, "could not scan the nand chip\n");
 		return ret;
 	}
 
-- 
2.14.1

