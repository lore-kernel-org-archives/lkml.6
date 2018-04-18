Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeDRHKD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:10:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:35955 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752022AbeDRHKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:10:02 -0400
Date: Wed, 18 Apr 2018 09:09:58 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm:memcg: add __GFP_NOWARN in
 __memcg_schedule_kmem_cache_create
Message-ID: <20180418070958.GM17484@dhcp22.suse.cz>
References: <20180418022912.248417-1-minchan@kernel.org>
 <20180418030824.GA7320@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418030824.GA7320@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-04-18 20:08:24, Matthew Wilcox wrote:
> On Wed, Apr 18, 2018 at 11:29:12AM +0900, Minchan Kim wrote:
> > If there are heavy memory pressure, page allocation with __GFP_NOWAIT
> > fails easily although it's order-0 request.
> > I got below warning 9 times for normal boot.
> > 
> > [   17.072747] c0 0      <snip >: page allocation failure: order:0, mode:0x2200000(GFP_NOWAIT|__GFP_NOTRACK)
> > 
> > Let's not make user scared.
> >  
> > -	cw = kmalloc(sizeof(*cw), GFP_NOWAIT);
> > +	cw = kmalloc(sizeof(*cw), GFP_NOWAIT | __GFP_NOWARN);
> >  	if (!cw)
> 
> Not arguing against this patch.  But how many places do we want to use
> GFP_NOWAIT without __GFP_NOWARN?  Not many, and the few which do do this
> seem like they simply haven't added it yet.  Maybe this would be a good idea?
> 
> -#define GFP_NOWAIT      (__GFP_KSWAPD_RECLAIM)
> +#define GFP_NOWAIT      (__GFP_KSWAPD_RECLAIM | __GFP_NOWARN)

We have tried something like this in the past and Linus was strongly
against. I do not have reference handy but his argument was that each
__GFP_NOWARN should be explicit rather than implicit because it is
a deliberate decision to make.

-- 
Michal Hocko
SUSE Labs
