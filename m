Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83222C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6923D2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 18:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389925AbfAKSQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 13:16:32 -0500
Received: from verein.lst.de ([213.95.11.211]:57607 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfAKSQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 13:16:32 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C272568DD2; Fri, 11 Jan 2019 19:16:30 +0100 (CET)
Date:   Fri, 11 Jan 2019 19:16:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: remove dma_zalloc_coherent
Message-ID: <20190111181630.GA21720@lst.de>
References: <20190108130701.14161-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108130701.14161-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

any chance you could take this before -rc2?  That should avoid a lot
of churn going forward.  Any fine tuning of the memset-removal
cochinnelle scripts can be queued up with normal updates.

On Tue, Jan 08, 2019 at 08:06:58AM -0500, Christoph Hellwig wrote:
> Hi Linus and world,
> 
> We've always had a weird situation around dma_zalloc_coherent.  To
> safely support mapping the allocations to userspace major architectures
> like x86 and arm have always zeroed allocations from dma_alloc_coherent,
> but a couple other architectures were missing that zeroing either always
> or in corner cases.  Then later we grew anothe dma_zalloc_coherent
> interface to explicitly request zeroing, but that just added __GFP_ZERO
> to the allocation flags, which for some allocators that didn't end
> up using the page allocator ended up being a no-op and still not
> zeroing the allocations.
> 
> So for this merge window I fixed up all remaining architectures to zero
> the memory in dma_alloc_coherent, and made dma_zalloc_coherent a no-op
> wrapper around dma_alloc_coherent, which fixes all of the above issues.
> 
> dma_zalloc_coherent is now pointless and can go away, and Luis helped
> me writing a cocchinelle script and patch series to kill it, which I
> think we should apply now just after -rc1 to finally settle these
> issue.
> 
> The script that generated the first patch is included here:
> 
> @ replace_dma_zalloc_coherent @
> expression dev, size, data, handle, flags;
> @@
> 
> -dma_zalloc_coherent(dev, size, handle, flags)
> +dma_alloc_coherent(dev, size, handle, flags)
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
