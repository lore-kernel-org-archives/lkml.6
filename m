Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753140AbeEGVy1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 17:54:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752846AbeEGVy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 17:54:26 -0400
Date: Mon, 7 May 2018 14:55:45 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
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
 <20180507210801.GZ26088@linux.vnet.ibm.com>
 <20180507214514.GA13787@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507214514.GA13787@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050721-0040-0000-0000-00000427F1D5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008989; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01028992; UDB=6.00525758; IPR=6.00808126;
 MB=3.00020980; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-07 21:54:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050721-0041-0000-0000-0000082DFE41
Message-Id: <20180507215545.GA26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070214
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 02:45:14PM -0700, Joel Fernandes wrote:
> On Mon, May 07, 2018 at 02:08:01PM -0700, Paul E. McKenney wrote:
> > On Mon, May 07, 2018 at 01:41:42PM -0700, Joel Fernandes wrote:
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > 
> > > In recent tests with IRQ on/off tracepoints, a large performance
> > > overhead ~10% is noticed when running hackbench. This is root caused to
> > > calls to rcu_irq_enter_irqson and rcu_irq_exit_irqson from the
> > > tracepoint code. Following a long discussion on the list [1] about this,
> > > we concluded that srcu is a better alternative for use during rcu idle.
> > > Although it does involve extra barriers, its lighter than the sched-rcu
> > > version which has to do additional RCU calls to notify RCU idle about
> > > entry into RCU sections.
> > > 
> > > In this patch, we change the underlying implementation of the
> > > trace_*_rcuidle API to use SRCU. This has shown to improve performance
> > > alot for the high frequency irq enable/disable tracepoints.
> [...]
> >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  include/linux/tracepoint.h | 46 +++++++++++++++++++++++++++++++-------
> > >  kernel/tracepoint.c        | 15 ++++++++++++-
> > >  2 files changed, 52 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > > index c94f466d57ef..f56f290cf8eb 100644
> > > --- a/include/linux/tracepoint.h
> > > +++ b/include/linux/tracepoint.h
> > > @@ -15,6 +15,7 @@
> > >   */
> > > 
> > >  #include <linux/smp.h>
> > > +#include <linux/srcu.h>
> > >  #include <linux/errno.h>
> > >  #include <linux/types.h>
> > >  #include <linux/cpumask.h>
> > > @@ -33,6 +34,8 @@ struct trace_eval_map {
> > > 
> > >  #define TRACEPOINT_DEFAULT_PRIO	10
> > > 
> > > +extern struct srcu_struct tracepoint_srcu;
> > > +
> > >  extern int
> > >  tracepoint_probe_register(struct tracepoint *tp, void *probe, void *data);
> > >  extern int
> > > @@ -77,6 +80,9 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
> > >   */
> > >  static inline void tracepoint_synchronize_unregister(void)
> > >  {
> > > +#ifdef CONFIG_TRACEPOINTS
> > > +	synchronize_srcu(&tracepoint_srcu);
> > > +#endif
> > >  	synchronize_sched();
> > >  }
> > > 
> > > @@ -129,18 +135,38 @@ extern void syscall_unregfunc(void);
> > >   * as "(void *, void)". The DECLARE_TRACE_NOARGS() will pass in just
> > >   * "void *data", where as the DECLARE_TRACE() will pass in "void *data, proto".
> > >   */
> > > -#define __DO_TRACE(tp, proto, args, cond, rcucheck)			\
> > > +#define __DO_TRACE(tp, proto, args, cond, rcuidle)			\
> > >  	do {								\
> > >  		struct tracepoint_func *it_func_ptr;			\
> > >  		void *it_func;						\
> > >  		void *__data;						\
> > > +		int __maybe_unused idx = 0;				\
> > >  									\
> > >  		if (!(cond))						\
> > >  			return;						\
> > > -		if (rcucheck)						\
> > > -			rcu_irq_enter_irqson();				\
> > > -		rcu_read_lock_sched_notrace();				\
> > > -		it_func_ptr = rcu_dereference_sched((tp)->funcs);	\
> > > +									\
> > > +		/*							\
> > > +		 * For rcuidle callers, use srcu since sched-rcu	\
> > > +		 * doesn't work from the idle path.			\
> > > +		 */							\
> > > +		if (rcuidle) {						\
> > > +			if (in_nmi()) {					\
> > > +				WARN_ON_ONCE(1);			\
> > > +				return; /* no srcu from nmi */		\
> > > +			}						\
> > > +									\
> > > +			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
> > > +			it_func_ptr =					\
> > > +				srcu_dereference_notrace((tp)->funcs,	\
> > > +						&tracepoint_srcu);	\
> > > +			/* To keep it consistent with !rcuidle path */	\
> > > +			preempt_disable_notrace();			\
> > > +		} else {						\
> > > +			rcu_read_lock_sched_notrace();			\
> > > +			it_func_ptr =					\
> > > +				rcu_dereference_sched((tp)->funcs);	\
> > > +		}							\
> > > +									\
> > >  		if (it_func_ptr) {					\
> > >  			do {						\
> > >  				it_func = (it_func_ptr)->func;		\
> > > @@ -148,9 +174,13 @@ extern void syscall_unregfunc(void);
> > >  				((void(*)(proto))(it_func))(args);	\
> > >  			} while ((++it_func_ptr)->func);		\
> > >  		}							\
> > > -		rcu_read_unlock_sched_notrace();			\
> > > -		if (rcucheck)						\
> > > -			rcu_irq_exit_irqson();				\
> > > +									\
> > > +		if (rcuidle) {						\
> > 
> > Don't we also need an in_nmi() check here in order to avoid unbalanced
> > srcu_read_unlock_notrace() calls?
> 
>  The in_nmi() in the lock path should take care of making sure its balanced.
> 
>  The diff the way its formatted appears confusing as Mathieu pointed.

Ah, right, I was for some reason thinking that the two hunks of the
diff were two separate macros.  Apologies for my confusion!
	
							Thanx, Paul
