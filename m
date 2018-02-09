Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751195AbeBIMfw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:35:52 -0500
Received: from merlin.infradead.org ([205.233.59.134]:53260 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbeBIMfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:35:51 -0500
Date: Fri, 9 Feb 2018 13:35:39 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Joel Fernandes <joelaf@google.com>
Cc: Rohit Jain <rohit.k.jain@oracle.com>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        "Cc: EAS Dev" <eas-dev@lists.linaro.org>
Subject: Re: [RESEND PATCH] sched/fair: consider RT/IRQ pressure in
 select_idle_sibling
Message-ID: <20180209123539.GM25201@hirez.programming.kicks-ass.net>
References: <1517268429-933-1-git-send-email-rohit.k.jain@oracle.com>
 <CAJWu+opnNgfVxhgHwLft_qcLMeikEAbNY0zci0WtgQiFkVVjhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+opnNgfVxhgHwLft_qcLMeikEAbNY0zci0WtgQiFkVVjhg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 07:39:15PM -0800, Joel Fernandes wrote:

> > @@ -6081,7 +6086,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
> >
> >                 for_each_cpu(cpu, cpu_smt_mask(core)) {
> >                         cpumask_clear_cpu(cpu, cpus);
> > -                       if (!idle_cpu(cpu))
> > +                       if (!idle_cpu(cpu) || !full_capacity(cpu))
> >                                 idle = false;
> >                 }
> 
> There's some difference in logic between select_idle_core and
> select_idle_cpu as far as the full_capacity stuff you're adding goes.
> In select_idle_core, if all CPUs are !full_capacity, you're returning
> -1. But in select_idle_cpu you're returning the best idle CPU that's
> the most cap among the !full_capacity ones. Why there is this
> different in logic? Did I miss something?

select_idle_core() wants to find a whole core that's idle, the way he
changed it we'll not consider a core idle if one (or more) of the
siblings have a heavy IRQ load.

select_idle_cpu() just wants an idle (logical) CPU, and here it looks
for 

> >
> > @@ -6102,7 +6107,8 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
> >   */
> >  static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int target)
> >  {
> > -       int cpu;
> > +       int cpu, rcpu = -1;
> > +       unsigned long max_cap = 0;
> >
> >         if (!static_branch_likely(&sched_smt_present))
> >                 return -1;
> > @@ -6110,11 +6116,13 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
> >         for_each_cpu(cpu, cpu_smt_mask(target)) {
> >                 if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> >                         continue;
> > -               if (idle_cpu(cpu))
> > -                       return cpu;
> > +               if (idle_cpu(cpu) && (capacity_of(cpu) > max_cap)) {
> > +                       max_cap = capacity_of(cpu);
> > +                       rcpu = cpu;
> 
> At the SMT level, do you need to bother with choosing best capacity
> among threads? If RT is eating into one of the SMT thread's underlying
> capacity, it would eat into the other's. Wondering what's the benefit
> of doing this here.

Its about latency mostly I think; scheduling on the other sibling gets
you to run faster -- the core will interleave the SMT threads and you
don't get to suffer the interrupt load _as_bad_.

If people really cared about their RT workload, they would not allow
regular tasks on its siblings in any case.
