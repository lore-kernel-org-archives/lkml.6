Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D27EC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C588D20878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 08:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uj6QQ2HA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C588D20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeJHPOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 11:14:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56628 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeJHPOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 11:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zXOrORcMUq+rxl5njDWs71ST2cIRH5pp8lv3zYmYiGs=; b=Uj6QQ2HAJ8oB8H4swSRYPdiZ7u
        QwUjk/yydWW2C98tM3BBNEdsBctI7YBQUmZ8Y/vdMm7mDSzSIjeelEI4UesSe+VDAsoLYM/KHo5us
        zbdJgAEhgVr16BMK4dP9iBenC/G2656jWlYo2UopEgf7tkilgDXITDzr6CHFDCWQopfD4y2FDdihs
        uzkk4opsx1Ms8NBZ8APiAd1NCBl3vSEl9UhbCd7tirvCvjAQd2WPhNiMIK7uYa7M7kZuhOB+mkupx
        sFYsiIW/Kw1hiaNZnVUuAeh870Gh1drrBP308vSccHPrDI4Kcdb0Ek+fz8R8nVh9uclX7vvGnhROR
        OFvohEEw==;
Received: from 089144207060.atnat0016.highway.bob.at ([89.144.207.60] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9QVh-0002OC-Aa; Mon, 08 Oct 2018 08:03:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] swiotlb: add support for non-coherent DMA
Date:   Mon,  8 Oct 2018 10:02:45 +0200
Message-Id: <20181008080246.20543-10-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008080246.20543-1-hch@lst.de>
References: <20181008080246.20543-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle architectures that are not cache coherent directly in the main
swiotlb code by calling arch_sync_dma_for_{device,cpu} in all the right
places from the various dma_map/unmap/sync methods when the device is
non-coherent.

Because swiotlb now uses dma_direct_alloc for the coherent allocation
that side is already taken care of by the dma-direct code calling into
arch_dma_{alloc,free} for devices that are non-coherent.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 475a41eff3dc..52885b274368 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -21,6 +21,7 @@
 
 #include <linux/cache.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/mm.h>
 #include <linux/export.h>
 #include <linux/spinlock.h>
@@ -677,6 +678,10 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 		dma_addr = swiotlb_bounce_page(dev, &phys, size, dir, attrs);
 	}
 
+	if (!dev_is_dma_coherent(dev) &&
+	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+		arch_sync_dma_for_device(dev, phys, size, dir);
+
 	return dma_addr;
 }
 
@@ -696,6 +701,10 @@ void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 
 	BUG_ON(dir == DMA_NONE);
 
+	if (!dev_is_dma_coherent(hwdev) &&
+	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+		arch_sync_dma_for_cpu(hwdev, paddr, size, dir);
+
 	if (is_swiotlb_buffer(paddr)) {
 		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
 		return;
@@ -732,15 +741,17 @@ swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
 
 	BUG_ON(dir == DMA_NONE);
 
-	if (is_swiotlb_buffer(paddr)) {
+	if (!dev_is_dma_coherent(hwdev) && target == SYNC_FOR_CPU)
+		arch_sync_dma_for_cpu(hwdev, paddr, size, dir);
+
+	if (is_swiotlb_buffer(paddr))
 		swiotlb_tbl_sync_single(hwdev, paddr, size, dir, target);
-		return;
-	}
 
-	if (dir != DMA_FROM_DEVICE)
-		return;
+	if (!dev_is_dma_coherent(hwdev) && target == SYNC_FOR_DEVICE)
+		arch_sync_dma_for_device(hwdev, paddr, size, dir);
 
-	dma_mark_clean(phys_to_virt(paddr), size);
+	if (!is_swiotlb_buffer(paddr) && dir == DMA_FROM_DEVICE)
+		dma_mark_clean(phys_to_virt(paddr), size);
 }
 
 void
-- 
2.19.0

