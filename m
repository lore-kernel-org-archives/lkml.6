Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753678AbeCUVWU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 17:22:20 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39464 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753495AbeCUVWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 17:22:15 -0400
X-Google-Smtp-Source: AG47ELvQ+QBEexO4xdW1G9u1z/AU4OjLLlk7wfQq/YOqgMl+VLxjO7hVbPhUpOaPRbnlJLKQiP46xw==
Date: Wed, 21 Mar 2018 14:22:13 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Michal Hocko <mhocko@kernel.org>
cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] memcg, thp: do not invoke oom killer on thp charges
In-Reply-To: <20180321205928.22240-1-mhocko@kernel.org>
Message-ID: <alpine.DEB.2.20.1803211418170.107059@chino.kir.corp.google.com>
References: <20180321205928.22240-1-mhocko@kernel.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2018, Michal Hocko wrote:

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d1a917b5b7b7..08accbcd1a18 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1493,7 +1493,7 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
>  
>  static void mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
>  {
> -	if (!current->memcg_may_oom)
> +	if (!current->memcg_may_oom || order > PAGE_ALLOC_COSTLY_ORDER)
>  		return;
>  	/*
>  	 * We are in the middle of the charge context here, so we

What bug reports have you received about order-4 and higher order non thp 
charges that this fixes?

The patch title and the changelog specifically single out thp, which I've 
fixed, since it has sane fallback behavior and everything else uses 
__GFP_NORETRY.  I think this is misusing a page allocator heuristic that 
hasn't been applied to the memcg charge path before to address a thp 
regression but generalizing it for all charges.

PAGE_ALLOC_COSTLY_ORDER is a heuristic used by the page allocator because 
it cannot free high-order contiguous memory.  Memcg just needs to reclaim 
a number of pages.  Two order-3 charges can cause a memcg oom kill but now 
an order-4 charge cannot.  It's an unfair bias against high-order charges 
that are not explicitly using __GFP_NORETRY.
