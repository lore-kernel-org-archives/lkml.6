Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeEPWkp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 18:40:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:53564 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbeEPWko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 18:40:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,407,1520924400";
   d="scan'208";a="42400844"
Message-ID: <1526510439.61700.109.camel@linux.intel.com>
Subject: Re: [RFC/RFT] [PATCH 06/10] cpufreq / sched: Add interface to get
 utilization values
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com,
        linux-kernel@vger.kernel.org
Date: Wed, 16 May 2018 15:40:39 -0700
In-Reply-To: <20180516081155.GA12217@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
         <20180516044911.28797-7-srinivas.pandruvada@linux.intel.com>
         <20180516081155.GA12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-16 at 10:11 +0200, Peter Zijlstra wrote:
> On Tue, May 15, 2018 at 09:49:07PM -0700, Srinivas Pandruvada wrote:
> > --- a/kernel/sched/cpufreq.c
> > +++ b/kernel/sched/cpufreq.c
> > @@ -60,3 +60,26 @@ void cpufreq_remove_update_util_hook(int cpu)
> >  	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu),
> > NULL);
> >  }
> >  EXPORT_SYMBOL_GPL(cpufreq_remove_update_util_hook);
> > +
> > +/**
> > + * cpufreq_get_sched_util - Get utilization values.
> > + * @cpu: The targeted CPU.
> > + *
> > + * Get the CFS, DL and max utilization.
> > + * This function allows cpufreq driver outside the kernel/sched to
> > access
> > + * utilization value for a CPUs run queue.
> > + */
> > +void cpufreq_get_sched_util(int cpu, unsigned long *util_cfs,
> > +			    unsigned long *util_dl, unsigned long
> > *max)
> > +{
> > +#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> > +	struct rq *rq = cpu_rq(cpu);
> > +
> > +	*max = arch_scale_cpu_capacity(NULL, cpu);
> > +	*util_cfs = cpu_util_cfs(rq);
> > +	*util_dl  = cpu_util_dl(rq);
> > +#else
> > +	*util_cfs = *util_dl = 1;
> > +#endif
> > +}
> > +EXPORT_SYMBOL_GPL(cpufreq_get_sched_util);
> 
> So I _really_ hate this... I'd much rather you make schedutil work
> with
> the hwp passive stuff.
Are you not happy with ifdefs are utility function itself? Can you
explain more how this should be done?

utilization values are not passed with scheduler update util callback.
So need to have access to rq->cfs.avg.util* and rq->dl.running_bw
access from intel_pstate.
The ifdefs can be removed, if we remove ifdefs for cpu_util_dl() or
cpu_util_cfs(), which are not doing anything special other than
accessing rq->cfs.avg.util* and rq->dl.running_bw. I think it is better
to remove from these functions.

> 
> Also, afaict intel_pstate is bool, not tristate, so no need for an
> EXPORT at all.
Correct. I am just following other interface functions for sched util
hooks in this file which are using EXPORT.
But I will remove EXPORT in the next revision.

Thanks,
Srinivas
