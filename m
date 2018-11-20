Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA770C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD054206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD054206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbeKUAjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:39:32 -0500
Received: from foss.arm.com ([217.140.101.70]:49432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728395AbeKUAjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:39:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84E9115BE;
        Tue, 20 Nov 2018 06:10:12 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 261053F5A0;
        Tue, 20 Nov 2018 06:10:11 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de, konrad.wilk@oracle.com
Cc:     m.szyprowski@samsung.com, john.stultz@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] swiotlb: Skip cache maintenance on map error
Date:   Tue, 20 Nov 2018 14:09:53 +0000
Message-Id: <a77c838eb070fb46c51802aa22c28bd8e1f9741c.1542722463.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
In-Reply-To: <cover.1542722463.git.robin.murphy@arm.com>
References: <cover.1542722463.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If swiotlb_bounce_page() failed, calling arch_sync_dma_for_device() may
lead to such delights as performing cache maintenance on whatever
address phys_to_virt(SWIOTLB_MAP_ERROR) looks like, which is typically
outside the kernel memory map and goes about as well as expected.

Don't do that.

Fixes: a4a4330db46a ("swiotlb: add support for non-coherent DMA")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/dma/swiotlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 5731daa09a32..045930e32c0e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -679,7 +679,8 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 	}
 
 	if (!dev_is_dma_coherent(dev) &&
-	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0 &&
+	    dev_addr != DIRECT_MAPPING_ERROR)
 		arch_sync_dma_for_device(dev, phys, size, dir);
 
 	return dev_addr;
-- 
2.19.1.dirty

