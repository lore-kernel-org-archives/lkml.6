Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C86C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D8C20854
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 06:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qaj5cXTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D8C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeIJK6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 06:58:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49732 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbeIJK6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 06:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7pc7ayPwPmDD4AwTWlyP+ascllwa0ZiTHBHiW2FU0eQ=; b=qaj5cXTVz4nzkV7u30Wm4Zqs3
        vMy4Bu4KsbtlZUTiiIn2NqdP3+fP3zqP3/foA3BBZ87aUxXCDD5jlVmABlxw+Asxsj4WbBFhhJmNH
        SL1YugfI4S/OyP64JJ1O1qzhPMXC17vSdO3g1vnwCcn5ueGjY0rd9vdGehxsDY1sbGMd1KX1Fb6EB
        kSu8wenDh/VJblHbp28KiYVdtGVcoryJ3rUBK2zqrj41K8oR8Eg2MkS8xUAKmh/zDxIzTI4PS7C7A
        XqZcJ75pp2JqLxK94nZ1TXb5yN9eaApgiNbL0x2n/szH2qKBl4z508oRg+FrHYUni4tQ3OqeLMGE/
        7GaCanN5w==;
Received: from 213-225-3-213.nat.highway.a1.net ([213.225.3.213] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzFKU-00082B-0k; Mon, 10 Sep 2018 06:05:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Burton <paul.burton@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] dma-mapping: merge direct and noncoherent ops
Date:   Mon, 10 Sep 2018 08:05:31 +0200
Message-Id: <20180910060533.27172-4-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180910060533.27172-1-hch@lst.de>
References: <20180910060533.27172-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the cache maintainance is already stubbed out when not enabled,
but merging the two allows us to nicely handle the case where
cache maintainance is required for some devices, but not others.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts
---
 arch/arc/Kconfig                     |   2 +-
 arch/arc/mm/dma.c                    |  16 ++--
 arch/arm/mm/dma-mapping-nommu.c      |   5 +-
 arch/c6x/Kconfig                     |   2 +-
 arch/hexagon/Kconfig                 |   2 +-
 arch/m68k/Kconfig                    |   2 +-
 arch/microblaze/Kconfig              |   2 +-
 arch/mips/Kconfig                    |   1 -
 arch/mips/include/asm/dma-mapping.h  |   2 -
 arch/mips/jazz/jazzdma.c             |   6 +-
 arch/mips/mm/dma-noncoherent.c       |  29 ++-----
 arch/nds32/Kconfig                   |   2 +-
 arch/nios2/Kconfig                   |   2 +-
 arch/openrisc/Kconfig                |   2 +-
 arch/parisc/Kconfig                  |   2 +-
 arch/parisc/kernel/setup.c           |   2 +-
 arch/sh/Kconfig                      |   3 +-
 arch/sparc/Kconfig                   |   2 +-
 arch/sparc/include/asm/dma-mapping.h |   4 +-
 arch/x86/kernel/amd_gart_64.c        |   6 +-
 arch/xtensa/Kconfig                  |   2 +-
 include/asm-generic/dma-mapping.h    |   9 --
 include/linux/dma-direct.h           |   4 +
 include/linux/dma-mapping.h          |   1 -
 include/linux/dma-noncoherent.h      |   5 --
 kernel/dma/Kconfig                   |   9 +-
 kernel/dma/Makefile                  |   1 -
 kernel/dma/direct.c                  | 121 +++++++++++++++++++++++++--
 kernel/dma/noncoherent.c             | 106 -----------------------
 29 files changed, 160 insertions(+), 192 deletions(-)
 delete mode 100644 kernel/dma/noncoherent.c

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index b4441b0764d7..ca03694d518a 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -17,7 +17,7 @@ config ARC
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
-	select DMA_NONCOHERENT_OPS
+	select DMA_DIRECT_OPS
 	select DMA_NONCOHERENT_MMAP
 	select GENERIC_ATOMIC64 if !ISA_ARCV2 || !(ARC_HAS_LL64 && ARC_HAS_LLSC)
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index c75d5c3470e3..535ed4a068ef 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -167,7 +167,7 @@ void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 }
 
 /*
- * Plug in coherent or noncoherent dma ops
+ * Plug in direct dma map ops.
  */
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
@@ -175,13 +175,11 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	/*
 	 * IOC hardware snoops all DMA traffic keeping the caches consistent
 	 * with memory - eliding need for any explicit cache maintenance of
-	 * DMA buffers - so we can use dma_direct cache ops.
+	 * DMA buffers.
 	 */
