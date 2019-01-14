Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D03FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C5F2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JvpY1zkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfANJ6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:58:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfANJ6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RtgWLmRaQa8Vtp2WR0jaqmktdlYG16bsRVyK1TK9/tw=; b=JvpY1zkCyh99fpfRANl3nAXYCv
        0l+F4ZtYUHCMbspkFJQJT+Zv7oLBD2CyAAM8h6B9Qo6QdoBinDKwm3ZsoGxh3Uace5FxYFHLzLbKH
        lgbxhdvia3xTtXuFRXpFaocWkWwqZrwiXUWqwYvZ31zdTfercbn8FkWAFLHr0IUpxeBR8UusMbK5D
        z6fwN46Cs5WO0FfJvx/Ed/oVwbSaUj2jN3tIl4JQW9ifDOLbbf2ZfPa5t1xZ5h1U733bOpAumv8I3
        JeTkUULPMcR9HWo4nuH8Y8J+g9TTC2ZnGHdP338fw0VUyNzkz27YAiK/yjTSJ9L8VqqxQOgdB5eiF
        5RsrFASA==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giz0o-00028p-5p; Mon, 14 Jan 2019 09:58:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] mmc: mvsdio: handle highmem pages
Date:   Mon, 14 Jan 2019 10:58:00 +0100
Message-Id: <20190114095804.27978-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114095804.27978-1-hch@lst.de>
References: <20190114095804.27978-1-hch@lst.de>
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
 drivers/mmc/host/mvsdio.c | 48 +++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index e22bbff89c8d..545e370d6dae 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/io.h>
+#include <linux/highmem.h>
 #include <linux/platform_device.h>
 #include <linux/mbus.h>
 #include <linux/delay.h>
@@ -42,7 +43,8 @@ struct mvsd_host {
 	unsigned int intr_en;
 	unsigned int ctrl;
 	unsigned int pio_size;
-	void *pio_ptr;
+	struct scatterlist *pio_sg;
+	unsigned int pio_offset; /* offset in words into the segment */
 	unsigned int sg_frags;
 	unsigned int ns_per_clk;
 	unsigned int clock;
@@ -96,9 +98,9 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
 	if (tmout_index > MVSD_HOST_CTRL_TMOUT_MAX)
 		tmout_index = MVSD_HOST_CTRL_TMOUT_MAX;
 
-	dev_dbg(host->dev, "data %s at 0x%08x: blocks=%d blksz=%d tmout=%u (%d)\n",
+	dev_dbg(host->dev, "data %s at 0x%08llx: blocks=%d blksz=%d tmout=%u (%d)\n",
 		(data->flags & MMC_DATA_READ) ? "read" : "write",
-		(u32)sg_virt(data->sg), data->blocks, data->blksz,
+		(u64)sg_phys(data->sg), data->blocks, data->blksz,
 		tmout, tmout_index);
 
 	host->ctrl &= ~MVSD_HOST_CTRL_TMOUT_MASK;
@@ -118,10 +120,11 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
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
@@ -291,8 +294,9 @@ static u32 mvsd_finish_data(struct mvsd_host *host, struct mmc_data *data,
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
@@ -376,11 +380,12 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 	if (host->pio_size &&
 	    (intr_status & host->intr_en &
 	     (MVSD_NOR_RX_READY | MVSD_NOR_RX_FIFO_8W))) {
-		u16 *p = host->pio_ptr;
+		u16 *p = kmap_atomic(sg_page(host->pio_sg));
+		unsigned int o = host->pio_offset;
 		int s = host->pio_size;
 		while (s >= 32 && (intr_status & MVSD_NOR_RX_FIFO_8W)) {
-			readsw(iobase + MVSD_FIFO, p, 16);
-			p += 16;
+			readsw(iobase + MVSD_FIFO, p + o, 16);
+			o += 16;
 			s -= 32;
 			intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
 		}
@@ -391,8 +396,10 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 		 */
 		if (s <= 32) {
 			while (s >= 4 && (intr_status & MVSD_NOR_RX_READY)) {
-				put_unaligned(mvsd_read(MVSD_FIFO), p++);
-				put_unaligned(mvsd_read(MVSD_FIFO), p++);
+				put_unaligned(mvsd_read(MVSD_FIFO), p + o);
+				o++;
+				put_unaligned(mvsd_read(MVSD_FIFO), p + o);
+				o++;
 				s -= 4;
 				intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
 			}
@@ -400,7 +407,7 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 				u16 val[2] = {0, 0};
 				val[0] = mvsd_read(MVSD_FIFO);
 				val[1] = mvsd_read(MVSD_FIFO);
-				memcpy(p, ((void *)&val) + 4 - s, s);
+				memcpy(p + o, ((void *)&val) + 4 - s, s);
 				s = 0;
 				intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
 			}
@@ -416,13 +423,14 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 		}
 		dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
 			s, intr_status, mvsd_read(MVSD_HW_STATE));
-		host->pio_ptr = p;
+		host->pio_offset = o;
 		host->pio_size = s;
 		irq_handled = 1;
 	} else if (host->pio_size &&
 		   (intr_status & host->intr_en &
 		    (MVSD_NOR_TX_AVAIL | MVSD_NOR_TX_FIFO_8W))) {
-		u16 *p = host->pio_ptr;
+		u16 *p = kmap_atomic(sg_page(host->pio_sg));
+		unsigned int o = host->pio_offset;
 		int s = host->pio_size;
 		/*
 		 * The TX_FIFO_8W bit is unreliable. When set, bursting
@@ -431,8 +439,10 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 		 * TX_FIFO_8W remains set.
 		 */
 		while (s >= 4 && (intr_status & MVSD_NOR_TX_AVAIL)) {
-			mvsd_write(MVSD_FIFO, get_unaligned(p++));
-			mvsd_write(MVSD_FIFO, get_unaligned(p++));
+			mvsd_write(MVSD_FIFO, get_unaligned(p + o));
+			o++;
+			mvsd_write(MVSD_FIFO, get_unaligned(p + o));
+			o++;
 			s -= 4;
 			intr_status = mvsd_read(MVSD_NOR_INTR_STATUS);
 		}
@@ -453,7 +463,7 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 		}
 		dev_dbg(host->dev, "pio %d intr 0x%04x hw_state 0x%04x\n",
 			s, intr_status, mvsd_read(MVSD_HW_STATE));
-		host->pio_ptr = p;
+		host->pio_offset = o;
 		host->pio_size = s;
 		irq_handled = 1;
 	}
-- 
2.20.1

