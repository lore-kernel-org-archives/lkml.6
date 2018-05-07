Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753448AbeEGXhy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 19:37:54 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41881 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeEGXhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 19:37:52 -0400
X-Google-Smtp-Source: AB8JxZrZQnKN0oPrLGr3KFIN1Cx9Bka/5lPb4iEnxKVAfcyeN0/gs1iIj0YGHQxGa5LC/sAIOxHOXg==
Date: Mon, 07 May 2018 16:37:45 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20180507215545.GA26088@linux.vnet.ibm.com>
References: <20180507204143.13061-1-joelaf@google.com> <20180507204143.13061-5-joelaf@google.com> <20180507210801.GZ26088@linux.vnet.ibm.com> <20180507214514.GA13787@joelaf.mtv.corp.google.com> <20180507215545.GA26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH RFC v6 4/5] tracepoint: Make rcuidle tracepoint callers use SRCU
To: paulmck@linux.vnet.ibm.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>
CC: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
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
From: Joel Fernandes <joel.opensrc@gmail.com>
Message-ID: <700CDAD4-15FB-4AE7-868C-AE01B1F9FD62@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w47Nc0Ys028341



On May 7, 2018 2:55:45 PM PDT, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
>On Mon, May 07, 2018 at 02:45:14PM -0700, Joel Fernandes wrote:
>> On Mon, May 07, 2018 at 02:08:01PM -0700, Paul E. McKenney wrote:
>> > On Mon, May 07, 2018 at 01:41:42PM -0700, Joel Fernandes wrote:
>> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>> > > 
>> > > In recent tests with IRQ on/off tracepoints, a large performance
>> > > overhead ~10% is noticed when running hackbench. This is root
>caused to
>> > > calls to rcu_irq_enter_irqson and rcu_irq_exit_irqson from the
>> > > tracepoint code. Following a long discussion on the list [1]
>about this,
>> > > we concluded that srcu is a better alternative for use during rcu
>idle.
>> > > Although it does involve extra barriers, its lighter than the
>sched-rcu
>> > > version which has to do additional RCU calls to notify RCU idle
>about
>> > > entry into RCU sections.
>> > > 
>> > > In this patch, we change the underlying implementation of the
>> > > trace_*_rcuidle API to use SRCU. This has shown to improve
>performance
>> > > alot for the high frequency irq enable/disable tracepoints.
>> [...]
>> >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> > > ---
>> > >  include/linux/tracepoint.h | 46
>+++++++++++++++++++++++++++++++-------
>> > >  kernel/tracepoint.c        | 15 ++++++++++++-
>> > >  2 files changed, 52 insertions(+), 9 deletions(-)
>> > > 
>> > > diff --git a/include/linux/tracepoint.h
>b/include/linux/tracepoint.h
>> > > index c94f466d57ef..f56f290cf8eb 100644
>> > > --- a/include/linux/tracepoint.h
>> > > +++ b/include/linux/tracepoint.h
>> > > @@ -15,6 +15,7 @@
>> > >   */
>> > > 
>> > >  #include <linux/smp.h>
>> > > +#include <linux/srcu.h>
>> > >  #include <linux/errno.h>
>> > >  #include <linux/types.h>
>> > >  #include <linux/cpumask.h>
>> > > @@ -33,6 +34,8 @@ struct trace_eval_map {
>> > > 
>> > >  #define TRACEPOINT_DEFAULT_PRIO	10
>> > > 
>> > > +extern struct srcu_struct tracepoint_srcu;
>> > > +
>> > >  extern int
>> > >  tracepoint_probe_register(struct tracepoint *tp, void *probe,
>void *data);
>> > >  extern int
>> > > @@ -77,6 +80,9 @@ int
>unregister_tracepoint_module_notifier(struct notifier_block *nb)
>> > >   */
>> > >  static inline void tracepoint_synchronize_unregister(void)
>> > >  {
>> > > +#ifdef CONFIG_TRACEPOINTS
>> > > +	synchronize_srcu(&tracepoint_srcu);
>> > > +#endif
>> > >  	synchronize_sched();
>> > >  }
>> > > 
>> > > @@ -129,18 +135,38 @@ extern void syscall_unregfunc(void);
>> > >   * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in
>just
>> > >   * "void *data", where as the DECLARE_TRACE() will pass in "void
>*data, proto".
>> > >   */
>> > > -#define __DO_TRACE(tp, proto, args, cond, rcucheck)			\
>> > > +#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
>> > >  	do {								\
>> > >  		struct tracepoint_func *it_func_ptr;			\
>> > >  		void *it_func;						\
>> > >  		void *__data;						\
>> > > +		int __maybe_unused idx = 0;				\
>> > >  									\
>> > >  		if (!(cond))						\
>> > >  			return;						\
>> > > -		if (rcucheck)						\
>> > > -			rcu_irq_enter_irqson();				\
>> > > -		rcu_read_lock_sched_notrace();				\
>> > > -		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
>> > > +									\
>> > > +		/*							\
>> > > +		 * For rcuidle callers, use srcu since sched-rcu	\
>> > > +		 * doesn't work from the idle path.			\
>> > > +		 */							\
>> > > +		if (rcuidle) {						\
>> > > +			if (in_nmi()) {					\
>> > > +				WARN_ON_ONCE(1);			\
>> > > +				return; /* no srcu from nmi */		\
>> > > +			}						\
>> > > +									\
>> > > +			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
>> > > +			it_func_ptr =					\
>> > > +				srcu_dereference_notrace((tp)->funcs,	\
>> > > +						&tracepoint_srcu);	\
>> > > +			/* To keep it consistent with !rcuidle path */	\
>> > > +			preempt_disable_notrace();			\
>> > > +		} else {						\
>> > > +			rcu_read_lock_sched_notrace();			\
>> > > +			it_func_ptr =					\
>> > > +				rcu_dereference_sched((tp)->funcs);	\
>> > > +		}							\
>> > > +									\
>> > >  		if (it_func_ptr) {					\
>> > >  			do {						\
>> > >  				it_func = (it_func_ptr)->func;		\
>> > > @@ -148,9 +174,13 @@ extern void syscall_unregfunc(void);
>> > >  				((void(*)(proto))(it_func))(args);	\
>> > >  			} while ((++it_func_ptr)->func);		\
>> > >  		}							\
>> > > -		rcu_read_unlock_sched_notrace();			\
>> > > -		if (rcucheck)						\
>> > > -			rcu_irq_exit_irqson();				\
>> > > +									\
>> > > +		if (rcuidle) {						\
>> > 
>> > Don't we also need an in_nmi() check here in order to avoid
>unbalanced
>> > srcu_read_unlock_notrace() calls?
>> 
>>  The in_nmi() in the lock path should take care of making sure its
>balanced.
>> 
>>  The diff the way its formatted appears confusing as Mathieu pointed.
>
>Ah, right, I was for some reason thinking that the two hunks of the
>diff were two separate macros.  Apologies for my confusion!
>	

No worries! Thanks for the great idea to use in_nmi in the first place.

- Joel

>							Thanx, Paul

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
