Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885DEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4976C20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4976C20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbeKLGKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:10:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731823AbeKLGKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:10:05 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABKJCCR065188
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:20:35 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npdbgjmcu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 15:20:35 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 20:20:33 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 20:20:28 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABKKRc925231470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 20:20:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96A38B2064;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A220B2065;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 20:20:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A39DC16C5D5F; Sun, 11 Nov 2018 12:20:28 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 03/17] rcutorture: Remove cbflood facility
Date:   Sun, 11 Nov 2018 12:20:13 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111201956.GA11935@linux.ibm.com>
References: <20181111201956.GA11935@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111120-0052-0000-0000-00000354249C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116031; UDB=6.00578740; IPR=6.00896132;
 MB=3.00024115; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 20:20:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111120-0053-0000-0000-00005EBB30EE
Message-Id: <20181111202027.13585-3-paulmck@linux.ibm.com>
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

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Now that the forward-progress code does a full-bore continuous callback
flood lasting multiple seconds, there is little point in also posting a
mere 60,000 callbacks every second or so.  This commit therefore removes
the old cbflood testing.  Over time, it may be desirable to concurrently
do full-bore continuous callback floods on all CPUs simultaneously, but
one dragon at a time.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../admin-guide/kernel-parameters.txt         | 18 ----
 kernel/rcu/rcutorture.c                       | 86 +------------------
 2 files changed, 1 insertion(+), 103 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 81d1d5a74728..6c53d6eb4594 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3743,24 +3743,6 @@
 			in microseconds.  The default of zero says
 			no holdoff.
 
-	rcutorture.cbflood_inter_holdoff= [KNL]
-			Set holdoff time (jiffies) between successive
-			callback-flood tests.
-
-	rcutorture.cbflood_intra_holdoff= [KNL]
-			Set holdoff time (jiffies) between successive
-			bursts of callbacks within a given callback-flood
-			test.
-
-	rcutorture.cbflood_n_burst= [KNL]
-			Set the number of bursts making up a given
-			callback-flood test.  Set this to zero to
-			disable callback-flood testing.
-
-	rcutorture.cbflood_n_per_burst= [KNL]
-			Set the number of callbacks to be registered
-			in a given burst of a callback-flood test.
-
 	rcutorture.fqs_duration= [KNL]
 			Set duration of force_quiescent_state bursts
 			in microseconds.
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8cf700ca7845..17f480129a78 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -80,13 +80,6 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@us.ibm.com> and Josh Triplett <josh@jos
 					/* Must be power of two minus one. */
 #define RCUTORTURE_RDR_MAX_SEGS (RCUTORTURE_RDR_MAX_LOOPS + 3)
 
-torture_param(int, cbflood_inter_holdoff, HZ,
-	      "Holdoff between floods (jiffies)");
-torture_param(int, cbflood_intra_holdoff, 1,
-	      "Holdoff between bursts (jiffies)");
-torture_param(int, cbflood_n_burst, 3, "# bursts in flood, zero to disable");
-torture_param(int, cbflood_n_per_burst, 20000,
-	      "# callbacks per burst in flood");
 torture_param(int, extendables, RCUTORTURE_MAX_EXTEND,
 	      "Extend readers by disabling bh (1), irqs (2), or preempt (4)");
 torture_param(int, fqs_duration, 0,
@@ -138,12 +131,10 @@ module_param(torture_type, charp, 0444);
 MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
 
 static int nrealreaders;
-static int ncbflooders;
 static struct task_struct *writer_task;
 static struct task_struct **fakewriter_tasks;
 static struct task_struct **reader_tasks;
 static struct task_struct *stats_task;
-static struct task_struct **cbflood_task;
 static struct task_struct *fqs_task;
 static struct task_struct *boost_tasks[NR_CPUS];
 static struct task_struct *stall_task;
@@ -181,7 +172,6 @@ static long n_rcu_torture_boosts;
 static atomic_long_t n_rcu_torture_timers;
 static long n_barrier_attempts;
 static long n_barrier_successes; /* did rcu_barrier test succeed? */
-static atomic_long_t n_cbfloods;
 static struct list_head rcu_torture_removed;
 
 static int rcu_torture_writer_state;
@@ -873,59 +863,6 @@ checkwait:	stutter_wait("rcu_torture_boost");
 	return 0;
 }
 
