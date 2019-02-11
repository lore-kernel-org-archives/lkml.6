Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3381C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B634218F0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfBKQjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:39:39 -0500
Received: from verein.lst.de ([213.95.11.211]:58794 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbfBKQji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:39:38 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C033768DD6; Mon, 11 Feb 2019 17:39:36 +0100 (CET)
Date:   Mon, 11 Feb 2019 17:39:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/19] dma-iommu: don't depend on
 CONFIG_DMA_DIRECT_REMAP
Message-ID: <20190211163936.GA29978@lst.de>
References: <20190114094159.27326-1-hch@lst.de> <20190114094159.27326-17-hch@lst.de> <4698cdca-0e5b-c82f-bb80-3ba0f986c544@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4698cdca-0e5b-c82f-bb80-3ba0f986c544@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 11:55:49AM +0000, Robin Murphy wrote:
> On 14/01/2019 09:41, Christoph Hellwig wrote:
>> For entirely dma coherent architectures there is no good reason to ever
>> remap dma coherent allocation.
>
> Yes there is, namely assembling large buffers without the need for massive 
> CMA areas and compaction overhead under memory fragmentation. That has 
> always been a distinct concern from the DMA_DIRECT_REMAP cases; they've 
> just been able to share a fair few code paths.

Well, I guess I need to reword this - there is no _requirement_ to
remap.  And x86 has been happy to not remap so far and I see absolutely
no reason to force anyone to remap.

>>  Move all the remap and pool code under
>> CONFIG_DMA_DIRECT_REMAP ifdefs, and drop the Kconfig dependency.
>
> As far as I'm concerned that splits things the wrong way. Logically, 
> iommu_dma_alloc() should always have done its own vmap() instead of just 
> returning the bare pages array, but that was tricky to resolve with the 
> design of having the caller handle everything to do with coherency (forcing 
> the caller to unpick that mapping just to remap it yet again in the 
> noncoherent case didn't seem sensible).

I don't parse this.  In the old code base before this series
iommu_dma_alloc is a relatively low-level helper allocating and mapping
pages.  And that one should have done the remapping, and in fact does
so since ("dma-iommu: refactor page array remap helpers").  It just
happens that the function is now called iommu_dma_alloc_remap.

The new iommu_dma_alloc is the high level entry point that handles
every possible case of different allocations, including those where
we do not have a virtual mapping.
