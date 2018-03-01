Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeCABVW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 20:21:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751472AbeCABVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 20:21:20 -0500
Date: Wed, 28 Feb 2018 17:21:44 -0800
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
 <20180227153646.GD3777@linux.vnet.ibm.com>
 <20180228181252.55e0590c@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228181252.55e0590c@vmware.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030101-0056-0000-0000-000004264A74
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008605; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00996557; UDB=6.00506646; IPR=6.00775880;
 MB=3.00019786; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-01 01:21:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030101-0057-0000-0000-000008684AC7
Message-Id: <20180301012144.GX3777@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803010016
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 06:12:52PM -0500, Steven Rostedt wrote:
> On Tue, 27 Feb 2018 07:36:46 -0800
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > > > --- a/include/linux/sched.h
> > > > +++ b/include/linux/sched.h
> > > > @@ -1589,6 +1589,12 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
> > > >   */
> > > >  #ifndef CONFIG_PREEMPT
> > > >  extern int _cond_resched(void);
> > > > +#elif defined(CONFIG_TASKS_RCU)
> > > > +static inline int _cond_resched(void)
> > > > +{
> > > > +	rcu_note_voluntary_context_switch(current);
> > > > +	return 0;
> > > > +}
> > > >  #else
> > > >  static inline int _cond_resched(void) { return 0; }
> > > >  #endif  
> > > 
> > > 
> > > This does work, but so does the below, without causing cond_resched()
> > > from being something other than a nop of CONFIG_PREEMPT.  
> > 
> > True, but based on the cond_resched_rcu_qs() experience, I bet that
> > trace_benchmark.c won't be the only place needing help.
> 
> Perhaps, still think this is a special case. That said, perhaps
> cond_resched isn't done in critical locations as it's a place that is
> explicitly stating that it's OK to schedule.

Building on your second sentence, when you are running a non-production
stress test, adding an extra function call and conditional branch to
cond_resched() should not be a problem.

So how about the (still untested) patch below?

							Thanx, Paul

------------------------------------------------------------------------

commit e9a6ea9fc2542459f9a63cf2b3a0264d09fbc266
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Sun Feb 25 10:40:44 2018 -0800

    EXP sched: Make non-production PREEMPT cond_resched() help Tasks RCU
    
    In CONFIG_PREEMPT=y kernels, cond_resched() is a complete no-op, and
    thus cannot help advance Tasks-RCU grace periods.  However, such grace
    periods are only an issue in non-production benchmarking runs of the
    Linux kernel.  This commit therefore makes cond_resched() invoke
    rcu_note_voluntary_context_switch() for kernels implementing Tasks RCU
    even in CONFIG_PREEMPT=y kernels.
    
    Reported-by: Steven Rostedt <rostedt@goodmis.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b161ef8a902e..970dadefb86f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1589,6 +1589,12 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
  */
 #ifndef CONFIG_PREEMPT
 extern int _cond_resched(void);
+#elif defined(CONFIG_TRACEPOINT_BENCHMARK)
+static inline int _cond_resched(void)
+{
+	rcu_note_voluntary_context_switch(current);
+	return 0;
+}
 #else
 static inline int _cond_resched(void) { return 0; }
 #endif
