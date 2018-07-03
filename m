Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D122C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E9D20855
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E9D20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932915AbeGCWIQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:08:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52878 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932213AbeGCWAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:00:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5823C208C4; Wed,  4 Jul 2018 00:00:43 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id DFFFE20719;
        Wed,  4 Jul 2018 00:00:41 +0200 (CEST)
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
Subject: [PATCH v2 03/32] mtd: rawnand: cafe: convert driver to nand_scan()
Date:   Wed,  4 Jul 2018 00:00:00 +0200
Message-Id: <20180703220029.19565-4-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/cafe_nand.c | 131 ++++++++++++++++++++++-----------------
 1 file changed, 75 insertions(+), 56 deletions(-)

diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe_nand.c
index d721f489b38b..035061606e39 100644
--- a/drivers/mtd/nand/raw/cafe_nand.c
+++ b/drivers/mtd/nand/raw/cafe_nand.c
@@ -71,7 +71,9 @@ struct cafe_priv {
 	unsigned char *dmabuf;
 };
 
-static int usedma = 1;
+#define CAFE_DEFAULT_DMA	1
+
+static int usedma = CAFE_DEFAULT_DMA;
 module_param(usedma, int, 0644);
 
 static int skipbbt = 0;
@@ -598,6 +600,74 @@ static int cafe_mul(int x)
 	return gf4096_mul(x, 0xe01);
 }
 
+static int cafe_nand_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct cafe_priv *cafe = nand_get_controller_data(chip);
+	int err = 0;
+
+	cafe->dmabuf = dma_alloc_coherent(&cafe->pdev->dev, 2112,
+					  &cafe->dmaaddr, GFP_KERNEL);
+	if (!cafe->dmabuf)
+		return -ENOMEM;
+
+	/* Set up DMA address */
+	cafe_writel(cafe, lower_32_bits(cafe->dmaaddr), NAND_DMA_ADDR0);
+	cafe_writel(cafe, upper_32_bits(cafe->dmaaddr), NAND_DMA_ADDR1);
+
+	cafe_dev_dbg(&cafe->pdev->dev, "Set DMA address to %x (virt %p)\n",
+		     cafe_readl(cafe, NAND_DMA_ADDR0), cafe->dmabuf);
+
+	/* Restore the DMA flag */
+	usedma = CAFE_DEFAULT_DMA;
+
+	cafe->ctl2 = BIT(27); /* Reed-Solomon ECC */
+	if (mtd->writesize == 2048)
+		cafe->ctl2 |= BIT(29); /* 2KiB page size */
+
+	/* Set up ECC according to the type of chip we found */
+	mtd_set_ooblayout(mtd, &cafe_ooblayout_ops);
+	if (mtd->writesize == 2048) {
+		cafe->nand.bbt_td = &cafe_bbt_main_descr_2048;
+		cafe->nand.bbt_md = &cafe_bbt_mirror_descr_2048;
+	} else if (mtd->writesize == 512) {
+		cafe->nand.bbt_td = &cafe_bbt_main_descr_512;
+		cafe->nand.bbt_md = &cafe_bbt_mirror_descr_512;
+	} else {
+		dev_warn(&cafe->pdev->dev,
+			 "Unexpected NAND flash writesize %d. Aborting\n",
+			 mtd->writesize);
+		err = -ENOTSUPP;
+		goto out_free_dma;
+	}
+
+	cafe->nand.ecc.mode = NAND_ECC_HW_SYNDROME;
+	cafe->nand.ecc.size = mtd->writesize;
+	cafe->nand.ecc.bytes = 14;
+	cafe->nand.ecc.strength = 4;
+	cafe->nand.ecc.hwctl  = (void *)cafe_nand_bug;
+	cafe->nand.ecc.calculate = (void *)cafe_nand_bug;
+	cafe->nand.ecc.correct  = (void *)cafe_nand_bug;
+	cafe->nand.ecc.write_page = cafe_nand_write_page_lowlevel;
+	cafe->nand.ecc.write_oob = cafe_nand_write_oob;
+	cafe->nand.ecc.read_page = cafe_nand_read_page;
+	cafe->nand.ecc.read_oob = cafe_nand_read_oob;
+
+	return 0;
+
+ out_free_dma:
+	dma_free_coherent(&cafe->pdev->dev, 2112, cafe->dmabuf, cafe->dmaaddr);
+
+	return err;
+}
+
+static void cafe_nand_detach_chip(struct nand_chip *chip)
+{
+	struct cafe_priv *cafe = nand_get_controller_data(chip);
+
+	dma_free_coherent(&cafe->pdev->dev, 2112, cafe->dmabuf, cafe->dmaaddr);
+}
+
 static int cafe_nand_probe(struct pci_dev *pdev,
 				     const struct pci_device_id *ent)
 {
@@ -713,65 +783,16 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 		cafe_readl(cafe, GLOBAL_CTRL),
 		cafe_readl(cafe, GLOBAL_IRQ_MASK));
 
