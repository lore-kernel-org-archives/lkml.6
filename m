Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755443AbeEAPkx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:40:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41406 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751071AbeEAPkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:40:52 -0400
Date: Tue, 1 May 2018 08:42:05 -0700
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
 <20180501152135.GJ26088@linux.vnet.ibm.com>
 <CAJWu+oqO0WQwK-iU76D0zWE-A=-pHRPwzh3WG8yWq13G=c7HhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+oqO0WQwK-iU76D0zWE-A=-pHRPwzh3WG8yWq13G=c7HhQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18050115-2213-0000-0000-0000029BEB03
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008957; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01025989; UDB=6.00523970; IPR=6.00805220;
 MB=3.00020883; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-01 15:40:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050115-2214-0000-0000-000059F49479
Message-Id: <20180501154205.GM26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805010154
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 03:23:52PM +0000, Joel Fernandes wrote:
> On Tue, May 1, 2018 at 8:20 AM Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> wrote:
> [...]
> > > > > > --- a/kernel/tracepoint.c
> > > > > > +++ b/kernel/tracepoint.c
> > > > > > @@ -31,6 +31,9 @@
> > > > > >  extern struct tracepoint * const __start___tracepoints_ptrs[];
> > > > > >  extern struct tracepoint * const __stop___tracepoints_ptrs[];
> > > > > >
> > > > > > +DEFINE_SRCU(tracepoint_srcu);
> > > > > > +EXPORT_SYMBOL_GPL(tracepoint_srcu);
> > > > > > +
> > > > > >  /* Set to 1 to enable tracepoint debug output */
> > > > > >  static const int tracepoint_debug;
> > > > > >
> > > > > > @@ -67,11 +70,16 @@ static inline void *allocate_probes(int count)
> > > > > >     return p == NULL ? NULL : p->probes;
> > > > > >  }
> > > > > >
> > > > > > -static void rcu_free_old_probes(struct rcu_head *head)
> > > > > > +static void srcu_free_old_probes(struct rcu_head *head)
> > > > > >  {
> > > > > >     kfree(container_of(head, struct tp_probes, rcu));
> > > > > >  }
> > > > > >
> > > > > > +static void rcu_free_old_probes(struct rcu_head *head)
> > > > > > +{
> > > > > > +   call_srcu(&tracepoint_srcu, head, srcu_free_old_probes);
> > > > >
> > > > > Hmm, is it OK to call call_srcu() from a call_rcu() callback? I
> guess
> > > > > it would be.
> > >
> > > > It is perfectly legal, and quite a bit simpler than setting something
> > > > up to wait for both to complete concurrently.
> > >
> > > Cool. Also in this case if we call both in sequence, then I felt there
> > > could be a race to free the old data since both callbacks would try to
> do
> > > the same thing. The same thing being freeing of the same set of old
> probes
> > > which would need some synchronization between the 2 callbacks. With the
> > > chaining, since the ordering is assured there wouldn't be a question of
> > > such a race. I could add this reasoning to the changelog as well.
> 
> > Actually, as long as you have a solid happens-before between both of the
> > callbacks and the freeing, you are in good shape.  A release-acquire would
> > work fine, as would a lock acquired in both callbacks and then acquired
> > (and possibly released) before the free.
> 
> Got it, thanks. For now, if its Ok with you and others, I will leave it in
> the chained configuration. I also feel this is temporary since in the
> future if we switch to single rcu mechanism for tracepoints (srcu), then we
> could do with just a single callback.

I have no problem with chained callbacks.  Heck, I even test them in
rcutorture.  ;-)

							Thanx, Paul
