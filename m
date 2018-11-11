Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B72C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE19B20854
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE19B20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbeKLGKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:10:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731331AbeKLGKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:10:04 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABKJ92j121960
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:20:34 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npdvs9wk2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:20:34 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 20:20:33 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 20:20:29 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABKKSeb41877580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 20:20:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33068B2068;
        Sun, 11 Nov 2018 20:20:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDEF5B205F;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BE7C216C5DA1; Sun, 11 Nov 2018 12:20:28 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 08/17] rcutorture: Dump grace-period diagnostics upon forward-progress OOM
Date:   Sun, 11 Nov 2018 12:20:18 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111201956.GA11935@linux.ibm.com>
References: <20181111201956.GA11935@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111120-0052-0000-0000-00000354249E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116031; UDB=6.00578740; IPR=6.00896132;
 MB=3.00024115; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 20:20:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111120-0053-0000-0000-00005EBB30F1
Message-Id: <20181111202027.13585-8-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds an OOM notifier during rcutorture forward-progress
testing.  If this notifier is invoked, it dumps out some grace-period
state to help debug the forward-progress problem.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/rcu.h        |  2 ++
 kernel/rcu/rcutorture.c | 31 ++++++++++++++++++++++++++++---
 kernel/rcu/tree.c       | 20 ++++++++++++++++++++
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 0f0f5ae8c3d4..a393e24a9195 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -526,12 +526,14 @@ srcu_batches_completed(struct srcu_struct *sp) { return 0; }
 static inline void rcu_force_quiescent_state(void) { }
 static inline void show_rcu_gp_kthreads(void) { }
 static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
+static inline void rcu_fwd_progress_check(unsigned long j) { }
 #else /* #ifdef CONFIG_TINY_RCU */
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_exp_batches_completed(void);
 unsigned long srcu_batches_completed(struct srcu_struct *sp);
 void show_rcu_gp_kthreads(void);
 int rcu_get_gp_kthreads_prio(void);
+void rcu_fwd_progress_check(unsigned long j);
 void rcu_force_quiescent_state(void);
 extern struct workqueue_struct *rcu_gp_wq;
 extern struct workqueue_struct *rcu_par_gp_wq;
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index c4fd61dccedb..f28b88ecb47a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -56,6 +56,7 @@
 #include <linux/vmalloc.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/sysctl.h>
+#include <linux/oom.h>
 
 #include "rcu.h"
 
@@ -1624,6 +1625,7 @@ static struct rcu_fwd_cb *rcu_fwd_cb_head;
 static struct rcu_fwd_cb **rcu_fwd_cb_tail = &rcu_fwd_cb_head;
 static long n_launders_cb;
 static unsigned long rcu_fwd_startat;
+static bool rcu_fwd_emergency_stop;
 #define MAX_FWD_CB_JIFFIES	(8 * HZ) /* Maximum CB test duration. */
 #define MIN_FWD_CB_LAUNDERS	3	/* This many CB invocations to count. */
 #define MIN_FWD_CBS_LAUNDERED	100	/* Number of counted CBs. */
@@ -1681,7 +1683,8 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 	dur = sd4 + torture_random(&trs) % (sd - sd4);
 	WRITE_ONCE(rcu_fwd_startat, jiffies);
 	stopat = rcu_fwd_startat + dur;
-	while (time_before(jiffies, stopat) && !torture_must_stop()) {
+	while (time_before(jiffies, stopat) &&
+	       !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
 		idx = cur_ops->readlock();
 		udelay(10);
 		cur_ops->readunlock(idx);
@@ -1689,7 +1692,8 @@ static void rcu_torture_fwd_prog_nr(int *tested, int *tested_tries)
 			cond_resched();
 	}
 	(*tested_tries)++;
-	if (!time_before(jiffies, stopat) && !torture_must_stop()) {
+	if (!time_before(jiffies, stopat) &&
+	    !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
 		(*tested)++;
 		cver = READ_ONCE(rcu_torture_current_version) - cver;
 		gps = rcutorture_seq_diff(cur_ops->get_gp_seq(), gps);
@@ -1739,7 +1743,8 @@ static void rcu_torture_fwd_prog_cr(void)
 		n_launders_hist[i] = 0;
 	cver = READ_ONCE(rcu_torture_current_version);
 	gps = cur_ops->get_gp_seq();
-	while (time_before(jiffies, stopat) && !torture_must_stop()) {
+	while (time_before(jiffies, stopat) &&
+	       !READ_ONCE(rcu_fwd_emergency_stop) && !torture_must_stop()) {
 		rfcp = READ_ONCE(rcu_fwd_cb_head);
 		rfcpn = NULL;
 		if (rfcp)
@@ -1796,6 +1801,23 @@ static void rcu_torture_fwd_prog_cr(void)
 	}
 }
 
+
+/*
+ * OOM notifier, but this only prints diagnostic information for the
+ * current forward-progress test.
+ */
+static int rcutorture_oom_notify(struct notifier_block *self,
+				 unsigned long notused, void *nfreed)
+{
+	rcu_fwd_progress_check(1 + (jiffies - READ_ONCE(rcu_fwd_startat) / 2));
+	WRITE_ONCE(rcu_fwd_emergency_stop, true);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block rcutorture_oom_nb = {
+	.notifier_call = rcutorture_oom_notify
+};
+
 /* Carry out grace-period forward-progress testing. */
 static int rcu_torture_fwd_prog(void *args)
 {
@@ -1808,8 +1830,11 @@ static int rcu_torture_fwd_prog(void *args)
 		set_user_nice(current, MAX_NICE);
 	do {
 		schedule_timeout_interruptible(fwd_progress_holdoff * HZ);
+		WRITE_ONCE(rcu_fwd_emergency_stop, false);
+		register_oom_notifier(&rcutorture_oom_nb);
 		rcu_torture_fwd_prog_nr(&tested, &tested_tries);
 		rcu_torture_fwd_prog_cr();
+		unregister_oom_notifier(&rcutorture_oom_nb);
 
 		/* Avoid slow periods, better to test when busy. */
 		stutter_wait("rcu_torture_fwd_prog");
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 121f833acd04..6f04352011d7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2654,6 +2654,26 @@ rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
+/*
+ * Do a forward-progress check for rcutorture.  This is normally invoked
+ * due to an OOM event.  The argument "j" gives the time period during
+ * which rcutorture would like progress to have been made.
+ */
+void rcu_fwd_progress_check(unsigned long j)
+{
+	struct rcu_data *rdp;
+
+	if (rcu_gp_in_progress()) {
+		show_rcu_gp_kthreads();
+	} else {
+		preempt_disable();
+		rdp = this_cpu_ptr(&rcu_data);
+		rcu_check_gp_start_stall(rdp->mynode, rdp, j);
+		preempt_enable();
+	}
+}
+EXPORT_SYMBOL_GPL(rcu_fwd_progress_check);
+
 /*
  * This does the RCU core processing work for the specified rcu_data
  * structures.  This may be called only from the CPU to whom the rdp
-- 
2.17.1

