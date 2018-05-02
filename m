Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751900AbeEBQTM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:19:12 -0400
Received: from verein.lst.de ([213.95.11.211]:39917 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751447AbeEBQTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:19:11 -0400
Date: Wed, 2 May 2018 18:21:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Vetter <daniel@ffwll.ch>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] swiotlb: Fix inversed DMA_ATTR_NO_WARN test
Message-ID: <20180502162145.GA26787@lst.de>
References: <20180501132411.2311-1-michel@daenzer.net> <786ca83f-45c4-264b-2aef-d84fb18d3d28@gmail.com> <CAKMK7uH2+v3_UUqXdCjz_8=H4VRt1zB+dgE99PuuPqd+XM2=-w@mail.gmail.com> <20180502124151.GA22857@lst.de> <1066dfa2-2f78-815d-c65a-9d09eb35458c@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1066dfa2-2f78-815d-c65a-9d09eb35458c@daenzer.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 04:31:09PM +0200, Michel Dänzer wrote:
> > No.  __GFP_NOWARN (and gfp_t flags in general) are the wrong interface
> > for dma allocations and just cause problems.  I actually plan to
> > get rid of the gfp_t argument in dma_alloc_attrs sooner, and only
> > allow either GFP_KERNEL or GFP_DMA passed in dma_alloc_coherent.
> 
> How about GFP_TRANSHUGE_LIGHT? TTM uses that to opportunistically
> allocate huge pages (GFP_TRANSHUGE can result in unacceptably long
> delays with memory pressure).

Well, that is exactly what I don't want drivers to do - same for
__GFP_COMP in some drm code.  This very much assumes the page allocator
is used to back dma allocations, which very often it actually isn't, and
any use of magic gfp flags creates a tight coupling of consumers with a
specific implementation.

In general I can't think of a good reason not to actually use
GFP_TRANSHUGE_LIGHT by default in the dma allocator unless
DMA_ATTR_ALLOC_SINGLE_PAGES is set.  Can you prepare a patch for that?
