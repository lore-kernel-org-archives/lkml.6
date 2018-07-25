Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1F2C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE54620882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE54620882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbeGYIRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:17:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33585 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728461AbeGYIRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:17:44 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3E4B61675883F;
        Wed, 25 Jul 2018 15:07:21 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.382.0; Wed, 25 Jul 2018
 15:07:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linux@armlinux.org.uk>, <matthias.bgg@gmail.com>,
        <vladimir.murzin@arm.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <akpm@linux-foundation.org>, <iamjoonsoo.kim@lge.com>,
        <robin.murphy@arm.com>, <treding@nvidia.com>,
        <zhongjiang@huawei.com>, <sean.wang@mediatek.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] ARM: dma-mapping: always clear allocated buffers
Date:   Wed, 25 Jul 2018 15:07:06 +0800
Message-ID: <20180725070706.19576-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Wang reported dma_zalloc_coherent doesn't work as expect on his
armv7,the allocated mem is not zeroed.The reason is __alloc_from_pool
doesn't honor __GFP_ZERO.

As commit 6829e274a623 ("arm64: dma-mapping: always clear allocated buffers")
has pointed out,buffers allocated by dma_alloc_coherent() are always zeroed
on most architectures. some drivers rely on this 'feature'. Allocated buffer
might be also exposed to userspace with dma_mmap() call,so clearing it is
desired from security point of view to avoid exposing random memory to userspace.

This patch unifies dma_alloc_coherent() behavior on ARM architecture with other
implementations by unconditionally zeroing allocated buffer.Also to fix
dma_zalloc_coherent behavior.

Reported-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: zhong jiang <zhongjiang@huawei.com>
---
v2: reference more argument from arm64 commit as Christoph suggested
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


