Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25827C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85BF20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nvuGuEGr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfANJ7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:59:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60210 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfANJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:58:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WZ9aJEBC7EdGRYOFoux4r/SaAviNsLiJM7mr7nUt+xw=; b=nvuGuEGrA6lXHBJRocmbjOMDkC
        rjtYKqaMNZD89cnBBBEc9TaCCIY4SJmclUvcYTq6q0KxAVQo27rv6SZYzsw0cBdyntMggVaO/M/pO
        QMyTS+ZENRDdGQizbQv0uMijvWGGXw1FpdxaQlc4Jyqh9ppgLpo+lhFeM+C164s7T/TeaG9wPjRbG
        9OcCwqD4tRdSb8x1zrSMGSjc5jyFtchgsYLpGFwr4xh65JFiOJ2IBwqh4Zt8eGOZEwAsYWz52B3GP
        JndHaGVbDdogHR+FpV5Eck9L4IGymJFtCzF4U2FIaaBr1cYPtYsQG4yeEkgUNzBWk6KNxvPmA4yrz
        UAfnTcwA==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giz0k-000250-Ag; Mon, 14 Jan 2019 09:58:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] mmc: s3cmci: handle chained sglists
Date:   Mon, 14 Jan 2019 10:57:59 +0100
Message-Id: <20190114095804.27978-7-hch@lst.de>
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

Use the proper sg_next() helper to move to the next scatterlist element
to support chained scatterlists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/host/s3cmci.c | 19 +++++++++----------
 drivers/mmc/host/s3cmci.h |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 1be84426c817..2660fb61d1d0 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -320,20 +320,19 @@ static void s3cmci_check_sdio_irq(struct s3cmci_host *host)
 
 static inline int get_data_buffer(struct s3cmci_host *host)
 {
-	if (host->pio_sgptr >= host->mrq->data->sg_len) {
-		dbg(host, dbg_debug, "no more buffers (%i/%i)\n",
-		      host->pio_sgptr, host->mrq->data->sg_len);
+	if (!host->next_sg) {
+		dbg(host, dbg_debug, "no more buffers (%i)\n",
+		      host->mrq->data->sg_len);
 		return -EBUSY;
 	}
-	host->cur_sg = &host->mrq->data->sg[host->pio_sgptr];
+	host->cur_sg = host->next_sg;
+	host->next_sg = sg_next(host->next_sg);
 
 	host->pio_bytes = host->cur_sg->length;
 	host->pio_offset = host->cur_sg->offset;
 
-	host->pio_sgptr++;
-
-	dbg(host, dbg_sg, "new buffer (%i/%i)\n",
-	    host->pio_sgptr, host->mrq->data->sg_len);
+	dbg(host, dbg_sg, "new buffer (%i)\n",
+	    host->mrq->data->sg_len);
 
 	return 0;
 }
@@ -1052,8 +1051,8 @@ static int s3cmci_prepare_pio(struct s3cmci_host *host, struct mmc_data *data)
 
 	BUG_ON((data->flags & BOTH_DIR) == BOTH_DIR);
 
-	host->pio_sgptr = 0;
-	host->cur_sg = &host->mrq->data->sg[host->pio_sgptr];
+	host->cur_sg = host->mrq->data->sg;
+	host->next_sg = sg_next(host->cur_sg);
 	host->pio_bytes = 0;
 	host->pio_count = 0;
 	host->pio_active = rw ? XFER_WRITE : XFER_READ;
diff --git a/drivers/mmc/host/s3cmci.h b/drivers/mmc/host/s3cmci.h
index 4320f7d832dc..caf1078d07d1 100644
--- a/drivers/mmc/host/s3cmci.h
+++ b/drivers/mmc/host/s3cmci.h
@@ -51,7 +51,7 @@ struct s3cmci_host {
 	int			dma_complete;
 
 	struct scatterlist	*cur_sg;
-	u32			pio_sgptr;
+	struct scatterlist	*next_sg;
 	u32			pio_bytes;
 	u32			pio_count;
 	u32			pio_offset;
-- 
2.20.1

