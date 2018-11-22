Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3A6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA642081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wh2TGWPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA642081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437270AbeKWAnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:43:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60006 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437252AbeKWAnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ewKMIOPiQeSKNSLzG50VuvD8IxV2yIBYh9Hw3lJsGjs=; b=Wh2TGWPAyFqHhHM32M9S10GWgv
        +W4X52pRAsKJ+NryFFDSis2EVVLFB+qHl/t74Zc6eKH46T2ctjpTlW2asSg8hlAs6OvIcriN/HGzI
        usdsoD6H+nQJCfbY32l6/1z+8bjw0Xgl8B+5dhqfjomlNz2vmipxsnwdOx9LALllb5YyCY3mTb2cH
        NSiQCOcNFHjyj7+gwFTGw8Yuf74sQarcttjcx6wbISxdts+6dlfE2LYVmgIi9/R7DfMiIGNqpzYTZ
        4xSEkKBteHjgd1OseJ6Qaxotk1IUj3lR9k5sIQPTmmInBkLRR5XTTeJiBVscc4C1HIK7qC/pMWNgc
        TaAYb2pA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpaQ-0008UE-L5; Thu, 22 Nov 2018 14:04:07 +0000
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
Subject: [PATCH 14/24] ia64/sba_iommu: improve internal map_page users
Date:   Thu, 22 Nov 2018 15:03:10 +0100
Message-Id: <20181122140320.24080-15-hch@lst.de>
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

Remove the odd sba_{un,}map_single_attrs wrappers, check errors
everywhere, and remove the completly bogus alloc_pages_node call that
uses the dma attributes argument as the node id.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/ia64/hp/common/sba_iommu.c | 71 ++++++++++++---------------------
 1 file changed, 26 insertions(+), 45 deletions(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index e8a93b07283e..b953282d4704 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -907,11 +907,12 @@ sba_mark_invalid(struct ioc *ioc, dma_addr_t iova, size_t byte_cnt)
 }
 
 /**
- * sba_map_single_attrs - map one buffer and return IOVA for DMA
+ * sba_map_page - map one buffer and return IOVA for DMA
  * @dev: instance of PCI owned by the driver that's asking.
- * @addr:  driver buffer to map.
- * @size:  number of bytes to map in driver buffer.
- * @dir:  R/W or both.
+ * @page: page to map
+ * @poff: offset into page
+ * @size: number of bytes to map
+ * @dir: dma direction
  * @attrs: optional dma attributes
  *
  * See Documentation/DMA-API-HOWTO.txt
@@ -944,7 +945,7 @@ static dma_addr_t sba_map_page(struct device *dev, struct page *page,
  		** Device is bit capable of DMA'ing to the buffer...
 		** just return the PCI address of ptr
  		*/
