Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F07C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D5620660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LcEZ/Ndc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfANJ6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:58:17 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfANJ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ukM87FMgfgS9ur3gUuVOhxDqT0YWODMmGAJNvyFPMYc=; b=LcEZ/Ndcc3jGQx2CZ13af/Imy3
        0BE2RCQHOyWrgw5kXPCcuAW3vQohRGaY6UUxcn064R9/3bFXvLl3XtoTRvuVzEMnn98BxNEJgSHf8
        lNx2syU97p1WGDIZpg4/ermCt7wQRTYGhB7Y18onqHQLpbKv52khQtxcrhWPtMHNWruAa3iNz5MMt
        zRVoIusxp/OeIRjeMlJm9Ny5MU0UvsRVntcsEWDJM+AySGww90PWFDnXXl9dQVNy6ZFb5IF0/a8Om
        fVAiIzV15SEH/dlRKt5TnCo5g/8MclfzlHTzpxWn8VJUFAhw77jcr33ryzWp1lbsVlH+bydIOqbfg
        7wxtrB4A==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giz0T-0001qz-HZ; Mon, 14 Jan 2019 09:58:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] mmc: davinci: handle highmem pages
Date:   Mon, 14 Jan 2019 10:57:54 +0100
Message-Id: <20190114095804.27978-2-hch@lst.de>
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
 drivers/mmc/host/davinci_mmc.c | 43 ++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 9e68c3645e22..9c500c52b63d 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/cpufreq.h>
+#include <linux/highmem.h>
 #include <linux/mmc/host.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -194,11 +195,12 @@ struct mmc_davinci_host {
 #define DAVINCI_MMC_DATADIR_WRITE	2
 	unsigned char data_dir;
 
-	/* buffer is used during PIO of one scatterlist segment, and
-	 * is updated along with buffer_bytes_left.  bytes_left applies
-	 * to all N blocks of the PIO transfer.
+	/*
+	 * buffer_offset is used during PIO of one scatterlist segment, and is
+	 * updated along with buffer_bytes_left.  bytes_left applies to all N
+	 * blocks of the PIO transfer.
 	 */
-	u8 *buffer;
+	u32 buffer_offset;
 	u32 buffer_bytes_left;
 	u32 bytes_left;
 
@@ -229,8 +231,8 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id);
 /* PIO only */
 static void mmc_davinci_sg_to_buf(struct mmc_davinci_host *host)
 {
+	host->buffer_offset = host->sg->offset;
 	host->buffer_bytes_left = sg_dma_len(host->sg);
-	host->buffer = sg_virt(host->sg);
 	if (host->buffer_bytes_left > host->bytes_left)
 		host->buffer_bytes_left = host->bytes_left;
 }
@@ -238,7 +240,7 @@ static void mmc_davinci_sg_to_buf(struct mmc_davinci_host *host)
 static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 					unsigned int n)
 {
-	u8 *p;
+	void *p;
 	unsigned int i;
 
 	if (host->buffer_bytes_left == 0) {
@@ -246,7 +248,7 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 		mmc_davinci_sg_to_buf(host);
 	}
 
-	p = host->buffer;
+	p = kmap_atomic(sg_page(host->sg));
 	if (n > host->buffer_bytes_left)
 		n = host->buffer_bytes_left;
 	host->buffer_bytes_left -= n;
@@ -258,24 +260,31 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 	 */
 	if (host->data_dir == DAVINCI_MMC_DATADIR_WRITE) {
 		for (i = 0; i < (n >> 2); i++) {
-			writel(*((u32 *)p), host->base + DAVINCI_MMCDXR);
-			p = p + 4;
+			u32 *val = p + host->buffer_offset;
+
+			writel(*val, host->base + DAVINCI_MMCDXR);
+			host->buffer_offset += 4;
 		}
 		if (n & 3) {
-			iowrite8_rep(host->base + DAVINCI_MMCDXR, p, (n & 3));
-			p = p + (n & 3);
+			iowrite8_rep(host->base + DAVINCI_MMCDXR,
+					p + host->buffer_offset, n & 3);
+			host->buffer_offset += (n & 3);
 		}
 	} else {
 		for (i = 0; i < (n >> 2); i++) {
-			*((u32 *)p) = readl(host->base + DAVINCI_MMCDRR);
-			p  = p + 4;
+			u32 *val = p + host->buffer_offset;
+
+			*val = readl(host->base + DAVINCI_MMCDRR);
+			host->buffer_offset += 4;
 		}
 		if (n & 3) {
-			ioread8_rep(host->base + DAVINCI_MMCDRR, p, (n & 3));
-			p = p + (n & 3);
+			ioread8_rep(host->base + DAVINCI_MMCDRR,
+					p + host->buffer_offset, n & 3);
+			host->buffer_offset += (n & 3);
 		}
 	}
-	host->buffer = p;
+
+	kunmap_atomic(p);
 }
 
 static void mmc_davinci_start_command(struct mmc_davinci_host *host,
@@ -572,7 +581,7 @@ mmc_davinci_prepare_data(struct mmc_davinci_host *host, struct mmc_request *req)
 			host->base + DAVINCI_MMCFIFOCTL);
 	}
 
-	host->buffer = NULL;
+	host->buffer_offset = 0;
 	host->bytes_left = data->blocks * data->blksz;
 
 	/* For now we try to use DMA whenever we won't need partial FIFO
-- 
2.20.1

