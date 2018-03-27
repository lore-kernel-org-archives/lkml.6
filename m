Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522144851; cv=none;
        d=google.com; s=arc-20160816;
        b=Op8I3rooW+g+TRNI4zLCOOhL5EXLJRb6f56nu9wJqF7AeEauAj6C9LaBwZ1CEivu/q
         8Xvm9oSzbHkYpFgD6017e/NK81g7PTV1gSe+W82WgTOa+bhu1CF/UbZYDeakC50muhqO
         mhF4OrFNVqaKajNgmGbY03AM0yvXl2yG5UwL7n+tncS8wWq7y0a7OONgHZ6m0oY1wXpV
         sWsc8ZkBjOlHtSgfYcw3EGEp/GDiXzakdoDPwzqntNJlPZi6KiUmS2SLfw0YacqxGUiQ
         4/e8ZWr2GVveY+Lf0xXDiosV2SkYyjNyuAW98Jm+seNXOmQDFHf7bhHqNfR+olrGuqyd
         IGGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=vDoSlrWFnoGE6H471jTmCt2LjkGRsrzWFcw95QFonRA=;
        b=ovEtx5F8DM+vPZFRhGHX6wbxstjMfbAqT74ff4Nw0q3G9qrE2mgYLLrEy5UsrgfYcf
         u8QsrZpb6NBHlCN3uAv017Li3hpcv5/fSKVvCg8kdokj2g+3+WBr9FfI4D9TMcH8TQER
         Lf6+kXwr5Gdb0VxpJ3/8oR7UP1+lqmeG7U4RhsCsAIH1LwDgpC69FaM9GGsWg54DgUn+
         erVXgyO2GTlsl6D1s2UP/qpxHBBsXOAigCIdejc2v8iF/ITYKU1OfotW6aLTj39m8pUZ
         55TOTDO6l2On3Qcg5yc/XEFnkc8Mmb1eyrQYPpZPq/ORHpENGMh/Ann4QBinoZ7+PAcz
         +EPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=B4LsuhDR;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=B4LsuhDR;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsrhRt2CymQUepxGpNqseDPr0+bbm+ce5uVHa3iBo0skhDLMXDkDDdjDUvmlwuSMCuZkOrE5Q==
Date: Tue, 27 Mar 2018 13:00:47 +0300
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
Subject: Re: [PATCH 03/10] mm: Assign memcg-aware shrinkers bitmap to memcg
Message-ID: <20180327100047.gj4gtmt3necmtpzw@esperanza>
References: <152163840790.21546.980703278415599202.stgit@localhost.localdomain>
 <152163850081.21546.6969747084834474733.stgit@localhost.localdomain>
 <20180324192521.my7akysvj7wtudan@esperanza>
 <09663190-12dd-4353-668d-f4fc2f27c2d7@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09663190-12dd-4353-668d-f4fc2f27c2d7@virtuozzo.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595553622756842955?=
X-GMAIL-MSGID: =?utf-8?q?1596084559656218101?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 26, 2018 at 06:29:05PM +0300, Kirill Tkhai wrote:
> >> @@ -182,6 +187,9 @@ struct mem_cgroup {
> >>  	unsigned long low;
> >>  	unsigned long high;
> >>  
> >> +	/* Bitmap of shrinker ids suitable to call for this memcg */
> >> +	struct shrinkers_map __rcu *shrinkers_map;
> >> +
> > 
> > We keep all per-node data in mem_cgroup_per_node struct. I think this
> > bitmap should be defined there as well.
> 
> But them we'll have to have struct rcu_head for every node to free the map
> via rcu. This is the only reason I did that. But if you think it's not a problem,
> I'll agree with you.

I think it's OK. It'd be consistent with how list_lru handles
list_lru_memcg reallocations.

> >> @@ -4487,6 +4490,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
> >>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> >>  	struct mem_cgroup_event *event, *tmp;
> >>  
> >> +	free_shrinker_maps(memcg);
> >> +
> > 
> > AFAIU this can race with shrink_slab accessing the map, resulting in
> > use-after-free. IMO it would be safer to free the bitmap from css_free.
> 
> But doesn't shrink_slab() iterate only online memcg?

Well, yes, shrink_slab() bails out if the memcg is offline, but I
suspect there might be a race condition between shrink_slab and
css_offline when shrink_slab calls shrinkers for an offline cgroup.

> 
> >>  	/*
> >>  	 * Unregister events and notify userspace.
> >>  	 * Notify userspace about cgroup removing only after rmdir of cgroup
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index 97ce4f342fab..9d1df5d90eca 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -165,6 +165,10 @@ static DECLARE_RWSEM(bitmap_rwsem);
> >>  static int bitmap_id_start;
> >>  static int bitmap_nr_ids;
> >>  static struct shrinker **mcg_shrinkers;
> >> +struct shrinkers_map *__rcu root_shrinkers_map;
> > 
> > Why do you need root_shrinkers_map? AFAIR the root memory cgroup doesn't
> > have kernel memory accounting enabled.
> But we can charge the corresponding lru and iterate it over global reclaim,
> don't we?

Yes, I guess you're right. But do we need to care about it? Would it be
OK if we iterated over all shrinkers for the root cgroup? Dunno...

Anyway, please try to handle the root cgroup consistently with other
cgroups. I mean, nothing like this root_shrinkers_map should exist.
It should be either a part of root_mem_cgroup or we should iterate over
all shrinkers for the root cgroup.

> 
> struct list_lru_node {
> 	...
>         /* global list, used for the root cgroup in cgroup aware lrus */
>         struct list_lru_one     lru;
> 	...
> };
