Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeEGVGq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 17:06:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752764AbeEGVGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 17:06:44 -0400
Date: Mon, 7 May 2018 14:08:01 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zilstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>, kernel-team@android.com
Subject: Re: [PATCH RFC v6 4/5] tracepoint: Make rcuidle tracepoint callers
 use SRCU
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180507204143.13061-1-joelaf@google.com>
 <20180507204143.13061-5-joelaf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507204143.13061-5-joelaf@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050721-0040-0000-0000-00000427EE4F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008988; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01028977; UDB=6.00525749; IPR=6.00808110;
 MB=3.00020979; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-07 21:06:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050721-0041-0000-0000-0000082DFAAE
Message-Id: <20180507210801.GZ26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070207
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 01:41:42PM -0700, Joel Fernandes wrote:
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
> 	       this series" case as just noise).
> Median: 3.013
> Std Dev: 0.033
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
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/linux/tracepoint.h | 46 +++++++++++++++++++++++++++++++-------
>  kernel/tracepoint.c        | 15 ++++++++++++-
>  2 files changed, 52 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index c94f466d57ef..f56f290cf8eb 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -15,6 +15,7 @@
>   */
> 
>  #include <linux/smp.h>
> +#include <linux/srcu.h>
>  #include <linux/errno.h>
>  #include <linux/types.h>
>  #include <linux/cpumask.h>
> @@ -33,6 +34,8 @@ struct trace_eval_map {
> 
>  #define TRACEPOINT_DEFAULT_PRIO	10
> 
> +extern struct srcu_struct tracepoint_srcu;
> +
>  extern int
>  tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
>  extern int
> @@ -77,6 +80,9 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
>   */
>  static inline void tracepoint_synchronize_unregister(void)
>  {
> +#ifdef CONFIG_TRACEPOINTS
> +	synchronize_srcu(&tracepoint_srcu);
> +#endif
>  	synchronize_sched();
>  }
> 
> @@ -129,18 +135,38 @@ extern void syscall_unregfunc(void);
>   * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
>   * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
>   */
> -#define __DO_TRACE(tp, proto, args, cond, rcucheck)			\
> +#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
>  	do {								\
>  		struct tracepoint_func *it_func_ptr;			\
>  		void *it_func;						\
>  		void *__data;						\
> +		int __maybe_unused idx = 0;				\
>  									\
>  		if (!(cond))						\
>  			return;						\
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
>  		if (it_func_ptr) {					\
>  			do {						\
>  				it_func = (it_func_ptr)->func;		\
> @@ -148,9 +174,13 @@ extern void syscall_unregfunc(void);
>  				((void(*)(proto))(it_func))(args);	\
>  			} while ((++it_func_ptr)->func);		\
>  		}							\
> -		rcu_read_unlock_sched_notrace();			\
> -		if (rcucheck)						\
> -			rcu_irq_exit_irqson();				\
> +									\
> +		if (rcuidle) {						\

Don't we also need an in_nmi() check here in order to avoid unbalanced
srcu_read_unlock_notrace() calls?

							Thanx, Paul

> +			preempt_enable_notrace();			\
> +			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
> +		} else {						\
> +			rcu_read_unlock_sched_notrace();		\
> +		}							\
>  	} while (0)
> 
>  #ifndef MODULE
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 671b13457387..2089f579f790 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -31,6 +31,9 @@
>  extern struct tracepoint * const __start___tracepoints_ptrs[];
>  extern struct tracepoint * const __stop___tracepoints_ptrs[];
> 
> +DEFINE_SRCU(tracepoint_srcu);
> +EXPORT_SYMBOL_GPL(tracepoint_srcu);
> +
>  /* Set to 1 to enable tracepoint debug output */
>  static const int tracepoint_debug;
> 
> @@ -67,16 +70,26 @@ static inline void *allocate_probes(int count)
>  	return p == NULL ? NULL : p->probes;
>  }
> 
> -static void rcu_free_old_probes(struct rcu_head *head)
> +static void srcu_free_old_probes(struct rcu_head *head)
>  {
>  	kfree(container_of(head, struct tp_probes, rcu));
>  }
> 
> +static void rcu_free_old_probes(struct rcu_head *head)
> +{
> +	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
> +}
> +
>  static inline void release_probes(struct tracepoint_func *old)
>  {
>  	if (old) {
>  		struct tp_probes *tp_probes = container_of(old,
>  			struct tp_probes, probes[0]);
> +		/*
> +		 * Tracepoint probes are protected by both sched RCU and SRCU,
> +		 * by calling the SRCU callback in the sched RCU callback we
> +		 * cover both cases. So lets chain the SRCU and RCU callbacks.
> +		 */
>  		call_rcu_sched(&tp_probes->rcu, rcu_free_old_probes);
>  	}
>  }
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
