Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5B6C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB1022433
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tT/wMuG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB1022433
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933796AbeFUVej (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:34:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41782 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933957AbeFUV3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wesYzO7sUKPy+4+U70aatZEC6CUjHr8ewqO8wP2zFc8=; b=tT/wMuG5svtem8e/qZCdh8FWt
        Sxyj2L92E1KbH4bmdJ14fzGiphA9Si/v0ev1+nR9Q0PGgyg8xvz25WHQ448Hwu9M8hXf7Ln/DSyRI
        EyTqrFwJ1F+jU9ThbuBd2r811nP1VeSRWYirJw3k05ht/DKDis9w2Fw1r52RiC2bUh9BA+8gHxUwy
        NvYkPByLU2KOZOmUwwypzREAZeMrP9ywUoROtMida23AzDGEdoFso9SNBpk0P6d012s98sX0tUJlr
        qzoPxqTOboWdSArQnUmcGXXpKTp+rZBU7+1dLsI4VsbZvsm/MlJYBVgdqEceRs0Gqi+83a0S1iBoR
        R9QbBirNg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78f-0001c6-Or; Thu, 21 Jun 2018 21:29:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Subject: [PATCH 16/26] dmaengine: Convert to new IDA API
Date:   Thu, 21 Jun 2018 14:28:25 -0700
Message-Id: <20180621212835.5636-17-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simpler and shorter code.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/dma/dmaengine.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 08ba8473a284..1e9bdadfc312 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -161,9 +161,7 @@ static void chan_dev_release(struct device *dev)
 
 	chan_dev = container_of(dev, typeof(*chan_dev), device);
 	if (atomic_dec_and_test(chan_dev->idr_ref)) {
-		mutex_lock(&dma_list_mutex);
-		ida_remove(&dma_ida, chan_dev->dev_id);
-		mutex_unlock(&dma_list_mutex);
+		ida_free(&dma_ida, chan_dev->dev_id);
 		kfree(chan_dev->idr_ref);
 	}
 	kfree(chan_dev);
@@ -896,16 +894,10 @@ static bool device_has_all_tx_types(struct dma_device *device)
 
 static int get_dma_id(struct dma_device *device)
 {
-	int rc;
-
-	do {
-		if (!ida_pre_get(&dma_ida, GFP_KERNEL))
-			return -ENOMEM;
-		mutex_lock(&dma_list_mutex);
-		rc = ida_get_new(&dma_ida, &device->dev_id);
-		mutex_unlock(&dma_list_mutex);
-	} while (rc == -EAGAIN);
+	int rc = ida_alloc(&dma_ida, GFP_KERNEL);
 
+	if (rc >= 0)
+		device->dev_id = rc;
 	return rc;
 }
 
@@ -1090,9 +1082,7 @@ int dma_async_device_register(struct dma_device *device)
 err_out:
 	/* if we never registered a channel just release the idr */
 	if (atomic_read(idr_ref) == 0) {
-		mutex_lock(&dma_list_mutex);
-		ida_remove(&dma_ida, device->dev_id);
-		mutex_unlock(&dma_list_mutex);
+		ida_free(&dma_ida, device->dev_id);
 		kfree(idr_ref);
 		return rc;
 	}
-- 
2.17.1

