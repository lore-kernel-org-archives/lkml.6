Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052CEECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A8A2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A8A2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbeGSXqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:46:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54117 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731452AbeGSXqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:46:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 05E9B20876; Fri, 20 Jul 2018 01:00:49 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8B2F22072F;
        Fri, 20 Jul 2018 01:00:47 +0200 (CEST)
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
Subject: [PATCH v3 08/33] mtd: rawnand: gpmi: convert driver to nand_scan()
Date:   Fri, 20 Jul 2018 01:00:01 +0200
Message-Id: <20180719230026.8741-9-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 56 ++++++++++++++++++------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 6294d018df65..5da2fd6e37cc 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -744,9 +744,9 @@ static int gpmi_alloc_dma_buffer(struct gpmi_nand_data *this)
 	 * [2] Allocate a read/write data buffer.
 	 *     The gpmi_alloc_dma_buffer can be called twice.
 	 *     We allocate a PAGE_SIZE length buffer if gpmi_alloc_dma_buffer
-	 *     is called before the nand_scan_ident; and we allocate a buffer
-	 *     of the real NAND page size when the gpmi_alloc_dma_buffer is
-	 *     called after the nand_scan_ident.
+	 *     is called before the NAND identification; and we allocate a
+	 *     buffer of the real NAND page size when the gpmi_alloc_dma_buffer
+	 *     is called after.
 	 */
 	this->data_buffer_dma = kzalloc(mtd->writesize ?: PAGE_SIZE,
 					GFP_DMA | GFP_KERNEL);
@@ -1865,6 +1865,34 @@ static int gpmi_init_last(struct gpmi_nand_data *this)
 	return 0;
 }
 
+static int gpmi_nand_attach_chip(struct nand_chip *chip)
+{
+	struct gpmi_nand_data *this = nand_get_controller_data(chip);
+	int ret;
+
+	if (chip->bbt_options & NAND_BBT_USE_FLASH) {
+		chip->bbt_options |= NAND_BBT_NO_OOB;
+
+		if (of_property_read_bool(this->dev->of_node,
+					  "fsl,no-blockmark-swap"))
+			this->swap_block_mark = false;
+	}
+	dev_dbg(this->dev, "Blockmark swapping %sabled\n",
+		this->swap_block_mark ? "en" : "dis");
+
+	ret = gpmi_init_last(this);
+	if (ret)
+		return ret;
+
+	chip->options |= NAND_SKIP_BBTSCAN;
+
+	return 0;
+}
+
+static struct nand_controller_ops gpmi_nand_controller_ops = {
+	.attach_chip = gpmi_nand_attach_chip,
+};
+
 static int gpmi_nand_init(struct gpmi_nand_data *this)
 {
 	struct nand_chip *chip = &this->nand;
@@ -1905,26 +1933,8 @@ static int gpmi_nand_init(struct gpmi_nand_data *this)
 	if (ret)
 		goto err_out;
 
-	ret = nand_scan_ident(mtd, GPMI_IS_MX6(this) ? 2 : 1, NULL);
-	if (ret)
-		goto err_out;
-
-	if (chip->bbt_options & NAND_BBT_USE_FLASH) {
-		chip->bbt_options |= NAND_BBT_NO_OOB;
-
-		if (of_property_read_bool(this->dev->of_node,
-						"fsl,no-blockmark-swap"))
-			this->swap_block_mark = false;
-	}
-	dev_dbg(this->dev, "Blockmark swapping %sabled\n",
-		this->swap_block_mark ? "en" : "dis");
-
-	ret = gpmi_init_last(this);
-	if (ret)
-		goto err_out;
-
-	chip->options |= NAND_SKIP_BBTSCAN;
-	ret = nand_scan_tail(mtd);
+	chip->dummy_controller.ops = &gpmi_nand_controller_ops;
+	ret = nand_scan(mtd, GPMI_IS_MX6(this) ? 2 : 1);
 	if (ret)
 		goto err_out;
 
-- 
2.14.1

