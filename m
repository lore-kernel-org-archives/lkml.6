Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752031AbeCXNLh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 09:11:37 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32859 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751894AbeCXNLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 09:11:35 -0400
X-Google-Smtp-Source: AG47ELtc48il0CHQlYfhbSYbHGlNgjHSWw/jaUjKdHMkxACbyI6RtePbLzGvPreUR1jyZljwQbDl0A==
Date: Sat, 24 Mar 2018 16:11:31 +0300
From: Vladimir Davydov <vdavydov.dev@gmail.com>
To: Shakeel Butt <shakeelb@google.com>
Cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm, slab: eagerly delete inactive offlined SLABs
Message-ID: <20180324131131.blg3eqsfjc6issp2@esperanza>
References: <20180321224301.142879-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321224301.142879-1-shakeelb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shakeel,

The patch makes sense to me, but I have a concern about synchronization
of cache destruction vs concurrent kmem_cache_free. Please, see my
comments inline.

On Wed, Mar 21, 2018 at 03:43:01PM -0700, Shakeel Butt wrote:
> With kmem cgroup support, high memcgs churn can leave behind a lot of
> empty kmem_caches. Usually such kmem_caches will be destroyed when the
> corresponding memcg gets released but the memcg release can be
> arbitrarily delayed. These empty kmem_caches wastes cache_reaper's time.
> So, the reaper should destroy such empty offlined kmem_caches.

> diff --git a/mm/slab.c b/mm/slab.c
> index 66f2db98f026..9c174a799ffb 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -4004,6 +4004,16 @@ static void drain_array(struct kmem_cache *cachep, struct kmem_cache_node *n,
>  	slabs_destroy(cachep, &list);
>  }
>  
> +static bool is_slab_active(struct kmem_cache *cachep)
> +{
> +	int node;
> +	struct kmem_cache_node *n;
> +
> +	for_each_kmem_cache_node(cachep, node, n)
> +		if (READ_ONCE(n->total_slabs) - n->free_slabs)

Why READ_ONCE total_slabs, but not free_slabs?

Anyway, AFAIU there's no guarantee that this CPU sees the two fields
updated in the same order as they were actually updated on another CPU.
For example, suppose total_slabs is 2 and free_slabs is 1, and another
CPU is freeing a slab page concurrently from kmem_cache_free, i.e.
subtracting 1 from both total_slabs and free_slabs. Then this CPU might
see a transient state, when total_slabs is already updated (set to 1),
but free_slabs is not (still equals 1), and decide that it's safe to
destroy this slab cache while in fact it isn't.

Such a race will probably not result in any serious problems, because
shutdown_cache() checks that the cache is empty and does nothing if it
isn't, but still it looks suspicious and at least deserves a comment.
To eliminate the race, we should check total_slabs vs free_slabs with
kmem_cache_node->list_lock held. Alternatively, I think we could just
check if total_slabs is 0 - sooner or later cache_reap() will release
all empty slabs anyway.

> +			return true;
> +	return false;
> +}

> @@ -4061,6 +4071,10 @@ static void cache_reap(struct work_struct *w)
>  				5 * searchp->num - 1) / (5 * searchp->num));
>  			STATS_ADD_REAPED(searchp, freed);
>  		}
> +
> +		/* Eagerly delete inactive kmem_cache of an offlined memcg. */
> +		if (!is_memcg_online(searchp) && !is_slab_active(searchp))

I don't think we need to define is_memcg_online in generic code.
I would merge is_memcg_online and is_slab_active, and call the
resulting function cache_is_active.

> +			shutdown_cache(searchp);
>  next:
>  		cond_resched();
>  	}
