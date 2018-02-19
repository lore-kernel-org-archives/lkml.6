Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753596AbeBSRLt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:11:49 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:38880 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753449AbeBSRLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:11:46 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose.Abreu@synopsys.com, vbhadram@nvidia.com,
        Niklas Cassel <niklass@axis.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/7] net: stmmac: WARN if tx_skbuff entries are reused before cleared
Date: Mon, 19 Feb 2018 18:11:11 +0100
Message-Id: <20180219171116.15326-4-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180219171116.15326-1-niklas.cassel@axis.com>
References: <20180219171116.15326-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code assumes that a tx_skbuff entry has been cleared
by stmmac_tx_clean() before stmmac_xmit()/stmmac_tso_xmit()
assigns a new skb to that entry. However, since we never check
the current value before overwriting it, it is theoretically
possible that a non-NULL value is overwritten.

Add WARN_ONs to verify that each entry in tx_skbuff is NULL
before it is assigned a new value.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 24afe7733cde..9881df126227 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2794,6 +2794,7 @@ static void stmmac_tso_allocator(struct stmmac_priv *priv, unsigned int des,
 
 	while (tmp_len > 0) {
 		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, DMA_TX_SIZE);
+		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
 		desc = tx_q->dma_tx + tx_q->cur_tx;
 
 		desc->des0 = cpu_to_le32(des + (total_len - tmp_len));
@@ -2878,6 +2879,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		priv->hw->desc->set_mss(mss_desc, mss);
 		tx_q->mss = mss;
 		tx_q->cur_tx = STMMAC_GET_ENTRY(tx_q->cur_tx, DMA_TX_SIZE);
+		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
 	}
 
 	if (netif_msg_tx_queued(priv)) {
@@ -2888,6 +2890,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	first_entry = tx_q->cur_tx;
+	WARN_ON(tx_q->tx_skbuff[first_entry]);
 
 	desc = tx_q->dma_tx + first_entry;
 	first = desc;
@@ -3062,6 +3065,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	entry = tx_q->cur_tx;
 	first_entry = entry;
+	WARN_ON(tx_q->tx_skbuff[first_entry]);
 
 	csum_insertion = (skb->ip_summed == CHECKSUM_PARTIAL);
 
@@ -3090,6 +3094,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		bool last_segment = (i == (nfrags - 1));
 
 		entry = STMMAC_GET_ENTRY(entry, DMA_TX_SIZE);
+		WARN_ON(tx_q->tx_skbuff[entry]);
 
 		if (likely(priv->extend_desc))
 			desc = (struct dma_desc *)(tx_q->dma_etx + entry);
-- 
2.14.2
