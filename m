Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA30EECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEC020846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 03:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEC020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeGWES3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 00:18:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727688AbeGWES3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 00:18:29 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1118D2E820A79;
        Mon, 23 Jul 2018 11:19:22 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.382.0; Mon, 23 Jul 2018
 11:19:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <nbd@openwrt.org>, <john@phrozen.org>,
        <sean.wang@mediatek.com>, <nelson.chang@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 net-next] net: mediatek: use dma_zalloc_coherent instead of allocator/memset
Date:   Mon, 23 Jul 2018 11:16:47 +0800
Message-ID: <20180723031647.9820-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dma_zalloc_coherent instead of dma_alloc_coherent
followed by memset 0.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: remove redundant __GFP_ZERO
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index d8ebf0a..c30aea2 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1221,14 +1221,11 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 	if (!ring->buf)
 		goto no_tx_mem;
 
-	ring->dma = dma_alloc_coherent(eth->dev,
-					  MTK_DMA_SIZE * sz,
-					  &ring->phys,
-					  GFP_ATOMIC | __GFP_ZERO);
+	ring->dma = dma_zalloc_coherent(eth->dev, MTK_DMA_SIZE * sz,
+					&ring->phys, GFP_ATOMIC);
 	if (!ring->dma)
 		goto no_tx_mem;
 
-	memset(ring->dma, 0, MTK_DMA_SIZE * sz);
 	for (i = 0; i < MTK_DMA_SIZE; i++) {
 		int next = (i + 1) % MTK_DMA_SIZE;
 		u32 next_ptr = ring->phys + next * sz;
-- 
2.7.0


