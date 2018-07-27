Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88CDC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA46208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA46208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388796AbeG0Rtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 13:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730850AbeG0Rtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 13:49:41 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4D03205C9;
        Fri, 27 Jul 2018 16:27:00 +0000 (UTC)
Date:   Fri, 27 Jul 2018 12:26:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v11 2/3] tracepoint: Make rcuidle tracepoint callers use
 SRCU
Message-ID: <20180727122659.524dd13f@gandalf.local.home>
In-Reply-To: <20180726235044.10195-3-joel@joelfernandes.org>
References: <20180726235044.10195-1-joel@joelfernandes.org>
        <20180726235044.10195-3-joel@joelfernandes.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 16:50:43 -0700
Joel Fernandes <joel@joelfernandes.org> wrote:

> F
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

Why isn't the above:

		WARN_ON_ONCE(rcuidle && in_nmi());

?

The rest looks fine.

-- Steve

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
> 
