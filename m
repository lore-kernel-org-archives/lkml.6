Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB51AC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4D72077C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 18:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QjY8vcG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4D72077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJOB4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 21:56:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbeJOB4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 21:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uC1HeLViRw8puCYIafO6+yTVfaTcl+eNlKtvW0jSAtQ=; b=QjY8vcG9b+Xqb0w+yd+4LNNrG
        BqmVJuhS83/o+jLIuswY1H+Z3rBEYh7CTZ2ALRBUwNf0XxO7GInNG/ulzQGtLbUT7iAix8NRMu9dd
        DwD2dAEuj4RHsHh6o/yAICe5KIHeyoBzqGskMamIKjY+VABAlw1BiTXp5OEmtZ2tStyYpIwQz1GK6
        byeMSXTQ4Vq+0LqlkZBNQ2rTP8pnlWiALnH/gF3IURwIGjW4uJJBoZ5c1Y7xQ+cGliv89GYUGXKk2
        QObdz4RoMEEwCy9S1NpfXRyzKQwmI1ZnBg6kUfm56FktcS2NybjWhS0aoFk/omYOyMarcjO8pU3T5
        OGPnJG2Ow==;
Received: from 089144199123.atnat0008.highway.a1.net ([89.144.199.123] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBkuf-0006Z6-Io; Sun, 14 Oct 2018 18:14:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dma-direct: reject highmem pages from dma_alloc_from_contiguous
Date:   Sun, 14 Oct 2018 20:14:47 +0200
Message-Id: <20181014181447.22783-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
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
index 87a6bc2a96c0..46fbaa49125b 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -126,6 +126,18 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (gfpflags_allow_blocking(gfp)) {
 		page = dma_alloc_from_contiguous(dev, count, page_order,
 						 gfp & __GFP_NOWARN);
+		if (page && PageHighMem(page)) {
+			/*
+			 * Depending on the cma= arguments and per-arch setup
+			 * dma_alloc_from_contiguous could return highmem
+			 * pages.  Without remapping there is no way to return
+			 * them here, so log an error and fail.
+			 */
+			dev_info(dev, "Ignoring highmem page from CMA.\n");
+			dma_release_from_contiguous(dev, page, count);
+			page = NULL;
+		}
+
 		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 			dma_release_from_contiguous(dev, page, count);
 			page = NULL;
-- 
2.19.1

