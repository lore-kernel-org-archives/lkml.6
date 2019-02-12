Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E105CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1382186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aw+TPjn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfBLHZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:25:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57820 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBLHZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X7acI9+T4s0sysdc/0cb9IiZBmC/K8FNZBk+vRCRvWI=; b=aw+TPjn3RJidxYZ+NX+n8/W1ED
        X8hgIvBAEC5uqTz80Zud6QokdPJiVLib0q8PJhl1K1ACO/Ofhm4Qa8+JDmWpSsOM0XnxUkn8iDfXV
        BXBzoENsuKyhthQjLkxjG5zv4IDxeXBZxw6n3tznJqB+eHvS4tFrQwcTRhXxD4fTE7m3DT8a0DD+A
        YdXiK7WJx/rg4Lpw/dqc12gZtxinc5Hx9xUCUQr2tVDfyAHctiteBLbjsObG9zumujK/nCmk2IGS0
        FOAAWhi2QppdQWhTfyvoGsWK3HNeESO0HiBdLcrmcLWBihsedSLRtOxv1KPfvQ4/VOX7ZPewBVI0p
        9v2MsmJA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSRm-0002P6-HK; Tue, 12 Feb 2019 07:25:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] mmc: add a need_kmap flag to struct mmc_host
Date:   Tue, 12 Feb 2019 08:25:17 +0100
Message-Id: <20190212072528.13167-4-hch@lst.de>
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

If we want to get rid of the block layer bounce buffering for highmem we
need to ensure no segment spans multiple pages so that we can kmap it.
Add a flag to struct mmc_host so that we can handle the block and DMA
layer interactions in common code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/core/queue.c | 13 +++++++++++++
 include/linux/mmc/host.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 35cc138b096d..71cd2411329e 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -370,6 +370,19 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 	blk_queue_max_segments(mq->queue, host->max_segs);
 	blk_queue_max_segment_size(mq->queue, host->max_seg_size);
 
+	/*
+	 * If the host requires kmapping for PIO we need to ensure
+	 * that no segment spans a page boundary.
+	 */
+	if (host->need_kmap) {
+		unsigned int dma_boundary = host->max_seg_size - 1;
+
+		if (dma_boundary >= PAGE_SIZE)
+			dma_boundary = PAGE_SIZE - 1;
+		blk_queue_segment_boundary(mq->queue, dma_boundary);
+		dma_set_seg_boundary(mmc_dev(host), dma_boundary);
+	}
+
 	INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
 	INIT_WORK(&mq->complete_work, mmc_blk_mq_complete_work);
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4eadf01b4a93..87f8a89d2f70 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -397,6 +397,7 @@ struct mmc_host {
 	unsigned int		doing_retune:1;	/* re-tuning in progress */
 	unsigned int		retune_now:1;	/* do re-tuning at next req */
 	unsigned int		retune_paused:1; /* re-tuning is temporarily disabled */
+	unsigned int		need_kmap:1;	/* only allow single page segments */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
-- 
2.20.1

