Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeDRDI1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 23:08:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52762 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753144AbeDRDI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 23:08:26 -0400
Date: Tue, 17 Apr 2018 20:08:24 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm:memcg: add __GFP_NOWARN in
 __memcg_schedule_kmem_cache_create
Message-ID: <20180418030824.GA7320@bombadil.infradead.org>
References: <20180418022912.248417-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418022912.248417-1-minchan@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 11:29:12AM +0900, Minchan Kim wrote:
> If there are heavy memory pressure, page allocation with __GFP_NOWAIT
> fails easily although it's order-0 request.
> I got below warning 9 times for normal boot.
> 
> [   17.072747] c0 0      <snip >: page allocation failure: order:0, mode:0x2200000(GFP_NOWAIT|__GFP_NOTRACK)
> 
> Let's not make user scared.
>  
> -	cw = kmalloc(sizeof(*cw), GFP_NOWAIT);
> +	cw = kmalloc(sizeof(*cw), GFP_NOWAIT | __GFP_NOWARN);
>  	if (!cw)

Not arguing against this patch.  But how many places do we want to use
GFP_NOWAIT without __GFP_NOWARN?  Not many, and the few which do do this
seem like they simply haven't added it yet.  Maybe this would be a good idea?

-#define GFP_NOWAIT      (__GFP_KSWAPD_RECLAIM)
+#define GFP_NOWAIT      (__GFP_KSWAPD_RECLAIM | __GFP_NOWARN)
