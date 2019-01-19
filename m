Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFFDC5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EA92086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfASAGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:06:10 -0500
Received: from ale.deltatee.com ([207.54.116.67]:53594 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730114AbfASAGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:06:10 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gke9E-00028U-Qx; Fri, 18 Jan 2019 17:06:06 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1gke9C-0003Ku-Pf; Fri, 18 Jan 2019 17:06:02 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Logan Gunthorpe <logang@deltatee.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Date:   Fri, 18 Jan 2019 17:05:59 -0700
Message-Id: <20190119000559.12784-1-logang@deltatee.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, hch@lst.de, logang@deltatee.com, dwmw2@infradead.org, joro@8bytes.org
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] iommu/vt-d: Implement dma_[un]map_resource()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the Intel IOMMU uses the default dma_[un]map_resource()
implementations does nothing and simply returns the physical address
unmodified.

However, this doesn't create the IOVA entries necessary for addresses
mapped this way to work when the IOMMU is enabled. Thus, when the
IOMMU is enabled, drivers relying on dma_map_resource() will trigger
DMAR errors. We see this when running ntb_transport with the IOMMU
enabled, DMA, and switchtec hardware.

The implementation for intel_map_resource() is nearly identical to
intel_map_page(), we just have to re-create __intel_map_single().
dma_unmap_resource() uses intel_unmap_page() directly as the
functions are identical.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
---
 drivers/iommu/intel-iommu.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 2bd9ac285c0d..81fb265f7730 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3649,11 +3649,9 @@ static int iommu_no_mapping(struct device *dev)
 	return 0;
 }
 
-static dma_addr_t __intel_map_page(struct device *dev, struct page *page,
-				   unsigned long offset, size_t size, int dir,
-				   u64 dma_mask)
+static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
+				     size_t size, int dir, u64 dma_mask)
 {
-	phys_addr_t paddr = page_to_phys(page) + offset;
 	struct dmar_domain *domain;
 	phys_addr_t start_paddr;
 	unsigned long iova_pfn;
@@ -3710,6 +3708,14 @@ static dma_addr_t __intel_map_page(struct device *dev, struct page *page,
 	return DMA_MAPPING_ERROR;
 }
 
+static dma_addr_t __intel_map_page(struct device *dev, struct page *page,
+				   unsigned long offset, size_t size, int dir,
+				   u64 dma_mask)
+{
+	return __intel_map_single(dev, page_to_phys(page) + offset, size, dir,
+				  dma_mask);
+}
+
 static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				 unsigned long offset, size_t size,
 				 enum dma_data_direction dir,
@@ -3718,6 +3724,13 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 	return __intel_map_page(dev, page, offset, size, dir, *dev->dma_mask);
 }
 
+static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
+				     size_t size, enum dma_data_direction dir,
+				     unsigned long attrs)
+{
+	return __intel_map_single(dev, phys_addr, size, dir, *dev->dma_mask);
+}
+
 static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
 {
 	struct dmar_domain *domain;
@@ -3924,6 +3937,8 @@ static const struct dma_map_ops intel_dma_ops = {
 	.unmap_sg = intel_unmap_sg,
 	.map_page = intel_map_page,
 	.unmap_page = intel_unmap_page,
+	.map_resource = intel_map_resource,
+	.unmap_resource = intel_unmap_page,
 	.dma_supported = dma_direct_supported,
 };
 
@@ -4080,7 +4095,7 @@ static int init_iommu_hw(void)
 				iommu_disable_protect_mem_regions(iommu);
 			continue;
 		}
-	
+
 		iommu_flush_write_buffer(iommu);
 
 		iommu_set_root_entry(iommu);
-- 
2.19.0

