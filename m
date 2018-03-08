Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935713AbeCHKaR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 05:30:17 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:40649 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755301AbeCHKaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:30:15 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose.Abreu@synopsys.com, pavel@ucw.cz,
        Niklas Cassel <niklass@axis.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: stmmac: remove superfluous wmb() memory barriers
Date: Thu,  8 Mar 2018 11:30:05 +0100
Message-Id: <20180308103006.1197-1-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These wmb() memory barriers are performed after the last descriptor write,
and they are followed by enable_dma_transmission()/set_tx_tail_ptr(),
i.e. a writel() to MMIO register space.
Since writel() itself performs the equivalent of a wmb() before doing the
actual write, these barriers are superfluous, and removing them should
thus not change any existing behavior.

Ordering within the descriptor writes is already ensured with dma_wmb()
barriers inside prepare_tx_desc(first, ..)/prepare_tso_tx_desc(first, ..).

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a9856a8bf8ad..005fb45ace30 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2998,12 +2998,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 		priv->hw->desc->set_tx_owner(mss_desc);
 	}
 
-	/* The own bit must be the latest setting done when prepare the
-	 * descriptor and then barrier is needed to make sure that
-	 * all is coherent before granting the DMA engine.
-	 */
-	wmb();
-
 	if (netif_msg_pktdata(priv)) {
 		pr_info("%s: curr=%d dirty=%d f=%d, e=%d, f_p=%p, nfrags %d\n",
 			__func__, tx_q->cur_tx, tx_q->dirty_tx, first_entry,
@@ -3221,12 +3215,6 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		priv->hw->desc->prepare_tx_desc(first, 1, nopaged_len,
 						csum_insertion, priv->mode, 1,
 						last_segment, skb->len);
-
-		/* The own bit must be the latest setting done when prepare the
-		 * descriptor and then barrier is needed to make sure that
-		 * all is coherent before granting the DMA engine.
-		 */
-		wmb();
 	}
 
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
-- 
2.14.2