-	if (is_isa_arcv2() && ioc_enable && coherent) {
-		set_dma_ops(dev, &dma_direct_ops);
-		dev_info(dev, "use dma_direct_ops cache ops\n");
-	} else {
-		set_dma_ops(dev, &dma_noncoherent_ops);
-		dev_info(dev, "use dma_noncoherent_ops cache ops\n");
-	}
+	if (is_isa_arcv2() && ioc_enable && coherent)
+		dev->dma_coherent = true;
+
+	dev_info(dev, "use %sncoherent DMA ops\n",
+		 dev->dma_coherent ? "" : "non");
 }
diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index aa7aba302e76..0ad156f9985b 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -47,7 +47,8 @@ static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
 	 */
 
 	if (attrs & DMA_ATTR_NON_CONSISTENT)
-		return dma_direct_alloc(dev, size, dma_handle, gfp, attrs);
+		return dma_direct_alloc_pages(dev, size, dma_handle, gfp,
+				attrs);
 
 	ret = dma_alloc_from_global_coherent(size, dma_handle);
 
@@ -70,7 +71,7 @@ static void arm_nommu_dma_free(struct device *dev, size_t size,
 			       unsigned long attrs)
 {
 	if (attrs & DMA_ATTR_NON_CONSISTENT) {
-		dma_direct_free(dev, size, cpu_addr, dma_addr, attrs);
+		dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
 	} else {
 		int ret = dma_release_from_global_coherent(get_order(size),
 							   cpu_addr);
diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
index a641b0bf1611..f65a084607fd 100644
--- a/arch/c6x/Kconfig
+++ b/arch/c6x/Kconfig
@@ -9,7 +9,7 @@ config C6X
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select CLKDEV_LOOKUP
-	select DMA_NONCOHERENT_OPS
+	select DMA_DIRECT_OPS
 	select GENERIC_ATOMIC64
 	select GENERIC_IRQ_SHOW
 	select HAVE_ARCH_TRACEHOOK
diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 6cee842a9b44..3ef46522e89f 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -30,7 +30,7 @@ config HEXAGON
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
-	select DMA_NONCOHERENT_OPS
+	select DMA_DIRECT_OPS
 	---help---
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 070553791e97..c7b2a8d60a41 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -26,7 +26,7 @@ config M68K
 	select MODULES_USE_ELF_RELA
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
-	select DMA_NONCOHERENT_OPS if HAS_DMA
+	select DMA_DIRECT_OPS if HAS_DMA
 	select HAVE_MEMBLOCK
 	select ARCH_DISCARD_MEMBLOCK
 	select NO_BOOTMEM
diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index ace5c5bf1836..0f48ab6a8070 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -11,7 +11,7 @@ config MICROBLAZE
 	select TIMER_OF
 	select CLONE_BACKWARDS3
 	select COMMON_CLK
-	select DMA_NONCOHERENT_OPS
+	select DMA_DIRECT_OPS
 	select DMA_NONCOHERENT_MMAP
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 54c52bd0d9d3..96da6e3396e1 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1121,7 +1121,6 @@ config DMA_NONCOHERENT
 	select NEED_DMA_MAP_STATE
 	select DMA_NONCOHERENT_MMAP
 	select DMA_NONCOHERENT_CACHE_SYNC
-	select DMA_NONCOHERENT_OPS
 
 config SYS_HAS_EARLY_PRINTK
 	bool
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 40d825c779de..b4c477eb46ce 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -12,8 +12,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &jazz_dma_ops;
 #elif defined(CONFIG_SWIOTLB)
 	return &swiotlb_dma_ops;
-#elif defined(CONFIG_DMA_NONCOHERENT_OPS)
-	return &dma_noncoherent_ops;
 #else
 	return &dma_direct_ops;
 #endif
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index d31bc2f01208..bb49dfa1a9a3 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -564,13 +564,13 @@ static void *jazz_dma_alloc(struct device *dev, size_t size,
 {
 	void *ret;
 
-	ret = dma_direct_alloc(dev, size, dma_handle, gfp, attrs);
+	ret = dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
 	if (!ret)
 		return NULL;
 
 	*dma_handle = vdma_alloc(virt_to_phys(ret), size);
 	if (*dma_handle == VDMA_ERROR) {
-		dma_direct_free(dev, size, ret, *dma_handle, attrs);
+		dma_direct_free_pages(dev, size, ret, *dma_handle, attrs);
 		return NULL;
 	}
 
@@ -587,7 +587,7 @@ static void jazz_dma_free(struct device *dev, size_t size, void *vaddr,
 	vdma_free(dma_handle);
 	if (!(attrs & DMA_ATTR_NON_CONSISTENT))
 		vaddr = (void *)CAC_ADDR((unsigned long)vaddr);
-	return dma_direct_free(dev, size, vaddr, dma_handle, attrs);
+	dma_direct_free_pages(dev, size, vaddr, dma_handle, attrs);
 }
 
 static dma_addr_t jazz_dma_map_page(struct device *dev, struct page *page,
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index d408ac51f56c..b01b9a3e424f 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -29,9 +29,6 @@
  */
 static inline bool cpu_needs_post_dma_flush(struct device *dev)
 {
-	if (dev_is_dma_coherent(dev))
-		return false;
-
 	switch (boot_cpu_type()) {
 	case CPU_R10000:
 	case CPU_R12000:
@@ -52,11 +49,8 @@ void *arch_dma_alloc(struct device *dev, size_t size,
 {
 	void *ret;
 
-	ret = dma_direct_alloc(dev, size, dma_handle, gfp, attrs);
-	if (!ret)
-		return NULL;
-
-	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_NON_CONSISTENT)) {
+	ret = dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
+	if (!ret && !(attrs & DMA_ATTR_NON_CONSISTENT)) {
 		dma_cache_wback_inv((unsigned long) ret, size);
 		ret = (void *)UNCAC_ADDR(ret);
 	}
@@ -67,9 +61,9 @@ void *arch_dma_alloc(struct device *dev, size_t size,
 void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
-	if (!(attrs & DMA_ATTR_NON_CONSISTENT) && !dev_is_dma_coherent(dev))
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT))
 		cpu_addr = (void *)CAC_ADDR((unsigned long)cpu_addr);
-	dma_direct_free(dev, size, cpu_addr, dma_addr, attrs);
+	dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
 }
 
 int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
@@ -78,16 +72,11 @@ int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 {
 	unsigned long user_count = vma_pages(vma);
 	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	unsigned long addr = (unsigned long)cpu_addr;
+	unsigned long addr = CAC_ADDR((unsigned long)cpu_addr);
 	unsigned long off = vma->vm_pgoff;
-	unsigned long pfn;
+	unsigned long pfn = page_to_pfn(virt_to_page((void *)addr));
 	int ret = -ENXIO;
 
-	if (!dev_is_dma_coherent(dev))
-		addr = CAC_ADDR(addr);
-
-	pfn = page_to_pfn(virt_to_page((void *)addr));
-
 	if (attrs & DMA_ATTR_WRITE_COMBINE)
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 	else
@@ -167,8 +156,7 @@ static inline void dma_sync_phys(phys_addr_t paddr, size_t size,
 void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir)
 {
-	if (!dev_is_dma_coherent(dev))
-		dma_sync_phys(paddr, size, dir);
+	dma_sync_phys(paddr, size, dir);
 }
 
 void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
@@ -183,6 +171,5 @@ void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 {
 	BUG_ON(direction == DMA_NONE);
 
-	if (!dev_is_dma_coherent(dev))
-		dma_sync_virt(vaddr, size, direction);
+	dma_sync_virt(vaddr, size, direction);
 }
diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 7068f341133d..56992330026a 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -11,7 +11,7 @@ config NDS32
 	select CLKSRC_MMIO
 	select CLONE_BACKWARDS
 	select COMMON_CLK
-	select DMA_NONCOHERENT_OPS
+	select DMA_DIRECT_OPS
 	select GENERIC_ATOMIC64
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index f4ad1138e6b9..03965692fbfe 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -4,7 +4,7 @@ config NIOS2
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_SWAP
-	select DMA_NONCOHERENT_OPS
+	select DMA_DIRECT_OPS
 	select TIMER_OF
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index e0081e734827..a655ae280637 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -7,7 +7,7 @@
 config OPENRISC
 	def_bool y
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select DMA_NONCOHERENT_OPS
+	select DMA_DIRECT_OPS
 	select OF
 	select OF_EARLY_FLATTREE
 	select IRQ_DOMAIN
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 8e6d83f79e72..f1cd12afd943 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -186,7 +186,7 @@ config PA11
 	depends on PA7000 || PA7100LC || PA7200 || PA7300LC
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select DMA_NONCOHERENT_OPS
+	select DMA_DIRECT_OPS
 	select DMA_NONCOHERENT_CACHE_SYNC
 
 config PREFETCH
diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
index 4e87c35c22b7..755e89ec828a 100644
--- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -102,7 +102,7 @@ void __init dma_ops_init(void)
 	case pcxl: /* falls through */
 	case pcxs:
 	case pcxt:
-		hppa_dma_ops = &dma_noncoherent_ops;
+		hppa_dma_ops = &dma_direct_ops;
 		break;
 	default:
 		break;
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 1fb7b6d72baf..475d786a65b0 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -7,6 +7,7 @@ config SUPERH
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select HAVE_PATA_PLATFORM
 	select CLKDEV_LOOKUP
+	select DMA_DIRECT_OPS
 	select HAVE_IDE if HAS_IOPORT_MAP
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
@@ -158,13 +159,11 @@ config SWAP_IO_SPACE
 	bool
 
 config DMA_COHERENT
-	select DMA_DIRECT_OPS
 	bool
 
 config DMA_NONCOHERENT
 	def_bool !DMA_COHERENT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select DMA_NONCOHERENT_OPS
 
 config PGTABLE_LEVELS
 	default 3 if X2TLB
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index e6f2a38d2e61..7e2aa59fcc29 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -51,7 +51,7 @@ config SPARC
 config SPARC32
 	def_bool !64BIT
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
-	select DMA_NONCOHERENT_OPS
+	select DMA_DIRECT_OPS
 	select GENERIC_ATOMIC64
 	select CLZ_TAB
 	select HAVE_UID16
diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index e17566376934..b0bb2fcaf1c9 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -14,11 +14,11 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 #ifdef CONFIG_SPARC_LEON
 	if (sparc_cpu_model == sparc_leon)
-		return &dma_noncoherent_ops;
+		return &dma_direct_ops;
 #endif
 #if defined(CONFIG_SPARC32) && defined(CONFIG_PCI)
 	if (bus == &pci_bus_type)
-		return &dma_noncoherent_ops;
+		return &dma_direct_ops;
 #endif
 	return dma_ops;
 }
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index f299d8a479bb..3f9d1b4019bb 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -482,7 +482,7 @@ gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
 {
 	void *vaddr;
 
-	vaddr = dma_direct_alloc(dev, size, dma_addr, flag, attrs);
+	vaddr = dma_direct_alloc_pages(dev, size, dma_addr, flag, attrs);
 	if (!vaddr ||
 	    !force_iommu || dev->coherent_dma_mask <= DMA_BIT_MASK(24))
 		return vaddr;
@@ -494,7 +494,7 @@ gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
 		goto out_free;
 	return vaddr;
 out_free:
-	dma_direct_free(dev, size, vaddr, *dma_addr, attrs);
+	dma_direct_free_pages(dev, size, vaddr, *dma_addr, attrs);
 	return NULL;
 }
 
@@ -504,7 +504,7 @@ gart_free_coherent(struct device *dev, size_t size, void *vaddr,
 		   dma_addr_t dma_addr, unsigned long attrs)
 {
 	gart_unmap_page(dev, dma_addr, size, DMA_BIDIRECTIONAL, 0);
-	dma_direct_free(dev, size, vaddr, dma_addr, attrs);
+	dma_direct_free_pages(dev, size, vaddr, dma_addr, attrs);
 }
 
 static int gart_mapping_error(struct device *dev, dma_addr_t dma_addr)
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 04d038f3b6fa..516694937b7a 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -12,7 +12,7 @@ config XTENSA
 	select BUILDTIME_EXTABLE_SORT
 	select CLONE_BACKWARDS
 	select COMMON_CLK
-	select DMA_NONCOHERENT_OPS
+	select DMA_DIRECT_OPS
 	select GENERIC_ATOMIC64
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_SHOW
diff --git a/include/asm-generic/dma-mapping.h b/include/asm-generic/dma-mapping.h
index ad2868263867..880a292d792f 100644
--- a/include/asm-generic/dma-mapping.h
+++ b/include/asm-generic/dma-mapping.h
@@ -4,16 +4,7 @@
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	/*
-	 * Use the non-coherent ops if available.  If an architecture wants a
-	 * more fine-grained selection of operations it will have to implement
-	 * get_arch_dma_ops itself or use the per-device dma_ops.
-	 */
-#ifdef CONFIG_DMA_NONCOHERENT_OPS
-	return &dma_noncoherent_ops;
-#else
 	return &dma_direct_ops;
-#endif
 }
 
 #endif /* _ASM_GENERIC_DMA_MAPPING_H */
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 8d9f33febde5..86a59ba5a7f3 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -59,6 +59,10 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs);
+void *dma_direct_alloc_pages(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
+void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t dma_addr, unsigned long attrs);
 dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index eafd6f318e78..8f2001181cd1 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -136,7 +136,6 @@ struct dma_map_ops {
 };
 
 extern const struct dma_map_ops dma_direct_ops;
-extern const struct dma_map_ops dma_noncoherent_ops;
 extern const struct dma_map_ops dma_virt_ops;
 
 #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 69630ec320be..12c3e1a9b391 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -24,14 +24,9 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void arch_dma_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs);
-
-#ifdef CONFIG_DMA_NONCOHERENT_MMAP
 int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs);
-#else
-#define arch_dma_mmap NULL
-#endif /* CONFIG_DMA_NONCOHERENT_MMAP */
 
 #ifdef CONFIG_DMA_NONCOHERENT_CACHE_SYNC
 void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 040859ac2a56..0154412128be 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -30,18 +30,13 @@ config DMA_DIRECT_OPS
 	bool
 	depends on HAS_DMA
 
-config DMA_NONCOHERENT_OPS
-	bool
-	depends on HAS_DMA
-	select DMA_DIRECT_OPS
-
 config DMA_NONCOHERENT_MMAP
 	bool
-	depends on DMA_NONCOHERENT_OPS
+	depends on DMA_DIRECT_OPS
 
 config DMA_NONCOHERENT_CACHE_SYNC
 	bool
-	depends on DMA_NONCOHERENT_OPS
+	depends on DMA_DIRECT_OPS
 
 config DMA_VIRT_OPS
 	bool
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index 6de44e4eb454..7d581e4eea4a 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -4,7 +4,6 @@ obj-$(CONFIG_HAS_DMA)			+= mapping.o
 obj-$(CONFIG_DMA_CMA)			+= contiguous.o
 obj-$(CONFIG_HAVE_GENERIC_DMA_COHERENT) += coherent.o
 obj-$(CONFIG_DMA_DIRECT_OPS)		+= direct.o
-obj-$(CONFIG_DMA_NONCOHERENT_OPS)	+= noncoherent.o
 obj-$(CONFIG_DMA_VIRT_OPS)		+= virt.o
 obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
 obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index de87b0282e74..09e85f6aa4ba 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -1,13 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * DMA operations that map physical memory directly without using an IOMMU or
- * flushing caches.
+ * Copyright (C) 2018 Christoph Hellwig.
+ *
+ * DMA operations that map physical memory directly without using an IOMMU.
  */
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/dma-direct.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-contiguous.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/pfn.h>
 #include <linux/set_memory.h>
 
@@ -58,8 +60,8 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 	return addr + size - 1 <= dev->coherent_dma_mask;
 }
 
-void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, unsigned long attrs)
+void *dma_direct_alloc_pages(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	int page_order = get_order(size);
@@ -124,7 +126,7 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
  * NOTE: this function must never look at the dma_addr argument, because we want
  * to be able to use it as a helper for iommu implementations as well.
  */
-void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
+void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
@@ -136,14 +138,106 @@ void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
 		free_pages((unsigned long)cpu_addr, page_order);
 }
 
+void *dma_direct_alloc(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	if (!dev_is_dma_coherent(dev))
+		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
+	return dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
+}
+
+void dma_direct_free(struct device *dev, size_t size,
+		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
+{
+	if (!dev_is_dma_coherent(dev))
+		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
+	else
+		dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
+}
+
+static int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
+		void *cpu_addr, dma_addr_t dma_addr, size_t size,
+		unsigned long attrs)
+{
+	if (!dev_is_dma_coherent(dev) &&
+	    IS_ENABLED(CONFIG_DMA_NONCOHERENT_MMAP))
+		return arch_dma_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
+	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size);
+}
+
+static void dma_direct_sync_single_for_device(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+	if (dev_is_dma_coherent(dev))
+		return;
+	arch_sync_dma_for_device(dev, dma_to_phys(dev, addr), size, dir);
+}
+
+static void dma_direct_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	if (dev_is_dma_coherent(dev))
+		return;
+
+	for_each_sg(sgl, sg, nents, i)
+		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
+}
+
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+static void dma_direct_sync_single_for_cpu(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+	if (dev_is_dma_coherent(dev))
+		return;
+	arch_sync_dma_for_cpu(dev, dma_to_phys(dev, addr), size, dir);
+	arch_sync_dma_for_cpu_all(dev);
+}
+
+static void dma_direct_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
+
+	if (dev_is_dma_coherent(dev))
+		return;
+
+	for_each_sg(sgl, sg, nents, i)
+		arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
+	arch_sync_dma_for_cpu_all(dev);
+}
+
+static void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
+}
+
+static void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		dma_direct_sync_sg_for_cpu(dev, sgl, nents, dir);
+}
+#endif
+
 dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
 {
-	dma_addr_t dma_addr = phys_to_dma(dev, page_to_phys(page)) + offset;
+	phys_addr_t phys = page_to_phys(page) + offset;
+	dma_addr_t dma_addr = phys_to_dma(dev, phys);
 
 	if (!check_addr(dev, dma_addr, size, __func__))
 		return DIRECT_MAPPING_ERROR;
+
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		dma_direct_sync_single_for_device(dev, dma_addr, size, dir);
 	return dma_addr;
 }
 
