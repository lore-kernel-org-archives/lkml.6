Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6369CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3839D2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bB6Q+j4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405045AbfBMS3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:29:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393742AbfBMS3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jdOQ5vyc+zherAM5NTYhXc5p38ZCk+b+23FPXWVwQoI=; b=bB6Q+j4TnFETJVdwpgcZ/s7pZT
        V3pRgR3U+ziyzB7yYSOghET8/psuNiSclwtzR8WLYV6yx+Wn7C+uG3K3e5NQvp8+vreZNlEn9+I0O
        MlZsJlvS8JASBZJ6vIgjxq4ZRW1Lt4M0clme7PAy/BbGK3LkS6Tvx3+IZOX0NGhXw0KiK3WHGe00r
        a2FIEjbZtnolWiHHByyzHrgy1nKHEqHolEm8toFYKOKSDih7ODysR+oFR2Gp2ap8pPIt49gVWwJuh
        mIf+siWLiW5RI89sZ7+Vzqm3FLVs4IngA/Z7VXVQkh3lQWrGIw1bi0WGvhMskYkVq0Ukz37+5ls+S
        OlMFQLhA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtzHy-00089H-6X; Wed, 13 Feb 2019 18:29:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/21] dma-iommu: refactor iommu_dma_mmap
Date:   Wed, 13 Feb 2019 19:29:07 +0100
Message-Id: <20190213182920.16764-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213182920.16764-1-hch@lst.de>
References: <20190213182920.16764-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the vm_area handling into __iommu_dma_mmap, which is renamed
to iommu_dma_mmap_remap.

Inline __iommu_dma_mmap_pfn into the main function to simplify the code
flow a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 50 ++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c320c52cdac4..ed2ef8409806 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -598,23 +598,27 @@ static struct page **__iommu_dma_alloc(struct device *dev, size_t size,
 }
 
 /**
- * __iommu_dma_mmap - Map a buffer into provided user VMA
- * @pages: Array representing buffer from __iommu_dma_alloc()
+ * iommu_dma_mmap_remap - Map a remapped page array into provided user VMA
+ * @cpu_addr: virtual address of the memory to be remapped
  * @size: Size of buffer in bytes
  * @vma: VMA describing requested userspace mapping
  *
- * Maps the pages of the buffer in @pages into @vma. The caller is responsible
+ * Maps the pages pointed to by @cpu_addr into @vma. The caller is responsible
  * for verifying the correct size and protection of @vma beforehand.
  */
-static int __iommu_dma_mmap(struct page **pages, size_t size,
+static int iommu_dma_mmap_remap(void *cpu_addr, size_t size,
 		struct vm_area_struct *vma)
 {
+	struct vm_struct *area = find_vm_area(cpu_addr);
 	unsigned long uaddr = vma->vm_start;
 	unsigned int i, count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	int ret = -ENXIO;
 
+	if (WARN_ON(!area || !area->pages))
+		return -ENXIO;
+
 	for (i = vma->vm_pgoff; i < count && uaddr < vma->vm_end; i++) {
-		ret = vm_insert_page(vma, uaddr, pages[i]);
+		ret = vm_insert_page(vma, uaddr, area->pages[i]);
 		if (ret)
 			break;
 		uaddr += PAGE_SIZE;
@@ -1053,21 +1057,13 @@ static void iommu_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	}
 }
 
-static int __iommu_dma_mmap_pfn(struct vm_area_struct *vma,
-			      unsigned long pfn, size_t size)
-{
-	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
-			       vma->vm_end - vma->vm_start,
-			       vma->vm_page_prot);
-}
-
 static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs)
 {
 	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
-	struct vm_struct *area;
+	unsigned long pfn;
 	int ret;
 
 	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
@@ -1078,25 +1074,15 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (off >= nr_pages || vma_pages(vma) > nr_pages - off)
 		return -ENXIO;
 
-	if (!is_vmalloc_addr(cpu_addr)) {
-		unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
-		return __iommu_dma_mmap_pfn(vma, pfn, size);
-	}
+	if (is_vmalloc_addr(cpu_addr)) {
+		if (!(attrs & DMA_ATTR_FORCE_CONTIGUOUS))
+			return iommu_dma_mmap_remap(cpu_addr, size, vma);
+		pfn = vmalloc_to_pfn(cpu_addr);
+	} else
+		pfn = page_to_pfn(virt_to_page(cpu_addr));
 
-	if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		/*
-		 * DMA_ATTR_FORCE_CONTIGUOUS allocations are always remapped,
-		 * hence in the vmalloc space.
-		 */
-		unsigned long pfn = vmalloc_to_pfn(cpu_addr);
-		return __iommu_dma_mmap_pfn(vma, pfn, size);
-	}
-
-	area = find_vm_area(cpu_addr);
-	if (WARN_ON(!area || !area->pages))
-		return -ENXIO;
-
-	return __iommu_dma_mmap(area->pages, size, vma);
+	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
+			vma_pages(vma) << PAGE_SHIFT, vma->vm_page_prot);
 }
 
 static int __iommu_dma_get_sgtable_page(struct sg_table *sgt, struct page *page,
-- 
2.20.1

