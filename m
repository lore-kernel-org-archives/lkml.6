Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeB0CaM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 21:30:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751927AbeB0CaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 21:30:10 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47F321748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=tempfail smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 26 Feb 2018 21:29:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH tip/core/rcu 06/10] trace: Eliminate
 cond_resched_rcu_qs() in favor of cond_resched()
Message-ID: <20180226212920.43e25d6e@vmware.local.home>
In-Reply-To: <20180225183944.GA8840@linux.vnet.ibm.com>
References: <20171201192122.GA19301@linux.vnet.ibm.com>
        <1512156104-20104-6-git-send-email-paulmck@linux.vnet.ibm.com>
        <20180224151240.0d63a059@vmware.local.home>
        <20180225174927.GC2855@linux.vnet.ibm.com>
        <20180225181730.GA3963@linux.vnet.ibm.com>
        <20180225183944.GA8840@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Feb 2018 10:39:44 -0800
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> > Hmmm...  Grasping at straws...  Could we make cond_resched() be something
> > like a tracepoint and instrument them with cond_resched_rcu_qs() if the
> > current RCU-tasks grace period ran for more that (say) a minute of its
> > ten-minute stall-warning span?  
> 
> On the other hand, you noted in your other email that the tracepoint
> benchmark should not be enabled on production systems.  So how about
> the following (again untested) patch?  The "defined(CONFIG_TASKS_RCU)"
> might need to change, especially if RCU-tasks is used in production
> kernels, but perhaps a starting point.

RCU tasks are used in production systems if PREEMPT is enabled (it
allows for optimizations with ftrace, perf and kprobes).

But the tracepoint is not used.

> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index b161ef8a902e..316c29c5e506 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1589,6 +1589,12 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
>   */
>  #ifndef CONFIG_PREEMPT
>  extern int _cond_resched(void);
> +#elif defined(CONFIG_TASKS_RCU)
> +static inline int _cond_resched(void)
> +{
> +	rcu_note_voluntary_context_switch(current);
> +	return 0;
> +}
>  #else
>  static inline int _cond_resched(void) { return 0; }
>  #endif


This does work, but so does the below, without causing cond_resched()
from being something other than a nop of CONFIG_PREEMPT.

-- Steve

diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index 22fee766081b..82d83bb4874b 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -166,6 +166,7 @@ static int benchmark_event_kthread(void *arg)
 		 * block synchronize_rcu_tasks() indefinitely.
 		 */
 		cond_resched();
+		rcu_note_voluntary_context_switch(current);
 	}
 
 	return 0;
