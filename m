Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521920743; cv=none;
        d=google.com; s=arc-20160816;
        b=TjPN0vIZRFNMFR3D9GTt6VopgpOUOXgJcPuvNchuCjHJWscmQzGolo/XlKvAQgdX1E
         aGS1f/ZoXpP+0W6sb8T21rmXut0f7HSOXK3hPHkN3upQTeD/hvNRub91tOyp39JLJ2VQ
         eWr9b/2ikNa6/ewS5MWEZPDisvjsQ2/f94ah+8kF/COQcNppSaOGxCRh3MaIf2eg+6Cr
         10LeCg4Oy5MxjdOGSzxlaeD/3UyuqeBjwSFpcAdbilunPp8rWURyMKPnnwwFrqDSSUN5
         5tp8gQUwvOzyXdK4B9AIX4kxSfMm6pGIpIGfGEG+3rJ3cIVacNS82sPBM9sMj66hFIT4
         3Bmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=U0YWY+ZVzy2XlfWcVqPivKBjyBCeJycNDU+Ppy09EwI=;
        b=rgWkvzHKclyfJW/miZ6keclOuwnFOpeTAqYQBdIDbrUe9pTKxkMGPq72RBIK8mob0O
         /CdT0TXfIV3ytpZNYIp5+5x0TDXGLJ2xAF0qUkO7Qp5QGrKaufOAfr1frZKQf6O6n+uA
         VnXk0K1QQZwwYLkhQMKZWV3eZnopAzNHrvB3tC3g1WmYFJF3UIXl/ctAwqLbpANrz2vz
         Lcikr8/zlLqTqH9/gExoGm04Zrv6MoQucCMdCqgzhLO6hUgXQ0sUvEmlk/CLiGEqVTgp
         xCcQEnk6RTgxq457AesJYxzhgbXSeWNtuk2sLJJdiNE3OdW3locczNMapQo5GwQxl0J/
         /Otg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IbmNEZhH;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=IbmNEZhH;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELs9bBWWNIkhiXhw9BEnqUkFRVj8pG2FmyD8JxLB1qviMVda+3tD8+K9uatxRa6d9r93YFpdpQ==
Date: Sat, 24 Mar 2018 22:45:40 +0300
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
Subject: Re: [PATCH 08/10] mm: Set bit in memcg shrinker bitmap on first
 list_lru item apearance
Message-ID: <20180324194540.rvejbnjg6knkwwia@esperanza>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163856059.21546.11414341109878480074.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152163856059.21546.11414341109878480074.stgit@localhost.localdomain>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553686088522081?=
X-GMAIL-MSGID: =?utf-8?q?1595849565893594156?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 04:22:40PM +0300, Kirill Tkhai wrote:
> Introduce set_shrinker_bit() function to set shrinker-related
> bit in memcg shrinker bitmap, and set the bit after the first
> item is added and in case of reparenting destroyed memcg's items.
> 
> This will allow next patch to make shrinkers be called only,
> in case of they have charged objects at the moment, and
> to improve shrink_slab() performance.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  include/linux/shrinker.h |    7 +++++++
>  mm/list_lru.c            |   22 ++++++++++++++++++++--
>  mm/vmscan.c              |    7 +++++++
>  3 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 738de8ef5246..24aeed1bc332 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -78,4 +78,11 @@ struct shrinker {
>  
>  extern __must_check int register_shrinker(struct shrinker *);
>  extern void unregister_shrinker(struct shrinker *);
> +#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)
> +extern void set_shrinker_bit(struct mem_cgroup *, int, int);
> +#else
> +static inline void set_shrinker_bit(struct mem_cgroup *memcg, int node, int id)
> +{
> +}
> +#endif

IMO this function, as well as other shrinker bitmap manipulation
functions, should be defined in memcontrol.[hc] and have mem_cgroup_
prefix.

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9d1df5d90eca..265cf069b470 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -378,6 +378,13 @@ static void del_shrinker(struct shrinker *shrinker)
>  	list_del(&shrinker->list);
>  	up_write(&shrinker_rwsem);
>  }
> +
> +void set_shrinker_bit(struct mem_cgroup *memcg, int nid, int nr)
> +{
> +	struct shrinkers_map *map = SHRINKERS_MAP(memcg);
> +
> +	set_bit(nr, map->map[nid]);
> +}

Shouldn't we use rcu_read_lock here? After all, the map can be
reallocated right from under our feet.
