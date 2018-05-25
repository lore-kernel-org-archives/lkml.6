Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967963AbeEYTQa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:16:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967820AbeEYTQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:16:28 -0400
Date: Fri, 25 May 2018 12:18:02 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        peterz@infradead.org, bigeasy@linutronix.de,
        qianyue.zj@alibaba-inc.com, efault@gmx.de
Subject: [PATCH RFC rcu/x86] Provide early rcu_cpu_starting() callback
Reply-To: paulmck@linux.vnet.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052519-0056-0000-0000-00000455C4C0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009083; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000262; SDB=6.01037574; UDB=6.00530875; IPR=6.00816702;
 MB=3.00021296; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-25 19:16:26
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052519-0057-0000-0000-00000899E380
Message-Id: <20180525191802.GA7141@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805250200
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86/mtrr code does horrific things because hardware. It uses
stop_machine_from_inactive_cpu(), which does a wakeup (of the stopper
thread on another CPU), which uses RCU, all before the CPU is onlined.

RCU complains about this, because wakeups use RCU and RCU does
(rightfully) not consider offline CPUs for grace-periods.

Fix this by initializing RCU way early in the MTRR case.

Tested-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Add !SMP support, per 0day Test Robot report. ]
---

This should have been in last week's RCU pull request, but slipped through
the cracks.  It also needed fixes for a bug located by 0day Test Robot.
If I don't hear otherwise, I will send a pull request on Tuesday May 29,
Pacific Time.

 arch/x86/kernel/cpu/mtrr/main.c |    4 ++++
 include/linux/rcupdate.h        |    1 -
 include/linux/rcutiny.h         |    1 +
 include/linux/rcutree.h         |    1 +
 kernel/rcu/tree.c               |    9 +++++++++
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
index 7468de429087..3ea0047beb40 100644
--- a/arch/x86/kernel/cpu/mtrr/main.c
+++ b/arch/x86/kernel/cpu/mtrr/main.c
@@ -46,6 +46,7 @@
 #include <linux/pci.h>
 #include <linux/smp.h>
 #include <linux/syscore_ops.h>
+#include <linux/rcupdate.h>
 
 #include <asm/cpufeature.h>
 #include <asm/e820/api.h>
@@ -793,6 +794,9 @@ void mtrr_ap_init(void)
 
 	if (!use_intel() || mtrr_aps_delayed_init)
 		return;
+
+	rcu_cpu_starting(smp_processor_id());
+
 	/*
 	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
 	 * changed, but this routine will be called in cpu boot time,
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 19d235fefdb9..e679b175b411 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -108,7 +108,6 @@ void rcu_sched_qs(void);
 void rcu_bh_qs(void);
 void rcu_check_callbacks(int user);
 void rcu_report_dead(unsigned int cpu);
-void rcu_cpu_starting(unsigned int cpu);
 void rcutree_migrate_callbacks(int cpu);
 
 #ifdef CONFIG_RCU_STALL_COMMON
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index ce9beec35e34..7b3c82e8a625 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -132,5 +132,6 @@ static inline void rcu_all_qs(void) { barrier(); }
 #define rcutree_offline_cpu      NULL
 #define rcutree_dead_cpu         NULL
 #define rcutree_dying_cpu        NULL
+static inline void rcu_cpu_starting(unsigned int cpu) { }
 
 #endif /* __LINUX_RCUTINY_H */
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 448f20f27396..914655848ef6 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -101,5 +101,6 @@ int rcutree_online_cpu(unsigned int cpu);
 int rcutree_offline_cpu(unsigned int cpu);
 int rcutree_dead_cpu(unsigned int cpu);
 int rcutree_dying_cpu(unsigned int cpu);
+void rcu_cpu_starting(unsigned int cpu);
 
 #endif /* __LINUX_RCUTREE_H */
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4fccdfa25716..aa7cade1b9f3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3665,6 +3665,8 @@ int rcutree_dead_cpu(unsigned int cpu)
 	return 0;
 }
 
+static DEFINE_PER_CPU(int, rcu_cpu_started);
+
 /*
  * Mark the specified CPU as being online so that subsequent grace periods
  * (both expedited and normal) will wait on it.  Note that this means that
@@ -3686,6 +3688,11 @@ void rcu_cpu_starting(unsigned int cpu)
 	struct rcu_node *rnp;
 	struct rcu_state *rsp;
 
+	if (per_cpu(rcu_cpu_started, cpu))
+		return;
+
+	per_cpu(rcu_cpu_started, cpu) = 1;
+
 	for_each_rcu_flavor(rsp) {
 		rdp = per_cpu_ptr(rsp->rda, cpu);
 		rnp = rdp->mynode;
@@ -3742,6 +3749,8 @@ void rcu_report_dead(unsigned int cpu)
 	preempt_enable();
 	for_each_rcu_flavor(rsp)
 		rcu_cleanup_dying_idle_cpu(cpu, rsp);
+
+	per_cpu(rcu_cpu_started, cpu) = 0;
 }
 
 /* Migrate the dead CPU's callbacks to the current CPU. */
