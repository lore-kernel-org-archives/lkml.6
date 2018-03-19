Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932983AbeCSKj3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 06:39:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55236 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932922AbeCSKjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 06:39:23 -0400
From: Christoph Hellwig <hch@lst.de>
To: x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/14] dma-direct: handle the memory encryption bit in common code
Date: Mon, 19 Mar 2018 11:38:24 +0100
Message-Id: <20180319103826.12853-13-hch@lst.de>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20180319103826.12853-1-hch@lst.de>
References: <20180319103826.12853-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Give the basic phys_to_dma and dma_to_phys helpers a __-prefix and add
the memory encryption mask to the non-prefixed versions.  Use the
__-prefixed versions directly instead of clearing the mask again in
various places.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-direct.h                  |  4 ++--
 arch/mips/cavium-octeon/dma-octeon.c               | 10 ++++-----
 .../include/asm/mach-cavium-octeon/dma-coherence.h |  4 ++--
 .../include/asm/mach-loongson64/dma-coherence.h    | 10 ++++-----
 arch/mips/loongson64/common/dma-swiotlb.c          |  4 ++--
 arch/powerpc/include/asm/dma-direct.h              |  4 ++--
 arch/x86/Kconfig                                   |  2 +-
 arch/x86/include/asm/dma-direct.h                  | 25 ++--------------------
 arch/x86/mm/mem_encrypt.c                          |  2 +-
 arch/x86/pci/sta2x11-fixup.c                       |  6 +++---
 include/linux/dma-direct.h                         | 21 ++++++++++++++++--
 lib/swiotlb.c                                      | 25 ++++++++--------------
 12 files changed, 53 insertions(+), 64 deletions(-)

diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
index 5b0a8a421894..b67e5fc1fe43 100644
--- a/arch/arm/include/asm/dma-direct.h
+++ b/arch/arm/include/asm/dma-direct.h
@@ -2,13 +2,13 @@
 #ifndef ASM_ARM_DMA_DIRECT_H
 #define ASM_ARM_DMA_DIRECT_H 1
 
-static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	unsigned int offset = paddr & ~PAGE_MASK;
 	return pfn_to_dma(dev, __phys_to_pfn(paddr)) + offset;
 }
 
-static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
+static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 {
 	unsigned int offset = dev_addr & ~PAGE_MASK;
 	return __pfn_to_phys(dma_to_pfn(dev, dev_addr)) + offset;
diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index c7bb8a407041..7b335ab21697 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -10,7 +10,7 @@
  * IP32 changes by Ilya.
  * Copyright (C) 2010 Cavium Networks, Inc.
  */
-#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/scatterlist.h>
 #include <linux/bootmem.h>
 #include <linux/export.h>
@@ -182,7 +182,7 @@ struct octeon_dma_map_ops {
 	phys_addr_t (*dma_to_phys)(struct device *dev, dma_addr_t daddr);
 };
 
-dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	struct octeon_dma_map_ops *ops = container_of(get_dma_ops(dev),
 						      struct octeon_dma_map_ops,
@@ -190,9 +190,9 @@ dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 
 	return ops->phys_to_dma(dev, paddr);
 }
-EXPORT_SYMBOL(phys_to_dma);
+EXPORT_SYMBOL(__phys_to_dma);
 
-phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
 	struct octeon_dma_map_ops *ops = container_of(get_dma_ops(dev),
 						      struct octeon_dma_map_ops,
@@ -200,7 +200,7 @@ phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 
 	return ops->dma_to_phys(dev, daddr);
 }
-EXPORT_SYMBOL(dma_to_phys);
+EXPORT_SYMBOL(__dma_to_phys);
 
 static struct octeon_dma_map_ops octeon_linear_dma_map_ops = {
 	.dma_map_ops = {
diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
index 138edf6b5b48..6eb1ee548b11 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
@@ -69,8 +69,8 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	return addr + size - 1 <= *dev->dma_mask;
 }
 
-dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
-phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr);
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr);
 
 struct dma_map_ops;
 extern const struct dma_map_ops *octeon_pci_dma_map_ops;
diff --git a/arch/mips/include/asm/mach-loongson64/dma-coherence.h b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
index b1b575f5c6c1..64fc44dec0a8 100644
--- a/arch/mips/include/asm/mach-loongson64/dma-coherence.h
+++ b/arch/mips/include/asm/mach-loongson64/dma-coherence.h
@@ -25,13 +25,13 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	return addr + size - 1 <= *dev->dma_mask;
 }
 
