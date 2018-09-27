Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D24C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806D9216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mfyIp7XR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806D9216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeI1E5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:57:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbeI1E5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=c4OSNKvB6ZHMxE3XSffoHNgluA3huF89BH1MYp0OMXw=; b=mfyIp7XREycB/8lIkEkAGpFihu
        +mkYx8DAli/lQdOj/QH81odzinnynpYbbm8l/TF5Bw8JvQJsBJ0M/IxeABdg19ucoOc4cH02QjGzj
        4XD6qPFG1AUETh/dlj9+NyajkrpWHmWKY4Xb2ccuhM7xGr/wE0qlVLzfrtEUcIx1JwQak8zIcb59w
        2BboWa1KUeky+EFfE7BN0JGSb9lCZu/TpbPYBRmwG2TE+T8HRh2x9yoLJ2RF2Lh0sdmmAdOiLdAru
        kz2XjVle5Mq1O34/FtBPcQ6f2YsRA1CKQ8dgYRk0JwhdYYrzw+7wGNEQWMdIL5rWZaWBs8XboAPDL
        MDtexmig==;
Received: from [199.255.44.5] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5etg-0002mK-So; Thu, 27 Sep 2018 22:36:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] dma-direct: add an explicit dma_direct_get_required_mask
Date:   Thu, 27 Sep 2018 15:35:36 -0700
Message-Id: <20180927223539.28449-3-hch@lst.de>
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

This is somewhat modelled after the powerpc version, and differs from
the legacy fallback in use fls64 instead of pointlessly splitting up the
address into low and high dwords and in that it takes (__)phys_to_dma
into account.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 include/linux/dma-direct.h |  1 +
 kernel/dma/direct.c        | 22 +++++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

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
index c954f0a6dc62..f32b33cfa331 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -4,6 +4,7 @@
  *
  * DMA operations that map physical memory directly without using an IOMMU.
  */
+#include <linux/bootmem.h> /* for max_pfn */
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/dma-direct.h>
@@ -53,11 +54,25 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
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
@@ -296,6 +311,7 @@ const struct dma_map_ops dma_direct_ops = {
 	.unmap_page		= dma_direct_unmap_page,
 	.unmap_sg		= dma_direct_unmap_sg,
 #endif
+	.get_required_mask	= dma_direct_get_required_mask,
 	.dma_supported		= dma_direct_supported,
 	.mapping_error		= dma_direct_mapping_error,
 	.cache_sync		= arch_dma_cache_sync,
-- 
2.19.0

