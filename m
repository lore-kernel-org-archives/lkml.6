Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162172AbeE1KgN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:36:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937308AbeE1KgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:36:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hemanth Puranik <hpuranik@codeaurora.org>,
        Timur Tabi <timur@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 188/329] net: qcom/emac: Use proper free methods during TX
Date: Mon, 28 May 2018 12:01:57 +0200
Message-Id: <20180528100257.958569320@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hemanth Puranik <hpuranik@codeaurora.org>

[ Upstream commit cc5db3150e87fe7f7e947bf333b6c1c97f848ecb ]

This patch fixes the warning messages/call traces seen if DMA debug is
enabled, In case of fragmented skb's memory was allocated using
dma_map_page but freed using dma_unmap_single. This patch modifies buffer
allocations in TX path to use dma_map_page in all the places and
dma_unmap_page while freeing the buffers.

Signed-off-by: Hemanth Puranik <hpuranik@codeaurora.org>
Acked-by: Timur Tabi <timur@codeaurora.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qualcomm/emac/emac-mac.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/qualcomm/emac/emac-mac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
@@ -1250,9 +1250,9 @@ void emac_mac_tx_process(struct emac_ada
 	while (tx_q->tpd.consume_idx != hw_consume_idx) {
 		tpbuf = GET_TPD_BUFFER(tx_q, tx_q->tpd.consume_idx);
 		if (tpbuf->dma_addr) {
-			dma_unmap_single(adpt->netdev->dev.parent,
-					 tpbuf->dma_addr, tpbuf->length,
-					 DMA_TO_DEVICE);
+			dma_unmap_page(adpt->netdev->dev.parent,
+				       tpbuf->dma_addr, tpbuf->length,
+				       DMA_TO_DEVICE);
 			tpbuf->dma_addr = 0;
 		}
 
@@ -1409,9 +1409,11 @@ static void emac_tx_fill_tpd(struct emac
 
 		tpbuf = GET_TPD_BUFFER(tx_q, tx_q->tpd.produce_idx);
 		tpbuf->length = mapped_len;
-		tpbuf->dma_addr = dma_map_single(adpt->netdev->dev.parent,
-						 skb->data, tpbuf->length,
-						 DMA_TO_DEVICE);
+		tpbuf->dma_addr = dma_map_page(adpt->netdev->dev.parent,
+					       virt_to_page(skb->data),
+					       offset_in_page(skb->data),
+					       tpbuf->length,
+					       DMA_TO_DEVICE);
 		ret = dma_mapping_error(adpt->netdev->dev.parent,
 					tpbuf->dma_addr);
 		if (ret)
@@ -1427,9 +1429,12 @@ static void emac_tx_fill_tpd(struct emac
 	if (mapped_len < len) {
 		tpbuf = GET_TPD_BUFFER(tx_q, tx_q->tpd.produce_idx);
 		tpbuf->length = len - mapped_len;
-		tpbuf->dma_addr = dma_map_single(adpt->netdev->dev.parent,
-						 skb->data + mapped_len,
-						 tpbuf->length, DMA_TO_DEVICE);
+		tpbuf->dma_addr = dma_map_page(adpt->netdev->dev.parent,
+					       virt_to_page(skb->data +
+							    mapped_len),
+					       offset_in_page(skb->data +
+							      mapped_len),
+					       tpbuf->length, DMA_TO_DEVICE);
 		ret = dma_mapping_error(adpt->netdev->dev.parent,
 					tpbuf->dma_addr);
 		if (ret)
