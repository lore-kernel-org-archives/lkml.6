Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeEBMjT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:39:19 -0400
Received: from verein.lst.de ([213.95.11.211]:38997 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbeEBMjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:39:17 -0400
Date: Wed, 2 May 2018 14:41:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] swiotlb: Fix inversed DMA_ATTR_NO_WARN test
Message-ID: <20180502124151.GA22857@lst.de>
References: <20180501132411.2311-1-michel@daenzer.net> <786ca83f-45c4-264b-2aef-d84fb18d3d28@gmail.com> <CAKMK7uH2+v3_UUqXdCjz_8=H4VRt1zB+dgE99PuuPqd+XM2=-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uH2+v3_UUqXdCjz_8=H4VRt1zB+dgE99PuuPqd+XM2=-w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 02:18:56PM +0200, Daniel Vetter wrote:
> Other dma-api backends like cma just shut up when __GFP_NOWARN is
> passed. And afaiui Christoph Hellwig has plans to nuke the DMA_ATTR
> stuff (or at least clean it up) - should we just remove
> DMA_ATTR_NO_WARN and instead only look at __GFP_NOWARN?

No.  __GFP_NOWARN (and gfp_t flags in general) are the wrong interface
for dma allocations and just cause problems.  I actually plan to
get rid of the gfp_t argument in dma_alloc_attrs sooner, and only
allow either GFP_KERNEL or GFP_DMA passed in dma_alloc_coherent.

> Or maybe we should at least enforce that both or none are set, for
> consistency for now?

The interface should be DMA_ATTR_NO_WARN.  __GFP_NOWARN in this
context was never documented, and just slipped in.
