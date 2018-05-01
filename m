Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756053AbeEAPUY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:20:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755513AbeEAPUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:20:22 -0400
Date: Tue, 1 May 2018 08:21:35 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Cc: Frederic Weisbecker" <fweisbec@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Fenguang Wu <fengguang.wu@intel.com>,
        Baohong Liu <baohong.liu@intel.com>,
        Vedang Patel <vedang.patel@intel.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH RFC v5 5/6] tracepoint: Make rcuidle tracepoint callers
 use SRCU
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180501014204.67548-1-joelaf@google.com>
 <20180501014204.67548-6-joelaf@google.com>
 <20180501102401.2cac5781@gandalf.local.home>
 <20180501143601.GG26088@linux.vnet.ibm.com>
 <CAJWu+op-7oyiO7p_pvWJhcy4UBBwGZRxcuoxzW_GefPr40h-xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+op-7oyiO7p_pvWJhcy4UBBwGZRxcuoxzW_GefPr40h-xQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050115-2213-0000-0000-0000029BE94D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008957; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01025982; UDB=6.00523966; IPR=6.00805213;
 MB=3.00020883; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-01 15:20:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050115-2214-0000-0000-000059F48B36
Message-Id: <20180501152135.GJ26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805010152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 03:16:02PM +0000, Joel Fernandes wrote:
> On Tue, May 1, 2018 at 7:34 AM Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> wrote:
> 
> > On Tue, May 01, 2018 at 10:24:01AM -0400, Steven Rostedt wrote:
> > > On Mon, 30 Apr 2018 18:42:03 -0700
> > > Joel Fernandes <joelaf@google.com> wrote:
> > >
> > > > In recent tests with IRQ on/off tracepoints, a large performance
> > > > overhead ~10% is noticed when running hackbench. This is root caused
> to
> > > > calls to rcu_irq_enter_irqson and rcu_irq_exit_irqson from the
> > > > tracepoint code. Following a long discussion on the list [1] about
> this,
> > > > we concluded that srcu is a better alternative for use during rcu
> idle.
> > > > Although it does involve extra barriers, its lighter than the
> sched-rcu
> > > > version which has to do additional RCU calls to notify RCU idle about
> > > > entry into RCU sections.
> > > >
> > > > In this patch, we change the underlying implementation of the
> > > > trace_*_rcuidle API to use SRCU. This has shown to improve performance
> > > > alot for the high frequency irq enable/disable tracepoints.
> 
> > [ . . . ]
> 
> > > > --- a/kernel/tracepoint.c
> > > > +++ b/kernel/tracepoint.c
> > > > @@ -31,6 +31,9 @@
> > > >  extern struct tracepoint * const __start___tracepoints_ptrs[];
> > > >  extern struct tracepoint * const __stop___tracepoints_ptrs[];
> > > >
> > > > +DEFINE_SRCU(tracepoint_srcu);
> > > > +EXPORT_SYMBOL_GPL(tracepoint_srcu);
> > > > +
> > > >  /* Set to 1 to enable tracepoint debug output */
> > > >  static const int tracepoint_debug;
> > > >
> > > > @@ -67,11 +70,16 @@ static inline void *allocate_probes(int count)
> > > >     return p == NULL ? NULL : p->probes;
> > > >  }
> > > >
> > > > -static void rcu_free_old_probes(struct rcu_head *head)
> > > > +static void srcu_free_old_probes(struct rcu_head *head)
> > > >  {
> > > >     kfree(container_of(head, struct tp_probes, rcu));
> > > >  }
> > > >
> > > > +static void rcu_free_old_probes(struct rcu_head *head)
> > > > +{
> > > > +   call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
> > >
> > > Hmm, is it OK to call call_srcu() from a call_rcu() callback? I guess
> > > it would be.
> 
> > It is perfectly legal, and quite a bit simpler than setting something
> > up to wait for both to complete concurrently.
> 
> Cool. Also in this case if we call both in sequence, then I felt there
> could be a race to free the old data since both callbacks would try to do
> the same thing. The same thing being freeing of the same set of old probes
> which would need some synchronization between the 2 callbacks. With the
> chaining, since the ordering is assured there wouldn't be a question of
> such a race. I could add this reasoning to the changelog as well.

Actually, as long as you have a solid happens-before between both of the
callbacks and the freeing, you are in good shape.  A release-acquire would
work fine, as would a lock acquired in both callbacks and then acquired
(and possibly released) before the free.

							Thanx, Paul
