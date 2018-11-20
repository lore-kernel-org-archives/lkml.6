Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756CBC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F14F2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F14F2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeKTTsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:48:18 -0500
Received: from verein.lst.de ([213.95.11.211]:43936 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbeKTTsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:48:18 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id F18C568B02; Tue, 20 Nov 2018 10:20:10 +0100 (CET)
Date:   Tue, 20 Nov 2018 10:20:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        vdumpa@nvidia.com
Subject: Re: [PATCH RFC] dma-direct: do not allocate a single page from CMA
 area
Message-ID: <20181120092010.GA7270@lst.de>
References: <20181031200355.19945-1-nicoleotsuka@gmail.com> <13d60076-33ad-b542-4d17-4d717d5aa4d3@arm.com> <20181102063542.GA17073@lst.de> <20181105224050.GA10411@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105224050.GA10411@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 02:40:51PM -0800, Nicolin Chen wrote:
> > > In general, this seems to make sense to me. It does represent a theoretical 
> > > change in behaviour for devices which have their own CMA area somewhere 
> > > other than kernel memory, and only ever make non-atomic allocations, but 
> > > I'm not sure whether that's a realistic or common enough case to really 
> > > worry about.
> > 
> > Yes, I think we should make the decision in dma_alloc_from_contiguous
> > based on having a per-dev CMA area or not.  There is a lot of cruft in
> 
> It seems that cma_alloc() already has a CMA area check? Would it
> be duplicated to have a similar one in dma_alloc_from_contiguous?

It isn't duplicate if it serves a different purpose.

> > this area that should be cleaned up while we're at it, like always
> > falling back to the normal page allocator if there is no CMA area or
> > nothing suitable found in dma_alloc_from_contiguous instead of
> > having to duplicate all that in the caller.
> 
> Am I supposed to clean up things that's mentioned above by moving
> the fallback allocator into dma_alloc_from_contiguous, or to just
> move my change (the count check) into dma_alloc_from_contiguous?
> 
> I understand that'd be great to have a cleanup, yet feel it could
> be done separately as this patch isn't really a cleanup change.

I can take care of any cleanups.  I've been trying to dust up that
area anyway.
