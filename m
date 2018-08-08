Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A88FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8942216FC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 01:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8942216FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeHHEMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 00:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbeHHEMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 00:12:41 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98433216F2;
        Wed,  8 Aug 2018 01:55:24 +0000 (UTC)
Date:   Tue, 7 Aug 2018 21:55:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joelaf@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
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
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-ID: <20180807215522.04114097@vmware.local.home>
In-Reply-To: <CAJWu+oqBOEJicepLaUG=JpmtDTgxjRdMyJAgOEUkdk4NzX0esw@mail.gmail.com>
References: <20180730222423.196630-1-joel@joelfernandes.org>
        <20180730222423.196630-4-joel@joelfernandes.org>
        <20180806155058.5ee875f4@gandalf.local.home>
        <CAJWu+oqvpev_EZC38_mi+UNRCxS8GqNVagHyGM4dUjruzKgwgQ@mail.gmail.com>
        <20180806214300.13e63523@gandalf.local.home>
        <CAJWu+oqZi2W9OYAn2xu17fdrBitQs4Gti4LxWmtx5B-EYtNMmA@mail.gmail.com>
        <20180807094954.5137972d@gandalf.local.home>
        <446AE5F2-39E0-46B6-8E0B-207E003DBF20@google.com>
        <20180807103410.4fe203cb@gandalf.local.home>
        <C1CB990F-8232-4168-89A8-E8C13B660B0B@google.com>
        <20180807110906.3a1b0ac4@gandalf.local.home>
        <6B9E5DC9-0859-41B4-9B72-A7D85E9EA2AD@google.com>
        <20180807194515.4e549c1a@gandalf.local.home>
        <6D0A3FD6-2190-4CC0-A3C0-7B3759E73243@google.com>
        <20180807204820.50b83c6d@vmware.local.home>
        <CAJWu+oqBOEJicepLaUG=JpmtDTgxjRdMyJAgOEUkdk4NzX0esw@mail.gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2018 18:17:42 -0700
Joel Fernandes <joelaf@google.com> wrote:

> From 6986af946ceb04fc9ddc6d5b45fc559b6807e465 Mon Sep 17 00:00:00 2001
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Date: Sun, 5 Aug 2018 20:17:41 -0700
> Subject: [PATCH] tracepoint: Run tracepoints even after CPU is offline
> 
> Commit f37755490fe9 ("tracepoints: Do not trace when cpu is offline")
> causes a problem for lockdep using tracepoint code. Once a CPU is
> offline, tracepoints donot get called, however this causes a big problem
> for lockdep probes that need to run so that IRQ annotations are marked
> correctly.
> 
> A race is possible where while the CPU is going offline, an interrupt
> can come in and then a lockdep assert causes an annotation warning:
> 
> [  106.551354] IRQs not enabled as expected
> [  106.551785] WARNING: CPU: 1 PID: 0 at kernel/time/tick-sched.c:982
>                                          tick_nohz_idle_enter+0x99/0xb0
> [  106.552964] Modules linked in:
> [  106.553299] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
> 
> We need tracepoints to run as late as possible. This commit fixes the
> issue by removing the cpu_online check in tracepoint code that was
> introduced in the mentioned commit, however we now switch to using SRCU
> for all tracepoints and special handle calling tracepoints from NMI so
> that we don't run into issues that result from using sched-RCU when the
> CPUs are marked to be offline.
> 
> Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and
>                       unify their usage")
> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>


The above change log doesn't look like it matches the NMI patch.

Can you resend with just the NMI changes? I already handled the cpu
offline ones.

But I may still have concerns with this patch.

---
>  include/linux/tracepoint.h | 27 +++++++++++----------------
>  kernel/tracepoint.c        | 10 ++++++----
>  2 files changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index d9a084c72541..5733502bb3ce 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -35,6 +35,7 @@ struct trace_eval_map {
>  #define TRACEPOINT_DEFAULT_PRIO	10
>  
>  extern struct srcu_struct tracepoint_srcu;
> +extern struct srcu_struct tracepoint_srcu_nmi;
>  
>  extern int
>  tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
> @@ -144,13 +145,11 @@ extern void syscall_unregfunc(void);
>  		void *it_func;						\
>  		void *__data;						\
>  		int __maybe_unused idx = 0;				\
> +		struct srcu_struct *ss;					\
>  									\
>  		if (!(cond))						\
>  			return;						\
>  									\
> -		/* srcu can't be used from NMI */			\
> -		WARN_ON_ONCE(rcuidle && in_nmi());			\
> -									\
>  		/* keep srcu and sched-rcu usage consistent */		\
>  		preempt_disable_notrace();				\
>  									\
> @@ -159,7 +158,11 @@ extern void syscall_unregfunc(void);
>  		 * doesn't work from the idle path.			\
>  		 */							\
>  		if (rcuidle)						\
> -			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
> +			ss = &tracepoint_srcu_nmi;			\
> +		else							\
> +			ss = &tracepoint_srcu;				\
> +									\
> +		idx = srcu_read_lock_notrace(ss);			\
>  									\
>  		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
>  									\
> @@ -171,8 +174,7 @@ extern void syscall_unregfunc(void);
>  			} while ((++it_func_ptr)->func);		\
>  		}							\
>  									\
> -		if (rcuidle)						\
> -			srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
> +		srcu_read_unlock_notrace(ss, idx);			\

