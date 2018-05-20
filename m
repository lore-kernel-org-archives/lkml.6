Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526803206; cv=none;
        d=google.com; s=arc-20160816;
        b=i2MdUmVOe/SDncQoUV2rCl5K7MmIXSpLwUQUUmY8kjlieMw5uscTRx/lUJ+w3vhGbc
         nW/8+lKh2wxUPvlt9elNLTdxu8luZ+Y5tO2aHcqYKlsLCcZvNco4eQlPj3FkgFzEyA4A
         yyWNFdCJcVnP728iMiYPr7TEkHTGPk+25xL3m2oMk8s+mT8KGFVjNF7S8TU6xuvEmXD3
         t900TvULBW8a32F5dkSddY3wMaelv8RugMT9sQp/lFeqTjabCZDevObck/8ay1aytvhu
         FRjZLMJJRNPbj+Xog5LKlC/4U3OXyVZNrYXxQYjN1NV/Y6pYVQqfkDXLh229eBnUyyyV
         MmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=/AmKnO0W30rn1AiOxhXXC0Kq9Ocg80nYMSpjrPGywmM=;
        b=WvfZhzIkuymD5a4wf1IueZu1IV6Ne4T9XRZYissty3ojZO3DAGEfYq3K4p9kcFr4IS
         7sfIDvZB/+5ZOzHsrMMtvuULZ5fgCV5m49r0MRr+s9YqvPSasLL62ZKtHRZ7LheAuVd0
         Q2jv4Arc43KluaL4lZGhBfqbQ6pjjF29k+7QgwqArpKtgPlz/IIfrjpMhbRPSn56uZsj
         PEjMRge7T+zpNpGkMK7Oo4qGJJ8Ks2G6I7+LTUgriBtu1BQm7lAwwMHx8r2cABH7KVHF
         OrGecAriERX7l2H5NtGomjinm+zB5o/WHAZdS0XBphuj5o3n3rRQ8cqCs0IY5OOuJ6/8
         ovWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=B/f+IV3J;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=B/f+IV3J;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrIlhztZpTVTk+jk2XG1vMp/o07+x+gmLe/hB+DuJsC0yrNULTXZHrPiMQWCAcQbxo673CfIA==
Date: Sun, 20 May 2018 11:00:03 +0300
From: Vladimir Davydov <vdavydov.dev@gmail.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com, viro@zeniv.linux.org.uk,
	hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
	pombredanne@nexb.com, stummala@codeaurora.org,
	gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
	mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
	chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
	ying.huang@intel.com, mgorman@techsingularity.net, jbacik@fb.com,
	linux@roeck-us.net, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, lirongqing@baidu.com,
	aryabinin@virtuozzo.com
Subject: Re: [PATCH v6 14/17] mm: Iterate only over charged shrinkers during
 memcg shrink_slab()
Message-ID: <20180520080003.gfygtb6rloqpjaol@esperanza>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
 <152663304128.5308.12840831728812876902.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152663304128.5308.12840831728812876902.stgit@localhost.localdomain>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790777328718772?=
