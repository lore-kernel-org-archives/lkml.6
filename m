Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752267AbeCWTvi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:51:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54293 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751930AbeCWTvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:51:37 -0400
Date: Fri, 23 Mar 2018 12:51:06 -0700
From: tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-b468620f2a1dfdcfddfd6fa54367b8bcc1b51248@git.kernel.org>
Cc: mingo@kernel.org, konrad.wilk@oracle.com, hch@lst.de,
        dwmw2@infradead.org, thomas.lendacky@amd.com, peterz@infradead.org,
        hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        jdmason@kudzu.us, joro@8bytes.org, mulix@mulix.org, jroedel@suse.de,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, jdmason@kudzu.us, joro@8bytes.org,
        mulix@mulix.org, jroedel@suse.de, torvalds@linux-foundation.org,
        hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
        dwmw2@infradead.org, thomas.lendacky@amd.com, mingo@kernel.org,
        konrad.wilk@oracle.com, hch@lst.de
In-Reply-To: <20180319103826.12853-8-hch@lst.de>
References: <20180319103826.12853-8-hch@lst.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/dma] iommu/amd_iommu: Use CONFIG_DMA_DIRECT_OPS=y and
 dma_direct_{alloc,free}()
Git-Commit-ID: b468620f2a1dfdcfddfd6fa54367b8bcc1b51248
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b468620f2a1dfdcfddfd6fa54367b8bcc1b51248
Gitweb:     https://git.kernel.org/tip/b468620f2a1dfdcfddfd6fa54367b8bcc1b51248
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Mon, 19 Mar 2018 11:38:19 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 10:01:58 +0100

iommu/amd_iommu: Use CONFIG_DMA_DIRECT_OPS=y and dma_direct_{alloc,free}()

This cleans up the code a lot by removing duplicate logic.

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Tested-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: iommu@lists.linux-foundation.org
Link: http://lkml.kernel.org/r/20180319103826.12853-8-hch@lst.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/iommu/Kconfig     |  1 +
 drivers/iommu/amd_iommu.c | 68 +++++++++++++++--------------------------------
 2 files changed, 22 insertions(+), 47 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index f3a21343e636..dc7c1914645d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -107,6 +107,7 @@ config IOMMU_PGTABLES_L2
 # AMD IOMMU support
 config AMD_IOMMU
 	bool "AMD IOMMU support"
+	select DMA_DIRECT_OPS
 	select SWIOTLB
 	select PCI_MSI
 	select PCI_ATS
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 0bf19423b588..83819d0cbf90 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2600,51 +2600,32 @@ static void *alloc_coherent(struct device *dev, size_t size,
 			    unsigned long attrs)
 {
 	u64 dma_mask = dev->coherent_dma_mask;
-	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
-	struct page *page;
-
-	domain = get_domain(dev);
-	if (PTR_ERR(domain) == -EINVAL) {
-		page = alloc_pages(flag, get_order(size));
-		*dma_addr = page_to_phys(page);
-		return page_address(page);
-	} else if (IS_ERR(domain))
-		return NULL;
+	struct protection_domain *domain = get_domain(dev);
+	bool is_direct = false;
+	void *virt_addr;
 
-	dma_dom   = to_dma_ops_domain(domain);
-	size	  = PAGE_ALIGN(size);
-	dma_mask  = dev->coherent_dma_mask;
-	flag     &= ~(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32);
-	flag     |= __GFP_ZERO;
-
-	page = alloc_pages(flag | __GFP_NOWARN,  get_order(size));
-	if (!page) {
-		if (!gfpflags_allow_blocking(flag))
-			return NULL;
-
-		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
-						 get_order(size), flag);
-		if (!page)
+	if (IS_ERR(domain)) {
+		if (PTR_ERR(domain) != -EINVAL)
 			return NULL;
+		is_direct = true;
 	}
 
+	virt_addr = dma_direct_alloc(dev, size, dma_addr, flag, attrs);
+	if (!virt_addr || is_direct)
+		return virt_addr;
+
 	if (!dma_mask)
 		dma_mask = *dev->dma_mask;
 
-	*dma_addr = __map_single(dev, dma_dom, page_to_phys(page),
-				 size, DMA_BIDIRECTIONAL, dma_mask);
-
+	*dma_addr = __map_single(dev, to_dma_ops_domain(domain),
+			virt_to_phys(virt_addr), PAGE_ALIGN(size),
+			DMA_BIDIRECTIONAL, dma_mask);
 	if (*dma_addr == AMD_IOMMU_MAPPING_ERROR)
 		goto out_free;
-
-	return page_address(page);
+	return virt_addr;
 
 out_free:
-
-	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
-		__free_pages(page, get_order(size));
-
+	dma_direct_free(dev, size, virt_addr, *dma_addr, attrs);
 	return NULL;
 }
 
@@ -2655,24 +2636,17 @@ static void free_coherent(struct device *dev, size_t size,
 			  void *virt_addr, dma_addr_t dma_addr,
 			  unsigned long attrs)
 {
-	struct protection_domain *domain;
-	struct dma_ops_domain *dma_dom;
-	struct page *page;
+	struct protection_domain *domain = get_domain(dev);
 
-	page = virt_to_page(virt_addr);
 	size = PAGE_ALIGN(size);
 
-	domain = get_domain(dev);
-	if (IS_ERR(domain))
-		goto free_mem;
+	if (!IS_ERR(domain)) {
+		struct dma_ops_domain *dma_dom = to_dma_ops_domain(domain);
 
-	dma_dom = to_dma_ops_domain(domain);
-
-	__unmap_single(dma_dom, dma_addr, size, DMA_BIDIRECTIONAL);
+		__unmap_single(dma_dom, dma_addr, size, DMA_BIDIRECTIONAL);
+	}
 
-free_mem:
-	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
-		__free_pages(page, get_order(size));
+	dma_direct_free(dev, size, virt_addr, dma_addr, attrs);
 }
 
 /*
