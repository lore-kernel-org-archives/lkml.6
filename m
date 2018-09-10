Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7E3C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C7A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nWYpnq62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C7A20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbeIJK6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 06:58:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49738 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbeIJK6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 06:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mSJJDxJ1oSP8iGB5PKNCPd1Kecg4lnzqPWN5LcGu2oU=; b=nWYpnq62+N6WjTBXyrSy6n77C
        wg6E+ltRRV5kEdTucuPWyEkEPgMcjcWmR9cYof8zLyApgcgwMx8R923nyrtw8sX9Ins8P6LotZtr6
        8IZpkBwdgqN4HkT1k8Ov/kHa/RaFth4HK9Vp5vaj1VYkWk4d8B0Za09uMtLFBJOa4WvNSmg/6FpoN
        mX/KnIUWotR6gDWnTLmu4ud5D7V46RubhbR18NhWB8yF8buI88Ix4Ob3dAt/Z8qlpIgK78MpGWgps
        iVWludZBdIpQXZEGyoZ3g0vuXWdoBs2v5wU39p7WS4/3F5QhfBZ/OBOJJAZe6dn1jYIxGZWmmQ2cw
        m2awJJEqQ==;
Received: from 213-225-3-213.nat.highway.a1.net ([213.225.3.213] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzFKX-00084e-Nh; Mon, 10 Sep 2018 06:05:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] dma-mapping: consolidate the dma mmap implementations
Date:   Mon, 10 Sep 2018 08:05:32 +0200
Message-Id: <20180910060533.27172-5-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180910060533.27172-1-hch@lst.de>
References: <20180910060533.27172-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only functional differences (modulo a few missing fixes in the arch
code) is that architectures without coherent caches need a hook to
convert a virtual or dma address into a pfn, given that we don't have
the kernel linear mapping available for the otherwise easy virt_to_page
call.  As a side effect we can support mmap of the per-device coherent
area even on architectures not providing the callback, and we make
previous dangerous default methods dma_common_mmap actually save for
non-coherent architectures by rejecting it without the right helper.

In addition to that we need a hook so that some architectures can
override the protection bits when mmaping a dma coherent allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts
---
 arch/arc/Kconfig                      |  2 +-
 arch/arc/mm/dma.c                     | 25 +++------------------
 arch/arm/mm/dma-mapping-nommu.c       |  2 +-
 arch/microblaze/Kconfig               |  2 +-
 arch/microblaze/include/asm/pgtable.h |  2 --
 arch/microblaze/kernel/dma.c          | 22 ------------------
 arch/microblaze/mm/consistent.c       |  3 ++-
 arch/mips/Kconfig                     |  3 ++-
 arch/mips/jazz/jazzdma.c              |  1 -
 arch/mips/mm/dma-noncoherent.c        | 32 ++++++++-------------------
 drivers/xen/swiotlb-xen.c             |  2 +-
 include/linux/dma-mapping.h           |  5 +++--
 include/linux/dma-noncoherent.h       | 10 +++++++--
 kernel/dma/Kconfig                    | 10 +++++----
 kernel/dma/direct.c                   | 11 ---------
 kernel/dma/mapping.c                  | 32 ++++++++++++++++++---------
 16 files changed, 58 insertions(+), 106 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index ca03694d518a..3d9bdecfa52d 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -9,6 +9,7 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
+	select ARCH_HAS_DMA_COHERENT_TO_PFN
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
@@ -18,7 +19,6 @@ config ARC
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select DMA_DIRECT_OPS
-	select DMA_NONCOHERENT_MMAP
 	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_FIND_FIRST_BIT
diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 535ed4a068ef..db203ff69ccf 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -84,29 +84,10 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 	__free_pages(page, get_order(size));
 }
 
