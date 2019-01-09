Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DA3C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA5E206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfAIVTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:19:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36694 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726332AbfAIVTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:19:00 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LIm3Z174299
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:18:59 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwq2x4j91-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:18:59 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:18:58 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:18:54 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LIrPX21430292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:18:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B930B206C;
        Wed,  9 Jan 2019 21:18:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF842B2071;
        Wed,  9 Jan 2019 21:18:52 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:18:52 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 79F9116C641B; Wed,  9 Jan 2019 13:18:52 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 11/12] rcu: Inline _synchronize_rcu_expedited() into synchronize_rcu_expedited()
Date:   Wed,  9 Jan 2019 13:18:49 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109211830.GA30595@linux.ibm.com>
References: <20190109211830.GA30595@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0068-0000-0000-000003800515
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010374; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144142; UDB=6.00595706; IPR=6.00924404;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:18:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0069-0000-0000-000047121E1B
Message-Id: <20190109211850.31599-11-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that _synchronize_rcu_expedited() has only one caller, and given that
this is a tail call, this commit inlines _synchronize_rcu_expedited()
into synchronize_rcu_expedited().

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree_exp.h | 81 +++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 45 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 353d113c0cd4..d882ca0cd01b 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -599,50 +599,6 @@ static void wait_rcu_exp_gp(struct work_struct *wp)
 	rcu_exp_sel_wait_wake(rewp->rew_s);
 }
 
-/*
- * Given a smp_call_function() handler, kick off the specified
- * implementation of expedited grace period.
- */
-static void _synchronize_rcu_expedited(void)
-{
-	struct rcu_data *rdp;
-	struct rcu_exp_work rew;
-	struct rcu_node *rnp;
-	unsigned long s;
-
-	/* If expedited grace periods are prohibited, fall back to normal. */
-	if (rcu_gp_is_normal()) {
-		wait_rcu_gp(call_rcu);
-		return;
-	}
-
-	/* Take a snapshot of the sequence number.  */
-	s = rcu_exp_gp_seq_snap();
-	if (exp_funnel_lock(s))
-		return;  /* Someone else did our work for us. */
-
-	/* Ensure that load happens before action based on it. */
-	if (unlikely(rcu_scheduler_active == RCU_SCHEDULER_INIT)) {
-		/* Direct call during scheduler init and early_initcalls(). */
-		rcu_exp_sel_wait_wake(s);
-	} else {
-		/* Marshall arguments & schedule the expedited grace period. */
-		rew.rew_s = s;
-		INIT_WORK_ONSTACK(&rew.rew_work, wait_rcu_exp_gp);
-		queue_work(rcu_gp_wq, &rew.rew_work);
-	}
-
-	/* Wait for expedited grace period to complete. */
-	rdp = per_cpu_ptr(&rcu_data, raw_smp_processor_id());
-	rnp = rcu_get_root();
-	wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
-		   sync_exp_work_done(s));
-	smp_mb(); /* Workqueue actions happen before return. */
-
-	/* Let the next expedited grace period start. */
-	mutex_unlock(&rcu_state.exp_mutex);
-}
-
 #ifdef CONFIG_PREEMPT_RCU
 
 /*
@@ -792,6 +748,11 @@ static void sync_sched_exp_online_cleanup(int cpu)
  */
 void synchronize_rcu_expedited(void)
 {
+	struct rcu_data *rdp;
+	struct rcu_exp_work rew;
+	struct rcu_node *rnp;
+	unsigned long s;
+
 	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
 			 lock_is_held(&rcu_lock_map) ||
 			 lock_is_held(&rcu_sched_lock_map),
@@ -801,6 +762,36 @@ void synchronize_rcu_expedited(void)
 	if (rcu_blocking_is_gp())
 		return;
 
-	_synchronize_rcu_expedited();
+	/* If expedited grace periods are prohibited, fall back to normal. */
+	if (rcu_gp_is_normal()) {
+		wait_rcu_gp(call_rcu);
+		return;
+	}
+
+	/* Take a snapshot of the sequence number.  */
+	s = rcu_exp_gp_seq_snap();
+	if (exp_funnel_lock(s))
+		return;  /* Someone else did our work for us. */
+
+	/* Ensure that load happens before action based on it. */
+	if (unlikely(rcu_scheduler_active == RCU_SCHEDULER_INIT)) {
+		/* Direct call during scheduler init and early_initcalls(). */
+		rcu_exp_sel_wait_wake(s);
+	} else {
+		/* Marshall arguments & schedule the expedited grace period. */
+		rew.rew_s = s;
+		INIT_WORK_ONSTACK(&rew.rew_work, wait_rcu_exp_gp);
+		queue_work(rcu_gp_wq, &rew.rew_work);
+	}
+
+	/* Wait for expedited grace period to complete. */
+	rdp = per_cpu_ptr(&rcu_data, raw_smp_processor_id());
+	rnp = rcu_get_root();
+	wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
+		   sync_exp_work_done(s));
+	smp_mb(); /* Workqueue actions happen before return. */
+
+	/* Let the next expedited grace period start. */
+	mutex_unlock(&rcu_state.exp_mutex);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
-- 
2.17.1

