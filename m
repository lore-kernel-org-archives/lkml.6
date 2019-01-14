Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968D9C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674F220660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RuUJggtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfANJ64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:58:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60484 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfANJ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CIKvEsqambALdGutoiZPpIA5EvIUo191MZXIgS3IRFo=; b=RuUJggtwRqEsqKAnpt5MuTXjKA
        m5NcC3xAcfuNhjQ19kbCa4w0c9HEf0IVHW5bI+cR0jCSzvBqAn+9jWSObxVGpIqvQMsThj97SdQEB
        Gq8N8xoYniyiaP1qbbvwl4yuL4BvU1L3MDl2Gdm4g2qPy5ziJKF8xhLGPQts0EAYnITh+3xD/fdqc
        lD7v9fjjr567xQ9WuJ/VPPecTLKJT4a+VsUrQ1AT3iMkjzYmFy+HDq4VENIV7tLZHq95CaTSiGHpN
        pNLBVdJZEmqYeoxKLsFZZINfZg1ZNqyopjc0cf2+wUYuwtby2WyRx3QWvd7RQCnP55nDrFobc8yI9
        YLhe/bqQ==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giz12-0002VI-Iv; Mon, 14 Jan 2019 09:58:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] dma-mapping: remove dma_max_pfn
Date:   Mon, 14 Jan 2019 10:58:04 +0100
Message-Id: <20190114095804.27978-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114095804.27978-1-hch@lst.de>
References: <20190114095804.27978-1-hch@lst.de>
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

