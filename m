Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758629AbeD0QOe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:14:34 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34031 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758515AbeD0QOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:14:32 -0400
X-Google-Smtp-Source: AB8JxZoP8aJJ9kppJWbBNR3OSSvX17/yfRt1SYxLVbdHO8pH6z/U0+mZEp8FtxKeYLPw4G0RIR8iN1M8nl2tC2KmmX8=
MIME-Version: 1.0
In-Reply-To: <20180427155701.GL26088@linux.vnet.ibm.com>
References: <20180427042656.190746-1-joelaf@google.com> <20180427155701.GL26088@linux.vnet.ibm.com>
From: Joel Fernandes <joelaf@google.com>
Date: Fri, 27 Apr 2018 09:14:30 -0700
Message-ID: <CAJWu+or9GJwkDK9+842YbobG3=xVW-PgqS=uE5P2xFbDhmqxEQ@mail.gmail.com>
Subject: Re: [PATCH RFC] tracepoint: Introduce tracepoint callbacks executing
 with preempt on
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
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
        Vedang Patel <vedang.patel@intel.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Fri, Apr 27, 2018 at 8:57 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Thu, Apr 26, 2018 at 09:26:56PM -0700, Joel Fernandes wrote:
>> In recent tests with IRQ on/off tracepoints, a large performance
>> overhead ~10% is noticed when running hackbench. This is root caused to
>> calls to rcu_irq_enter_irqson and rcu_irq_exit_irqson from the
>> tracepoint code. Following a long discussion on the list [1] about this,
>> we concluded that srcu is a better alternative for use during rcu idle.
>> Although it does involve extra barriers, its lighter than the sched-rcu
>> version which has to do additional RCU calls to notify RCU idle about
>> entry into RCU sections.
>>
>> In this patch, we change the underlying implementation of the
>> trace_*_rcuidle API to use SRCU. This has shown to improve performance
>> alot for the high frequency irq enable/disable tracepoints.
>>
>> In the future, we can add a new may_sleep API which can use this
>> infrastructure for callbacks that actually can sleep which will support
>> Mathieu's usecase of blocking probes.
>>
>> Test: Tested idle and preempt/irq tracepoints.
>
> Looks good overall!  One question and a few comments below.
>
>                                                         Thanx, Paul
>
>> [1] https://patchwork.kernel.org/patch/10344297/
>>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Peter Zilstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Thomas Glexiner <tglx@linutronix.de>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>
>> Cc: Frederic Weisbecker <fweisbec@gmail.com>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Fenguang Wu <fengguang.wu@intel.com>
>> Cc: Baohong Liu <baohong.liu@intel.com>
>> Cc: Vedang Patel <vedang.patel@intel.com>
>> Cc: kernel-team@android.com
>> Signed-off-by: Joel Fernandes <joelaf@google.com>
>> ---
>>  include/linux/tracepoint.h | 37 +++++++++++++++++++++++++++++--------
>>  kernel/tracepoint.c        | 10 +++++++++-
>>  2 files changed, 38 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
>> index c94f466d57ef..a1c1987de423 100644
>> --- a/include/linux/tracepoint.h
>> +++ b/include/linux/tracepoint.h
>> @@ -15,6 +15,7 @@
>>   */
>>
>>  #include <linux/smp.h>
>> +#include <linux/srcu.h>
>>  #include <linux/errno.h>
>>  #include <linux/types.h>
>>  #include <linux/cpumask.h>
>> @@ -33,6 +34,8 @@ struct trace_eval_map {
>>
>>  #define TRACEPOINT_DEFAULT_PRIO      10
>>
>> +extern struct srcu_struct tracepoint_srcu;
>> +
>>  extern int
>>  tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
>>  extern int
>> @@ -77,6 +80,7 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
>>   */
>>  static inline void tracepoint_synchronize_unregister(void)
>>  {
>> +     synchronize_srcu(&tracepoint_srcu);
>>       synchronize_sched();
>>  }
>>
>> @@ -129,18 +133,26 @@ extern void syscall_unregfunc(void);
>>   * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
>>   * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
>>   */
>> -#define __DO_TRACE(tp, proto, args, cond, rcucheck)                  \
>> +#define __DO_TRACE(tp, proto, args, cond, preempt_on)                        \
>>       do {                                                            \
>>               struct tracepoint_func *it_func_ptr;                    \
>>               void *it_func;                                          \
>>               void *__data;                                           \
>> +             int __maybe_unused idx = 0;                             \
>>                                                                       \
>>               if (!(cond))                                            \
>>                       return;                                         \
>> -             if (rcucheck)                                           \
>> -                     rcu_irq_enter_irqson();                         \
>> -             rcu_read_lock_sched_notrace();                          \
>> -             it_func_ptr = rcu_dereference_sched((tp)->funcs);       \
>> +             if (preempt_on) {                                       \
>> +                     WARN_ON_ONCE(in_nmi()); /* no srcu from nmi */  \
>
> Very good on this check, thank you!

Sure thing :-)

>
>> +                     idx = srcu_read_lock(&tracepoint_srcu);         \
>
> Hmmm...  Do I need to create a _notrace variant of srcu_read_lock()
> and srcu_read_unlock()?

That shouldn't be needed. For the rcu_read_lock_sched case, there is a
preempt_disable which needs to be a notrace, but for the srcu one,
since we don't do that, I think it should be fine.

Thanks!

- Joel
