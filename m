Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751649AbeEQOKr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:10:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:55767 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbeEQOKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:10:45 -0400
Message-ID: <1526566209.8616.19.camel@gmx.de>
Subject: Re: cpu stopper threads and load balancing leads to deadlock
From: Mike Galbraith <efault@gmx.de>
To: paulmck@linux.vnet.ibm.com
Cc: Peter Zijlstra <peterz@infradead.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Date: Thu, 17 May 2018 16:10:09 +0200
In-Reply-To: <20180517140345.GI3803@linux.vnet.ibm.com>
References: <20180503122808.GZ12217@hirez.programming.kicks-ass.net>
         <1525351221.9956.4.camel@gmx.de>
         <20180503124943.GB12217@hirez.programming.kicks-ass.net>
         <1525354359.5576.1.camel@gmx.de>
         <20180503135617.GC12217@hirez.programming.kicks-ass.net>
         <1525357015.5577.2.camel@gmx.de>
         <20180503144450.GD12217@hirez.programming.kicks-ass.net>
         <20180503161231.GI26088@linux.vnet.ibm.com>
         <20180503164508.GG12217@hirez.programming.kicks-ass.net>
         <1526358626.19125.0.camel@gmx.de>
         <20180517140345.GI3803@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iSd/xDFpZChhe1oNpEREGvEGtstcG1WENOxCsupQlmdi1p+sF4m
 qpmx3TiaMh1ThOZI+LXYGm5R+l6C12P6mpAtd47Ns8WUdfnEZCPIYvmythoZo+pKpaa2+Xl
 NZyWkAQhvB+WI0LjRi9bjWXVBB7YHOoqr4kAf2r7wPx66Kfx0uIxOy1pAOWoQiReuo9HBA5
 HGiZOi+/PdKUPgxUp1lwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AxKx4UirVXM=:BhKm/4dMJwUSxgjRoHGlfV
 NOvM5Aorzw5mEyykU+NmMRpnx1+4yxcIXGiExa3eeZ5WCCU+KP6kmJUuG2HfG3B1TNqXqLEIT
 bCAa6n+0C3Rkc0GmqNyZzQCHXkB3H804gHGkI1DuN16gKJEhxqQBnh240TTsxj5RpTVpiC/2k
 Wrl1+J2uA5Qt8QgGX06vCJNpCV+oIYhd+zINzoFOOtWD19eefZ9zzfgxTYvTdGaR+45FlsSrr
 DCo9Yir142uQDK7UrS1mnkl+JJYX24XoqwomkYTjSWm2K0oZ5Nlmmc+hQfRRE/kNWnwzhVquY
 nYryGX+gDBppB9Jvil20b5I/HXTh2yLKmac39styN86CElaC7zvX950oBJ7DsSgp+MLxaY2jR
 J1j2i5oRemoMvuJBK+1TzqrM52WinRAVxOXc/OskfkphjCGMTit8OGWpXFcltihnvILxUHint
 41SorcEp/k6IAckHC2iecmOqqqH7sJth1U6h/qUZN2AqoN/PnVd2z9S22oZKZ1jLTU1Acr5Lk
 pY/mM3wMi7bq7bQmnCiKq/tuia6nGyKH9r8wWw7suwy+LWRsGkXFTAhmCTVo7UFzE7xHDEuFW
 xgTpihT+el8kXQXBn11bUXcA1BHeVjxZRC6OyMvzyxUXKEb5zg1DMm0QBhe29u3RQla/755oQ
 SSlTzLG7/kLtzGTPuyLEi9ieCTuEejDH22Hcy6Hhnp76/0tLn3FG68mVi9wl/1Ro/RLm6vil1
 Mou5IVcaqDRX5DmaASX2EsSpO2hQbjLaQih3S3+y0T8BS5y/74TRdIpeJmFal83a1fZ/4dgZ2
 kjgzGgF
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-17 at 07:03 -0700, Paul E. McKenney wrote:
> On Tue, May 15, 2018 at 06:30:26AM +0200, Mike Galbraith wrote:
> 
> > > Something like so perhaps? Mike, can you play around with that? Could
> > > burn your granny and eat your cookies.
> > 
> > Did this get queued anywhere?
> 
> I have not queued it, but given Peter's Signed-off-by and your Tested-by
> I would be happy to do so.

Here's the later. Tested-by: Mike Galbraith <efault@gmx.de>

> > > diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
> > > index 7468de429087..07360523c3ce 100644
> > > --- a/arch/x86/kernel/cpu/mtrr/main.c
> > > +++ b/arch/x86/kernel/cpu/mtrr/main.c
> > > @@ -793,6 +793,9 @@ void mtrr_ap_init(void)
> > >  
> > >  	if (!use_intel() || mtrr_aps_delayed_init)
> > >  		return;
> > > +
> > > +	rcu_cpu_starting(smp_processor_id());
> > > +
> > >  	/*
> > >  	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
> > >  	 * changed, but this routine will be called in cpu boot time,
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 2a734692a581..4dab46950fdb 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3775,6 +3775,8 @@ int rcutree_dead_cpu(unsigned int cpu)
> > >  	return 0;
> > >  }
> > >  
> > > +static DEFINE_PER_CPU(int, rcu_cpu_started);
> > > +
> > >  /*
> > >   * Mark the specified CPU as being online so that subsequent grace periods
> > >   * (both expedited and normal) will wait on it.  Note that this means that
> > > @@ -3796,6 +3798,11 @@ void rcu_cpu_starting(unsigned int cpu)
> > >  	struct rcu_node *rnp;
> > >  	struct rcu_state *rsp;
> > >  
> > > +	if (per_cpu(rcu_cpu_started, cpu))
> > > +		return;
> > > +
> > > +	per_cpu(rcu_cpu_started, cpu) = 1;
> > > +
> > >  	for_each_rcu_flavor(rsp) {
> > >  		rdp = per_cpu_ptr(rsp->rda, cpu);
> > >  		rnp = rdp->mynode;
> > > @@ -3852,6 +3859,8 @@ void rcu_report_dead(unsigned int cpu)
> > >  	preempt_enable();
> > >  	for_each_rcu_flavor(rsp)
> > >  		rcu_cleanup_dying_idle_cpu(cpu, rsp);
> > > +
> > > +	per_cpu(rcu_cpu_started, cpu) = 0;
> > >  }
> > >  
> > >  /* Migrate the dead CPU's callbacks to the current CPU. */
> > 
> 
