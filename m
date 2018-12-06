Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94929C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377EB20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:00:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377EB20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbeLFUAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:00:09 -0500
Received: from verein.lst.de ([213.95.11.211]:59245 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbeLFUAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:00:09 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id BB63368AA6; Thu,  6 Dec 2018 21:00:06 +0100 (CET)
Date:   Thu, 6 Dec 2018 21:00:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        iommu@lists.linux-foundation.org, brouer@redhat.com,
        tariqt@mellanox.com, ilias.apalodimas@linaro.org, toke@toke.dk,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] avoid indirect calls for DMA direct mappings
Message-ID: <20181206200006.GA31548@lst.de>
References: <20181206153720.10702-1-hch@lst.de> <CAHk-=wgz6PFCm+XMWN31dRHzA3JcNP0x0Y-z5NMMw3dHhrDXAw@mail.gmail.com> <20181206184330.GB30039@lst.de> <173bfba7-033d-93c4-6ef1-48c9e39c9efc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173bfba7-033d-93c4-6ef1-48c9e39c9efc@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 06:54:17PM +0000, Robin Murphy wrote:
> I'm pretty sure we used to assign dummy_dma_ops explicitly to devices at 
> the point we detected the ACPI properties are wrong - that shouldn't be too 
> much of a headache to go back to.

Ok.  I've cooked up a patch to use NULL as the go direct marker.
This cleans up a few things nicely, but also means we now need to
do the bypass scheme for all ops, not just the fast path.  But we
probably should just move the slow path ops out of line anyway,
so I'm not worried about it.  This has survived some very basic
testing on x86, and really needs to be cleaned up and split into
multiple patches..

The other nice thing this would allow is removing dma_direct_ops
entirely, which means we can simplify a few things even further.

This patch is relative to what I sent out before and the git tree,
and survives some very basic x86 testing.

---
From 9318145675791833f752cba22484a0b4b4387f1b Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 6 Dec 2018 10:52:35 -0800
Subject: dma-direct: use NULL as the bypass indicator

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/include/asm/dma-mapping.h |   2 +-
 arch/arm/include/asm/dma-mapping.h   |   2 +-
 arch/arm/mm/dma-mapping-nommu.c      |  12 +--
 arch/arm64/include/asm/dma-mapping.h |   8 +-
 arch/arm64/mm/dma-mapping.c          |  89 -------------------
 arch/ia64/hp/common/hwsw_iommu.c     |   2 +-
 arch/ia64/hp/common/sba_iommu.c      |   4 +-
 arch/ia64/kernel/dma-mapping.c       |   1 -
 arch/ia64/kernel/pci-dma.c           |   2 +-
 arch/mips/include/asm/dma-mapping.h  |   2 +-
 arch/parisc/kernel/setup.c           |   4 -
 arch/sparc/include/asm/dma-mapping.h |   4 +-
 arch/x86/kernel/pci-dma.c            |   2 +-
 drivers/base/platform.c              |   2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c  |   2 +-
 drivers/iommu/amd_iommu.c            |  13 +--
 drivers/pci/controller/vmd.c         |   4 +-
 include/asm-generic/dma-mapping.h    |   2 +-
 include/linux/dma-direct.h           |   6 --
 include/linux/dma-mapping.h          | 125 ++++++++++++++-------------
 include/linux/dma-noncoherent.h      |   7 --
 kernel/dma/Kconfig                   |   2 +-
 kernel/dma/direct.c                  |   3 +
 23 files changed, 92 insertions(+), 208 deletions(-)

diff --git a/arch/alpha/include/asm/dma-mapping.h b/arch/alpha/include/asm/dma-mapping.h
index 8beeafd4f68e..c9203468d4fe 100644
--- a/arch/alpha/include/asm/dma-mapping.h
+++ b/arch/alpha/include/asm/dma-mapping.h
@@ -7,7 +7,7 @@ extern const struct dma_map_ops alpha_pci_ops;
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 #ifdef CONFIG_ALPHA_JENSEN
-	return &dma_direct_ops;
+	return NULL; /* use direct mapping */
 #else
 	return &alpha_pci_ops;
 #endif
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 965b7c846ecb..31d3b96f0f4b 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -18,7 +18,7 @@ extern const struct dma_map_ops arm_coherent_dma_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	return IS_ENABLED(CONFIG_MMU) ? &arm_dma_ops : &dma_direct_ops;
+	return IS_ENABLED(CONFIG_MMU) ? &arm_dma_ops : NULL;
 }
 
 #ifdef __arch_page_to_dma
diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index 712416ecd8e6..378763003079 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -209,16 +209,9 @@ const struct dma_map_ops arm_nommu_dma_ops = {
 };
 EXPORT_SYMBOL(arm_nommu_dma_ops);
 
-static const struct dma_map_ops *arm_nommu_get_dma_map_ops(bool coherent)
-{
-	return coherent ? &dma_direct_ops : &arm_nommu_dma_ops;
-}
-
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
-	const struct dma_map_ops *dma_ops;
-
 	if (IS_ENABLED(CONFIG_CPU_V7M)) {
 		/*
 		 * Cache support for v7m is optional, so can be treated as
@@ -234,7 +227,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		dev->archdata.dma_coherent = (get_cr() & CR_M) ? coherent : true;
 	}
 
-	dma_ops = arm_nommu_get_dma_map_ops(dev->archdata.dma_coherent);
-
-	set_dma_ops(dev, dma_ops);
+	if (!dev->archdata.dma_coherent)
+		set_dma_ops(dev, &arm_nommu_dma_ops);
 }
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index c41f3fb1446c..95dbf3ef735a 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -24,15 +24,9 @@
 #include <xen/xen.h>
 #include <asm/xen/hypervisor.h>
 
-extern const struct dma_map_ops dummy_dma_ops;
-
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	/*
-	 * We expect no ISA devices, and all other DMA masters are expected to
-	 * have someone call arch_setup_dma_ops at device creation time.
-	 */
-	return &dummy_dma_ops;
+	return NULL;
 }
 
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index e4effbb243b1..95eda81e3f2d 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -89,92 +89,6 @@ static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
 }
 #endif /* CONFIG_IOMMU_DMA */
 
