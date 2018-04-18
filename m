Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753942AbeDRNbm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:31:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753442AbeDRNbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:31:41 -0400
Date: Wed, 18 Apr 2018 06:31:39 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm:memcg: add __GFP_NOWARN in
 __memcg_schedule_kmem_cache_create
Message-ID: <20180418133139.GB27475@bombadil.infradead.org>
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
> Let's not make user scared.

Actually, can you explain why it's OK if this fails?  As I understand this
code, we'll fail to create a kmalloc cache for this memcg.  What problems
does that cause?

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 448db08d97a0..671d07e73a3b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2200,7 +2200,7 @@ static void __memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
>  {
>  	struct memcg_kmem_cache_create_work *cw;
>  
> -	cw = kmalloc(sizeof(*cw), GFP_NOWAIT);
> +	cw = kmalloc(sizeof(*cw), GFP_NOWAIT | __GFP_NOWARN);
>  	if (!cw)
>  		return;
>  
> -- 
> 2.17.0.484.g0c8726318c-goog
> 