@@ -162,6 +256,8 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		sg_dma_len(sg) = sg->length;
 	}
 
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		dma_direct_sync_sg_for_device(dev, sgl, nents, dir);
 	return nents;
 }
 
@@ -197,9 +293,22 @@ int dma_direct_mapping_error(struct device *dev, dma_addr_t dma_addr)
 const struct dma_map_ops dma_direct_ops = {
 	.alloc			= dma_direct_alloc,
 	.free			= dma_direct_free,
+	.mmap			= dma_direct_mmap,
 	.map_page		= dma_direct_map_page,
 	.map_sg			= dma_direct_map_sg,
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE)
+	.sync_single_for_device	= dma_direct_sync_single_for_device,
+	.sync_sg_for_device	= dma_direct_sync_sg_for_device,
+#endif
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+	.sync_single_for_cpu	= dma_direct_sync_single_for_cpu,
+	.sync_sg_for_cpu	= dma_direct_sync_sg_for_cpu,
+	.unmap_page		= dma_direct_unmap_page,
+	.unmap_sg		= dma_direct_unmap_sg,
+#endif
 	.dma_supported		= dma_direct_supported,
 	.mapping_error		= dma_direct_mapping_error,
+	.cache_sync		= arch_dma_cache_sync,
 };
 EXPORT_SYMBOL(dma_direct_ops);
