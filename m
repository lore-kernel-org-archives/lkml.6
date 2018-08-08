Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4864CC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0183121723
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0183121723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeHHSiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:38:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:50032 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727062AbeHHSiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:38:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DF6F8AD70;
        Wed,  8 Aug 2018 16:17:39 +0000 (UTC)
Date:   Wed, 8 Aug 2018 18:17:37 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] memcg, oom: emit oom report when there is no
 eligible task
Message-ID: <20180808161737.GQ27972@dhcp22.suse.cz>
References: <20180808064414.GA27972@dhcp22.suse.cz>
 <20180808071301.12478-1-mhocko@kernel.org>
 <20180808071301.12478-3-mhocko@kernel.org>
 <20180808144515.GA9276@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808144515.GA9276@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-08-18 10:45:15, Johannes Weiner wrote:
> On Wed, Aug 08, 2018 at 09:13:01AM +0200, Michal Hocko wrote:
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > Johannes had doubts that the current WARN in the memcg oom path
> > when there is no eligible task is not all that useful because it doesn't
> > really give any useful insight into the memcg state. My original
> > intention was to make this lightweight but it is true that seeing
> > a stack trace will likely be not sufficient when somebody gets back to
> > us and report this warning.
> > 
> > Therefore replace the current warning by the full oom report which will
> > give us not only the back trace of the offending path but also the full
> > memcg state - memory counters and existing tasks.
> > 
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  include/linux/oom.h |  2 ++
> >  mm/memcontrol.c     | 24 +++++++++++++-----------
> >  mm/oom_kill.c       |  8 ++++----
> >  3 files changed, 19 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/oom.h b/include/linux/oom.h
> > index a16a155a0d19..7424f9673cd1 100644
> > --- a/include/linux/oom.h
> > +++ b/include/linux/oom.h
> > @@ -133,6 +133,8 @@ extern struct task_struct *find_lock_task_mm(struct task_struct *p);
> >  
> >  extern int oom_evaluate_task(struct task_struct *task, void *arg);
> >  
> > +extern void dump_oom_header(struct oom_control *oc, struct task_struct *victim);
> > +
> >  /* sysctls */
> >  extern int sysctl_oom_dump_tasks;
> >  extern int sysctl_oom_kill_allocating_task;
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c80e5b6a8e9f..3d7c90e6c235 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1390,6 +1390,19 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >  	mutex_lock(&oom_lock);
> >  	ret = out_of_memory(&oc);
> >  	mutex_unlock(&oom_lock);
> > +
> > +	/*
> > +	 * under rare race the current task might have been selected while
> > +	 * reaching mem_cgroup_out_of_memory and there is no other oom victim
> > +	 * left. There is still no reason to warn because this task will
> > +	 * die and release its bypassed charge eventually.
> 
> "rare race" is a bit vague. Can we describe the situation?
> 
> 	/*
> 	 * We killed and reaped every task in the group, and still no
> 	 * luck with the charge. This is likely the result of a crazy
> 	 * configuration, let the user know.
> 	 *
> 	 * With one exception: current is the last task, it's already
> 	 * been killed and reaped, but that wasn't enough to satisfy
> 	 * the charge request under the configured limit. In that case
> 	 * let it bypass quietly and current exit.
> 	 */

Sounds good.

> And after spelling that out, I no longer think we want to skip the OOM
> header in that situation. The first paragraph still applies: this is
> probably a funny configuration, we're going to bypass the charge, let
> the user know that we failed containment - to help THEM identify by
> themselves what is likely an easy to fix problem.
> 
> > +	 */
> > +	if (tsk_is_oom_victim(current))
> > +		return ret;
> > +
> > +	pr_warn("Memory cgroup charge failed because of no reclaimable memory! "
> > +		"This looks like a misconfiguration or a kernel bug.");
> > +	dump_oom_header(&oc, NULL);
> 
> All other sites print the context first before printing the
> conclusion, we should probably do the same here.
> 
> I'd also prefer keeping the message in line with the global case when
> no eligible tasks are left. There is no need to speculate whose fault
> this could be, that's apparent from the OOM header. If the user can't
> figure it out from the OOM header, they'll still report it to us.
> 
> How about this?
> 
> ---
> 
> >From bba01122f739b05a689dbf1eeeb4f0e07affd4e7 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Wed, 8 Aug 2018 09:59:40 -0400
> Subject: [PATCH] mm: memcontrol: print proper OOM header when no eligible
>  victim left
> 
> When the memcg OOM killer runs out of killable tasks, it currently
> prints a WARN with no further OOM context. This has caused some user
> confusion.
> 
> Warnings indicate a kernel problem. In a reported case, however, the
> situation was triggered by a non-sensical memcg configuration (hard
> limit set to 0). But without any VM context this wasn't obvious from
> the report, and it took some back and forth on the mailing list to
> identify what is actually a trivial issue.
> 
> Handle this OOM condition like we handle it in the global OOM killer:
> dump the full OOM context and tell the user we ran out of tasks.
> 
> This way the user can identify misconfigurations easily by themselves
> and rectify the problem - without having to go through the hassle of
> running into an obscure but unsettling warning, finding the
> appropriate kernel mailing list and waiting for a kernel developer to
> remote-analyze that the memcg configuration caused this.
> 
> If users cannot make sense of why the OOM killer was triggered or why
> it failed, they will still report it to the mailing list, we know that
> from experience. So in case there is an actual kernel bug causing
> this, kernel developers will very likely hear about it.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Yes this works as well. We would get a dump even for the race we have
seen but I do not think this is something to lose sleep over. And if it
triggers too often to be disturbing we can add
tsk_is_oom_victim(current) check there.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c |  2 --
>  mm/oom_kill.c   | 13 ++++++++++---
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4e3c1315b1de..29d9d1a69b36 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1701,8 +1701,6 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
>  	if (mem_cgroup_out_of_memory(memcg, mask, order))
>  		return OOM_SUCCESS;
>  
> -	WARN(1,"Memory cgroup charge failed because of no reclaimable memory! "
> -		"This looks like a misconfiguration or a kernel bug.");
>  	return OOM_FAILED;
>  }
>  
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 0e10b864e074..07ae222d7830 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1103,10 +1103,17 @@ bool out_of_memory(struct oom_control *oc)
>  	}
>  
>  	select_bad_process(oc);
> -	/* Found nothing?!?! Either we hang forever, or we panic. */
> -	if (!oc->chosen && !is_sysrq_oom(oc) && !is_memcg_oom(oc)) {
> +	/* Found nothing?!?! */
> +	if (!oc->chosen) {
>  		dump_header(oc, NULL);
> -		panic("Out of memory and no killable processes...\n");
> +		pr_warn("Out of memory and no killable processes...\n");
> +		/*
> +		 * If we got here due to an actual allocation at the
> +		 * system level, we cannot survive this and will enter
> +		 * an endless loop in the allocator. Bail out now.
> +		 */
> +		if (!is_sysrq_oom(oc) && !is_memcg_oom(oc))
> +			panic("System is deadlocked on memory\n");
>  	}
>  	if (oc->chosen && oc->chosen != (void *)-1UL)
>  		oom_kill_process(oc, !is_memcg_oom(oc) ? "Out of memory" :
> -- 
> 2.18.0
> 

-- 
Michal Hocko
SUSE Labs