-/********************************************
- * The following APIs are for dummy DMA ops *
- ********************************************/
-
-static void *__dummy_alloc(struct device *dev, size_t size,
-			   dma_addr_t *dma_handle, gfp_t flags,
-			   unsigned long attrs)
-{
-	return NULL;
-}
-
-static void __dummy_free(struct device *dev, size_t size,
-			 void *vaddr, dma_addr_t dma_handle,
-			 unsigned long attrs)
-{
-}
-
-static int __dummy_mmap(struct device *dev,
-			struct vm_area_struct *vma,
-			void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			unsigned long attrs)
-{
-	return -ENXIO;
-}
-
-static dma_addr_t __dummy_map_page(struct device *dev, struct page *page,
-				   unsigned long offset, size_t size,
-				   enum dma_data_direction dir,
-				   unsigned long attrs)
-{
-	return DMA_MAPPING_ERROR;
-}
-
-static void __dummy_unmap_page(struct device *dev, dma_addr_t dev_addr,
-			       size_t size, enum dma_data_direction dir,
-			       unsigned long attrs)
-{
-}
-
-static int __dummy_map_sg(struct device *dev, struct scatterlist *sgl,
-			  int nelems, enum dma_data_direction dir,
-			  unsigned long attrs)
-{
-	return 0;
-}
-
-static void __dummy_unmap_sg(struct device *dev,
-			     struct scatterlist *sgl, int nelems,
-			     enum dma_data_direction dir,
-			     unsigned long attrs)
-{
-}
-
-static void __dummy_sync_single(struct device *dev,
-				dma_addr_t dev_addr, size_t size,
-				enum dma_data_direction dir)
-{
-}
-
-static void __dummy_sync_sg(struct device *dev,
-			    struct scatterlist *sgl, int nelems,
-			    enum dma_data_direction dir)
-{
-}
-
-static int __dummy_dma_supported(struct device *hwdev, u64 mask)
-{
-	return 0;
-}
-
-const struct dma_map_ops dummy_dma_ops = {
-	.alloc                  = __dummy_alloc,
-	.free                   = __dummy_free,
-	.mmap                   = __dummy_mmap,
-	.map_page               = __dummy_map_page,
-	.unmap_page             = __dummy_unmap_page,
-	.map_sg                 = __dummy_map_sg,
-	.unmap_sg               = __dummy_unmap_sg,
-	.sync_single_for_cpu    = __dummy_sync_single,
-	.sync_single_for_device = __dummy_sync_single,
-	.sync_sg_for_cpu        = __dummy_sync_sg,
-	.sync_sg_for_device     = __dummy_sync_sg,
-	.dma_supported          = __dummy_dma_supported,
-};
-EXPORT_SYMBOL(dummy_dma_ops);
-
 static int __init arm64_dma_init(void)
 {
 	WARN_TAINT(ARCH_DMA_MINALIGN < cache_line_size(),
@@ -548,9 +462,6 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
-	if (!dev->dma_ops)
-		dev->dma_ops = &dma_direct_ops;
-
 	dev->dma_coherent = coherent;
 	__iommu_setup_dma_ops(dev, dma_base, size, iommu);
 
diff --git a/arch/ia64/hp/common/hwsw_iommu.c b/arch/ia64/hp/common/hwsw_iommu.c
index f40ca499b246..8840ed97712f 100644
--- a/arch/ia64/hp/common/hwsw_iommu.c
+++ b/arch/ia64/hp/common/hwsw_iommu.c
@@ -38,7 +38,7 @@ static inline int use_swiotlb(struct device *dev)
 const struct dma_map_ops *hwsw_dma_get_ops(struct device *dev)
 {
 	if (use_swiotlb(dev))
-		return &dma_direct_ops;
+		return NULL;
 	return &sba_dma_ops;
 }
 EXPORT_SYMBOL(hwsw_dma_get_ops);
diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index 5ee74820a0f6..5a361e51cb1e 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -2078,7 +2078,7 @@ sba_init(void)
 	 * a successful kdump kernel boot is to use the swiotlb.
 	 */
 	if (is_kdump_kernel()) {
-		dma_ops = &dma_direct_ops;
+		dma_ops = NULL;
 		if (swiotlb_late_init_with_default_size(64 * (1<<20)) != 0)
 			panic("Unable to initialize software I/O TLB:"
 				  " Try machvec=dig boot option");
@@ -2100,7 +2100,7 @@ sba_init(void)
 		 * If we didn't find something sba_iommu can claim, we
 		 * need to setup the swiotlb and switch to the dig machvec.
 		 */
-		dma_ops = &dma_direct_ops;
+		dma_ops = NULL;
 		if (swiotlb_late_init_with_default_size(64 * (1<<20)) != 0)
 			panic("Unable to find SBA IOMMU or initialize "
 			      "software I/O TLB: Try machvec=dig boot option");
diff --git a/arch/ia64/kernel/dma-mapping.c b/arch/ia64/kernel/dma-mapping.c
index 80cd3e1ea95a..ad7d9963de34 100644
--- a/arch/ia64/kernel/dma-mapping.c
+++ b/arch/ia64/kernel/dma-mapping.c
@@ -36,7 +36,6 @@ long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
 
 void __init swiotlb_dma_init(void)
 {
-	dma_ops = &dma_direct_ops;
 	swiotlb_init(1);
 }
 #endif
diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index fe988c49f01c..a4d61278417a 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -48,7 +48,7 @@ void __init pci_iommu_alloc(void)
 #ifdef CONFIG_IA64_GENERIC
 		printk(KERN_INFO "PCI-DMA: Re-initialize machine vector.\n");
 		machvec_init("dig");
-		swiotlb_dma_init();
+		swiotlb_init(1);
 #else
 		panic("Unable to find Intel IOMMU");
 #endif /* CONFIG_IA64_GENERIC */
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 69f914667f3e..20dfaad3a55d 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -11,7 +11,7 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 #if defined(CONFIG_MACH_JAZZ)
 	return &jazz_dma_ops;
 #else
-	return &dma_direct_ops;
+	return NULL;
 #endif
 }
 
diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
index cd227f1cf629..54818cd78bd0 100644
--- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -99,10 +99,6 @@ void __init dma_ops_init(void)
 
 	case pcxl2:
 		pa7300lc_init();
-	case pcxl: /* falls through */
-	case pcxs:
-	case pcxt:
-		hppa_dma_ops = &dma_direct_ops;
 		break;
 	default:
 		break;
diff --git a/arch/sparc/include/asm/dma-mapping.h b/arch/sparc/include/asm/dma-mapping.h
index b0bb2fcaf1c9..59f5a0f17316 100644
--- a/arch/sparc/include/asm/dma-mapping.h
+++ b/arch/sparc/include/asm/dma-mapping.h
@@ -14,11 +14,11 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 #ifdef CONFIG_SPARC_LEON
 	if (sparc_cpu_model == sparc_leon)
-		return &dma_direct_ops;
+		return NULL;
 #endif
 #if defined(CONFIG_SPARC32) && defined(CONFIG_PCI)
 	if (bus == &pci_bus_type)
-		return &dma_direct_ops;
+		return NULL;
 #endif
 	return dma_ops;
 }
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index f4562fcec681..d460998ae828 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -17,7 +17,7 @@
 
 static bool disable_dac_quirk __read_mostly;
 
-const struct dma_map_ops *dma_ops = &dma_direct_ops;
+const struct dma_map_ops *dma_ops;
 EXPORT_SYMBOL(dma_ops);
 
 #ifdef CONFIG_IOMMU_DEBUG
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 41b91af95afb..1a659225d01a 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1203,6 +1203,8 @@ u64 dma_get_required_mask(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
+	if (dma_is_direct(ops))
+		return dma_direct_get_required_mask(dev);
 	if (ops->get_required_mask)
 		return ops->get_required_mask(dev);
 	return dma_default_get_required_mask(dev);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 61a84b958d67..50637f372e9f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -581,7 +581,7 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 
 	dev_priv->map_mode = vmw_dma_map_populate;
 
-	if (dma_ops->sync_single_for_cpu)
+	if (dma_ops && dma_ops->sync_single_for_cpu)
 		dev_priv->map_mode = vmw_dma_alloc_coherent;
 #ifdef CONFIG_SWIOTLB
 	if (swiotlb_nr_tbl() == 0)
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index c5d6c7c42b0a..567221cca13c 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2184,7 +2184,7 @@ static int amd_iommu_add_device(struct device *dev)
 				dev_name(dev));
 
 		iommu_ignore_device(dev);
-		dev->dma_ops = &dma_direct_ops;
+		dev->dma_ops = NULL;
 		goto out;
 	}
 	init_iommu_group(dev);
