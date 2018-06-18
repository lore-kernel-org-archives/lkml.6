Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278DCC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D744420864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D744420864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965494AbeFRIW0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:22:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55520 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965435AbeFRIWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:22:24 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 494A2C7A;
        Mon, 18 Jun 2018 08:22:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 155/279] mtd: onenand: omap2: Disable DMA for HIGHMEM buffers
Date:   Mon, 18 Jun 2018 10:12:20 +0200
Message-Id: <20180618080615.243663438@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ladislav Michl <ladis@linux-mips.org>

[ Upstream commit 6732cfd4cac514b556f36b518670af91c8bdf19a ]

dma_map_single does not work for vmalloc-ed buffers,
so disable DMA in this case.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Reported-by: "H. Nikolaus Schaller" <hns@goldelico.com>
Tested-by: "H. Nikolaus Schaller" <hns@goldelico.com>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/onenand/omap2.c |  105 +++++++++++++++-----------------------------
 1 file changed, 38 insertions(+), 67 deletions(-)

--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -377,56 +377,42 @@ static int omap2_onenand_read_bufferram(
 {
 	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
 	struct onenand_chip *this = mtd->priv;
-	dma_addr_t dma_src, dma_dst;
-	int bram_offset;
+	struct device *dev = &c->pdev->dev;
 	void *buf = (void *)buffer;
+	dma_addr_t dma_src, dma_dst;
+	int bram_offset, err;
 	size_t xtra;
-	int ret;
 
 	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
-	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
-		goto out_copy;
-
-	/* panic_write() may be in an interrupt context */
-	if (in_interrupt() || oops_in_progress)
+	/*
+	 * If the buffer address is not DMA-able, len is not long enough to make
+	 * DMA transfers profitable or panic_write() may be in an interrupt
+	 * context fallback to PIO mode.
+	 */
+	if (!virt_addr_valid(buf) || bram_offset & 3 || (size_t)buf & 3 ||
+	    count < 384 || in_interrupt() || oops_in_progress )
 		goto out_copy;
 
-	if (buf >= high_memory) {
-		struct page *p1;
-
-		if (((size_t)buf & PAGE_MASK) !=
-		    ((size_t)(buf + count - 1) & PAGE_MASK))
-			goto out_copy;
-		p1 = vmalloc_to_page(buf);
-		if (!p1)
-			goto out_copy;
-		buf = page_address(p1) + ((size_t)buf & ~PAGE_MASK);
-	}
-
 	xtra = count & 3;
 	if (xtra) {
 		count -= xtra;
 		memcpy(buf + count, this->base + bram_offset + count, xtra);
 	}
 
+	dma_dst = dma_map_single(dev, buf, count, DMA_FROM_DEVICE);
 	dma_src = c->phys_base + bram_offset;
-	dma_dst = dma_map_single(&c->pdev->dev, buf, count, DMA_FROM_DEVICE);
-	if (dma_mapping_error(&c->pdev->dev, dma_dst)) {
-		dev_err(&c->pdev->dev,
-			"Couldn't DMA map a %d byte buffer\n",
-			count);
-		goto out_copy;
-	}
 
-	ret = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
-	dma_unmap_single(&c->pdev->dev, dma_dst, count, DMA_FROM_DEVICE);
-
-	if (ret) {
-		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
+	if (dma_mapping_error(dev, dma_dst)) {
+		dev_err(dev, "Couldn't DMA map a %d byte buffer\n", count);
 		goto out_copy;
 	}
 
-	return 0;
+	err = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
+	dma_unmap_single(dev, dma_dst, count, DMA_FROM_DEVICE);
+	if (!err)
+		return 0;
+
+	dev_err(dev, "timeout waiting for DMA\n");
 
 out_copy:
 	memcpy(buf, this->base + bram_offset, count);
@@ -439,49 +425,34 @@ static int omap2_onenand_write_bufferram
 {
 	struct omap2_onenand *c = container_of(mtd, struct omap2_onenand, mtd);
 	struct onenand_chip *this = mtd->priv;
-	dma_addr_t dma_src, dma_dst;
-	int bram_offset;
+	struct device *dev = &c->pdev->dev;
 	void *buf = (void *)buffer;
-	int ret;
+	dma_addr_t dma_src, dma_dst;
+	int bram_offset, err;
 
 	bram_offset = omap2_onenand_bufferram_offset(mtd, area) + area + offset;
-	if (bram_offset & 3 || (size_t)buf & 3 || count < 384)
-		goto out_copy;
-
-	/* panic_write() may be in an interrupt context */
-	if (in_interrupt() || oops_in_progress)
+	/*
+	 * If the buffer address is not DMA-able, len is not long enough to make
+	 * DMA transfers profitable or panic_write() may be in an interrupt
+	 * context fallback to PIO mode.
+	 */
+	if (!virt_addr_valid(buf) || bram_offset & 3 || (size_t)buf & 3 ||
+	    count < 384 || in_interrupt() || oops_in_progress )
 		goto out_copy;
 
-	if (buf >= high_memory) {
-		struct page *p1;
-
-		if (((size_t)buf & PAGE_MASK) !=
-		    ((size_t)(buf + count - 1) & PAGE_MASK))
-			goto out_copy;
-		p1 = vmalloc_to_page(buf);
-		if (!p1)
-			goto out_copy;
-		buf = page_address(p1) + ((size_t)buf & ~PAGE_MASK);
-	}
-
-	dma_src = dma_map_single(&c->pdev->dev, buf, count, DMA_TO_DEVICE);
+	dma_src = dma_map_single(dev, buf, count, DMA_TO_DEVICE);
 	dma_dst = c->phys_base + bram_offset;
-	if (dma_mapping_error(&c->pdev->dev, dma_src)) {
-		dev_err(&c->pdev->dev,
-			"Couldn't DMA map a %d byte buffer\n",
-			count);
-		return -1;
-	}
-
-	ret = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
-	dma_unmap_single(&c->pdev->dev, dma_src, count, DMA_TO_DEVICE);
-
-	if (ret) {
-		dev_err(&c->pdev->dev, "timeout waiting for DMA\n");
+	if (dma_mapping_error(dev, dma_src)) {
+		dev_err(dev, "Couldn't DMA map a %d byte buffer\n", count);
 		goto out_copy;
 	}
 
-	return 0;
+	err = omap2_onenand_dma_transfer(c, dma_src, dma_dst, count);
+	dma_unmap_page(dev, dma_src, count, DMA_TO_DEVICE);
+	if (!err)
+		return 0;
+
+	dev_err(dev, "timeout waiting for DMA\n");
 
 out_copy:
 	memcpy(this->base + bram_offset, buf, count);


