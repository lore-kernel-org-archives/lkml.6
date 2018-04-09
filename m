Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754759AbeDIUIC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 16:08:02 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54051 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754692AbeDIUHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 16:07:39 -0400
X-Google-Smtp-Source: AIpwx4+e1NZPvhjrhZ8KMTub3tzTARP0XDvvqgv3WDC9J91t35rmGBsyK4FX5vxw+pLYppQUiQu9TA==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] iommu/tegra: gart: Constify number of GART pages
Date: Mon,  9 Apr 2018 23:07:21 +0300
Message-Id: <954659be6760130f6ffd5e733db2ad58cbb8e6e4.1523304324.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <cover.1523304324.git.digetx@gmail.com>
References: <cover.1523304324.git.digetx@gmail.com>
In-Reply-To: <cover.1523304324.git.digetx@gmail.com>
References: <cover.1523304324.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GART has a fixed aperture size, hence the number of pages is constant.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-gart.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 89ec24c6952c..4a0607669d34 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -33,6 +33,8 @@
 
 #include <asm/cacheflush.h>
 
+#define GART_APERTURE_SIZE	SZ_32M
+
 /* bitmap of the page sizes currently supported */
 #define GART_IOMMU_PGSIZES	(SZ_4K)
 
@@ -47,6 +49,8 @@
 #define GART_PAGE_MASK						\
 	(~(GART_PAGE_SIZE - 1) & ~GART_ENTRY_PHYS_ADDR_VALID)
 
+#define GART_PAGECOUNT		(GART_APERTURE_SIZE >> GART_PAGE_SHIFT)
+
 struct gart_client {
 	struct device		*dev;
 	struct list_head	list;
@@ -55,7 +59,6 @@ struct gart_client {
 struct gart_device {
 	void __iomem		*regs;
 	u32			*savedata;
-	u32			page_count;	/* total remappable size */
 	dma_addr_t		iovmm_base;	/* offset to vmm_area */
 	spinlock_t		pte_lock;	/* for pagetable */
 	struct list_head	client;
@@ -91,7 +94,7 @@ static struct gart_domain *to_gart_domain(struct iommu_domain *dom)
 
 #define for_each_gart_pte(gart, iova)					\
 	for (iova = gart->iovmm_base;					\
-	     iova < gart->iovmm_base + GART_PAGE_SIZE * gart->page_count; \
+	     iova < gart->iovmm_base + GART_APERTURE_SIZE; 		\
 	     iova += GART_PAGE_SIZE)
 
 static inline void gart_set_pte(struct gart_device *gart,
@@ -158,7 +161,7 @@ static inline bool gart_iova_range_valid(struct gart_device *gart,
 	iova_start = iova;
 	iova_end = iova_start + bytes - 1;
 	gart_start = gart->iovmm_base;
-	gart_end = gart_start + gart->page_count * GART_PAGE_SIZE - 1;
+	gart_end = gart_start + GART_APERTURE_SIZE - 1;
 
 	if (iova_start < gart_start)
 		return false;
@@ -241,7 +244,7 @@ static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 	gart_domain->gart = gart;
 	gart_domain->domain.geometry.aperture_start = gart->iovmm_base;
 	gart_domain->domain.geometry.aperture_end = gart->iovmm_base +
-					gart->page_count * GART_PAGE_SIZE - 1;
+							GART_APERTURE_SIZE - 1;
 	gart_domain->domain.geometry.force_aperture = true;
 
 	return &gart_domain->domain;
@@ -463,9 +466,8 @@ static int tegra_gart_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&gart->client);
 	gart->regs = gart_regs;
 	gart->iovmm_base = (dma_addr_t)res_remap->start;
-	gart->page_count = (resource_size(res_remap) >> GART_PAGE_SHIFT);
 
-	gart->savedata = vmalloc(sizeof(u32) * gart->page_count);
+	gart->savedata = vmalloc(sizeof(u32) * GART_PAGECOUNT);
 	if (!gart->savedata) {
 		dev_err(dev, "failed to allocate context save area\n");
 		return -ENOMEM;
-- 
2.16.3
