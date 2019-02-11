Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BAEC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76303218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZeoP7iHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfBKNUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:20:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfBKNUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+Rdr7puIGsWbHQDOq4MtZ0iJvKMyHWerWF39sIBePIE=; b=ZeoP7iHwrkcrH+KFYz7GIkR56s
        ESj3W1Tse35I6DyvRBid2VLQPikxGVQHLLJaYvIG6RxwCDfYShJkjeHjV3fpYSC8aRj39gvdVe8C9
        6cAPrmdroISHEfmbHL8umLmQVYTrLGBo4wT9ngyv9FRVNbyVj8tQVB+y0132VEgdpsfH8rj75kTgZ
        z1sKik5ETVQtIUleTWDzTOvd2WDUfGqgXNFiLySEXIPxBk3vDOK1sdW1cDdCSEXNUlrjgXy+2iuMZ
        deaCLQZNAAfFlcbZ5C7fHz/tJKuGh3qOzri6Jg+zLMg+/Vn2JKQmih6njteNth93rtR8VuZhjrUgZ
        O+ewuk5Q==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtBVQ-0008GD-Cx; Mon, 11 Feb 2019 13:20:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] macb_main: pass struct device to DMA API functions
Date:   Mon, 11 Feb 2019 14:19:59 +0100
Message-Id: <20190211132004.29143-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211132004.29143-1-hch@lst.de>
References: <20190211132004.29143-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA API generally relies on a struct device to work properly, and
only barely works without one for legacy reasons.  Pass the easily
available struct device from the platform_device to remedy this.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index eaabe8c278ec..4d1509f431d7 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3673,9 +3673,9 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 		/* Store packet information (to free when Tx completed) */
 		lp->skb = skb;
 		lp->skb_length = skb->len;
-		lp->skb_physaddr = dma_map_single(NULL, skb->data, skb->len,
-							DMA_TO_DEVICE);
-		if (dma_mapping_error(NULL, lp->skb_physaddr)) {
+		lp->skb_physaddr = dma_map_single(&lp->pdev->dev, skb->data,
+						  skb->len, DMA_TO_DEVICE);
+		if (dma_mapping_error(&lp->pdev->dev, lp->skb_physaddr)) {
 			dev_kfree_skb_any(skb);
 			dev->stats.tx_dropped++;
 			netdev_err(dev, "%s: DMA mapping error\n", __func__);
@@ -3765,7 +3765,7 @@ static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
 		if (lp->skb) {
 			dev_kfree_skb_irq(lp->skb);
 			lp->skb = NULL;
-			dma_unmap_single(NULL, lp->skb_physaddr,
+			dma_unmap_single(&lp->pdev->dev, lp->skb_physaddr,
 					 lp->skb_length, DMA_TO_DEVICE);
 			dev->stats.tx_packets++;
 			dev->stats.tx_bytes += lp->skb_length;
-- 
2.20.1

