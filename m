Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935714AbeCAFEP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 00:04:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750739AbeCAFEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 00:04:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1638217A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 1 Mar 2018 00:04:04 -0500
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
Message-ID: <20180301000404.64828a0e@vmware.local.home>
In-Reply-To: <20180301012144.GX3777@linux.vnet.ibm.com>
References: <20171201192122.GA19301@linux.vnet.ibm.com>
 <1512156104-20104-6-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180224151240.0d63a059@vmware.local.home>
 <20180225174927.GC2855@linux.vnet.ibm.com>
 <20180225181730.GA3963@linux.vnet.ibm.com>
 <20180225183944.GA8840@linux.vnet.ibm.com>
 <20180226212920.43e25d6e@vmware.local.home>
 <20180227153646.GD3777@linux.vnet.ibm.com>
 <20180228181252.55e0590c@vmware.local.home>
 <20180301012144.GX3777@linux.vnet.ibm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018 17:21:44 -0800
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> > Perhaps, still think this is a special case. That said, perhaps
> > cond_resched isn't done in critical locations as it's a place that is
> > explicitly stating that it's OK to schedule.  
> 
> Building on your second sentence, when you are running a non-production
> stress test, adding an extra function call and conditional branch to
> cond_resched() should not be a problem.
> 
> So how about the (still untested) patch below?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit e9a6ea9fc2542459f9a63cf2b3a0264d09fbc266
> Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Date:   Sun Feb 25 10:40:44 2018 -0800
> 
>     EXP sched: Make non-production PREEMPT cond_resched() help Tasks RCU
>     
>     In CONFIG_PREEMPT=y kernels, cond_resched() is a complete no-op, and
>     thus cannot help advance Tasks-RCU grace periods.  However, such grace
>     periods are only an issue in non-production benchmarking runs of the
>     Linux kernel.  This commit therefore makes cond_resched() invoke
>     rcu_note_voluntary_context_switch() for kernels implementing Tasks RCU
>     even in CONFIG_PREEMPT=y kernels.
>     
>     Reported-by: Steven Rostedt <rostedt@goodmis.org>
>     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index b161ef8a902e..970dadefb86f 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1589,6 +1589,12 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
>   */
>  #ifndef CONFIG_PREEMPT
>  extern int _cond_resched(void);
> +#elif defined(CONFIG_TRACEPOINT_BENCHMARK)
> +static inline int _cond_resched(void)
> +{
> +	rcu_note_voluntary_context_switch(current);

The thing I hate about this is that it is invasive to code outside of
the tracepoint benchmark. Why do the rcu_note_voluntary_context_switch
here and not in the tracepoint code? Seems odd to have it called
everywhere in the kernel when it is only needed by the benchmark
tracepoint code.

-- Steve



> +	return 0;
> +}
>  #else
>  static inline int _cond_resched(void) { return 0; }
>  #endif
