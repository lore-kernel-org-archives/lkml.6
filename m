Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0090EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6054205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6054205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388457AbeGXM6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:58:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43828 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388254AbeGXM6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:58:50 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D6A7F4BA41DC;
        Tue, 24 Jul 2018 19:52:39 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Tue, 24 Jul 2018
 19:52:34 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <kvalo@codeaurora.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <wcn36xx@lists.infradead.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] wcn36xx: use dma_zalloc_coherent instead of allocator/memset
Date:   Tue, 24 Jul 2018 19:52:11 +0800
Message-ID: <20180724115211.19264-1-yuehaibing@huawei.com>
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
 drivers/net/wireless/ath/wcn36xx/dxe.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index 06cfe8d..5ab3e31 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -174,13 +174,12 @@ static int wcn36xx_dxe_init_descs(struct device *dev, struct wcn36xx_dxe_ch *wcn
 	int i;
 
 	size = wcn_ch->desc_num * sizeof(struct wcn36xx_dxe_desc);
-	wcn_ch->cpu_addr = dma_alloc_coherent(dev, size, &wcn_ch->dma_addr,
-					      GFP_KERNEL);
+	wcn_ch->cpu_addr = dma_zalloc_coherent(dev, size,
+					       &wcn_ch->dma_addr,
+					       GFP_KERNEL);
 	if (!wcn_ch->cpu_addr)
 		return -ENOMEM;
 
-	memset(wcn_ch->cpu_addr, 0, size);
-
 	cur_dxe = (struct wcn36xx_dxe_desc *)wcn_ch->cpu_addr;
 	cur_ctl = wcn_ch->head_blk_ctl;
 
@@ -628,13 +627,13 @@ int wcn36xx_dxe_allocate_mem_pools(struct wcn36xx *wcn)
 		16 - (WCN36XX_BD_CHUNK_SIZE % 8);
 
 	s = wcn->mgmt_mem_pool.chunk_size * WCN36XX_DXE_CH_DESC_NUMB_TX_H;
-	cpu_addr = dma_alloc_coherent(wcn->dev, s, &wcn->mgmt_mem_pool.phy_addr,
-				      GFP_KERNEL);
+	cpu_addr = dma_zalloc_coherent(wcn->dev, s,
+				       &wcn->mgmt_mem_pool.phy_addr,
+				       GFP_KERNEL);
 	if (!cpu_addr)
 		goto out_err;
 
 	wcn->mgmt_mem_pool.virt_addr = cpu_addr;
-	memset(cpu_addr, 0, s);
 
 	/* Allocate BD headers for DATA frames */
 
@@ -643,13 +642,13 @@ int wcn36xx_dxe_allocate_mem_pools(struct wcn36xx *wcn)
 		16 - (WCN36XX_BD_CHUNK_SIZE % 8);
 
 	s = wcn->data_mem_pool.chunk_size * WCN36XX_DXE_CH_DESC_NUMB_TX_L;
-	cpu_addr = dma_alloc_coherent(wcn->dev, s, &wcn->data_mem_pool.phy_addr,
-				      GFP_KERNEL);
+	cpu_addr = dma_zalloc_coherent(wcn->dev, s,
+				       &wcn->data_mem_pool.phy_addr,
+				       GFP_KERNEL);
 	if (!cpu_addr)
 		goto out_err;
 
 	wcn->data_mem_pool.virt_addr = cpu_addr;
-	memset(cpu_addr, 0, s);
 
 	return 0;
 
-- 
2.7.0


