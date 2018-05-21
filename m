Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753252AbeEURJR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 13:09:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:50633 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753065AbeEURJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 13:09:16 -0400
Date: Mon, 21 May 2018 19:06:32 +0200
From: David Sterba <dsterba@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Huaisheng HS1 Ye <yehs1@lenovo.com>, Michal Hocko <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [External]  Re: [PATCH 2/3] include/linux/gfp.h: use unsigned
 int in gfp_zone
Message-ID: <20180521170632.GY6649@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Matthew Wilcox <willy@infradead.org>,
        Huaisheng HS1 Ye <yehs1@lenovo.com>,
        Michal Hocko <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "colyli@suse.de" <colyli@suse.de>,
        NingTing Cheng <chengnt@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <HK2PR03MB168459A1C4FB2B7D3E1F6A4A92840@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180506134814.GB7362@bombadil.infradead.org>
 <HK2PR03MB168447008C658172FFDA402992840@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180506185532.GA13604@bombadil.infradead.org>
 <HK2PR03MB1684BF10B3B515BFABD35F8B929B0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180507184410.GA12361@bombadil.infradead.org>
 <20180507212500.bdphwfhk55w6vlbb@twin.jikos.cz>
 <20180508002547.GA16338@bombadil.infradead.org>
 <20180509093659.jalprmufpwspya26@twin.jikos.cz>
 <20180515115404.GD31599@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515115404.GD31599@bombadil.infradead.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 04:54:04AM -0700, Matthew Wilcox wrote:
> > > Subject: btrfs: Allocate extents from ZONE_NORMAL
> > > From: Matthew Wilcox <mawilcox@microsoft.com>
> > > 
> > > If anyone ever passes a GFP_DMA or GFP_MOVABLE allocation flag to
> > > allocate_extent_state, it will try to allocate memory from the wrong zone.
> > > We just want to allocate memory from ZONE_NORMAL, so use GFP_RECLAIM_MASK
> > > to get what we want.
> > 
> > Looks good to me.
> > 
> > > Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> > > 
> > > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > > index e99b329002cf..4e4a67b7b29d 100644
> > > --- a/fs/btrfs/extent_io.c
> > > +++ b/fs/btrfs/extent_io.c
> > > @@ -216,12 +216,7 @@ static struct extent_state *alloc_extent_state(gfp_t mask)
> > >  {
> > >  	struct extent_state *state;
> > >  
> > > -	/*
> > > -	 * The given mask might be not appropriate for the slab allocator,
> > > -	 * drop the unsupported bits
> > > -	 */
> > > -	mask &= ~(__GFP_DMA32|__GFP_HIGHMEM);
> > 
> > I've noticed there's GFP_SLAB_BUG_MASK that's basically open coded here,
> > but this would not filter out the placement flags.
> > 
> > > -	state = kmem_cache_alloc(extent_state_cache, mask);
> > 
> > I'd prefer some comment here, it's not obvious why the mask is used.
> 
> Sorry, I dropped the ball on this.  Would you prefer:
> 
>         /* Allocate from ZONE_NORMAL */
>         state = kmem_cache_alloc(extent_state_cache, mask & GFP_RECLAIM_MASK);
> 
> or
> 
> 	/*
> 	 * Callers may pass in a mask which indicates they want to allocate
> 	 * from a special zone, so clear those bits here rather than forcing
> 	 * each caller to do it.  We only want to use their mask to indicate
> 	 * what strategies the memory allocator can use to free memory.
> 	 */
>         state = kmem_cache_alloc(extent_state_cache, mask & GFP_RECLAIM_MASK);
> 
> I tend to lean towards being more terse, but it's not about me, it's
> about whoever reads this code next.

I prefer the latter variant, it's clear that it's some MM stuff. Thanks.
