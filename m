Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932560AbeCERue (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 12:50:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60246 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbeCERrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 12:47:14 -0500
From: Christoph Hellwig <hch@lst.de>
To: x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] x86/amd_gart: use dma_direct_{alloc,free}
Date: Mon,  5 Mar 2018 09:46:48 -0800
Message-Id: <20180305174655.9878-7-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180305174655.9878-1-hch@lst.de>
References: <20180305174655.9878-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This gains support for CMA allocations for the force_iommu case, and
cleans up the code a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/amd_gart_64.c | 36 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 79ac6caaaabb..f299d8a479bb 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -480,29 +480,21 @@ static void *
 gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
 		    gfp_t flag, unsigned long attrs)
 {
-	dma_addr_t paddr;
-	unsigned long align_mask;
-	struct page *page;
-
-	if (force_iommu && dev->coherent_dma_mask > DMA_BIT_MASK(24)) {
-		flag &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
-		page = alloc_pages(flag | __GFP_ZERO, get_order(size));
-		if (!page)
-			return NULL;
-
-		align_mask = (1UL << get_order(size)) - 1;
-		paddr = dma_map_area(dev, page_to_phys(page), size,
-				     DMA_BIDIRECTIONAL, align_mask);
-
-		flush_gart();
-		if (paddr != bad_dma_addr) {
-			*dma_addr = paddr;
-			return page_address(page);
-		}
-		__free_pages(page, get_order(size));
-	} else
-		return dma_direct_alloc(dev, size, dma_addr, flag, attrs);
+	void *vaddr;
+
+	vaddr = dma_direct_alloc(dev, size, dma_addr, flag, attrs);
+	if (!vaddr ||
+	    !force_iommu || dev->coherent_dma_mask <= DMA_BIT_MASK(24))
+		return vaddr;
 
+	*dma_addr = dma_map_area(dev, virt_to_phys(vaddr), size,
+			DMA_BIDIRECTIONAL, (1UL << get_order(size)) - 1);
+	flush_gart();
+	if (unlikely(*dma_addr == bad_dma_addr))
+		goto out_free;
+	return vaddr;
+out_free:
+	dma_direct_free(dev, size, vaddr, *dma_addr, attrs);
 	return NULL;
 }
 
-- 
2.14.2
