Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98F5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D79E20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Wda/JaLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D79E20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbeGXLQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:16:25 -0400
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:40133 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388251AbeGXLQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:16:25 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 22B9A10C0D61;
        Tue, 24 Jul 2018 03:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1532427042; bh=7JLQXvWOCbq90isblzh8XlINfMmrqevVjHleMR4MpU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wda/JaLyGAAyh76u6lx/FKzfkA80S/nMK3P6nboj4k6JAINhphi9eNzEtAKqU5ryR
         OcbPjsMEtyWGqDc7YDsBGkV/TozyTNdgYvHYPXnuZatR3Ny9juIn612eknma/ctpU2
         Wg/yEDCT/UDEYdIXbsv0FT91raNxmLKF1r/ZjDcVb9B5AZMuA9wOcprIp9k+DJGfP/
         Q/J55vAFeTcbsuABT02Jb9SZLBhDPfhxIbhm1IPq4vKja6dOIeOj7p6GfaJgQ4cxSw
         ycPFkW/OHfPLWUJlJizWlZi+LME6QzCKMyOxmVF2Jn2AI/qBI77UX+hR/XOi5C3FRx
         LyG/epk4N2KRA==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.86])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4DFA03364;
        Tue, 24 Jul 2018 03:10:40 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 3/4] ARC: refactor arch/arc/mm/dma.c
Date:   Tue, 24 Jul 2018 13:10:00 +0300
Message-Id: <20180724101001.31965-4-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com>
References: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactoring, no functional change intended.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/mm/dma.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
index b693818cd8e5..46584c7c2858 100644
--- a/arch/arc/mm/dma.c
+++ b/arch/arc/mm/dma.c
@@ -27,30 +27,24 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	struct page *page;
 	phys_addr_t paddr;
 	void *kvaddr;
-	int need_coh = 1, need_kvaddr = 0;
+	bool need_coh = !(attrs & DMA_ATTR_NON_CONSISTENT);
 
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
+	 * - A coherent buffer needs MMU mapping to enforce non-cachability
+	 * - A highmem page needs a virtual handle (hence MMU mapping)
+	 *   independent of cachability.
+	 * kvaddr is kernel Virtual address (0x7000_0000 based)
+	 */
+	if (PageHighMem(page) || need_coh) {
 		kvaddr = ioremap_nocache(paddr, size);
 		if (kvaddr == NULL) {
 			__free_pages(page, order);
@@ -81,11 +75,9 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 {
 	phys_addr_t paddr = dma_handle;
 	struct page *page = virt_to_page(paddr);
-	int is_non_coh = 1;
-
-	is_non_coh = (attrs & DMA_ATTR_NON_CONSISTENT);
+	bool is_coh = !(attrs & DMA_ATTR_NON_CONSISTENT);
 
-	if (PageHighMem(page) || !is_non_coh)
+	if (PageHighMem(page) || is_coh)
 		iounmap((void __force __iomem *)vaddr);
 
 	__free_pages(page, get_order(size));
-- 
2.14.4

