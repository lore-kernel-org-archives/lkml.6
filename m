Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbeDDORd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 10:17:33 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:50000 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750853AbeDDORc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 10:17:32 -0400
Date: Wed, 4 Apr 2018 10:18:50 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Tejun Heo <tj@kernel.org>
Cc: mhocko@kernel.org, vdavydov.dev@gmail.com, guro@fb.com,
        riel@surriel.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm: memcontrol: Use cgroup_rstat for event accounting
Message-ID: <20180404141850.GC28966@cmpxchg.org>
References: <20180324160901.512135-1-tj@kernel.org>
 <20180324160901.512135-2-tj@kernel.org>
 <20180404140855.GA28966@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404140855.GA28966@cmpxchg.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 10:08:55AM -0400, Johannes Weiner wrote:
> On Sat, Mar 24, 2018 at 09:08:59AM -0700, Tejun Heo wrote:
> > @@ -91,6 +91,9 @@ struct mem_cgroup_stat_cpu {
> >  	unsigned long events[MEMCG_NR_EVENTS];
> >  	unsigned long nr_page_events;
> >  	unsigned long targets[MEM_CGROUP_NTARGETS];
> > +
> > +	/* for cgroup rstat delta calculation */
> > +	unsigned long last_events[MEMCG_NR_EVENTS];
> >  };
> >  
> >  struct mem_cgroup_reclaim_iter {
> > @@ -233,7 +236,11 @@ struct mem_cgroup {
> >  
> >  	struct mem_cgroup_stat_cpu __percpu *stat_cpu;
> >  	atomic_long_t		stat[MEMCG_NR_STAT];
> > -	atomic_long_t		events[MEMCG_NR_EVENTS];
> > +
> > +	/* events is managed by cgroup rstat */
> > +	unsigned long long	events[MEMCG_NR_EVENTS];	/* local */
> > +	unsigned long long	tree_events[MEMCG_NR_EVENTS];	/* subtree */
> > +	unsigned long long	pending_events[MEMCG_NR_EVENTS];/* propagation */
> 
> The lazy updates are neat, but I'm a little concerned at the memory
> footprint. On a 64-cpu machine for example, this adds close to 9000
> words to struct mem_cgroup. And we really only need the accuracy for
> the 4 cgroup items in memory.events, not all VM events and stats.
> 
> Why not restrict the patch to those? It would also get rid of the
> weird sharing between VM and cgroup enums.

In fact, I wonder if we need per-cpuness for MEMCG_LOW, MEMCG_HIGH
etc. in the first place. They describe super high-level reclaim and
OOM events, so they're not nearly as hot as other VM events and
stats. We could probably just have a per-memcg array of atomics.
