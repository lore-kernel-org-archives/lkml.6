Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEC3C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA092186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZkPQ8ObZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfBLH0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:26:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60256 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbfBLH0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GGjmjraVIn+2mB2UvfK5xi66lVDamNQYiimNQrqXuz0=; b=ZkPQ8ObZwywEjm8WjiDqbCy/8h
        g/HLsgH4lKO3zRGNkFYlAtI8VLbmee3N4VecXfmzG2AuXOxvb0mfNxA9D8BZn+KvE8cijbo9Yl26M
        z9oABCMTnKO15P/o4CT/UpEs23a0CxVCjpBnIhpyH5Kv+H7XwR1tgY68UK0faM8LbTwdUTjP5r7G7
        fFMNJ7dLGhQazIcz+JIdU22ECsOXzE1bZqj65lXTnyLDYoETFNKohddTdjFdNIBsVvP4yavsGGOs1
        dzvsgtevy6gX7qiAjZq3qmOuDTy2WPr3vhrCGNK2XF0zh8w8StGhBWDzHDDrczFKyNT7UDFknM0Ka
        ejZSb/TQ==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSSE-0002ty-4k; Tue, 12 Feb 2019 07:26:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] mmc: core: don't use block layer bounce buffers
Date:   Tue, 12 Feb 2019 08:25:27 +0100
Message-Id: <20190212072528.13167-14-hch@lst.de>
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

All MMC and SD host drivers are highmem safe now, and bounce buffering
for addressing limitations is handled in the DMA layer now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/core/queue.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 71cd2411329e..1c92a2a4d641 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -354,17 +354,12 @@ static const struct blk_mq_ops mmc_mq_ops = {
 static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
-	u64 limit = BLK_BOUNCE_HIGH;
-
-	if (mmc_dev(host)->dma_mask && *mmc_dev(host)->dma_mask)
-		limit = (u64)dma_max_pfn(mmc_dev(host)) << PAGE_SHIFT;
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, mq->queue);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, mq->queue);
 	if (mmc_can_erase(card))
 		mmc_queue_setup_discard(mq->queue, card);
 
-	blk_queue_bounce_limit(mq->queue, limit);
 	blk_queue_max_hw_sectors(mq->queue,
 		min(host->max_blk_count, host->max_req_size / 512));
 	blk_queue_max_segments(mq->queue, host->max_segs);
-- 
2.20.1

