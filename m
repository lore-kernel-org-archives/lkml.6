Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966966AbeEXP3u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:29:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:44954 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966171AbeEXP3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:29:46 -0400
Date: Thu, 24 May 2018 17:29:43 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Huaisheng Ye <yehs2007@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, vbabka@suse.cz, mgorman@techsingularity.net,
        kstewart@linuxfoundation.org, alexander.levin@verizon.com,
        gregkh@linuxfoundation.org, colyli@suse.de, chengnt@lenovo.com,
        hehy1@lenovo.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, xen-devel@lists.xenproject.org,
        linux-btrfs@vger.kernel.org, Huaisheng Ye <yehs1@lenovo.com>
Subject: Re: [RFC PATCH v2 00/12] get rid of GFP_ZONE_TABLE/BAD
Message-ID: <20180524152943.GA11881@dhcp22.suse.cz>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
 <20180522183728.GB20441@dhcp22.suse.cz>
 <20180524051919.GA9819@bombadil.infradead.org>
 <20180524122323.GH20441@dhcp22.suse.cz>
 <20180524151818.GA21245@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524151818.GA21245@bombadil.infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 24-05-18 08:18:18, Matthew Wilcox wrote:
> On Thu, May 24, 2018 at 02:23:23PM +0200, Michal Hocko wrote:
> > > If we had eight ZONEs, we could offer:
> > 
> > No, please no more zones. What we have is quite a maint. burden on its
> > own. Ideally we should only have lowmem, highmem and special/device
> > zones for directly kernel accessible memory, the one that the kernel
> > cannot or must not use and completely special memory managed out of
> > the page allocator. All the remaining constrains should better be
> > implemented on top.
> 
> I believe you when you say that they're a maintenance pain.  Is that
> maintenance pain because they're so specialised?

Well, it used to be LRU balancing which is gone with the node reclaim
but that brings new challenges. Now as you say their meaning is not
really clear to users and that leads to bugs left and right.

> ie if we had more,
> could we solve our pain by making them more generic?

Well, if you have more you will consume more bits in the struct pages,
right?

[...]

> > But those already do have aproper API, IIUC. So do we really need to
> > make our GFP_*/Zone API more complicated than it already is?
> 
> I don't want to change the driver API (setting the DMA mask, etc),
> but we don't actually have a good API to the page allocator for the
> implementation of dma_alloc_foo() to request pages.  More or less,
> architectures do:
> 
> 	if (mask < 4GB)
> 		alloc_page(GFP_DMA)
> 	else if (mask < 64EB)
> 		alloc_page(GFP_DMA32)
> 	else
> 		alloc_page(GFP_HIGHMEM)
> 
> it more-or-less sucks that the devices with 28-bit DMA limits are forced
> to allocate from the low 16MB when they're perfectly capable of using the
> low 256MB.

Do we actually care all that much about those? If yes then we should
probably follow the ZONE_DMA (x86) path and use a CMA region for them.
I mean most devices should be good with very limited addressability or
below 4G, no?
-- 
Michal Hocko
SUSE Labs
