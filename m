Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4D4C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22532152A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QQgO6il9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F22532152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388340AbeIUAiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:38:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36876 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbeIUAiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PEMjccevc3KLUF8d1Q+gICy4TzsoHuAg7/eyEjFAyf4=; b=QQgO6il9GHPmXfL5abqDWx0Er
        Cf6BFGd1Cu3ppj44w62WVOikGlPWKxpF2TAZs/5mVXotBoBumsC2hHVHcRa2Afzl0UOd255SplfYR
        FFpAfb1FP+lM3o0nHGAT+94R6xGqOtb2yZcDqawMzqQGvP/aCLi1dmKnZlU0cZdXhSEh+r2Pr4k1d
        hh/U+T/C5eIp3gxL8wADvP1Tbv1rwD51e85sZAWek9OGj+FiZRTtmzLQziXRG58jLzCtYjVufoDH9
        c9xxJw8wOBR5GaoeJ2NNKzscNuGEzV/ia6TsDqssYX2FkiHWKc4JksgP1v7X4zQTZ1+yH9t/aXbjX
        MgfTa8vEA==;
Received: from 089144198037.atnat0007.highway.a1.net ([89.144.198.37] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g344Z-0001mR-BL; Thu, 20 Sep 2018 18:53:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal memory size
Date:   Thu, 20 Sep 2018 20:52:47 +0200
Message-Id: <20180920185247.20037-6-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180920185247.20037-1-hch@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This way an architecture with less than 4G of RAM can support dma_mask
smaller than 32-bit without a ZONE_DMA.  Apparently that is a common
case on powerpc.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 64466b7ef67b..d1e103c6b107 100644
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
@@ -283,21 +284,24 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
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
+		min_mask = min_t(u64, DMA_BIT_MASK(32),
+				 (max_pfn - 1) << PAGE_SHIFT);
+
+	if (mask >= phys_to_dma(dev, min_mask))
 		return 0;
-#endif
 	return 1;
 }
 
-- 
2.18.0