-	/* Do not use the DMA for the nand_scan_ident() */
-	old_dma = usedma;
+	/* Do not use the DMA during the NAND identification */
 	usedma = 0;
 
 	/* Scan to find existence of the device */
-	err = nand_scan_ident(mtd, 2, NULL);
+	cafe->nand.hwcontrol.attach_chip = cafe_nand_attach_chip;
+	cafe->nand.hwcontrol.detach_chip = cafe_nand_detach_chip;
+	err = nand_scan(mtd, 2);
 	if (err)
 		goto out_irq;
 
-	cafe->dmabuf = dma_alloc_coherent(&cafe->pdev->dev, 2112,
-					  &cafe->dmaaddr, GFP_KERNEL);
-	if (!cafe->dmabuf) {
-		err = -ENOMEM;
-		goto out_irq;
-	}
-
-	/* Set up DMA address */
-	cafe_writel(cafe, lower_32_bits(cafe->dmaaddr), NAND_DMA_ADDR0);
-	cafe_writel(cafe, upper_32_bits(cafe->dmaaddr), NAND_DMA_ADDR1);
-
-	cafe_dev_dbg(&cafe->pdev->dev, "Set DMA address to %x (virt %p)\n",
-		cafe_readl(cafe, NAND_DMA_ADDR0), cafe->dmabuf);
-
-	/* Restore the DMA flag */
-	usedma = old_dma;
-
-	cafe->ctl2 = 1<<27; /* Reed-Solomon ECC */
-	if (mtd->writesize == 2048)
-		cafe->ctl2 |= 1<<29; /* 2KiB page size */
-
-	/* Set up ECC according to the type of chip we found */
-	mtd_set_ooblayout(mtd, &cafe_ooblayout_ops);
-	if (mtd->writesize == 2048) {
-		cafe->nand.bbt_td = &cafe_bbt_main_descr_2048;
-		cafe->nand.bbt_md = &cafe_bbt_mirror_descr_2048;
-	} else if (mtd->writesize == 512) {
-		cafe->nand.bbt_td = &cafe_bbt_main_descr_512;
-		cafe->nand.bbt_md = &cafe_bbt_mirror_descr_512;
-	} else {
-		pr_warn("Unexpected NAND flash writesize %d. Aborting\n",
-			mtd->writesize);
-		goto out_free_dma;
-	}
-	cafe->nand.ecc.mode = NAND_ECC_HW_SYNDROME;
-	cafe->nand.ecc.size = mtd->writesize;
-	cafe->nand.ecc.bytes = 14;
-	cafe->nand.ecc.strength = 4;
-	cafe->nand.ecc.hwctl  = (void *)cafe_nand_bug;
-	cafe->nand.ecc.calculate = (void *)cafe_nand_bug;
-	cafe->nand.ecc.correct  = (void *)cafe_nand_bug;
-	cafe->nand.ecc.write_page = cafe_nand_write_page_lowlevel;
-	cafe->nand.ecc.write_oob = cafe_nand_write_oob;
-	cafe->nand.ecc.read_page = cafe_nand_read_page;
-	cafe->nand.ecc.read_oob = cafe_nand_read_oob;
-
-	err = nand_scan_tail(mtd);
-	if (err)
-		goto out_free_dma;
-
 	pci_set_drvdata(pdev, mtd);
 
 	mtd->name = "cafe_nand";
@@ -783,8 +804,6 @@ static int cafe_nand_probe(struct pci_dev *pdev,
 
  out_cleanup_nand:
 	nand_cleanup(&cafe->nand);
- out_free_dma:
-	dma_free_coherent(&cafe->pdev->dev, 2112, cafe->dmabuf, cafe->dmaaddr);
  out_irq:
 	/* Disable NAND IRQ in global IRQ mask register */
 	cafe_writel(cafe, ~1 & cafe_readl(cafe, GLOBAL_IRQ_MASK), GLOBAL_IRQ_MASK);
-- 
2.14.1

