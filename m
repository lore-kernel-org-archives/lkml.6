Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E75DECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C08820883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zd95GFak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C08820883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbeIQVHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 17:07:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbeIQVHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 17:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bzomx/IUn4NIUll0JYoUGs9rlSPOkVSwtm87I8xtlZ0=; b=Zd95GFakd+s4YbZai2vygbqO0
        41ZGp7lacNeyUXacauFKShJr7kI4h9kKqt4QYiM3ddARroVuzEgs594rAh0kY7wOCOLWww/Sq65Sg
        PKKpaB4UGgcrkZhaZqLL1+u9ZCp+1cwWtAVC8BbdZa74ZGG3zoXbuUvb2dnCPSE80L5uiXiiTwtph
        b/4QwxmUX39zyxocTZchzVWpyb3WNYog/o37V5k2svzhyqpo64olryVwmLde9UuffUMwua8AQfTj0
        d9HwOzHClff2ZYmhUPN/PqaCX1kxcqio7zhIaIQQri076wRvPfYEbVYXl2zrNi21X/wUG1ge0U7l1
        wWhH5/9dw==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g1vby-0006HK-CN; Mon, 17 Sep 2018 15:38:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] swiotlb: add support for non-coherent DMA
Date:   Mon, 17 Sep 2018 17:38:25 +0200
Message-Id: <20180917153826.28052-9-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180917153826.28052-1-hch@lst.de>
References: <20180917153826.28052-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle architectures that are not cache coherent directly in the main
swiotlb code.  This involves two related changes:

 - call arch_sync_dma_for_{device,cpu} in all the right places from the
   various dma_map/unmap/sync methods when the device is non-coherent
 - call arch_dma_{alloc,free} for devices that are non-coherent

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/mm/dma-mapping.c |  6 ++---
 include/linux/swiotlb.h     |  4 ++--
 kernel/dma/swiotlb.c        | 44 ++++++++++++++++++++++++++++++-------
 3 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index abcae73eea50..07d9c2633f80 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -112,7 +112,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
 		return addr;
 	}
 
-	ptr = swiotlb_alloc(dev, size, dma_handle, flags, attrs);
+	ptr = __swiotlb_alloc(dev, size, dma_handle, flags, attrs);
 	if (!ptr)
 		goto no_mem;
 
@@ -133,7 +133,7 @@ static void *__dma_alloc(struct device *dev, size_t size,
 	return coherent_ptr;
 
 no_map:
-	swiotlb_free(dev, size, ptr, *dma_handle, attrs);
+	__swiotlb_free(dev, size, ptr, *dma_handle, attrs);
 no_mem:
 	return NULL;
 }
@@ -151,7 +151,7 @@ static void __dma_free(struct device *dev, size_t size,
 			return;
 		vunmap(vaddr);
 	}
-	swiotlb_free(dev, size, swiotlb_addr, dma_handle, attrs);
+	__swiotlb_free(dev, size, swiotlb_addr, dma_handle, attrs);
 }
 
 static dma_addr_t __swiotlb_map_page(struct device *dev, struct page *page,
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index f847c1b265c4..bc809d826d4f 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -67,9 +67,9 @@ extern void swiotlb_tbl_sync_single(struct device *hwdev,
 
 /* Accessory functions. */
 
-void *swiotlb_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle,
+void *__swiotlb_alloc(struct device *hwdev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flags, unsigned long attrs);
-void swiotlb_free(struct device *dev, size_t size, void *vaddr,
+void __swiotlb_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_addr, unsigned long attrs);
 
 extern dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 4d7a4d85d71e..83e597101c6a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -21,6 +21,7 @@
 
 #include <linux/cache.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/mm.h>
 #include <linux/export.h>
 #include <linux/spinlock.h>
@@ -749,6 +750,10 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 		dma_addr = swiotlb_bounce_page(dev, &phys, size, dir, attrs);
 	}
 
+	if (!dev_is_dma_coherent(dev) &&
+	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+		arch_sync_dma_for_device(dev, phys, size, dir);
+
 	return dma_addr;
 }
 
@@ -768,6 +773,10 @@ void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 
 	BUG_ON(dir == DMA_NONE);
 
+	if (!dev_is_dma_coherent(hwdev) &&
+	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+		arch_sync_dma_for_cpu(hwdev, paddr, size, dir);
+
 	if (is_swiotlb_buffer(paddr)) {
 		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
 		return;
@@ -804,15 +813,17 @@ swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
 
 	BUG_ON(dir == DMA_NONE);
 
-	if (is_swiotlb_buffer(paddr)) {
+	if (!dev_is_dma_coherent(hwdev) && target == SYNC_FOR_CPU)
+		arch_sync_dma_for_cpu(hwdev, paddr, size, dir);
+
+	if (is_swiotlb_buffer(paddr))
 		swiotlb_tbl_sync_single(hwdev, paddr, size, dir, target);
-		return;
-	}
 
-	if (dir != DMA_FROM_DEVICE)
-		return;
+	if (!dev_is_dma_coherent(hwdev) && target == SYNC_FOR_DEVICE)
+		arch_sync_dma_for_device(hwdev, paddr, size, dir);
 
-	dma_mark_clean(phys_to_virt(paddr), size);
+	if (!is_swiotlb_buffer(paddr) && dir == DMA_FROM_DEVICE)
+		dma_mark_clean(phys_to_virt(paddr), size);
 }
 
 void
@@ -928,7 +939,7 @@ swiotlb_dma_supported(struct device *hwdev, u64 mask)
 	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
 }
 
-void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+void *__swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs)
 {
 	void *vaddr;
@@ -950,13 +961,30 @@ void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	return vaddr;
 }
 
-void swiotlb_free(struct device *dev, size_t size, void *vaddr,
+static void *swiotlb_alloc(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	if (!dev_is_dma_coherent(dev))
+		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
+	return __swiotlb_alloc(dev, size, dma_handle, gfp, attrs);
+}
+
+void __swiotlb_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
 	if (!swiotlb_free_buffer(dev, size, dma_addr))
 		dma_direct_free(dev, size, vaddr, dma_addr, attrs);
 }
 
+static void swiotlb_free(struct device *dev, size_t size, void *vaddr,
+		dma_addr_t dma_addr, unsigned long attrs)
+{
+	if (!dev_is_dma_coherent(dev))
+		arch_dma_free(dev, size, vaddr, dma_addr, attrs);
+	else
+		__swiotlb_free(dev, size, vaddr, dma_addr, attrs);
+}
+
 const struct dma_map_ops swiotlb_dma_ops = {
 	.mapping_error		= dma_direct_mapping_error,
 	.alloc			= swiotlb_alloc,
-- 
2.18.0

