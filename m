Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LMLRFwQHHVsGOgAAmS7hNA
	; Sun, 10 Jun 2018 11:09:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4F5F760850; Sun, 10 Jun 2018 11:09:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C2DE9600D0;
	Sun, 10 Jun 2018 11:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C2DE9600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbeFJLJx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 07:09:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35222 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753877AbeFJLIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 07:08:36 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 15ADC5C677746;
        Sun, 10 Jun 2018 19:08:33 +0800 (CST)
Received: from localhost (10.177.23.164) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.382.0; Sun, 10 Jun 2018
 19:08:23 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Guozhu Li <liguozhu@hisilicon.com>,
        "Xinwei Hu" <huxinwei@huawei.com>
Subject: [PATCH v2 2/5] iommu/dma: add support for non-strict mode
Date: Sun, 10 Jun 2018 19:07:20 +0800
Message-ID: <1528628843-10280-3-git-send-email-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 1.9.5.msysgit.0
In-Reply-To: <1528628843-10280-1-git-send-email-thunder.leizhen@huawei.com>
References: <1528628843-10280-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.23.164]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Save the related domain pointer in struct iommu_dma_cookie, make iovad
   capable call domain->ops->flush_iotlb_all to flush TLB.
2. Add a new iommu capability: IOMMU_CAP_NON_STRICT, which used to indicate
   that the iommu domain support non-strict mode.
3. During the iommu domain initialization phase, call capable() to check
   whether it support non-strcit mode. If so, call init_iova_flush_queue
   to register iovad->flush_cb callback.
4. All unmap(contains iova-free) APIs will finally invoke __iommu_dma_unmap
   -->iommu_dma_free_iova. If the domain is non-strict, call queue_iova to
   put off iova freeing.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/dma-iommu.c | 25 +++++++++++++++++++++++++
 include/linux/iommu.h     |  7 +++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ddcbbdb..9f0c77a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -55,6 +55,7 @@ struct iommu_dma_cookie {
 	};
 	struct list_head		msi_page_list;
 	spinlock_t			msi_lock;
+	struct iommu_domain		*domain_non_strict;
 };

 static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
@@ -257,6 +258,17 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }

+static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
+{
+	struct iommu_dma_cookie *cookie;
+	struct iommu_domain *domain;
+
+	cookie = container_of(iovad, struct iommu_dma_cookie, iovad);
+	domain = cookie->domain_non_strict;
+
+	domain->ops->flush_iotlb_all(domain);
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -272,6 +284,7 @@ static int iova_reserve_iommu_regions(struct device *dev,
 int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 		u64 size, struct device *dev)
 {
+	const struct iommu_ops *ops = domain->ops;
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	unsigned long order, base_pfn, end_pfn;
@@ -308,6 +321,15 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	}

 	init_iova_domain(iovad, 1UL << order, base_pfn);
+
+	if ((ops->capable && ops->capable(IOMMU_CAP_NON_STRICT)) &&
+	    (IOMMU_DOMAIN_STRICT_MODE(domain) == IOMMU_NON_STRICT)) {
+		BUG_ON(!ops->flush_iotlb_all);
+
+		cookie->domain_non_strict = domain;
+		init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
+	}
+
 	if (!dev)
 		return 0;

@@ -390,6 +412,9 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 	/* The MSI case is only ever cleaning up its most recent allocation */
 	if (cookie->type == IOMMU_DMA_MSI_COOKIE)
 		cookie->msi_iova -= size;
+	else if (cookie->domain_non_strict)
+		queue_iova(iovad, iova_pfn(iovad, iova),
+				size >> iova_shift(iovad), 0);
 	else
 		free_iova_fast(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad));
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 19938ee..82ed979 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -86,6 +86,12 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API)

+#define IOMMU_STRICT		0
+#define IOMMU_NON_STRICT	1
+#define IOMMU_STRICT_MODE_MASK	1UL
+#define IOMMU_DOMAIN_STRICT_MODE(domain)	\
+		(domain->type != IOMMU_DOMAIN_UNMANAGED)
+
 struct iommu_domain {
 	unsigned type;
 	const struct iommu_ops *ops;
@@ -101,6 +107,7 @@ enum iommu_cap {
 					   transactions */
 	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
 	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
+	IOMMU_CAP_NON_STRICT,		/* IOMMU supports non-strict mode */
 };

 /*
--
1.8.3
