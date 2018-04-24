Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524569328; cv=none;
        d=google.com; s=arc-20160816;
        b=LGlBqKI5u8aY4DK4LWjg3BjgGGB2F4qOtI0eWx30w8CuL3cRYNHtKh3VIYllJ23yLF
         nCzEfRTbsTMT8nYR6to8ncIr9aCdT3uk4wkYPH3c9Q5vbHFz4YBKIKTaSe+ITk3ERc7K
         ZZN15mtMD6Jq0HJw001e4lpqrZDNRf0rGtK8FWBC4FlhHkTHxKSsUDy+97mXIejPnRnO
         At4AqiabJkSVcJvQT2jPQjGUYq5QKJV3QBNR1xoVMfolCc70i477YdVGHAN+8AirQ9Fa
         bHYp460UHUFwi8bScn+aXO31v3UMuPDTq9k1uTUMqd00gYM82meV/eUGF++m8qs38Rj9
         v+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=tp0+b9RTwH9haozPXnp1VFb16M/89aoi/rg5bFyRZoc=;
        b=wYvELOKTDOe46Uo9Sa+JsRY18ophCbRTr/ztxNk6qYs6JFPgc1bEiAuM4LzjrawOSq
         lzlZcmZftL4u4L68ApI1yny7fSAaurUve4oElLHiip4bMUfiqcP8teCTIwLtoHqaDtwx
         FIT07HDmec1f0iVUlq1knWn0yFjw4elxRssqVatzVIozups5MYR3JF3hn3DTEOtDglHL
         l4U0W8iNJkAUFBQV0qxu2hIhOQP3xy1gAhAlYK6OeFPDDPrNnSz8nU54b/JjoIS20UCU
         4ImrhvkLQ8+frcadK41qcfuyY1D7G1M76wDpvSA8iebXpCCf0Cf1Q/JnCk4QxMhim5XZ
         z3zg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ix8Fe2Xa;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ix8Fe2Xa;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqktXsSgf9a035Oml7B3ejk03dS7tARrc1jvKnFaeWclbDFePF6yIcHrSIoblwLRVBIBkrUng==
Date: Tue, 24 Apr 2018 14:28:44 +0300
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
Subject: Re: [PATCH v2 04/12] mm: Assign memcg-aware shrinkers bitmap to memcg
Message-ID: <20180424112844.626madzs4cwoz5gh@esperanza>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
 <152399121146.3456.5459546288565589098.stgit@localhost.localdomain>
 <20180422175900.dsjmm7gt2nsqj3er@esperanza>
 <14ebcccf-3ea8-59f4-d7ea-793aaba632c0@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ebcccf-3ea8-59f4-d7ea-793aaba632c0@virtuozzo.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009310068873507?=
X-GMAIL-MSGID: =?utf-8?q?1598626808138285230?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 01:54:50PM +0300, Kirill Tkhai wrote:
> >> @@ -1200,6 +1206,8 @@ extern int memcg_nr_cache_ids;
> >>  void memcg_get_cache_ids(void);
> >>  void memcg_put_cache_ids(void);
> >>  
> >> +extern int shrinkers_max_nr;
> >> +
> > 
> > memcg_shrinker_id_max?
> 
> memcg_shrinker_id_max sounds like an includive value, doesn't it?
> While shrinker->id < shrinker_max_nr.
> 
> Let's better use memcg_shrinker_nr_max.

or memcg_nr_shrinker_ids (to match memcg_nr_cache_ids), not sure...

Come to think of it, this variable is kinda awkward: it is defined in
vmscan.c but declared in memcontrol.h; it is used by vmscan.c for max
shrinker id and by memcontrol.c for shrinker map capacity. Just a raw
idea: what about splitting it in two: one is private to vmscan.c, used
as max id, say we call it shrinker_id_max; the other is defined in
memcontrol.c and is used for shrinker map capacity, say we call it
memcg_shrinker_map_capacity. What do you think?

> >> +int expand_shrinker_maps(int old_nr, int nr)
> >> +{
> >> +	int id, size, old_size, node, ret;
> >> +	struct mem_cgroup *memcg;
> >> +
> >> +	old_size = old_nr / BITS_PER_BYTE;
> >> +	size = nr / BITS_PER_BYTE;
> >> +
> >> +	down_write(&shrinkers_max_nr_rwsem);
> >> +	for_each_node(node) {
> > 
> > Iterating over cgroups first, numa nodes second seems like a better idea
> > to me. I think you should fold for_each_node in memcg_expand_maps.
> >
> >> +		idr_for_each_entry(&mem_cgroup_idr, memcg, id) {
> > 
> > Iterating over mem_cgroup_idr looks strange. Why don't you use
> > for_each_mem_cgroup?
> 
> We want to allocate shrinkers maps in mem_cgroup_css_alloc(), since
> mem_cgroup_css_online() mustn't fail (it's a requirement of currently
> existing design of memcg_cgroup::id).
> 
> A new memcg is added to parent's list between two of these calls:
> 
> css_create()
>   ss->css_alloc()
>   list_add_tail_rcu(&css->sibling, &parent_css->children)
>   ss->css_online()
> 
> for_each_mem_cgroup() does not see allocated, but not linked children.

Why don't we move shrinker map allocation to css_online then?

>  
> >> +			if (id == 1)
> >> +				memcg = NULL;
> >> +			ret = memcg_expand_maps(memcg, node, size, old_size);
> >> +			if (ret)
> >> +				goto unlock;
> >> +		}
> >> +
> >> +		/* root_mem_cgroup is not initialized yet */
> >> +		if (id == 0)
> >> +			ret = memcg_expand_maps(NULL, node, size, old_size);
> >> +	}
> >> +unlock:
> >> +	up_write(&shrinkers_max_nr_rwsem);
> >> +	return ret;
> >> +}
