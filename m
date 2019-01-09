Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B88C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48DB22075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfAIVUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:20:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726657AbfAIVTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:19:00 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LImgQ174235
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:18:59 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwq2x4j8w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:18:59 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:18:58 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:18:53 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LIqXE15794224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:18:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5A51B2064;
        Wed,  9 Jan 2019 21:18:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 838FBB206A;
        Wed,  9 Jan 2019 21:18:52 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:18:52 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 553DC16C63FE; Wed,  9 Jan 2019 13:18:52 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 05/12] rcu: Inline force_quiescent_state() into rcu_force_quiescent_state()
Date:   Wed,  9 Jan 2019 13:18:43 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109211830.GA30595@linux.ibm.com>
References: <20190109211830.GA30595@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0068-0000-0000-000003800516
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010374; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144142; UDB=6.00595706; IPR=6.00924404;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:18:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0069-0000-0000-000047121E1A
Message-Id: <20190109211850.31599-5-paulmck@linux.ibm.com>
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

Given that rcu_force_quiescent_state() is a simple wrapper around
force_quiescent_state(), this commit saves a few lines of code by
inlining force_quiescent_state() into rcu_force_quiescent_state(),
and changing all references to force_quiescent_state() to instead
invoke rcu_force_quiescent_state().

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f4edc664fb65..e56a46444775 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -479,7 +479,6 @@ module_param_cb(jiffies_till_next_fqs, &next_fqs_jiffies_ops, &jiffies_till_next
 module_param(rcu_kick_kthreads, bool, 0644);
 
 static void force_qs_rnp(int (*f)(struct rcu_data *rdp));
-static void force_quiescent_state(void);
 static int rcu_pending(void);
 
 /*
@@ -503,15 +502,6 @@ unsigned long rcu_exp_batches_completed(void)
 }
 EXPORT_SYMBOL_GPL(rcu_exp_batches_completed);
 
-/*
- * Force a quiescent state.
- */
-void rcu_force_quiescent_state(void)
-{
-	force_quiescent_state();
-}
-EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
-
 /*
  * Convert a ->gp_state value to a character string.
  */
@@ -1310,7 +1300,7 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 
 	panic_on_rcu_stall();
 
-	force_quiescent_state();  /* Kick them all. */
+	rcu_force_quiescent_state();  /* Kick them all. */
 }
 
 static void print_cpu_stall(void)
@@ -2578,7 +2568,7 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rdp))
  * Force quiescent states on reluctant CPUs, and also detect which
  * CPUs are in dyntick-idle mode.
  */
-static void force_quiescent_state(void)
+void rcu_force_quiescent_state(void)
 {
 	unsigned long flags;
 	bool ret;
@@ -2610,6 +2600,7 @@ static void force_quiescent_state(void)
 	raw_spin_unlock_irqrestore_rcu_node(rnp_old, flags);
 	rcu_gp_kthread_wake();
 }
+EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
 
 /*
  * This function checks for grace-period requests that fail to motivate
@@ -2801,9 +2792,9 @@ static void __call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
 
 	/*
 	 * Force the grace period if too many callbacks or too long waiting.
-	 * Enforce hysteresis, and don't invoke force_quiescent_state()
+	 * Enforce hysteresis, and don't invoke rcu_force_quiescent_state()
 	 * if some other CPU has recently done so.  Also, don't bother
-	 * invoking force_quiescent_state() if the newly enqueued callback
+	 * invoking rcu_force_quiescent_state() if the newly enqueued callback
 	 * is the only one waiting for a grace period to complete.
 	 */
 	if (unlikely(rcu_segcblist_n_cbs(&rdp->cblist) >
@@ -2820,7 +2811,7 @@ static void __call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
 			rdp->blimit = LONG_MAX;
 			if (rcu_state.n_force_qs == rdp->n_force_qs_snap &&
 			    rcu_segcblist_first_pend_cb(&rdp->cblist) != head)
-				force_quiescent_state();
+				rcu_force_quiescent_state();
 			rdp->n_force_qs_snap = rcu_state.n_force_qs;
 			rdp->qlen_last_fqs_check = rcu_segcblist_n_cbs(&rdp->cblist);
 		}
-- 
2.17.1

