Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 237AEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD0220658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD0220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeH3CiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:38:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49320 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727480AbeH3CiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:07 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMcjg8093149
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:04 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m64a288mb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:03 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:02 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcvuV28049586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21198B2075;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D10CB2070;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5DF9F16C025C; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 30/52] rcu: Remove rsp parameter from __rcu_pending()
Date:   Wed, 29 Aug 2018 15:38:32 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0068-0000-0000-00000331B954
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557497; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0069-0000-0000-0000458F1616
Message-Id: <20180829223854.4055-30-paulmck@linux.vnet.ibm.com>
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

There now is only one rcu_state structure in a given build of the Linux
kernel, so there is no need to pass it as a parameter to RCU's functions.
This commit therefore removes the rsp parameter from __rcu_pending(),
and also inlines it into rcu_pending(), removing the for_each_rcu_flavor()
while in the neighborhood..

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4af227e826a6..e347a6b2984c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2996,8 +2996,7 @@ EXPORT_SYMBOL_GPL(call_rcu_sched);
  * callbacks in the list of pending callbacks. Until then, this
  * function may only be called from __kfree_rcu().
  */
-void kfree_call_rcu(struct rcu_head *head,
-		    rcu_callback_t func)
+void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	__call_rcu(head, func, -1, 1);
 }
@@ -3079,21 +3078,23 @@ void cond_synchronize_sched(unsigned long oldstate)
 EXPORT_SYMBOL_GPL(cond_synchronize_sched);
 
 /*
- * Check to see if there is any immediate RCU-related work to be done
- * by the current CPU, for the specified type of RCU, returning 1 if so.
- * The checks are in order of increasing expense: checks that can be
- * carried out against CPU-local state are performed first.  However,
- * we must check for CPU stalls first, else we might not get a chance.
+ * Check to see if there is any immediate RCU-related work to be done by
+ * the current CPU, for the specified type of RCU, returning 1 if so and
+ * zero otherwise.  The checks are in order of increasing expense: checks
+ * that can be carried out against CPU-local state are performed first.
+ * However, we must check for CPU stalls first, else we might not get
+ * a chance.
  */
-static int __rcu_pending(struct rcu_state *rsp, struct rcu_data *rdp)
+static int rcu_pending(void)
 {
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 
 	/* Check for CPU stalls, if enabled. */
 	check_cpu_stall(rdp);
 
 	/* Is this CPU a NO_HZ_FULL CPU that should ignore RCU? */
-	if (rcu_nohz_full_cpu(rsp))
+	if (rcu_nohz_full_cpu(&rcu_state))
 		return 0;
 
 	/* Is the RCU core waiting for a quiescent state from this CPU? */
@@ -3123,21 +3124,6 @@ static int __rcu_pending(struct rcu_state *rsp, struct rcu_data *rdp)
 	return 0;
 }
 
-/*
- * Check to see if there is any immediate RCU-related work to be done
- * by the current CPU, returning 1 if so.  This function is part of the
- * RCU implementation; it is -not- an exported member of the RCU API.
- */
-static int rcu_pending(void)
-{
-	struct rcu_state *rsp;
-
-	for_each_rcu_flavor(rsp)
-		if (__rcu_pending(rsp, this_cpu_ptr(&rcu_data)))
-			return 1;
-	return 0;
-}
-
 /*
  * Return true if the specified CPU has any callback.  If all_lazy is
  * non-NULL, store an indication of whether all callbacks are lazy.
-- 
2.17.1

