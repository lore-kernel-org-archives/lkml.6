Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526363088; cv=none;
        d=google.com; s=arc-20160816;
        b=UUgNKMCN6DDWJWjM7cT6XbD3SxhSmCmXAarQAIBpl5F5BywdPm0eCF9AV1OMxRjlq1
         syMposy0+j0BQBhCC1e+Ark1jDcoEyY8nsJvsfgAeyMrxeLapI2gf7ZTMwwy9aX/2UuJ
         Z0Wpk7GYfPFBDV+VnUPsUWKjo5hXJiCrJnNroD+54pANjQpILNWLGuZ6wkD7OYI2w8d4
         HSjxv6nTOmcPa3ioJ0B1WxrYt65rtU0uTx0H06LvFrsIS3vXghQT+N3NIRmIDv2YcqFr
         WzeDyiF5EVWBfVdVbOYN2wb/e7nnIYD0b1nrSzOf6RW1mWXU5ogNybeLFjp8/P70dRaz
         sR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=aIr8cWPxE/36wYe2+02lluboFVKTnm5dCBcd+PQPt50=;
        b=SqncnzJyVUWk//mNpN0jLLKbHvGpXVDbKCleQSUXx1sPhpMjYiEVgh6LelCbXbEKdI
         66R7RqROb/EOMjb1HQ6ZX/D+vxguUxJ5xjr9KfPVvhjMkm6nrr8VJsRkOEF/HTRq+iL0
         qDpsa8W4iD4ZEgoipTZ2F9cZtcmgOngXVgnfz3PKxErTQr4ZH2WE3DqbFXZWNTOqvV9x
         t/cNjkOPVvmM0vX2Zw4fUOWO5QdvV9dKPhUXl+LoklAQpJEHNkXomYdgLe/IizcK60V9
         kO8CUVNQyp2FMXwDD/eZ3ZFz6B11TGG6zyW+7jC9FnZSS7/Ezg2dx6oQUySh0fCLAyqn
         TOZA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sI6zCGic;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sI6zCGic;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpAX0RTcuol68Vn90mf5pP1nOknagpuYLz7+dHUapQUq+fias6Ys1VcTRecYjILAAX7EEp13A==
Date: Tue, 15 May 2018 08:44:45 +0300
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
Subject: Re: [PATCH v5 11/13] mm: Iterate only over charged shrinkers during
 memcg shrink_slab()
Message-ID: <20180515054445.nhe4zigtelkois4p@esperanza>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
 <152594603565.22949.12428911301395699065.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152594603565.22949.12428911301395699065.stgit@localhost.localdomain>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070396521697862?=
X-GMAIL-MSGID: =?utf-8?q?1600507701935984539?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 12:53:55PM +0300, Kirill Tkhai wrote:
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
>  include/linux/memcontrol.h |    1 +
>  mm/vmscan.c                |   70 ++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 62 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 82f892e77637..436691a66500 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -760,6 +760,7 @@ void mem_cgroup_split_huge_fixup(struct page *head);
>  #define MEM_CGROUP_ID_MAX	0
>  
>  struct mem_cgroup;
> +#define root_mem_cgroup NULL

Let's instead export mem_cgroup_is_root(). In case if MEMCG is disabled
it will always return false.

>  
>  static inline bool mem_cgroup_disabled(void)
>  {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d8a2870710e0..a2e38e05adb5 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -376,6 +376,7 @@ int prealloc_shrinker(struct shrinker *shrinker)
>  			goto free_deferred;
>  	}
>  
> +	INIT_LIST_HEAD(&shrinker->list);

IMO this shouldn't be here, see my comment below.

>  	return 0;
>  
>  free_deferred:
> @@ -547,6 +548,63 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	return freed;
>  }
>  
> +#ifdef CONFIG_MEMCG_SHRINKER
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
> +	 * 1)Caller passes only alive memcg, so map can't be NULL.
> +	 * 2)shrinker_rwsem protects from maps expanding.

            ^^
Nit: space missing here :-)

> +	 */
> +	map = rcu_dereference_protected(MEMCG_SHRINKER_MAP(memcg, nid), true);
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
> +		if (!shrinker) {
> +			clear_bit(i, map->map);
> +			continue;
> +		}

The shrinker must be memcg aware so please add

  BUG_ON((shrinker->flags & SHRINKER_MEMCG_AWARE) == 0);

> +		if (list_empty(&shrinker->list))
> +			continue;

I don't like using shrinker->list as an indicator that the shrinker has
been initialized. IMO if you do need such a check, you should split
shrinker_idr registration in two steps - allocate a slot in 'prealloc'
and set the pointer in 'register'. However, can we really encounter an
unregistered shrinker here? AFAIU a bit can be set in the shrinker map
only after the corresponding shrinker has been initialized, no?

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
> +#else /* CONFIG_MEMCG_SHRINKER */
> +static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
> +			struct mem_cgroup *memcg, int priority)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_MEMCG_SHRINKER */
> +
>  /**
>   * shrink_slab - shrink slab caches
>   * @gfp_mask: allocation context
> @@ -576,8 +634,8 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  	struct shrinker *shrinker;
>  	unsigned long freed = 0;
>  
> -	if (memcg && (!memcg_kmem_enabled() || !mem_cgroup_online(memcg)))
> -		return 0;
> +	if (memcg && memcg != root_mem_cgroup)

if (!mem_cgroup_is_root(memcg))

> +		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
>  
>  	if (!down_read_trylock(&shrinker_rwsem))
>  		goto out;
> @@ -589,13 +647,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
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

I want this check gone. It's easy to achieve, actually - just remove the
following lines from shrink_node()

		if (global_reclaim(sc))
			shrink_slab(sc->gfp_mask, pgdat->node_id, NULL,
				    sc->priority);

>  
>  		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> 
