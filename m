Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753938AbeDWDB4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 23:01:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753848AbeDWDBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 23:01:53 -0400
Date: Sun, 22 Apr 2018 20:02:58 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com,
        torvalds@linux-foundation.org, npiggin@gmail.com
Subject: [PATCH tip/core/rcu 0/21] Contention reduction for v4.18
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042303-0008-0000-0000-000002FC935B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021898; UDB=6.00521542; IPR=6.00801133;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 03:01:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042303-0009-0000-0000-000038FF6636
Message-Id: <20180423030258.GA23370@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230032
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series reduces lock contention on the root rcu_node structure,
and is also the first precursor to TBD changes to consolidate the three
RCU flavors (RCU-bh, RCU-preempt, and RCU-sched) into one.

1.	Improve non-root rcu_cbs_completed() accuracy, thus reducing the
	need to acquire the root rcu_node structure's ->lock.  This also
	eliminates the need to reassign callbacks to an earlier grace
	period, which enables introduction of funnel locking in a later
	commit, which further reduces contention.

2.	Make rcu_start_future_gp()'s grace-period check more precise,
	eliminating one need for forward-progress failsafe checks
	that acquire the root rcu_node structure's ->lock.

3.	Create (and make use of) accessors for the ->need_future_gp[]
	array to enable easy changes in size.

4.	Make rcu_gp_kthread() check for early-boot activity, which was
	another situation needing failsafe checks.

5.	Make rcu_gp_cleanup() more accurately predict need for new GP.
	This eliminates the need for both failsafe checks and extra
	grace-period kthread wakeups.

6.	Avoid losing ->need_future_gp[] values due to GP start/end races
	by expanding this array from two elements to four.

7.	Make rcu_future_needs_gp() check all ->need_future_gps[] elements,
	again to eliminate a need for both failsafe checks and extra
	grace-period kthread wakeups.

8.	Convert ->need_future_gp[] array to boolean, given that there
	is no longer a need to count the number of requests for a
	future grace period.

9.	Make rcu_migrate_callbacks wake GP kthread when needed, which
	again eliminates a need for failsafe checks.

10.	Avoid __call_rcu_core() root rcu_node ->lock acquisition, which
	was one of the failsafe checks that many of the above patches
	were making safe to remove.

11.	Switch __rcu_process_callbacks() to rcu_accelerate_cbs(), which
	was one of the failsafe checks that many of the above patches
	were making safe to remove.  (Yes, this one also acquired the
	root rcu_node structure's ->lock, and was in fact the lock
	acquisition that was showing up in Nick Piggin's traces.)

12.	Put ->completed into an unsigned long instead of an int.  (The
	"int" was harmless because only the low-order bits were used,
	but it was still an accident waiting to happen.)

13.	Clear requests other than RCU_GP_FLAG_INIT at grace-period end.
	This prevents premature quiescent-state forcing that might
	otherwise occur due to requests posted when the grace period
	was already almost done.

14.	Inline rcu_start_gp_advanced() into rcu_start_future_gp().
	This brings RCU down to only one function to start a grace
	period, in happen contrast to the need to choose correctly
	between three of them before this patch series.

15.	Make rcu_start_future_gp() caller select grace period to avoid
	duplicate grace-period selection.  (We are going to like this
	grace period so much that we selected it twice!)

16.	Add funnel locking to rcu_start_this_gp(), the point being to
	reduce lock contention, especially on large systems.

17.	Make rcu_start_this_gp() check for out-of-range requests.
	If this check triggers, that indicates a bug in a caller of
	rcu_start_this_gp() or that the ->need_future_gp[] array needs
	to be even bigger, most likely the former.  More importantly, it
	avoids one possible cause of otherwise silent grace-period hangs.

18.	The rcu_gp_cleanup() function does not need cpu_needs_another_gp()
	because funnel locking summarizes the need for future
	grace periods in the root rcu_node structure's ->lock,
	which rcu_gp_cleanup() already holds for other reasons.

19.	Simplify and inline cpu_needs_another_gp(), which used to be a key
	part of the no-longer-required forward-progress failsafe checks.

20.	Drop early GP request check from rcu_gp_kthread().  Yes, it
	was added above in order avoid grace-period hangs, but at this
	point in the series is no longer needed.  All in the name of
	bisectability.

21.	Update list of rcu_future_grace_period() trace events to reflect
	strings added above.

							Thanx, Paul

------------------------------------------------------------------------

 include/trace/events/rcu.h |   13 -
 kernel/rcu/rcu_segcblist.c |   18 -
 kernel/rcu/rcu_segcblist.h |    2 
 kernel/rcu/tree.c          |  406 ++++++++++++++++-----------------------------
 kernel/rcu/tree.h          |   24 ++
 kernel/rcu/tree_plugin.h   |   28 ---
 6 files changed, 182 insertions(+), 309 deletions(-)
