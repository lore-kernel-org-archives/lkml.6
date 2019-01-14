Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18974C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D642120870
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FnlH5iCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfANJm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:42:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43746 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfANJmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:42:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eQgrSQynQ3QcHAssdtwa/itH2smDnNtOJYA3dhn/YFQ=; b=FnlH5iCu5h6IxFn7E6pCLSUVpp
        4RgDceHwMYagDGzAYGPxuYqgizePaAjL6fiP9/tix0OOeubOV72AybjeoA1t71ZcW/ScGRxvJBPMW
        GcjZg8xVFROEKJ5KRQvs9SeYsGPllIZZ5zGUJQgnezM50g8K5qYvpU7hhuyyKAHKeJjcmvfm7rIsw
        4pBB7R5YGLKkaaGXmYBBArrGMbc/aTeLZoJJYBPG5UnZvb+dKDrC1U/0SJTiNrHZYvGptt2jERh2S
        l4Vn0tXCF+3kNZ8y+aTP7utFj2/p51FW14RlGH/Mn2D5CRS7kkl+DuyV9291D3ESQKihhYPMnYLhP
        OyTk0GFQ==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giylc-0006kB-Eh; Mon, 14 Jan 2019 09:42:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/19] dma-iommu: factor contiguous remapped allocations into helpers
Date:   Mon, 14 Jan 2019 10:41:54 +0100
Message-Id: <20190114094159.27326-15-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114094159.27326-1-hch@lst.de>
References: <20190114094159.27326-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the last remaning non-dispatch code out of iommu_dma_alloc,
preparing to refactor the allocation method selection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 48 +++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 710814a370b9..956cb218c6ba 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -667,6 +667,29 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
 	return NULL;
 }
 
+static void *iommu_dma_alloc_contiguous_remap(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
+	struct page *page;
+	void *addr;
+
+	addr = iommu_dma_alloc_contiguous(dev, size, dma_handle, gfp, attrs);
+	if (!addr)
+		return NULL;
+
+	page = virt_to_page(addr);
+	addr = dma_common_contiguous_remap(page, PAGE_ALIGN(size), VM_USERMAP,
+			prot, __builtin_return_address(0));
+	if (!addr)
+		goto out_free;
+	arch_dma_prep_coherent(page, size);
+	return addr;
+out_free:
+	iommu_dma_free_contiguous(dev, size, page, *dma_handle);
+	return NULL;
+}
+
 /**
  * iommu_dma_mmap_remap - Map a remapped page array into provided user VMA
  * @cpu_addr: virtual address of the memory to be remapped
@@ -1016,8 +1039,6 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 	size_t iosize = size;
 	void *addr;
 
-	size = PAGE_ALIGN(size);
-
 	/*
 	 * Some drivers rely on this, and we probably don't want the
 	 * possibility of stale kernel data being read by devices anyway.
@@ -1036,23 +1057,12 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 		return iommu_dma_alloc_contiguous(dev, iosize, handle, gfp,
 				attrs);
 	} else if (attrs & DMA_ATTR_FORCE_CONTIGUOUS) {
-		pgprot_t prot = arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs);
-		struct page *page;
-
-		addr = iommu_dma_alloc_contiguous(dev, iosize, handle, gfp,
-				attrs);
-		if (coherent || !addr)
-			return addr;
-
-		page = virt_to_page(addr);
-		addr = dma_common_contiguous_remap(page, size, VM_USERMAP, prot,
-				__builtin_return_address(0));
-		if (!addr) {
-			iommu_dma_free_contiguous(dev, iosize, page, *handle);
-			return NULL;
-		}
-
-		arch_dma_prep_coherent(page, iosize);
+		if (coherent)
+			addr = iommu_dma_alloc_contiguous(dev, iosize, handle,
+					gfp, attrs);
+		else
+			addr = iommu_dma_alloc_contiguous_remap(dev, iosize,
+					handle, gfp, attrs);
 	} else {
 		addr = iommu_dma_alloc_remap(dev, iosize, handle, gfp, attrs);
 	}
-- 
2.20.1

