Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DC0C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD602630A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD602630A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935200AbeFZAJ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:09:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934572AbeFZAHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:06 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q04Mkt061787
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:05 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96ttum7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:05 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:04 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06vDM3080472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EB28B2078;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38E31B205F;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 46F5E16CA0A2; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 16/40] rcu: Make RCU CPU stall warnings use ->gp_seq
Date:   Mon, 25 Jun 2018 17:08:35 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0052-0000-0000-00000303F3D3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052328; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0053-0000-0000-00005D23BCD4
Message-Id: <20180626000859.23572-16-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes the RCU CPU stall-warning code in print_other_cpu_stall(),
print_cpu_stall(), and check_cpu_stall() use ->gp_seq instead of ->gpnum
and ->completed.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 51 ++++++++++++++++++++--------------------
 kernel/rcu/tree_plugin.h |  8 +++----
 2 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6f9a564e82d3..9452842e0590 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1340,7 +1340,7 @@ static inline void panic_on_rcu_stall(void)
 		panic("RCU Stall\n");
 }
 
-static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gpnum)
+static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gp_seq)
 {
 	int cpu;
 	unsigned long flags;
@@ -1350,6 +1350,8 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gpnum)
 	struct rcu_node *rnp = rcu_get_root(rsp);
 	long totqlen = 0;
 
+	WARN_ON_ONCE(gp_seq & 0x2); /* Remove when ->gpnum removed. */
+
 	/* Kick and suppress, if so configured. */
 	rcu_stall_kick_kthreads(rsp);
 	if (rcu_cpu_stall_suppress)
@@ -1380,17 +1382,16 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gpnum)
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_segcblist_n_cbs(&per_cpu_ptr(rsp->rda,
 							    cpu)->cblist);
-	pr_cont("(detected by %d, t=%ld jiffies, g=%ld, c=%ld, q=%lu)\n",
+	pr_cont("(detected by %d, t=%ld jiffies, g=%ld, q=%lu)\n",
 	       smp_processor_id(), (long)(jiffies - rsp->gp_start),
-	       (long)rsp->gpnum, (long)rsp->completed, totqlen);
+	       (long)rcu_seq_current(&rsp->gp_seq), totqlen);
 	if (ndetected) {
 		rcu_dump_cpu_stacks(rsp);
 
 		/* Complain about tasks blocking the grace period. */
 		rcu_print_detail_task_stall(rsp);
 	} else {
-		if (READ_ONCE(rsp->gpnum) != gpnum ||
-		    READ_ONCE(rsp->completed) == gpnum) {
+		if (rcu_seq_current(&rsp->gp_seq) != gp_seq) {
 			pr_err("INFO: Stall ended before state dump start\n");
 		} else {
 			j = jiffies;
@@ -1442,9 +1443,9 @@ static void print_cpu_stall(struct rcu_state *rsp)
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_segcblist_n_cbs(&per_cpu_ptr(rsp->rda,
 							    cpu)->cblist);
-	pr_cont(" (t=%lu jiffies g=%ld c=%ld q=%lu)\n",
+	pr_cont(" (t=%lu jiffies g=%ld q=%lu)\n",
 		jiffies - rsp->gp_start,
-		(long)rsp->gpnum, (long)rsp->completed, totqlen);
+		(long)rcu_seq_current(&rsp->gp_seq), totqlen);
 
 	rcu_check_gp_kthread_starvation(rsp);
 
@@ -1471,8 +1472,8 @@ static void print_cpu_stall(struct rcu_state *rsp)
 
 static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
 {
-	unsigned long completed;
-	unsigned long gpnum;
+	unsigned long gs1;
+	unsigned long gs2;
 	unsigned long gps;
 	unsigned long j;
 	unsigned long jn;
@@ -1488,28 +1489,28 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
 	/*
 	 * Lots of memory barriers to reject false positives.
 	 *
-	 * The idea is to pick up rsp->gpnum, then rsp->jiffies_stall,
-	 * then rsp->gp_start, and finally rsp->completed.  These values
-	 * are updated in the opposite order with memory barriers (or
-	 * equivalent) during grace-period initialization and cleanup.
-	 * Now, a false positive can occur if we get an new value of
-	 * rsp->gp_start and a old value of rsp->jiffies_stall.  But given
-	 * the memory barriers, the only way that this can happen is if one
-	 * grace period ends and another starts between these two fetches.
-	 * Detect this by comparing rsp->completed with the previous fetch
-	 * from rsp->gpnum.
+	 * The idea is to pick up rsp->gp_seq, then rsp->jiffies_stall,
+	 * then rsp->gp_start, and finally another copy of rsp->gp_seq.
+	 * These values are updated in the opposite order with memory
+	 * barriers (or equivalent) during grace-period initialization
+	 * and cleanup.  Now, a false positive can occur if we get an new
+	 * value of rsp->gp_start and a old value of rsp->jiffies_stall.
+	 * But given the memory barriers, the only way that this can happen
+	 * is if one grace period ends and another starts between these
+	 * two fetches.  This is detected by comparing the second fetch
+	 * of rsp->gp_seq with the previous fetch from rsp->gp_seq.
 	 *
 	 * Given this check, comparisons of jiffies, rsp->jiffies_stall,
 	 * and rsp->gp_start suffice to forestall false positives.
 	 */
-	gpnum = READ_ONCE(rsp->gpnum);
-	smp_rmb(); /* Pick up ->gpnum first... */
+	gs1 = READ_ONCE(rsp->gp_seq);
+	smp_rmb(); /* Pick up ->gp_seq first... */
 	js = READ_ONCE(rsp->jiffies_stall);
 	smp_rmb(); /* ...then ->jiffies_stall before the rest... */
 	gps = READ_ONCE(rsp->gp_start);
-	smp_rmb(); /* ...and finally ->gp_start before ->completed. */
-	completed = READ_ONCE(rsp->completed);
-	if (ULONG_CMP_GE(completed, gpnum) ||
+	smp_rmb(); /* ...and finally ->gp_start before ->gp_seq again. */
+	gs2 = READ_ONCE(rsp->gp_seq);
+	if (gs1 != gs2 ||
 	    ULONG_CMP_LT(j, js) ||
 	    ULONG_CMP_GE(gps, js))
 		return; /* No stall or GP completed since entering function. */
@@ -1527,7 +1528,7 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
 		   cmpxchg(&rsp->jiffies_stall, js, jn) == js) {
 
 		/* They had a few time units to dump stack, so complain. */
-		print_other_cpu_stall(rsp, gpnum);
+		print_other_cpu_stall(rsp, gs2);
 	}
 }
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2036dc7426ac..f4a88e3c388d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1755,12 +1755,12 @@ static void print_cpu_stall_info(struct rcu_state *rsp, int cpu)
 	 */
 	touch_nmi_watchdog();
 
-	if (rsp->gpnum == rdp->gpnum) {
+	ticks_value = rcu_seq_ctr(rsp->gp_seq - rdp->gp_seq);
+	if (ticks_value) {
+		ticks_title = "GPs behind";
+	} else {
 		ticks_title = "ticks this GP";
 		ticks_value = rdp->ticks_this_gp;
-	} else {
-		ticks_title = "GPs behind";
-		ticks_value = rsp->gpnum - rdp->gpnum;
 	}
 	print_cpu_stall_fast_no_hz(fast_no_hz, cpu);
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
-- 
2.17.1

