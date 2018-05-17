Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeEQI2J (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:28:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59626 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeEQI2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:28:06 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C1947602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=hpuranik@codeaurora.org
From: Hemanth Puranik <hpuranik@codeaurora.org>
To: netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: Timur Tabi <timur@codeaurora.org>,
        Hemanth Puranik <hpuranik@codeaurora.org>
Subject: [PATCH] net: qcom/emac: Allocate buffers from local node
Date: Thu, 17 May 2018 13:58:00 +0530
Message-Id: <1526545680-21650-1-git-send-email-hpuranik@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we use non-NUMA aware allocation for TPD and RRD buffers,
this patch modifies to use NUMA friendly allocation.

Signed-off-by: Hemanth Puranik <hpuranik@codeaurora.org>
---
 drivers/net/ethernet/qualcomm/emac/emac-mac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/emac/emac-mac.c b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
index 092718a..c3df86a 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac-mac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac-mac.c
@@ -684,9 +684,10 @@ static int emac_tx_q_desc_alloc(struct emac_adapter *adpt,
 {
 	struct emac_ring_header *ring_header = &adpt->ring_header;
 	size_t size;
+	int node = dev_to_node(adpt->netdev->dev.parent);
 
 	size = sizeof(struct emac_buffer) * tx_q->tpd.count;
-	tx_q->tpd.tpbuff = kzalloc(size, GFP_KERNEL);
+	tx_q->tpd.tpbuff = kzalloc_node(size, GFP_KERNEL, node);
 	if (!tx_q->tpd.tpbuff)
 		return -ENOMEM;
 
@@ -725,9 +726,10 @@ static int emac_rx_descs_alloc(struct emac_adapter *adpt)
 	struct emac_ring_header *ring_header = &adpt->ring_header;
 	struct emac_rx_queue *rx_q = &adpt->rx_q;
 	size_t size;
+	int node = dev_to_node(adpt->netdev->dev.parent);
 
 	size = sizeof(struct emac_buffer) * rx_q->rfd.count;
-	rx_q->rfd.rfbuff = kzalloc(size, GFP_KERNEL);
+	rx_q->rfd.rfbuff = kzalloc_node(size, GFP_KERNEL, node);
 	if (!rx_q->rfd.rfbuff)
 		return -ENOMEM;
 
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
