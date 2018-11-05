Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE5EC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97DA20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UD+nTlIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97DA20819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbeKEVjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:39:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeKEVjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Swg4ga2b+JoWl4Ai2D+474TmSQL6g6gFWeOwcBB8yaE=; b=UD+nTlIH71KDUFCQZpCRDN+XIh
        yKJmGjycIKuAQ0YVbxyNc+jz6ac7ueA3tvtI47bvNuodaOe5bqAUDBFoJy/oLGbVddeUqp9ZKeZdb
        Jn/IGTXa9pL7aRhr5mVpfG2NFQ7LR5oSmXFrI77XB34y9zmGxy4TDPks1KkQ/4ITnq2xeHxjkt47V
        uvhIzyVXt8og1deboMCa3pIqtdbS0OXL7CwJ8m7nNgjTB4Gmne1ZOrXrSp8BEVdfAlFefy1xG78na
        14xhNzv1XekEQfWgfblClHGi3kYfse5kiHgo35jICgnaSOuW9ZeuJSfyhyKTJCbvXOBoagr2zOSol
        8O+tNzlg==;
Received: from 213-225-37-95.nat.highway.a1.net ([213.225.37.95] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJdr0-0003Hd-2J; Mon, 05 Nov 2018 12:19:38 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] dma-direct: provide page based alloc/free helpers
Date:   Mon,  5 Nov 2018 13:19:23 +0100
Message-Id: <20181105121931.13481-2-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105121931.13481-1-hch@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures support remapping highmem into DMA coherent
allocations.  To use the common code for them we need variants of
dma_direct_{alloc,free}_pages that do not use kernel virtual addresses.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-direct.h |  3 +++
 kernel/dma/direct.c        | 32 ++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index bd73e7a91410..5a7a3bbb912f 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -67,6 +67,9 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
 void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs);
+struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
+void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page);
 dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs);
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 22a12ab5a5e9..680287779b0a 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -103,14 +103,13 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 			min_not_zero(dev->coherent_dma_mask, dev->bus_dma_mask);
 }
 
-void *dma_direct_alloc_pages(struct device *dev, size_t size,
+struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	int page_order = get_order(size);
 	struct page *page = NULL;
 	u64 phys_mask;
-	void *ret;
 
 	if (attrs & DMA_ATTR_NO_WARN)
 		gfp |= __GFP_NOWARN;
@@ -150,11 +149,22 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 		}
 	}
 
+	return page;
+}
+
+void *dma_direct_alloc_pages(struct device *dev, size_t size,
+		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
+{
+	struct page *page;
+	void *ret;
+
+	page = __dma_direct_alloc_pages(dev, size, dma_handle, gfp, attrs);
 	if (!page)
 		return NULL;
+
 	ret = page_address(page);
 	if (force_dma_unencrypted()) {
-		set_memory_decrypted((unsigned long)ret, 1 << page_order);
+		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
 		*dma_handle = __phys_to_dma(dev, page_to_phys(page));
 	} else {
 		*dma_handle = phys_to_dma(dev, page_to_phys(page));
@@ -163,20 +173,22 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	return ret;
 }
 
-/*
- * NOTE: this function must never look at the dma_addr argument, because we want
- * to be able to use it as a helper for iommu implementations as well.
- */
+void __dma_direct_free_pages(struct device *dev, size_t size, struct page *page)
+{
+	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	if (!dma_release_from_contiguous(dev, page, count))
+		__free_pages(page, get_order(size));
+}
+
 void dma_direct_free_pages(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
-	unsigned int count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	unsigned int page_order = get_order(size);
 
 	if (force_dma_unencrypted())
 		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
-	if (!dma_release_from_contiguous(dev, virt_to_page(cpu_addr), count))
-		free_pages((unsigned long)cpu_addr, page_order);
+	__dma_direct_free_pages(dev, size, virt_to_page(cpu_addr));
 }
 
 void *dma_direct_alloc(struct device *dev, size_t size,
-- 
2.19.1

