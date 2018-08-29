Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12C2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4772064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4772064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeH3DGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:06:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727496AbeH3DGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:06:55 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TN3p7o101821
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:07:43 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m62u3kx1t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:07:42 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 19:07:42 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 19:07:37 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TN7bt526935534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 23:07:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7374B2064;
        Wed, 29 Aug 2018 19:06:32 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5758B2068;
        Wed, 29 Aug 2018 19:06:32 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 19:06:32 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2FF9816C91C7; Wed, 29 Aug 2018 16:07:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 04/10] rcu: Switch last accelerate/advance to rcu_data structure
Date:   Wed, 29 Aug 2018 16:07:29 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829230715.GA9431@linux.vnet.ibm.com>
References: <20180829230715.GA9431@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082923-0052-0000-0000-00000328229F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080754; UDB=6.00557503; IPR=6.00860739;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 23:07:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082923-0053-0000-0000-00005DE6090B
Message-Id: <20180829230735.10256-4-paulmck@linux.vnet.ibm.com>
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

This commit removes ->last_accelerate and ->last_advance_all from the
rcu_dynticks structure and updates the code to access them from the
rcu_data structure.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.h        |  4 ----
 kernel/rcu/tree_plugin.h | 17 ++++++++---------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 5d447ceba769..69bd6bec05bb 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -49,10 +49,6 @@ struct rcu_dynticks {
 				    /* # times non-lazy CBs posted to CPU. */
 	unsigned long nonlazy_posted_snap;
 				    /* idle-period nonlazy_posted snapshot. */
-	unsigned long last_accelerate;
-				    /* Last jiffy CBs were accelerated. */
-	unsigned long last_advance_all;
-				    /* Last jiffy CBs were all advanced. */
 #endif /* #ifdef CONFIG_RCU_FAST_NO_HZ */
 };
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 6511032371c1..45708164ddf9 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1597,16 +1597,14 @@ module_param(rcu_idle_lazy_gp_delay, int, 0644);
 static bool __maybe_unused rcu_try_advance_all_cbs(void)
 {
 	bool cbs_ready = false;
-	struct rcu_data *rdp;
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp;
 
 	/* Exit early if we advanced recently. */
-	if (jiffies == rdtp->last_advance_all)
+	if (jiffies == rdp->last_advance_all)
 		return false;
-	rdtp->last_advance_all = jiffies;
+	rdp->last_advance_all = jiffies;
 
-	rdp = this_cpu_ptr(&rcu_data);
 	rnp = rdp->mynode;
 
 	/*
@@ -1635,6 +1633,7 @@ static bool __maybe_unused rcu_try_advance_all_cbs(void)
  */
 int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 {
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 	unsigned long dj;
 
@@ -1655,7 +1654,7 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 		invoke_rcu_core();
 		return 1;
 	}
-	rdtp->last_accelerate = jiffies;
+	rdp->last_accelerate = jiffies;
 
 	/* Request timer delay depending on laziness, and round. */
 	if (!rdtp->all_lazy) {
@@ -1718,9 +1717,9 @@ static void rcu_prepare_for_idle(void)
 	 * If we have not yet accelerated this jiffy, accelerate all
 	 * callbacks on this CPU.
 	 */
-	if (rdtp->last_accelerate == jiffies)
+	if (rdp->last_accelerate == jiffies)
 		return;
-	rdtp->last_accelerate = jiffies;
+	rdp->last_accelerate = jiffies;
 	if (rcu_segcblist_pend_cbs(&rdp->cblist)) {
 		rnp = rdp->mynode;
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
@@ -1769,7 +1768,7 @@ static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
 	unsigned long nlpd = rdtp->nonlazy_posted - rdtp->nonlazy_posted_snap;
 
 	sprintf(cp, "last_accelerate: %04lx/%04lx, nonlazy_posted: %ld, %c%c",
-		rdtp->last_accelerate & 0xffff, jiffies & 0xffff,
+		rdp->last_accelerate & 0xffff, jiffies & 0xffff,
 		ulong2long(nlpd),
 		rdtp->all_lazy ? 'L' : '.',
 		rdp->tick_nohz_enabled_snap ? '.' : 'D');
-- 
2.17.1

