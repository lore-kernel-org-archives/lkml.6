Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935493AbeEYFAr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 01:00:47 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25429 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935256AbeEYFAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 01:00:45 -0400
From: Huaisheng Ye <yehs2007@zoho.com>
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, chengnt@lenovo.com,
        Huaisheng Ye <yehs1@lenovo.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, Michal Hocko <mhocko@suse.com>
Subject: [PATCH v1] arch/x86/kernel/pci-dma: Remove useless parameter of arch_dma_alloc_attrs
Date: Fri, 25 May 2018 13:00:00 +0800
Message-Id: <20180525050000.6076-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

arch_dma_alloc_attrs has parameter gfp which is not used at all.
Remove it.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
---
 arch/x86/include/asm/dma-mapping.h | 2 +-
 arch/x86/kernel/pci-dma.c          | 2 +-
 include/linux/dma-mapping.h        | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index 89ce4bf..ef59747 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -33,7 +33,7 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 int arch_dma_supported(struct device *dev, u64 mask);
 #define arch_dma_supported arch_dma_supported
 
-bool arch_dma_alloc_attrs(struct device **dev, gfp_t *gfp);
+bool arch_dma_alloc_attrs(struct device **dev);
 #define arch_dma_alloc_attrs arch_dma_alloc_attrs
 
 #endif
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 77625b6..94d1a49 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -76,7 +76,7 @@ void __init pci_iommu_alloc(void)
 	}
 }
 
-bool arch_dma_alloc_attrs(struct device **dev, gfp_t *gfp)
+bool arch_dma_alloc_attrs(struct device **dev)
 {
 	if (!*dev)
 		*dev = &x86_dma_fallback_dev;
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f8ab1c0..c80bb09 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -502,7 +502,7 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 #define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
 
 #ifndef arch_dma_alloc_attrs
-#define arch_dma_alloc_attrs(dev, flag)	(true)
+#define arch_dma_alloc_attrs(dev)	(true)
 #endif
 
 static inline void *dma_alloc_attrs(struct device *dev, size_t size,
@@ -521,7 +521,7 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 	/* let the implementation decide on the zone to allocate from: */
 	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
-	if (!arch_dma_alloc_attrs(&dev, &flag))
+	if (!arch_dma_alloc_attrs(&dev))
 		return NULL;
 	if (!ops->alloc)
 		return NULL;
-- 
1.8.3.1
