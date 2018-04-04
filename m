Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDDQ6g (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:58:36 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:37232 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752069AbeDDQ6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:58:34 -0400
X-Google-Smtp-Source: AIpwx4+YKnJfGE2H4dN6LI9V3XCGvpyGBMWiPoS+Coa1rFQMrbCF9ZIjb9F+0Zzi8GO6fK1JTFzPZg==
Date: Wed, 4 Apr 2018 09:58:29 -0700
From: Tejun Heo <tj@kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, vdavydov.dev@gmail.com,
        guro@fb.com, riel@surriel.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] mm: memcontrol: Use cgroup_rstat for event accounting
Message-ID: <20180404165829.GA3126663@devbig577.frc2.facebook.com>
References: <20180324160901.512135-1-tj@kernel.org>
 <20180324160901.512135-2-tj@kernel.org>
 <20180404140855.GA28966@cmpxchg.org>
 <20180404141850.GC28966@cmpxchg.org>
 <20180404143447.GJ6312@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404143447.GJ6312@dhcp22.suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Apr 04, 2018 at 04:34:47PM +0200, Michal Hocko wrote:
> > > The lazy updates are neat, but I'm a little concerned at the memory
> > > footprint. On a 64-cpu machine for example, this adds close to 9000
> > > words to struct mem_cgroup. And we really only need the accuracy for
> > > the 4 cgroup items in memory.events, not all VM events and stats.
> > > 
> > > Why not restrict the patch to those? It would also get rid of the
> > > weird sharing between VM and cgroup enums.
> > 
> > In fact, I wonder if we need per-cpuness for MEMCG_LOW, MEMCG_HIGH
> > etc. in the first place. They describe super high-level reclaim and
> > OOM events, so they're not nearly as hot as other VM events and
> > stats. We could probably just have a per-memcg array of atomics.
> 
> Agreed!

Ah, yeah, if we aren't worried about the update frequency of
MEMCG_HIGH, which likely is the highest freq, we can just switch to
atomic_t.  I'm gonna apply the cgroup stat refactoring patches to
cgroup, so if we ever wanna switch the counter to rstat, we can easily
do that later.

Thasnks.

-- 
tejun
