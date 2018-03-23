Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeCWTwI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:52:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45553 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbeCWTwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:52:07 -0400
Date: Fri, 23 Mar 2018 12:51:34 -0700
From: tip-bot for Christoph Hellwig <tipbot@zytor.com>
Message-ID: <tip-d657c5c73ca987214a6f9436e435b34fc60f332a@git.kernel.org>
Cc: mingo@kernel.org, peterz@infradead.org, dwmw2@infradead.org,
        hpa@zytor.com, jdmason@kudzu.us, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hch@lst.de, mulix@mulix.org,
        konrad.wilk@oracle.com, joro@8bytes.org, torvalds@linux-foundation.org,
        thomas.lendacky@amd.com
Reply-To: joro@8bytes.org, thomas.lendacky@amd.com,
        torvalds@linux-foundation.org, mulix@mulix.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, hch@lst.de, mingo@kernel.org,
        peterz@infradead.org, dwmw2@infradead.org, jdmason@kudzu.us,
        hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20180319103826.12853-9-hch@lst.de>
References: <20180319103826.12853-9-hch@lst.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/dma] iommu/intel-iommu: Enable CONFIG_DMA_DIRECT_OPS=y and
 clean up intel_{alloc,free}_coherent()
Git-Commit-ID: d657c5c73ca987214a6f9436e435b34fc60f332a
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

Commit-ID:  d657c5c73ca987214a6f9436e435b34fc60f332a
Gitweb:     https://git.kernel.org/tip/d657c5c73ca987214a6f9436e435b34fc60f332a
Author:     Christoph Hellwig <hch@lst.de>
AuthorDate: Mon, 19 Mar 2018 11:38:20 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 10:01:58 +0100

iommu/intel-iommu: Enable CONFIG_DMA_DIRECT_OPS=y and clean up intel_{alloc,free}_coherent()

Use the dma_direct_*() helpers and clean up the code flow.

Tested-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: iommu@lists.linux-foundation.org
Link: http://lkml.kernel.org/r/20180319103826.12853-9-hch@lst.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/iommu/Kconfig       |  1 +
 drivers/iommu/intel-iommu.c | 62 ++++++++++++---------------------------------
 2 files changed, 17 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dc7c1914645d..df171cb85822 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -143,6 +143,7 @@ config DMAR_TABLE
 config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
 	depends on PCI_MSI && ACPI && (X86 || IA64_GENERIC)
+	select DMA_DIRECT_OPS
 	select IOMMU_API
 	select IOMMU_IOVA
 	select DMAR_TABLE
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fd899b2a12bb..24d1b1b42013 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -31,6 +31,7 @@
 #include <linux/pci.h>
 #include <linux/dmar.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/mempool.h>
 #include <linux/memory.h>
 #include <linux/cpu.h>
@@ -3708,61 +3709,30 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flags,
 				  unsigned long attrs)
 {
-	struct page *page = NULL;
-	int order;
-
-	size = PAGE_ALIGN(size);
-	order = get_order(size);
-
-	if (!iommu_no_mapping(dev))
-		flags &= ~(GFP_DMA | GFP_DMA32);
-	else if (dev->coherent_dma_mask < dma_get_required_mask(dev)) {
-		if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
-			flags |= GFP_DMA;
-		else
-			flags |= GFP_DMA32;
-	}
+	void *vaddr;
 
-	if (gfpflags_allow_blocking(flags)) {
-		unsigned int count = size >> PAGE_SHIFT;
+	vaddr = dma_direct_alloc(dev, size, dma_handle, flags, attrs);
+	if (iommu_no_mapping(dev) || !vaddr)
+		return vaddr;
 
-		page = dma_alloc_from_contiguous(dev, count, order, flags);
-		if (page && iommu_no_mapping(dev) &&
-		    page_to_phys(page) + size > dev->coherent_dma_mask) {
-			dma_release_from_contiguous(dev, page, count);
-			page = NULL;
-		}
-	}
-
-	if (!page)
-		page = alloc_pages(flags, order);
-	if (!page)
-		return NULL;
-	memset(page_address(page), 0, size);
-
-	*dma_handle = __intel_map_single(dev, page_to_phys(page), size,
-					 DMA_BIDIRECTIONAL,
-					 dev->coherent_dma_mask);
-	if (*dma_handle)
-		return page_address(page);
-	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
-		__free_pages(page, order);
+	*dma_handle = __intel_map_single(dev, virt_to_phys(vaddr),
+			PAGE_ALIGN(size), DMA_BIDIRECTIONAL,
+			dev->coherent_dma_mask);
+	if (!*dma_handle)
+		goto out_free_pages;
+	return vaddr;
 
+out_free_pages:
+	dma_direct_free(dev, size, vaddr, *dma_handle, attrs);
 	return NULL;
 }
 
 static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 				dma_addr_t dma_handle, unsigned long attrs)
 {
-	int order;
-	struct page *page = virt_to_page(vaddr);
-
-	size = PAGE_ALIGN(size);
-	order = get_order(size);
-
-	intel_unmap(dev, dma_handle, size);
-	if (!dma_release_from_contiguous(dev, page, size >> PAGE_SHIFT))
-		__free_pages(page, order);
+	if (!iommu_no_mapping(dev))
+		intel_unmap(dev, dma_handle, PAGE_ALIGN(size));
+	dma_direct_free(dev, size, vaddr, dma_handle, attrs);
 }
 
 static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