X-GMAIL-MSGID: =?utf-8?q?1600969199326873575?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 11:44:01AM +0300, Kirill Tkhai wrote:
> Using the preparations made in previous patches, in case of memcg
> shrink, we may avoid shrinkers, which are not set in memcg's shrinkers
> bitmap. To do that, we separate iterations over memcg-aware and
> !memcg-aware shrinkers, and memcg-aware shrinkers are chosen
> via for_each_set_bit() from the bitmap. In case of big nodes,
> having many isolated environments, this gives significant
> performance growth. See next patches for the details.
> 
> Note, that the patch does not respect to empty memcg shrinkers,
> since we never clear the bitmap bits after we set it once.
> Their shrinkers will be called again, with no shrinked objects
> as result. This functionality is provided by next patches.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  mm/vmscan.c |   87 +++++++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 78 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f09ea20d7270..2fbf3b476601 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -373,6 +373,20 @@ int prealloc_shrinker(struct shrinker *shrinker)
>  			goto free_deferred;
>  	}
>  
> +	/*
> +	 * There is a window between prealloc_shrinker()
> +	 * and register_shrinker_prepared(). We don't want
> +	 * to clear bit of a shrinker in such the state
> +	 * in shrink_slab_memcg(), since this will impose
> +	 * restrictions on a code registering a shrinker
> +	 * (they would have to guarantee, their LRU lists
> +	 * are empty till shrinker is completely registered).
> +	 * So, we differ the situation, when 1)a shrinker
> +	 * is semi-registered (id is assigned, but it has
> +	 * not yet linked to shrinker_list) and 2)shrinker
> +	 * is not registered (id is not assigned).
> +	 */
> +	INIT_LIST_HEAD(&shrinker->list);
>  	return 0;
>  
>  free_deferred:
> @@ -544,6 +558,67 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	return freed;
>  }
>  
> +#ifdef CONFIG_MEMCG_KMEM
> +static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
> +			struct mem_cgroup *memcg, int priority)
> +{
> +	struct memcg_shrinker_map *map;
> +	unsigned long freed = 0;
> +	int ret, i;
> +
> +	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
> +		return 0;
> +
> +	if (!down_read_trylock(&shrinker_rwsem))
> +		return 0;
> +
> +	/*
> +	 * 1) Caller passes only alive memcg, so map can't be NULL.
> +	 * 2) shrinker_rwsem protects from maps expanding.
> +	 */
> +	map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
> +					true);
> +	BUG_ON(!map);
> +
> +	for_each_set_bit(i, map->map, memcg_shrinker_nr_max) {
> +		struct shrink_control sc = {
> +			.gfp_mask = gfp_mask,
> +			.nid = nid,
> +			.memcg = memcg,
> +		};
> +		struct shrinker *shrinker;
> +
> +		shrinker = idr_find(&shrinker_idr, i);
> +		if (unlikely(!shrinker)) {

Nit: I don't think 'unlikely' is required here as this is definitely not
a hot path.

> +			clear_bit(i, map->map);
> +			continue;
> +		}
> +		BUG_ON(!(shrinker->flags & SHRINKER_MEMCG_AWARE));
> +
> +		/* See comment in prealloc_shrinker() */
> +		if (unlikely(list_empty(&shrinker->list)))

Ditto.

> +			continue;
> +
> +		ret = do_shrink_slab(&sc, shrinker, priority);
> +		freed += ret;
> +
> +		if (rwsem_is_contended(&shrinker_rwsem)) {
> +			freed = freed ? : 1;
> +			break;
> +		}
> +	}
> +
> +	up_read(&shrinker_rwsem);
> +	return freed;
> +}
> +#else /* CONFIG_MEMCG_KMEM */
> +static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
> +			struct mem_cgroup *memcg, int priority)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_MEMCG_KMEM */
> +
>  /**
>   * shrink_slab - shrink slab caches
>   * @gfp_mask: allocation context
> @@ -573,8 +648,8 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  	struct shrinker *shrinker;
>  	unsigned long freed = 0;
>  
> -	if (memcg && (!memcg_kmem_enabled() || !mem_cgroup_online(memcg)))
> -		return 0;
> +	if (memcg && !mem_cgroup_is_root(memcg))
> +		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>  
>  	if (!down_read_trylock(&shrinker_rwsem))
>  		goto out;
> @@ -586,13 +661,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  			.memcg = memcg,
>  		};
>  
> -		/*
> -		 * If kernel memory accounting is disabled, we ignore
> -		 * SHRINKER_MEMCG_AWARE flag and call all shrinkers
> -		 * passing NULL for memcg.
> -		 */
> -		if (memcg_kmem_enabled() &&
> -		    !!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
> +		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
>  			continue;
>  
>  		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> 
