Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73A8C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A0421B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730848AbfBKQAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:00:53 -0500
Received: from verein.lst.de ([213.95.11.211]:58096 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729447AbfBKQAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:00:51 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 19EF668DD6; Mon, 11 Feb 2019 17:00:50 +0100 (CET)
Date:   Mon, 11 Feb 2019 17:00:49 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/19] dma-iommu: don't use a scatterlist in
 iommu_dma_alloc
Message-ID: <20190211160049.GB27745@lst.de>
References: <20190114094159.27326-1-hch@lst.de> <20190114094159.27326-4-hch@lst.de> <5145b2f7-6fc8-6ed9-4cf2-9b7e1d33b0fe@arm.com> <20190201161638.GJ6532@lst.de> <f59852aa-394c-3165-f7c0-fa6cdcea059f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f59852aa-394c-3165-f7c0-fa6cdcea059f@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 03:28:28PM +0000, Robin Murphy wrote:
> Because if iommu_map() only gets called at PAGE_SIZE granularity, then the 
> IOMMU PTEs will be created at PAGE_SIZE (or smaller) granularity, so any 
> effort to get higher-order allocations matching larger IOMMU block sizes is 
> wasted, and we may as well have just done this:
>
> 	for (i = 0; i < count; i++) {
> 		struct page *page = alloc_page(gfp);
> 		...
> 		iommu_map(..., page_to_phys(page), PAGE_SIZE, ...);
> 	}

True.  I've dropped this patch.

> Really, it's a shame we have to split huge pages for the CPU remap, since 
> in the common case the CPU MMU will have a matching block size, but IIRC 
> there was something in vmap() or thereabouts that explicitly chokes on 
> them.

That just needs a volunteer to fix the implementation, as there is no
fundamental reason not to remap large pages.
