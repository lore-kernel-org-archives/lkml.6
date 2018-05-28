Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969220AbeE1Ppt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:45:49 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:34186 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968684AbeE1Ppq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:45:46 -0400
Date: Mon, 28 May 2018 08:45:16 -0700
From: Paul Burton <paul.burton@mips.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/2] sched: Make select_task_rq() require cpu_active()
 for user tasks
Message-ID: <20180528154516.c54b37ygekcn3p4g@pburton-laptop>
References: <20180526154648.11635-1-paul.burton@mips.com>
 <20180526154648.11635-2-paul.burton@mips.com>
 <20180528144924.GE12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180528144924.GE12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1527522316-321458-31141-136399-1
X-BESS-VER: 2018.6-r1805181819
X-BESS-Apparent-Source-IP: 12.201.5.33
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193454
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, May 28, 2018 at 04:49:24PM +0200, Peter Zijlstra wrote:
> On Sat, May 26, 2018 at 08:46:47AM -0700, Paul Burton wrote:
> 
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1565,7 +1565,8 @@ int select_task_rq(struct task_struct *p, int cpu, int sd_flags, int wake_flags)
> >  	 *   not worry about this generic constraint ]
> >  	 */
> >  	if (unlikely(!cpumask_test_cpu(cpu, &p->cpus_allowed) ||
> > -		     !cpu_online(cpu)))
> > +		     !cpu_online(cpu) ||
> > +		     (!cpu_active(cpu) && !(p->flags & PF_KTHREAD))))
> >  		cpu = select_fallback_rq(task_cpu(p), p);
> 
> That is not quite right.. and I find that the wrong patch:
> 
>   955dbdf4ce87 ("sched: Allow migrating kthreads into online but inactive CPUs")
> 
> got merged over my suggested alternative :-(
> 
>   http://lkml.kernel.org/r/20170725165821.cejhb7v2s3kecems@hirez.programming.kicks-ass.net
> 
> So, lets first fix that

Thanks for the link - just knowing that the intention is that only
per-CPU kthreads are allowed on !active CPUs is useful.

> , and then your patch becomes something like the below I think.
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1562,7 +1562,7 @@ int select_task_rq(struct task_struct *p
>  	 *   not worry about this generic constraint ]
>  	 */
>  	if (unlikely(!cpumask_test_cpu(cpu, &p->cpus_allowed) ||
> -		     !cpu_online(cpu)))
> +		     (is_per_cpu_kthread(p) ? !cpu_online(cpu) : !cpu_active(cpu)))
>  		cpu = select_fallback_rq(task_cpu(p), p);
>  
>  	return cpu;

Yes this looks good to me.

Are you planning to submit your change to introduce
is_per_cpu_kthread(), or shall I?

Thanks,
    Paul
