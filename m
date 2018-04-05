Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeDEANG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 20:13:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752353AbeDEANE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 20:13:04 -0400
Date: Wed, 4 Apr 2018 17:13:58 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rcu_process_callbacks irqsoff latency caused by taking spinlock
 with irqs disabled
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180405093414.2273203e@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405093414.2273203e@roar.ozlabs.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18040500-0036-0000-0000-000002DC009C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008803; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01013211; UDB=6.00516442; IPR=6.00792477;
 MB=3.00020419; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-05 00:13:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040500-0037-0000-0000-000043DF0578
Message-Id: <20180405001358.GK3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-04_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804050000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 09:34:14AM +1000, Nicholas Piggin wrote:
> Hi Paul,
> 
> Just looking at latencies, and RCU showed up as one of the maximums.
> This is a 2 socket system with (176 CPU threads). Just doing a
> `make -j 352` kernel build. Got a max latency of 3ms. I don't think
> that's anything to worry about really, but I wanted to check the
> cause.

Well, that 3 milliseconds would cause serious problems for some workloads...

> # tracer: irqsoff
> #
> # irqsoff latency trace v1.1.5 on 4.16.0-01530-g43d1859f0994
> # --------------------------------------------------------------------
> # latency: 3055 us, #19/19, CPU#135 | (M:server VP:0, KP:0, SP:0 HP:0 #P:176)
> #    -----------------
> #    | task: cc1-58689 (uid:1003 nice:0 policy:0 rt_prio:0)
> #    -----------------
> #  => started at: rcu_process_callbacks
> #  => ended at:   _raw_spin_unlock_irqrestore
> #
> #
> #                  _------=> CPU#            
> #                 / _-----=> irqs-off        
> #                | / _----=> need-resched    
> #                || / _---=> hardirq/softirq 
> #                ||| / _--=> preempt-depth   
> #                |||| /     delay            
> #  cmd     pid   ||||| time  |   caller      
> #     \   /      |||||  \    |   /         
>    <...>-58689 135d.s.    0us : rcu_process_callbacks
>    <...>-58689 135d.s.    1us : cpu_needs_another_gp <-rcu_process_callbacks
>    <...>-58689 135d.s.    2us : rcu_segcblist_future_gp_needed <-cpu_needs_another_gp
>    <...>-58689 135d.s.    3us#: _raw_spin_lock <-rcu_process_callbacks
>    <...>-58689 135d.s. 3047us : rcu_start_gp <-rcu_process_callbacks
>    <...>-58689 135d.s. 3048us : rcu_advance_cbs <-rcu_start_gp
>    <...>-58689 135d.s. 3049us : rcu_segcblist_pend_cbs <-rcu_advance_cbs
>    <...>-58689 135d.s. 3049us : rcu_segcblist_advance <-rcu_advance_cbs
>    <...>-58689 135d.s. 3050us : rcu_accelerate_cbs <-rcu_start_gp
>    <...>-58689 135d.s. 3050us : rcu_segcblist_pend_cbs <-rcu_accelerate_cbs
>    <...>-58689 135d.s. 3051us : rcu_segcblist_accelerate <-rcu_accelerate_cbs
>    <...>-58689 135d.s. 3052us : trace_rcu_future_gp.isra.0 <-rcu_accelerate_cbs
>    <...>-58689 135d.s. 3052us : trace_rcu_future_gp.isra.0 <-rcu_accelerate_cbs
>    <...>-58689 135d.s. 3053us : rcu_start_gp_advanced.isra.35 <-rcu_start_gp
>    <...>-58689 135d.s. 3053us : cpu_needs_another_gp <-rcu_start_gp_advanced.isra.35
>    <...>-58689 135d.s. 3054us : _raw_spin_unlock_irqrestore <-rcu_process_callbacks
>    <...>-58689 135d.s. 3055us : _raw_spin_unlock_irqrestore
>    <...>-58689 135d.s. 3056us : trace_hardirqs_on <-_raw_spin_unlock_irqrestore
>    <...>-58689 135d.s. 3061us : <stack trace>
> 
> So it's taking a contende lock with interrupts disabled:
> 
> static void
> __rcu_process_callbacks(struct rcu_state *rsp)
> {
>         unsigned long flags;
>         bool needwake;
>         struct rcu_data *rdp = raw_cpu_ptr(rsp->rda);
> 
>         WARN_ON_ONCE(!rdp->beenonline);
> 
>         /* Update RCU state based on any recent quiescent states. */
>         rcu_check_quiescent_state(rsp, rdp);
> 
>         /* Does this CPU require a not-yet-started grace period? */
>         local_irq_save(flags);
>         if (cpu_needs_another_gp(rsp, rdp)) {
>                 raw_spin_lock_rcu_node(rcu_get_root(rsp)); /* irqs disabled. */
>                 needwake = rcu_start_gp(rsp);
>                 raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(rsp), flags);
>                 if (needwake)
>                         rcu_gp_kthread_wake(rsp);
>         } else {
>                 local_irq_restore(flags);
>         }
> 
> Because irqs are disabled before taking the lock, we can't spin with
> interrupts enabled.
> 
> cpu_needs_another_gp needs interrupts off to prevent races with normal
> callback registry, but that doesn't seem to be preventing any wider
> races in this code, because we immediately re-enable interrupts anyway
> if no gp is needed. So an interrupt can come in right after that and
> queue something up.
> 
> So then the question is whether it's safe-albeit-racy to call with
> interrupts ensabled? Would be nice to move it to a spin_lock_irqsave.

If I recall correctly, the issue is that an unsynchronized (due to
interrupts being enabled) check in the "if" statement can cause extra
unneeded grace periods.

I am guessing that the long latency is caused by lots of CPUs suddenly
needing a new grace period at about the same time.  If so, this is
a bottleneck that I have been expecting for some time, and one that
I would resolve by introducing funnel locking, sort of like SRCU and
expedited grace periods already use.

Or am I confused about the source of the contention?

							Thanx, Paul