-static void rcu_torture_cbflood_cb(struct rcu_head *rhp)
-{
-}
-
-/*
- * RCU torture callback-flood kthread.  Repeatedly induces bursts of calls
- * to call_rcu() or analogous, increasing the probability of occurrence
- * of callback-overflow corner cases.
- */
-static int
-rcu_torture_cbflood(void *arg)
-{
-	int err = 1;
-	int i;
-	int j;
-	struct rcu_head *rhp;
-
-	if (cbflood_n_per_burst > 0 &&
-	    cbflood_inter_holdoff > 0 &&
-	    cbflood_intra_holdoff > 0 &&
-	    cur_ops->call &&
-	    cur_ops->cb_barrier) {
-		rhp = vmalloc(array3_size(cbflood_n_burst,
-					  cbflood_n_per_burst,
-					  sizeof(*rhp)));
-		err = !rhp;
-	}
-	if (err) {
-		VERBOSE_TOROUT_STRING("rcu_torture_cbflood disabled: Bad args or OOM");
-		goto wait_for_stop;
-	}
-	VERBOSE_TOROUT_STRING("rcu_torture_cbflood task started");
-	do {
-		schedule_timeout_interruptible(cbflood_inter_holdoff);
-		atomic_long_inc(&n_cbfloods);
-		WARN_ON(signal_pending(current));
-		for (i = 0; i < cbflood_n_burst; i++) {
-			for (j = 0; j < cbflood_n_per_burst; j++) {
-				cur_ops->call(&rhp[i * cbflood_n_per_burst + j],
-					      rcu_torture_cbflood_cb);
-			}
-			schedule_timeout_interruptible(cbflood_intra_holdoff);
-			WARN_ON(signal_pending(current));
-		}
-		cur_ops->cb_barrier();
-		stutter_wait("rcu_torture_cbflood");
-	} while (!torture_must_stop());
-	vfree(rhp);
-wait_for_stop:
-	torture_kthread_stopping("rcu_torture_cbflood");
-	return 0;
-}
-
 /*
  * RCU torture force-quiescent-state kthread.  Repeatedly induces
  * bursts of calls to force_quiescent_state(), increasing the probability
@@ -1460,11 +1397,10 @@ rcu_torture_stats_print(void)
 		n_rcu_torture_boosts,
 		atomic_long_read(&n_rcu_torture_timers));
 	torture_onoff_stats();
-	pr_cont("barrier: %ld/%ld:%ld ",
+	pr_cont("barrier: %ld/%ld:%ld\n",
 		n_barrier_successes,
 		n_barrier_attempts,
 		n_rcu_torture_barrier_error);
-	pr_cont("cbflood: %ld\n", atomic_long_read(&n_cbfloods));
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) != 0 ||
@@ -2093,8 +2029,6 @@ rcu_torture_cleanup(void)
 		 cur_ops->name, gp_seq, flags);
 	torture_stop_kthread(rcu_torture_stats, stats_task);
 	torture_stop_kthread(rcu_torture_fqs, fqs_task);
-	for (i = 0; i < ncbflooders; i++)
-		torture_stop_kthread(rcu_torture_cbflood, cbflood_task[i]);
 	if (rcu_torture_can_boost())
 		cpuhp_remove_state(rcutor_hp);
 
@@ -2377,24 +2311,6 @@ rcu_torture_init(void)
 		goto unwind;
 	if (object_debug)
 		rcu_test_debug_objects();
-	if (cbflood_n_burst > 0) {
-		/* Create the cbflood threads */
-		ncbflooders = (num_online_cpus() + 3) / 4;
-		cbflood_task = kcalloc(ncbflooders, sizeof(*cbflood_task),
-				       GFP_KERNEL);
-		if (!cbflood_task) {
-			VERBOSE_TOROUT_ERRSTRING("out of memory");
-			firsterr = -ENOMEM;
-			goto unwind;
-		}
-		for (i = 0; i < ncbflooders; i++) {
-			firsterr = torture_create_kthread(rcu_torture_cbflood,
-							  NULL,
-							  cbflood_task[i]);
-			if (firsterr)
-				goto unwind;
-		}
-	}
 	torture_init_end();
 	return 0;
 
-- 
2.17.1

