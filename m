Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521923596; cv=none;
        d=google.com; s=arc-20160816;
        b=tJ+7adMeETrbKWcwJ9SiKQLnpOLFVVMarsb1XCXUwtQk+9svhMSX+XyC56bAuO4euQ
         Y7x5ow2wPevGzuwXXeARlyje6we9EfR35Ig0cWt0r/JAbwArHZNzlAWEV3/q3O7SGxzN
         LDFRIm1nTRbPpKK6guHkloyhzFxL2Mt5FH+nYkOPH9PhO2NvcjtBVC/LhYENMyrHOf61
         VVTSR/gHp8KHZKkA1JisiDfp3oQJhDWau8+q8963Cn0pX7+zJTyasYQLjrxspaqIhJ7u
         kISgx9PT6ngtCFiOJWLCddDQ7eamH+uuE9suYV/AxPPalANAwqWFEnQnIK9xk2OuztSP
         eong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=n2eYhm4/zDDtG8JXZ3xBpUn+W+FipIB42ArWSQ85hWg=;
        b=ri6VvpRlDHxB5R2OZChmR8BkWMDXN3haAA7TzJrAQscpv33l34wNZAH1VsA1mxPavV
         6Jw/ADHNCKnZSe9X5ImS4ujY7KQ7C4EdKkaYwoInvkvv7OwkT2oohPL4ChTHpE2NWpB6
         yIRmKF8nCx6etQp7A39IV8GmT0fxNxJhyo2G8U1tKoqrmNCzHV4LDB9Bfh0pjYAi+hff
         YTh8eWLfPLXrXBt96jGVdcRSaITY/GDnBz8eNRMaZTuM0aErMKFABTERiiBDfIxqjx/Q
         WGRy4tCj87n2lFlnOS9G+ImTjc7b3oQFw77RqHQhGC8mrDw30sQ21pRCvZ2uoDAoKWQw
         isVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CRbwWnXj;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=CRbwWnXj;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48HYt+VcqL+ZaU3whhwr+BUQyMNmN1RuNEhc8Biw7PZqoKoE/6KZxE1CluEQbVqZTZvpbwVVw==
Date: Sat, 24 Mar 2018 23:33:12 +0300
From: Vladimir Davydov <vdavydov.dev@gmail.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: viro@zeniv.linux.org.uk, hannes@cmpxchg.org, mhocko@kernel.org,
	akpm@linux-foundation.org, tglx@linutronix.de, pombredanne@nexb.com,
	stummala@codeaurora.org, gregkh@linuxfoundation.org,
	sfr@canb.auug.org.au, guro@fb.com, mka@chromium.org,
	penguin-kernel@I-love.SAKURA.ne.jp, chris@chris-wilson.co.uk,
	longman@redhat.com, minchan@kernel.org, hillf.zj@alibaba-inc.com,
	ying.huang@intel.com, mgorman@techsingularity.net,
	shakeelb@google.com, jbacik@fb.com, linux@roeck-us.net,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	willy@infradead.org
Subject: Re: [PATCH 10/10] mm: Clear shrinker bit if there are no objects
 related to memcg
