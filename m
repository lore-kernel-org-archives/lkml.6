Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F4DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834E020820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="opXri71v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834E020820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437333AbeKWAn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:43:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731458AbeKWAnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:43:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UCBzcSNstlTImrqRsKjur3SJmugPcDMxlHw2DAWEj2s=; b=opXri71vNUMfd5qdcSsTUotgJs
        3e7Ib3jbAglhBOKY5dpsk5hJl7iPHt1pFo+YVIPQk4v9CMyqEtQkcbLXalgYd1veYsWH/MHRkAr2g
        R52KW2Ktqpxw+iEo28hnQjcNdv1Wz+HGjZesJZpCFWEpPV1hb2cAEGNRdi+PAa5b11wfxwM0TH/WL
        TcI22DuSCULc0r72obvK2x6iGq56hdSbi+aIQG8KbD+NYBQ5WTcJZYvGXzzJnPjwDeCqnw0HdfDc6
        RAYRV0nJKIBCrEDYjTu8vRIhrDNHIEL5i8550DlWtNVRWLYWY3Ach1jD29SpkE23IK7HvLYT/G9/b
        dKeeG/bA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpac-0000KC-Sw; Thu, 22 Nov 2018 14:04:19 +0000
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
Subject: [PATCH 18/24] x86/calgary: remove the mapping_error dma_map_ops method
Date:   Thu, 22 Nov 2018 15:03:14 +0100
Message-Id: <20181122140320.24080-19-hch@lst.de>
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

Return DMA_MAPPING_ERROR instead of the magic bad_dma_addr on a dma
mapping failure and let the core dma-mapping code handle the rest.

Remove the magic EMERGENCY_PAGES that the bad_dma_addr gets redirected to.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/pci-calgary_64.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index bbfc8b1e9104..e76ec1b8ed1f 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -51,8 +51,6 @@
 #include <asm/x86_init.h>
 #include <asm/iommu_table.h>
 
-#define CALGARY_MAPPING_ERROR	0
-
 #ifdef CONFIG_CALGARY_IOMMU_ENABLED_BY_DEFAULT
 int use_calgary __read_mostly = 1;
 #else
@@ -157,8 +155,6 @@ static const unsigned long phb_debug_offsets[] = {
 
 #define PHB_DEBUG_STUFF_OFFSET	0x0020
 
-#define EMERGENCY_PAGES 32 /* = 128KB */
-
 unsigned int specified_table_size = TCE_TABLE_SIZE_UNSPECIFIED;
 static int translate_empty_slots __read_mostly = 0;
 static int calgary_detected __read_mostly = 0;
@@ -255,7 +251,7 @@ static unsigned long iommu_range_alloc(struct device *dev,
 			if (panic_on_overflow)
 				panic("Calgary: fix the allocator.\n");
 			else
-				return CALGARY_MAPPING_ERROR;
+				return DMA_MAPPING_ERROR;
 		}
 	}
 
@@ -274,11 +270,10 @@ static dma_addr_t iommu_alloc(struct device *dev, struct iommu_table *tbl,
 	dma_addr_t ret;
 
 	entry = iommu_range_alloc(dev, tbl, npages);
-
-	if (unlikely(entry == CALGARY_MAPPING_ERROR)) {
+	if (unlikely(entry == DMA_MAPPING_ERROR)) {
 		pr_warn("failed to allocate %u pages in iommu %p\n",
 			npages, tbl);
-		return CALGARY_MAPPING_ERROR;
+		return DMA_MAPPING_ERROR;
 	}
 
 	/* set the return dma address */
@@ -298,8 +293,7 @@ static void iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
 	unsigned long flags;
 
 	/* were we called with bad_dma_address? */
-	badend = CALGARY_MAPPING_ERROR + (EMERGENCY_PAGES * PAGE_SIZE);
-	if (unlikely(dma_addr < badend)) {
+	if (unlikely(dma_addr == DMA_MAPPING_ERROR)) {
 		WARN(1, KERN_ERR "Calgary: driver tried unmapping bad DMA "
 		       "address 0x%Lx\n", dma_addr);
 		return;
@@ -383,7 +377,7 @@ static int calgary_map_sg(struct device *dev, struct scatterlist *sg,
 		npages = iommu_num_pages(vaddr, s->length, PAGE_SIZE);
 
 		entry = iommu_range_alloc(dev, tbl, npages);
-		if (entry == CALGARY_MAPPING_ERROR) {
+		if (entry == DMA_MAPPING_ERROR) {
 			/* makes sure unmap knows to stop */
 			s->dma_length = 0;
 			goto error;
@@ -401,7 +395,7 @@ static int calgary_map_sg(struct device *dev, struct scatterlist *sg,
 error:
 	calgary_unmap_sg(dev, sg, nelems, dir, 0);
 	for_each_sg(sg, s, nelems, i) {
-		sg->dma_address = CALGARY_MAPPING_ERROR;
+		sg->dma_address = DMA_MAPPING_ERROR;
 		sg->dma_length = 0;
 	}
 	return 0;
@@ -454,7 +448,7 @@ static void* calgary_alloc_coherent(struct device *dev, size_t size,
 
 	/* set up tces to cover the allocated range */
 	mapping = iommu_alloc(dev, tbl, ret, npages, DMA_BIDIRECTIONAL);
-	if (mapping == CALGARY_MAPPING_ERROR)
+	if (mapping == DMA_MAPPING_ERROR)
 		goto free;
 	*dma_handle = mapping;
 	return ret;
@@ -479,11 +473,6 @@ static void calgary_free_coherent(struct device *dev, size_t size,
 	free_pages((unsigned long)vaddr, get_order(size));
 }
 
-static int calgary_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == CALGARY_MAPPING_ERROR;
-}
-
 static const struct dma_map_ops calgary_dma_ops = {
 	.alloc = calgary_alloc_coherent,
 	.free = calgary_free_coherent,
@@ -491,7 +480,6 @@ static const struct dma_map_ops calgary_dma_ops = {
 	.unmap_sg = calgary_unmap_sg,
 	.map_page = calgary_map_page,
 	.unmap_page = calgary_unmap_page,
-	.mapping_error = calgary_mapping_error,
 	.dma_supported = dma_direct_supported,
 };
 
@@ -739,9 +727,6 @@ static void __init calgary_reserve_regions(struct pci_dev *dev)
 	u64 start;
 	struct iommu_table *tbl = pci_iommu(dev->bus);
 
-	/* reserve EMERGENCY_PAGES from bad_dma_address and up */
-	iommu_range_reserve(tbl, CALGARY_MAPPING_ERROR, EMERGENCY_PAGES);
-
 	/* avoid the BIOS/VGA first 640KB-1MB region */
 	/* for CalIOC2 - avoid the entire first MB */
 	if (is_calgary(dev->device)) {
-- 
2.19.1

