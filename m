Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21F9C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8FA2623A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 22:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8FA2623A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934763AbeFYWpV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 18:45:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934277AbeFYWlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 18:41:35 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PMRJ2V133181
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:41:35 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96trcpy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 18:41:35 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 18:41:34 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 18:41:29 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PMfSf83801458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 22:41:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A25C9B2066;
        Mon, 25 Jun 2018 18:41:23 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82497B2064;
        Mon, 25 Jun 2018 18:41:23 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 18:41:23 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CD01816CA093; Mon, 25 Jun 2018 15:43:33 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 1/2] rcu: Make expedited grace period use direct call on last leaf
Date:   Mon, 25 Jun 2018 15:43:31 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625224308.GA10064@linux.vnet.ibm.com>
References: <20180625224308.GA10064@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062522-2213-0000-0000-000002BFD800
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052299; UDB=6.00539447; IPR=6.00830224;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 22:41:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062522-2214-0000-0000-00005A9B68D5
Message-Id: <20180625224332.10596-1-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250253
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During expedited grace-period initialization, a work item is scheduled
for each leaf rcu_node structure.  However, that initialization code
is itself (normally) executing from a workqueue, so one of the leaf
rcu_node structures could just as well be handled by that pre-existing
workqueue, and with less overhead.  This commit therefore uses a
shiny new rcu_is_leaf_node() macro to execute the last leaf rcu_node
structure's initialization directly from the pre-existing workqueue.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcu.h      | 3 +++
 kernel/rcu/tree_exp.h | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 40cea6735c2d..db0870acfdff 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -276,6 +276,9 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
 /* Is this rcu_node a leaf? */
 #define rcu_is_leaf_node(rnp) ((rnp)->level == rcu_num_lvls - 1)
 
+/* Is this rcu_node the last leaf? */
+#define rcu_is_last_leaf_node(rsp, rnp) ((rnp) == &(rsp)->node[rcu_num_nodes - 1])
+
 /*
  * Do a full breadth-first scan of the rcu_node structures for the
  * specified rcu_state structure.
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index d40708e8c5d6..c6385ee1af65 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -486,8 +486,9 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 		rnp->rew.rew_func = func;
 		rnp->rew.rew_rsp = rsp;
 		if (!READ_ONCE(rcu_par_gp_wq) ||
-		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING) {
-			/* No workqueues yet. */
+		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
+		    rcu_is_last_leaf_node(rsp, rnp)) {
+			/* No workqueues yet or last leaf, do direct call. */
 			sync_rcu_exp_select_node_cpus(&rnp->rew.rew_work);
 			continue;
 		}
-- 
2.17.1

