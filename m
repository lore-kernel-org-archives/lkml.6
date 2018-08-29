Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC41C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C2720647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C2720647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbeH3DHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:07:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727328AbeH3DG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:06:56 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TN3l4Q030204
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:07:43 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61jbxxkq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:07:43 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 19:07:42 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 19:07:37 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TN7bjh54132792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 23:07:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA5A5B2066;
        Wed, 29 Aug 2018 19:06:32 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B243FB2065;
        Wed, 29 Aug 2018 19:06:32 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 19:06:32 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3456C16C91C9; Wed, 29 Aug 2018 16:07:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 05/10] rcu: Switch lazy counts to rcu_data structure
Date:   Wed, 29 Aug 2018 16:07:30 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829230715.GA9431@linux.vnet.ibm.com>
References: <20180829230715.GA9431@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082923-0068-0000-0000-00000331BB63
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080754; UDB=6.00557503; IPR=6.00860739;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 23:07:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082923-0069-0000-0000-0000458F24E5
Message-Id: <20180829230735.10256-5-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes ->all_lazy, ->nonlazy_posted and ->nonlazy_posted_snap
from the rcu_dynticks structure and updates the code to access them from
the rcu_data structure.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.h        |  7 -------
 kernel/rcu/tree_plugin.h | 23 ++++++++++-------------
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 69bd6bec05bb..36a47c7bd882 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -43,13 +43,6 @@ struct rcu_dynticks {
 	atomic_t dynticks;	    /* Even value for idle, else odd. */
 	bool rcu_need_heavy_qs;     /* GP old, need heavy quiescent state. */
 	bool rcu_urgent_qs;	    /* GP old need light quiescent state. */
-#ifdef CONFIG_RCU_FAST_NO_HZ
-	bool all_lazy;		    /* Are all CPU's CBs lazy? */
-	unsigned long nonlazy_posted;
-				    /* # times non-lazy CBs posted to CPU. */
-	unsigned long nonlazy_posted_snap;
-				    /* idle-period nonlazy_posted snapshot. */
-#endif /* #ifdef CONFIG_RCU_FAST_NO_HZ */
 };
 
 /* Communicate arguments to a workqueue handler. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 45708164ddf9..b5aeb2fe4cfe 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1634,16 +1634,15 @@ static bool __maybe_unused rcu_try_advance_all_cbs(void)
 int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 	unsigned long dj;
 
 	lockdep_assert_irqs_disabled();
 
 	/* Snapshot to detect later posting of non-lazy callback. */
-	rdtp->nonlazy_posted_snap = rdtp->nonlazy_posted;
+	rdp->nonlazy_posted_snap = rdp->nonlazy_posted;
 
 	/* If no callbacks, RCU doesn't need the CPU. */
-	if (!rcu_cpu_has_callbacks(&rdtp->all_lazy)) {
+	if (!rcu_cpu_has_callbacks(&rdp->all_lazy)) {
 		*nextevt = KTIME_MAX;
 		return 0;
 	}
@@ -1657,7 +1656,7 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 	rdp->last_accelerate = jiffies;
 
 	/* Request timer delay depending on laziness, and round. */
-	if (!rdtp->all_lazy) {
+	if (!rdp->all_lazy) {
 		dj = round_up(rcu_idle_gp_delay + jiffies,
 			       rcu_idle_gp_delay) - jiffies;
 	} else {
@@ -1681,7 +1680,6 @@ static void rcu_prepare_for_idle(void)
 {
 	bool needwake;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 	struct rcu_node *rnp;
 	int tne;
 
@@ -1705,10 +1703,10 @@ static void rcu_prepare_for_idle(void)
 	 * callbacks, invoke RCU core for the side-effect of recalculating
 	 * idle duration on re-entry to idle.
 	 */
-	if (rdtp->all_lazy &&
-	    rdtp->nonlazy_posted != rdtp->nonlazy_posted_snap) {
-		rdtp->all_lazy = false;
-		rdtp->nonlazy_posted_snap = rdtp->nonlazy_posted;
+	if (rdp->all_lazy &&
+	    rdp->nonlazy_posted != rdp->nonlazy_posted_snap) {
+		rdp->all_lazy = false;
+		rdp->nonlazy_posted_snap = rdp->nonlazy_posted;
 		invoke_rcu_core();
 		return;
 	}
@@ -1754,7 +1752,7 @@ static void rcu_cleanup_after_idle(void)
  */
 static void rcu_idle_count_callbacks_posted(void)
 {
-	__this_cpu_add(rcu_dynticks.nonlazy_posted, 1);
+	__this_cpu_add(rcu_data.nonlazy_posted, 1);
 }
 
 #endif /* #else #if !defined(CONFIG_RCU_FAST_NO_HZ) */
@@ -1764,13 +1762,12 @@ static void rcu_idle_count_callbacks_posted(void)
 static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
 {
 	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-	struct rcu_dynticks *rdtp = &per_cpu(rcu_dynticks, cpu);
-	unsigned long nlpd = rdtp->nonlazy_posted - rdtp->nonlazy_posted_snap;
+	unsigned long nlpd = rdp->nonlazy_posted - rdp->nonlazy_posted_snap;
 
 	sprintf(cp, "last_accelerate: %04lx/%04lx, nonlazy_posted: %ld, %c%c",
 		rdp->last_accelerate & 0xffff, jiffies & 0xffff,
 		ulong2long(nlpd),
-		rdtp->all_lazy ? 'L' : '.',
+		rdp->all_lazy ? 'L' : '.',
 		rdp->tick_nohz_enabled_snap ? '.' : 'D');
 }
 
-- 
2.17.1

