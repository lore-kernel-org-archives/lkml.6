Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753137AbeD0LZs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:25:48 -0400
Received: from foss.arm.com ([217.140.101.70]:38804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752061AbeD0LZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:25:46 -0400
Date: Fri, 27 Apr 2018 12:25:43 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/fair: Avoid calling sync_entity_load_avg()
 unnecessarily
Message-ID: <20180427112543.GB27072@e108498-lin.cambridge.arm.com>
References: <20831b8d237bf3a20e4e328286f678b425ff04c9.1524738578.git.viresh.kumar@linaro.org>
 <cd019d1753824c81130eae7b43e2bbcec47cc1ad.1524738578.git.viresh.kumar@linaro.org>
 <c1dba90d-d464-9286-94e3-e399f0b71281@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1dba90d-d464-9286-94e3-e399f0b71281@arm.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On Friday 27 Apr 2018 at 10:30:39 (+0200), Dietmar Eggemann wrote:
> Hi Viresh,
> 
> On 04/26/2018 12:30 PM, Viresh Kumar wrote:
> > Call sync_entity_load_avg() directly from find_idlest_cpu() instead of
> > select_task_rq_fair(), as that's where we need to use task's utilization
> > value. And call sync_entity_load_avg() only after making sure sched
> > domain spans over one of the allowed CPUs for the task.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> The patch looks correct to me but we want to have the waking task synced
> against its previous rq also for EAS, i.e. for find_energy_efficient_cpu()
> which will sit next to find_idlest_cpu().
> 
> https://marc.info/?l=linux-kernel&m=152302907327168&w=2
> 
> The comment on top of the if condition would have to be changed though.
> 
> I would suggest we leave the call to sync_entity_load_avg() in the slow path
> of strf() so that we're not forced to call it in
> find_energy_efficient_cpu().

With the new implementation of the overutilization mechanism agreed at
OSPM, I don't think we'll be able to avoid calling sync_entity_load_avg()
from find_energy_efficient_cpu(). The EAS integration within strf()
will have to be reworked, so I'm happy if the sync_entity_load_avg()
call moves from strf() to find_idlest_cpu() in the meantime.

Thanks,
Quentin

> 
> > ---
> >   kernel/sched/fair.c | 16 +++++++---------
> >   1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 84fc74ddbd4b..5b1b4f91f132 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6199,6 +6199,13 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
> >   	if (!cpumask_intersects(sched_domain_span(sd), &p->cpus_allowed))
> >   		return prev_cpu;
> > +	/*
> > +	 * We need task's util for capacity_spare_wake, sync it up to prev_cpu's
> > +	 * last_update_time.
> > +	 */
> > +	if (!(sd_flag & SD_BALANCE_FORK))
> > +		sync_entity_load_avg(&p->se);
> > +
> >   	while (sd) {
> >   		struct sched_group *group;
> >   		struct sched_domain *tmp;
> > @@ -6651,15 +6658,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
> >   	if (unlikely(sd)) {
> >   		/* Slow path */
> > -
> > -		/*
> > -		 * We're going to need the task's util for capacity_spare_wake
> > -		 * in find_idlest_group. Sync it up to prev_cpu's
> > -		 * last_update_time.
> > -		 */
> > -		if (!(sd_flag & SD_BALANCE_FORK))
> > -			sync_entity_load_avg(&p->se);
> > -
> >   		new_cpu = find_idlest_cpu(sd, p, cpu, prev_cpu, sd_flag);
> >   	} else if (sd_flag & SD_BALANCE_WAKE) { /* XXX always ? */
> >   		/* Fast path */
> > 
> 
