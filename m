Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbeDRIkO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:40:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752762AbeDRIkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:40:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Linux IOMMU Mailing List <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jintack Lim <jintack@cs.columbia.edu>,
        Alexander Witte <alexander.witte@baicanada.com>, peterx@redhat.com
Subject: [PATCH v2 3/3] intel-iommu: fix iotlb psi missing for mappings
Date: Wed, 18 Apr 2018 16:39:53 +0800
Message-Id: <20180418083953.21492-4-peterx@redhat.com>
In-Reply-To: <20180418083953.21492-1-peterx@redhat.com>
References: <20180418083953.21492-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When caching mode is enabled for IOMMU, we should send explicit IOTLB
PSIs even for newly created mappings.  However these events are missing
for all intel_iommu_map() callers, e.g., iommu_map().  One direct user
is the vfio-pci driver.

To make sure we'll send the PSIs always when necessary, this patch
firstly introduced domain_mapping() helper for page mappings, then fixed
the problem by generalizing the explicit map IOTLB PSI logic into that
new helper. With that, we let iommu_domain_identity_map() to use the
simplified version to avoid sending the notifications, while for all the
rest of cases we send the notifications always.

For VM case, we send the PSIs to all the backend IOMMUs for the domain.

This patch allows the nested device assignment to work with QEMU (assign
device firstly to L1 guest, then assign it again to L2 guest).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/iommu/intel-iommu.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index bf111e60857c..eb0f0911342f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2353,18 +2353,47 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 	return 0;
 }
 
+static int domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
+                         struct scatterlist *sg, unsigned long phys_pfn,
+                         unsigned long nr_pages, int prot)
+{
+       int ret;
+       struct intel_iommu *iommu;
+
+       /* Do the real mapping first */
+       ret = __domain_mapping(domain, iov_pfn, sg, phys_pfn, nr_pages, prot);
+       if (ret)
+               return ret;
+
+       /* Notify about the new mapping */
+       if (domain_type_is_vm(domain)) {
+	       /* VM typed domains can have more than one IOMMUs */
+	       int iommu_id;
+	       for_each_domain_iommu(iommu_id, domain) {
+		       iommu = g_iommus[iommu_id];
+		       __mapping_notify_one(iommu, domain, iov_pfn, nr_pages);
+	       }
+       } else {
+	       /* General domains only have one IOMMU */
+	       iommu = domain_get_iommu(domain);
+	       __mapping_notify_one(iommu, domain, iov_pfn, nr_pages);
+       }
+
+       return 0;
+}
+
 static inline int domain_sg_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 				    struct scatterlist *sg, unsigned long nr_pages,
 				    int prot)
 {
-	return __domain_mapping(domain, iov_pfn, sg, 0, nr_pages, prot);
+	return domain_mapping(domain, iov_pfn, sg, 0, nr_pages, prot);
 }
 
 static inline int domain_pfn_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 				     unsigned long phys_pfn, unsigned long nr_pages,
 				     int prot)
 {
-	return __domain_mapping(domain, iov_pfn, NULL, phys_pfn, nr_pages, prot);
+	return domain_mapping(domain, iov_pfn, NULL, phys_pfn, nr_pages, prot);
 }
 
 static void domain_context_clear_one(struct intel_iommu *iommu, u8 bus, u8 devfn)
@@ -2669,9 +2698,9 @@ static int iommu_domain_identity_map(struct dmar_domain *domain,
 	 */
 	dma_pte_clear_range(domain, first_vpfn, last_vpfn);
 
-	return domain_pfn_mapping(domain, first_vpfn, first_vpfn,
-				  last_vpfn - first_vpfn + 1,
-				  DMA_PTE_READ|DMA_PTE_WRITE);
+	return __domain_mapping(domain, first_vpfn, NULL,
+				first_vpfn, last_vpfn - first_vpfn + 1,
+				DMA_PTE_READ|DMA_PTE_WRITE);
 }
 
 static int domain_prepare_identity_map(struct device *dev,
@@ -3638,8 +3667,6 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 	if (ret)
 		goto error;
 
-	__mapping_notify_one(iommu, domain, mm_to_dma_pfn(iova_pfn), size);
-
 	start_paddr = (phys_addr_t)iova_pfn << PAGE_SHIFT;
 	start_paddr += paddr & ~PAGE_MASK;
 	return start_paddr;
@@ -3857,8 +3884,6 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 		return 0;
 	}
 
-	__mapping_notify_one(iommu, domain, start_vpfn, size);
-
 	return nelems;
 }
 
-- 
2.14.3
