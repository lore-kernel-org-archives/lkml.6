Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161677AbeCAUsh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:48:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1161630AbeCAUse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:48:34 -0500
Date: Thu, 1 Mar 2018 12:48:58 -0800
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
References: <1512156104-20104-6-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180224151240.0d63a059@vmware.local.home>
 <20180225174927.GC2855@linux.vnet.ibm.com>
 <20180225181730.GA3963@linux.vnet.ibm.com>
 <20180225183944.GA8840@linux.vnet.ibm.com>
 <20180226212920.43e25d6e@vmware.local.home>
 <20180227153646.GD3777@linux.vnet.ibm.com>
 <20180228181252.55e0590c@vmware.local.home>
 <20180301012144.GX3777@linux.vnet.ibm.com>
 <20180301000404.64828a0e@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301000404.64828a0e@vmware.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030120-0052-0000-0000-000002C1C49A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008609; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00996946; UDB=6.00506879; IPR=6.00776265;
 MB=3.00019805; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-01 20:48:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030120-0053-0000-0000-00005BDC29CA
Message-Id: <20180301204858.GH3777@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010254
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 12:04:04AM -0500, Steven Rostedt wrote:
> On Wed, 28 Feb 2018 17:21:44 -0800
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > > Perhaps, still think this is a special case. That said, perhaps
> > > cond_resched isn't done in critical locations as it's a place that is
> > > explicitly stating that it's OK to schedule.  
> > 
> > Building on your second sentence, when you are running a non-production
> > stress test, adding an extra function call and conditional branch to
> > cond_resched() should not be a problem.
> > 
> > So how about the (still untested) patch below?
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit e9a6ea9fc2542459f9a63cf2b3a0264d09fbc266
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Sun Feb 25 10:40:44 2018 -0800
> > 
> >     EXP sched: Make non-production PREEMPT cond_resched() help Tasks RCU
> >     
> >     In CONFIG_PREEMPT=y kernels, cond_resched() is a complete no-op, and
> >     thus cannot help advance Tasks-RCU grace periods.  However, such grace
> >     periods are only an issue in non-production benchmarking runs of the
> >     Linux kernel.  This commit therefore makes cond_resched() invoke
> >     rcu_note_voluntary_context_switch() for kernels implementing Tasks RCU
> >     even in CONFIG_PREEMPT=y kernels.
> >     
> >     Reported-by: Steven Rostedt <rostedt@goodmis.org>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index b161ef8a902e..970dadefb86f 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1589,6 +1589,12 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
> >   */
> >  #ifndef CONFIG_PREEMPT
> >  extern int _cond_resched(void);
> > +#elif defined(CONFIG_TRACEPOINT_BENCHMARK)
> > +static inline int _cond_resched(void)
> > +{
> > +	rcu_note_voluntary_context_switch(current);
> 
> The thing I hate about this is that it is invasive to code outside of
> the tracepoint benchmark. Why do the rcu_note_voluntary_context_switch
> here and not in the tracepoint code? Seems odd to have it called
> everywhere in the kernel when it is only needed by the benchmark
> tracepoint code.

Understood, and I am not completely devoid of sympathy for that view.
My problem with adding rcu_note_voluntary_context_switch() is that it
is a pretty deep detail of RCU.

Hmmm...  I wasn't happy with your original use of cond_resched_rcu_qs()
because it is now a rather strange thing.  However, this discussion has
helped me to understand that its real distinction over cond_resched()
as things stand now is that is provides a quiescent state for Tasks RCU.

So how about I rename cond_resched_rcu_qs() to cond_resched_tasks_rcu_qs(),
which at least gives a hint as to where it needs to be used?

Would that work for you?

							Thanx, Paul

> -- Steve
> 
> 
> 
> > +	return 0;
> > +}
> >  #else
> >  static inline int _cond_resched(void) { return 0; }
> >  #endif
> 