Message-ID: <20180324203312.b2whjgadm7gwby3v@esperanza>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163858159.21546.2876185232270486710.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152163858159.21546.2876185232270486710.stgit@localhost.localdomain>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553705818183633?=
X-GMAIL-MSGID: =?utf-8?q?1595852557328779623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 04:23:01PM +0300, Kirill Tkhai wrote:
> To avoid further unneed calls of do_shrink_slab()
> for shrinkers, which already do not have any charged
> objects in a memcg, their bits have to be cleared.
> 
> This patch introduces new return value SHRINK_EMPTY,
> which will be used in case of there is no charged
> objects in shrinker. We can't use 0 instead of that,
> as a shrinker may return 0, when it has very small
> amount of objects.
> 
> To prevent race with parallel list lru add, we call
> do_shrink_slab() once again, after the bit is cleared.
> So, if there is a new object, we never miss it, and
> the bit will be restored again.
> 
> The below test shows significant performance growths
> after using the patchset:
> 
> $echo 1 > /sys/fs/cgroup/memory/memory.use_hierarchy
> $mkdir /sys/fs/cgroup/memory/ct
> $echo 4000M > /sys/fs/cgroup/memory/ct/memory.kmem.limit_in_bytes
> $for i in `seq 0 4000`; do mkdir /sys/fs/cgroup/memory/ct/$i; echo $$ > /sys/fs/cgroup/memory/ct/$i/cgroup.procs; mkdir -p s/$i; mount -t tmpfs $i s/$i; touch s/$i/file; done
> 
> Then 4 drop_caches:
> $time echo 3 > /proc/sys/vm/drop_caches
> 
> Times of drop_caches:
> 
> *Before (4 iterations)*
> 0.00user 6.80system 0:06.82elapsed 99%CPU
> 0.00user 4.61system 0:04.62elapsed 99%CPU
> 0.00user 4.61system 0:04.61elapsed 99%CPU
> 0.00user 4.61system 0:04.61elapsed 99%CPU
> 
> *After (4 iterations)*
> 0.00user 0.93system 0:00.94elapsed 99%CPU
> 0.00user 0.00system 0:00.01elapsed 80%CPU
> 0.00user 0.00system 0:00.01elapsed 80%CPU
> 0.00user 0.00system 0:00.01elapsed 81%CPU
> 
> 4.61s/0.01s = 461 times faster.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  fs/super.c               |    3 +++
>  include/linux/shrinker.h |    1 +
>  mm/vmscan.c              |   21 ++++++++++++++++++---
>  mm/workingset.c          |    3 +++
>  4 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 24aeed1bc332..b23180deb928 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -34,6 +34,7 @@ struct shrink_control {
>  };
>  
>  #define SHRINK_STOP (~0UL)
> +#define SHRINK_EMPTY (~0UL - 1)

Please update the comment below accordingly.

>  /*
>   * A callback you can register to apply pressure to ageable caches.
>   *
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index e1fd16bc7a9b..1fc05e8bde04 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -387,6 +387,7 @@ void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int nr)
>  {
>  	struct shrinkers_map *map = SHRINKERS_MAP(memcg);
>  
> +	smp_mb__before_atomic(); /* Pairs with mb in shrink_slab() */

I don't understand the purpose of this barrier. Please add a comment
explaining why you need it.

>  	set_bit(nr, map->map[nid]);
>  }
>  #else /* CONFIG_MEMCG && !CONFIG_SLOB */
> @@ -568,8 +569,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>  	long scanned = 0, next_deferred;
>  
>  	freeable = shrinker->count_objects(shrinker, shrinkctl);
> -	if (freeable == 0)
> -		return 0;
> +	if (freeable == 0 || freeable == SHRINK_EMPTY)
> +		return freeable;
>  
>  	/*
>  	 * copy the current shrinker scan count into a local variable
> @@ -708,6 +709,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  #if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
>  	if (!memcg_kmem_enabled() || memcg) {
>  		struct shrinkers_map *map;
> +		unsigned long ret;
>  		int i;
>  
>  		map = rcu_dereference_protected(SHRINKERS_MAP(memcg), true);
> @@ -724,7 +726,20 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  					clear_bit(i, map->map[nid]);
>  					continue;
>  				}
> -				freed += do_shrink_slab(&sc, shrinker, priority);
> +				if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
> +					sc.nid = 0;

Hmm, if my memory doesn't fail, in the previous patch you added a BUG_ON
ensuring that a memcg-aware shrinker must also be numa-aware while here
you still check it. Please remove the BUG_ON or remove this check.
Better remove the BUG_ON, because a memcg-aware shrinker doesn't have to
be numa-aware.

> +				ret = do_shrink_slab(&sc, shrinker, priority);
> +				if (ret == SHRINK_EMPTY) {

do_shrink_slab() is also called for memcg-unaware shrinkers, you should
probably handle SHRINK_EMPTY there as well.

> +					clear_bit(i, map->map[nid]);
> +					/* pairs with mb in set_shrinker_bit() */
> +					smp_mb__after_atomic();
> +					ret = do_shrink_slab(&sc, shrinker, priority);
> +					if (ret == SHRINK_EMPTY)
> +						ret = 0;
> +					else
> +						set_bit(i, map->map[nid]);

Well, that's definitely a tricky part and hence needs a good comment.

Anyway, it would be great if we could simplify this part somehow.

> +				}
> +				freed += ret;
>  
>  				if (rwsem_is_contended(&shrinker_rwsem)) {
>  					freed = freed ? : 1;
