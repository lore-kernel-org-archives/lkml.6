Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeDLGC3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 02:02:29 -0400
Received: from verein.lst.de ([213.95.11.211]:53710 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751877AbeDLGC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 02:02:28 -0400
Date: Thu, 12 Apr 2018 08:02:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] swiotlb: Fix unexpected swiotlb_alloc_coherent()
        failures
Message-ID: <20180412060227.GA30248@lst.de>
References: <20180410170513.22834-1-tiwai@suse.de> <20180410170615.GA27589@lst.de> <s5hzi2bat25.wl-tiwai@suse.de> <40618b9c-786d-7f5f-3f5b-fc1dd8375846@arm.com> <20180410181020.GA28565@lst.de> <s5h4lkib3rd.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h4lkib3rd.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 09:28:54AM +0200, Takashi Iwai wrote:
> > But we should try a GFP_DMA32 allocation first, so this is a bit
> > surprising.
> 
> Hm, do we really try that?
> Through a quick glance, dma_alloc_coherent_gfp_flags() gives GFP_DMA32
> only when coherent mask <= DMA_BIT_MASK(32); in the case of iwlwifi,
> it's 36bit, so GFP_DMA isn't set.

Oh, yes - it is using an odd dma mask, and amdgpu seems to use an
just as odd 40-bit dma mask.

> We had a fallback allocation with GFP_DMA32 in the past, but this
> seems gone long time ago along with cleanups (commit c647c3bb2d16).
> 
> But I haven't followed about this topic for long time, so I might have
> missed obviously...

I think a fallback would be much better here rather than relying on the
limited swiotlb buffer bool.  dma_direct_alloc (which in 4.17 is also
used for x86) already has a GFP_DMA fallback, so extending this for
GFP_DMA32 as well would seem reasonable.

Any volunteers?
