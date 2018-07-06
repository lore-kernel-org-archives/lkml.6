Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE19DC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D3A23FCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D3A23FCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933713AbeGFNVG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:21:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57327 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933259AbeGFNUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:20:03 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1E5E1207D4; Fri,  6 Jul 2018 15:20:01 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id D479A207F4;
        Fri,  6 Jul 2018 15:19:50 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Dmitri Epshtein <dima@marvell.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next 4/6] net: mvneta: Allocate page for the descriptor
Date:   Fri,  6 Jul 2018 15:19:47 +0200
Message-Id: <20180706131949.2684-5-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180706131949.2684-1-gregory.clement@bootlin.com>
References: <20180706131949.2684-1-gregory.clement@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of trying to allocate the exact amount of memory for each
descriptor use a page for each of them, it allows to simplify the
allocation management and increase the performance of the driver.

Based on the work of Yelena Krivosheev <yelena@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c    | 66 ++++++++++--------------
 drivers/net/ethernet/marvell/mvneta_bm.h |  3 --
 2 files changed, 26 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 2c575c6732ce..12739fb60732 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -1791,47 +1791,30 @@ static void mvneta_txq_done(struct mvneta_port *pp,
 	}
 }
 
-void *mvneta_frag_alloc(unsigned int frag_size)
-{
-	if (likely(frag_size <= PAGE_SIZE))
-		return netdev_alloc_frag(frag_size);
-	else
-		return kmalloc(frag_size, GFP_ATOMIC);
-}
-EXPORT_SYMBOL_GPL(mvneta_frag_alloc);
-
-void mvneta_frag_free(unsigned int frag_size, void *data)
-{
-	if (likely(frag_size <= PAGE_SIZE))
-		skb_free_frag(data);
-	else
-		kfree(data);
-}
-EXPORT_SYMBOL_GPL(mvneta_frag_free);
-
 /* Refill processing for SW buffer management */
-static int mvneta_rx_refill(struct mvneta_port *pp,
-			    struct mvneta_rx_desc *rx_desc,
-			    struct mvneta_rx_queue *rxq)
-
+/* Allocate page per descriptor */
+static inline int mvneta_rx_refill(struct mvneta_port *pp,
+				   struct mvneta_rx_desc *rx_desc,
+				   struct mvneta_rx_queue *rxq,
+				   gfp_t gfp_mask)
 {
 	dma_addr_t phys_addr;
-	void *data;
+	struct page *page;
 
-	data = mvneta_frag_alloc(pp->frag_size);
-	if (!data)
+	page = __dev_alloc_page(gfp_mask);
+	if (!page)
 		return -ENOMEM;
 
-	phys_addr = dma_map_single(pp->dev->dev.parent, data,
-				   MVNETA_RX_BUF_SIZE(pp->pkt_size),
-				   DMA_FROM_DEVICE);
+	/* map page for use */
+	phys_addr = dma_map_page(pp->dev->dev.parent, page, 0, PAGE_SIZE,
+				 DMA_FROM_DEVICE);
 	if (unlikely(dma_mapping_error(pp->dev->dev.parent, phys_addr))) {
-		mvneta_frag_free(pp->frag_size, data);
+		__free_page(page);
 		return -ENOMEM;
 	}
 
 	phys_addr += pp->rx_offset_correction;
-	mvneta_rx_desc_fill(rx_desc, phys_addr, data, rxq);
+	mvneta_rx_desc_fill(rx_desc, phys_addr, page, rxq);
 	return 0;
 }
 
@@ -1897,7 +1880,7 @@ static void mvneta_rxq_drop_pkts(struct mvneta_port *pp,
 
 		dma_unmap_single(pp->dev->dev.parent, rx_desc->buf_phys_addr,
 				 MVNETA_RX_BUF_SIZE(pp->pkt_size), DMA_FROM_DEVICE);
-		mvneta_frag_free(pp->frag_size, data);
+		__free_page(data);
 	}
 }
 
