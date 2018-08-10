Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2A8C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE08223E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE08223E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeHJSGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 14:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbeHJSGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 14:06:19 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AF01223C6;
        Fri, 10 Aug 2018 15:35:56 +0000 (UTC)
Date:   Fri, 10 Aug 2018 11:35:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v12 2/3] tracepoint: Make rcuidle tracepoint callers use
 SRCU
Message-ID: <20180810113554.1df28050@gandalf.local.home>
In-Reply-To: <20180730222423.196630-3-joel@joelfernandes.org>
References: <20180730222423.196630-1-joel@joelfernandes.org>
        <20180730222423.196630-3-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jul 2018 15:24:22 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

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
> [remove rcu_read_lock_sched_notrace as its the equivalent of
> preempt_disable_notrace and is unnecessary to call in tracepoint code]
> Cleaned-up-by: Peter Zijlstra <peterz@infradead.org>
> Acked-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/linux/tracepoint.h | 41 ++++++++++++++++++++++++++++++--------
>  kernel/tracepoint.c        | 16 ++++++++++++++-
>  2 files changed, 48 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 19a690b559ca..6e7bc6ebfcd8 100644
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
> @@ -75,10 +78,16 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
>   * probe unregistration and the end of module exit to make sure there is no
>   * caller executing a probe when it is freed.
>   */
> +#ifdef CONFIG_TRACEPOINTS
>  static inline void tracepoint_synchronize_unregister(void)
>  {
> +	synchronize_srcu(&tracepoint_srcu);
>  	synchronize_sched();
>  }
> +#else
> +static inline void tracepoint_synchronize_unregister(void)
> +{ }
> +#endif
>  
>  #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
>  extern int syscall_regfunc(void);
> @@ -129,18 +138,32 @@ extern void syscall_unregfunc(void);
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
> +		/* srcu can't be used from NMI */			\
> +		if (rcuidle && in_nmi())				\
> +			WARN_ON_ONCE(1);				\
> +									\
> +		/* keep srcu and sched-rcu usage consistent */		\
> +		preempt_disable_notrace();				\
> +									\
> +		/*							\
> +		 * For rcuidle callers, use srcu since sched-rcu	\
> +		 * doesn't work from the idle path.			\
> +		 */							\
> +		if (rcuidle)						\
> +			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
> +									\
> +		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
> +									\
>  		if (it_func_ptr) {					\
>  			do {						\
>  				it_func = (it_func_ptr)->func;		\
> @@ -148,9 +171,11 @@ extern void syscall_unregfunc(void);
>  				((void(*)(proto))(it_func))(args);	\
>  			} while ((++it_func_ptr)->func);		\
>  		}							\
> -		rcu_read_unlock_sched_notrace();			\
> -		if (rcucheck)						\
> -			rcu_irq_exit_irqson();				\
> +									\
> +		if (rcuidle)						\
> +			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
> +									\
> +		preempt_enable_notrace();				\
>  	} while (0)
>  
>  #ifndef MODULE
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 6dc6356c3327..955148d91b74 100644
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
> @@ -67,16 +70,27 @@ static inline void *allocate_probes(int count)
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

Grumble. This fails my tests that test enabling tracepoints via the
command line with this:

WARNING: CPU: 0 PID: 13 at /work/build/trace/nobackup/linux-test.git/kernel/rcu/srcutree.c:236 check_init_srcu_struct+0xe/0x61
Modules linked in:
CPU: 0 PID: 13 Comm: watchdog/0 Not tainted 4.18.0-rc6-test+ #6
Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
RIP: 0010:check_init_srcu_struct+0xe/0x61
Code: 48 c7 c6 ec 8a 65 b4 e8 ff 79 fe ff 48 89 df 31 f6 e8 f2 fa ff ff 5a 5b 41 5c 5d c3 0f 1f 44 00 00 83 3d 68 94 b8 01 01 75 02 <0f> 0b 48 8b 87 f0 0a 00 00 a8 03 74 45 55 48 89 e5 41 55 41 54 4c 
RSP: 0000:ffff96eb9ea03e68 EFLAGS: 00010246
RAX: ffff96eb962b5b01 RBX: ffffffffb4a87420 RCX: 0000000000000001
RDX: ffffffffb3107969 RSI: ffff96eb962b5b40 RDI: ffffffffb4a87420
RBP: ffff96eb9ea03eb0 R08: ffffabbd00cd7f48 R09: 0000000000000000
R10: ffff96eb9ea03e68 R11: ffffffffb4a6eec0 R12: ffff96eb962b5b40
R13: ffff96eb9ea03ef8 R14: ffffffffb3107969 R15: ffffffffb3107948
FS:  0000000000000000(0000) GS:ffff96eb9ea00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff96eb13ab2000 CR3: 0000000192a1e001 CR4: 00000000001606f0
Call Trace:
 <IRQ>
 ? __call_srcu+0x2d/0x290
 ? rcu_process_callbacks+0x26e/0x448
 ? allocate_probes+0x2b/0x2b
 call_srcu+0x13/0x15
 rcu_free_old_probes+0x1f/0x21
 rcu_process_callbacks+0x2ed/0x448
 __do_softirq+0x172/0x336
 irq_exit+0x62/0xb2
 smp_apic_timer_interrupt+0x161/0x19e
 apic_timer_interrupt+0xf/0x20
 </IRQ>

Investigating it, it's that when we register more than one event, the
tracepoint code calls "release_probes" when adding new tracepoints (as
it updated the tracepoint array), and this is done very early in boot
up, causing this warning.

I'm still looking at ways to fix this. Any ideas would help.

-- Steve


>  static inline void release_probes(struct tracepoint_func *old)
>  {
>  	if (old) {
>  		struct tp_probes *tp_probes = container_of(old,
>  			struct tp_probes, probes[0]);
> +		/*
> +		 * Tracepoint probes are protected by both sched RCU and SRCU,
> +		 * by calling the SRCU callback in the sched RCU callback we
> +		 * cover both cases. So let us chain the SRCU and sched RCU
> +		 * callbacks to wait for both grace periods.
> +		 */
>  		call_rcu_sched(&tp_probes->rcu, rcu_free_old_probes);
>  	}
>  }

