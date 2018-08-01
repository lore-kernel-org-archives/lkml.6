Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCD2C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A000208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A000208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389583AbeHAQH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:07:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55340 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389499AbeHAQH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:07:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6082448129ADE;
        Wed,  1 Aug 2018 22:21:54 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.399.0; Wed, 1 Aug 2018 22:21:51 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <matthias.bgg@gmail.com>
CC:     <kamalheib1@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/staging/mt7621-eth: Use dma_zalloc_coherent to replace dma_alloc_coherent+memset
Date:   Wed, 1 Aug 2018 22:10:15 +0800
Message-ID: <1533132615-53808-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

we prefer to use dma_zalloc_coherent rather than dam_alloc_coherent+memset

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/staging/mt7621-eth/mtk_eth_soc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-eth/mtk_eth_soc.c b/drivers/staging/mt7621-eth/mtk_eth_soc.c
index f9b593ca..7135075 100644
--- a/drivers/staging/mt7621-eth/mtk_eth_soc.c
+++ b/drivers/staging/mt7621-eth/mtk_eth_soc.c
@@ -1396,14 +1396,13 @@ static int mtk_qdma_tx_alloc_tx(struct mtk_eth *eth)
 	if (!ring->tx_buf)
 		goto no_tx_mem;
 
-	ring->tx_dma = dma_alloc_coherent(eth->dev,
+	ring->tx_dma = dma_zalloc_coherent(eth->dev,
 					  ring->tx_ring_size * sz,
 					  &ring->tx_phys,
 					  GFP_ATOMIC | __GFP_ZERO);
 	if (!ring->tx_dma)
 		goto no_tx_mem;
 
-	memset(ring->tx_dma, 0, ring->tx_ring_size * sz);
 	for (i = 0; i < ring->tx_ring_size; i++) {
 		int next = (i + 1) % ring->tx_ring_size;
 		u32 next_ptr = ring->tx_phys + next * sz;
-- 
1.7.12.4

