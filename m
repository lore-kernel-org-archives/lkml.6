Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935132AbeD0O0e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:26:34 -0400
Received: from mail.efficios.com ([167.114.142.138]:53276 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934915AbeD0O0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:26:31 -0400
Date: Fri, 27 Apr 2018 10:26:29 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        fweisbec <fweisbec@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        baohong liu <baohong.liu@intel.com>,
        vedang patel <vedang.patel@intel.com>, kernel-team@android.com
Message-ID: <1169911546.5820.1524839189395.JavaMail.zimbra@efficios.com>
In-Reply-To: <20180427042656.190746-1-joelaf@google.com>
References: <20180427042656.190746-1-joelaf@google.com>
Subject: Re: [PATCH RFC] tracepoint: Introduce tracepoint callbacks
 executing with preempt on
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2009 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_2009)
Thread-Topic: tracepoint: Introduce tracepoint callbacks executing with preempt on
Thread-Index: 9kxJNPeEOzhqgoiyb3oJGZH4kVqYqQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 27, 2018, at 12:26 AM, Joel Fernandes joelaf@google.com wrote:

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

The general approach and the implementation look fine, except for
one small detail: I would be tempted to explicitly disable preemption
around the call to the tracepoint callback for the rcuidle variant,
unless we plan to audit every tracer right away to remove any assumption
that preemption is disabled in the callback implementation.

That would be the main difference between an eventual "may_sleep" tracepoint
and a rcuidle tracepoint: "may_sleep" would use SRCU and leave preemption
enabled when invoking the callback. rcuidle uses SRCU too, but would
disable preemption when invoking the callback.

Thoughts ?

Thanks,

Mathieu


> 
> In the future, we can add a new may_sleep API which can use this
> infrastructure for callbacks that actually can sleep which will support
> Mathieu's usecase of blocking probes.
> 
> Test: Tested idle and preempt/irq tracepoints.
> 
> [1] https://patchwork.kernel.org/patch/10344297/
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Peter Zilstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Glexiner <tglx@linutronix.de>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Fenguang Wu <fengguang.wu@intel.com>
> Cc: Baohong Liu <baohong.liu@intel.com>
> Cc: Vedang Patel <vedang.patel@intel.com>
> Cc: kernel-team@android.com
> Signed-off-by: Joel Fernandes <joelaf@google.com>
> ---
> include/linux/tracepoint.h | 37 +++++++++++++++++++++++++++++--------
> kernel/tracepoint.c        | 10 +++++++++-
> 2 files changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index c94f466d57ef..a1c1987de423 100644
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
> @@ -77,6 +80,7 @@ int unregister_tracepoint_module_notifier(struct
> notifier_block *nb)
>  */
> static inline void tracepoint_synchronize_unregister(void)
> {
> +	synchronize_srcu(&tracepoint_srcu);
> 	synchronize_sched();
> }
> 
> @@ -129,18 +133,26 @@ extern void syscall_unregfunc(void);
>  * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
>  * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
>  */
> -#define __DO_TRACE(tp, proto, args, cond, rcucheck)			\
> +#define __DO_TRACE(tp, proto, args, cond, preempt_on)			\
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
> +		if (preempt_on) {					\
> +			WARN_ON_ONCE(in_nmi()); /* no srcu from nmi */	\
> +			idx = srcu_read_lock(&tracepoint_srcu);         \
> +			it_func_ptr = srcu_dereference((tp)->funcs,	\
> +						&tracepoint_srcu);	\
> +		} else {						\
> +			rcu_read_lock_sched_notrace();			\
> +			it_func_ptr =					\
> +				rcu_dereference_sched((tp)->funcs);	\
> +		}							\
> +									\
> 		if (it_func_ptr) {					\
> 			do {						\
> 				it_func = (it_func_ptr)->func;		\
> @@ -148,12 +160,21 @@ extern void syscall_unregfunc(void);
> 				((void(*)(proto))(it_func))(args);	\
> 			} while ((++it_func_ptr)->func);		\
> 		}							\
> -		rcu_read_unlock_sched_notrace();			\
> -		if (rcucheck)						\
> -			rcu_irq_exit_irqson();				\
> +									\
> +		if (preempt_on)					\
> +			srcu_read_unlock(&tracepoint_srcu, idx);	\
> +		else							\
> +			rcu_read_unlock_sched_notrace();		\
> 	} while (0)
> 
> #ifndef MODULE
> +/*
> + * This is for tracepoints that may be called from an rcu idle path. To make
> + * sure we its safe in the idle path, use the srcu instead of sched-rcu by
> + * specifying the preempt_on flag below.  This has the obvious effect that any
> + * callback expecting preemption to be disabled should explicitly do so since
> + * with srcu it'd run with preempt on.
> + */
> #define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto, data_args) \
> 	static inline void trace_##name##_rcuidle(proto)		\
> 	{								\
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 671b13457387..b3b1d65a2460 100644
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
> @@ -67,11 +70,16 @@ static inline void *allocate_probes(int count)
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
> --
> 2.17.0.441.gb46fe60e1d-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
