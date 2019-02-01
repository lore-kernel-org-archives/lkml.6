Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D60C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D80218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LiBiSbGo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbfBAIsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:48:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729556AbfBAIsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zMOwIVCHl/3RSZU/IZr6L//+E7MYj6EUe0TSRYGQl6Y=; b=LiBiSbGo5IPnaiejGCGng1QljA
        HXZ0WUc3L7YVimZ6z5jlGBboZ6YKdo0uuqUXkSy7TTJ7B0WtVhWzHy/wNo67WNS05CNQG6NvCFjDa
        EoqpHqEGFt0HlWOBcOYyH0UwiXtXoP94ercGnU5TanudT4wNnJTQM1/JXUhkTXal3OkAf6SAGNwjR
        oxd++UEQZvm6Ydtaw90HkQjqPX0E+MySMhsSV3zrkG/xjg0EW4T+syCVvv6Do8R8pfquQsukrPTqa
        L1XHHiLiigjJJlehTCiDF51ptjTXYtPEaMlwEv1//KHKdrLmaGTBvZE0kCeS1H0XZ8dGNmlXPs8eJ
        GA1QbSKA==;
Received: from 089144212163.atnat0021.highway.a1.net ([89.144.212.163] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gpUUs-0001Qm-OP; Fri, 01 Feb 2019 08:48:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     John Crispin <john@phrozen.org>, Vinod Koul <vkoul@kernel.org>,
        Dmitry Tarnyagin <dmitry.tarnyagin@lockless.no>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Felipe Balbi <balbi@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     iommu@lists.linux-foundation.org
Subject: [PATCH 09/18] meth: pass struct device to DMA API functions
Date:   Fri,  1 Feb 2019 09:47:52 +0100
Message-Id: <20190201084801.10983-10-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201084801.10983-1-hch@lst.de>
References: <20190201084801.10983-1-hch@lst.de>
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

Also use GFP_KERNEL instead of GFP_ATOMIC as the gfp_t for the memory
allocation, as we aren't in interrupt context or under a lock.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/ethernet/sgi/meth.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/sgi/meth.c b/drivers/net/ethernet/sgi/meth.c
index 0e1b7e960b98..67954a9e3675 100644
--- a/drivers/net/ethernet/sgi/meth.c
+++ b/drivers/net/ethernet/sgi/meth.c
@@ -68,6 +68,8 @@ module_param(timeout, int, 0);
  * packets in and out, so there is place for a packet
  */
 struct meth_private {
+	struct platform_device *pdev;
+
 	/* in-memory copy of MAC Control register */
 	u64 mac_ctrl;
 
@@ -211,8 +213,8 @@ static void meth_check_link(struct net_device *dev)
 static int meth_init_tx_ring(struct meth_private *priv)
 {
 	/* Init TX ring */
-	priv->tx_ring = dma_alloc_coherent(NULL, TX_RING_BUFFER_SIZE,
-					   &priv->tx_ring_dma, GFP_ATOMIC);
+	priv->tx_ring = dma_alloc_coherent(&priv->pdev->dev,
+			TX_RING_BUFFER_SIZE, &priv->tx_ring_dma, GFP_KERNEL);
 	if (!priv->tx_ring)
 		return -ENOMEM;
 
@@ -236,7 +238,7 @@ static int meth_init_rx_ring(struct meth_private *priv)
 		priv->rx_ring[i]=(rx_packet*)(priv->rx_skbs[i]->head);
 		/* I'll need to re-sync it after each RX */
 		priv->rx_ring_dmas[i] =
-			dma_map_single(NULL, priv->rx_ring[i],
+			dma_map_single(&priv->pdev->dev, priv->rx_ring[i],
 				       METH_RX_BUFF_SIZE, DMA_FROM_DEVICE);
 		mace->eth.rx_fifo = priv->rx_ring_dmas[i];
 	}
@@ -253,7 +255,7 @@ static void meth_free_tx_ring(struct meth_private *priv)
 			dev_kfree_skb(priv->tx_skbs[i]);
 		priv->tx_skbs[i] = NULL;
 	}
-	dma_free_coherent(NULL, TX_RING_BUFFER_SIZE, priv->tx_ring,
+	dma_free_coherent(&priv->pdev->dev, TX_RING_BUFFER_SIZE, priv->tx_ring,
 	                  priv->tx_ring_dma);
 }
 
@@ -263,7 +265,7 @@ static void meth_free_rx_ring(struct meth_private *priv)
 	int i;
 
 	for (i = 0; i < RX_RING_ENTRIES; i++) {
-		dma_unmap_single(NULL, priv->rx_ring_dmas[i],
+		dma_unmap_single(&priv->pdev->dev, priv->rx_ring_dmas[i],
 				 METH_RX_BUFF_SIZE, DMA_FROM_DEVICE);
 		priv->rx_ring[i] = 0;
 		priv->rx_ring_dmas[i] = 0;
@@ -393,7 +395,8 @@ static void meth_rx(struct net_device* dev, unsigned long int_status)
 		fifo_rptr = (fifo_rptr - 1) & 0x0f;
 	}
 	while (priv->rx_write != fifo_rptr) {
-		dma_unmap_single(NULL, priv->rx_ring_dmas[priv->rx_write],
+		dma_unmap_single(&priv->pdev->dev,
+				 priv->rx_ring_dmas[priv->rx_write],
 				 METH_RX_BUFF_SIZE, DMA_FROM_DEVICE);
 		status = priv->rx_ring[priv->rx_write]->status.raw;
 #if MFE_DEBUG
@@ -454,7 +457,8 @@ static void meth_rx(struct net_device* dev, unsigned long int_status)
 		priv->rx_ring[priv->rx_write] = (rx_packet*)skb->head;
 		priv->rx_ring[priv->rx_write]->status.raw = 0;
 		priv->rx_ring_dmas[priv->rx_write] =
-			dma_map_single(NULL, priv->rx_ring[priv->rx_write],
+			dma_map_single(&priv->pdev->dev,
+				       priv->rx_ring[priv->rx_write],
 				       METH_RX_BUFF_SIZE, DMA_FROM_DEVICE);
 		mace->eth.rx_fifo = priv->rx_ring_dmas[priv->rx_write];
 		ADVANCE_RX_PTR(priv->rx_write);
@@ -637,7 +641,7 @@ static void meth_tx_1page_prepare(struct meth_private *priv,
 	}
 
 	/* first page */
-	catbuf = dma_map_single(NULL, buffer_data, buffer_len,
+	catbuf = dma_map_single(&priv->pdev->dev, buffer_data, buffer_len,
 				DMA_TO_DEVICE);
 	desc->data.cat_buf[0].form.start_addr = catbuf >> 3;
 	desc->data.cat_buf[0].form.len = buffer_len - 1;
@@ -663,12 +667,12 @@ static void meth_tx_2page_prepare(struct meth_private *priv,
 	}
 
 	/* first page */
-	catbuf1 = dma_map_single(NULL, buffer1_data, buffer1_len,
+	catbuf1 = dma_map_single(&priv->pdev->dev, buffer1_data, buffer1_len,
 				 DMA_TO_DEVICE);
 	desc->data.cat_buf[0].form.start_addr = catbuf1 >> 3;
 	desc->data.cat_buf[0].form.len = buffer1_len - 1;
 	/* second page */
-	catbuf2 = dma_map_single(NULL, buffer2_data, buffer2_len,
+	catbuf2 = dma_map_single(&priv->pdev->dev, buffer2_data, buffer2_len,
 				 DMA_TO_DEVICE);
 	desc->data.cat_buf[1].form.start_addr = catbuf2 >> 3;
 	desc->data.cat_buf[1].form.len = buffer2_len - 1;
@@ -840,6 +844,7 @@ static int meth_probe(struct platform_device *pdev)
 	memcpy(dev->dev_addr, o2meth_eaddr, ETH_ALEN);
 
 	priv = netdev_priv(dev);
+	priv->pdev = pdev;
 	spin_lock_init(&priv->meth_lock);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
-- 
2.20.1