@@ -2770,17 +2770,6 @@ int __init amd_iommu_init_dma_ops(void)
 	swiotlb        = (iommu_pass_through || sme_me_mask) ? 1 : 0;
 	iommu_detected = 1;
 
-	/*
-	 * In case we don't initialize SWIOTLB (actually the common case
-	 * when AMD IOMMU is enabled and SME is not active), make sure there
-	 * are global dma_ops set as a fall-back for devices not handled by
-	 * this driver (for example non-PCI devices). When SME is active,
-	 * make sure that swiotlb variable remains set so the global dma_ops
-	 * continue to be SWIOTLB.
-	 */
-	if (!swiotlb)
-		dma_ops = &dma_direct_ops;
-
 	if (amd_iommu_unmap_flush)
 		pr_info("AMD-Vi: IO/TLB flush on unmap enabled\n");
 	else
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 98ce79eac128..a63568c7172d 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -309,7 +309,9 @@ static struct device *to_vmd_dev(struct device *dev)
 
 static const struct dma_map_ops *vmd_dma_ops(struct device *dev)
 {
-	return get_dma_ops(to_vmd_dev(dev));
+	const struct dma_map_ops *ops = get_dma_ops(to_vmd_dev(dev));
+
+	return ops ? ops : &dma_direct_ops;
 }
 
 static void *vmd_alloc(struct device *dev, size_t size, dma_addr_t *addr,
diff --git a/include/asm-generic/dma-mapping.h b/include/asm-generic/dma-mapping.h
index 880a292d792f..c13f46109e88 100644
--- a/include/asm-generic/dma-mapping.h
+++ b/include/asm-generic/dma-mapping.h
@@ -4,7 +4,7 @@
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
-	return &dma_direct_ops;
+	return NULL;
 }
 
 #endif /* _ASM_GENERIC_DMA_MAPPING_H */
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index b7338702592a..b2012ba1c436 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -48,11 +48,6 @@ static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 	return __sme_clr(__dma_to_phys(dev, daddr));
 }
 
