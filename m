Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753814AbeB0Ph5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:37:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753561AbeB0Phz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:37:55 -0500
Date: Tue, 27 Feb 2018 07:36:46 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH tip/core/rcu 06/10] trace: Eliminate
 cond_resched_rcu_qs() in favor of cond_resched()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20171201192122.GA19301@linux.vnet.ibm.com>
 <1512156104-20104-6-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180224151240.0d63a059@vmware.local.home>
 <20180225174927.GC2855@linux.vnet.ibm.com>
 <20180225181730.GA3963@linux.vnet.ibm.com>
 <20180225183944.GA8840@linux.vnet.ibm.com>
 <20180226212920.43e25d6e@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226212920.43e25d6e@vmware.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022715-0036-0000-0000-000002C75105
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00995884; UDB=6.00506244; IPR=6.00775209;
 MB=3.00019762; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-27 15:36:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022715-0037-0000-0000-0000437AC651
Message-Id: <20180227153646.GD3777@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-27_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802270196
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 09:29:20PM -0500, Steven Rostedt wrote:
> On Sun, 25 Feb 2018 10:39:44 -0800
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > > Hmmm...  Grasping at straws...  Could we make cond_resched() be something
> > > like a tracepoint and instrument them with cond_resched_rcu_qs() if the
> > > current RCU-tasks grace period ran for more that (say) a minute of its
> > > ten-minute stall-warning span?  
> > 
> > On the other hand, you noted in your other email that the tracepoint
> > benchmark should not be enabled on production systems.  So how about
> > the following (again untested) patch?  The "defined(CONFIG_TASKS_RCU)"
> > might need to change, especially if RCU-tasks is used in production
> > kernels, but perhaps a starting point.
> 
> RCU tasks are used in production systems if PREEMPT is enabled (it
> allows for optimizations with ftrace, perf and kprobes).
> 
> But the tracepoint is not used.

Right, so I should use defined(CONFIG_TRACEPOINT_BENCHMARK) instead of
defined(CONFIG_TASKS_RCU).

Or am I misinterpreting the code in kernel/trace?

> > ------------------------------------------------------------------------
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index b161ef8a902e..316c29c5e506 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1589,6 +1589,12 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
> >   */
> >  #ifndef CONFIG_PREEMPT
> >  extern int _cond_resched(void);
> > +#elif defined(CONFIG_TASKS_RCU)
> > +static inline int _cond_resched(void)
> > +{
> > +	rcu_note_voluntary_context_switch(current);
> > +	return 0;
> > +}
> >  #else
> >  static inline int _cond_resched(void) { return 0; }
> >  #endif
> 
> 
> This does work, but so does the below, without causing cond_resched()
> from being something other than a nop of CONFIG_PREEMPT.

True, but based on the cond_resched_rcu_qs() experience, I bet that
trace_benchmark.c won't be the only place needing help.

							Thanx, Paul

> -- Steve
> 
> diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
> index 22fee766081b..82d83bb4874b 100644
> --- a/kernel/trace/trace_benchmark.c
> +++ b/kernel/trace/trace_benchmark.c
> @@ -166,6 +166,7 @@ static int benchmark_event_kthread(void *arg)
>  		 * block synchronize_rcu_tasks() indefinitely.
>  		 */
>  		cond_resched();
> +		rcu_note_voluntary_context_switch(current);
>  	}
> 
>  	return 0;
> 
