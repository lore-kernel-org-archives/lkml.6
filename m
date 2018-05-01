Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755831AbeEAPyG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:54:06 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38682 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753789AbeEAPyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:54:05 -0400
X-Google-Smtp-Source: AB8JxZr1ZM4xgSiWZRDAXNBFeCGvpYzwEaLPyNAMKi+aTwR9U0NmRgX/5zYvgXk6IefZGREXNQ5DEvklqXWJP4hFA18=
MIME-Version: 1.0
References: <20180501014204.67548-1-joelaf@google.com> <20180501014204.67548-6-joelaf@google.com>
 <20180501102401.2cac5781@gandalf.local.home>
In-Reply-To: <20180501102401.2cac5781@gandalf.local.home>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 01 May 2018 15:53:53 +0000
Message-ID: <CAJWu+orW_Ej8nGumYrB5vp-NBk0WrO75W7Te2yQ5MLyXXUFs4A@mail.gmail.com>
Subject: Re: [PATCH RFC v5 5/6] tracepoint: Make rcuidle tracepoint callers
 use SRCU
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
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

Missed replying to some comments..

On Tue, May 1, 2018 at 7:24 AM Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 30 Apr 2018 18:42:03 -0700
> Joel Fernandes <joelaf@google.com> wrote:

> > In recent tests with IRQ on/off tracepoints, a large performance
> > overhead ~10% is noticed when running hackbench. This is root caused to
> > calls to rcu_irq_enter_irqson and rcu_irq_exit_irqson from the
> > tracepoint code. Following a long discussion on the list [1] about this,
> > we concluded that srcu is a better alternative for use during rcu idle.
> > Although it does involve extra barriers, its lighter than the sched-rcu
> > version which has to do additional RCU calls to notify RCU idle about
> > entry into RCU sections.
> >
> > In this patch, we change the underlying implementation of the
> > trace_*_rcuidle API to use SRCU. This has shown to improve performance
> > alot for the high frequency irq enable/disable tracepoints.

> Can you post some numbers?

Sure, I will post them in the next revision.

> > Test: Tested idle and preempt/irq tracepoints.
> >
> > [1] https://patchwork.kernel.org/patch/10344297/
> > [...]
> >  include/linux/tracepoint.h | 46 +++++++++++++++++++++++++++++++-------
> >  kernel/tracepoint.c        | 10 ++++++++-
> >  2 files changed, 47 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > index c94f466d57ef..4135e08fb5f1 100644
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -15,6 +15,7 @@
> >   */
> >
> >  #include <linux/smp.h>
> > +#include <linux/srcu.h>
> >  #include <linux/errno.h>
> >  #include <linux/types.h>
> >  #include <linux/cpumask.h>
> > @@ -33,6 +34,8 @@ struct trace_eval_map {
> >
> >  #define TRACEPOINT_DEFAULT_PRIO      10
> >
> > +extern struct srcu_struct tracepoint_srcu;
> > +
> >  extern int
> >  tracepoint_probe_register(struct tracepoint *tp, void *probe, void
*data);
> >  extern int
> > @@ -77,6 +80,9 @@ int unregister_tracepoint_module_notifier(struct
notifier_block *nb)
> >   */
> >  static inline void tracepoint_synchronize_unregister(void)
> >  {
> > +#ifdef CONFIG_TRACEPOINTS
> > +     synchronize_srcu(&tracepoint_srcu);
> > +#endif

> Not related to your patch, but I find it interesting that we don't make
> this function a nop if CONFIG_TRACEPOINTS is not set. Is it because
> something might rely on our implementation that we call
> synchronize_sched here? I think that's a too tight of a coupling for
> others to rely on this, especially since it's not in the comments about
> this function.

If there's no CONFIG_TRACEPOINTS, then nothing should be replying on the
implementation?

Basically, if !TRACEPOINTS, then there shouldn't be any active rcu read
sections calling probes.

> Again, not related to this series, but something we should probably
> consider in the future. It would require auditing users of this too.

Yes, probably could be a noop in the future.



> >       synchronize_sched();
> >  }
> >
> > @@ -129,18 +135,38 @@ extern void syscall_unregfunc(void);
> >   * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
> >   * "void *data", where as the DECLARE_TRACE() will pass in "void
*data, proto".
> >   */
> > -#define __DO_TRACE(tp, proto, args, cond, rcucheck)                  \
> > +#define __DO_TRACE(tp, proto, args, cond, rcuidle)                   \
> >       do {                                                            \
> >               struct tracepoint_func *it_func_ptr;                    \
> >               void *it_func;                                          \
> >               void *__data;                                           \
> > +             int __maybe_unused idx = 0;                             \
> >                                                                       \
> >               if (!(cond))                                            \
> >                       return;                                         \
> > -             if (rcucheck)                                           \
> > -                     rcu_irq_enter_irqson();                         \
> > -             rcu_read_lock_sched_notrace();                          \
> > -             it_func_ptr = rcu_dereference_sched((tp)->funcs);       \
> > +                                                                     \
> > +             /*                                                      \
> > +              * For rcuidle callers, use srcu since sched-rcu        \
> > +              * doesn't work from the idle path.                     \
> > +              */                                                     \
> > +             if (rcuidle) {                                          \
> > +                     if (in_nmi()) {                                 \
> > +                             WARN_ON_ONCE(1);                        \
> > +                             return; /* no srcu from nmi */          \
> > +                     }                                               \
> > +                                                                     \
> > +                     /* To keep it consistent with !rcuidle path */  \
> > +                     preempt_disable_notrace();                      \

> Why not disable preemption after taking the srcu lock?

Sure. I don't have a strong preference for either way so I could disable it
after.

[...]
> >  #ifndef MODULE
> > diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> > index 671b13457387..b3b1d65a2460 100644
> > --- a/kernel/tracepoint.c
> > +++ b/kernel/tracepoint.c
> > @@ -31,6 +31,9 @@
> >  extern struct tracepoint * const __start___tracepoints_ptrs[];
> >  extern struct tracepoint * const __stop___tracepoints_ptrs[];
> >
> > +DEFINE_SRCU(tracepoint_srcu);
> > +EXPORT_SYMBOL_GPL(tracepoint_srcu);
> > +
> >  /* Set to 1 to enable tracepoint debug output */
> >  static const int tracepoint_debug;
> >
> > @@ -67,11 +70,16 @@ static inline void *allocate_probes(int count)
> >       return p == NULL ? NULL : p->probes;
> >  }
> >
> > -static void rcu_free_old_probes(struct rcu_head *head)
> > +static void srcu_free_old_probes(struct rcu_head *head)
> >  {
> >       kfree(container_of(head, struct tp_probes, rcu));
> >  }
> >
> > +static void rcu_free_old_probes(struct rcu_head *head)
> > +{
> > +     call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);

> Hmm, is it OK to call call_srcu() from a call_rcu() callback? I guess
> it would be.

> I think we should add a comment to why we are doing this. Something
> like:

> /*
>   * Tracepoint probes are protected by both sched RCU and SRCU, by
>   * calling the SRCU callback in the sched RCU callback we cover
>   * both cases.
>   */

> Or something along those lines.

Ok I'll add these. Thanks,

- Joel
