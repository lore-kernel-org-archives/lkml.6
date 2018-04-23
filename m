Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754379AbeDWIvw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:51:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754029AbeDWIvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:51:46 -0400
Date: Mon, 23 Apr 2018 10:51:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel.opensrc@gmail.com
Subject: Re: [PATCH tip/core/rcu 01/22] sched: Make non-production PREEMPT
 cond_resched() help Tasks RCU
Message-ID: <20180423085127.GR4064@hirez.programming.kicks-ass.net>
References: <20180423023150.GA21533@linux.vnet.ibm.com>
 <1524450747-22778-1-git-send-email-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524450747-22778-1-git-send-email-paulmck@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 07:32:06PM -0700, Paul E. McKenney wrote:
> In CONFIG_PREEMPT=y kernels, cond_resched() is a complete no-op, and
> thus cannot help advance Tasks-RCU grace periods.  However, such grace
> periods are only an issue in non-production benchmarking runs of the
> Linux kernel.  This commit therefore makes cond_resched() invoke
> rcu_note_voluntary_context_switch() for kernels implementing Tasks RCU
> even in CONFIG_PREEMPT=y kernels.

I'm confused.. why is having this conditional on TRACEPOINT_BENCHMARK a
sane idea?

> 
> Reported-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> ---
>  include/linux/sched.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index b3d697f3b573..fe8f7178a22d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1617,6 +1617,12 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
>   */
>  #ifndef CONFIG_PREEMPT
>  extern int _cond_resched(void);
> +#elif defined(CONFIG_TRACEPOINT_BENCHMARK)
> +static inline int _cond_resched(void)
> +{
> +	rcu_note_voluntary_context_switch(current);
> +	return 0;
> +}
>  #else
>  static inline int _cond_resched(void) { return 0; }
>  #endif
> -- 
> 2.5.2
> 
