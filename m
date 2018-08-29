Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F778C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7D0420647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7D0420647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbeH3Clb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:41:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51956 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727546AbeH3CiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:07 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMckiw118373
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:03 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m60r189wf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:03 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:02 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcuCN47513844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49842B2078;
        Wed, 29 Aug 2018 18:37:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29A6AB2067;
        Wed, 29 Aug 2018 18:37:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3C1DE16C91C6; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 24/52] rcu: Remove rsp parameter from CPU hotplug functions
Date:   Wed, 29 Aug 2018 15:38:26 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0072-0000-0000-0000039968A3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557498; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0073-0000-0000-0000493EB370
Message-Id: <20180829223854.4055-24-paulmck@linux.vnet.ibm.com>
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

There now is only one rcu_state structure in a given build of the
Linux kernel, so there is no need to pass it as a parameter to RCU's
functions.  This commit therefore removes the rsp parameter from
rcu_cleanup_dying_cpu() and rcu_cleanup_dead_cpu().  And, as long as
we are in the neighborhood, inlines them into rcutree_dying_cpu() and
rcutree_dead_cpu(), respectively.  This also eliminates a pair of
for_each_rcu_flavor() loops.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 43 +++++++++++--------------------------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c7e58f6ac666..c38c9dcb98fe 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2401,20 +2401,22 @@ rcu_check_quiescent_state(struct rcu_data *rdp)
 }
 
 /*
- * Trace the fact that this CPU is going offline.
+ * Near the end of the offline process.  Trace the fact that this CPU
+ * is going offline.
  */
-static void rcu_cleanup_dying_cpu(struct rcu_state *rsp)
+int rcutree_dying_cpu(unsigned int cpu)
 {
 	RCU_TRACE(bool blkd;)
 	RCU_TRACE(struct rcu_data *rdp = this_cpu_ptr(&rcu_data);)
 	RCU_TRACE(struct rcu_node *rnp = rdp->mynode;)
 
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
-		return;
+		return 0;
 
 	RCU_TRACE(blkd = !!(rnp->qsmask & rdp->grpmask);)
-	trace_rcu_grace_period(rsp->name, rnp->gp_seq,
+	trace_rcu_grace_period(rcu_state.name, rnp->gp_seq,
 			       blkd ? TPS("cpuofl") : TPS("cpuofl-bgp"));
+	return 0;
 }
 
 /*
@@ -2468,16 +2470,19 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
  * There can only be one CPU hotplug operation at a time, so no need for
  * explicit locking.
  */
-static void rcu_cleanup_dead_cpu(int cpu, struct rcu_state *rsp)
+int rcutree_dead_cpu(unsigned int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
 
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
-		return;
+		return 0;
 
 	/* Adjust any no-longer-needed kthreads. */
 	rcu_boost_kthread_setaffinity(rnp, -1);
+	/* Do any needed no-CB deferred wakeups from this CPU. */
+	do_nocb_deferred_wakeup(per_cpu_ptr(&rcu_data, cpu));
+	return 0;
 }
 
 /*
@@ -3513,32 +3518,6 @@ int rcutree_offline_cpu(unsigned int cpu)
 	return 0;
 }
 
-/*
- * Near the end of the offline process.  We do only tracing here.
- */
-int rcutree_dying_cpu(unsigned int cpu)
-{
-	struct rcu_state *rsp;
-
-	for_each_rcu_flavor(rsp)
-		rcu_cleanup_dying_cpu(rsp);
-	return 0;
-}
-
-/*
- * The outgoing CPU is gone and we are running elsewhere.
- */
-int rcutree_dead_cpu(unsigned int cpu)
-{
-	struct rcu_state *rsp;
-
-	for_each_rcu_flavor(rsp) {
-		rcu_cleanup_dead_cpu(cpu, rsp);
-		do_nocb_deferred_wakeup(per_cpu_ptr(&rcu_data, cpu));
-	}
-	return 0;
-}
-
 static DEFINE_PER_CPU(int, rcu_cpu_started);
 
 /*
-- 
2.17.1

