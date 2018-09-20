Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8CFECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFCF206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFCF206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbeITVyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:54:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48572 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeITVyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:54:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7472E15AD;
        Thu, 20 Sep 2018 09:10:38 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.Emea.Arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A98113F557;
        Thu, 20 Sep 2018 09:10:36 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com,
        john.garry@huawei.com
Subject: [PATCH v8 2/7] iommu/dma: Add support for non-strict mode
Date:   Thu, 20 Sep 2018 17:10:22 +0100
Message-Id: <bd0efe2b9a26e35cfd9b4157bea3e6f21f4c8adf.1537458163.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.0.dirty
In-Reply-To: <cover.1537458163.git.robin.murphy@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

With the flush queue infrastructure already abstracted into IOVA
domains, hooking it up in iommu-dma is pretty simple. Since there is a
degree of dependency on the IOMMU driver knowing what to do to play
along, we key the whole thing off a domain attribute which will be set
on default DMA ops domains to request non-strict invalidation. That way,
drivers can indicate the appropriate support by acknowledging the
attribute, and we can easily fall back to strict invalidation otherwise.

The flush queue callback needs a handle on the iommu_domain which owns
our cookie, so we have to add a pointer back to that, but neatly, that's
also sufficient to indicate whether we're using a flush queue or not,
and thus which way to release IOVAs. The only slight subtlety is
switching __iommu_dma_unmap() from calling iommu_unmap() to explicit
iommu_unmap_fast()/iommu_tlb_sync() so that we can elide the sync
entirely in non-strict mode.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
[rm: convert to domain attribute, tweak comments and commit message]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v8:
 - Rewrite commit message/comments
 - Don't initialise "attr" unnecessarily
 - Rename "domain" to "fq_domain" for clarity
 - Don't let init_iova_flush_queue() be called more than once

 drivers/iommu/dma-iommu.c | 32 +++++++++++++++++++++++++++++++-
 include/linux/iommu.h     |  1 +
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 511ff9a1d6d9..cc1bf786cfac 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -55,6 +55,9 @@ struct iommu_dma_cookie {
 	};
 	struct list_head		msi_page_list;
 	spinlock_t			msi_lock;
+
+	/* Domain for flush queue callback; NULL if flush queue not in use */
+	struct iommu_domain		*fq_domain;
 };
 
 static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
@@ -257,6 +260,20 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }
 
+static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
+{
+	struct iommu_dma_cookie *cookie;
+	struct iommu_domain *domain;
+
+	cookie = container_of(iovad, struct iommu_dma_cookie, iovad);
+	domain = cookie->fq_domain;
+	/*
+	 * The IOMMU driver supporting DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE
+	 * implies that ops->flush_iotlb_all must be non-NULL.
+	 */
+	domain->ops->flush_iotlb_all(domain);
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -275,6 +292,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	unsigned long order, base_pfn, end_pfn;
+	int attr;
 
 	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
 		return -EINVAL;
@@ -308,6 +326,13 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	}
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
+
+	if (!cookie->fq_domain && !iommu_domain_get_attr(domain,
+			DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE, &attr) && attr) {
+		cookie->fq_domain = domain;
+		init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
+	}
+
 	if (!dev)
 		return 0;
 
@@ -393,6 +418,9 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 	/* The MSI case is only ever cleaning up its most recent allocation */
 	if (cookie->type == IOMMU_DMA_MSI_COOKIE)
 		cookie->msi_iova -= size;
+	else if (cookie->fq_domain)	/* non-strict mode */
+		queue_iova(iovad, iova_pfn(iovad, iova),
+				size >> iova_shift(iovad), 0);
 	else
 		free_iova_fast(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad));
@@ -408,7 +436,9 @@ static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
 	dma_addr -= iova_off;
 	size = iova_align(iovad, size + iova_off);
 
-	WARN_ON(iommu_unmap(domain, dma_addr, size) != size);
+	WARN_ON(iommu_unmap_fast(domain, dma_addr, size) != size);
+	if (!cookie->fq_domain)
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

