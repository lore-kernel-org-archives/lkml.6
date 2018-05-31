Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754163AbeEaHos (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:44:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48997 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754035AbeEaHns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:43:48 -0400
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>, Joerg Roedel <joro@8bytes.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>, Libin <huawei.libin@huawei.com>,
        Guozhu Li <liguozhu@hisilicon.com>, "Xinwei Hu" <huxinwei@huawei.com>
Subject: [PATCH 5/7] iommu/dma: add support for non-strict mode
Date: Thu, 31 May 2018 15:42:47 +0800
Message-ID: <1527752569-18020-6-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
In-Reply-To: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
References: <1527752569-18020-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Save the related domain pointer in struct iommu_dma_cookie, make iovad
   capable call domain->ops->flush_iotlb_all to flush TLB.
2. Define a new iommu capable: IOMMU_CAP_NON_STRICT, which used to indicate
   that the iommu domain support non-strict mode.
3. During the iommu domain initialization phase, call capable() to check
   whether it support non-strcit mode. If so, call init_iova_flush_queue
   to register iovad->flush_cb callback.
4. All unmap(contains iova-free) APIs will finally invoke __iommu_dma_unmap
   -->iommu_dma_free_iova. Use iovad->flush_cb to check whether its related
   iommu support non-strict mode or not, and call IOMMU_DOMAIN_IS_STRICT to
   make sure the IOMMU_DOMAIN_UNMANAGED domain always follow strict mode.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/dma-iommu.c | 29 ++++++++++++++++++++++++++---
 include/linux/iommu.h     |  3 +++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4e885f7..2e116d9 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -55,6 +55,7 @@ struct iommu_dma_cookie {
 	};
 	struct list_head		msi_page_list;
 	spinlock_t			msi_lock;
+	struct iommu_domain		*domain;
 };
 
 static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
@@ -64,7 +65,8 @@ static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
 	return PAGE_SIZE;
 }
 
-static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
+static struct iommu_dma_cookie *cookie_alloc(struct iommu_domain *domain,
+					     enum iommu_dma_cookie_type type)
 {
 	struct iommu_dma_cookie *cookie;
 
@@ -73,6 +75,7 @@ static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
 		spin_lock_init(&cookie->msi_lock);
 		INIT_LIST_HEAD(&cookie->msi_page_list);
 		cookie->type = type;
+		cookie->domain = domain;
 	}
 	return cookie;
 }
@@ -94,7 +97,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
 	if (domain->iova_cookie)
 		return -EEXIST;
 
-	domain->iova_cookie = cookie_alloc(IOMMU_DMA_IOVA_COOKIE);
+	domain->iova_cookie = cookie_alloc(domain, IOMMU_DMA_IOVA_COOKIE);
 	if (!domain->iova_cookie)
 		return -ENOMEM;
 
@@ -124,7 +127,7 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 	if (domain->iova_cookie)
 		return -EEXIST;
 
-	cookie = cookie_alloc(IOMMU_DMA_MSI_COOKIE);
+	cookie = cookie_alloc(domain, IOMMU_DMA_MSI_COOKIE);
 	if (!cookie)
 		return -ENOMEM;
 
@@ -261,6 +264,17 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }
 
+static void iova_flush_iotlb_all(struct iova_domain *iovad)
+{
+	struct iommu_dma_cookie *cookie;
+	struct iommu_domain *domain;
+
+	cookie = container_of(iovad, struct iommu_dma_cookie, iovad);
+	domain = cookie->domain;
+
+	domain->ops->flush_iotlb_all(domain);
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -276,6 +290,7 @@ static int iova_reserve_iommu_regions(struct device *dev,
 int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		u64 size, struct device *dev)
 {
+	const struct iommu_ops *ops = domain->ops;
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	unsigned long order, base_pfn, end_pfn;
@@ -313,6 +328,11 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
 
+	if (ops->capable && ops->capable(IOMMU_CAP_NON_STRICT)) {
+		BUG_ON(!ops->flush_iotlb_all);
+		init_iova_flush_queue(iovad, iova_flush_iotlb_all, NULL);
+	}
+
 	return iova_reserve_iommu_regions(dev, domain);
 }
 EXPORT_SYMBOL(iommu_dma_init_domain);
@@ -392,6 +412,9 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 	/* The MSI case is only ever cleaning up its most recent allocation */
 	if (cookie->type == IOMMU_DMA_MSI_COOKIE)
 		cookie->msi_iova -= size;
+	else if (!IOMMU_DOMAIN_IS_STRICT(cookie->domain) && iovad->flush_cb)
+		queue_iova(iovad, iova_pfn(iovad, iova),
+				size >> iova_shift(iovad), 0);
 	else
 		free_iova_fast(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad));
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 39b3150..01ff569 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -87,6 +87,8 @@ struct iommu_domain_geometry {
 				 __IOMMU_DOMAIN_DMA_API)
 
 #define IOMMU_STRICT		1
+#define IOMMU_DOMAIN_IS_STRICT(domain)	\
+		(domain->type == IOMMU_DOMAIN_UNMANAGED)
 
 struct iommu_domain {
 	unsigned type;
@@ -103,6 +105,7 @@ enum iommu_cap {
 					   transactions */
 	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
 	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
+	IOMMU_CAP_NON_STRICT,		/* IOMMU supports non-strict mode */
 };
 
 /*
-- 
1.8.3