-extern dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
-extern phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);
+extern dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr);
+extern phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr);
 static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 					  size_t size)
 {
 #ifdef CONFIG_CPU_LOONGSON3
-	return phys_to_dma(dev, virt_to_phys(addr));
+	return __phys_to_dma(dev, virt_to_phys(addr));
 #else
 	return virt_to_phys(addr) | 0x80000000;
 #endif
@@ -41,7 +41,7 @@ static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
 					       struct page *page)
 {
 #ifdef CONFIG_CPU_LOONGSON3
-	return phys_to_dma(dev, page_to_phys(page));
+	return __phys_to_dma(dev, page_to_phys(page));
 #else
 	return page_to_phys(page) | 0x80000000;
 #endif
@@ -51,7 +51,7 @@ static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
 #if defined(CONFIG_CPU_LOONGSON3) && defined(CONFIG_64BIT)
-	return dma_to_phys(dev, dma_addr);
+	return __dma_to_phys(dev, dma_addr);
 #elif defined(CONFIG_CPU_LOONGSON2F) && defined(CONFIG_64BIT)
 	return (dma_addr > 0x8fffffff) ? dma_addr : (dma_addr & 0x0fffffff);
 #else
diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
index 7bbcf89475f3..6a739f8ae110 100644
--- a/arch/mips/loongson64/common/dma-swiotlb.c
+++ b/arch/mips/loongson64/common/dma-swiotlb.c
@@ -63,7 +63,7 @@ static int loongson_dma_supported(struct device *dev, u64 mask)
 	return swiotlb_dma_supported(dev, mask);
 }
 
-dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	long nid;
 #ifdef CONFIG_PHYS48_TO_HT40
@@ -75,7 +75,7 @@ dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 	return paddr;
 }
 
-phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
 	long nid;
 #ifdef CONFIG_PHYS48_TO_HT40
diff --git a/arch/powerpc/include/asm/dma-direct.h b/arch/powerpc/include/asm/dma-direct.h
index a5b59c765426..7702875aabb7 100644
--- a/arch/powerpc/include/asm/dma-direct.h
+++ b/arch/powerpc/include/asm/dma-direct.h
@@ -17,12 +17,12 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	return addr + size - 1 <= *dev->dma_mask;
 }
 
-static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	return paddr + get_dma_offset(dev);
 }
 
-static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
+static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
 	return daddr - get_dma_offset(dev);
 }
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 10f482beda1b..1ca4f0874517 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -54,7 +54,6 @@ config X86
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
-	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_REFCOUNT
@@ -692,6 +691,7 @@ config X86_SUPPORTS_MEMORY_FAILURE
 config STA2X11
 	bool "STA2X11 Companion Chip Support"
 	depends on X86_32_NON_STANDARD && PCI
+	select ARCH_HAS_PHYS_TO_DMA
 	select X86_DEV_DMA_OPS
 	select X86_DMA_REMAP
 	select SWIOTLB
diff --git a/arch/x86/include/asm/dma-direct.h b/arch/x86/include/asm/dma-direct.h
index 1295bc622ebe..1a19251eaac9 100644
--- a/arch/x86/include/asm/dma-direct.h
+++ b/arch/x86/include/asm/dma-direct.h
@@ -2,29 +2,8 @@
 #ifndef ASM_X86_DMA_DIRECT_H
 #define ASM_X86_DMA_DIRECT_H 1
 
-#include <linux/mem_encrypt.h>
-
-#ifdef CONFIG_X86_DMA_REMAP /* Platform code defines bridge-specific code */
 bool dma_capable(struct device *dev, dma_addr_t addr, size_t size);
-dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
-phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr);
-#else
-static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
-{
-	if (!dev->dma_mask)
-		return 0;
-
-	return addr + size - 1 <= *dev->dma_mask;
-}
-
-static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
-{
-	return __sme_set(paddr);
-}
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr);
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr);
 
-static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
-{
-	return __sme_clr(daddr);
-}
-#endif /* CONFIG_X86_DMA_REMAP */
 #endif /* ASM_X86_DMA_DIRECT_H */
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index d3b80d5f9828..1a05bea831a8 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -216,7 +216,7 @@ static void *sev_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		 * Since we will be clearing the encryption bit, check the
 		 * mask with it already cleared.
 		 */
-		addr = __sme_clr(phys_to_dma(dev, page_to_phys(page)));
+		addr = __phys_to_dma(dev, page_to_phys(page));
 		if ((addr + size) > dev->coherent_dma_mask) {
 			__free_pages(page, get_order(size));
 		} else {
diff --git a/arch/x86/pci/sta2x11-fixup.c b/arch/x86/pci/sta2x11-fixup.c
index eac58e03f43c..7a5bafb76d77 100644
--- a/arch/x86/pci/sta2x11-fixup.c
+++ b/arch/x86/pci/sta2x11-fixup.c
@@ -207,11 +207,11 @@ bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 }
 
 /**
- * phys_to_dma - Return the DMA AMBA address used for this STA2x11 device
+ * __phys_to_dma - Return the DMA AMBA address used for this STA2x11 device
  * @dev: device for a PCI device
  * @paddr: Physical address
  */
-dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	if (!dev->archdata.is_sta2x11)
 		return paddr;
@@ -223,7 +223,7 @@ dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
  * @dev: device for a PCI device
  * @daddr: STA2x11 AMBA DMA address
  */
-phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
+phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
 	if (!dev->archdata.is_sta2x11)
 		return daddr;
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index bcdb1a3e4b1f..53ad6a47f513 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -3,18 +3,19 @@
 #define _LINUX_DMA_DIRECT_H 1
 
 #include <linux/dma-mapping.h>
