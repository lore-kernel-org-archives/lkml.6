Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526188513; cv=none;
        d=google.com; s=arc-20160816;
        b=pfNRqcOJLsE8/qxwwPpo5s638ou+904qXISBMcBeTZ5Tl2tA7GyhQkEgjoVde2fVk1
         FPuDxdfhZC9gUb1eySrJcPCpHsI7mJSso5Nar8eYqybvJGr+G21iaTGkS0mkS5yL5Gbj
         XCTShFnckF3JxAEL9g2Nl3RvXw5Q6KM6cPrtnl6RnpzPFYX/93qIQOYdjIdGJZ+4ZaUj
         XbKTSnbhPnQ2sOAX/lZCcLyb3YbFIId8F0IVlg1f7+Fwhj+m3aM74vtbioYacSR9DQve
         0PdXdHXOxoND7RhCTStbP8hiou1gaI3lG9tqXKPF594STJpnO6UVBfTLS4iOAvF7UJJu
         x8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=lSW09Jr5T1lwfnRps0av0UlmKX7MGtOkP9faxXCDupA=;
        b=PTzC8YmHi2KvFu0as+Jc925eH+2MJEhtXIoN16J3WhIBvUfrRYx48vB75ynPHMqSrz
         kqDZffdb2WvhM06DxonxBehrhuqkWKUOTWoPUhjqIrCSyChDV06whP8n+/LEDVx4XCkL
         448Rx0gV5z3d4p0/9KruiEpMei7l85DIhmbtMRwflHsDD4xfqfwzxX6Pee19tR8j4l93
         0s6VOqiSueyMiSLl6WRHjETaXS9FI31azOG3t5BC1IIwQ2j7K6/LNqGJbDaGmP845ha3
         IM1PTQr1pVoSgObuh+ckd1z6G7LQ+VXBqrzWoFcNu4Qvrz+Xztw5ylZG+8DlaBjZyxdk
         PzUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RijV6F04;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RijV6F04;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpzCpsRIxJF6Sa/irgoLnBZRfdE1NEkbJE19WKq/esqQCjWf5fVXiVCpT/JM23lDKOEPRMb9g==
Date: Sun, 13 May 2018 08:15:09 +0300
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
Subject: Re: [PATCH v5 01/13] mm: Assign id to every memcg-aware shrinker
Message-ID: <20180513051509.df2tcmbhxn3q2fp7@esperanza>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
 <152594593798.22949.6730606876057040426.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152594593798.22949.6730606876057040426.stgit@localhost.localdomain>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599987539736036809?=
X-GMAIL-MSGID: =?utf-8?q?1600324646989725958?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 10, 2018 at 12:52:18PM +0300, Kirill Tkhai wrote:
> The patch introduces shrinker::id number, which is used to enumerate
> memcg-aware shrinkers. The number start from 0, and the code tries
> to maintain it as small as possible.
> 
> This will be used as to represent a memcg-aware shrinkers in memcg
> shrinkers map.
> 
> Since all memcg-aware shrinkers are based on list_lru, which is per-memcg
> in case of !SLOB only, the new functionality will be under MEMCG && !SLOB
> ifdef (symlinked to CONFIG_MEMCG_SHRINKER).

Using MEMCG && !SLOB instead of introducing a new config option was done
deliberately, see:

  http://lkml.kernel.org/r/20151210202244.GA4809@cmpxchg.org

I guess, this doesn't work well any more, as there are more and more
parts depending on kmem accounting, like shrinkers. If you really want
to introduce a new option, I think you should call it CONFIG_MEMCG_KMEM
and use it consistently throughout the code instead of MEMCG && !SLOB.
And this should be done in a separate patch.

> diff --git a/fs/super.c b/fs/super.c
> index 122c402049a2..16c153d2f4f1 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -248,6 +248,9 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
>  	s->s_time_gran = 1000000000;
>  	s->cleancache_poolid = CLEANCACHE_NO_POOL;
>  
> +#ifdef CONFIG_MEMCG_SHRINKER
> +	s->s_shrink.id = -1;
> +#endif

No point doing that - you are going to overwrite the id anyway in
prealloc_shrinker().

>  	s->s_shrink.seeks = DEFAULT_SEEKS;
>  	s->s_shrink.scan_objects = super_cache_scan;
>  	s->s_shrink.count_objects = super_cache_count;

> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 10c8a38c5eef..d691beac1048 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -169,6 +169,47 @@ unsigned long vm_total_pages;
>  static LIST_HEAD(shrinker_list);
>  static DECLARE_RWSEM(shrinker_rwsem);
>  
> +#ifdef CONFIG_MEMCG_SHRINKER
> +static DEFINE_IDR(shrinker_idr);
> +
> +static int prealloc_memcg_shrinker(struct shrinker *shrinker)
> +{
> +	int id, ret;
> +
> +	down_write(&shrinker_rwsem);
> +	ret = id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
> +	if (ret < 0)
> +		goto unlock;
> +	shrinker->id = id;
> +	ret = 0;
> +unlock:
> +	up_write(&shrinker_rwsem);
> +	return ret;
> +}
> +
> +static void del_memcg_shrinker(struct shrinker *shrinker)

Nit: IMO unregister_memcg_shrinker() would be a better name as it
matches unregister_shrinker(), just like prealloc_memcg_shrinker()
matches prealloc_shrinker().

> +{
> +	int id = shrinker->id;
> +

> +	if (id < 0)
> +		return;

Nit: I think this should be BUG_ON(id >= 0) as this function is only
called for memcg-aware shrinkers AFAICS.

> +
> +	down_write(&shrinker_rwsem);
> +	idr_remove(&shrinker_idr, id);
> +	up_write(&shrinker_rwsem);
> +	shrinker->id = -1;
> +}
