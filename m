Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149C9C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C3B21581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C3B21581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbeHTOME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:12:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51313 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbeHTOME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:12:04 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 51912D39A64B1;
        Mon, 20 Aug 2018 18:56:52 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.399.0; Mon, 20 Aug 2018 18:56:49 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <kvalo@codeaurora.org>
CC:     <davem@davemloft.net>, <wcn36xx@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] wcn36xx: Use dma_zalloc_coherent instead of dma_alloc_coherent + memset
Date:   Mon, 20 Aug 2018 18:44:55 +0800
Message-ID: <1534761895-10457-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_zalloc_coherent has implemented the dma_alloc_coherent() + memset(),
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

