Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1307FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99E520684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WFTGG4iX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99E520684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437157AbeKWAn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:43:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57516 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391646AbeKWAn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ddSc0GEXTciULelNE8dEV/Abh7889SvikaXoFrcrdpo=; b=WFTGG4iXQnXhmYXV0fS89aw1Ji
        wpoi3FyQfZERrWk5YYIAohdZfj6iZlI7ZmcRs2z+bfgnIsvTcv/T/d4m56ORGKsDoXCWoT4BgAIXr
        VoKZ+5cttlWu7z6szNWL2ksWAoB6cnvwe95PuA+y6blxOlJLFGSkQ132y/KD4cLCOPzbgnGjdA8FA
        V76OZCUOOxHgteuZ/E1vbCUJLthECQ18brpUP2VFP4amEbZY+aDbi/BR8R9esy9TXPm5DRIttuGkz
        +ipXstlftvFU32dkoRwpm8iLMosgAANejBoaWrVjVBfp170QATBBQsbY/7vIgXH1UVBiZTwj4k4ff
        t9GmmgbA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPpa5-0007w1-7s; Thu, 22 Nov 2018 14:03:45 +0000
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
Subject: [PATCH 07/24] mips/jazz: remove the mapping_error dma_map_ops method
Date:   Thu, 22 Nov 2018 15:03:03 +0100
Message-Id: <20181122140320.24080-8-hch@lst.de>
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

The Jazz iommu code already returns (~(dma_addr_t)0x0) on mapping
failures, so we can switch over to returning DMA_MAPPING_ERROR and
let the core dma-mapping code handle the rest.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/include/asm/jazzdma.h |  6 ------
 arch/mips/jazz/jazzdma.c        | 16 +++++-----------
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/jazzdma.h b/arch/mips/include/asm/jazzdma.h
index d913439c738c..d13f940022d5 100644
--- a/arch/mips/include/asm/jazzdma.h
+++ b/arch/mips/include/asm/jazzdma.h
@@ -39,12 +39,6 @@ extern int vdma_get_enable(int channel);
 #define VDMA_PAGE(a)		((unsigned int)(a) >> 12)
 #define VDMA_OFFSET(a)		((unsigned int)(a) & (VDMA_PAGESIZE-1))
 
-/*
- * error code returned by vdma_alloc()
- * (See also arch/mips/kernel/jazzdma.c)
- */
-#define VDMA_ERROR		0xffffffff
-
 /*
  * VDMA pagetable entry description
  */
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index 4c41ed0a637e..6256d35dbf4d 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -104,12 +104,12 @@ unsigned long vdma_alloc(unsigned long paddr, unsigned long size)
 		if (vdma_debug)
 			printk("vdma_alloc: Invalid physical address: %08lx\n",
 			       paddr);
-		return VDMA_ERROR;	/* invalid physical address */
+		return DMA_MAPPING_ERROR;	/* invalid physical address */
 	}
 	if (size > 0x400000 || size == 0) {
 		if (vdma_debug)
 			printk("vdma_alloc: Invalid size: %08lx\n", size);
-		return VDMA_ERROR;	/* invalid physical address */
+		return DMA_MAPPING_ERROR;	/* invalid physical address */
 	}
 
 	spin_lock_irqsave(&vdma_lock, flags);
@@ -123,7 +123,7 @@ unsigned long vdma_alloc(unsigned long paddr, unsigned long size)
 		       first < VDMA_PGTBL_ENTRIES) first++;
 		if (first + pages > VDMA_PGTBL_ENTRIES) {	/* nothing free */
 			spin_unlock_irqrestore(&vdma_lock, flags);
-			return VDMA_ERROR;
+			return DMA_MAPPING_ERROR;
 		}
 
 		last = first + 1;
@@ -569,7 +569,7 @@ static void *jazz_dma_alloc(struct device *dev, size_t size,
 		return NULL;
 
 	*dma_handle = vdma_alloc(virt_to_phys(ret), size);
-	if (*dma_handle == VDMA_ERROR) {
+	if (*dma_handle == DMA_MAPPING_ERROR) {
 		dma_direct_free_pages(dev, size, ret, *dma_handle, attrs);
 		return NULL;
 	}
@@ -620,7 +620,7 @@ static int jazz_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 			arch_sync_dma_for_device(dev, sg_phys(sg), sg->length,
 				dir);
 		sg->dma_address = vdma_alloc(sg_phys(sg), sg->length);
-		if (sg->dma_address == VDMA_ERROR)
+		if (sg->dma_address == DMA_MAPPING_ERROR)
 			return 0;
 		sg_dma_len(sg) = sg->length;
 	}
@@ -674,11 +674,6 @@ static void jazz_dma_sync_sg_for_cpu(struct device *dev,
 		arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
 }
 
-static int jazz_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return dma_addr == VDMA_ERROR;
-}
-
 const struct dma_map_ops jazz_dma_ops = {
 	.alloc			= jazz_dma_alloc,
 	.free			= jazz_dma_free,
@@ -692,6 +687,5 @@ const struct dma_map_ops jazz_dma_ops = {
 	.sync_sg_for_device	= jazz_dma_sync_sg_for_device,
 	.dma_supported		= dma_direct_supported,
 	.cache_sync		= arch_dma_cache_sync,
-	.mapping_error		= jazz_dma_mapping_error,
 };
 EXPORT_SYMBOL(jazz_dma_ops);
-- 
2.19.1

