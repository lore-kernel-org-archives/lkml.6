Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751321AbeEDDiv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 23:38:51 -0400
Received: from mout.gmx.net ([212.227.15.19]:56577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751229AbeEDDiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 23:38:50 -0400
Message-ID: <1525405098.5618.3.camel@gmx.de>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Date: Fri, 04 May 2018 05:38:18 +0200
In-Reply-To: <20180503164508.GG12217@hirez.programming.kicks-ass.net>
References: <20180424133325.GA3179@codeblueprint.co.uk>
         <1525349542.9956.2.camel@gmx.de>
         <20180503122808.GZ12217@hirez.programming.kicks-ass.net>
         <1525351221.9956.4.camel@gmx.de>
         <20180503124943.GB12217@hirez.programming.kicks-ass.net>
         <1525354359.5576.1.camel@gmx.de>
         <20180503135617.GC12217@hirez.programming.kicks-ass.net>
         <1525357015.5577.2.camel@gmx.de>
         <20180503144450.GD12217@hirez.programming.kicks-ass.net>
         <20180503161231.GI26088@linux.vnet.ibm.com>
         <20180503164508.GG12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:SGjlPqq17yrn98Xz7lZjcYgt32fb9K9SmEYelL7TEN4sKqgB1JU
 N/mqIwF1rTYtTFqfd1TsFBftwOCY7Y04Rogi4svNETLj97Q0Z6c/2kcZ0/6WDLjMyDgUdxr
 H+9QuTvrldITVteST5NiyEvfeAGdrZqRq9vUGNmlzt5PiZL9bC9jxgixmx7f5gPlqBroj1P
 hSQoiIZjFdkCyV8gZujlw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mdkZ8eUZ0cc=:GMFMNYDtFGBYb5dzZi0Via
 g7os2bQWyBv9Raqx62ujaQon2inA1Le1S/q6FrU38PtXdd5xQns/NBLNvb3UYuJOAKidt0ilO
 NymWMbJWKTTkWZ1uKQ7rxoALqlxdce7i/RbAb2Ks51dllenbMG4+aJCBJkTHzapNTA6P+4g6Q
 F77LGxYQZaERxWIHlwdilwUkwOWMauaJ+5+/P5ikSAWfCoYottEE3oDWu31Y0WijoeSkCsYyX
 08iermGBLfrLmEsDGhb9paEm7cWIShQa+i3e21bjXvU/LLl9yB/9Gaf17GaZzoscQbh01LnGG
 EFd4FF/vlpRHTXR9Yfjjn/JIeOhW/qN6uxS3O66CdrKUHAu9c84SPCx1iGTmkChvd1t33tI2y
 /AnlI+l3XsQ8y3IHn8GLXKK+oUTJFm/KYHr35gBKc/E3TAAhz/QrGldnp0PeTcfeU3Zf5L6cY
 PcGW+QBNnu/cAmfB9bS2EmABlb0h7qMdW7i7DzkJGKpNQwvMH3HmUlg+hVEXDGhYqvFXM+zzP
 1OPo8KaEq/tB2cte2DTvBlwvJKh9X1GwipeOdxAMDu9pWaQtXCSsz/54af4TR58wCZx7PBZ+3
 RiVF9UfQJIed67ZT+FvlnSNPB0UyIX8vh5V0KcQPkqusaH3IiPmLzGd7An5VactZaKbghx6M3
 JRjlv9Qb7I8cdHFuNELGvyyaTesgZY3nYsKENV85G3RVwMZr+EgdotaCf+pXWnq1ctPbsbq9z
 siIWPX91UCfn0WmfygoY4eijZ/bcKg2c1bb+e8C3SSdlkBM3Lixkj5RQuM7C3XPy8bqcoGtfI
 jJCwkTD
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-03 at 18:45 +0200, Peter Zijlstra wrote:
> 
> Something like so perhaps? Mike, can you play around with that? Could
> burn your granny and eat your cookies.

That worked, and nothing entertaining has happened.. yet.  Hm, I could
use this kernel to update my backup drive, if there's a cookie monster
lurking, that might get its attention :)
 
> diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
> index 7468de429087..07360523c3ce 100644
> --- a/arch/x86/kernel/cpu/mtrr/main.c
> +++ b/arch/x86/kernel/cpu/mtrr/main.c
> @@ -793,6 +793,9 @@ void mtrr_ap_init(void)
>  
>  	if (!use_intel() || mtrr_aps_delayed_init)
>  		return;
> +
> +	rcu_cpu_starting(smp_processor_id());
> +
>  	/*
>  	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
>  	 * changed, but this routine will be called in cpu boot time,
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 2a734692a581..4dab46950fdb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3775,6 +3775,8 @@ int rcutree_dead_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> +static DEFINE_PER_CPU(int, rcu_cpu_started);
> +
>  /*
>   * Mark the specified CPU as being online so that subsequent grace periods
>   * (both expedited and normal) will wait on it.  Note that this means that
> @@ -3796,6 +3798,11 @@ void rcu_cpu_starting(unsigned int cpu)
>  	struct rcu_node *rnp;
>  	struct rcu_state *rsp;
>  
> +	if (per_cpu(rcu_cpu_started, cpu))
> +		return;
> +
> +	per_cpu(rcu_cpu_started, cpu) = 1;
> +
>  	for_each_rcu_flavor(rsp) {
>  		rdp = per_cpu_ptr(rsp->rda, cpu);
>  		rnp = rdp->mynode;
> @@ -3852,6 +3859,8 @@ void rcu_report_dead(unsigned int cpu)
>  	preempt_enable();
>  	for_each_rcu_flavor(rsp)
>  		rcu_cleanup_dying_idle_cpu(cpu, rsp);
> +
> +	per_cpu(rcu_cpu_started, cpu) = 0;
>  }
>  
>  /* Migrate the dead CPU's callbacks to the current CPU. */
