Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBF0C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97ABD20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LK5zIRC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97ABD20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437186AbeKWAnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:43:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58158 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732590AbeKWAnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:43:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZNLU6sSp3uiLMX8F8bTjTkvpVBXJnza8jEm00Ete8Hs=; b=LK5zIRC0Suh0CKQXnLY9Ib5Fa5
        E5cBOR6XLI16RPCptv5t6VifDPnTjc6X90Dwv732+3m19fcXm76KC4WGIMuIo4Tdch3Lg9mwmze0f
        +sxRKP9XzO+zV9hz9ySl8roAsc+4oJbzWclkexKd+bCSg2CqxfxtKlOHwXi2FbBNE/s4KVoHATo5g
        Up49RHizfvfF4hXREmVz/7U9IzmAY/b5aH6ROpXLvBA/fo8d/BhqfKj++s/oSpBgKYbVw9JMRaUd7
        fhY21gBlq7I7eS3NfKa09HOX3M9reSVz2nM6pT6GdEzABEG1Y4LOhXR/TT9uzTGwOFBelZKREqVFl
        EbZqOH8Q==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpaB-000875-Af; Thu, 22 Nov 2018 14:03:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/24] sparc: remove the mapping_error dma_map_ops method
Date:   Thu, 22 Nov 2018 15:03:05 +0100
Message-Id: <20181122140320.24080-10-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122140320.24080-1-hch@lst.de>
References: <20181122140320.24080-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparc already returns (~(dma_addr_t)0x0) on mapping failures, so we can
switch over to returning DMA_MAPPING_ERROR and let the core dma-mapping
code handle the rest.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/iommu.c        | 12 +++---------
 arch/sparc/kernel/iommu_common.h |  2 --
 arch/sparc/kernel/pci_sun4v.c    | 14 ++++----------
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 40d008b0bd3e..0626bae5e3da 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -315,7 +315,7 @@ static dma_addr_t dma_4u_map_page(struct device *dev, struct page *page,
 bad_no_ctx:
 	if (printk_ratelimit())
 		WARN_ON(1);
-	return SPARC_MAPPING_ERROR;
+	return DMA_MAPPING_ERROR;
 }
 
 static void strbuf_flush(struct strbuf *strbuf, struct iommu *iommu,
@@ -548,7 +548,7 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 
 	if (outcount < incount) {
 		outs = sg_next(outs);
-		outs->dma_address = SPARC_MAPPING_ERROR;
+		outs->dma_address = DMA_MAPPING_ERROR;
 		outs->dma_length = 0;
 	}
 
@@ -574,7 +574,7 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 			iommu_tbl_range_free(&iommu->tbl, vaddr, npages,
 					     IOMMU_ERROR_CODE);
 
-			s->dma_address = SPARC_MAPPING_ERROR;
+			s->dma_address = DMA_MAPPING_ERROR;
 			s->dma_length = 0;
 		}
 		if (s == outs)
@@ -742,11 +742,6 @@ static void dma_4u_sync_sg_for_cpu(struct device *dev,
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
-static int dma_4u_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == SPARC_MAPPING_ERROR;
-}
-
 static int dma_4u_supported(struct device *dev, u64 device_mask)
 {
 	struct iommu *iommu = dev->archdata.iommu;
@@ -772,7 +767,6 @@ static const struct dma_map_ops sun4u_dma_ops = {
 	.sync_single_for_cpu	= dma_4u_sync_single_for_cpu,
 	.sync_sg_for_cpu	= dma_4u_sync_sg_for_cpu,
 	.dma_supported		= dma_4u_supported,
-	.mapping_error		= dma_4u_mapping_error,
 };
 
 const struct dma_map_ops *dma_ops = &sun4u_dma_ops;
diff --git a/arch/sparc/kernel/iommu_common.h b/arch/sparc/kernel/iommu_common.h
index e3c02ba32500..d62ed9c5682d 100644
--- a/arch/sparc/kernel/iommu_common.h
+++ b/arch/sparc/kernel/iommu_common.h
@@ -48,6 +48,4 @@ static inline int is_span_boundary(unsigned long entry,
 	return iommu_is_span_boundary(entry, nr, shift, boundary_size);
 }
 
-#define SPARC_MAPPING_ERROR	(~(dma_addr_t)0x0)
-
 #endif /* _IOMMU_COMMON_H */
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index 565d9ac883d0..fa0e42b4cbfb 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -414,12 +414,12 @@ static dma_addr_t dma_4v_map_page(struct device *dev, struct page *page,
 bad:
 	if (printk_ratelimit())
 		WARN_ON(1);
-	return SPARC_MAPPING_ERROR;
+	return DMA_MAPPING_ERROR;
 
 iommu_map_fail:
 	local_irq_restore(flags);
 	iommu_tbl_range_free(tbl, bus_addr, npages, IOMMU_ERROR_CODE);
-	return SPARC_MAPPING_ERROR;
+	return DMA_MAPPING_ERROR;
 }
 
 static void dma_4v_unmap_page(struct device *dev, dma_addr_t bus_addr,
@@ -592,7 +592,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 
 	if (outcount < incount) {
 		outs = sg_next(outs);
-		outs->dma_address = SPARC_MAPPING_ERROR;
+		outs->dma_address = DMA_MAPPING_ERROR;
 		outs->dma_length = 0;
 	}
 
@@ -609,7 +609,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 			iommu_tbl_range_free(tbl, vaddr, npages,
 					     IOMMU_ERROR_CODE);
 			/* XXX demap? XXX */
-			s->dma_address = SPARC_MAPPING_ERROR;
+			s->dma_address = DMA_MAPPING_ERROR;
 			s->dma_length = 0;
 		}
 		if (s == outs)
@@ -688,11 +688,6 @@ static int dma_4v_supported(struct device *dev, u64 device_mask)
 	return pci64_dma_supported(to_pci_dev(dev), device_mask);
 }
 
-static int dma_4v_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == SPARC_MAPPING_ERROR;
-}
-
 static const struct dma_map_ops sun4v_dma_ops = {
 	.alloc				= dma_4v_alloc_coherent,
 	.free				= dma_4v_free_coherent,
@@ -701,7 +696,6 @@ static const struct dma_map_ops sun4v_dma_ops = {
 	.map_sg				= dma_4v_map_sg,
 	.unmap_sg			= dma_4v_unmap_sg,
 	.dma_supported			= dma_4v_supported,
-	.mapping_error			= dma_4v_mapping_error,
 };
 
 static void pci_sun4v_scan_bus(struct pci_pbm_info *pbm, struct device *parent)
-- 
2.19.1

