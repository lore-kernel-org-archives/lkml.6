Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436D6C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BF121581
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BF121581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbeHRSZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 14:25:06 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11141 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbeHRSZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 14:25:05 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 029744BEB2F1B;
        Sat, 18 Aug 2018 23:16:59 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.399.0; Sat, 18 Aug 2018 23:16:59 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <kvalo@codeaurora.org>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH] wireless: Use dma_zalloc_coherent instead of dma_alloc_coherent + memset
Date:   Sat, 18 Aug 2018 23:05:07 +0800
Message-ID: <1534604707-10874-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_zalloc_coherent has implemented the dma_alloc_coherent() + memset (),
We prefer to dma_zalloc_coherent instead of open-codeing.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/net/wireless/ath/wcn36xx/dxe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/dxe.c b/drivers/net/wireless/ath/wcn36xx/dxe.c
index 06cfe8d..e66ddaa 100644
--- a/drivers/net/wireless/ath/wcn36xx/dxe.c
+++ b/drivers/net/wireless/ath/wcn36xx/dxe.c
@@ -174,13 +174,11 @@ static int wcn36xx_dxe_init_descs(struct device *dev, struct wcn36xx_dxe_ch *wcn
 	int i;
 
 	size = wcn_ch->desc_num * sizeof(struct wcn36xx_dxe_desc);
-	wcn_ch->cpu_addr = dma_alloc_coherent(dev, size, &wcn_ch->dma_addr,
-					      GFP_KERNEL);
+	wcn_ch->cpu_addr = dma_zalloc_coherent(dev, size, &wcn_ch->dma_addr,
+					       GFP_KERNEL);
 	if (!wcn_ch->cpu_addr)
 		return -ENOMEM;
 
-	memset(wcn_ch->cpu_addr, 0, size);
-
 	cur_dxe = (struct wcn36xx_dxe_desc *)wcn_ch->cpu_addr;
 	cur_ctl = wcn_ch->head_blk_ctl;
 
-- 
1.7.12.4

