Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbeEAB4P (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 21:56:15 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:32804 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbeEAB4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 21:56:13 -0400
X-Google-Smtp-Source: AB8JxZq93gOMGhTWJ0EK0PdPSc9NMyhhAqUWRSZUnIuwOfkrB+6XXD3XnM3/UMHqsdPJkaIkM+gYJnp/WT7DCmKlv64=
MIME-Version: 1.0
References: <20180501014204.67548-1-joelaf@google.com> <20180501014204.67548-6-joelaf@google.com>
In-Reply-To: <20180501014204.67548-6-joelaf@google.com>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 01 May 2018 01:56:01 +0000
Message-ID: <CAJWu+oozGFeGq84JJ4HMkbM4HB702gUZ0=bx7qLG5DiqUAu67A@mail.gmail.com>
Subject: Re: [PATCH RFC v5 5/6] tracepoint: Make rcuidle tracepoint callers
 use SRCU
To: LKML <linux-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Cc: Frederic Weisbecker" <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 6:42 PM Joel Fernandes <joelaf@google.com> wrote:

> In recent tests with IRQ on/off tracepoints, a large performance
> overhead ~10% is noticed when running hackbench. This is root caused to
> calls to rcu_irq_enter_irqson and rcu_irq_exit_irqson from the
> tracepoint code. Following a long discussion on the list [1] about this,
> we concluded that srcu is a better alternative for use during rcu idle.
> Although it does involve extra barriers, its lighter than the sched-rcu
> version which has to do additional RCU calls to notify RCU idle about
> entry into RCU sections.

> In this patch, we change the underlying implementation of the
> trace_*_rcuidle API to use SRCU. This has shown to improve performance
> alot for the high frequency irq enable/disable tracepoints.

> Test: Tested idle and preempt/irq tracepoints.

> [1] https://patchwork.kernel.org/patch/10344297/

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
>   include/linux/tracepoint.h | 46 +++++++++++++++++++++++++++++++-------
>   kernel/tracepoint.c        | 10 ++++++++-
>   2 files changed, 47 insertions(+), 9 deletions(-)

> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index c94f466d57ef..4135e08fb5f1 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -15,6 +15,7 @@
>    */

>   #include <linux/smp.h>
> +#include <linux/srcu.h>
>   #include <linux/errno.h>
>   #include <linux/types.h>
>   #include <linux/cpumask.h>
> @@ -33,6 +34,8 @@ struct trace_eval_map {

>   #define TRACEPOINT_DEFAULT_PRIO        10

> +extern struct srcu_struct tracepoint_srcu;
> +
>   extern int
>   tracepoint_probe_register(struct tracepoint *tp, void *probe, void
*data);
>   extern int
> @@ -77,6 +80,9 @@ int unregister_tracepoint_module_notifier(struct
notifier_block *nb)
>    */
>   static inline void tracepoint_synchronize_unregister(void)
>   {
> +#ifdef CONFIG_TRACEPOINTS
> +       synchronize_srcu(&tracepoint_srcu);
> +#endif
>          synchronize_sched();
>   }

> @@ -129,18 +135,38 @@ extern void syscall_unregfunc(void);
>    * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
>    * "void *data", where as the DECLARE_TRACE() will pass in "void *data,
proto".
>    */
> -#define __DO_TRACE(tp, proto, args, cond, rcucheck)                    \
> +#define __DO_TRACE(tp, proto, args, cond, rcuidle)                     \
>          do {                                                            \
>                  struct tracepoint_func *it_func_ptr;                    \
>                  void *it_func;                                          \
>                  void *__data;                                           \
> +               int __maybe_unused idx = 0;                             \
>                                                                          \
>                  if (!(cond))                                            \
>                          return;                                         \
> -               if (rcucheck)                                           \
> -                       rcu_irq_enter_irqson();                         \
> -               rcu_read_lock_sched_notrace();                          \
> -               it_func_ptr = rcu_dereference_sched((tp)->funcs);       \
> +                                                                       \
> +               /*                                                      \
> +                * For rcuidle callers, use srcu since sched-rcu        \
> +                * doesn't work from the idle path.                     \
> +                */                                                     \
> +               if (rcuidle) {                                          \
> +                       if (in_nmi()) {                                 \
> +                               WARN_ON_ONCE(1);                        \
> +                               return; /* no srcu from nmi */          \
> +                       }                                               \
> +                                                                       \
> +                       /* To keep it consistent with !rcuidle path */  \
> +                       preempt_disable_notrace();                      \
> +                                                                       \
> +                       idx = srcu_read_lock_notrace(&tracepoint_srcu); \
> +                       it_func_ptr = srcu_dereference((tp)->funcs,     \
> +                                               &tracepoint_srcu);      \

This last bit is supposed to be srcu_dereference_notrace. The hunk to use
that is actually in patch 6/6 , sorry about that. I've fixed it in my tree
and it means patches 5/6 and 6/6 need an update. Steve, if you want me to
repost  it right away I can do that, or can wait for additional comments
and then repost.

thanks,

- Joel
