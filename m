Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2CDC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE3920644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EE3920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbeH3CiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:38:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727476AbeH3CiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMcjhZ093144
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:02 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m64a288k1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:02 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:01 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcuaK46530656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4017EB2073;
        Wed, 29 Aug 2018 18:37:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F8E9B2064;
        Wed, 29 Aug 2018 18:37:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1B76B16C91D8; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 17/52] rcu: Remove rsp parameter from rcu_accelerate_cbs_unlocked()
Date:   Wed, 29 Aug 2018 15:38:19 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0040-0000-0000-00000467583D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557497; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0041-0000-0000-0000086E7219
Message-Id: <20180829223854.4055-17-paulmck@linux.vnet.ibm.com>
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
rcu_accelerate_cbs_unlocked().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2c1d457e8cc2..442adb8eedc1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1703,15 +1703,14 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
  * that a new grace-period request be made, invokes rcu_accelerate_cbs()
  * while holding the leaf rcu_node structure's ->lock.
  */
-static void rcu_accelerate_cbs_unlocked(struct rcu_state *rsp,
-					struct rcu_node *rnp,
+static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
 					struct rcu_data *rdp)
 {
 	unsigned long c;
 	bool needwake;
 
 	lockdep_assert_irqs_disabled();
-	c = rcu_seq_snap(&rsp->gp_seq);
+	c = rcu_seq_snap(&rcu_state.gp_seq);
 	if (!rdp->gpwrap && ULONG_CMP_GE(rdp->gp_seq_needed, c)) {
 		/* Old request still live, so mark recent callbacks. */
 		(void)rcu_segcblist_accelerate(&rdp->cblist, c);
@@ -2758,7 +2757,7 @@ __rcu_process_callbacks(struct rcu_state *rsp)
 	    rcu_segcblist_is_enabled(&rdp->cblist)) {
 		local_irq_save(flags);
 		if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
-			rcu_accelerate_cbs_unlocked(rsp, rnp, rdp);
+			rcu_accelerate_cbs_unlocked(rnp, rdp);
 		local_irq_restore(flags);
 	}
 
@@ -2845,7 +2844,7 @@ static void __call_rcu_core(struct rcu_state *rsp, struct rcu_data *rdp,
 
 		/* Start a new grace period if one not already started. */
 		if (!rcu_gp_in_progress()) {
-			rcu_accelerate_cbs_unlocked(rsp, rdp->mynode, rdp);
+			rcu_accelerate_cbs_unlocked(rdp->mynode, rdp);
 		} else {
 			/* Give the grace period a kick. */
 			rdp->blimit = LONG_MAX;
-- 
2.17.1

