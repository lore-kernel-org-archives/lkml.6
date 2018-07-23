Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AE6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533E020852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533E020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388664AbeGWQmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:42:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35908 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388144AbeGWQmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:42:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 682E380D;
        Mon, 23 Jul 2018 08:40:30 -0700 (PDT)
Received: from e110439-lin (e110439-lin.Emea.Arm.com [10.4.12.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD7143F237;
        Mon, 23 Jul 2018 08:40:27 -0700 (PDT)
Date:   Mon, 23 Jul 2018 16:40:25 +0100
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Paul Turner <pjt@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Subject: Re: [PATCH v2 10/12] sched/core: uclamp: use TG's clamps to restrict
 Task's clamps
Message-ID: <20180723154025.GF2683@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-11-patrick.bellasi@arm.com>
 <CAJuCfpFnj2g3+ZpR4fP4yqfxs0zd=c-Zehr2XM7m_C+WdL9jNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFnj2g3+ZpR4fP4yqfxs0zd=c-Zehr2XM7m_C+WdL9jNA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-Jul 20:05, Suren Baghdasaryan wrote:
> On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:
> > When a task's util_clamp value is configured via sched_setattr(2), this
> > value has to be properly accounted in the corresponding clamp group
> > every time the task is enqueued and dequeued. When cgroups are also in
> > use, per-task clamp values have to be aggregated to those of the CPU's
> > controller's Task Group (TG) in which the task is currently living.
> >
> > Let's update uclamp_cpu_get() to provide aggregation between the task
> > and the TG clamp values. Every time a task is enqueued, it will be
> > accounted in the clamp_group which defines the smaller clamp between the
> > task specific value and its TG value.
> 
> So choosing smallest for both UCLAMP_MIN and UCLAMP_MAX means the
> least boosted value and the most clamped value between syscall and TG
> will be used.

Right

> My understanding is that boost means "at least this much" and clamp
> means "at most this much".

Right

> So to satisfy both TG and syscall requirements I think you would
> need to choose the largest value for UCLAMP_MIN and the smallest one
> for UCLAMP_MAX, meaning the most boosted and most clamped range.
> Current implementation choses the least boosted value, so
> effectively one of the UCLAMP_MIN requirements (either from TG or
> from syscall) are being ignored...  Could you please clarify why
> this choice is made?

The TG values are always used to specify a _restriction_ on
task-specific values.

Thus, if you look or example at the CPU mask for a task, you can have
a task with affinity to CPUs 0-1, currently running on a cgroup with
cpuset.cpus=0... then the task can run only on CPU 0 (althought its
affinity includes CPU1 too).

Same we do here: if a task has util_min=10, but it's running in a
cgroup with cpu.util_min=0, then it will not be boosted.

IOW, this allows to implement a "nice" policy at task level, where a
task (via syscall) can decide to be less boosted with respect to its
group but never more boosted. The same task can also decide to be more
clamped, but not less clamped then its current group.

[...]

> > @@ -982,18 +989,30 @@ static inline void uclamp_cpu_get_id(struct task_struct *p,
> >         int clamp_value;
> >         int group_id;
> >
> > -       /* No task specific clamp values: nothing to do */
> >         group_id = p->uclamp[clamp_id].group_id;
> > +       clamp_value = p->uclamp[clamp_id].value;
> > +#ifdef CONFIG_UCLAMP_TASK_GROUP
> > +       /* Use TG's clamp value to limit task specific values */
> > +       if (group_id == UCLAMP_NONE ||
> > +           clamp_value >= task_group(p)->uclamp[clamp_id].value) {
> 
> Not a big deal but do you need to override if (clamp_value ==
> task_group(p)->uclamp[clamp_id].value)? Maybe:
> -           clamp_value >= task_group(p)->uclamp[clamp_id].value) {
> +          clamp_value > task_group(p)->uclamp[clamp_id].value) {

Good point, yes... the override is not really changing anything here.
Will fix this!

> > +               clamp_value = task_group(p)->uclamp[clamp_id].value;
> > +               group_id = task_group(p)->uclamp[clamp_id].group_id;
> > +       }
> > +#else
> > +       /* No task specific clamp values: nothing to do */
> >         if (group_id == UCLAMP_NONE)
> >                 return;
> > +#endif
> >
> >         /* Reference count the task into its current group_id */
> >         uc_grp = &rq->uclamp.group[clamp_id][0];
> >         uc_grp[group_id].tasks += 1;
> >
> > +       /* Track the effective clamp group */
> > +       p->uclamp_group_id[clamp_id] = group_id;
> > +
> >         /* Force clamp update on idle exit */
> >         uc_cpu = &rq->uclamp;
> > -       clamp_value = p->uclamp[clamp_id].value;
> >         if (unlikely(uc_cpu->flags & UCLAMP_FLAG_IDLE)) {
> >                 if (clamp_id == UCLAMP_MAX)
> >                         uc_cpu->flags &= ~UCLAMP_FLAG_IDLE;

[...]

-- 
#include <best/regards.h>

Patrick Bellasi
