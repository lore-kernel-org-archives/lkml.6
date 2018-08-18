Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B4EC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49ED62178F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49ED62178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeHRSg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 14:36:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbeHRSg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 14:36:56 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 85C7C19C64D25;
        Sat, 18 Aug 2018 23:28:48 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Sat, 18 Aug 2018 23:28:48 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <yong.zhi@intel.com>, <sakari.ailus@linux.intel.com>,
        <bingbu.cao@intel.com>, <mchehab@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <tian.shu.qiu@intel.com>, <jian.xu.zheng@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: [PATCH 2/2] media: mtk_vcodec_util: Use dma_zalloc_coherent to replace dma_alloc_coherent + memset
Date:   Sat, 18 Aug 2018 23:16:55 +0800
Message-ID: <1534605415-11452-3-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1534605415-11452-1-git-send-email-zhongjiang@huawei.com>
References: <1534605415-11452-1-git-send-email-zhongjiang@huawei.com>
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
 drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
index 0c28d0b..e80123c 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
@@ -49,16 +49,13 @@ int mtk_vcodec_mem_alloc(struct mtk_vcodec_ctx *data,
 	struct mtk_vcodec_ctx *ctx = (struct mtk_vcodec_ctx *)data;
 	struct device *dev = &ctx->dev->plat_dev->dev;
 
-	mem->va = dma_alloc_coherent(dev, size, &mem->dma_addr, GFP_KERNEL);
-
+	mem->va = dma_zalloc_coherent(dev, size, &mem->dma_addr, GFP_KERNEL);
 	if (!mem->va) {
 		mtk_v4l2_err("%s dma_alloc size=%ld failed!", dev_name(dev),
 			     size);
 		return -ENOMEM;
 	}
 
-	memset(mem->va, 0, size);
-
 	mtk_v4l2_debug(3, "[%d]  - va      = %p", ctx->id, mem->va);
 	mtk_v4l2_debug(3, "[%d]  - dma     = 0x%lx", ctx->id,
 		       (unsigned long)mem->dma_addr);
-- 
1.7.12.4

