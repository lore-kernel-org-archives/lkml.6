Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFBCECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5BF20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5BF20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbeGSXpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:45:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54002 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbeGSXpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:45:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4F1A4207B4; Fri, 20 Jul 2018 01:00:35 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id BDDBA206F6;
        Fri, 20 Jul 2018 01:00:32 +0200 (CEST)
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
Subject: [PATCH v3 01/33] mtd: rawnand: brcmnand: convert driver to nand_scan()
Date:   Fri, 20 Jul 2018 00:59:54 +0200
Message-Id: <20180719230026.8741-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180719230026.8741-1-miquel.raynal@bootlin.com>
References: <20180719230026.8741-1-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 47 +++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 2e5efa0f9ea2..4a69c13c83f4 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2208,6 +2208,32 @@ static int brcmnand_setup_dev(struct brcmnand_host *host)
 	return 0;
 }
 
+static int brcmnand_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct brcmnand_host *host = nand_get_controller_data(chip);
+	int ret;
+
+	if (chip->bbt_options & NAND_BBT_USE_FLASH)
+		chip->bbt_options |= NAND_BBT_NO_OOB;
+
+	if (brcmnand_setup_dev(host))
+		return -ENXIO;
+
+	chip->ecc.size = host->hwcfg.sector_size_1k ? 1024 : 512;
+
+	/* only use our internal HW threshold */
+	mtd->bitflip_threshold = 1;
+
+	ret = brcmstb_choose_ecc_layout(host);
+
+	return ret;
+}
+
+static struct nand_controller_ops brcmnand_controller_ops = {
+	.attach_chip = brcmnand_attach_chip,
+};
+
 static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 {
 	struct brcmnand_controller *ctrl = host->ctrl;
@@ -2267,10 +2293,6 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 	nand_writereg(ctrl, cfg_offs,
 		      nand_readreg(ctrl, cfg_offs) & ~CFG_BUS_WIDTH);
 
-	ret = nand_scan_ident(mtd, 1, NULL);
-	if (ret)
-		return ret;
-
 	chip->options |= NAND_NO_SUBPAGE_WRITE;
 	/*
 	 * Avoid (for instance) kmap()'d buffers from JFFS2, which we can't DMA
@@ -2279,21 +2301,7 @@ static int brcmnand_init_cs(struct brcmnand_host *host, struct device_node *dn)
 	 */
 	chip->options |= NAND_USE_BOUNCE_BUFFER;
 
-	if (chip->bbt_options & NAND_BBT_USE_FLASH)
-		chip->bbt_options |= NAND_BBT_NO_OOB;
-
-	if (brcmnand_setup_dev(host))
-		return -ENXIO;
-
-	chip->ecc.size = host->hwcfg.sector_size_1k ? 1024 : 512;
-	/* only use our internal HW threshold */
-	mtd->bitflip_threshold = 1;
-
-	ret = brcmstb_choose_ecc_layout(host);
-	if (ret)
-		return ret;
-
-	ret = nand_scan_tail(mtd);
+	ret = nand_scan(mtd, 1);
 	if (ret)
 		return ret;
 
@@ -2434,6 +2442,7 @@ int brcmnand_probe(struct platform_device *pdev, struct brcmnand_soc *soc)
 	init_completion(&ctrl->done);
 	init_completion(&ctrl->dma_done);
 	nand_controller_init(&ctrl->controller);
+	ctrl->controller.ops = &brcmnand_controller_ops;
 	INIT_LIST_HEAD(&ctrl->host_list);
 
 	/* NAND register range */
-- 
2.14.1

