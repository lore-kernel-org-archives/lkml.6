Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B07DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F6B216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H9f8VtHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F6B216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbeI1E6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:58:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56730 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbeI1E6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MlBySUpchmz0WGM63O2g0JBp+NwC06W2THLy9NIvxm4=; b=H9f8VtHEeChNNYGEFbDRhVocms
        psNJrcBwnW9z7I81koVpaQC44UBWAw9Aw/AbC8aihb6KM5eJp8GR+J4/dDGAy6PLRyfy8NVjImomM
        rMh06QLzbeXExdWi7BB97aqq770OfQsnp0kkb2LlyXOIWWIC+/80Hg1rwvj0aFwWoTYNV/hK6NwrQ
        X9HtXKcRkNr8onJpzNhBvGhiyJkDnxsXo4EgTsQ0iZw+X34ypH4NqWnC09QyhbDHN7eJZY007ASd6
        i2aWOSJd/bnuxC0TD+eyVHGj/ZK6iugnPdh7TsC6xFBxbCscNbTeqEGbT6JV9HfG7y35FjWlMHaT/
        Ro8QGJmw==;
Received: from [199.255.44.5] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5eus-00033e-DZ; Thu, 27 Sep 2018 22:38:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal memory size
Date:   Thu, 27 Sep 2018 15:35:39 -0700
Message-Id: <20180927223539.28449-6-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927223539.28449-1-hch@lst.de>
References: <20180927223539.28449-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This way an architecture with less than 4G of RAM can support dma_mask
smaller than 32-bit without a ZONE_DMA.  Apparently that is a common
case on powerpc.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/dma/direct.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 60c433b880e0..170bd322a94a 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -284,21 +284,25 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	return nents;
 }
 
+/*
+ * Because 32-bit DMA masks are so common we expect every architecture to be
+ * able to satisfy them - either by not supporting more physical memory, or by
+ * providing a ZONE_DMA32.  If neither is the case, the architecture needs to
+ * use an IOMMU instead of the direct mapping.
+ */
 int dma_direct_supported(struct device *dev, u64 mask)
 {
-#ifdef CONFIG_ZONE_DMA
-	if (mask < phys_to_dma(dev, DMA_BIT_MASK(ARCH_ZONE_DMA_BITS)))
-		return 0;
-#else
-	/*
-	 * Because 32-bit DMA masks are so common we expect every architecture
-	 * to be able to satisfy them - either by not supporting more physical
-	 * memory, or by providing a ZONE_DMA32.  If neither is the case, the
-	 * architecture needs to use an IOMMU instead of the direct mapping.
-	 */
-	if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
+	u64 min_mask;
+
+	if (IS_ENABLED(CONFIG_ZONE_DMA))
+		min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
+	else
+		min_mask = DMA_BIT_MASK(32);
+
+	min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
+
+	if (mask >= phys_to_dma(dev, min_mask))
 		return 0;
-#endif
 	return 1;
 }
 
-- 
2.19.0

