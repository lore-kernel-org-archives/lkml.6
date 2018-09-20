Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690B9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5DC214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WJgezo4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5DC214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388269AbeIUAhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:37:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36816 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeIUAhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UHrcQ0vOu7EYUULQWJ6Y6B0FUWI2kb1ITfZBIKThr0s=; b=WJgezo4jz4EoKdjau6Cx5OY0C
        qV9CGRjDhgQVBsLb/N4FkMcc1z4TaY85U/sICObtjsdKOJ+BzO8elg+WyV59mWJ4MFsCX1WLlvdjC
        XLcawJXTV+h7mfQcjEyLgiqWwYY4fCtcsEKmvC/6dAiheBM6hPJJyFwLNxqvQ993LmVqT9n4qLBAL
        gzPt/W0YAtQgR3COjaoymPer0XDGbLkcpFSdNVvNOURJPLrwqN9RIsQhKz+Pkvjl6baepiKPoTgXk
        trrifGJwZeofUgmwx9kNtvBoOWU3fZn/y7Ib0awfkeaWDXWtylCep0b3pHvAo13a9auCx5aQKRazQ
        THTRcYo6g==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g344Q-0001kr-B1; Thu, 20 Sep 2018 18:52:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] dma-direct: add an explicit dma_direct_get_required_mask
Date:   Thu, 20 Sep 2018 20:52:44 +0200
Message-Id: <20180920185247.20037-3-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920185247.20037-1-hch@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is somewhat modelled after the powerpc version, and differs from
the legacy fallback in use fls64 instead of pointlessly splitting up the
address into low and high dwords and in that it takes (__)phys_to_dma
into account.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-direct.h |  1 +
 kernel/dma/direct.c        | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 86a59ba5a7f3..b79496d8c75b 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -55,6 +55,7 @@ static inline void dma_mark_clean(void *addr, size_t size)
 }
 #endif /* CONFIG_ARCH_HAS_DMA_MARK_CLEAN */
 
+u64 dma_direct_get_required_mask(struct device *dev);
 void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index c954f0a6dc62..81b73a5bba54 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -53,11 +53,25 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
 	return true;
 }
 
+static inline dma_addr_t phys_to_dma_direct(struct device *dev,
+		phys_addr_t phys)
+{
+	if (force_dma_unencrypted())
+		return __phys_to_dma(dev, phys);
+	return phys_to_dma(dev, phys);
+}
+
+u64 dma_direct_get_required_mask(struct device *dev)
+{
+	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
+
+	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
+}
+
 static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
-	dma_addr_t addr = force_dma_unencrypted() ?
-		__phys_to_dma(dev, phys) : phys_to_dma(dev, phys);
-	return addr + size - 1 <= dev->coherent_dma_mask;
+	return phys_to_dma_direct(dev, phys) + size - 1 <=
+			dev->coherent_dma_mask;
 }
 
 void *dma_direct_alloc_pages(struct device *dev, size_t size,
@@ -296,6 +310,7 @@ const struct dma_map_ops dma_direct_ops = {
 	.unmap_page		= dma_direct_unmap_page,
 	.unmap_sg		= dma_direct_unmap_sg,
 #endif
+	.get_required_mask	= dma_direct_get_required_mask,
 	.dma_supported		= dma_direct_supported,
 	.mapping_error		= dma_direct_mapping_error,
 	.cache_sync		= arch_dma_cache_sync,
-- 
2.18.0

