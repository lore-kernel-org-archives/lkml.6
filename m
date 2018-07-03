Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E0EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F11D20855
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F11D20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932413AbeGCWAu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:00:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52897 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932351AbeGCWAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:00:47 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BCBA3208B3; Wed,  4 Jul 2018 00:00:44 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 552BC2084E;
        Wed,  4 Jul 2018 00:00:43 +0200 (CEST)
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
Subject: [PATCH v2 04/32] mtd: rawnand: davinci: convert driver to nand_scan()
Date:   Wed,  4 Jul 2018 00:00:01 +0200
Message-Id: <20180703220029.19565-5-miquel.raynal@bootlin.com>
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

Also change the unused "struct device *dev" parameter of the driver
structure into a platform device to reuse it in the ->attach_chip()
hook.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/davinci_nand.c | 186 +++++++++++++++++++-----------------
 1 file changed, 98 insertions(+), 88 deletions(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index cd12e5abafde..f27ce709f5b0 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -53,7 +53,7 @@
 struct davinci_nand_info {
 	struct nand_chip	chip;
 
-	struct device		*dev;
+	struct platform_device	*pdev;
 
 	bool			is_readmode;
 
@@ -606,6 +606,100 @@ static struct davinci_nand_pdata
 }
 #endif
 
+static int davinci_nand_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct davinci_nand_info *info = to_davinci_nand(mtd);
+	struct davinci_nand_pdata *pdata = nand_davinci_get_pdata(info->pdev);
+	int ret = 0;
+
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+
+	switch (info->chip.ecc.mode) {
+	case NAND_ECC_NONE:
+		pdata->ecc_bits = 0;
+		break;
+	case NAND_ECC_SOFT:
+		pdata->ecc_bits = 0;
+		/*
+		 * This driver expects Hamming based ECC when ecc_mode is set
+		 * to NAND_ECC_SOFT. Force ecc.algo to NAND_ECC_HAMMING to
+		 * avoid adding an extra ->ecc_algo field to
+		 * davinci_nand_pdata.
+		 */
+		info->chip.ecc.algo = NAND_ECC_HAMMING;
+		break;
+	case NAND_ECC_HW:
+		if (pdata->ecc_bits == 4) {
+			/*
+			 * No sanity checks:  CPUs must support this,
+			 * and the chips may not use NAND_BUSWIDTH_16.
+			 */
+
+			/* No sharing 4-bit hardware between chipselects yet */
+			spin_lock_irq(&davinci_nand_lock);
+			if (ecc4_busy)
+				ret = -EBUSY;
+			else
+				ecc4_busy = true;
+			spin_unlock_irq(&davinci_nand_lock);
+
+			if (ret == -EBUSY)
+				return ret;
+
+			info->chip.ecc.calculate = nand_davinci_calculate_4bit;
+			info->chip.ecc.correct = nand_davinci_correct_4bit;
+			info->chip.ecc.hwctl = nand_davinci_hwctl_4bit;
+			info->chip.ecc.bytes = 10;
+			info->chip.ecc.options = NAND_ECC_GENERIC_ERASED_CHECK;
+			info->chip.ecc.algo = NAND_ECC_BCH;
+		} else {
+			/* 1bit ecc hamming */
+			info->chip.ecc.calculate = nand_davinci_calculate_1bit;
+			info->chip.ecc.correct = nand_davinci_correct_1bit;
+			info->chip.ecc.hwctl = nand_davinci_hwctl_1bit;
+			info->chip.ecc.bytes = 3;
+			info->chip.ecc.algo = NAND_ECC_HAMMING;
+		}
+		info->chip.ecc.size = 512;
+		info->chip.ecc.strength = pdata->ecc_bits;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * Update ECC layout if needed ... for 1-bit HW ECC, the default
+	 * is OK, but it allocates 6 bytes when only 3 are needed (for
+	 * each 512 bytes).  For the 4-bit HW ECC, that default is not
+	 * usable:  10 bytes are needed, not 6.
+	 */
+	if (pdata->ecc_bits == 4) {
+		int chunks = mtd->writesize / 512;
+
+		if (!chunks || mtd->oobsize < 16) {
+			dev_dbg(&info->pdev->dev, "too small\n");
+			return -EINVAL;
+		}
+
+		/* For small page chips, preserve the manufacturer's
+		 * badblock marking data ... and make sure a flash BBT
+		 * table marker fits in the free bytes.
+		 */
+		if (chunks == 1) {
+			mtd_set_ooblayout(mtd, &hwecc4_small_ooblayout_ops);
+		} else if (chunks == 4 || chunks == 8) {
+			mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
+			info->chip.ecc.mode = NAND_ECC_HW_OOB_FIRST;
+		} else {
+			return -EIO;
+		}
+	}
+
+	return ret;
+}
+
 static int nand_davinci_probe(struct platform_device *pdev)
 {
 	struct davinci_nand_pdata	*pdata;
@@ -659,7 +753,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 		return -EADDRNOTAVAIL;
 	}
 
-	info->dev		= &pdev->dev;
+	info->pdev		= pdev;
 	info->base		= base;
 	info->vaddr		= vaddr;
 
@@ -711,97 +805,13 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	spin_unlock_irq(&davinci_nand_lock);
 
 	/* Scan to find existence of the device(s) */
-	ret = nand_scan_ident(mtd, pdata->mask_chipsel ? 2 : 1, NULL);
+	info->chip.hwcontrol.attach_chip = davinci_nand_attach_chip;
+	ret = nand_scan(mtd, pdata->mask_chipsel ? 2 : 1);
 	if (ret < 0) {
 		dev_dbg(&pdev->dev, "no NAND chip(s) found\n");
 		return ret;
 	}
 
-	switch (info->chip.ecc.mode) {
-	case NAND_ECC_NONE:
-		pdata->ecc_bits = 0;
-		break;
-	case NAND_ECC_SOFT:
-		pdata->ecc_bits = 0;
-		/*
-		 * This driver expects Hamming based ECC when ecc_mode is set
-		 * to NAND_ECC_SOFT. Force ecc.algo to NAND_ECC_HAMMING to
-		 * avoid adding an extra ->ecc_algo field to
-		 * davinci_nand_pdata.
-		 */
-		info->chip.ecc.algo = NAND_ECC_HAMMING;
-		break;
-	case NAND_ECC_HW:
-		if (pdata->ecc_bits == 4) {
-			/* No sanity checks:  CPUs must support this,
-			 * and the chips may not use NAND_BUSWIDTH_16.
-			 */
-
-			/* No sharing 4-bit hardware between chipselects yet */
-			spin_lock_irq(&davinci_nand_lock);
-			if (ecc4_busy)
-				ret = -EBUSY;
-			else
-				ecc4_busy = true;
-			spin_unlock_irq(&davinci_nand_lock);
-
-			if (ret == -EBUSY)
-				return ret;
-
-			info->chip.ecc.calculate = nand_davinci_calculate_4bit;
-			info->chip.ecc.correct = nand_davinci_correct_4bit;
-			info->chip.ecc.hwctl = nand_davinci_hwctl_4bit;
-			info->chip.ecc.bytes = 10;
-			info->chip.ecc.options = NAND_ECC_GENERIC_ERASED_CHECK;
-			info->chip.ecc.algo = NAND_ECC_BCH;
-		} else {
-			/* 1bit ecc hamming */
-			info->chip.ecc.calculate = nand_davinci_calculate_1bit;
-			info->chip.ecc.correct = nand_davinci_correct_1bit;
-			info->chip.ecc.hwctl = nand_davinci_hwctl_1bit;
-			info->chip.ecc.bytes = 3;
-			info->chip.ecc.algo = NAND_ECC_HAMMING;
-		}
-		info->chip.ecc.size = 512;
-		info->chip.ecc.strength = pdata->ecc_bits;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* Update ECC layout if needed ... for 1-bit HW ECC, the default
-	 * is OK, but it allocates 6 bytes when only 3 are needed (for
-	 * each 512 bytes).  For the 4-bit HW ECC, that default is not
-	 * usable:  10 bytes are needed, not 6.
-	 */
-	if (pdata->ecc_bits == 4) {
-		int	chunks = mtd->writesize / 512;
-
-		if (!chunks || mtd->oobsize < 16) {
-			dev_dbg(&pdev->dev, "too small\n");
-			ret = -EINVAL;
-			goto err;
-		}
-
-		/* For small page chips, preserve the manufacturer's
-		 * badblock marking data ... and make sure a flash BBT
-		 * table marker fits in the free bytes.
-		 */
-		if (chunks == 1) {
-			mtd_set_ooblayout(mtd, &hwecc4_small_ooblayout_ops);
-		} else if (chunks == 4 || chunks == 8) {
-			mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
-			info->chip.ecc.mode = NAND_ECC_HW_OOB_FIRST;
-		} else {
-			ret = -EIO;
-			goto err;
-		}
-	}
-
-	ret = nand_scan_tail(mtd);
-	if (ret < 0)
-		goto err;
-
 	if (pdata->parts)
 		ret = mtd_device_parse_register(mtd, NULL, NULL,
 					pdata->parts, pdata->nr_parts);
-- 
2.14.1

