Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753237AbeCFCsS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 21:48:18 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40326 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753181AbeCFCsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 21:48:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 618546022C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=hpuranik@codeaurora.org
From: Hemanth Puranik <hpuranik@codeaurora.org>
To: netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: Timur Tabi <timur@codeaurora.org>,
        Hemanth Puranik <hpuranik@codeaurora.org>
Subject: [PATCH] net: qcom/emac: Use proper free methods during TX
Date: Tue,  6 Mar 2018 08:18:06 +0530
Message-Id: <1520304486-14466-1-git-send-email-hpuranik@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the warning messages/call traces seen if DMA debug is
enabled, In case of fragmented skb's memory was allocated using
dma_map_page but freed using dma_unmap_single. This patch modifies buffer
allocations in TX path to use dma_map_page in all the places and
dma_unmap_page while freeing the buffers.

Signed-off-by: Hemanth Puranik <hpuranik@codeaurora.org>
---
 drivers/net/ethernet/qualcomm/emac/emac-mac.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac-mac.c b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
index 9cbb2726..d5a32b7 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-mac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
@@ -1194,9 +1194,9 @@ void emac_mac_tx_process(struct emac_adapter *adpt, struct emac_tx_queue *tx_q)
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
 
@@ -1353,9 +1353,11 @@ static void emac_tx_fill_tpd(struct emac_adapter *adpt,
 
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
@@ -1371,9 +1373,12 @@ static void emac_tx_fill_tpd(struct emac_adapter *adpt,
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
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
