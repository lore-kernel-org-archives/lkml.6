Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526803707; cv=none;
        d=google.com; s=arc-20160816;
        b=Sw6PMzq3/D6m5ysdxbm0e9lqIwvThwi7I861raw/JDXd7b1TJHG4BswIfmzcLam9Jy
         taUvbIw2mHlyFEBqTUDV2zTfNeQPXet4NqoWvfB1KcXdA9J8CptpZI0hbM1JipavPad6
         CcfiZMuQdtW7oirXM2+ezaWuqwdGMoQTEgLABDK/b0TwV5CL+bMIdqitvoF2rfWe5rwF
         fHI7O8Qv7XkunGa9XJwhqkxVhlktn2lu8rhY4nsHcy2mGqC+9PI3ntp+wswq74w3DIoe
         Il94j/w8BANpBtDP/sFg2xw/im3S+RMad/Lu/p2MscU/cc6lAKZqMzwOvp5eGZVtslCc
         XQnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=ET30GZr+A/JiuBoKRqRNafGmd4I0wm2njebZIqltbTY=;
        b=QGlPDzOB+ifuMXaZO7jXxOh69ePhKJLVUJXArWXFAt2Yzp0GEHXLCz3UwpA5F+xVL1
         EnEAiz+1nxC4BbT8ladkjl6W0IcGlwFXKULytYD5BV8TpSOWORNj89PXPU7Nbep5k/OJ
         zMuGTd/ZCloFL/avMzyri93OAQhWVPBTENPwRxnWhUoz4LexedFLR5ZmwOOcoqyLBiWU
         l1SD+VDWRdjbFpKF3T5DAKMm06bYzoDU/RaRs/BSoevvl28ETNd9lXuf4zFIPP9Lgi6T
         ETfKqYC3FtQATvzlWIk3YI4rSZI2/TNwgEDDgwRPvbH1oDz7BEG0JetaETYeCNvVTiUJ
         23WQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Erf3LnDn;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Erf3LnDn;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpG0xZ09Td2Zd2/lCnSh4eTBg/kHxuUk7kXrFHQFuewu3rcuhzBXsyvIZ4VkzhJNcabXraAKw==
Date: Sun, 20 May 2018 11:08:22 +0300
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
Subject: Re: [PATCH v6 15/17] mm: Generalize shrink_slab() calls in
 shrink_node()
Message-ID: <20180520080822.hqish62iahbonlht@esperanza>
References: <152663268383.5308.8660992135988724014.stgit@localhost.localdomain>
 <152663305153.5308.14479673190611499656.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152663305153.5308.14479673190611499656.stgit@localhost.localdomain>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600790790376098452?=
X-GMAIL-MSGID: =?utf-8?q?1600969724135068349?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 11:44:11AM +0300, Kirill Tkhai wrote:
> From: Vladimir Davydov <vdavydov.dev@gmail.com>
> 
> The patch makes shrink_slab() be called for root_mem_cgroup
> in the same way as it's called for the rest of cgroups.
> This simplifies the logic and improves the readability.
> 
> Signed-off-by: Vladimir Davydov <vdavydov.dev@gmail.com>
> ktkhai: Description written.
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  mm/vmscan.c |   13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2fbf3b476601..f1d23e2df988 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c

You forgot to patch the comment to shrink_slab(). Please take a closer
look at the diff I sent you:

@@ -486,10 +486,8 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
  * @nid is passed along to shrinkers with SHRINKER_NUMA_AWARE set,
  * unaware shrinkers will receive a node id of 0 instead.
  *
- * @memcg specifies the memory cgroup to target. If it is not NULL,
- * only shrinkers with SHRINKER_MEMCG_AWARE set will be called to scan
- * objects from the memory cgroup specified. Otherwise, only unaware
- * shrinkers are called.
+ * @memcg specifies the memory cgroup to target. Unaware shrinkers
+ * are called only if it is the root cgroup.
  *
  * @priority is sc->priority, we take the number of objects and >> by priority
  * in order to get the scan target.

> @@ -661,9 +661,6 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  			.memcg = memcg,
>  		};

If you made !MEMCG version of mem_cgroup_is_root return true, as I
suggested in reply to patch 13, you could also simplify the memcg
related check in the beginning of shrink_slab() as in case of
CONFIG_MEMCG 'memcg' is now guaranteed to be != NULL in this function
while in case if !CONFIG_MEMCG mem_cgroup_is_root() would always
return true:

@@ -501,7 +501,7 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
 	struct shrinker *shrinker;
 	unsigned long freed = 0;
 
-	if (memcg && !mem_cgroup_is_root(memcg))
+	if (!mem_cgroup_is_root(memcg))
 		return shrink_slab_memcg(gfp_mask, nid, memcg, priority);
 
 	if (!down_read_trylock(&shrinker_rwsem))

>  
> -		if (!!memcg != !!(shrinker->flags & SHRINKER_MEMCG_AWARE))
> -			continue;
> -
>  		if (!(shrinker->flags & SHRINKER_NUMA_AWARE))
>  			sc.nid = 0;
>  
> @@ -693,6 +690,7 @@ void drop_slab_node(int nid)
>  		struct mem_cgroup *memcg = NULL;
>  
>  		freed = 0;
> +		memcg = mem_cgroup_iter(NULL, NULL, NULL);
>  		do {
>  			freed += shrink_slab(GFP_KERNEL, nid, memcg, 0);
>  		} while ((memcg = mem_cgroup_iter(NULL, memcg, NULL)) != NULL);
> @@ -2712,9 +2710,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  			shrink_node_memcg(pgdat, memcg, sc, &lru_pages);
>  			node_lru_pages += lru_pages;
>  
> -			if (memcg)
> -				shrink_slab(sc->gfp_mask, pgdat->node_id,
> -					    memcg, sc->priority);
> +			shrink_slab(sc->gfp_mask, pgdat->node_id,
> +				    memcg, sc->priority);
>  
>  			/* Record the group's reclaim efficiency */
>  			vmpressure(sc->gfp_mask, memcg, false,
> @@ -2738,10 +2735,6 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  			}
>  		} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
>  
> -		if (global_reclaim(sc))
> -			shrink_slab(sc->gfp_mask, pgdat->node_id, NULL,
> -				    sc->priority);
> -
>  		if (reclaim_state) {
>  			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
>  			reclaim_state->reclaimed_slab = 0;
> 
