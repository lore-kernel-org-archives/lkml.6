Return-Path: <vdavydov.dev@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524572119; cv=none;
        d=google.com; s=arc-20160816;
        b=pObK+aHyErhxr9ddd52Gz5wLChkS74nwBrsO5DYFW0OCogyX9lza1gqaOe1hMi977r
         /nXcvPkirY2vwMedWE0bgq7oGXcJVOPFhG1dlArlKL+NREO6ZLICWFMVE03VufzgV99p
         y3P6/NLEPQtUf4dZITuH3/tQm+5JgjjycbOZu3zBQszMqNu1HkqSsCCC/Y7easBb1oua
         Guj8MfTkeaUpQEdBCwjX7re1te4MWoc/YXzDG56ekpz6zfmWR4VbVC/cpN+SbtTeFrVM
         wo5chbZUZHed4jsrBbfvmz/sfQ+0IDa1oNE6/Ka+nznzu3csfKDOvVGu4hBPVY1TEbXK
         +dzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:dkim-signature:arc-authentication-results;
        bh=59GXguP/iACvp3qhrW1yKZEP5Oxqbiw2JekNWrZaKVw=;
        b=udeu4FI807QRmoftMwKxpOZvVkSWIekoVo78JqkuGu3cKXe1ZPBe60aizHTpXOvL3V
         t5S4/dKy8jRkrHry5ah6gAUDUjfhyksvHquQBrZIi9t55O1NQOVTp5MOsVKz6TLXsWeI
         MEogACzNEh7P/Dmf6lEheomDdUy4ve5Yh1KXOmnv5yfWj3oiHHza5gQCNLwcRy3cs3nb
         CpQp0gJmV88waKB1cZ/prfEf/i1UUCBqu72MDgFxjFjAwb35QpNxniZ761gj5DMi47po
         z0+FiH9GjvqLGfhCZHdBnIb7VDO9DtNattxHYWVIPR86t+0jW4IzKal7rjdikFttgyF1
         l3pw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hQ68v7+T;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hQ68v7+T;
       spf=pass (google.com: domain of vdavydov.dev@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=vdavydov.dev@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49Ccde6hJeKgjgzrerVnTiAFrfI9qvviQb80SDLWc/NfCuSxZtoeLXYmfYCrDCMEhuGp9FntA==
Date: Tue, 24 Apr 2018 15:15:16 +0300
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
Message-ID: <20180424121516.ihn6lewpidc34ayl@esperanza>
References: <152397794111.3456.1281420602140818725.stgit@localhost.localdomain>
 <152399121146.3456.5459546288565589098.stgit@localhost.localdomain>
 <20180422175900.dsjmm7gt2nsqj3er@esperanza>
 <14ebcccf-3ea8-59f4-d7ea-793aaba632c0@virtuozzo.com>
 <20180424112844.626madzs4cwoz5gh@esperanza>
 <7bf5372d-7d9d-abee-27dd-5044da5ec489@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bf5372d-7d9d-abee-27dd-5044da5ec489@virtuozzo.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009310068873507?=
X-GMAIL-MSGID: =?utf-8?q?1598629734782043068?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 02:38:51PM +0300, Kirill Tkhai wrote:
> On 24.04.2018 14:28, Vladimir Davydov wrote:
> > On Mon, Apr 23, 2018 at 01:54:50PM +0300, Kirill Tkhai wrote:
> >>>> @@ -1200,6 +1206,8 @@ extern int memcg_nr_cache_ids;
> >>>>  void memcg_get_cache_ids(void);
> >>>>  void memcg_put_cache_ids(void);
> >>>>  
> >>>> +extern int shrinkers_max_nr;
> >>>> +
> >>>
> >>> memcg_shrinker_id_max?
> >>
> >> memcg_shrinker_id_max sounds like an includive value, doesn't it?
> >> While shrinker->id < shrinker_max_nr.
> >>
> >> Let's better use memcg_shrinker_nr_max.
> > 
> > or memcg_nr_shrinker_ids (to match memcg_nr_cache_ids), not sure...
> > 
> > Come to think of it, this variable is kinda awkward: it is defined in
> > vmscan.c but declared in memcontrol.h; it is used by vmscan.c for max
> > shrinker id and by memcontrol.c for shrinker map capacity. Just a raw
> > idea: what about splitting it in two: one is private to vmscan.c, used
> > as max id, say we call it shrinker_id_max; the other is defined in
> > memcontrol.c and is used for shrinker map capacity, say we call it
> > memcg_shrinker_map_capacity. What do you think?
> 
> I don't much like a duplication of the single variable...

Well, it's not really a duplication. For example, shrinker_id_max could
decrease when a shrinker is unregistered while shrinker_map_capacity can
only grow exponentially.

> Are there real problems, if it defined in memcontrol.{c,h} and use in
> both of the places?

The code is more difficult to follow when variables are shared like that
IMHO. I suggest you try it and see how it looks. May be, it will only
get worse and we'll have to revert to what we have now. Difficult to say
without seeing the code.

>  
> >>>> +int expand_shrinker_maps(int old_nr, int nr)
> >>>> +{
> >>>> +	int id, size, old_size, node, ret;
> >>>> +	struct mem_cgroup *memcg;
> >>>> +
> >>>> +	old_size = old_nr / BITS_PER_BYTE;
> >>>> +	size = nr / BITS_PER_BYTE;
> >>>> +
> >>>> +	down_write(&shrinkers_max_nr_rwsem);
> >>>> +	for_each_node(node) {
> >>>
> >>> Iterating over cgroups first, numa nodes second seems like a better idea
> >>> to me. I think you should fold for_each_node in memcg_expand_maps.
> >>>
> >>>> +		idr_for_each_entry(&mem_cgroup_idr, memcg, id) {
> >>>
> >>> Iterating over mem_cgroup_idr looks strange. Why don't you use
> >>> for_each_mem_cgroup?
> >>
> >> We want to allocate shrinkers maps in mem_cgroup_css_alloc(), since
> >> mem_cgroup_css_online() mustn't fail (it's a requirement of currently
> >> existing design of memcg_cgroup::id).
> >>
> >> A new memcg is added to parent's list between two of these calls:
> >>
> >> css_create()
> >>   ss->css_alloc()
> >>   list_add_tail_rcu(&css->sibling, &parent_css->children)
> >>   ss->css_online()
> >>
> >> for_each_mem_cgroup() does not see allocated, but not linked children.
> > 
> > Why don't we move shrinker map allocation to css_online then?
> 
> Because the design of memcg_cgroup::id prohibits mem_cgroup_css_online() to fail.
> This function can't fail.

I fail to understand why it is so. Could you please elaborate?

> 
> I don't think it will be good to dive into reworking of this stuff for this patchset,
> which is really already big. Also, it will be assymmetric to allocate one part of
> data in css_alloc(), while another data in css_free(). This breaks cgroup design,
> which specially introduces this two function to differ allocation and onlining.
> Also, I've just move the allocation to alloc_mem_cgroup_per_node_info() like it was
> suggested in comments to v1...

Yeah, but (ab)using mem_cgroup_idr for iterating over all allocated
memory cgroups looks rather dubious to me...