-int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-		void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		unsigned long attrs)
+long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
+		dma_addr_t dma_addr)
 {
-	unsigned long user_count = vma_pages(vma);
-	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long pfn = __phys_to_pfn(dma_addr);
-	unsigned long off = vma->vm_pgoff;
-	int ret = -ENXIO;
-
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-
-	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-
-	if (off < count && user_count <= (count - off)) {
-		ret = remap_pfn_range(vma, vma->vm_start,
-				      pfn + off,
-				      user_count << PAGE_SHIFT,
-				      vma->vm_page_prot);
-	}
-
-	return ret;
+	return __phys_to_pfn(dma_addr);
 }
 
 /*
diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index 0ad156f9985b..712416ecd8e6 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -91,7 +91,7 @@ static int arm_nommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 	if (dma_mmap_from_global_coherent(vma, cpu_addr, size, &ret))
 		return ret;
 
-	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
+	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
 }
 
 
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 0f48ab6a8070..164a4857737a 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -1,6 +1,7 @@
 config MICROBLAZE
 	def_bool y
 	select ARCH_NO_SWAP
+	select ARCH_HAS_DMA_COHERENT_TO_PFN if MMU
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
@@ -12,7 +13,6 @@ config MICROBLAZE
 	select CLONE_BACKWARDS3
 	select COMMON_CLK
 	select DMA_DIRECT_OPS
-	select DMA_NONCOHERENT_MMAP
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CPU_DEVICES
diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
index 7b650ab14fa0..f64ebb9c9a41 100644
--- a/arch/microblaze/include/asm/pgtable.h
+++ b/arch/microblaze/include/asm/pgtable.h
@@ -553,8 +553,6 @@ void __init *early_get_page(void);
 
 extern unsigned long ioremap_bot, ioremap_base;
 
-unsigned long consistent_virt_to_pfn(void *vaddr);
-
 void setup_memory(void);
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
index 71032cf64669..a89c2d4ed5ff 100644
--- a/arch/microblaze/kernel/dma.c
+++ b/arch/microblaze/kernel/dma.c
@@ -42,25 +42,3 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 {
 	__dma_sync(dev, paddr, size, dir);
 }
-
-int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-		void *cpu_addr, dma_addr_t handle, size_t size,
-		unsigned long attrs)
-{
-#ifdef CONFIG_MMU
-	unsigned long user_count = vma_pages(vma);
-	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long off = vma->vm_pgoff;
-	unsigned long pfn;
-
-	if (off >= count || user_count > (count - off))
-		return -ENXIO;
-
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	pfn = consistent_virt_to_pfn(cpu_addr);
-	return remap_pfn_range(vma, vma->vm_start, pfn + off,
-			       vma->vm_end - vma->vm_start, vma->vm_page_prot);
-#else
-	return -ENXIO;
-#endif
-}
diff --git a/arch/microblaze/mm/consistent.c b/arch/microblaze/mm/consistent.c
index c9a278ac795a..d801cc5f5b95 100644
--- a/arch/microblaze/mm/consistent.c
+++ b/arch/microblaze/mm/consistent.c
@@ -165,7 +165,8 @@ static pte_t *consistent_virt_to_pte(void *vaddr)
 	return pte_offset_kernel(pmd_offset(pgd_offset_k(addr), addr), addr);
 }
 
-unsigned long consistent_virt_to_pfn(void *vaddr)
+long arch_dma_coherent_to_pfn(struct device *dev, void *vaddr,
+		dma_addr_t dma_addr)
 {
 	pte_t *ptep = consistent_virt_to_pte(vaddr);
 
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 96da6e3396e1..77c022e56e6e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1116,10 +1116,11 @@ config DMA_PERDEV_COHERENT
 
 config DMA_NONCOHERENT
 	bool
+	select ARCH_HAS_DMA_MMAP_PGPROT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select NEED_DMA_MAP_STATE
-	select DMA_NONCOHERENT_MMAP
+	select ARCH_HAS_DMA_COHERENT_TO_PFN
 	select DMA_NONCOHERENT_CACHE_SYNC
 
 config SYS_HAS_EARLY_PRINTK
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index bb49dfa1a9a3..0a0aaf39fd16 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -682,7 +682,6 @@ static int jazz_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 const struct dma_map_ops jazz_dma_ops = {
 	.alloc			= jazz_dma_alloc,
 	.free			= jazz_dma_free,
-	.mmap			= arch_dma_mmap,
 	.map_page		= jazz_dma_map_page,
 	.unmap_page		= jazz_dma_unmap_page,
 	.map_sg			= jazz_dma_map_sg,
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index b01b9a3e424f..e6c9485cadcf 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -66,33 +66,19 @@ void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
 }
 
-int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-		void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		unsigned long attrs)
+long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
+		dma_addr_t dma_addr)
 {
-	unsigned long user_count = vma_pages(vma);
-	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long addr = CAC_ADDR((unsigned long)cpu_addr);
-	unsigned long off = vma->vm_pgoff;
-	unsigned long pfn = page_to_pfn(virt_to_page((void *)addr));
-	int ret = -ENXIO;
+	return page_to_pfn(virt_to_page((void *)addr));
+}
 
+pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
+		unsigned long attrs)
+{
 	if (attrs & DMA_ATTR_WRITE_COMBINE)
-		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
-	else
-		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-
-	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-
-	if (off < count && user_count <= (count - off)) {
-		ret = remap_pfn_range(vma, vma->vm_start,
-				      pfn + off,
-				      user_count << PAGE_SHIFT,
-				      vma->vm_page_prot);
-	}
-
-	return ret;
+		return pgprot_writecombine(prot);
+	return pgprot_noncached(prot);
 }
 
 static inline void dma_sync_virt(void *addr, size_t size,
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index a6f9ba85dc4b..470757ddddea 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -662,7 +662,7 @@ xen_swiotlb_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		return xen_get_dma_ops(dev)->mmap(dev, vma, cpu_addr,
 						    dma_addr, size, attrs);
 #endif
-	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
+	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
 }
 
 /*
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 8f2001181cd1..c3378d4e0d57 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -444,7 +444,8 @@ dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 }
 
 extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
-			   void *cpu_addr, dma_addr_t dma_addr, size_t size);
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs);
 
 void *dma_common_contiguous_remap(struct page *page, size_t size,
 			unsigned long vm_flags,
@@ -476,7 +477,7 @@ dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma, void *cpu_addr,
 	BUG_ON(!ops);
 	if (ops->mmap)
 		return ops->mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
-	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
+	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
 }
 
 #define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, 0)
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 12c3e1a9b391..52b0250ea83c 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -24,9 +24,15 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs);
-int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
+		dma_addr_t dma_addr);
+
+#ifdef CONFIG_ARCH_HAS_DMA_MMAP_PGPROT
+pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
 		unsigned long attrs);
+#else
+# define arch_dma_mmap_pgprot(dev, prot, attrs)	pgprot_noncached(prot)
+#endif
 
 #ifdef CONFIG_DMA_NONCOHERENT_CACHE_SYNC
 void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 0154412128be..f544b2c1d8dc 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -26,13 +26,15 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
 	bool
 	select NEED_DMA_MAP_STATE
 
-config DMA_DIRECT_OPS
+config ARCH_HAS_DMA_COHERENT_TO_PFN
 	bool
-	depends on HAS_DMA
 
-config DMA_NONCOHERENT_MMAP
+config ARCH_HAS_DMA_MMAP_PGPROT
 	bool
-	depends on DMA_DIRECT_OPS
+
+config DMA_DIRECT_OPS
+	bool
+	depends on HAS_DMA
 
 config DMA_NONCOHERENT_CACHE_SYNC
 	bool
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 09e85f6aa4ba..c954f0a6dc62 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -155,16 +155,6 @@ void dma_direct_free(struct device *dev, size_t size,
 		dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
 }
 
-static int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
-		void *cpu_addr, dma_addr_t dma_addr, size_t size,
-		unsigned long attrs)
-{
-	if (!dev_is_dma_coherent(dev) &&
-	    IS_ENABLED(CONFIG_DMA_NONCOHERENT_MMAP))
-		return arch_dma_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
-	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
-}
-
 static void dma_direct_sync_single_for_device(struct device *dev,
 		dma_addr_t addr, size_t size, enum dma_data_direction dir)
 {
@@ -293,7 +283,6 @@ int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)
 const struct dma_map_ops dma_direct_ops = {
 	.alloc			= dma_direct_alloc,
 	.free			= dma_direct_free,
-	.mmap			= dma_direct_mmap,
 	.map_page		= dma_direct_map_page,
 	.map_sg			= dma_direct_map_sg,
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE)
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 3540cb399bd2..42fd73aca305 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -7,7 +7,7 @@
  */
 
 #include <linux/acpi.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/export.h>
 #include <linux/gfp.h>
 #include <linux/of_device.h>
