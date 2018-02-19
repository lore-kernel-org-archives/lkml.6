Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753491AbeBSRLe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:11:34 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:38847 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753427AbeBSRLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:11:32 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose.Abreu@synopsys.com, vbhadram@nvidia.com,
        Niklas Cassel <niklass@axis.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/7] net: stmmac: set MSS for each tx DMA channel
Date: Mon, 19 Feb 2018 18:11:09 +0100
Message-Id: <20180219171116.15326-2-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180219171116.15326-1-niklas.cassel@axis.com>
References: <20180219171116.15326-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DMA engine in dwmac4 can segment a large TSO packet to several
smaller packets of (max) size Maximum Segment Size (MSS).

The DMA engine fetches and saves the MSS via a context descriptor.

This context decriptor has to be provided to each tx DMA channel.
To ensure that this is done, move struct member mss from stmmac_priv
to stmmac_tx_queue.

stmmac_reset_queues_param() now also resets mss, together with other
queue parameters, so reset of mss value can be removed from
stmmac_resume().

init_dma_tx_desc_rings() now also resets mss, together with other
queue parameters, so reset of mss value can be removed from
stmmac_open().

This fixes tx queue timeouts for dwmac4, with DT property
snps,tx-queues-to-use > 1, when running iperf3 with multiple threads.

Fixes: ce736788e8a9 ("net: stmmac: adding multiple buffers for TX")
Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++--------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index a916e13624eb..75161e1b7e55 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -58,6 +58,7 @@ struct stmmac_tx_queue {
 	unsigned int dirty_tx;
 	dma_addr_t dma_tx_phy;
 	u32 tx_tail_addr;
+	u32 mss;
 };
 
 struct stmmac_rx_queue {
@@ -138,7 +139,6 @@ struct stmmac_priv {
 	spinlock_t ptp_lock;
 	void __iomem *mmcaddr;
 	void __iomem *ptpaddr;
-	u32 mss;
 
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dbgfs_dir;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7ad841434ec8..d38bf38f12f5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1355,6 +1355,7 @@ static int init_dma_tx_desc_rings(struct net_device *dev)
 
 		tx_q->dirty_tx = 0;
 		tx_q->cur_tx = 0;
+		tx_q->mss = 0;
 
 		netdev_tx_reset_queue(netdev_get_tx_queue(priv->dev, queue));
 	}
@@ -1946,6 +1947,7 @@ static void stmmac_tx_err(struct stmmac_priv *priv, u32 chan)
 						     (i == DMA_TX_SIZE - 1));
 	tx_q->dirty_tx = 0;
 	tx_q->cur_tx = 0;
+	tx_q->mss = 0;
 	netdev_tx_reset_queue(netdev_get_tx_queue(priv->dev, chan));
 	stmmac_start_tx_dma(priv, chan);
 
@@ -2632,7 +2634,6 @@ static int stmmac_open(struct net_device *dev)
 
 	priv->dma_buf_sz = STMMAC_ALIGN(buf_sz);
 	priv->rx_copybreak = STMMAC_RX_COPYBREAK;
-	priv->mss = 0;
 
 	ret = alloc_dma_desc_resources(priv);
 	if (ret < 0) {
@@ -2872,10 +2873,10 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	mss = skb_shinfo(skb)->gso_size;
 
 	/* set new MSS value if needed */
-	if (mss != priv->mss) {
+	if (mss != tx_q->mss) {
 		mss_desc = tx_q->dma_tx + tx_q->cur_tx;
 		priv->hw->desc->set_mss(mss_desc, mss);
-		priv->mss = mss;
+		tx_q->mss = mss;
 		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, DMA_TX_SIZE);
 	}
 
@@ -4436,6 +4437,7 @@ static void stmmac_reset_queues_param(struct stmmac_priv *priv)
 
 		tx_q->cur_tx = 0;
 		tx_q->dirty_tx = 0;
+		tx_q->mss = 0;
 	}
 }
 
@@ -4481,11 +4483,6 @@ int stmmac_resume(struct device *dev)
 
 	stmmac_reset_queues_param(priv);
 
-	/* reset private mss value to force mss context settings at
-	 * next tso xmit (only used for gmac4).
-	 */
-	priv->mss = 0;
-
 	stmmac_clear_descriptors(priv);
 
 	stmmac_hw_setup(ndev, false);
-- 
2.14.2
