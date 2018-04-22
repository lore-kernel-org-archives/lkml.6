Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524417419; cv=none;
        d=google.com; s=arc-20160816;
        b=GuAXeQmdUA1T2xyl4O7T7XyiCyYR0b4NWWr2di+ghB1Vw5g/quU3TukGC195hGggHK
         PDCT9zelW/MpoWoTmrZDQiDuMhbLwm3nRB4OnUTA04KJzTAnxP4tljron4TwLoL4uGqO
         ljdNvmeVq0D/uA8ah3Nn8mYrCBqk6yfpep5FcI809zeKzs9CZXLJlePxGFXRY7C94dll
         s9bikIfgojjyLkm5he0BmkO4aoIlSRYwF6MB/D80f4eGPQthrBgtPUQBeVdsUKjh7WPv
         NTrLpJeIMdADXK/VJ+vnp6QIFO6/gaMTF6ph7/FjTDluJUevzR91zx8qvWBzzdT3s/2r
         C0dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=gOkJNJoboUwDuK4tSeSyXPB0tEPGmMaeZyBU9yb1CeI=;
        b=OyoSissRI7RcClZu/0pkXjjJ9iMPMBWL5XrU+rLwU5FeH+VN5XL0evfKfzTiI7XIul
         0iMBIuiPC1bWppnC6mr9GRcgg88Krkv3papAqt225mjd9ERPZHzJikEQdHpS/ExCMNNJ
         4GhPbXN/x2jnL9Vav8YF4DbZMvOfWLrTJsL7PNSOq6cTFEDc+dS/BXdFSjZ0Dj1X2+e4
         kgH5/8w3tw58iYlukUGsRPkUES2G8aYmmIGYnJwpgIf3aWot+03PnVCXgA/sPDyzaL3W
         NEyKFNXTUVYeErvZD/EmBK6+HjK/0KtEde5EYPJiv74AEPuJgi0b3xwritT/extL09/6
         dCdA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=F9LMKekE;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=F9LMKekE;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqUl42XThqgMKD5HmVCOLUoDTYcbwrV7FP6TMCibjcm3ehqb7vxW6OW1mXFR3+rMUJgQprnQw==
Date: Sun, 22 Apr 2018 20:16:55 +0300
From: Vladimir Davydov <vdavydov.dev@gmail.com>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: akpm@linux-foundation.org, shakeelb@google.com, viro@zeniv.linux.org.uk,
	hannes@cmpxchg.org, mhocko@kernel.org, tglx@linutronix.de,
	pombredanne@nexb.com, stummala@codeaurora.org,
	gregkh@linuxfoundation.org, sfr@canb.auug.org.au, guro@fb.com,
	mka@chromium.org, penguin-kernel@I-love.SAKURA.ne.jp,
	chris@chris-wilson.co.uk, longman@redhat.com, minchan@kernel.org,
	hillf.zj@alibaba-inc.com, ying.huang@intel.com,
	mgorman@techsingularity.net, jbacik@fb.com, linux@roeck-us.net,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	willy@infradead.org, lirongqing@baidu.com, aryabinin@virtuozzo.com
Subject: Re: [PATCH v2 01/12] mm: Assign id to every memcg-aware shrinker
Message-ID: <20180422171655.llxowifnxzpf5hee@esperanza>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
 <152399118252.3456.17590357803686895373.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152399118252.3456.17590357803686895373.stgit@localhost.localdomain>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009267479229519?=
X-GMAIL-MSGID: =?utf-8?q?1598467520034470017?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 09:53:02PM +0300, Kirill Tkhai wrote:
> The patch introduces shrinker::id number, which is used to enumerate
> memcg-aware shrinkers. The number start from 0, and the code tries
> to maintain it as small as possible.
> 
> This will be used as to represent a memcg-aware shrinkers in memcg
> shrinkers map.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  include/linux/shrinker.h |    2 ++
>  mm/vmscan.c              |   51 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index a3894918a436..86b651fa2846 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -66,6 +66,8 @@ struct shrinker {
>  
>  	/* These are for internal use */
>  	struct list_head list;

> +	/* ID in shrinkers_id_idr */
> +	int id;

This should be under ifdef CONFIG_MEMCG && CONFIG_SLOB.

>  	/* objs pending delete, per node */
>  	atomic_long_t *nr_deferred;
>  };
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 8b920ce3ae02..4f02fe83537e 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -169,6 +169,43 @@ unsigned long vm_total_pages;
>  static LIST_HEAD(shrinker_list);
>  static DECLARE_RWSEM(shrinker_rwsem);
>  
> +#if defined(CONFIG_MEMCG) && !defined(CONFIG_SLOB)

> +static DEFINE_IDR(shrinkers_id_idr);

IMO shrinker_idr would be a better name.

> +
> +static int add_memcg_shrinker(struct shrinker *shrinker)
> +{
> +	int id, ret;
> +
> +	down_write(&shrinker_rwsem);
> +	ret = id = idr_alloc(&shrinkers_id_idr, shrinker, 0, 0, GFP_KERNEL);
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
> +{
> +	int id = shrinker->id;
> +
> +	down_write(&shrinker_rwsem);
> +	idr_remove(&shrinkers_id_idr, id);
> +	up_write(&shrinker_rwsem);
> +}
> +#else /* CONFIG_MEMCG && !CONFIG_SLOB */
> +static int add_memcg_shrinker(struct shrinker *shrinker)
> +{
> +	return 0;
> +}
> +
> +static void del_memcg_shrinker(struct shrinker *shrinker)
> +{
> +}
> +#endif /* CONFIG_MEMCG && !CONFIG_SLOB */
> +
>  #ifdef CONFIG_MEMCG
>  static bool global_reclaim(struct scan_control *sc)
>  {
> @@ -306,6 +343,7 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
>  int register_shrinker(struct shrinker *shrinker)
>  {
>  	size_t size = sizeof(*shrinker->nr_deferred);
> +	int ret;
>  
>  	if (shrinker->flags & SHRINKER_NUMA_AWARE)
>  		size *= nr_node_ids;
> @@ -314,10 +352,21 @@ int register_shrinker(struct shrinker *shrinker)
>  	if (!shrinker->nr_deferred)
>  		return -ENOMEM;
>  
> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
> +		ret = add_memcg_shrinker(shrinker);
> +		if (ret)
> +			goto free_deferred;
> +	}
> +

This doesn't apply anymore, not after commit 8e04944f0ea8a ("mm,vmscan:
Allow preallocating memory for register_shrinker()"). Please rebase.

I guess now you have to allocate an id in prealloc_shrinker and set the
pointer (with idr_replace) in register_shrinker_prepared.

>  	down_write(&shrinker_rwsem);
>  	list_add_tail(&shrinker->list, &shrinker_list);
>  	up_write(&shrinker_rwsem);
>  	return 0;
> +
> +free_deferred:
> +	kfree(shrinker->nr_deferred);
> +	shrinker->nr_deferred = NULL;
> +	return -ENOMEM;
>  }
>  EXPORT_SYMBOL(register_shrinker);
>  
> @@ -328,6 +377,8 @@ void unregister_shrinker(struct shrinker *shrinker)
>  {
>  	if (!shrinker->nr_deferred)
>  		return;
> +	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
> +		del_memcg_shrinker(shrinker);
>  	down_write(&shrinker_rwsem);
>  	list_del(&shrinker->list);
>  	up_write(&shrinker_rwsem);
> 
