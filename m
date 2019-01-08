Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AE5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8565A2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfAHN4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:56:10 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:61107
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727662AbfAHN4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:56:10 -0500
X-IronPort-AV: E=Sophos;i="5.56,454,1539640800"; 
   d="scan'208";a="291152796"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2019 14:55:44 +0100
Date:   Tue, 8 Jan 2019 14:55:42 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Christoph Hellwig <hch@lst.de>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: remove dma_zalloc_coherent
In-Reply-To: <20190108130701.14161-1-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1901081453380.6130@hadrien>
References: <20190108130701.14161-1-hch@lst.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Jan 2019, Christoph Hellwig wrote:

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

Great.  We should also update api/alloc/zalloc-simple.cocci.  The message
could just say that the z version is no longer needed.

julia
