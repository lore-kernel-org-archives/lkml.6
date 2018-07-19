Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34755ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B9520684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B9520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbeGSXqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:46:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54053 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731246AbeGSXp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:45:59 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BA15E20935; Fri, 20 Jul 2018 01:00:42 +0200 (CEST)
Received: from localhost.localdomain (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 08C0320732;
        Fri, 20 Jul 2018 01:00:40 +0200 (CEST)
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
Subject: [PATCH v3 04/33] mtd: rawnand: denali: convert to nand_scan()
Date:   Fri, 20 Jul 2018 00:59:57 +0200
Message-Id: <20180719230026.8741-5-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/denali.c | 138 +++++++++++++++++++++++-------------------
 1 file changed, 77 insertions(+), 61 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 4d53f41ada08..8325e5231abc 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1205,62 +1205,12 @@ static int denali_multidev_fixup(struct denali_nand_info *denali)
 	return 0;
 }
 
-int denali_init(struct denali_nand_info *denali)
+static int denali_attach_chip(struct nand_chip *chip)
 {
-	struct nand_chip *chip = &denali->nand;
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	u32 features = ioread32(denali->reg + FEATURES);
+	struct denali_nand_info *denali = mtd_to_denali(mtd);
 	int ret;
 
-	mtd->dev.parent = denali->dev;
-	denali_hw_init(denali);
-
-	init_completion(&denali->complete);
-	spin_lock_init(&denali->irq_lock);
-
-	denali_clear_irq_all(denali);
-
-	ret = devm_request_irq(denali->dev, denali->irq, denali_isr,
-			       IRQF_SHARED, DENALI_NAND_NAME, denali);
-	if (ret) {
-		dev_err(denali->dev, "Unable to request IRQ\n");
-		return ret;
-	}
-
-	denali_enable_irq(denali);
-	denali_reset_banks(denali);
-
-	denali->active_bank = DENALI_INVALID_BANK;
-
-	nand_set_flash_node(chip, denali->dev->of_node);
-	/* Fallback to the default name if DT did not give "label" property */
-	if (!mtd->name)
-		mtd->name = "denali-nand";
-
-	chip->select_chip = denali_select_chip;
-	chip->read_byte = denali_read_byte;
-	chip->write_byte = denali_write_byte;
-	chip->read_word = denali_read_word;
-	chip->cmd_ctrl = denali_cmd_ctrl;
-	chip->dev_ready = denali_dev_ready;
-	chip->waitfunc = denali_waitfunc;
-
-	if (features & FEATURES__INDEX_ADDR) {
-		denali->host_read = denali_indexed_read;
-		denali->host_write = denali_indexed_write;
-	} else {
-		denali->host_read = denali_direct_read;
-		denali->host_write = denali_direct_write;
-	}
-
-	/* clk rate info is needed for setup_data_interface */
-	if (denali->clk_rate && denali->clk_x_rate)
-		chip->setup_data_interface = denali_setup_data_interface;
-
-	ret = nand_scan_ident(mtd, denali->max_banks, NULL);
-	if (ret)
-		goto disable_irq;
-
 	if (ioread32(denali->reg + FEATURES) & FEATURES__DMA)
 		denali->dma_avail = 1;
 
@@ -1293,7 +1243,7 @@ int denali_init(struct denali_nand_info *denali)
 				   mtd->oobsize - denali->oob_skip_bytes);
 	if (ret) {
 		dev_err(denali->dev, "Failed to setup ECC settings.\n");
-		goto disable_irq;
+		return ret;
 	}
 
 	dev_dbg(denali->dev,
@@ -1337,7 +1287,7 @@ int denali_init(struct denali_nand_info *denali)
 
 	ret = denali_multidev_fixup(denali);
 	if (ret)
-		goto disable_irq;
+		return ret;
 
 	/*
 	 * This buffer is DMA-mapped by denali_{read,write}_page_raw.  Do not
@@ -1345,26 +1295,92 @@ int denali_init(struct denali_nand_info *denali)
 	 * guarantee DMA-safe alignment.
 	 */
 	denali->buf = kmalloc(mtd->writesize + mtd->oobsize, GFP_KERNEL);
-	if (!denali->buf) {
-		ret = -ENOMEM;
-		goto disable_irq;
+	if (!denali->buf)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void denali_detach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct denali_nand_info *denali = mtd_to_denali(mtd);
+
+	kfree(denali->buf);
+}
+
+static struct nand_controller_ops denali_controller_ops = {
+	.attach_chip = denali_attach_chip,
+	.detach_chip = denali_detach_chip,
+};
+
+int denali_init(struct denali_nand_info *denali)
+{
+	struct nand_chip *chip = &denali->nand;
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	u32 features = ioread32(denali->reg + FEATURES);
+	int ret;
+
+	mtd->dev.parent = denali->dev;
+	denali_hw_init(denali);
+
+	init_completion(&denali->complete);
+	spin_lock_init(&denali->irq_lock);
+
+	denali_clear_irq_all(denali);
+
+	ret = devm_request_irq(denali->dev, denali->irq, denali_isr,
+			       IRQF_SHARED, DENALI_NAND_NAME, denali);
+	if (ret) {
+		dev_err(denali->dev, "Unable to request IRQ\n");
+		return ret;
+	}
+
+	denali_enable_irq(denali);
+	denali_reset_banks(denali);
+
+	denali->active_bank = DENALI_INVALID_BANK;
+
+	nand_set_flash_node(chip, denali->dev->of_node);
+	/* Fallback to the default name if DT did not give "label" property */
+	if (!mtd->name)
+		mtd->name = "denali-nand";
+
+	chip->select_chip = denali_select_chip;
+	chip->read_byte = denali_read_byte;
+	chip->write_byte = denali_write_byte;
+	chip->read_word = denali_read_word;
+	chip->cmd_ctrl = denali_cmd_ctrl;
+	chip->dev_ready = denali_dev_ready;
+	chip->waitfunc = denali_waitfunc;
+
+	if (features & FEATURES__INDEX_ADDR) {
+		denali->host_read = denali_indexed_read;
+		denali->host_write = denali_indexed_write;
+	} else {
+		denali->host_read = denali_direct_read;
+		denali->host_write = denali_direct_write;
 	}
 
-	ret = nand_scan_tail(mtd);
+	/* clk rate info is needed for setup_data_interface */
+	if (denali->clk_rate && denali->clk_x_rate)
+		chip->setup_data_interface = denali_setup_data_interface;
+
+	chip->dummy_controller.ops = &denali_controller_ops;
+	ret = nand_scan(mtd, denali->max_banks);
 	if (ret)
-		goto free_buf;
+		goto disable_irq;
 
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret) {
 		dev_err(denali->dev, "Failed to register MTD: %d\n", ret);
 		goto cleanup_nand;
 	}
+
 	return 0;
 
 cleanup_nand:
 	nand_cleanup(chip);
-free_buf:
-	kfree(denali->buf);
 disable_irq:
 	denali_disable_irq(denali);
 
-- 
2.14.1

