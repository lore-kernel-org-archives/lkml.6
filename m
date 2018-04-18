Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeDRJPU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 05:15:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56576 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752166AbeDRJPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 05:15:18 -0400
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net] net: mvpp2: Fix DMA address mask size
Date: Wed, 18 Apr 2018 11:14:44 +0200
Message-Id: <20180418091444.14039-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPv2 TX/RX descriptors uses 40bits DMA addresses, but 41 bits masks were
used (GENMASK_ULL(40, 0)).

This commit fixes that by using the correct mask.

Fixes: e7c5359f2eed ("net: mvpp2: introduce PPv2.2 HW descriptors and adapt accessors")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 9deb79b6dcc8..4202f9b5b966 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -916,6 +916,8 @@ static struct {
 
 #define MVPP2_MIB_COUNTERS_STATS_DELAY		(1 * HZ)
 
+#define MVPP2_DESC_DMA_MASK	DMA_BIT_MASK(40)
+
 /* Definitions */
 
 /* Shared Packet Processor resources */
@@ -1429,7 +1431,7 @@ static dma_addr_t mvpp2_txdesc_dma_addr_get(struct mvpp2_port *port,
 	if (port->priv->hw_version == MVPP21)
 		return tx_desc->pp21.buf_dma_addr;
 	else
-		return tx_desc->pp22.buf_dma_addr_ptp & GENMASK_ULL(40, 0);
+		return tx_desc->pp22.buf_dma_addr_ptp & MVPP2_DESC_DMA_MASK;
 }
 
 static void mvpp2_txdesc_dma_addr_set(struct mvpp2_port *port,
@@ -1447,7 +1449,7 @@ static void mvpp2_txdesc_dma_addr_set(struct mvpp2_port *port,
 	} else {
 		u64 val = (u64)addr;
 
-		tx_desc->pp22.buf_dma_addr_ptp &= ~GENMASK_ULL(40, 0);
+		tx_desc->pp22.buf_dma_addr_ptp &= ~MVPP2_DESC_DMA_MASK;
 		tx_desc->pp22.buf_dma_addr_ptp |= val;
 		tx_desc->pp22.packet_offset = offset;
 	}
@@ -1507,7 +1509,7 @@ static dma_addr_t mvpp2_rxdesc_dma_addr_get(struct mvpp2_port *port,
 	if (port->priv->hw_version == MVPP21)
 		return rx_desc->pp21.buf_dma_addr;
 	else
-		return rx_desc->pp22.buf_dma_addr_key_hash & GENMASK_ULL(40, 0);
+		return rx_desc->pp22.buf_dma_addr_key_hash & MVPP2_DESC_DMA_MASK;
 }
 
 static unsigned long mvpp2_rxdesc_cookie_get(struct mvpp2_port *port,
@@ -1516,7 +1518,7 @@ static unsigned long mvpp2_rxdesc_cookie_get(struct mvpp2_port *port,
 	if (port->priv->hw_version == MVPP21)
 		return rx_desc->pp21.buf_cookie;
 	else
-		return rx_desc->pp22.buf_cookie_misc & GENMASK_ULL(40, 0);
+		return rx_desc->pp22.buf_cookie_misc & MVPP2_DESC_DMA_MASK;
 }
 
 static size_t mvpp2_rxdesc_size_get(struct mvpp2_port *port,
@@ -8789,7 +8791,7 @@ static int mvpp2_probe(struct platform_device *pdev)
 	}
 
 	if (priv->hw_version == MVPP22) {
-		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(40));
+		err = dma_set_mask(&pdev->dev, MVPP2_DESC_DMA_MASK);
 		if (err)
 			goto err_mg_clk;
 		/* Sadly, the BM pools all share the same register to
-- 
2.11.0