@@ -220,27 +220,37 @@ EXPORT_SYMBOL(dma_common_get_sgtable);
  * Create userspace mapping for the DMA-coherent memory.
  */
 int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
-		    void *cpu_addr, dma_addr_t dma_addr, size_t size)
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs)
 {
-	int ret = -ENXIO;
 #ifndef CONFIG_ARCH_NO_COHERENT_DMA_MMAP
 	unsigned long user_count = vma_pages(vma);
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned long off = vma->vm_pgoff;
+	unsigned long pfn;
+	int ret = -ENXIO;
 
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_page_prot = arch_dma_mmap_pgprot(dev, vma->vm_page_prot, attrs);
 
 	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
 		return ret;
 
-	if (off < count && user_count <= (count - off))
-		ret = remap_pfn_range(vma, vma->vm_start,
-				      page_to_pfn(virt_to_page(cpu_addr)) + off,
-				      user_count << PAGE_SHIFT,
-				      vma->vm_page_prot);
-#endif	/* !CONFIG_ARCH_NO_COHERENT_DMA_MMAP */
+	if (off >= count || user_count > count - off)
+		return -ENXIO;
+
+	if (!dev_is_dma_coherent(dev)) {
+		if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_COHERENT_TO_PFN))
+			return -ENXIO;
+		pfn = arch_dma_coherent_to_pfn(dev, cpu_addr, dma_addr);
+	} else {
+		pfn = page_to_pfn(virt_to_page(cpu_addr));
+	}
 
-	return ret;
+	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
+			user_count << PAGE_SHIFT, vma->vm_page_prot);
+#else
+	return -ENXIO;
+#endif /* !CONFIG_ARCH_NO_COHERENT_DMA_MMAP */
 }
 EXPORT_SYMBOL(dma_common_mmap);
 
-- 
2.18.0

