Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753923AbeDWCar (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:30:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753867AbeDWCao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:30:44 -0400
Date: Sun, 22 Apr 2018 19:31:50 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel.opensrc@gmail.com
Subject: [PATCH tip/core/rcu 0/22] Miscellaneous fixes for v4.18
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18042302-0052-0000-0000-000002E0B1B4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008903; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01021888; UDB=6.00521536; IPR=6.00801123;
 MB=3.00020719; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-23 02:30:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042302-0053-0000-0000-00005C6D81D9
Message-Id: <20180423023150.GA21533@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230025
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides miscellaneous fixes:

1.	Make non-production PREEMPT cond_resched() help Tasks RCU.

2.	Inline rcu_preempt_do_callback() into its sole caller, courtesy
	of Byungchul Park.

3.	Don't allocate rcu_nocb_mask if no one needs it, for example, in
	the case where there are no no-CBs CPUs.

4.	Call wake_nocb_leader_defer() with 'FORCE' when nocb_q_count is
	high, courtesy of Byungchul Park.

5.	Remove deprecated RCU debugfs tracing code, courtesy of Byungchul
	Park.

6.	Rename cond_resched_rcu_qs() to cond_resched_tasks_rcu_qs() in
	order to reflect its actual current use case.

7.	Eliminate unused cond_resched_softirq() macro.

8.	Move __rcu_read_lock() and __rcu_read_unlock() to tree_plugin.h.

9.	Update rcu_bind_gp_kthread() header comment.

10.	Declare rcu_eqs_special_set() in public header, courtesy of
	Yury Norov.

11.	Add cleanup_srcu_struct_quiesced().

12.	Avoid flush dependency in delete controller flow, which is
	included in this series due to its need for the shiny new
	cleanup_srcu_struct_quiesced() function.

13.	Exclude near-simultaneous RCU CPU stall warnings.

14.	Add leaf-node macros to simplify code.

15.	Ensure whatisRCU.txt actually says what RCU is, courtesy of
	Paul Gortmaker.

16-21:	Debugging commits that may or may not be submitted for inclusion,
	depending on how helpful they prove to be.

22:	Use the proper lockdep annotation in dump_blkd_tasks(),
	courtesy of Boqun Feng.

							Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/whatisRCU.txt |    2 
 drivers/nvme/host/core.c        |    2 
 include/linux/rcupdate.h        |    4 -
 include/linux/rcutree.h         |    1 
 include/linux/sched.h           |   14 ++--
 include/linux/srcu.h            |   36 ++++++++++++
 kernel/rcu/rcu.h                |   11 ++-
 kernel/rcu/rcuperf.c            |    2 
 kernel/rcu/rcutorture.c         |    7 ++
 kernel/rcu/srcutiny.c           |    9 ++-
 kernel/rcu/srcutree.c           |   30 +++++-----
 kernel/rcu/tree.c               |   76 ++++++++++++++------------
 kernel/rcu/tree.h               |    8 --
 kernel/rcu/tree_exp.h           |   13 +---
 kernel/rcu/tree_plugin.h        |  116 +++++++++++++++++++++++++++++++---------
 kernel/rcu/update.c             |   50 -----------------
 kernel/sched/core.c             |   14 ----
 kernel/softirq.c                |    3 -
 kernel/torture.c                |    2 
 kernel/trace/trace_benchmark.c  |    4 -
 20 files changed, 232 insertions(+), 172 deletions(-)
