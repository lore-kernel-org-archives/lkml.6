Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7596EC46475
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3865E20819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sSwVWIg7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3865E20819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbeKEVj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:39:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeKEVj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dHJev5ruQT89a3tvMNGOu1k6+5bwOUgwC2qREzrAI5U=; b=sSwVWIg7YnQrgJbbGKF8Gjb1mz
        Y90MwFiaVMCXI29NriTv0D9l/dLlNW7Rye58nhOjsCSMp3lbHm77DwaNvAg42DOWKBqeVNk/+UOzQ
        2bKEsFJe5L4Wdf/GAs3S+1+/NUhDolkFqFayeVlPpt9gPXk2MqubyyZIrXngBu9yvUqjL95RBDG0O
        cv7S/MqshJ5COAal4GvjefjnnkIZVTmsFAu4SRHVeQYzl3lp9zgLeDKjMLgLBPCNs9yKyD+dUIzaQ
        eAv6YyE3w9Ik2CzdzRIklRewm05Y83yHa0db7GW/KtZENVqpAYYVyUunFPbPY0zvqRfp/yAb17cgw
        IVUJz4RQ==;
Received: from 213-225-37-95.nat.highway.a1.net ([213.225.37.95] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJdrE-0003e4-BB; Mon, 05 Nov 2018 12:19:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] dma-remap: support DMA_ATTR_NO_KERNEL_MAPPING
Date:   Mon,  5 Nov 2018 13:19:28 +0100
Message-Id: <20181105121931.13481-7-hch@lst.de>
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

Do not waste vmalloc space on allocations that do not require a mapping
into the kernel address space.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/remap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 8f1fca34b894..10a545126b0b 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -200,7 +200,8 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 
 	size = PAGE_ALIGN(size);
 
-	if (!gfpflags_allow_blocking(flags)) {
+	if (!gfpflags_allow_blocking(flags) &&
+	    !(attrs & DMA_ATTR_NO_KERNEL_MAPPING)) {
 		ret = dma_alloc_from_pool(size, &page, flags);
 		if (!ret)
 			return NULL;
@@ -215,6 +216,9 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	/* remove any dirty cache lines on the kernel alias */
 	arch_dma_prep_coherent(page, size);
 
+	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
+		return page; /* opaqueue cookie */
+
 	/* create a coherent mapping */
 	ret = dma_common_contiguous_remap(page, size, VM_USERMAP,
 			arch_dma_mmap_pgprot(dev, PAGE_KERNEL, attrs),
@@ -227,7 +231,10 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
-	if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
+	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING) {
+		/* vaddr is a struct page cookie, not a kernel address */
+		__dma_direct_free_pages(dev, size, vaddr);
+	} else if (!dma_free_from_pool(vaddr, PAGE_ALIGN(size))) {
 		phys_addr_t phys = dma_to_phys(dev, dma_handle);
 		struct page *page = pfn_to_page(__phys_to_pfn(phys));
 
-- 
2.19.1