-u64 dma_direct_get_required_mask(struct device *dev);
-void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, unsigned long attrs);
-void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t dma_addr, unsigned long attrs);
 void *dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
 void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
@@ -60,5 +55,4 @@ void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
 void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page);
-int dma_direct_supported(struct device *dev, u64 mask);
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 648ca7da3bb3..c45b649330a8 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -223,7 +223,7 @@ static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
 
 static inline bool dma_is_direct(const struct dma_map_ops *ops)
 {
-	return IS_ENABLED(CONFIG_DMA_DIRECT_OPS) && ops == &dma_direct_ops;
+	return likely(IS_ENABLED(CONFIG_DMA_DIRECT_OPS) && ops == NULL);
 }
 
 /*
@@ -235,6 +235,12 @@ dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 		unsigned long attrs);
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs);
+u64 dma_direct_get_required_mask(struct device *dev);
+void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		gfp_t gfp, unsigned long attrs);
+void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t dma_addr, unsigned long attrs);
+int dma_direct_supported(struct device *dev, u64 mask);
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_SWIOTLB)
@@ -284,6 +290,14 @@ static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
 }
 #endif
 
+#ifdef CONFIG_DMA_NONCOHERENT_CACHE_SYNC
+void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+		enum dma_data_direction direction);
+#else
+#define arch_dma_cache_sync NULL
+#endif /* CONFIG_DMA_NONCOHERENT_CACHE_SYNC */
+
+
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 					      size_t size,
 					      enum dma_data_direction dir,
@@ -314,12 +328,10 @@ static inline void dma_unmap_single_attrs(struct device *dev, dma_addr_t addr,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->unmap_page) {
-		if (dma_is_direct(ops))
-			dma_direct_unmap_page(dev, addr, size, dir, attrs);
-		else
-			ops->unmap_page(dev, addr, size, dir, attrs);
-	}
+	if (dma_is_direct(ops))
+		dma_direct_unmap_page(dev, addr, size, dir, attrs);
+	else if (ops->unmap_page)
+		ops->unmap_page(dev, addr, size, dir, attrs);
 	debug_dma_unmap_page(dev, addr, size, dir, true);
 }
 
@@ -353,12 +365,10 @@ static inline void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg
 
 	BUG_ON(!valid_dma_direction(dir));
 	debug_dma_unmap_sg(dev, sg, nents, dir);
-	if (ops->unmap_sg) {
-		if (dma_is_direct(ops))
-			dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
-		else
-			ops->unmap_sg(dev, sg, nents, dir, attrs);
-	}
+	if (dma_is_direct(ops))
+		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
+	else if (ops->unmap_sg)
+		ops->unmap_sg(dev, sg, nents, dir, attrs);
 }
 
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
@@ -388,12 +398,10 @@ static inline void dma_unmap_page_attrs(struct device *dev,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->unmap_page) {
-		if (dma_is_direct(ops))
-			dma_direct_unmap_page(dev, addr, size, dir, attrs);
-		else
-			ops->unmap_page(dev, addr, size, dir, attrs);
-	}
+	if (dma_is_direct(ops))
+		dma_direct_unmap_page(dev, addr, size, dir, attrs);
+	else if (ops->unmap_page)
+		ops->unmap_page(dev, addr, size, dir, attrs);
 	debug_dma_unmap_page(dev, addr, size, dir, false);
 }
 
