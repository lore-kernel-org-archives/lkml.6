Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568A8FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C54520893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AaHMGxkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C54520893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbeG3SCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:02:36 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:40167 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeG3SCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:02:34 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2DCA410C05D8;
        Mon, 30 Jul 2018 09:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532968010; bh=EN6mNSpaRkYlyEL2gxhw9tIreBpXQzuMLKFgvRF6IAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AaHMGxkVccjcbQC34ngaxcpErVyk5CuuVD+SQ6sID6YUWSOE/VcqpGruKY5zXIyus
         Ci0cYuJjDpfX38pX63NQCKB9emrZ32qKckXzmCN/5cCD5PhAoSXUVUtwYjf4cCzlBl
         vk57PPTQd4JsjmeQaogcuD7Jmb4ynoflZLyhY1XJnDazTIQpk2HbmM7J9CmwNfsx7U
         esYdPoxm580RI3UwzWJu9P8fxc5Xv0tftw2NU42UVq8qbbdy/lqdy8SDXowEvWJUyA
         IqTfvfjIouYKidKEgbQzV7yfu/ribj1XWjCnGTMo6gKh2nHXuqSUiits0IImnHCNkN
         MLPzu9X1jm94w==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id 68EB23FCB;
        Mon, 30 Jul 2018 09:26:48 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2 4/4] ARC: don't check for HIGHMEM pages in arch_dma_alloc
Date:   Mon, 30 Jul 2018 19:26:36 +0300
Message-Id: <20180730162636.3556-5-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
References: <20180730162636.3556-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__GFP_HIGHMEM flag is cleared by upper layer functions
(in include/linux/dma-mapping.h) so we'll never get a
__GFP_HIGHMEM flag in arch_dma_alloc gfp argument.
That's why alloc_pages will never return highmem page
here.

Get rid of highmem pages handling and cleanup arch_dma_alloc
and arch_dma_free functions.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v1->v2 (Thanks to Christoph):
 * Remove check for HIGHMEM pages from arch_dma_{alloc, free}

 arch/arc/mm/dma.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index 4d1466905e48..46129d7a298d 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -27,30 +27,29 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	struct page *page;
 	phys_addr_t paddr;
 	void *kvaddr;
-	int need_coh = 1, need_kvaddr = 0;
+	bool need_coh = !(attrs & DMA_ATTR_NON_CONSISTENT);
+
+	/*
+	 * __GFP_HIGHMEM flag is cleared by upper layer functions
+	 * (in include/linux/dma-mapping.h) so we should never get a
+	 * __GFP_HIGHMEM here.
+	 */
+	BUG_ON(gfp & __GFP_HIGHMEM);
 
 	page = alloc_pages(gfp, order);
 	if (!page)
 		return NULL;
 
-	if (attrs & DMA_ATTR_NON_CONSISTENT)
-		need_coh = 0;
-
-	/*
-	 * - A coherent buffer needs MMU mapping to enforce non-cachability
-	 * - A highmem page needs a virtual handle (hence MMU mapping)
-	 *   independent of cachability
-	 */
-	if (PageHighMem(page) || need_coh)
-		need_kvaddr = 1;
-
 	/* This is linear addr (0x8000_0000 based) */
 	paddr = page_to_phys(page);
 
 	*dma_handle = paddr;
 
-	/* This is kernel Virtual address (0x7000_0000 based) */
-	if (need_kvaddr) {
+	/*
+	 * A coherent buffer needs MMU mapping to enforce non-cachability.
+	 * kvaddr is kernel Virtual address (0x7000_0000 based).
+	 */
+	if (need_coh) {
 		kvaddr = ioremap_nocache(paddr, size);
 		if (kvaddr == NULL) {
 			__free_pages(page, order);
@@ -81,11 +80,8 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 {
 	phys_addr_t paddr = dma_handle;
 	struct page *page = virt_to_page(paddr);
-	int is_non_coh = 1;
-
-	is_non_coh = (attrs & DMA_ATTR_NON_CONSISTENT);
 
-	if (PageHighMem(page) || !is_non_coh)
+	if (!(attrs & DMA_ATTR_NON_CONSISTENT))
 		iounmap((void __force __iomem *)vaddr);
 
 	__free_pages(page, get_order(size));
-- 
2.14.4

