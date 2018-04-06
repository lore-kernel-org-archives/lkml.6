Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeDFMDH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 08:03:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:44632 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751492AbeDFMDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 08:03:05 -0400
Date: Fri, 6 Apr 2018 14:03:02 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>, vdavydov.dev@gmail.com, guro@fb.com,
        riel@surriel.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcg: make sure memory.events is uptodate when
 waking pollers
Message-ID: <20180406120302.GL8286@dhcp22.suse.cz>
References: <20180324160901.512135-1-tj@kernel.org>
 <20180324160901.512135-2-tj@kernel.org>
 <20180404140855.GA28966@cmpxchg.org>
 <20180404141850.GC28966@cmpxchg.org>
 <20180404143447.GJ6312@dhcp22.suse.cz>
 <20180404165829.GA3126663@devbig577.frc2.facebook.com>
 <20180405175507.GA24817@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405175507.GA24817@cmpxchg.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-04-18 13:55:16, Johannes Weiner wrote:
[...]
> >From 4369ce161a9085aa408f2eca54f9de72909ee1b1 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Thu, 5 Apr 2018 11:53:55 -0400
> Subject: [PATCH] mm: memcg: make sure memory.events is uptodate when waking
>  pollers
> 
> a983b5ebee57 ("mm: memcontrol: fix excessive complexity in memory.stat
> reporting") added per-cpu drift to all memory cgroup stats and events
> shown in memory.stat and memory.events.
> 
> For memory.stat this is acceptable. But memory.events issues file
> notifications, and somebody polling the file for changes will be
> confused when the counters in it are unchanged after a wakeup.
> 
> Luckily, the events in memory.events - MEMCG_LOW, MEMCG_HIGH,
> MEMCG_MAX, MEMCG_OOM - are sufficiently rare and high-level that we
> don't need per-cpu buffering for them: MEMCG_HIGH and MEMCG_MAX would
> be the most frequent, but they're counting invocations of reclaim,
> which is a complex operation that touches many shared cachelines.
> 
> This splits memory.events from the generic VM events and tracks them
> in their own, unbuffered atomic counters. That's also cleaner, as it
> eliminates the ugly enum nesting of VM and cgroup events.

I agree with the patch I am just worried about the naming a bit. It is
quite confusing TBH. events should be vm_events and memory_events should
be limit_events or something like that.

> Fixes: a983b5ebee57 ("mm: memcontrol: fix excessive complexity in memory.stat reporting")
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Anyway
Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
