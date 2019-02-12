Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4372BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0970C2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KVXA7MsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfBLH0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:26:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbfBLH0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Hr3Qhi9mJ6traoG8RuQH0KZd/VGSkf1KHeoWBrtoQQY=; b=KVXA7MsHEid3O1CwEnKfoOoshJ
        6qcdeWLvGLK5asDszwUVeiIE5avG+oEQH4097E/lN0MNUhcuxFiEDf/he0ot0YVJ9aNE/040SKML7
        W5mPYDRhJWwHear3kqLfhkfCRPSZNXfloVJIEcgYIor0EdpJBSHUY+Dv3QgrqePC+WSC/rW7nhZEO
        etVhXQQJaRl5+mWufCpIwKeSSBkIXU8vgC0xOTp+jHZI8ivPPgeCQ5ynpEpZ0N5ZBE+SpXEtlq9Eb
        B5NsVbnU3pBvV7mLAN0w3jjXzjhmy60r9CtMqKJTmzqY2E4NPhJUt784uteM8j7+JwsbHB6gPTWS6
        9aIKsCKA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSS6-0002lW-2f; Tue, 12 Feb 2019 07:25:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/14] mmc: mvsdio: handle highmem pages
Date:   Tue, 12 Feb 2019 08:25:24 +0100
Message-Id: <20190212072528.13167-11-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212072528.13167-1-hch@lst.de>
References: <20190212072528.13167-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of setting up a kernel pointer to track the current PIO address,
track the offset in the current page, and do an atomic kmap for the page
while doing the actual PIO operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/host/mvsdio.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index e22bbff89c8d..d04c78125a4d 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -42,7 +42,8 @@ struct mvsd_host {
 	unsigned int intr_en;
 	unsigned int ctrl;
 	unsigned int pio_size;
-	void *pio_ptr;
+	struct scatterlist *pio_sg;
+	unsigned int pio_offset; /* offset in words into the segment */
 	unsigned int sg_frags;
 	unsigned int ns_per_clk;
 	unsigned int clock;
@@ -96,9 +97,9 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
 	if (tmout_index > MVSD_HOST_CTRL_TMOUT_MAX)
 		tmout_index = MVSD_HOST_CTRL_TMOUT_MAX;
 
-	dev_dbg(host->dev, "data %s at 0x%08x: blocks=%d blksz=%d tmout=%u (%d)\n",
+	dev_dbg(host->dev, "data %s at 0x%08llx: blocks=%d blksz=%d tmout=%u (%d)\n",
 		(data->flags & MMC_DATA_READ) ? "read" : "write",
-		(u32)sg_virt(data->sg), data->blocks, data->blksz,
+		(u64)sg_phys(data->sg), data->blocks, data->blksz,
 		tmout, tmout_index);
 
 	host->ctrl &= ~MVSD_HOST_CTRL_TMOUT_MASK;
@@ -118,10 +119,11 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
 		 * boundary.
 		 */
 		host->pio_size = data->blocks * data->blksz;
-		host->pio_ptr = sg_virt(data->sg);
+		host->pio_sg = data->sg;
+		host->pio_offset = data->sg->offset / 2;
 		if (!nodma)
-			dev_dbg(host->dev, "fallback to PIO for data at 0x%p size %d\n",
-				host->pio_ptr, host->pio_size);
+			dev_dbg(host->dev, "fallback to PIO for data at 0x%x size %d\n",
+				host->pio_offset, host->pio_size);
 		return 1;
 	} else {
 		dma_addr_t phys_addr;
@@ -291,8 +293,9 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
 {
 	void __iomem *iobase = host->base;
 
-	if (host->pio_ptr) {
-		host->pio_ptr = NULL;
+	if (host->pio_sg) {
+		host->pio_sg = NULL;
+		host->pio_offset = 0;
 		host->pio_size = 0;
 	} else {
 		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_frags,
@@ -376,8 +379,10 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 	if (host->pio_size &&
 	    (intr_status & host->intr_en &
 	     (MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W))) {
-		u16 *p = host->pio_ptr;
+		u16 *base = sg_kmap_atomic(host->pio_sg);
+		u16 *p = base + host->pio_offset;
 		int s = host->pio_size;
+
 		while (s >= 32 && (intr_status & MVSD_NOR_RX_FIFO_8W)) {
 			readsw(iobase + MVSD_FIFO, p, 16);
 			p += 16;
@@ -416,13 +421,15 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 		}
 		dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
 			s, intr_status, mvsd_read(MVSD_HW_STATE));
-		host->pio_ptr = p;
+		host->pio_offset = p - base;
 		host->pio_size = s;
+		sg_kunmap_atomic(host->pio_sg, base);
 		irq_handled = 1;
 	} else if (host->pio_size &&
 		   (intr_status & host->intr_en &
 		    (MVSD_NOR_TX_AVAIL | MVSD_NOR_TX_FIFO_8W))) {
-		u16 *p = host->pio_ptr;
+		u16 *base = sg_kmap_atomic(host->pio_sg);
+		u16 *p = base + host->pio_offset;
 		int s = host->pio_size;
 		/*
 		 * The TX_FIFO_8W bit is unreliable. When set, bursting
@@ -453,8 +460,9 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 		}
 		dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
 			s, intr_status, mvsd_read(MVSD_HW_STATE));
-		host->pio_ptr = p;
+		host->pio_offset = p - base;
 		host->pio_size = s;
+		sg_kunmap_atomic(host->pio_sg, base);
 		irq_handled = 1;
 	}
 
@@ -737,6 +745,7 @@ static int mvsd_probe(struct platform_device *pdev)
 	clk_prepare_enable(host->clk);
 
 	mmc->ops = &mvsd_ops;
+	mmc->need_kmap = 1;
 
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 
-- 
2.20.1

