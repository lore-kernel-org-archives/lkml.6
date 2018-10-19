Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B131ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3E62086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 06:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3E62086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJSO5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 10:57:42 -0400
Received: from verein.lst.de ([213.95.11.211]:43608 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbeJSO5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 10:57:42 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7B12B68C76; Fri, 19 Oct 2018 08:52:58 +0200 (CEST)
Date:   Fri, 19 Oct 2018 08:52:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] swiotlb: refactor swiotlb_map_page
Message-ID: <20181019065258.GA29249@lst.de>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-8-hch@lst.de> <35016142-f06d-e424-5afe-6026b6d57eda@arm.com> <20181019003715.GI1251@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019003715.GI1251@char.us.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 08:37:15PM -0400, Konrad Rzeszutek Wilk wrote:
> > > +	if (!dma_capable(dev, dma_addr, size) ||
> > > +	    swiotlb_force == SWIOTLB_FORCE) {
> > > +		trace_swiotlb_bounced(dev, dma_addr, size, swiotlb_force);
> > > +		dma_addr = swiotlb_bounce_page(dev, &phys, size, dir, attrs);
> > > +	}
> > 
> > FWIW I prefer the inverse condition and early return of the original code
> > here, which also then allows a tail-call to swiotlb_bounce_page() (and saves
> > a couple of lines), but it's no biggie.
> > 
> > Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> 
> I agree with Robin - it certainly makes it easier to read.
> 
> With that small change:
> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

So I did this edit, and in this patch it does indeed look much cleaner.
But in patch 9 we introduce the cache maintainance, and have to invert
the condition again if we don't want a goto mess:

---
From e840ec23360788d54a8ebd2ebc7cd0f0ef8bdb01 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 19 Oct 2018 08:51:53 +0200
Subject: swiotlb: add support for non-coherent DMA

Handle architectures that are not cache coherent directly in the main
swiotlb code by calling arch_sync_dma_for_{device,cpu} in all the right
places from the various dma_map/unmap/sync methods when the device is
non-coherent.

Because swiotlb now uses dma_direct_alloc for the coherent allocation
that side is already taken care of by the dma-direct code calling into
arch_dma_{alloc,free} for devices that are non-coherent.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/swiotlb.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 1a01b0ac0a5e..ebecaf255ea2 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -21,6 +21,7 @@
 
 #include <linux/cache.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/mm.h>
 #include <linux/export.h>
 #include <linux/spinlock.h>
@@ -671,11 +672,17 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 	 * we can safely return the device addr and not worry about bounce
 	 * buffering it.
 	 */
-	if (dma_capable(dev, dev_addr, size) && swiotlb_force != SWIOTLB_FORCE)
-		return dev_addr;
+	if (!dma_capable(dev, dev_addr, size) ||
+	    swiotlb_force == SWIOTLB_FORCE) {
+		trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
+		dev_addr = swiotlb_bounce_page(dev, &phys, size, dir, attrs);
+	}
+
+	if (!dev_is_dma_coherent(dev) &&
+	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+		arch_sync_dma_for_device(dev, phys, size, dir);
 
-	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
-	return swiotlb_bounce_page(dev, &phys, size, dir, attrs);
+	return dev_addr;
 }
 
 /*
@@ -694,6 +701,10 @@ void swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
 
 	BUG_ON(dir == DMA_NONE);
 
+	if (!dev_is_dma_coherent(hwdev) &&
+	    (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+		arch_sync_dma_for_cpu(hwdev, paddr, size, dir);
+
 	if (is_swiotlb_buffer(paddr)) {
 		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
 		return;
@@ -730,15 +741,17 @@ swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
 
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
2.19.1

