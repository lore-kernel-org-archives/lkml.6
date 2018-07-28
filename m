Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68C6C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A582088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 05:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A582088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbeG1HBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 03:01:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22107 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726047AbeG1HBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 03:01:21 -0400
X-UUID: 9220d135df184609b7a35b44ec2a0dea-20180728
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 284816014; Sat, 28 Jul 2018 13:36:06 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sat, 28 Jul 2018 13:36:03 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sat, 28 Jul 2018 13:35:58 +0800
From:   <sean.wang@mediatek.com>
To:     <john@phrozen.org>, <davem@davemloft.net>
CC:     <nbd@openwrt.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH net-next 1/2] net-next: mediatek: improve more with using dma_zalloc_coherent
Date:   Sat, 28 Jul 2018 13:35:55 +0800
Message-ID: <658dfd485c035cdae5452bc5d572125076b47a48.1532755541.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Improve more in the existing code by reusing dma_zalloc_coherent instead
of dma_alloc_coherent with __GFP_ZERO or superfluous zeroing buffer.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index c30aea2..8c85a4b 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -605,10 +605,10 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
 	dma_addr_t dma_addr;
 	int i;
 
-	eth->scratch_ring = dma_alloc_coherent(eth->dev,
-					       cnt * sizeof(struct mtk_tx_dma),
-					       &eth->phy_scratch_ring,
-					       GFP_ATOMIC | __GFP_ZERO);
+	eth->scratch_ring = dma_zalloc_coherent(eth->dev,
+						cnt * sizeof(struct mtk_tx_dma),
+						&eth->phy_scratch_ring,
+						GFP_ATOMIC);
 	if (unlikely(!eth->scratch_ring))
 		return -ENOMEM;
 
@@ -623,7 +623,6 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
 	if (unlikely(dma_mapping_error(eth->dev, dma_addr)))
 		return -ENOMEM;
 
-	memset(eth->scratch_ring, 0x0, sizeof(struct mtk_tx_dma) * cnt);
 	phy_ring_tail = eth->phy_scratch_ring +
 			(sizeof(struct mtk_tx_dma) * (cnt - 1));
 
@@ -1318,10 +1317,9 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 			return -ENOMEM;
 	}
 
-	ring->dma = dma_alloc_coherent(eth->dev,
-				       rx_dma_size * sizeof(*ring->dma),
-				       &ring->phys,
-				       GFP_ATOMIC | __GFP_ZERO);
+	ring->dma = dma_zalloc_coherent(eth->dev,
+					rx_dma_size * sizeof(*ring->dma),
+					&ring->phys, GFP_ATOMIC);
 	if (!ring->dma)
 		return -ENOMEM;
 
-- 
2.7.4

