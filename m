Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ABBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475A82086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ry3vZ+Uw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfANJ6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:58:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58764 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfANJ6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/s++KaySvR6D7mjFJB7ah1oNqG5vMse2K9rQmUXPq24=; b=ry3vZ+UwWbCPrLNsQH04P3GtCr
        UxzzopGXuf4S/v937V4B1tmp6v25zNN+juuQxoSeRjkhmPkbLUuayiRea0uPS8JXVh4e0L5sIE92h
        6oVMYinALLdAniIfpXfAunS4dOAZp7RlCxJwuHvXDmHSYOk5hsu0E6hmCpoxgrrRrPCnPqylPzCkH
        TBae4GLCecXMu0hXqni5Vipy6UEldy97NkAUeWqXN9dXkgO8GFX/DYULLwTvBkOkxqqAIqn89wez5
        Ln17bBpnBVEyKcOyBnO19NIQT0T4KJA4lz+vYK8zinjbQW025So8qmpDJ5EROrb6NAFdJjgMCUrjg
        KDcFoVWQ==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giz0g-00021E-SG; Mon, 14 Jan 2019 09:58:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] mmc: s3cmci: handle highmem pages
Date:   Mon, 14 Jan 2019 10:57:58 +0100
Message-Id: <20190114095804.27978-6-hch@lst.de>
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
 drivers/mmc/host/s3cmci.c | 107 +++++++++++++++++++-------------------
 drivers/mmc/host/s3cmci.h |   3 +-
 2 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 10f5219b3b40..1be84426c817 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -15,6 +15,7 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/clk.h>
+#include <linux/highmem.h>
 #include <linux/mmc/host.h>
 #include <linux/platform_device.h>
 #include <linux/cpufreq.h>
@@ -317,26 +318,17 @@ static void s3cmci_check_sdio_irq(struct s3cmci_host *host)
 	}
 }
 
