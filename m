Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeBZVsO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:48:14 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:54808 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeBZVrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:47:25 -0500
From: Niklas Cassel <niklas.cassel@axis.com>
To: Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose.Abreu@synopsys.com, pavel@ucw.cz,
        Niklas Cassel <niklass@axis.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/4] net: stmmac: use correct barrier between coherent memory and MMIO
Date: Mon, 26 Feb 2018 22:47:07 +0100
Message-Id: <20180226214709.4359-3-niklas.cassel@axis.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180226214709.4359-1-niklas.cassel@axis.com>
References: <20180226214709.4359-1-niklas.cassel@axis.com>
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last memory barrier in stmmac_xmit()/stmmac_tso_xmit() is placed
between a coherent memory write and a MMIO write:

The own bit is written in First Desc (TSO: MSS desc or First Desc).
<barrier>
The DMA engine is started by a write to the tx desc tail pointer/
enable dma transmission register, i.e. a MMIO write.

This barrier cannot be a simple dma_wmb(), since a dma_wmb() is only
used to guarantee the ordering, with respect to other writes,
to cache coherent DMA memory.

To guarantee that the cache coherent memory writes have completed
before we attempt to write to the cache incoherent MMIO region,
we need to use the more heavyweight barrier wmb().

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3b5e7b06e796..6dd04f237b2a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2997,7 +2997,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * descriptor and then barrier is needed to make sure that
 	 * all is coherent before granting the DMA engine.
 	 */
-	dma_wmb();
+	wmb();
 
 	if (netif_msg_pktdata(priv)) {
 		pr_info("%s: curr=%d dirty=%d f=%d, e=%d, f_p=%p, nfrags %d\n",
@@ -3221,7 +3221,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 		 * descriptor and then barrier is needed to make sure that
 		 * all is coherent before granting the DMA engine.
 		 */
-		dma_wmb();
+		wmb();
 	}
 
 	netdev_tx_sent_queue(netdev_get_tx_queue(dev, queue), skb->len);
-- 
2.14.2
