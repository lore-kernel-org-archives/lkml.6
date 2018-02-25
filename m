Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeBYSjZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 13:39:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48426 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751728AbeBYSjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 13:39:23 -0500
Date: Sun, 25 Feb 2018 10:39:44 -0800
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180225181730.GA3963@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022518-0056-0000-0000-00000423D3BC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008596; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00994987; UDB=6.00505710; IPR=6.00774320;
 MB=3.00019734; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-25 18:39:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022518-0057-0000-0000-00000865DC57
Message-Id: <20180225183944.GA8840@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802250249
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 25, 2018 at 10:17:30AM -0800, Paul E. McKenney wrote:
> On Sun, Feb 25, 2018 at 09:49:27AM -0800, Paul E. McKenney wrote:
> > On Sat, Feb 24, 2018 at 03:12:40PM -0500, Steven Rostedt wrote:
> > > On Fri,  1 Dec 2017 11:21:40 -0800
> > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > 
> > > > Now that cond_resched() also provides RCU quiescent states when
> > > > needed, it can be used in place of cond_resched_rcu_qs().  This
> > > > commit therefore makes this change.
> > > 
> > > Are you sure this is true?
> > 
> > Up to a point.  If a given CPU has been blocking an RCU grace period for
> > long enough, that CPU's rcu_dynticks.rcu_need_heavy_qs will be set, and
> > then the next cond_resched() will be treated as a cond_resched_rcu_qs().
> > 
> > However, to your point, if there is no grace period in progress or if 
> > the current grace period is not waiting on the CPU in question or if
> > the grace-period kthread is starved of CPU, then cond_resched() has no
> > effect on RCU.  Unless of course it results in a context switch.
> > 
> > > I just bisected a lock up on my machine down to this commit.
> > > 
> > > With CONFIG_TRACEPOINT_BENCHMARK=y
> > > 
> > > # cd linux.git/tools/testing/selftests/ftrace/
> > > # ./ftracetest test.d/ftrace/func_traceonoff_triggers.tc
> > > 
> > > Locks up with a backtrace of:
> > > 
> > > [  614.186509] INFO: rcu_tasks detected stalls on tasks:
> > 
> > Ah, but this is RCU-tasks!  Which never sets rcu_dynticks.rcu_need_heavy_qs,
> > thus needing a real context switch.
> > 
> > Hey, when you said that synchronize_rcu_tasks() could take a very long
> > time, I took you at your word!  ;-)
> > 
> > Does the following (untested, probably does not even build) patch make
> > cond_resched() take a more peremptory approach to RCU-tasks?
> 
> And probably not.  You are probably running CONFIG_PREEMPT=y (otherwise
> RCU-tasks is trivial), so cond_resched() is a complete no-op:
> 
> static inline int _cond_resched(void) { return 0; }
> 
> I could make this call rcu_all_qs(), but I would not expect Peter Zijlstra
> to be at all happy with that sort of change.
> 
> And the people who asked for the cond_resched() work probably aren't
> going to be happy with the resumed proliferation of cond_resched_rcu_qs().
> 
> Hmmm...  Grasping at straws...  Could we make cond_resched() be something
> like a tracepoint and instrument them with cond_resched_rcu_qs() if the
> current RCU-tasks grace period ran for more that (say) a minute of its
> ten-minute stall-warning span?

On the other hand, you noted in your other email that the tracepoint
benchmark should not be enabled on production systems.  So how about
the following (again untested) patch?  The "defined(CONFIG_TASKS_RCU)"
might need to change, especially if RCU-tasks is used in production
kernels, but perhaps a starting point.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b161ef8a902e..316c29c5e506 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1589,6 +1589,12 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
  */
 #ifndef CONFIG_PREEMPT
 extern int _cond_resched(void);
+#elif defined(CONFIG_TASKS_RCU)
+static inline int _cond_resched(void)
+{
+	rcu_note_voluntary_context_switch(current);
+	return 0;
+}
 #else
 static inline int _cond_resched(void) { return 0; }
 #endif
