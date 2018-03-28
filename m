Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752487AbeC1ARD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 20:17:03 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34902 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbeC1ARB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 20:17:01 -0400
X-Google-Smtp-Source: AIpwx4+BjFhz7rnY6081GDCCJQ/28bH5kemupYo1wB4SiiowR+7uW8FccgHkixAI+6rbN0OJOOTzCQ==
Date: Tue, 27 Mar 2018 17:16:59 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Shakeel Butt <shakeelb@google.com>
cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Greg Thelen <gthelen@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab, slub: skip unnecessary kasan_cache_shutdown()
In-Reply-To: <20180327230603.54721-1-shakeelb@google.com>
Message-ID: <alpine.DEB.2.20.1803271715310.8944@chino.kir.corp.google.com>
References: <20180327230603.54721-1-shakeelb@google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018, Shakeel Butt wrote:

> diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
> index 49fffb0ca83b..135ce2838c89 100644
> --- a/mm/kasan/kasan.c
> +++ b/mm/kasan/kasan.c
> @@ -382,7 +382,8 @@ void kasan_cache_shrink(struct kmem_cache *cache)
>  
>  void kasan_cache_shutdown(struct kmem_cache *cache)
>  {
> -	quarantine_remove_cache(cache);
> +	if (!__kmem_cache_empty(cache))
> +		quarantine_remove_cache(cache);
>  }
>  
>  size_t kasan_metadata_size(struct kmem_cache *cache)
> diff --git a/mm/slab.c b/mm/slab.c
> index 9212c64bb705..b59f2cdf28d1 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -2291,6 +2291,18 @@ static int drain_freelist(struct kmem_cache *cache,
>  	return nr_freed;
>  }
>  
> +bool __kmem_cache_empty(struct kmem_cache *s)
> +{
> +	int node;
> +	struct kmem_cache_node *n;
> +
> +	for_each_kmem_cache_node(s, node, n)
> +		if (!list_empty(&n->slabs_full) ||
> +		    !list_empty(&n->slabs_partial))
> +			return false;
> +	return true;
> +}
> +
>  int __kmem_cache_shrink(struct kmem_cache *cachep)
>  {
>  	int ret = 0;
> diff --git a/mm/slab.h b/mm/slab.h
> index e8981e811c45..68bdf498da3b 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -166,6 +166,7 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
>  			      SLAB_TEMPORARY | \
>  			      SLAB_ACCOUNT)
>  
> +bool __kmem_cache_empty(struct kmem_cache *);
>  int __kmem_cache_shutdown(struct kmem_cache *);
>  void __kmem_cache_release(struct kmem_cache *);
>  int __kmem_cache_shrink(struct kmem_cache *);
> diff --git a/mm/slub.c b/mm/slub.c
> index 1edc8d97c862..44aa7847324a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3707,6 +3707,17 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
>  		discard_slab(s, page);
>  }
>  
> +bool __kmem_cache_empty(struct kmem_cache *s)
> +{
> +	int node;
> +	struct kmem_cache_node *n;
> +
> +	for_each_kmem_cache_node(s, node, n)
> +		if (n->nr_partial || slabs_node(s, node))
> +			return false;
> +	return true;
> +}
> +
>  /*
>   * Release all resources used by a slab cache.
>   */

Any reason not to just make quarantine_remove_cache() part of 
__kmem_cache_shutdown() instead of duplicating its logic?
