Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BA7C46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E2120819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EC9mYGM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E2120819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbeKEVjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:39:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeKEVjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6CZ8u2Hp6BszJscW6OKAY0pFx5HDYwXE3CfpN14wo7w=; b=EC9mYGM4U7MOgNIWhpuJr2gljA
        EN1yR9PngfOEjdUMJvpPTfdPwg4c0QsPeIJleGbGRmTuJSMKyH9Od8eDbCnwzSE9PsecxtztUxNvE
        VZBSgGt8z7o+SbqIK3n9PBmJ+4XYANqG6WfzIAtt03sbIl7F9XViV471HXwfAMbDnnXvqOMqSnX2b
        Y0OME3MeEhYK1riRoKrbVMAH+NTxt26W7666Tz3mV00xFloC0RgCHaKZPPPp9ud1gR7Wl5Qfb2ty5
        eNmhU0YtJYAJRJkCGhbgvKZF3KS9k7kn3qCM3ag+IcDoMiB4QVyJZknQjMpNCLny8dUtTmxDLGiYv
        AXlohccQ==;
Received: from 213-225-37-95.nat.highway.a1.net ([213.225.37.95] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJdrB-0003ZI-Hq; Mon, 05 Nov 2018 12:19:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] dma-mapping: support highmem in the generic remap allocator
Date:   Mon,  5 Nov 2018 13:19:27 +0100
Message-Id: <20181105121931.13481-6-hch@lst.de>
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

By using __dma_direct_alloc_pages we can deal entirely with struct page
instead of having to derive a kernel virtual address.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/remap.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index bc42766f52df..8f1fca34b894 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -196,7 +196,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flags, unsigned long attrs)
 {
 	struct page *page = NULL;
-	void *ret, *kaddr;
+	void *ret;
 
 	size = PAGE_ALIGN(size);
 
@@ -208,10 +208,9 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		return ret;
 	}
 
-	kaddr = dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
-	if (!kaddr)
+	page = __dma_direct_alloc_pages(dev, size, dma_handle, flags, attrs);
+	if (!page)
 		return NULL;
-	page = virt_to_page(kaddr);
 
 	/* remove any dirty cache lines on the kernel alias */
 	arch_dma_prep_coherent(page, size);
@@ -221,7 +220,7 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 			arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
 			__builtin_return_address(0));
 	if (!ret)
-		dma_direct_free_pages(dev, size, kaddr, *dma_handle, attrs);
+		__dma_direct_free_pages(dev, size, page);
 	return ret;
 }
 
@@ -229,10 +228,11 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
 	if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
-		void *kaddr = phys_to_virt(dma_to_phys(dev, dma_handle));
+		phys_addr_t phys = dma_to_phys(dev, dma_handle);
+		struct page *page = pfn_to_page(__phys_to_pfn(phys));
 
 		vunmap(vaddr);
-		dma_direct_free_pages(dev, size, kaddr, dma_handle, attrs);
+		__dma_direct_free_pages(dev, size, page);
 	}
 }
 
-- 
2.19.1

