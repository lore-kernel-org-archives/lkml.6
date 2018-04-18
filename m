Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753584AbeDREQp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 00:16:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41162 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbeDREQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 00:16:44 -0400
X-Google-Smtp-Source: AIpwx4+k4lktME5iBPMb9v+Xb0t3jkkYYB1qGsrRq3inWCJZKNmzfy0AReJsMr8F4SVmbHWrsZ00Gw==
Date: Tue, 17 Apr 2018 21:16:42 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Matthew Wilcox <willy@infradead.org>
cc: Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm:memcg: add __GFP_NOWARN in
 __memcg_schedule_kmem_cache_create
In-Reply-To: <20180418030824.GA7320@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.21.1804172113400.114494@chino.kir.corp.google.com>
References: <20180418022912.248417-1-minchan@kernel.org> <20180418030824.GA7320@bombadil.infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018, Matthew Wilcox wrote:

> Not arguing against this patch.  But how many places do we want to use
> GFP_NOWAIT without __GFP_NOWARN?  Not many, and the few which do do this
> seem like they simply haven't added it yet.  Maybe this would be a good idea?
> 
> -#define GFP_NOWAIT      (__GFP_KSWAPD_RECLAIM)
> +#define GFP_NOWAIT      (__GFP_KSWAPD_RECLAIM | __GFP_NOWARN)
> 

I don't think that's a good idea, slab allocators use GFP_NOWAIT during 
init, for example, followed up with a BUG_ON() if it fails.  With an 
implicit __GFP_NOWARN we wouldn't be able to see the state of memory when 
it crashes (likely memory that wasn't freed to the allocator).  I think 
whether the allocation failure should trigger a warning is up to the 
caller.
