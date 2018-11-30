Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11885C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F102080A
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 13:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r+qXhKzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F102080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbeLAAco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 19:32:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbeLAAcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 19:32:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d9JpAhPkajo8247Fbaz7IQ+E4cfLUOsbaKmSdSNZxls=; b=r+qXhKzsb0BlPxOwbIk651yQbo
        zq3uWS0yHaTQ6U6y0xF7L1kIu4amq/eyO6LMFlWHitAis44uTxvkhPbcRXBrDCkLxnioi2s0pkL9Z
        la3K9Y32qI2Pd0t5XDzHg642XnPZX1IrF/7D3qfPJkWcf22q32vfR0t2IDTjfO7axmiez6eTag2Mi
        nkd/2OzXe0Mq+IVgk/AnaPcbK8kUho5bFT41j06D9hqzw4N+DiVntM6cVHHEkJa6qMICHw6VG1EGH
        E1CKeMmrk+EhwPnjEbZcAIRFHXE1RqNI+IzK7dfqomQIzv8Vv/KQRx3CNx2N9x5oZDejQMu4R9Zcx
        M7tG2FGA==;
Received: from 089144206221.atnat0015.highway.bob.at ([89.144.206.221] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSilJ-0004V1-Aj; Fri, 30 Nov 2018 13:23:17 +0000
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
Subject: [PATCH 06/23] s390: remove the mapping_error dma_map_ops method
Date:   Fri, 30 Nov 2018 14:22:14 +0100
Message-Id: <20181130132231.16512-7-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181130132231.16512-1-hch@lst.de>
References: <20181130132231.16512-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

S390 already returns (~(dma_addr_t)0x0) on mapping failures, so we can
switch over to returning DMA_MAPPING_ERROR and let the core dma-mapping
code handle the rest.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/pci/pci_dma.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index d387a0fbdd7e..346ba382193a 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -15,8 +15,6 @@
 #include <linux/pci.h>
 #include <asm/pci_dma.h>
 
-#define S390_MAPPING_ERROR		(~(dma_addr_t) 0x0)
-
 static struct kmem_cache *dma_region_table_cache;
 static struct kmem_cache *dma_page_table_cache;
 static int s390_iommu_strict;
@@ -301,7 +299,7 @@ static dma_addr_t dma_alloc_address(struct device *dev, int size)
 
 out_error:
 	spin_unlock_irqrestore(&zdev->iommu_bitmap_lock, flags);
-	return S390_MAPPING_ERROR;
+	return DMA_MAPPING_ERROR;
 }
 
 static void dma_free_address(struct device *dev, dma_addr_t dma_addr, int size)
@@ -349,7 +347,7 @@ static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
 	/* This rounds up number of pages based on size and offset */
 	nr_pages = iommu_num_pages(pa, size, PAGE_SIZE);
 	dma_addr = dma_alloc_address(dev, nr_pages);
-	if (dma_addr == S390_MAPPING_ERROR) {
+	if (dma_addr == DMA_MAPPING_ERROR) {
 		ret = -ENOSPC;
 		goto out_err;
 	}
@@ -372,7 +370,7 @@ static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
 out_err:
 	zpci_err("map error:\n");
 	zpci_err_dma(ret, pa);
-	return S390_MAPPING_ERROR;
+	return DMA_MAPPING_ERROR;
 }
 
 static void s390_dma_unmap_pages(struct device *dev, dma_addr_t dma_addr,
@@ -449,7 +447,7 @@ static int __s390_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	int ret;
 
 	dma_addr_base = dma_alloc_address(dev, nr_pages);
-	if (dma_addr_base == S390_MAPPING_ERROR)
+	if (dma_addr_base == DMA_MAPPING_ERROR)
 		return -ENOMEM;
 
 	dma_addr = dma_addr_base;
@@ -496,7 +494,7 @@ static int s390_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	for (i = 1; i < nr_elements; i++) {
 		s = sg_next(s);
 
-		s->dma_address = S390_MAPPING_ERROR;
+		s->dma_address = DMA_MAPPING_ERROR;
 		s->dma_length = 0;
 
 		if (s->offset || (size & ~PAGE_MASK) ||
@@ -546,11 +544,6 @@ static void s390_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	}
 }
 	
-static int s390_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == S390_MAPPING_ERROR;
-}
-
 int zpci_dma_init_device(struct zpci_dev *zdev)
 {
 	int rc;
@@ -675,7 +668,6 @@ const struct dma_map_ops s390_pci_dma_ops = {
 	.unmap_sg	= s390_dma_unmap_sg,
 	.map_page	= s390_dma_map_pages,
 	.unmap_page	= s390_dma_unmap_pages,
-	.mapping_error	= s390_mapping_error,
 	/* dma_supported is unconditionally true without a callback */
 };
 EXPORT_SYMBOL_GPL(s390_pci_dma_ops);
-- 
2.19.1

