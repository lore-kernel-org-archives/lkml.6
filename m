Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751360AbeEDCfK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 22:35:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751239AbeEDCfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 22:35:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Linux IOMMU Mailing List <iommu@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jintack Lim <jintack@cs.columbia.edu>,
        Alexander Witte <alexander.witte@baicanada.com>, peterx@redhat.com
Subject: [PATCH v3 1/2] iommu/vt-d: Introduce __mapping_notify_one()
Date: Fri,  4 May 2018 10:34:52 +0800
Message-Id: <20180504023453.25682-2-peterx@redhat.com>
In-Reply-To: <20180504023453.25682-1-peterx@redhat.com>
References: <20180504023453.25682-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce this new helper to notify one newly created mapping on one
single IOMMU.  We can further leverage this helper in the next patch.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 drivers/iommu/intel-iommu.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 749d8f235346..13190a54aba2 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1606,6 +1606,18 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 		iommu_flush_dev_iotlb(domain, addr, mask);
 }
 
+/* Notification for newly created mappings */
+static inline void __mapping_notify_one(struct intel_iommu *iommu,
+					struct dmar_domain *domain,
+					unsigned long pfn, unsigned int pages)
+{
+	/* It's a non-present to present mapping. Only flush if caching mode */
+	if (cap_caching_mode(iommu->cap))
+		iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
+	else
+		iommu_flush_write_buffer(iommu);
+}
+
 static void iommu_flush_iova(struct iova_domain *iovad)
 {
 	struct dmar_domain *domain;
@@ -3625,13 +3637,7 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 	if (ret)
 		goto error;
 
-	/* it's a non-present to present mapping. Only flush if caching mode */
-	if (cap_caching_mode(iommu->cap))
-		iommu_flush_iotlb_psi(iommu, domain,
-				      mm_to_dma_pfn(iova_pfn),
-				      size, 0, 1);
-	else
-		iommu_flush_write_buffer(iommu);
+	__mapping_notify_one(iommu, domain, mm_to_dma_pfn(iova_pfn), size);
 
 	start_paddr = (phys_addr_t)iova_pfn << PAGE_SHIFT;
 	start_paddr += paddr & ~PAGE_MASK;
@@ -3819,11 +3825,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 		return 0;
 	}
 
-	/* it's a non-present to present mapping. Only flush if caching mode */
-	if (cap_caching_mode(iommu->cap))
-		iommu_flush_iotlb_psi(iommu, domain, start_vpfn, size, 0, 1);
-	else
-		iommu_flush_write_buffer(iommu);
+	__mapping_notify_one(iommu, domain, start_vpfn, size);
 
 	return nelems;
 }
-- 
2.17.0