@@ -412,7 +420,7 @@ static inline dma_addr_t dma_map_resource(struct device *dev,
 	BUG_ON(pfn_valid(PHYS_PFN(phys_addr)));
 
 	addr = phys_addr;
-	if (ops->map_resource)
+	if (ops && ops->map_resource)
 		addr = ops->map_resource(dev, phys_addr, size, dir, attrs);
 
 	debug_dma_map_resource(dev, phys_addr, size, dir, addr);
@@ -427,7 +435,7 @@ static inline void dma_unmap_resource(struct device *dev, dma_addr_t addr,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->unmap_resource)
+	if (ops && ops->unmap_resource)
 		ops->unmap_resource(dev, addr, size, dir, attrs);
 	debug_dma_unmap_resource(dev, addr, size, dir);
 }
@@ -439,12 +447,10 @@ static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->sync_single_for_cpu) {
-		if (dma_is_direct(ops))
-			dma_direct_sync_single_for_cpu(dev, addr, size, dir);
-		else
-			ops->sync_single_for_cpu(dev, addr, size, dir);
-	}
+	if (dma_is_direct(ops))
+		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
+	else if (ops->sync_single_for_cpu)
+		ops->sync_single_for_cpu(dev, addr, size, dir);
 	debug_dma_sync_single_for_cpu(dev, addr, size, dir);
 }
 
@@ -462,12 +468,10 @@ static inline void dma_sync_single_for_device(struct device *dev,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->sync_single_for_device) {
-		if (dma_is_direct(ops))
-			dma_direct_sync_single_for_device(dev, addr, size, dir);
-		else
-			ops->sync_single_for_device(dev, addr, size, dir);
-	}
+	if (dma_is_direct(ops))
+		dma_direct_sync_single_for_device(dev, addr, size, dir);
+	else if (ops->sync_single_for_device)
+		ops->sync_single_for_device(dev, addr, size, dir);
 	debug_dma_sync_single_for_device(dev, addr, size, dir);
 }
 
@@ -485,12 +489,10 @@ dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->sync_sg_for_cpu) {
-		if (dma_is_direct(ops))
-			dma_direct_sync_sg_for_cpu(dev, sg, nelems, dir);
-		else
-			ops->sync_sg_for_cpu(dev, sg, nelems, dir);
-	}
+	if (dma_is_direct(ops))
+		dma_direct_sync_sg_for_cpu(dev, sg, nelems, dir);
+	else if (ops->sync_sg_for_cpu)
+		ops->sync_sg_for_cpu(dev, sg, nelems, dir);
 	debug_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
 }
 
@@ -501,12 +503,10 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->sync_sg_for_device) {
-		if (dma_is_direct(ops))
-			dma_direct_sync_sg_for_device(dev, sg, nelems, dir);
-		else
-			ops->sync_sg_for_device(dev, sg, nelems, dir);
-	}
+	if (dma_is_direct(ops))
+		dma_direct_sync_sg_for_device(dev, sg, nelems, dir);
+	else if (ops->sync_sg_for_device)
+		ops->sync_sg_for_device(dev, sg, nelems, dir);
 	debug_dma_sync_sg_for_device(dev, sg, nelems, dir);
 
 }
@@ -522,11 +522,15 @@ static inline void
 dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		enum dma_data_direction dir)
 {
+#ifdef CONFIG_DMA_NONCOHERENT_CACHE_SYNC
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (ops->cache_sync)
+	if (dma_is_direct(ops))
+		arch_dma_cache_sync(dev, vaddr, size, dir);
+	else if (ops->cache_sync)
 		ops->cache_sync(dev, vaddr, size, dir);
+#endif
 }
 
 extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
@@ -565,8 +569,8 @@ dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma, void *cpu_addr,
 	       dma_addr_t dma_addr, size_t size, unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-	BUG_ON(!ops);
