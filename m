Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A2FECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE602206B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 14:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE602206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeINTpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 15:45:23 -0400
Received: from foss.arm.com ([217.140.101.70]:34218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeINTpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 15:45:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CA8315B2;
        Fri, 14 Sep 2018 07:30:37 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 42C8B3F575;
        Fri, 14 Sep 2018 07:30:35 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v7 2/6] iommu/dma: Add support for non-strict mode
Date:   Fri, 14 Sep 2018 15:30:20 +0100
Message-Id: <0a891cec4bb164f8cf2f57c753791a7d1f5f1d81.1536935328.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.0.dirty
In-Reply-To: <cover.1536935328.git.robin.murphy@arm.com>
References: <cover.1536935328.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

1. Save the related domain pointer in struct iommu_dma_cookie, make iovad
   capable call domain->ops->flush_iotlb_all to flush TLB.
2. During the iommu domain initialization phase, base on domain->non_strict
   field to check whether non-strict mode is supported or not. If so, call
   init_iova_flush_queue to register iovad->flush_cb callback.
3. All unmap(contains iova-free) APIs will finally invoke __iommu_dma_unmap
   -->iommu_dma_free_iova. If the domain is non-strict, call queue_iova to
   put off iova freeing, and omit iommu_tlb_sync operation.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
[rm: convert raw boolean to domain attribute]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 29 ++++++++++++++++++++++++++++-
 include/linux/iommu.h     |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 511ff9a1d6d9..092e6926dc3c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -55,6 +55,9 @@ struct iommu_dma_cookie {
 	};
 	struct list_head		msi_page_list;
 	spinlock_t			msi_lock;
+
+	/* Only be assigned in non-strict mode, otherwise it's NULL */
+	struct iommu_domain		*domain;
 };
 
 static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
@@ -257,6 +260,17 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }
 
+static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
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
@@ -275,6 +289,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	unsigned long order, base_pfn, end_pfn;
+	int attr = 1;
 
 	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
 		return -EINVAL;
@@ -308,6 +323,13 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	}
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
+
+	if (!iommu_domain_get_attr(domain, DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+			&attr) && attr) {
+		cookie->domain = domain;
+		init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
+	}
+
 	if (!dev)
 		return 0;
 
@@ -393,6 +415,9 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 	/* The MSI case is only ever cleaning up its most recent allocation */
 	if (cookie->type == IOMMU_DMA_MSI_COOKIE)
 		cookie->msi_iova -= size;
+	else if (cookie->domain)	/* non-strict mode */
+		queue_iova(iovad, iova_pfn(iovad, iova),
+				size >> iova_shift(iovad), 0);
 	else
 		free_iova_fast(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad));
@@ -408,7 +433,9 @@ static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
 	dma_addr -= iova_off;
 	size = iova_align(iovad, size + iova_off);
 
-	WARN_ON(iommu_unmap(domain, dma_addr, size) != size);
+	WARN_ON(iommu_unmap_fast(domain, dma_addr, size) != size);
+	if (!cookie->domain)
+		iommu_tlb_sync(domain);
 	iommu_dma_free_iova(cookie, dma_addr, size);
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 87994c265bf5..decabe8e8dbe 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -124,6 +124,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMU_ENABLE,
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
+	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
2.19.0.dirty

