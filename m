Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754688AbeDWJy1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 05:54:27 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36358 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754642AbeDWJyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 05:54:24 -0400
X-Google-Smtp-Source: AIpwx4+xbbFFzbvlGj8GtfjBGB/Ibg73URSm8PIugrBp8w2C0ZvvmqRdRuBJW79GcS0bP7Ql+afaIQ==
Date: Mon, 23 Apr 2018 11:54:20 +0200
From: Vincent Guittot <vincent.guittot@linaro.org>
To: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: Potential problem with 31e77c93e432dec7 ("sched/fair: Update
 blocked load when newly idle")
Message-ID: <20180423095420.GA23995@linaro.org>
References: <20180412091822.GG12256@bigcity.dyn.berto.se>
 <CAKfTPtAE3qeWcTdT-WL8nrbZmP_+OaxPyyjUfVCzn=rax9tQZQ@mail.gmail.com>
 <20180412111519.GH12256@bigcity.dyn.berto.se>
 <20180412133031.GA551@linaro.org>
 <20180412223904.GJ12256@bigcity.dyn.berto.se>
 <CAKfTPtDRtto7w806gYgdS_bCJ77EY0RRtszycB+TnG6aQ6ve4Q@mail.gmail.com>
 <20180420160013.GA13769@linaro.org>
 <20180422221827.GB27674@bigcity.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180422221827.GB27674@bigcity.dyn.berto.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

Le Monday 23 Apr 2018 à 00:18:27 (+0200), Niklas Söderlund a écrit :
> Hi Vincent,
> 
> On 2018-04-20 18:00:13 +0200, Vincent Guittot wrote:
> 
> [snip]
> 
> > > 
> > > You results are similar to Heiner's ones. The problem is still there
> > > even if we only kick ilb which mainly send an IPI reschedule to the
> > > other CPU if Idle
> > > 
> > 
> > Could it be possible to record some traces of the problem to get a better view
> > of what happens ?
> > 
> > I have a small patch that adds some traces in the functions that seems to create
> > the problem
> 
> Sure, I applied the patch bellow on-top of c18bb396d3d261eb ("Merge 
> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net").
> 
> > 
> > 
> > 
> > Also that would be good to stop tracing when the RCU stall happens
> > 
> > In case you are not familiar with the trace tool, I have put below how to configure ftrace to trace scheudler, irq, timer ... events and stop tracing when dump_backtrace function is called
> > 
> > trace-cmd reset > /dev/null
> > trace-cmd start -b 40000 -p function -l dump_backtrace:traceoff -e sched -e cpu_idle -e cpu_frequency -e timer -e ipi -e irq -e printk
> > trace-cmd start -b 40000 -p function -l dump_backtrace
> > 
> > The trace-cmd start has to be called twice to make sure that we will not trace all function
> > 
> > Once the dump happen and the trace is stopped, you can extract the traces with 
> > 
> > trace-cmd extract -o <trace file name>
> 
> Thanks for the help with trace-cmd, I have attached the full 
> trace-cmd.dat extracted from running this. But a quick run of trace-cmd 
> report.i

Thanks for the report. Can you re run with the following trace-cmd sequence ? My previous sequence disables ftrace events

trace-cmd reset > /dev/null
trace-cmd start -b 40000 -p function -l dump_backtrace:traceoff -e sched -e cpu_idle -e cpu_frequency -e timer -e ipi -e irq -e printk
trace-cmd start -b 40000 -p function -l dump_backtrace -e sched -e cpu_idle -e cpu_frequency -e timer -e ipi -e irq -e printk

I have updated the patch and added traces to check that scheduler returns from idle_balance function and doesn't stay stuck

---
 kernel/sched/fair.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0951d1c..4285511 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9606,6 +9606,8 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	 */
 	WRITE_ONCE(nohz.has_blocked, 0);
 
+	trace_printk("_nohz_idle_balance cpu %d idle %d flag %x", this_cpu, idle, flags);
+
 	/*
 	 * Ensures that if we miss the CPU, we must see the has_blocked
 	 * store from nohz_balance_enter_idle().
@@ -9628,6 +9630,8 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 
 		rq = cpu_rq(balance_cpu);
 
+		trace_printk("_nohz_idle_balance update cpu %d ", balance_cpu);
+
 		has_blocked_load |= update_nohz_stats(rq, true);
 
 		/*
@@ -9680,6 +9684,8 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	if (likely(update_next_balance))
 		nohz.next_balance = next_balance;
 
+	trace_printk("_nohz_idle_balance return %d", ret);
+
 	return ret;
 }
 
@@ -9732,6 +9738,8 @@ static void nohz_newidle_balance(struct rq *this_rq)
 	    time_before(jiffies, READ_ONCE(nohz.next_blocked)))
 		return;
 
+	trace_printk("nohz_newidle_balance start update");
+
 	raw_spin_unlock(&this_rq->lock);
 	/*
 	 * This CPU is going to be idle and blocked load of idle CPUs
@@ -9742,6 +9750,9 @@ static void nohz_newidle_balance(struct rq *this_rq)
 	if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
 		kick_ilb(NOHZ_STATS_KICK);
 	raw_spin_lock(&this_rq->lock);
+
+	trace_printk("nohz_newidle_balance lock back");
+
 }
 
 #else /* !CONFIG_NO_HZ_COMMON */
@@ -9869,6 +9880,8 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	rq_repin_lock(this_rq, rf);
 
+	trace_printk("idle_balance %d", pulled_task);
+
 	return pulled_task;
 }
 
-- 
2.7.4

>
> 

[snip]

>        rcu_sched-9     [000]   147.342741: bputs:                pick_next_task_fair: nohz_newidle_balance start update
>        rcu_sched-9     [000]   147.342749: bprint:               _nohz_idle_balance: _nohz_idle_balance cpu 0 idle 2 flag 2
>        rcu_sched-9     [000]   147.342754: bprint:               _nohz_idle_balance: _nohz_idle_balance return 1
>        rcu_sched-9     [000]   147.382739: bputs:                pick_next_task_fair: nohz_newidle_balance start update
>        rcu_sched-9     [000]   147.382741: bprint:               _nohz_idle_balance: _nohz_idle_balance cpu 0 idle 2 flag 2
>        rcu_sched-9     [000]   147.382745: bprint:               _nohz_idle_balance: _nohz_idle_balance return 1
>             sshd-1881  [000]   147.621105: bputs:                pick_next_task_fair: nohz_newidle_balance start update
>             sshd-1881  [000]   147.621108: bprint:               _nohz_idle_balance: _nohz_idle_balance cpu 0 idle 2 flag 2
>             sshd-1881  [000]   147.621110: bprint:               _nohz_idle_balance: _nohz_idle_balance return 1

This is the last call to the function added by the patch on CPU0 and it returns completely.
But then nothing else is schedule on CPU0

>           <idle>-0     [001]   147.662725: bprint:               _nohz_idle_balance: _nohz_idle_balance cpu 1 idle 0 flag 2
>           <idle>-0     [001]   147.662730: bprint:               _nohz_idle_balance: _nohz_idle_balance return 1
>      kworker/1:1-31    [001]   151.032830: bputs:                pick_next_task_fair: nohz_newidle_balance start update
>      kworker/1:1-31    [001]   151.032833: bprint:               _nohz_idle_balance: _nohz_idle_balance cpu 1 idle 2 flag 2
>      kworker/1:1-31    [001]   151.032835: bprint:               _nohz_idle_balance: _nohz_idle_balance return 1
>      kworker/1:1-31    [001]   155.032777: bputs:                pick_next_task_fair: nohz_newidle_balance start update
>      kworker/1:1-31    [001]   155.032780: bprint:               _nohz_idle_balance: _nohz_idle_balance cpu 1 idle 2 flag 2
>      kworker/1:1-31    [001]   155.032781: bprint:               _nohz_idle_balance: _nohz_idle_balance return 1
>          haveged-1823  [001]   155.515789: bputs:                pick_next_task_fair: nohz_newidle_balance start update
>          haveged-1823  [001]   155.515792: bprint:               _nohz_idle_balance: _nohz_idle_balance cpu 1 idle 2 flag 2
>          haveged-1823  [001]   155.515794: bprint:               _nohz_idle_balance: _nohz_idle_balance return 1
>      kworker/1:1-31    [001]   157.032718: bputs:                pick_next_task_fair: nohz_newidle_balance start update
>      kworker/1:1-31    [001]   157.032720: bprint:               _nohz_idle_balance: _nohz_idle_balance cpu 1 idle 2 flag 2
>      kworker/1:1-31    [001]   157.032722: bprint:               _nohz_idle_balance: _nohz_idle_balance return 1
>      kworker/1:1-31    [001]   159.032724: bputs:                pick_next_task_fair: nohz_newidle_balance start update
>      kworker/1:1-31    [001]   159.032726: bprint:               _nohz_idle_balance: _nohz_idle_balance cpu 1 idle 2 flag 2
>      kworker/1:1-31    [001]   159.032728: bprint:               _nohz_idle_balance: _nohz_idle_balance return 1
>      kworker/1:1-31    [001]   161.032698: bputs:                pick_next_task_fair: nohz_newidle_balance start update
>      kworker/1:1-31    [001]   161.032701: bprint:               _nohz_idle_balance: _nohz_idle_balance cpu 1 idle 2 flag 2
>      kworker/1:1-31    [001]   161.032702: bprint:               _nohz_idle_balance: _nohz_idle_balance return 1
>      kworker/1:1-31    [001]   165.032671: bputs:                pick_next_task_fair: nohz_newidle_balance start update
>      kworker/1:1-31    [001]   165.032673: bprint:               _nohz_idle_balance: _nohz_idle_balance cpu 1 idle 2 flag 2
>      kworker/1:1-31    [001]   165.032675: bprint:               _nohz_idle_balance: _nohz_idle_balance return 1
>      kworker/1:1-31    [001]   167.032667: bputs:                pick_next_task_fair: nohz_newidle_balance start update
>      kworker/1:1-31    [001]   167.032669: bprint:               _nohz_idle_balance: _nohz_idle_balance cpu 1 idle 2 flag 2
>      kworker/1:1-31    [001]   167.032671: bprint:               _nohz_idle_balance: _nohz_idle_balance return 1
>      kworker/1:1-31    [001]   169.032654: bputs:                pick_next_task_fair: nohz_newidle_balance start update
>      kworker/1:1-31    [001]   169.032657: bprint:               _nohz_idle_balance: _nohz_idle_balance cpu 1 idle 2 flag 2
>      kworker/1:1-31    [001]   169.032658: bprint:               _nohz_idle_balance: _nohz_idle_balance return 1
>          rpcbind-1847  [001]   169.472688: bputs:                pick_next_task_fair: nohz_newidle_balance start update
>          rpcbind-1847  [001]   169.472691: bprint:               _nohz_idle_balance: _nohz_idle_balance cpu 1 idle 2 flag 2
>          rpcbind-1847  [001]   169.472693: bprint:               _nohz_idle_balance: _nohz_idle_balance return 1
>      kworker/1:1-31    [001]   171.032660: bputs:                pick_next_task_fair: nohz_newidle_balance start update
>      kworker/1:1-31    [001]   171.032662: bprint:               _nohz_idle_balance: _nohz_idle_balance cpu 1 idle 2 flag 2
>      kworker/1:1-31    [001]   171.032664: bprint:               _nohz_idle_balance: _nohz_idle_balance return 1
>          rpcbind-1847  [001]   199.482558: bputs:                pick_next_task_fair: nohz_newidle_balance start update
>          rpcbind-1847  [001]   199.482561: bprint:               _nohz_idle_balance: _nohz_idle_balance cpu 1 idle 2 flag 2
>          rpcbind-1847  [001]   199.482563: bprint:               _nohz_idle_balance: _nohz_idle_balance return 1
>           <idle>-0     [000]   241.615152: function:             dump_backtrace
> 
> -- 
> Regards,
> Niklas Söderlund

sorry for the inconvenience

Vincent