diff --git a/kernel/dma/noncoherent.c b/kernel/dma/noncoherent.c
deleted file mode 100644
index 031fe235d958..000000000000
--- a/kernel/dma/noncoherent.c
+++ /dev/null
@@ -1,106 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2018 Christoph Hellwig.
- *
- * DMA operations that map physical memory directly without providing cache
- * coherence.
- */
-#include <linux/export.h>
-#include <linux/mm.h>
-#include <linux/dma-direct.h>
-#include <linux/dma-noncoherent.h>
-#include <linux/scatterlist.h>
-
-static void dma_noncoherent_sync_single_for_device(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir)
-{
-	arch_sync_dma_for_device(dev, dma_to_phys(dev, addr), size, dir);
-}
-
-static void dma_noncoherent_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sgl, sg, nents, i)
-		arch_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
-}
-
-static dma_addr_t dma_noncoherent_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	dma_addr_t addr;
-
-	addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
-	if (!dma_mapping_error(dev, addr) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		arch_sync_dma_for_device(dev, page_to_phys(page) + offset,
-				size, dir);
-	return addr;
-}
-
-static int dma_noncoherent_map_sg(struct device *dev, struct scatterlist *sgl,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	nents = dma_direct_map_sg(dev, sgl, nents, dir, attrs);
-	if (nents > 0 && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_noncoherent_sync_sg_for_device(dev, sgl, nents, dir);
-	return nents;
-}
-
-#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
-    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
-static void dma_noncoherent_sync_single_for_cpu(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir)
-{
-	arch_sync_dma_for_cpu(dev, dma_to_phys(dev, addr), size, dir);
-	arch_sync_dma_for_cpu_all(dev);
-}
-
-static void dma_noncoherent_sync_sg_for_cpu(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sgl, sg, nents, i)
-		arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
-	arch_sync_dma_for_cpu_all(dev);
-}
-
-static void dma_noncoherent_unmap_page(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_noncoherent_sync_single_for_cpu(dev, addr, size, dir);
-}
-
-static void dma_noncoherent_unmap_sg(struct device *dev, struct scatterlist *sgl,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_noncoherent_sync_sg_for_cpu(dev, sgl, nents, dir);
-}
-#endif
-
-const struct dma_map_ops dma_noncoherent_ops = {
-	.alloc			= arch_dma_alloc,
-	.free			= arch_dma_free,
-	.mmap			= arch_dma_mmap,
-	.sync_single_for_device	= dma_noncoherent_sync_single_for_device,
-	.sync_sg_for_device	= dma_noncoherent_sync_sg_for_device,
-	.map_page		= dma_noncoherent_map_page,
-	.map_sg			= dma_noncoherent_map_sg,
-#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
-    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
-	.sync_single_for_cpu	= dma_noncoherent_sync_single_for_cpu,
-	.sync_sg_for_cpu	= dma_noncoherent_sync_sg_for_cpu,
-	.unmap_page		= dma_noncoherent_unmap_page,
-	.unmap_sg		= dma_noncoherent_unmap_sg,
-#endif
-	.dma_supported		= dma_direct_supported,
-	.mapping_error		= dma_direct_mapping_error,
-	.cache_sync		= arch_dma_cache_sync,
-};
-EXPORT_SYMBOL(dma_noncoherent_ops);
-- 
2.18.0