-		DBG_BYPASS("sba_map_single_attrs() bypass mask/addr: "
+		DBG_BYPASS("sba_map_page() bypass mask/addr: "
 			   "0x%lx/0x%lx\n",
 		           to_pci_dev(dev)->dma_mask, pci_addr);
 		return pci_addr;
@@ -966,7 +967,7 @@ static dma_addr_t sba_map_page(struct device *dev, struct page *page,
 
 #ifdef ASSERT_PDIR_SANITY
 	spin_lock_irqsave(&ioc->res_lock, flags);
-	if (sba_check_pdir(ioc,"Check before sba_map_single_attrs()"))
+	if (sba_check_pdir(ioc,"Check before sba_map_page()"))
 		panic("Sanity check failed");
 	spin_unlock_irqrestore(&ioc->res_lock, flags);
 #endif
@@ -997,20 +998,12 @@ static dma_addr_t sba_map_page(struct device *dev, struct page *page,
 	/* form complete address */
 #ifdef ASSERT_PDIR_SANITY
 	spin_lock_irqsave(&ioc->res_lock, flags);
-	sba_check_pdir(ioc,"Check after sba_map_single_attrs()");
+	sba_check_pdir(ioc,"Check after sba_map_page()");
 	spin_unlock_irqrestore(&ioc->res_lock, flags);
 #endif
 	return SBA_IOVA(ioc, iovp, offset);
 }
 
-static dma_addr_t sba_map_single_attrs(struct device *dev, void *addr,
-				       size_t size, enum dma_data_direction dir,
-				       unsigned long attrs)
-{
-	return sba_map_page(dev, virt_to_page(addr),
-			    (unsigned long)addr & ~PAGE_MASK, size, dir, attrs);
-}
-
 #ifdef ENABLE_MARK_CLEAN
 static SBA_INLINE void
 sba_mark_clean(struct ioc *ioc, dma_addr_t iova, size_t size)
@@ -1036,7 +1029,7 @@ sba_mark_clean(struct ioc *ioc, dma_addr_t iova, size_t size)
 #endif
 
 /**
- * sba_unmap_single_attrs - unmap one IOVA and free resources
+ * sba_unmap_page - unmap one IOVA and free resources
  * @dev: instance of PCI owned by the driver that's asking.
  * @iova:  IOVA of driver buffer previously mapped.
  * @size:  number of bytes mapped in driver buffer.
@@ -1063,7 +1056,7 @@ static void sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
 		/*
 		** Address does not fall w/in IOVA, must be bypassing
 		*/
-		DBG_BYPASS("sba_unmap_single_attrs() bypass addr: 0x%lx\n",
+		DBG_BYPASS("sba_unmap_page() bypass addr: 0x%lx\n",
 			   iova);
 
 #ifdef ENABLE_MARK_CLEAN
@@ -1114,12 +1107,6 @@ static void sba_unmap_page(struct device *dev, dma_addr_t iova, size_t size,
 #endif /* DELAYED_RESOURCE_CNT == 0 */
 }
 
-void sba_unmap_single_attrs(struct device *dev, dma_addr_t iova, size_t size,
-			    enum dma_data_direction dir, unsigned long attrs)
-{
-	sba_unmap_page(dev, iova, size, dir, attrs);
-}
-
 /**
  * sba_alloc_coherent - allocate/map shared mem for DMA
  * @dev: instance of PCI owned by the driver that's asking.
@@ -1132,30 +1119,20 @@ static void *
 sba_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		   gfp_t flags, unsigned long attrs)
 {
+	struct page *page;
 	struct ioc *ioc;
 	void *addr;
 
 	ioc = GET_IOC(dev);
 	ASSERT(ioc);
 
-#ifdef CONFIG_NUMA
-	{
-		struct page *page;
-
-		page = alloc_pages_node(ioc->node, flags, get_order(size));
-		if (unlikely(!page))
-			return NULL;
-
-		addr = page_address(page);
-	}
-#else
-	addr = (void *) __get_free_pages(flags, get_order(size));
-#endif
-	if (unlikely(!addr))
+	page = alloc_pages(ioc->node, get_order(size));
+	if (unlikely(!page))
 		return NULL;
 
+	addr = page_address(page);
 	memset(addr, 0, size);
-	*dma_handle = virt_to_phys(addr);
+	*dma_handle = page_to_phys(page);
 
 #ifdef ALLOW_IOV_BYPASS
 	ASSERT(dev->coherent_dma_mask);
@@ -1174,9 +1151,10 @@ sba_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	 * If device can't bypass or bypass is disabled, pass the 32bit fake
 	 * device to map single to get an iova mapping.
 	 */
-	*dma_handle = sba_map_single_attrs(&ioc->sac_only_dev->dev, addr,
-					   size, 0, 0);
-
+	*dma_handle = sba_map_page(&ioc->sac_only_dev->dev, page, 0, size,
+			DMA_BIDIRECTIONAL, 0);
+	if (dma_mapping_error(dev, *dma_handle))
+		return NULL;
 	return addr;
 }
 
@@ -1193,7 +1171,7 @@ sba_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
 static void sba_free_coherent(struct device *dev, size_t size, void *vaddr,
 			      dma_addr_t dma_handle, unsigned long attrs)
 {
-	sba_unmap_single_attrs(dev, dma_handle, size, 0, 0);
+	sba_unmap_page(dev, dma_handle, size, 0, 0);
 	free_pages((unsigned long) vaddr, get_order(size));
 }
 
@@ -1483,7 +1461,10 @@ static int sba_map_sg_attrs(struct device *dev, struct scatterlist *sglist,
 	/* Fast path single entry scatterlists. */
 	if (nents == 1) {
 		sglist->dma_length = sglist->length;
-		sglist->dma_address = sba_map_single_attrs(dev, sba_sg_address(sglist), sglist->length, dir, attrs);
+		sglist->dma_address = sba_map_page(dev, sg_page(sglist),
+				sglist->offset, sglist->length, dir, attrs);
+		if (dma_mapping_error(dev, sglist->dma_address))
+			return 0;
 		return 1;
 	}
 
@@ -1572,8 +1553,8 @@ static void sba_unmap_sg_attrs(struct device *dev, struct scatterlist *sglist,
 
 	while (nents && sglist->dma_length) {
 
-		sba_unmap_single_attrs(dev, sglist->dma_address,
-				       sglist->dma_length, dir, attrs);
+		sba_unmap_page(dev, sglist->dma_address, sglist->dma_length,
+			       dir, attrs);
 		sglist = sg_next(sglist);
 		nents--;
 	}
-- 
2.19.1

