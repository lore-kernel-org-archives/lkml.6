Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E36EC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0872186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tCKaoWrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfBLH0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:26:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58996 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbfBLH0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ziHP/B7eY+NBjALraVBoRKxJXXxl1F0JJMvkdVloYqE=; b=tCKaoWrDAxPhH0QZm07AWbPc16
        aZDS+f9ojEpl58L9vbK2sp0Oj+AlVrW5aFKZqXHKW1dza2OAV1RQoZp3in1/ZxyporPoxC+RUwsn/
        funk3sbFKyGL1TEYAh3UN7dkvXSopVS6Bu/gkA2v7PAK7X/2U7DaPZxAJQPNemNLJ2AEwxTxRgCYf
        X7b1O48YOvffuPuJzck54tvC2xfWimjKoftoKROteUm6+uJjETXJwpOOZkscrDn9LcPr271X2g2Z6
        WR7wnxleN5yLwciB0Tg8sX82MluwF5vLEYLuJ56wascFixrjbpVFORLhfePPZwqxp/0/cLMhtoWEQ
        mYE+Zx5Q==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSRx-0002b4-DI; Tue, 12 Feb 2019 07:25:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/14] mmc: omap: handle chained sglists
Date:   Tue, 12 Feb 2019 08:25:21 +0100
Message-Id: <20190212072528.13167-8-hch@lst.de>
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
 drivers/mmc/host/omap.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 6741c95f2281..8cd39bc087fa 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -147,7 +147,7 @@ struct mmc_omap_host {
 	struct mmc_data		*stop_data;
 
 	unsigned int		sg_len;
-	int			sg_idx;
+	struct scatterlist	*cur_sg;
 	u32			buffer_offset;
 	u32			buffer_bytes_left;
 	u32			total_bytes_left;
@@ -645,11 +645,8 @@ mmc_omap_cmd_timer(struct timer_list *t)
 static void
 mmc_omap_sg_to_buf(struct mmc_omap_host *host)
 {
-	struct scatterlist *sg;
-
-	sg = host->data->sg + host->sg_idx;
-	host->buffer_bytes_left = sg->length;
-	host->buffer_offset = sg->offset;
+	host->buffer_bytes_left = host->cur_sg->length;
+	host->buffer_offset = host->cur_sg->offset;
 	if (host->buffer_bytes_left > host->total_bytes_left)
 		host->buffer_bytes_left = host->total_bytes_left;
 }
@@ -666,13 +663,12 @@ mmc_omap_clk_timer(struct timer_list *t)
 static void
 mmc_omap_xfer_data(struct mmc_omap_host *host, int write)
 {
-	struct scatterlist *sg = host->data->sg + host->sg_idx;
+	struct scatterlist *sg = host->cur_sg;
 	int n, nwords;
 	void *p;
 
 	if (host->buffer_bytes_left == 0) {
-		host->sg_idx++;
-		BUG_ON(host->sg_idx == host->sg_len);
+		host->cur_sg = sg_next(host->cur_sg);
 		mmc_omap_sg_to_buf(host);
 	}
 	n = 64;
@@ -984,7 +980,7 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
 		}
 	}
 
-	host->sg_idx = 0;
+	host->cur_sg = host->data->sg;
 	if (use_dma) {
 		enum dma_data_direction dma_data_dir;
 		struct dma_async_tx_descriptor *tx;
-- 
2.20.1

