Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524928111; cv=none;
        d=google.com; s=arc-20160816;
        b=eC1XwIxmMWUw9CloSm+sSC0/fRHE1dQDpP5zPjf+m1foEwlgqKO6LaMSASymGHdZZB
         1HQxDqDbwHrKh/rSQjthcGwLG/lbLpfVOwhozWbRptLLlLEm3HWurxTXnY6qnDYebYFN
         fIFtjJnn3hZojuI7NCU1G3FIPLYKKaJDRchmgJBQDA4n56R4sVy9h7LP81AF1VAIT2la
         0E/DeA1cOgxUvhuZjXpYhmgxBcADM9rW4ZCD9wOMDy6xcGxm71MKtZr0f8sEjIkK2GM1
         WiigiIXqGdMteWY9DcgBajOAB5s3NBmrH+dWECzFEoaGgp08PvkJkv42IJunup3zTiD7
         S5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=Wu20f08332SJV4sXQikjls1RNze3uOm3TV57XiX20Ag=;
        b=mjaKk/x6MucuLox8D6v3/W2DaFrwnFQlxhPwd2xCNav34/ITMPNH6VsOLfPqRiMPZW
         GW9msIckdwH+sOq7n0oAem8KOc/9O8bOdObV86EsiTqJ5e9DOqtDHKn8JVPdrj4cla80
         4i9vIdGTOjtDtygjDBXqSYDygyueyv4k11aiIN0VzkmrpZk+NdsLmzxIuR5DqemGiFZA
         w4ghAMWnk9OnYz5N7tlHzkuj3F1UmmFoObkaoqWfmoRuEc80h594hrSlbtVyxA43/BLW
         laF653Ld3Bw2mgAphju7+dYkiDJf4AJXILAlQolYyGidbKkDRNSOnqOSgS6d/XDr+1Zf
         sH3w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Fdr1idfo;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Fdr1idfo;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZp5ogc+oKEB65SDg2cGUKX8rMFGGwXuLBpno+Na2kvw9z84lJpABugPydenN7nsY3hqaPjTRw==
Date: Sat, 28 Apr 2018 18:08:27 +0300
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
Message-ID: <20180428150827.b2bh7hhma7pp4av5@esperanza>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
 <152399121146.3456.5459546288565589098.stgit@localhost.localdomain>
 <20180422175900.dsjmm7gt2nsqj3er@esperanza>
 <14ebcccf-3ea8-59f4-d7ea-793aaba632c0@virtuozzo.com>
 <20180424112844.626madzs4cwoz5gh@esperanza>
 <7bf5372d-7d9d-abee-27dd-5044da5ec489@virtuozzo.com>
 <20180424121516.ihn6lewpidc34ayl@esperanza>
 <402281e6-6fea-3541-1435-a2f81e705e2b@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <402281e6-6fea-3541-1435-a2f81e705e2b@virtuozzo.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009310068873507?=
X-GMAIL-MSGID: =?utf-8?q?1599003019327117736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 03:24:53PM +0300, Kirill Tkhai wrote:
> >>>>>> +int expand_shrinker_maps(int old_nr, int nr)
> >>>>>> +{
> >>>>>> +	int id, size, old_size, node, ret;
> >>>>>> +	struct mem_cgroup *memcg;
> >>>>>> +
> >>>>>> +	old_size = old_nr / BITS_PER_BYTE;
> >>>>>> +	size = nr / BITS_PER_BYTE;
> >>>>>> +
> >>>>>> +	down_write(&shrinkers_max_nr_rwsem);
> >>>>>> +	for_each_node(node) {
> >>>>>
> >>>>> Iterating over cgroups first, numa nodes second seems like a better idea
> >>>>> to me. I think you should fold for_each_node in memcg_expand_maps.
> >>>>>
> >>>>>> +		idr_for_each_entry(&mem_cgroup_idr, memcg, id) {
> >>>>>
> >>>>> Iterating over mem_cgroup_idr looks strange. Why don't you use
> >>>>> for_each_mem_cgroup?
> >>>>
> >>>> We want to allocate shrinkers maps in mem_cgroup_css_alloc(), since
> >>>> mem_cgroup_css_online() mustn't fail (it's a requirement of currently
> >>>> existing design of memcg_cgroup::id).
> >>>>
> >>>> A new memcg is added to parent's list between two of these calls:
> >>>>
> >>>> css_create()
> >>>>   ss->css_alloc()
> >>>>   list_add_tail_rcu(&css->sibling, &parent_css->children)
> >>>>   ss->css_online()
> >>>>
> >>>> for_each_mem_cgroup() does not see allocated, but not linked children.
> >>>
> >>> Why don't we move shrinker map allocation to css_online then?
> >>
> >> Because the design of memcg_cgroup::id prohibits mem_cgroup_css_online() to fail.
> >> This function can't fail.
> > 
> > I fail to understand why it is so. Could you please elaborate?
> 
> mem_cgroup::id is freed not in mem_cgroup_css_free(), but earlier. It's freed
> between mem_cgroup_css_offline() and mem_cgroup_free(), after the last reference
> is put.
> 
> In case of sometimes we want to free it in mem_cgroup_css_free(), this will
> introduce assymmetric in the logic, which makes it more difficult. There is
> already a bug, which I fixed in
> 
> "memcg: remove memcg_cgroup::id from IDR on mem_cgroup_css_alloc() failure"
> 
> new change will make this code completely not-modular and unreadable.

How is that? AFAIU all we need to do to handle css_online failure
properly is call mem_cgroup_id_remove() from mem_cgroup_css_free().
That's it, as mem_cgroup_id_remove() is already safe to call more
than once for the same cgroup - the first call will free the id
while all subsequent calls will do nothing.

>  
> >>
> >> I don't think it will be good to dive into reworking of this stuff for this patchset,
> >> which is really already big. Also, it will be assymmetric to allocate one part of
> >> data in css_alloc(), while another data in css_free(). This breaks cgroup design,
> >> which specially introduces this two function to differ allocation and onlining.
> >> Also, I've just move the allocation to alloc_mem_cgroup_per_node_info() like it was
> >> suggested in comments to v1...
> > 
> > Yeah, but (ab)using mem_cgroup_idr for iterating over all allocated
> > memory cgroups looks rather dubious to me...
> 
> But we have to iterate over all allocated memory cgroups in any way,
> as all of them must have expanded maps. What is the problem?
> It's rather simple method, and it faster then for_each_mem_cgroup()
> cycle, since it does not have to play with get and put of refcounters.

I don't like this, because mem_cgroup_idr was initially introduced to
avoid depletion of css ids by offline cgroups. We could fix that problem
by extending swap_cgroup to UINT_MAX, in which case mem_cgroup_idr
wouldn't be needed at all. Reusing mem_cgroup_idr for iterating over
allocated cgroups deprives us of the ability to reconsider that design
decision in future, neither does it look natural IMO. Besides, in order
to use mem_cgroup_idr for your purpose, you have to reshuffle the code
of mem_cgroup_css_alloc in a rather contrived way IMO.

I agree that allocating parts of struct mem_cgroup in css_online may
look dubious, but IMHO it's better than inventing a new way to iterate
over cgroups instead of using the iterator provided by cgroup core.
May be, you should ask Tejun which way he thinks is better.

Thanks,
Vladimir
