Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA27C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93ECF2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fVooRxjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93ECF2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbeJBCtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:49:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeJBCtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gpJfkgtynyfTzWqSnZxf/m8M5D38vsOcfAqFCE1AVv0=; b=fVooRxjFVYe9SIWj59n1v6EkGt
        dSratgcbvm+1AHtGl9Q3K8WKmYCt/4VMo2Xrl0g7hiMD38+3ojNLwSImKxSd/VsqGE+FNNrSFBnUh
        xZ6vZUrSMIaL2Suv26gHI7O1AGkIqPeWWB4hJQYjKAKwTkRiW2xxIG6USMVjXOyNEnS0P+DxC/NZD
        i0DOHnp1MnTki678Z1YMZK0dM1boyVI293MthfoPnb11S5IaD/e7w3DqnQ99gmo6+TzqQoJJhncSI
        pAwNxymNMHdjVyslpWozKU0g7k8M4xanfm6yWTETy1ydXpG1bhhWtXXLz9hodBkUK5PsyRDR+7w3G
        4Yfb0Mpg==;
Received: from [38.126.112.138] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g74WI-0006Zo-GR; Mon, 01 Oct 2018 20:10:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dma-direct: document the zone selection logic
Date:   Mon,  1 Oct 2018 13:10:16 -0700
Message-Id: <20181001201016.32639-2-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001201016.32639-1-hch@lst.de>
References: <20181001201016.32639-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What we are doing here isn't quite obvious, so add a comment explaining
it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index ba6f5956a291..14b966e2349a 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -84,7 +84,14 @@ static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
 	else
 		*phys_mask = dma_to_phys(dev, dma_mask);
 
-	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
+	/*
+	 * Optimistically try the zone that the physicall address mask falls
+	 * into first.  If that returns memory that isn't actually addressable
+	 * we will fallback to the next lower zone and try again.
+	 *
+	 * Note that GFP_DMA32 and GFP_DMA are no ops without the corresponding
+	 * zones.
+	 */
 	if (*phys_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
 		return GFP_DMA;
 	if (*phys_mask <= DMA_BIT_MASK(32))
-- 
2.19.0