+#include <linux/mem_encrypt.h>
 
 #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
 #include <asm/dma-direct.h>
 #else
-static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	dma_addr_t dev_addr = (dma_addr_t)paddr;
 
 	return dev_addr - ((dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
 }
 
-static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
+static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
 {
 	phys_addr_t paddr = (phys_addr_t)dev_addr;
 
@@ -30,6 +31,22 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 }
 #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
 
+/*
+ * If memory encryption is supported, phys_to_dma will set the memory encryption
+ * bit in the DMA address, and dma_to_phys will clear it.  The raw __phys_to_dma
+ * and __dma_to_phys versions should only be used on non-encrypted memory for
+ * special occasions like DMA coherent buffers.
+ */
+static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return __sme_set(__phys_to_dma(dev, paddr));
+}
+
+static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
+{
+	return __sme_clr(__dma_to_phys(dev, daddr));
+}
+
 #ifdef CONFIG_ARCH_HAS_DMA_MARK_CLEAN
 void dma_mark_clean(void *addr, size_t size);
 #else
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 005d1d87bb2e..8b06b4485e65 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -157,13 +157,6 @@ unsigned long swiotlb_size_or_default(void)
 	return size ? size : (IO_TLB_DEFAULT_SIZE);
 }
 
-/* For swiotlb, clear memory encryption mask from dma addresses */
-static dma_addr_t swiotlb_phys_to_dma(struct device *hwdev,
-				      phys_addr_t address)
-{
-	return __sme_clr(phys_to_dma(hwdev, address));
-}
-
 /* Note that this doesn't work with highmem page */
 static dma_addr_t swiotlb_virt_to_bus(struct device *hwdev,
 				      volatile void *address)
@@ -622,7 +615,7 @@ map_single(struct device *hwdev, phys_addr_t phys, size_t size,
 		return SWIOTLB_MAP_ERROR;
 	}
 
-	start_dma_addr = swiotlb_phys_to_dma(hwdev, io_tlb_start);
+	start_dma_addr = __phys_to_dma(hwdev, io_tlb_start);
 	return swiotlb_tbl_map_single(hwdev, start_dma_addr, phys, size,
 				      dir, attrs);
 }
@@ -726,12 +719,12 @@ swiotlb_alloc_buffer(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		goto out_warn;
 
 	phys_addr = swiotlb_tbl_map_single(dev,
-			swiotlb_phys_to_dma(dev, io_tlb_start),
+			__phys_to_dma(dev, io_tlb_start),
 			0, size, DMA_FROM_DEVICE, 0);
 	if (phys_addr == SWIOTLB_MAP_ERROR)
 		goto out_warn;
 
-	*dma_handle = swiotlb_phys_to_dma(dev, phys_addr);
+	*dma_handle = __phys_to_dma(dev, phys_addr);
 	if (dma_coherent_ok(dev, *dma_handle, size))
 		goto out_unmap;
 
@@ -867,10 +860,10 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 	map = map_single(dev, phys, size, dir, attrs);
 	if (map == SWIOTLB_MAP_ERROR) {
 		swiotlb_full(dev, size, dir, 1);
-		return swiotlb_phys_to_dma(dev, io_tlb_overflow_buffer);
+		return __phys_to_dma(dev, io_tlb_overflow_buffer);
 	}
 
-	dev_addr = swiotlb_phys_to_dma(dev, map);
+	dev_addr = __phys_to_dma(dev, map);
 
 	/* Ensure that the address returned is DMA'ble */
 	if (dma_capable(dev, dev_addr, size))
@@ -879,7 +872,7 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 	attrs |= DMA_ATTR_SKIP_CPU_SYNC;
 	swiotlb_tbl_unmap_single(dev, map, size, dir, attrs);
 
-	return swiotlb_phys_to_dma(dev, io_tlb_overflow_buffer);
+	return __phys_to_dma(dev, io_tlb_overflow_buffer);
 }
 
 /*
@@ -1009,7 +1002,7 @@ swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
 				sg_dma_len(sgl) = 0;
 				return 0;
 			}
-			sg->dma_address = swiotlb_phys_to_dma(hwdev, map);
+			sg->dma_address = __phys_to_dma(hwdev, map);
 		} else
 			sg->dma_address = dev_addr;
 		sg_dma_len(sg) = sg->length;
@@ -1073,7 +1066,7 @@ swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
 int
 swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
 {
-	return (dma_addr == swiotlb_phys_to_dma(hwdev, io_tlb_overflow_buffer));
+	return (dma_addr == __phys_to_dma(hwdev, io_tlb_overflow_buffer));
 }
 
 /*
@@ -1085,7 +1078,7 @@ swiotlb_dma_mapping_error(struct device *hwdev, dma_addr_t dma_addr)
 int
 swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
-	return swiotlb_phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
+	return __phys_to_dma(hwdev, io_tlb_end - 1) <= mask;
 }
 
 #ifdef CONFIG_DMA_DIRECT_OPS
-- 
2.14.2
