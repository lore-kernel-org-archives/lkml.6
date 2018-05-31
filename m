Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754058AbeEaGvL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 02:51:11 -0400
Received: from mail.efficios.com ([167.114.142.138]:53638 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754006AbeEaGun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 02:50:43 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5555E225F33
Date: Thu, 31 May 2018 02:50:41 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>, Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>, shuah <shuah@kernel.org>,
        rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Message-ID: <214539705.3633.1527749441133.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180530000500.257225-6-joel@joelfernandes.org>
References: <20180530000500.257225-1-joel@joelfernandes.org> <20180530000500.257225-6-joel@joelfernandes.org>
Subject: Re: [PATCH v8 5/8] tracepoint: Make rcuidle tracepoint callers use
 SRCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: tracepoint: Make rcuidle tracepoint callers use SRCU
Thread-Index: nAvq5R3aJ9eIQjR/d+8UrCS38/m8pw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 30, 2018, at 2:04 AM, Joel Fernandes joelaf@google.com wrote:

> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> In recent tests with IRQ on/off tracepoints, a large performance
> overhead ~10% is noticed when running hackbench. This is root caused to
> calls to rcu_irq_enter_irqson and rcu_irq_exit_irqson from the
> tracepoint code. Following a long discussion on the list [1] about this,
> we concluded that srcu is a better alternative for use during rcu idle.
> Although it does involve extra barriers, its lighter than the sched-rcu
> version which has to do additional RCU calls to notify RCU idle about
> entry into RCU sections.
> 
> In this patch, we change the underlying implementation of the
> trace_*_rcuidle API to use SRCU. This has shown to improve performance
> alot for the high frequency irq enable/disable tracepoints.
> 
> Test: Tested idle and preempt/irq tracepoints.
> 
> Here are some performance numbers:
> 
> With a run of the following 30 times on a single core x86 Qemu instance
> with 1GB memory:
> hackbench -g 4 -f 2 -l 3000
> 
> Completion times in seconds. CONFIG_PROVE_LOCKING=y.
> 
> No patches (without this series)
> Mean: 3.048
> Median: 3.025
> Std Dev: 0.064
> 
> With Lockdep using irq tracepoints with RCU implementation:
> Mean: 3.451   (-11.66 %)
> Median: 3.447 (-12.22%)
> Std Dev: 0.049
> 
> With Lockdep using irq tracepoints with SRCU implementation (this series):
> Mean: 3.020   (I would consider the improvement against the "without
>	       this series" case as just noise).
> Median: 3.013
> Std Dev: 0.033
> 
> [1] https://patchwork.kernel.org/patch/10344297/
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> include/linux/tracepoint.h | 48 +++++++++++++++++++++++++++++++-------
> kernel/tracepoint.c        | 15 +++++++++++-
> 2 files changed, 54 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index c94f466d57ef..880794207921 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -15,6 +15,7 @@
>  */
> 
> #include <linux/smp.h>
> +#include <linux/srcu.h>
> #include <linux/errno.h>
> #include <linux/types.h>
> #include <linux/cpumask.h>
> @@ -33,6 +34,8 @@ struct trace_eval_map {
> 
> #define TRACEPOINT_DEFAULT_PRIO	10
> 
> +extern struct srcu_struct tracepoint_srcu;
> +
> extern int
> tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
> extern int
> @@ -75,10 +78,15 @@ int unregister_tracepoint_module_notifier(struct
> notifier_block *nb)
>  * probe unregistration and the end of module exit to make sure there is no
>  * caller executing a probe when it is freed.
>  */
> +#ifdef CONFIG_TRACEPOINTS
> static inline void tracepoint_synchronize_unregister(void)
> {
> +	synchronize_srcu(&tracepoint_srcu);
> 	synchronize_sched();
> }
> +#else
> +static inline void tracepoint_synchronize_unregister(void) { }

In order to add some consistency to the style in this header file,
this empty function should look like:

static inline void tracepoint_synchronize_unregister(void)
{ }

(with newline before "{")

> +#endif
> 
> #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
> extern int syscall_regfunc(void);
> @@ -129,18 +137,38 @@ extern void syscall_unregfunc(void);
>  * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
>  * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
>  */
> -#define __DO_TRACE(tp, proto, args, cond, rcucheck)			\
> +#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
> 	do {								\
> 		struct tracepoint_func *it_func_ptr;			\
> 		void *it_func;						\
> 		void *__data;						\
> +		int __maybe_unused idx = 0;				\
> 									\
> 		if (!(cond))						\
> 			return;						\
> -		if (rcucheck)						\
> -			rcu_irq_enter_irqson();				\
> -		rcu_read_lock_sched_notrace();				\
> -		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
> +									\
> +		/*							\
> +		 * For rcuidle callers, use srcu since sched-rcu	\
> +		 * doesn't work from the idle path.			\
> +		 */							\
> +		if (rcuidle) {						\
> +			if (in_nmi()) {					\
> +				WARN_ON_ONCE(1);			\
> +				return; /* no srcu from nmi */		\

I find it odd to have a "return" in a macro that consists of a
do { } while (0). I'm tempted to replace "return" by "break" here,
to break the macro do/while (0) loop.

> +			}						\
> +									\
> +			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
> +			it_func_ptr =					\
> +				srcu_dereference_notrace((tp)->funcs,	\
> +						&tracepoint_srcu);	\
> +			/* To keep it consistent with !rcuidle path */	\
> +			preempt_disable_notrace();			\
> +		} else {						\
> +			rcu_read_lock_sched_notrace();			\
> +			it_func_ptr =					\
> +				rcu_dereference_sched((tp)->funcs);	\
> +		}							\
> +									\
> 		if (it_func_ptr) {					\
> 			do {						\
> 				it_func = (it_func_ptr)->func;		\
> @@ -148,9 +176,13 @@ extern void syscall_unregfunc(void);
> 				((void(*)(proto))(it_func))(args);	\
> 			} while ((++it_func_ptr)->func);		\
> 		}							\
> -		rcu_read_unlock_sched_notrace();			\
> -		if (rcucheck)						\
> -			rcu_irq_exit_irqson();				\
> +									\
> +		if (rcuidle) {						\
> +			preempt_enable_notrace();			\
> +			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
> +		} else {						\
> +			rcu_read_unlock_sched_notrace();		\
> +		}							\
> 	} while (0)
> 
> #ifndef MODULE
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 1e37da2e0c25..54157792f5ab 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -31,6 +31,9 @@
> extern struct tracepoint * const __start___tracepoints_ptrs[];
> extern struct tracepoint * const __stop___tracepoints_ptrs[];
> 
> +DEFINE_SRCU(tracepoint_srcu);
> +EXPORT_SYMBOL_GPL(tracepoint_srcu);
> +
> /* Set to 1 to enable tracepoint debug output */
> static const int tracepoint_debug;
> 
> @@ -67,16 +70,26 @@ static inline void *allocate_probes(int count)
> 	return p == NULL ? NULL : p->probes;
> }
> 
> -static void rcu_free_old_probes(struct rcu_head *head)
> +static void srcu_free_old_probes(struct rcu_head *head)
> {
> 	kfree(container_of(head, struct tp_probes, rcu));
> }
> 
> +static void rcu_free_old_probes(struct rcu_head *head)
> +{
> +	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
> +}
> +
> static inline void release_probes(struct tracepoint_func *old)
> {
> 	if (old) {
> 		struct tp_probes *tp_probes = container_of(old,
> 			struct tp_probes, probes[0]);
> +		/*
> +		 * Tracepoint probes are protected by both sched RCU and SRCU,
> +		 * by calling the SRCU callback in the sched RCU callback we
> +		 * cover both cases. So lets chain the SRCU and RCU callbacks.

lets -> let's

But I would use a different wording for that sentence that does not include
"let's" which is short for "let us", e.g.

"Chain the SRCU and sched RCU callbacks to wait for both grace periods."

With the comments above taken care of, please add my:

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks,

Mathieu

> +		 */
> 		call_rcu_sched(&tp_probes->rcu, rcu_free_old_probes);
> 	}
> }
> --
> 2.17.0.921.gf22659ad46-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
