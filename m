Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D52FC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACC52186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kYsZtQKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfBLH03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:26:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbfBLH0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CIKvEsqambALdGutoiZPpIA5EvIUo191MZXIgS3IRFo=; b=kYsZtQKjUl+JD4bQwJANIMkDUK
        RaXAk5G5Xh1wh73S7rs3zE5uJjDx1ilGh8hwKPzoTMG/fmDjw1rxaH2L5vC0SJC8CnjE0nJDmBxzi
        +k+bI3jEiIrlsi9y/Rq36eTJHr5ils0k2HL/nm9sdxGG9TwEwFd1RrrdRPyTt45MkPc9ffv/VHvew
        Rj5BvSCnhGmQI7L+TxkKFcK+TDKxlUPvOc4AK9TV/LqYdvyEzqUsmmKtuVQqms7h2E3KoaPR6RcFM
        uFttPgiAmvZJUPhekc3lCGXcE4nzDETSoRIWYNu5BBptr02NUkYCSj/XPM86otqNLEw2bBUvCMkRV
        Kxcqr1yQ==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gtSSG-0002vw-RH; Tue, 12 Feb 2019 07:26:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] dma-mapping: remove dma_max_pfn
Date:   Tue, 12 Feb 2019 08:25:28 +0100
Message-Id: <20190212072528.13167-15-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212072528.13167-1-hch@lst.de>
References: <20190212072528.13167-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These days the DMA mapping code must bounce buffer for any not supported
address, and if they driver needs to optimize for natively supported
ranged it should use dma_get_required_mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-mapping.h | 7 -------
 include/linux/dma-mapping.h        | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 31d3b96f0f4b..496b36b9a7ff 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -89,13 +89,6 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 }
 #endif
 
-/* The ARM override for dma_max_pfn() */
-static inline unsigned long dma_max_pfn(struct device *dev)
-{
-	return dma_to_pfn(dev, *dev->dma_mask);
-}
-#define dma_max_pfn(dev) dma_max_pfn(dev)
-
 #define arch_setup_dma_ops arch_setup_dma_ops
 extern void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			       const struct iommu_ops *iommu, bool coherent);
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f6ded992c183..c6dbc287e466 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -710,13 +710,6 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
 	return -EIO;
 }
 
-#ifndef dma_max_pfn
-static inline unsigned long dma_max_pfn(struct device *dev)
-{
-	return (*dev->dma_mask >> PAGE_SHIFT) + dev->dma_pfn_offset;
-}
-#endif
-
 static inline int dma_get_cache_alignment(void)
 {
 #ifdef ARCH_DMA_MINALIGN
-- 
2.20.1