Hmm, why do we have the two different srcu handles?

Thinking about this, if this can be called by the "thunk" code, then
there might be an issue. I think the "thunk" code can be called before
in_nmi() is set, so we don't know if we are in an NMI or not. I need to
look at that code to make sure. If in_nmi() still works, then we should
use the _nmi srcu handle (if that's required).

But I'm not sure using SRCU for all tracepoints is needed at this
moment. I'll have to look deeper into this tomorrow. But it's getting
close to the merge window, and this needs to be settled quick. Another
"partial revert" may be needed until this gets settled.

-- Steve

>  									\
>  		preempt_enable_notrace();				\
>  	} while (0)
> @@ -212,11 +214,6 @@ extern void syscall_unregfunc(void);
>  				TP_PROTO(data_proto),			\
>  				TP_ARGS(data_args),			\
>  				TP_CONDITION(cond), 0);			\
> -		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
> -			rcu_read_lock_sched_notrace();			\
> -			rcu_dereference_sched(__tracepoint_##name.funcs);\
> -			rcu_read_unlock_sched_notrace();		\
> -		}							\
>  	}								\
>  	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
>  		PARAMS(cond), PARAMS(data_proto), PARAMS(data_args))	\
> @@ -365,19 +362,17 @@ extern void syscall_unregfunc(void);
>   * "void *__data, proto" as the callback prototype.
>   */
>  #define DECLARE_TRACE_NOARGS(name)					\
> -	__DECLARE_TRACE(name, void, ,					\
> -			cpu_online(raw_smp_processor_id()),		\
> +	__DECLARE_TRACE(name, void, , 1,				\
>  			void *__data, __data)
>  
>  #define DECLARE_TRACE(name, proto, args)				\
> -	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
> -			cpu_online(raw_smp_processor_id()),		\
> +	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args), 1,		\
>  			PARAMS(void *__data, proto),			\
>  			PARAMS(__data, args))
>  
>  #define DECLARE_TRACE_CONDITION(name, proto, args, cond)		\
>  	__DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),		\
> -			cpu_online(raw_smp_processor_id()) && (PARAMS(cond)), \
> +			PARAMS(cond),					\
>  			PARAMS(void *__data, proto),			\
>  			PARAMS(__data, args))
>  
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 955148d91b74..769d74b2f90e 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -32,7 +32,9 @@ extern struct tracepoint * const __start___tracepoints_ptrs[];
>  extern struct tracepoint * const __stop___tracepoints_ptrs[];
>  
>  DEFINE_SRCU(tracepoint_srcu);
> +DEFINE_SRCU(tracepoint_srcu_nmi);
>  EXPORT_SYMBOL_GPL(tracepoint_srcu);
> +EXPORT_SYMBOL_GPL(tracepoint_srcu_nmi);
>  
>  /* Set to 1 to enable tracepoint debug output */
>  static const int tracepoint_debug;
> @@ -70,14 +72,14 @@ static inline void *allocate_probes(int count)
>  	return p == NULL ? NULL : p->probes;
>  }
>  
> -static void srcu_free_old_probes(struct rcu_head *head)
> +static void srcu_free_old_probes_nmi(struct rcu_head *head)
>  {
>  	kfree(container_of(head, struct tp_probes, rcu));
>  }
>  
> -static void rcu_free_old_probes(struct rcu_head *head)
> +static void srcu_free_old_probes(struct rcu_head *head)
>  {
> -	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
> +	call_srcu(&tracepoint_srcu_nmi, head, srcu_free_old_probes_nmi);
>  }
>  
>  static inline void release_probes(struct tracepoint_func *old)
> @@ -91,7 +93,7 @@ static inline void release_probes(struct tracepoint_func *old)
>  		 * cover both cases. So let us chain the SRCU and sched RCU
>  		 * callbacks to wait for both grace periods.
>  		 */
> -		call_rcu_sched(&tp_probes->rcu, rcu_free_old_probes);
> +		call_srcu(&tracepoint_srcu, &tp_probes->rcu, srcu_free_old_probes);
>  	}
>  }
>  

