Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526356458; cv=none;
        d=google.com; s=arc-20160816;
        b=wctC6dvmmg2yUQLwRVIaGueHLykvY+oZEi2dVPKFc8l5GoZz1qK4MgF+eiJKvqAjzS
         jq5IEHJRor0uvpoTwXsQ/EmJdSXC6gY0LBRRaW6A3EqFm9Vp87pkC3DmHhHShtXeFRSv
         ENxeOdKHFSge1g7idywugvzzeHN9pkExxhBkWcb685kY3hRqvl6nFSPWDQgoqz7VU56n
         vLHfspW5ru3qyA2dUoaAkh5+6nY5KeMhf4vmcAhQq+302OB5AjCC2AmslkXHbQnhHnSp
         jt+qYv/Vk1xgQJg59G3MCTYHx3c754JKz8FzqOphL32jcVwnOEanylrlp5e8SaCT3Pm6
         SZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=1wi9Zu5+/zGvptZjuCkmBeyJWl4WQbIZoRpnFc9CaiU=;
        b=PKMLySoCZ28BZhdZJHuTwgU0YKvnDAB4Xn0eiZPARKCL2fAonRnCxYOd3JTS/CdDDb
         Ejv4Z0aTdL2Ll9Pvxx1yyavQM79GFYwsSgx0JdjjmM3nOCvqrZ+UqCZxjewdppScY+Ct
         poY9dk7TjWt6W0C9x4fYeR07COiTZyd78FWPPezJltL6pbJ63CFytx02rTjN9dqBBT+X
         0CjjQ92snE9A6yahDf4qypVIv27wkps7kmCmczKa4eE3oNwxmDaW4R/WpPDcTegcQAbs
         WH5K81WNkYWBxcrwHtbm18BzpN3y/7Qw8+6743FpR4vli3fRsJXFJO5bEgdaQpPK1zDB
         qF9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NOs5oe/T;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=NOs5oe/T;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrhL4vmHefBvUqJ108sUnsroM57xeFAV3UzjGdFg7pqSu7q0wGqov3A4mOdq3R78W6POPLGkg==
Date: Tue, 15 May 2018 06:54:15 +0300
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
Subject: Re: [PATCH v5 03/13] mm: Assign memcg-aware shrinkers bitmap to memcg
Message-ID: <20180515035415.3jpx3uqpztnzlnez@esperanza>
References: <152594582808.22949.8353313986092337675.stgit@localhost.localdomain>
 <152594595644.22949.8473969450800431565.stgit@localhost.localdomain>
 <20180513164738.tufhk5i7bnsxsq4l@esperanza>
 <d8c3a265-f20c-7bf5-23a7-8b80cf25af3d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8c3a265-f20c-7bf5-23a7-8b80cf25af3d@virtuozzo.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600070321367125899?=
X-GMAIL-MSGID: =?utf-8?q?1600500749868197405?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 12:34:45PM +0300, Kirill Tkhai wrote:
> >> +static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
> >> +{
> >> +	struct mem_cgroup_per_node *pn;
> >> +	struct memcg_shrinker_map *map;
> >> +	int nid;
> >> +
> >> +	if (memcg == root_mem_cgroup)
> >> +		return;
> >> +
> >> +	mutex_lock(&shrinkers_nr_max_mutex);
> > 
> > Why do you need to take the mutex here? You don't access shrinker map
> > capacity here AFAICS.
> 
> Allocation of shrinkers map is in css_online() now, and this wants its pay.
> memcg_expand_one_shrinker_map() must be able to differ mem cgroups with
> allocated maps, mem cgroups with not allocated maps, and mem cgroups with
> failed/failing css_online. So, the mutex is used for synchronization with
> expanding. See "old_size && !old" check in memcg_expand_one_shrinker_map().

Another reason to have 'expand' and 'alloc' paths separated - you
wouldn't need to take the mutex here as 'free' wouldn't be used for
undoing initial allocation, instead 'alloc' would cleanup by itself
while still holding the mutex.

> 
> >> +	for_each_node(nid) {
> >> +		pn = mem_cgroup_nodeinfo(memcg, nid);
> >> +		map = rcu_dereference_protected(pn->shrinker_map, true);
> >> +		if (map)
> >> +			call_rcu(&map->rcu, memcg_free_shrinker_map_rcu);
> >> +		rcu_assign_pointer(pn->shrinker_map, NULL);
> >> +	}
> >> +	mutex_unlock(&shrinkers_nr_max_mutex);
> >> +}
> >> +
> >> +static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
> >> +{
> >> +	int ret, size = memcg_shrinker_nr_max/BITS_PER_BYTE;
> >> +
> >> +	if (memcg == root_mem_cgroup)
> >> +		return 0;
> >> +
> >> +	mutex_lock(&shrinkers_nr_max_mutex);
> >> +	ret = memcg_expand_one_shrinker_map(memcg, size, 0);
> > 
> > I don't think it's worth reusing the function designed for reallocating
> > shrinker maps for initial allocation. Please just fold the code here -
> > it will make both 'alloc' and 'expand' easier to follow IMHO.
> 
> These function will have 80% code the same. What are the reasons to duplicate
> the same functionality? Two functions are more difficult for support, and
> everywhere in kernel we try to avoid this IMHO.

IMHO two functions with clear semantics are easier to maintain than
a function that does one of two things depending on some condition.
Separating 'alloc' from 'expand' would only add 10-15 SLOC.

> >> +	mutex_unlock(&shrinkers_nr_max_mutex);
> >> +
> >> +	if (ret)
> >> +		memcg_free_shrinker_maps(memcg);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static struct idr mem_cgroup_idr;
> >> +
> >> +int memcg_expand_shrinker_maps(int old_nr, int nr)
> >> +{
> >> +	int size, old_size, ret = 0;
> >> +	struct mem_cgroup *memcg;
> >> +
> >> +	old_size = old_nr / BITS_PER_BYTE;
> >> +	size = nr / BITS_PER_BYTE;
> >> +
> >> +	mutex_lock(&shrinkers_nr_max_mutex);
> >> +
> >> +	if (!root_mem_cgroup)
> >> +		goto unlock;
> > 
> > This wants a comment.
> 
> Which comment does this want? "root_mem_cgroup is not initialized, so
> it does not have child mem cgroups"?

Looking at this code again, I find it pretty self-explaining, sorry.

Thanks.
