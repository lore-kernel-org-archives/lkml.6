Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936260AbeEYOfg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 10:35:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56612 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935826AbeEYOfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 10:35:33 -0400
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 3/7] ia64: remove iommu_dma_supported
Date: Fri, 25 May 2018 16:35:08 +0200
Message-Id: <20180525143512.1466-4-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525143512.1466-1-hch@lst.de>
References: <20180525143512.1466-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic dma_direct_supported helper already used by intel-iommu on
x86 does a better job than the ia64 reimplementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/kernel/pci-dma.c  | 13 -------------
 drivers/iommu/intel-iommu.c |  2 --
 2 files changed, 15 deletions(-)

diff --git a/arch/ia64/kernel/pci-dma.c b/arch/ia64/kernel/pci-dma.c
index 50b6ad282a90..3c2884bef3d4 100644
--- a/arch/ia64/kernel/pci-dma.c
+++ b/arch/ia64/kernel/pci-dma.c
@@ -51,18 +51,6 @@ iommu_dma_init(void)
 	return;
 }
 
-int iommu_dma_supported(struct device *dev, u64 mask)
-{
-	/* Copied from i386. Doesn't make much sense, because it will
-	   only work for pci_alloc_coherent.
-	   The caller just has to use GFP_DMA in this case. */
-	if (mask < DMA_BIT_MASK(24))
-		return 0;
-
-	return 1;
-}
-EXPORT_SYMBOL(iommu_dma_supported);
-
 void __init pci_iommu_alloc(void)
 {
 	dma_ops = &intel_dma_ops;
@@ -71,7 +59,6 @@ void __init pci_iommu_alloc(void)
 	intel_dma_ops.sync_sg_for_cpu = machvec_dma_sync_sg;
 	intel_dma_ops.sync_single_for_device = machvec_dma_sync_single;
 	intel_dma_ops.sync_sg_for_device = machvec_dma_sync_sg;
-	intel_dma_ops.dma_supported = iommu_dma_supported;
 
 	/*
 	 * The order of these functions is important for
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 749d8f235346..5e0bef3754d1 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3841,9 +3841,7 @@ const struct dma_map_ops intel_dma_ops = {
 	.map_page = intel_map_page,
 	.unmap_page = intel_unmap_page,
 	.mapping_error = intel_mapping_error,
-#ifdef CONFIG_X86
 	.dma_supported = dma_direct_supported,
-#endif
 };
 
 static inline int iommu_domain_cache_init(void)
-- 
2.17.0
