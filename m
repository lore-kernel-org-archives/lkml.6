Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D6CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D2120841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 05:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D2120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733295AbeHAHjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:39:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:39534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733124AbeHAHjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:39:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 568CDAE77;
        Wed,  1 Aug 2018 05:55:05 +0000 (UTC)
Date:   Wed, 1 Aug 2018 07:55:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm, oom: introduce memory.oom.group
Message-ID: <20180801055503.GB16767@dhcp22.suse.cz>
References: <20180730180100.25079-1-guro@fb.com>
 <20180730180100.25079-4-guro@fb.com>
 <20180731090700.GF4557@dhcp22.suse.cz>
 <20180801011447.GB25953@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801011447.GB25953@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-07-18 18:14:48, Roman Gushchin wrote:
> On Tue, Jul 31, 2018 at 11:07:00AM +0200, Michal Hocko wrote:
> > On Mon 30-07-18 11:01:00, Roman Gushchin wrote:
> > > For some workloads an intervention from the OOM killer
> > > can be painful. Killing a random task can bring
> > > the workload into an inconsistent state.
> > > 
> > > Historically, there are two common solutions for this
> > > problem:
> > > 1) enabling panic_on_oom,
> > > 2) using a userspace daemon to monitor OOMs and kill
> > >    all outstanding processes.
> > > 
> > > Both approaches have their downsides:
> > > rebooting on each OOM is an obvious waste of capacity,
> > > and handling all in userspace is tricky and requires
> > > a userspace agent, which will monitor all cgroups
> > > for OOMs.
> > > 
> > > In most cases an in-kernel after-OOM cleaning-up
> > > mechanism can eliminate the necessity of enabling
> > > panic_on_oom. Also, it can simplify the cgroup
> > > management for userspace applications.
> > > 
> > > This commit introduces a new knob for cgroup v2 memory
> > > controller: memory.oom.group. The knob determines
> > > whether the cgroup should be treated as a single
> > > unit by the OOM killer. If set, the cgroup and its
> > > descendants are killed together or not at all.
> > 
> > I do not want to nit pick on wording but unit is not really a good
> > description. I would expect that to mean that the oom killer will
> > consider the unit also when selecting the task and that is not the case.
> > I would be more explicit about this being a single killable entity
> > because it forms an indivisible workload.
> > 
> > You can reuse http://lkml.kernel.org/r/20180730080357.GA24267@dhcp22.suse.cz
> > if you want.
> 
> Ok, I'll do my best to make it clearer.
> 
> > 
> > [...]
> > > +/**
> > > + * mem_cgroup_get_oom_group - get a memory cgroup to clean up after OOM
> > > + * @victim: task to be killed by the OOM killer
> > > + * @oom_domain: memcg in case of memcg OOM, NULL in case of system-wide OOM
> > > + *
> > > + * Returns a pointer to a memory cgroup, which has to be cleaned up
> > > + * by killing all belonging OOM-killable tasks.
> > 
> > Caller has to call mem_cgroup_put on the returned non-null memcg.
> 
> Added.
> 
> > 
> > > + */
> > > +struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
> > > +					    struct mem_cgroup *oom_domain)
> > > +{
> > > +	struct mem_cgroup *oom_group = NULL;
> > > +	struct mem_cgroup *memcg;
> > > +
> > > +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > > +		return NULL;
> > > +
> > > +	if (!oom_domain)
> > > +		oom_domain = root_mem_cgroup;
> > > +
> > > +	rcu_read_lock();
> > > +
> > > +	memcg = mem_cgroup_from_task(victim);
> > > +	if (!memcg || memcg == root_mem_cgroup)
> > > +		goto out;
> > 
> > When can we have memcg == NULL? victim should be always non-NULL.
> > Also why do you need to special case the root_mem_cgroup here. The loop
> > below should handle that just fine no?
> 
> Idk, I prefer to keep an explicit root_mem_cgroup check,
> rather than traversing the tree and relying on an inability
> to set oom_group on the root.

I will not insist but this just makes the code harder to read.

[...]
> > > +	if (oom_group) {
> > 
> > we want a printk explaining that we are going to tear down the whole
> > oom_group here.
> 
> Does this looks good?
> Or it's better to remove "memory." prefix?
> 
> [   52.835327] Out of memory: Kill process 1221 (allocate) score 241 or sacrifice child
> [   52.836625] Killed process 1221 (allocate) total-vm:2257144kB, anon-rss:2009128kB, file-rss:4kB, shmem-rss:0kB
> [   52.841431] Tasks in /A1 are going to be killed due to memory.oom.group set

Yes, looks good to me.

> [   52.869439] Killed process 1217 (allocate) total-vm:2052344kB, anon-rss:1704036kB, file-rss:0kB, shmem-rss:0kB
> [   52.875601] Killed process 1218 (allocate) total-vm:106668kB, anon-rss:24668kB, file-rss:0kB, shmem-rss:0kB
> [   52.882914] Killed process 1219 (allocate) total-vm:106668kB, anon-rss:21528kB, file-rss:0kB, shmem-rss:0kB
> [   52.891806] Killed process 1220 (allocate) total-vm:2257144kB, anon-rss:1984120kB, file-rss:4kB, shmem-rss:0kB
> [   52.903770] Killed process 1221 (allocate) total-vm:2257144kB, anon-rss:2009128kB, file-rss:4kB, shmem-rss:0kB
> [   52.905574] Killed process 1222 (allocate) total-vm:2257144kB, anon-rss:2063640kB, file-rss:0kB, shmem-rss:0kB
> [   53.202153] oom_reaper: reaped process 1222 (allocate), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> 
> > 
> > > +		mem_cgroup_scan_tasks(oom_group, oom_kill_memcg_member, NULL);
> > > +		mem_cgroup_put(oom_group);
> > > +	}
> > >  }
> > 
> > Other than that looks good to me. My concern that the previous
> > implementation was more consistent because we were comparing memcgs
> > still holds but if there is no way forward that direction this should be
> > acceptable as well.
> > 
> > After above small things are addressed you can add
> > Acked-by: Michal Hocko <mhocko@suse.com> 
> 
> Thank you!

-- 
Michal Hocko
SUSE Labs