-static inline int get_data_buffer(struct s3cmci_host *host,
-				  u32 *bytes, u32 **pointer)
+static inline int get_data_buffer(struct s3cmci_host *host)
 {
-	struct scatterlist *sg;
-
-	if (host->pio_active == XFER_NONE)
-		return -EINVAL;
-
-	if ((!host->mrq) || (!host->mrq->data))
-		return -EINVAL;
-
 	if (host->pio_sgptr >= host->mrq->data->sg_len) {
 		dbg(host, dbg_debug, "no more buffers (%i/%i)\n",
 		      host->pio_sgptr, host->mrq->data->sg_len);
 		return -EBUSY;
 	}
-	sg = &host->mrq->data->sg[host->pio_sgptr];
+	host->cur_sg = &host->mrq->data->sg[host->pio_sgptr];
 
-	*bytes = sg->length;
-	*pointer = sg_virt(sg);
+	host->pio_bytes = host->cur_sg->length;
+	host->pio_offset = host->cur_sg->offset;
 
 	host->pio_sgptr++;
 
@@ -422,11 +414,16 @@ static void s3cmci_disable_irq(struct s3cmci_host *host, bool transfer)
 
 static void do_pio_read(struct s3cmci_host *host)
 {
-	int res;
 	u32 fifo;
 	u32 *ptr;
 	u32 fifo_words;
 	void __iomem *from_ptr;
+	void *buf;
+
+	if (host->pio_active == XFER_NONE)
+		goto done;
+	if (!host->mrq || !host->mrq->data)
+		goto done;
 
 	/* write real prescaler to host, it might be set slow to fix */
 	writel(host->prescaler, host->base + S3C2410_SDIPRE);
@@ -435,20 +432,12 @@ static void do_pio_read(struct s3cmci_host *host)
 
 	while ((fifo = fifo_count(host))) {
 		if (!host->pio_bytes) {
-			res = get_data_buffer(host, &host->pio_bytes,
-					      &host->pio_ptr);
-			if (res) {
-				host->pio_active = XFER_NONE;
-				host->complete_what = COMPLETION_FINALIZE;
-
-				dbg(host, dbg_pio, "pio_read(): "
-				    "complete (no more data).\n");
-				return;
-			}
+			if (get_data_buffer(host) < 0)
+				goto done;
 
 			dbg(host, dbg_pio,
-			    "pio_read(): new target: [%i]@[%p]\n",
-			    host->pio_bytes, host->pio_ptr);
+			    "pio_read(): new target: [%i]@[%zu]\n",
+			    host->pio_bytes, host->pio_offset);
 		}
 
 		dbg(host, dbg_pio,
@@ -470,63 +459,65 @@ static void do_pio_read(struct s3cmci_host *host)
 		host->pio_count += fifo;
 
 		fifo_words = fifo >> 2;
-		ptr = host->pio_ptr;
-		while (fifo_words--)
+	
+		buf = (kmap_atomic(sg_page(host->cur_sg)) + host->pio_offset);
+		ptr = buf;
+		while (fifo_words--) {
 			*ptr++ = readl(from_ptr);
-		host->pio_ptr = ptr;
+			host->pio_offset += 4;
+		}
 
 		if (fifo & 3) {
 			u32 n = fifo & 3;
 			u32 data = readl(from_ptr);
-			u8 *p = (u8 *)host->pio_ptr;
+			u8 *p = (u8 *)ptr;
 
 			while (n--) {
 				*p++ = data;
 				data >>= 8;
+				host->pio_offset++;
 			}
 		}
+		kunmap_atomic(buf);
 	}
 
 	if (!host->pio_bytes) {
-		res = get_data_buffer(host, &host->pio_bytes, &host->pio_ptr);
-		if (res) {
-			dbg(host, dbg_pio,
-			    "pio_read(): complete (no more buffers).\n");
-			host->pio_active = XFER_NONE;
-			host->complete_what = COMPLETION_FINALIZE;
-
-			return;
-		}
+		if (get_data_buffer(host) < 0)
+			goto done;
 	}
 
 	enable_imask(host,
 		     S3C2410_SDIIMSK_RXFIFOHALF | S3C2410_SDIIMSK_RXFIFOLAST);
+	return;
+
+done:
+	host->pio_active = XFER_NONE;
+	host->complete_what = COMPLETION_FINALIZE;
+	dbg(host, dbg_pio, "pio_read(): complete (no more data).\n");
 }
 
 static void do_pio_write(struct s3cmci_host *host)
 {
 	void __iomem *to_ptr;
-	int res;
+	void *buf;
 	u32 fifo;
 	u32 *ptr;
 
+	if (host->pio_active == XFER_NONE)
+		goto done;
+	if (!host->mrq || !host->mrq->data)
+		goto done;
+
 	to_ptr = host->base + host->sdidata;
 
 	while ((fifo = fifo_free(host)) > 3) {
 		if (!host->pio_bytes) {
-			res = get_data_buffer(host, &host->pio_bytes,
-							&host->pio_ptr);
-			if (res) {
-				dbg(host, dbg_pio,
-				    "pio_write(): complete (no more data).\n");
-				host->pio_active = XFER_NONE;
-
-				return;
-			}
+			if (get_data_buffer(host) < 0)
+				goto done;
 
 			dbg(host, dbg_pio,
-			    "pio_write(): new source: [%i]@[%p]\n",
-			    host->pio_bytes, host->pio_ptr);
+			    "pio_write(): new source: [%i]@[%zd]\n",
+			    host->pio_bytes, host->pio_offset);
 
 		}
 
@@ -543,13 +534,20 @@ static void do_pio_write(struct s3cmci_host *host)
 		host->pio_count += fifo;
 
 		fifo = (fifo + 3) >> 2;
-		ptr = host->pio_ptr;
-		while (fifo--)
+		buf = (kmap_atomic(sg_page(host->cur_sg)) + host->pio_offset);
+		ptr = buf;
+		while (fifo--) {
 			writel(*ptr++, to_ptr);
-		host->pio_ptr = ptr;
+			host->pio_offset += 4;
+		}
+		kunmap_atomic(buf);
 	}
 
 	enable_imask(host, S3C2410_SDIIMSK_TXFIFOHALF);
+	return;
+done:
+	dbg(host, dbg_pio, "pio_write(): complete (no more data).\n");
+	host->pio_active = XFER_NONE;
 }
 
 static void pio_tasklet(unsigned long data)
@@ -1055,6 +1053,7 @@ static int s3cmci_prepare_pio(struct s3cmci_host *host, struct mmc_data *data)
 	BUG_ON((data->flags & BOTH_DIR) == BOTH_DIR);
 
 	host->pio_sgptr = 0;
+	host->cur_sg = &host->mrq->data->sg[host->pio_sgptr];
 	host->pio_bytes = 0;
 	host->pio_count = 0;
 	host->pio_active = rw ? XFER_WRITE : XFER_READ;
diff --git a/drivers/mmc/host/s3cmci.h b/drivers/mmc/host/s3cmci.h
index 30c2c0dd1bc8..4320f7d832dc 100644
--- a/drivers/mmc/host/s3cmci.h
+++ b/drivers/mmc/host/s3cmci.h
@@ -50,10 +50,11 @@ struct s3cmci_host {
 
 	int			dma_complete;
 
+	struct scatterlist	*cur_sg;
 	u32			pio_sgptr;
 	u32			pio_bytes;
 	u32			pio_count;
-	u32			*pio_ptr;
+	u32			pio_offset;
 #define XFER_NONE 0
 #define XFER_READ 1
 #define XFER_WRITE 2
-- 
2.20.1

