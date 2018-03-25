Return-Path: <quentin.perret@arm.com>
X-Google-Smtp-Source: AIpwx48jSyJsJwvs3ATop8sGcX2ygzKuDfJeemTXIwHSesnU25zZqC+ttwnUsFjtzANuAZC3OFwO
ARC-Seal: i=1; a=rsa-sha256; t=1521942770; cv=none;
        d=google.com; s=arc-20160816;
        b=vs7V25c21qUUsFXQFUfo40/3bln+KnlpVevmL3ub8GvySiFWOjrX/5KiZvR1zpe1qe
         CLbWEZe+DQkCV567eXeRA0KTvl5/6q/t8nh+JiPWSUdhWmakuUqkpARLdN5h5Fbsaz13
         UcRZ+Kf/fSCCxyYZhDb5Zfnm6d5l86KcADubvfJ2kWRdLDYQTRxOrq3HO44e196jvYy7
         d2ITKOaeqJdsyO0Ys4s0xLpZBtZ2Cii+7f+ypQRLgeW2COEyEScpRlraDOVlB5tD9Ipt
         2fgXpgaQw4XhtAR0wMWYN4uwE6kTNZidk03kWRGeIaipzy014kXia075NGsrJ+ITEKSF
         NOrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=lmPo07FpoTNUAG4FxCv5RAZvkGTSfqeVf7zxnsgeGzM=;
        b=LJcpDHIRCtXQjpirX8ip33OWGrIdktHFGk5xEjXXYL/ZJr10wSQNFW1yVc7ianZCsf
         Ze3KSHU3604CPYsn8BQ9qkrZxPzCtoZf7shNAajDELx/HYM2Ah8mipY9sfJwOY1I/EXg
         g0bWwlMGbXMg0C8PDRlZrAnKS0fBibo7JYtmQblVFeJvubqMVJzjBKLegkA3nwHsn4YI
         WXIg6O8IgkKj0lZvXkrTIdcSZUnk2lEgvKDx7FV1PuEyIgG0a4ep191XlPTJHAkqnffi
         fxU1EX0mfVfJooeBoSp99Oh+5UpsQGwl/6jB2L07iEk/7m7Y1Nj4gWqfbeq3Hq9cw+jN
         7fOA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of quentin.perret@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=quentin.perret@arm.com
Date: Sun, 25 Mar 2018 02:52:39 +0100
From: Quentin Perret <quentin.perret@arm.com>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thara Gopinath <thara.gopinath@linaro.org>,
	linux-pm@vger.kernel.org,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
Message-ID: <20180325015238.GB1803@queper01-VirtualBox>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-6-dietmar.eggemann@arm.com>
 <20180321153518.GC13951@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321153518.GC13951@e110439-lin>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449342602746528?=
X-GMAIL-MSGID: =?utf-8?q?1595872662887367668?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wednesday 21 Mar 2018 at 15:35:18 (+0000), Patrick Bellasi wrote:
> On 20-Mar 09:43, Dietmar Eggemann wrote:
> > From: Quentin Perret <quentin.perret@arm.com>
> 
> [...]
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 76bd46502486..65a1bead0773 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6513,6 +6513,60 @@ static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
> >  	return energy;
> >  }
> > 
> > +static bool task_fits(struct task_struct *p, int cpu)
> > +{
> > +	unsigned long next_util = cpu_util_next(cpu, p, cpu);
> > +
> > +	return util_fits_capacity(next_util, capacity_orig_of(cpu));
>                                              ^^^^^^^^^^^^^^^^^^^^^
> 
> Since here we are at scheduling CFS tasks, should we not better use
> capacity_of() to account for RT/IRQ pressure ?

Yes, definitely. I change this in v2.

> 
> > +}
> > +
> > +static int find_energy_efficient_cpu(struct sched_domain *sd,
> > +					struct task_struct *p, int prev_cpu)
> > +{
> > +	unsigned long cur_energy, prev_energy, best_energy;
> > +	int cpu, best_cpu = prev_cpu;
> > +
> > +	if (!task_util(p))
> 
> We are still waking up a task... what if the task was previously
> running on a big CPU which is now idle?
> 
> I understand that from a _relative_ energy_diff standpoint there is
> not much to do for a 0 utilization task. However, for those tasks we
> can still try to return the most energy efficient CPU among the ones
> in their cpus_allowed mask.
> 
> It should be a relatively low overhead (maybe contained in a fallback
> most_energy_efficient_cpu() kind of function) which allows, for
> example on ARM big.LITTLE systems, to consolidate those tasks on
> LITTLE CPUs instead for example keep running them on a big CPU.

Hmmmm so the difficult thing about a task with 0 util is that you don't
know if this is really a small task, or a big task with a very long
period. The only useful thing you know for sure about the task is where
it ran last time, so I guess that makes sense to use that information
rather than make assumptions. There is no perfect solution using the
util_avg of the task.

Now, UTIL_EST is changing the game here. If we use it for task placement
(which I think is the right thing to do), this issue should be a lot
easier to solve. What do you think ?

Thanks,
Quentin
