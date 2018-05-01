Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756038AbeEAOeu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:34:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755876AbeEAOes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:34:48 -0400
Date: Tue, 1 May 2018 07:36:01 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH RFC v5 5/6] tracepoint: Make rcuidle tracepoint callers
 use SRCU
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180501014204.67548-1-joelaf@google.com>
 <20180501014204.67548-6-joelaf@google.com>
 <20180501102401.2cac5781@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180501102401.2cac5781@gandalf.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050114-0048-0000-0000-00000266829C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008957; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01025967; UDB=6.00523957; IPR=6.00805198;
 MB=3.00020882; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-01 14:34:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050114-0049-0000-0000-000044F78B9C
Message-Id: <20180501143601.GG26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805010146
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 10:24:01AM -0400, Steven Rostedt wrote:
> On Mon, 30 Apr 2018 18:42:03 -0700
> Joel Fernandes <joelaf@google.com> wrote:
> 
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

[ . . . ]

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
> >  	return p == NULL ? NULL : p->probes;
> >  }
> >  
> > -static void rcu_free_old_probes(struct rcu_head *head)
> > +static void srcu_free_old_probes(struct rcu_head *head)
> >  {
> >  	kfree(container_of(head, struct tp_probes, rcu));
> >  }
> >  
> > +static void rcu_free_old_probes(struct rcu_head *head)
> > +{
> > +	call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
> 
> Hmm, is it OK to call call_srcu() from a call_rcu() callback? I guess
> it would be.

It is perfectly legal, and quite a bit simpler than setting something
up to wait for both to complete concurrently.

Of course, if you unconditionally call call_srcu() from that same
srcu_struct's callback, SRCU will be unable to safely delete the
srcu_struct, so cleanup_srcu_struct() will react by leaking memory.  ;-)

Normal RCU deals with the analogous situation by leaving at least one
callback uninvoked when the system goes down.

							Thanx, Paul

> I think we should add a comment to why we are doing this. Something
> like:
> 
> /*
>  * Tracepoint probes are protected by both sched RCU and SRCU, by
>  * calling the SRCU callback in the sched RCU callback we cover
>  * both cases.
>  */
> 
> Or something along those lines.
> 
> -- Steve
> 
> 
> > +}
> > +
> >  static inline void release_probes(struct tracepoint_func *old)
> >  {
> >  	if (old) {
> 
