Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38802C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0431B218AD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RosC/wCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfBLH0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:26:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59634 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfBLH0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:26:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DQRosv6F/JNDXaNNATTNtmbVxExkGx6fJzLxjv+dNf0=; b=RosC/wCxACXyDEaxwovI0VdYkd
        miNeWvCXMcfPzcKiL8tO2szO4X1y2wZMlg4lmv+NZVsnV/HXtgQRAPo1Pli0LZmJgxSfqLEQ0qnGZ
        XejjnF/ajHCEPM8l12yyPh9XKk39iflPMSTXY6c3EF47aELrLSqjch0FlVLGLkqQ6x0FtEvhb1aH3
        gPTdRBdPSIc6IsTNBvzHS9qNIU3P5JC07ZsQZlWIKjr4iW8+vbuFfi6VqCGRodsjLgY2o+GCgkzuh
        wErcGJEc8KDqJ7AtHjiMoiJPpMnOGrveP1WC2p32vHBpsoUTADm9gL3PhsXelZH+YDkT1d8rdBuYi
        5b4CX4cQ==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSS3-0002iH-Gu; Tue, 12 Feb 2019 07:25:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/14] mmc: s3cmci: handle chained sglists
Date:   Tue, 12 Feb 2019 08:25:23 +0100
Message-Id: <20190212072528.13167-10-hch@lst.de>
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

Use the proper sg_next() helper to move to the next scatterlist element
to support chained scatterlists.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/host/s3cmci.c | 19 +++++++++----------
 drivers/mmc/host/s3cmci.h |  2 +-
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 989fefea19f1..df7c27f78abf 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -319,20 +319,19 @@ static void s3cmci_check_sdio_irq(struct s3cmci_host *host)
 
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
@@ -1051,8 +1050,8 @@ static int s3cmci_prepare_pio(struct s3cmci_host *host, struct mmc_data *data)
 
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