-	if (ops->mmap)
+
+	if (!dma_is_direct(ops) && ops->mmap)
 		return ops->mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
 	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
 }
@@ -583,8 +587,8 @@ dma_get_sgtable_attrs(struct device *dev, struct sg_table *sgt, void *cpu_addr,
 		      unsigned long attrs)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
-	BUG_ON(!ops);
-	if (ops->get_sgtable)
+
+	if (!dma_is_direct(ops) && ops->get_sgtable)
 		return ops->get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
 					attrs);
 	return dma_common_get_sgtable(dev, sgt, cpu_addr, dma_addr, size,
@@ -604,7 +608,6 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 	void *cpu_addr;
 
-	BUG_ON(!ops);
 	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
 
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
@@ -615,10 +618,13 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 
 	if (!arch_dma_alloc_attrs(&dev))
 		return NULL;
-	if (!ops->alloc)
-		return NULL;
 
-	cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
+	if (dma_is_direct(ops))
+		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
+	else if (ops->alloc)
+		cpu_addr = ops->alloc(dev, size, dma_handle, flag, attrs);
+	else
+		return NULL;
 	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr);
 	return cpu_addr;
 }
@@ -629,8 +635,6 @@ static inline void dma_free_attrs(struct device *dev, size_t size,
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
-	BUG_ON(!ops);
-
 	if (dma_release_from_dev_coherent(dev, get_order(size), cpu_addr))
 		return;
 	/*
@@ -642,11 +646,14 @@ static inline void dma_free_attrs(struct device *dev, size_t size,
 	 */
 	WARN_ON(irqs_disabled());
 
-	if (!ops->free || !cpu_addr)
+	if (!cpu_addr)
 		return;
 
 	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
-	ops->free(dev, size, cpu_addr, dma_handle, attrs);
+	if (dma_is_direct(ops))
+		dma_direct_free(dev, size, cpu_addr, dma_handle, attrs);
+	else if (ops->free)
+		ops->free(dev, size, cpu_addr, dma_handle, attrs);
 }
 
 static inline void *dma_alloc_coherent(struct device *dev, size_t size,
@@ -682,6 +689,8 @@ static inline int dma_supported(struct device *dev, u64 mask)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
+	if (dma_is_direct(ops))
+		return dma_direct_supported(dev, mask);
 	if (!ops)
 		return 0;
 	if (!ops->dma_supported)
diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 306557331d7d..51c8db377c17 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -34,13 +34,6 @@ pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
 # define arch_dma_mmap_pgprot(dev, prot, attrs)	pgprot_noncached(prot)
 #endif
 
-#ifdef CONFIG_DMA_NONCOHERENT_CACHE_SYNC
-void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-		enum dma_data_direction direction);
-#else
-#define arch_dma_cache_sync NULL
-#endif /* CONFIG_DMA_NONCOHERENT_CACHE_SYNC */
-
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE
 void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir);
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 41c3b1df70eb..a73ef291499a 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -36,7 +36,7 @@ config ARCH_HAS_DMA_MMAP_PGPROT
 	bool
 
 config DMA_DIRECT_OPS
-	bool
+	def_bool y
 	depends on HAS_DMA
 
 config DMA_NONCOHERENT_CACHE_SYNC
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index cd535e7c67d7..119a981a3899 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -200,6 +200,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
 	return dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
 }
+EXPORT_SYMBOL(dma_direct_alloc);
 
 void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
@@ -209,6 +210,7 @@ void dma_direct_free(struct device *dev, size_t size,
 	else
 		dma_direct_free_pages(dev, size, cpu_addr, dma_addr, attrs);
 }
+EXPORT_SYMBOL(dma_direct_free);
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
     defined(CONFIG_SWIOTLB)
@@ -375,6 +377,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
 
 	return mask >= phys_to_dma(dev, min_mask);
 }
+EXPORT_SYMBOL(dma_direct_supported);
 
 const struct dma_map_ops dma_direct_ops = {
 	.alloc			= dma_direct_alloc,
-- 
2.19.1

