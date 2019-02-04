Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7D0C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8DD214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfBDIXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:23:09 -0500
Received: from verein.lst.de ([213.95.11.211]:47454 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbfBDIXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:23:08 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7A0C668D93; Mon,  4 Feb 2019 09:23:07 +0100 (CET)
Date:   Mon, 4 Feb 2019 09:23:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
        vdumpa@nvidia.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dma-direct: do not allocate a single page from CMA
 area
Message-ID: <20190204082307.GA5916@lst.de>
References: <20190115215140.1545-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115215140.1545-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 01:51:40PM -0800, Nicolin Chen wrote:
> The addresses within a single page are always contiguous, so it's
> not so necessary to allocate one single page from CMA area. Since
> the CMA area has a limited predefined size of space, it might run
> out of space in some heavy use case, where there might be quite a
> lot CMA pages being allocated for single pages.
> 
> This patch tries to skip CMA allocations of single pages and lets
> them go through normal page allocations unless the allocation has
> a DMA_ATTR_FORCE_CONTIGUOUS attribute. This'd save some resources
> in the CMA area for further more CMA allocations, and it can also
> reduce CMA fragmentations resulted from trivial allocations.

That DMA_ATTR_FORCE_CONTIGUOUS flag does not make sense.  A single
page allocation is per defintion always contigous.

>  again:
> -	/* CMA can be used only in the context which permits sleeping */
> -	if (gfpflags_allow_blocking(gfp)) {
> +	/*
> +	 * CMA can be used only in the context which permits sleeping.
> +	 * Since addresses within one PAGE are always contiguous, skip
> +	 * CMA allocation for a single page to save CMA reserved space
> +	 * unless DMA_ATTR_FORCE_CONTIGUOUS is flagged.
> +	 */
> +	if (gfpflags_allow_blocking(gfp) &&
> +	    (count > 1 || attrs & DMA_ATTR_FORCE_CONTIGUOUS)) {

And my other concern is that this skips allocating from the per-device
pool, which drivers might rely on.  To be honest I'm not sure there is
much of a point in the per-device CMA pool vs the traditional per-device
coherent pool, but I'd rather change that behavior in a clearly documented
commit with intentions rather as a side effect from a random optimization.
