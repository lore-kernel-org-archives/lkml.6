Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DEAC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C00C217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfBFHH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 02:07:27 -0500
Received: from verein.lst.de ([213.95.11.211]:58234 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfBFHH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 02:07:27 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4CAC07F11E; Wed,  6 Feb 2019 08:07:26 +0100 (CET)
Date:   Wed, 6 Feb 2019 08:07:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        robin.murphy@arm.com, vdumpa@nvidia.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma-direct: do not allocate a single page from CMA
 area
Message-ID: <20190206070726.GE23392@lst.de>
References: <20190115215140.1545-1-nicoleotsuka@gmail.com> <20190204082307.GA5916@lst.de> <20190205230514.GA21515@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205230514.GA21515@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 03:05:30PM -0800, Nicolin Chen wrote:
> > And my other concern is that this skips allocating from the per-device
> > pool, which drivers might rely on.
> 
> Actually Robin had the same concern at v1 and suggested that we could
> always use DMA_ATTR_FORCE_CONTIGUOUS to enforce into per-device pool.

That is both against the documented behavior of DMA_ATTR_FORCE_CONTIGUOUS
and doesn't help existing drivers that specify their CMA area in DT.

> > To be honest I'm not sure there is
> > much of a point in the per-device CMA pool vs the traditional per-device
> > coherent pool, but I'd rather change that behavior in a clearly documented
> > commit with intentions rather as a side effect from a random optimization.
> 
> Hmm..sorry, I don't really follow this suggestion. Is it possible for
> you to make it clear that what should I do for the change?

Something like this (plus proper comments):

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index b2a87905846d..789d734f0f77 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -192,10 +192,19 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
 struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
 				       unsigned int align, bool no_warn)
 {
+	struct cma *cma;
+
 	if (align > CONFIG_CMA_ALIGNMENT)
 		align = CONFIG_CMA_ALIGNMENT;
 
-	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
+	if (dev && dev->cma_area)
+		cma = dev->cma_area;
+	else if (count > PAGE_SIZE)
+		cma = dma_contiguous_default_area;
+	else
+		return NULL;
+
+	return cma_alloc(cma, count, align, no_warn);
 }
 
 /**
