Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D87CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3F620644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3F620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbeH3CiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:38:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727480AbeH3CiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:10 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMcjeu081159
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:06 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m62g7usqt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:06 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:05 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcwQl36176014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73DD9B2071;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 447F7B2067;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B7DB516C91D3; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 46/52] rcu: Eliminate stall-warning use of rsp
Date:   Wed, 29 Aug 2018 15:38:48 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-2213-0000-0000-000002E508D5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557498; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-2214-0000-0000-00005B602DB0
Message-Id: <20180829223854.4055-46-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is only one rcu_state structure, there is less point
in maintaining a pointer to it.  This commit therefore replaces rsp
with &rcu_state in print_other_cpu_stall(), print_cpu_stall(), and
check_cpu_stall().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 80 +++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 41 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 488ac7a36835..ccef04bf1636 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1272,17 +1272,17 @@ static void rcu_dump_cpu_stacks(void)
 static void rcu_stall_kick_kthreads(void)
 {
 	unsigned long j;
-	struct rcu_state *rsp = &rcu_state;
 
 	if (!rcu_kick_kthreads)
 		return;
-	j = READ_ONCE(rsp->jiffies_kick_kthreads);
-	if (time_after(jiffies, j) && rsp->gp_kthread &&
-	    (rcu_gp_in_progress() || READ_ONCE(rsp->gp_flags))) {
-		WARN_ONCE(1, "Kicking %s grace-period kthread\n", rsp->name);
+	j = READ_ONCE(rcu_state.jiffies_kick_kthreads);
+	if (time_after(jiffies, j) && rcu_state.gp_kthread &&
+	    (rcu_gp_in_progress() || READ_ONCE(rcu_state.gp_flags))) {
+		WARN_ONCE(1, "Kicking %s grace-period kthread\n",
+			  rcu_state.name);
 		rcu_ftrace_dump(DUMP_ALL);
-		wake_up_process(rsp->gp_kthread);
-		WRITE_ONCE(rsp->jiffies_kick_kthreads, j + HZ);
+		wake_up_process(rcu_state.gp_kthread);
+		WRITE_ONCE(rcu_state.jiffies_kick_kthreads, j + HZ);
 	}
 }
 
@@ -1300,7 +1300,6 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 	unsigned long j;
 	int ndetected = 0;
 	struct rcu_node *rnp = rcu_get_root();
-	struct rcu_state *rsp = &rcu_state;
 	long totqlen = 0;
 
 	/* Kick and suppress, if so configured. */
@@ -1313,7 +1312,7 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 	 * See Documentation/RCU/stallwarn.txt for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
-	pr_err("INFO: %s detected stalls on CPUs/tasks:", rsp->name);
+	pr_err("INFO: %s detected stalls on CPUs/tasks:", rcu_state.name);
 	print_cpu_stall_info_begin();
 	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -1333,21 +1332,21 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 		totqlen += rcu_segcblist_n_cbs(&per_cpu_ptr(&rcu_data,
 							    cpu)->cblist);
 	pr_cont("(detected by %d, t=%ld jiffies, g=%ld, q=%lu)\n",
-	       smp_processor_id(), (long)(jiffies - rsp->gp_start),
-	       (long)rcu_seq_current(&rsp->gp_seq), totqlen);
+	       smp_processor_id(), (long)(jiffies - rcu_state.gp_start),
+	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
 	if (ndetected) {
 		rcu_dump_cpu_stacks();
 
 		/* Complain about tasks blocking the grace period. */
 		rcu_print_detail_task_stall();
 	} else {
-		if (rcu_seq_current(&rsp->gp_seq) != gp_seq) {
+		if (rcu_seq_current(&rcu_state.gp_seq) != gp_seq) {
 			pr_err("INFO: Stall ended before state dump start\n");
 		} else {
 			j = jiffies;
-			gpa = READ_ONCE(rsp->gp_activity);
+			gpa = READ_ONCE(rcu_state.gp_activity);
 			pr_err("All QSes seen, last %s kthread activity %ld (%ld-%ld), jiffies_till_next_fqs=%ld, root ->qsmask %#lx\n",
-			       rsp->name, j - gpa, j, gpa,
+			       rcu_state.name, j - gpa, j, gpa,
 			       jiffies_till_next_fqs,
 			       rcu_get_root()->qsmask);
 			/* In this case, the current CPU might be at fault. */
@@ -1355,8 +1354,8 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 		}
 	}
 	/* Rewrite if needed in case of slow consoles. */
-	if (ULONG_CMP_GE(jiffies, READ_ONCE(rsp->jiffies_stall)))
-		WRITE_ONCE(rsp->jiffies_stall,
+	if (ULONG_CMP_GE(jiffies, READ_ONCE(rcu_state.jiffies_stall)))
+		WRITE_ONCE(rcu_state.jiffies_stall,
 			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
 
 	rcu_check_gp_kthread_starvation();
@@ -1372,7 +1371,6 @@ static void print_cpu_stall(void)
 	unsigned long flags;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rcu_get_root();
-	struct rcu_state *rsp = &rcu_state;
 	long totqlen = 0;
 
 	/* Kick and suppress, if so configured. */
@@ -1385,7 +1383,7 @@ static void print_cpu_stall(void)
 	 * See Documentation/RCU/stallwarn.txt for info on how to debug
 	 * RCU CPU stall warnings.
 	 */
-	pr_err("INFO: %s self-detected stall on CPU", rsp->name);
+	pr_err("INFO: %s self-detected stall on CPU", rcu_state.name);
 	print_cpu_stall_info_begin();
 	raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
 	print_cpu_stall_info(smp_processor_id());
@@ -1395,8 +1393,8 @@ static void print_cpu_stall(void)
 		totqlen += rcu_segcblist_n_cbs(&per_cpu_ptr(&rcu_data,
 							    cpu)->cblist);
 	pr_cont(" (t=%lu jiffies g=%ld q=%lu)\n",
-		jiffies - rsp->gp_start,
-		(long)rcu_seq_current(&rsp->gp_seq), totqlen);
+		jiffies - rcu_state.gp_start,
+		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
 
 	rcu_check_gp_kthread_starvation();
 
@@ -1404,8 +1402,8 @@ static void print_cpu_stall(void)
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	/* Rewrite if needed in case of slow consoles. */
-	if (ULONG_CMP_GE(jiffies, READ_ONCE(rsp->jiffies_stall)))
-		WRITE_ONCE(rsp->jiffies_stall,
+	if (ULONG_CMP_GE(jiffies, READ_ONCE(rcu_state.jiffies_stall)))
+		WRITE_ONCE(rcu_state.jiffies_stall,
 			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
@@ -1430,7 +1428,6 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	unsigned long jn;
 	unsigned long js;
 	struct rcu_node *rnp;
-	struct rcu_state *rsp = &rcu_state;
 
 	if ((rcu_cpu_stall_suppress && !rcu_kick_kthreads) ||
 	    !rcu_gp_in_progress())
@@ -1441,27 +1438,28 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	/*
 	 * Lots of memory barriers to reject false positives.
 	 *
-	 * The idea is to pick up rsp->gp_seq, then rsp->jiffies_stall,
-	 * then rsp->gp_start, and finally another copy of rsp->gp_seq.
-	 * These values are updated in the opposite order with memory
-	 * barriers (or equivalent) during grace-period initialization
-	 * and cleanup.  Now, a false positive can occur if we get an new
-	 * value of rsp->gp_start and a old value of rsp->jiffies_stall.
-	 * But given the memory barriers, the only way that this can happen
-	 * is if one grace period ends and another starts between these
-	 * two fetches.  This is detected by comparing the second fetch
-	 * of rsp->gp_seq with the previous fetch from rsp->gp_seq.
+	 * The idea is to pick up rcu_state.gp_seq, then
+	 * rcu_state.jiffies_stall, then rcu_state.gp_start, and finally
+	 * another copy of rcu_state.gp_seq.  These values are updated in
+	 * the opposite order with memory barriers (or equivalent) during
+	 * grace-period initialization and cleanup.  Now, a false positive
+	 * can occur if we get an new value of rcu_state.gp_start and a old
+	 * value of rcu_state.jiffies_stall.  But given the memory barriers,
+	 * the only way that this can happen is if one grace period ends
+	 * and another starts between these two fetches.  This is detected
+	 * by comparing the second fetch of rcu_state.gp_seq with the
+	 * previous fetch from rcu_state.gp_seq.
 	 *
-	 * Given this check, comparisons of jiffies, rsp->jiffies_stall,
-	 * and rsp->gp_start suffice to forestall false positives.
+	 * Given this check, comparisons of jiffies, rcu_state.jiffies_stall,
+	 * and rcu_state.gp_start suffice to forestall false positives.
 	 */
-	gs1 = READ_ONCE(rsp->gp_seq);
+	gs1 = READ_ONCE(rcu_state.gp_seq);
 	smp_rmb(); /* Pick up ->gp_seq first... */
-	js = READ_ONCE(rsp->jiffies_stall);
+	js = READ_ONCE(rcu_state.jiffies_stall);
 	smp_rmb(); /* ...then ->jiffies_stall before the rest... */
-	gps = READ_ONCE(rsp->gp_start);
+	gps = READ_ONCE(rcu_state.gp_start);
 	smp_rmb(); /* ...and finally ->gp_start before ->gp_seq again. */
-	gs2 = READ_ONCE(rsp->gp_seq);
+	gs2 = READ_ONCE(rcu_state.gp_seq);
 	if (gs1 != gs2 ||
 	    ULONG_CMP_LT(j, js) ||
 	    ULONG_CMP_GE(gps, js))
@@ -1470,14 +1468,14 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
 	if (rcu_gp_in_progress() &&
 	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
-	    cmpxchg(&rsp->jiffies_stall, js, jn) == js) {
+	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
 		/* We haven't checked in, so go dump stack. */
 		print_cpu_stall();
 
 	} else if (rcu_gp_in_progress() &&
 		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
-		   cmpxchg(&rsp->jiffies_stall, js, jn) == js) {
+		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
 		/* They had a few time units to dump stack, so complain. */
 		print_other_cpu_stall(gs2);
-- 
2.17.1

