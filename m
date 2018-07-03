Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B160C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4710E24574
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4710E24574
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933125AbeGCWBR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:01:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53159 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932992AbeGCWBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:01:13 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DC36620938; Wed,  4 Jul 2018 00:01:10 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7366220933;
        Wed,  4 Jul 2018 00:01:09 +0200 (CEST)
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
Subject: [PATCH v2 20/32] mtd: rawnand: sh_flctl: move all NAND chip related setup in one function
Date:   Wed,  4 Jul 2018 00:00:17 +0200
Message-Id: <20180703220029.19565-21-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180703220029.19565-1-miquel.raynal@bootlin.com>
References: <20180703220029.19565-1-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare the conversion of the sh_flctl driver to nand_scan() by moving
all the configuration that must be made after nand_scan_ident() in one
single function. Create a pdata entry in the controller structure for
that.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/sh_flctl.c | 38 +++++++++++++++++++-------------------
 include/linux/mtd/sh_flctl.h    |  1 +
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index c7abceffcc40..d37d1d3ccbf9 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -1007,6 +1007,16 @@ static int flctl_chip_init_tail(struct mtd_info *mtd)
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
 	struct nand_chip *chip = &flctl->chip;
 
+	if (chip->options & NAND_BUSWIDTH_16) {
+		/*
+		 * NAND_BUSWIDTH_16 may have been set by nand_scan_ident().
+		 * Add the SEL_16BIT flag in pdata->flcmncr_val and re-assign
+		 * flctl->flcmncr_base to pdata->flcmncr_val.
+		 */
+		flctl->pdata->flcmncr_val |= SEL_16BIT;
+		flctl->flcmncr_base = flctl->pdata->flcmncr_val;
+	}
+
 	if (mtd->writesize == 512) {
 		flctl->page_size = 0;
 		if (chip->chipsize > (32 << 20)) {
@@ -1122,7 +1132,6 @@ static int flctl_probe(struct platform_device *pdev)
 	struct sh_flctl *flctl;
 	struct mtd_info *flctl_mtd;
 	struct nand_chip *nand;
-	struct sh_flctl_platform_data *pdata;
 	int ret;
 	int irq;
 
@@ -1150,11 +1159,11 @@ static int flctl_probe(struct platform_device *pdev)
 	}
 
 	if (pdev->dev.of_node)
-		pdata = flctl_parse_dt(&pdev->dev);
+		flctl->pdata = flctl_parse_dt(&pdev->dev);
 	else
-		pdata = dev_get_platdata(&pdev->dev);
+		flctl->pdata = dev_get_platdata(&pdev->dev);
 
-	if (!pdata) {
+	if (!flctl->pdata) {
 		dev_err(&pdev->dev, "no setup data defined\n");
 		return -EINVAL;
 	}
@@ -1165,9 +1174,9 @@ static int flctl_probe(struct platform_device *pdev)
 	nand_set_flash_node(nand, pdev->dev.of_node);
 	flctl_mtd->dev.parent = &pdev->dev;
 	flctl->pdev = pdev;
-	flctl->hwecc = pdata->has_hwecc;
-	flctl->holden = pdata->use_holden;
-	flctl->flcmncr_base = pdata->flcmncr_val;
+	flctl->hwecc = flctl->pdata->has_hwecc;
+	flctl->holden = flctl->pdata->use_holden;
+	flctl->flcmncr_base = flctl->pdata->flcmncr_val;
 	flctl->flintdmacr_base = flctl->hwecc ? (STERINTE | ECERB) : STERINTE;
 
 	/* Set address of hardware control function */
@@ -1183,7 +1192,7 @@ static int flctl_probe(struct platform_device *pdev)
 	nand->set_features = nand_get_set_features_notsupp;
 	nand->get_features = nand_get_set_features_notsupp;
 
-	if (pdata->flcmncr_val & SEL_16BIT)
+	if (flctl->pdata->flcmncr_val & SEL_16BIT)
 		nand->options |= NAND_BUSWIDTH_16;
 
 	pm_runtime_enable(&pdev->dev);
@@ -1195,16 +1204,6 @@ static int flctl_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_chip;
 
-	if (nand->options & NAND_BUSWIDTH_16) {
-		/*
-		 * NAND_BUSWIDTH_16 may have been set by nand_scan_ident().
-		 * Add the SEL_16BIT flag in pdata->flcmncr_val and re-assign
-		 * flctl->flcmncr_base to pdata->flcmncr_val.
-		 */
-		pdata->flcmncr_val |= SEL_16BIT;
-		flctl->flcmncr_base = pdata->flcmncr_val;
-	}
-
 	ret = flctl_chip_init_tail(flctl_mtd);
 	if (ret)
 		goto err_chip;
@@ -1213,7 +1212,8 @@ static int flctl_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_chip;
 
-	ret = mtd_device_register(flctl_mtd, pdata->parts, pdata->nr_parts);
+	ret = mtd_device_register(flctl_mtd, flctl->pdata->parts,
+				  flctl->pdata->nr_parts);
 	if (ret)
 		goto cleanup_nand;
 
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index c759d403cbc0..c9f486c6c019 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -148,6 +148,7 @@ struct sh_flctl {
 	struct dev_pm_qos_request pm_qos;
 	void __iomem		*reg;
 	resource_size_t		fifo;
+	struct sh_flctl_platform_data *pdata;
 
 	uint8_t	done_buff[2048 + 64];	/* max size 2048 + 64 */
 	int	read_bytes;
-- 
2.14.1

