Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7FFC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 048C224574
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048C224574
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932892AbeGCWBF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:01:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53030 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932355AbeGCWBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:01:01 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 58A2B208C4; Wed,  4 Jul 2018 00:00:59 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 708A1207DA;
        Wed,  4 Jul 2018 00:00:55 +0200 (CEST)
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
Subject: [PATCH v2 12/32] mtd: rawnand: lpc32xx_mlc: convert driver to nand_scan()
Date:   Wed,  4 Jul 2018 00:00:09 +0200
Message-Id: <20180703220029.19565-13-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/lpc32xx_mlc.c | 105 +++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 50 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 052d123a8304..d650ed609ba7 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -184,6 +184,7 @@ static struct nand_bbt_descr lpc32xx_nand_bbt_mirror = {
 };
 
 struct lpc32xx_nand_host {
+	struct platform_device	*pdev;
 	struct nand_chip	nand_chip;
 	struct lpc32xx_mlc_platform_data *pdata;
 	struct clk		*clk;
@@ -653,6 +654,53 @@ static struct lpc32xx_nand_cfg_mlc *lpc32xx_parse_dt(struct device *dev)
 	return ncfg;
 }
 
+static int lpc32xx_nand_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
+	struct device *dev = &host->pdev->dev;
+
+	host->dma_buf = devm_kzalloc(dev, mtd->writesize, GFP_KERNEL);
+	if (!host->dma_buf)
+		return -ENOMEM;
+
+	host->dummy_buf = devm_kzalloc(dev, mtd->writesize, GFP_KERNEL);
+	if (!host->dummy_buf)
+		return -ENOMEM;
+
+	chip->ecc.mode = NAND_ECC_HW;
+	chip->ecc.size = 512;
+	mtd_set_ooblayout(mtd, &lpc32xx_ooblayout_ops);
+	host->mlcsubpages = mtd->writesize / 512;
+
+	/* initially clear interrupt status */
+	readb(MLC_IRQ_SR(host->io_base));
+
+	init_completion(&host->comp_nand);
+	init_completion(&host->comp_controller);
+
+	host->irq = platform_get_irq(host->pdev, 0);
+	if (host->irq < 0) {
+		dev_err(dev, "failed to get platform irq\n");
+		return -EINVAL;
+	}
+
+	if (request_irq(host->irq, (irq_handler_t)&lpc3xxx_nand_irq,
+			IRQF_TRIGGER_HIGH, DRV_NAME, host)) {
+		dev_err(dev, "Error requesting NAND IRQ\n");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static void lpc32xx_nand_detach_chip(struct nand_chip *chip)
+{
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
+
+	free_irq(host->irq, host);
+}
+
 /*
  * Probe for NAND controller
  */
@@ -669,6 +717,8 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	if (!host)
 		return -ENOMEM;
 
+	host->pdev = pdev;
+
 	rc = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->io_base = devm_ioremap_resource(&pdev->dev, rc);
 	if (IS_ERR(host->io_base))
@@ -749,58 +799,15 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	}
 
 	/*
-	 * Scan to find existance of the device and
-	 * Get the type of NAND device SMALL block or LARGE block
+	 * Scan to find existence of the device and get the type of NAND device:
+	 * SMALL block or LARGE block.
 	 */
-	res = nand_scan_ident(mtd, 1, NULL);
+	nand_chip->hwcontrol.attach_chip = lpc32xx_nand_attach_chip;
+	nand_chip->hwcontrol.detach_chip = lpc32xx_nand_detach_chip;
+	res = nand_scan(mtd, 1);
 	if (res)
 		goto release_dma_chan;
 
-	host->dma_buf = devm_kzalloc(&pdev->dev, mtd->writesize, GFP_KERNEL);
-	if (!host->dma_buf) {
-		res = -ENOMEM;
-		goto release_dma_chan;
-	}
-
-	host->dummy_buf = devm_kzalloc(&pdev->dev, mtd->writesize, GFP_KERNEL);
-	if (!host->dummy_buf) {
-		res = -ENOMEM;
-		goto release_dma_chan;
-	}
-
-	nand_chip->ecc.mode = NAND_ECC_HW;
-	nand_chip->ecc.size = 512;
-	mtd_set_ooblayout(mtd, &lpc32xx_ooblayout_ops);
-	host->mlcsubpages = mtd->writesize / 512;
-
-	/* initially clear interrupt status */
-	readb(MLC_IRQ_SR(host->io_base));
-
-	init_completion(&host->comp_nand);
-	init_completion(&host->comp_controller);
-
-	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq < 0) {
-		dev_err(&pdev->dev, "failed to get platform irq\n");
-		res = -EINVAL;
-		goto release_dma_chan;
-	}
-
-	if (request_irq(host->irq, (irq_handler_t)&lpc3xxx_nand_irq,
-			IRQF_TRIGGER_HIGH, DRV_NAME, host)) {
-		dev_err(&pdev->dev, "Error requesting NAND IRQ\n");
-		res = -ENXIO;
-		goto release_dma_chan;
-	}
-
-	/*
-	 * Fills out all the uninitialized function pointers with the defaults
-	 * And scans for a bad block table if appropriate.
-	 */
-	res = nand_scan_tail(mtd);
-	if (res)
-		goto free_irq;
-
 	mtd->name = DRV_NAME;
 
 	res = mtd_device_register(mtd, host->ncfg->parts,
@@ -812,8 +819,6 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 
 cleanup_nand:
 	nand_cleanup(nand_chip);
-free_irq:
-	free_irq(host->irq, host);
 release_dma_chan:
 	if (use_dma)
 		dma_release_channel(host->dma_chan);
-- 
2.14.1

