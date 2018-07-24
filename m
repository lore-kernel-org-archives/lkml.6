Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F27ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2D8205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2D8205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbeGXPLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:11:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52434 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388385AbeGXPLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:11:43 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 688EAB315FFA6;
        Tue, 24 Jul 2018 22:05:00 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.382.0; Tue, 24 Jul 2018
 22:04:53 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linux@armlinux.org.uk>, <matthias.bgg@gmail.com>,
        <vladimir.murzin@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <akpm@linux-foundation.org>, <iamjoonsoo.kim@lge.com>,
        <robin.murphy@arm.com>, <treding@nvidia.com>,
        <zhongjiang@huawei.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] ARM: dma-mapping: always clear allocated buffers
Date:   Tue, 24 Jul 2018 22:04:35 +0800
Message-ID: <20180724140435.17112-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Wang report dma_zalloc_coherent doesn't work as expect on his
armv7,the allocated mem is not zeroed.The reason is __alloc_from_pool
doesn't honor __GFP_ZERO.

Like commit 6829e274a623 ("arm64: dma-mapping: always clear allocated buffers")
does,always clear allocated buffers to fix this.

Reported-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/arm/mm/dma-mapping.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6656647..cf5882f 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -564,6 +564,7 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
 
 		*ret_page = phys_to_page(phys);
 		ptr = (void *)val;
+		memset(ptr, 0, size);
 	}
 
 	return ptr;
-- 
2.7.0


