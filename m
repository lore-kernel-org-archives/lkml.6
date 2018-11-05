Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA88C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA88520819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YvZFw/zS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA88520819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbeKEVjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:39:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeKEVjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d4McgTckpWhV6ILQUNWqr0DpsukYNOWnupHnTZO3Q1Y=; b=YvZFw/zSxNQYNeBPEjlLF6BgO3
        RX6kpUdt6j24cM3h2nkrexoDOeH6G4WY+Bvm+/Glr4ThasP49NINGjgla5yotStbFsQk9fljVXjPA
        WnuzDqqv6APXd9+Hd4CwWiVX4GmZqSnnpK7uQGY0mdycHVLqkBfcG0MaXY2kSwVadCbNlPwFo/JBT
        PQSezbEcdBwar5k3LU8m4kc6+rmg5fbcz7DvtHfZmaphGCNl5p8uJP16+lfhfHngjX8Hp9lyCz/0d
        ImcwHKEvzB2WM1gz4d3uwjd0dS1LrCN/trLQg/l20fi4LY1HYjREzhJR5Nwg3nPkzNjbQUvzI6zSW
        IJl6BAsA==;
Received: from 213-225-37-95.nat.highway.a1.net ([213.225.37.95] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJdr2-0003KW-Qk; Mon, 05 Nov 2018 12:19:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Guo Ren <ren_guo@c-sky.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] dma-direct: reject highmem pages from dma_alloc_from_contiguous
Date:   Mon,  5 Nov 2018 13:19:24 +0100
Message-Id: <20181105121931.13481-3-hch@lst.de>
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

dma_alloc_from_contiguous can return highmem pages depending on the
setup, which a plain non-remapping DMA allocator can't handle.  Detect
this case and try the normal page allocator instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 680287779b0a..c49849bcced6 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -162,6 +162,18 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
+	if (PageHighMem(page)) {
+		/*
+		 * Depending on the cma= arguments and per-arch setup
+		 * dma_alloc_from_contiguous could return highmem pages.
+		 * Without remapping there is no way to return them here,
+		 * so log an error and fail.
+		 */
+		dev_info(dev, "Rejecting highmem page from CMA.\n");
+		__dma_direct_free_pages(dev, size, page);
+		return NULL;
+	}
+
 	ret = page_address(page);
 	if (force_dma_unencrypted()) {
 		set_memory_decrypted((unsigned long)ret, 1 << get_order(size));
-- 
2.19.1