@@ -1924,6 +1907,7 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 		struct mvneta_rx_desc *rx_desc = mvneta_rxq_next_desc_get(rxq);
 		struct sk_buff *skb;
 		unsigned char *data;
+		struct page *page;
 		dma_addr_t phys_addr;
 		u32 rx_status, frag_size;
 		int rx_bytes, err, index;
@@ -1932,7 +1916,10 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 		rx_status = rx_desc->status;
 		rx_bytes = rx_desc->data_size - (ETH_FCS_LEN + MVNETA_MH_SIZE);
 		index = rx_desc - rxq->descs;
-		data = rxq->buf_virt_addr[index];
+		page = (struct page *)rxq->buf_virt_addr[index];
+		data = page_address(page);
+		/* Prefetch header */
+		prefetch(data);
 		phys_addr = rx_desc->buf_phys_addr - pp->rx_offset_correction;
 
 		if (!mvneta_rxq_desc_is_first_last(rx_status) ||
@@ -1975,7 +1962,7 @@ static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo,
 		}
 
 		/* Refill processing */
-		err = mvneta_rx_refill(pp, rx_desc, rxq);
+		err = mvneta_rx_refill(pp, rx_desc, rxq, GFP_KERNEL);
 		if (err) {
 			netdev_err(dev, "Linux processing - Can't refill\n");
 			rxq->refill_err++;
@@ -2767,9 +2754,11 @@ static int mvneta_rxq_fill(struct mvneta_port *pp, struct mvneta_rx_queue *rxq,
 
 	for (i = 0; i < num; i++) {
 		memset(rxq->descs + i, 0, sizeof(struct mvneta_rx_desc));
-		if (mvneta_rx_refill(pp, rxq->descs + i, rxq) != 0) {
-			netdev_err(pp->dev, "%s:rxq %d, %d of %d buffs  filled\n",
-				__func__, rxq->id, i, num);
+		if (mvneta_rx_refill(pp, rxq->descs + i, rxq,
+				     GFP_KERNEL) != 0) {
+			netdev_err(pp->dev,
+				   "%s:rxq %d, %d of %d buffs  filled\n",
+				   __func__, rxq->id, i, num);
 			break;
 		}
 	}
@@ -3183,8 +3172,6 @@ static int mvneta_change_mtu(struct net_device *dev, int mtu)
 		mvneta_bm_update_mtu(pp, mtu);
 
 	pp->pkt_size = MVNETA_RX_PKT_SIZE(dev->mtu);
-	pp->frag_size = SKB_DATA_ALIGN(MVNETA_RX_BUF_SIZE(pp->pkt_size)) +
-	                SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
 	ret = mvneta_setup_rxqs(pp);
 	if (ret) {
@@ -3672,8 +3659,7 @@ static int mvneta_open(struct net_device *dev)
 	int ret;
 
 	pp->pkt_size = MVNETA_RX_PKT_SIZE(pp->dev->mtu);
-	pp->frag_size = SKB_DATA_ALIGN(MVNETA_RX_BUF_SIZE(pp->pkt_size)) +
-	                SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	pp->frag_size = PAGE_SIZE;
 
 	ret = mvneta_setup_rxqs(pp);
 	if (ret)
diff --git a/drivers/net/ethernet/marvell/mvneta_bm.h b/drivers/net/ethernet/marvell/mvneta_bm.h
index 9358626e51ec..c8425d35c049 100644
--- a/drivers/net/ethernet/marvell/mvneta_bm.h
+++ b/drivers/net/ethernet/marvell/mvneta_bm.h
@@ -130,9 +130,6 @@ struct mvneta_bm_pool {
 };
 
 /* Declarations and definitions */
-void *mvneta_frag_alloc(unsigned int frag_size);
-void mvneta_frag_free(unsigned int frag_size, void *data);
-
 #if IS_ENABLED(CONFIG_MVNETA_BM)
 struct mvneta_bm *mvneta_bm_get(struct device_node *node);
 void mvneta_bm_put(struct mvneta_bm *priv);
-- 
2.17.1

