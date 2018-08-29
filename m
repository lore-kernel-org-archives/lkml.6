Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6A1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EB020647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EB020647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbeH3Cjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:39:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727674AbeH3CiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:08 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMchPP062053
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:05 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61x8d8a6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:04 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:03 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcwqp25493700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80D83B2066;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 502CBB206C;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D6EEE16C9CCB; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 51/52] rcu: Eliminate initialization-time use of rsp
Date:   Wed, 29 Aug 2018 15:38:53 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0040-0000-0000-000004675844
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557497; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0041-0000-0000-0000086E7220
Message-Id: <20180829223854.4055-51-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=816 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is only one rcu_state structure, there is less point in
maintaining a pointer to it.  This commit therefore replaces rsp with
&rcu_state in rcu_cpu_starting() and rcu_init_one().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e573fb9f0ef8..9c82981d7822 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3454,7 +3454,6 @@ void rcu_cpu_starting(unsigned int cpu)
 	unsigned long oldmask;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
-	struct rcu_state *rsp = &rcu_state;
 
 	if (per_cpu(rcu_cpu_started, cpu))
 		return;
@@ -3471,10 +3470,10 @@ void rcu_cpu_starting(unsigned int cpu)
 	oldmask ^= rnp->expmaskinitnext;
 	nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
 	/* Allow lockless access for expedited grace periods. */
-	smp_store_release(&rsp->ncpus, rsp->ncpus + nbits); /* ^^^ */
+	smp_store_release(&rcu_state.ncpus, rcu_state.ncpus + nbits); /* ^^^ */
 	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
-	rdp->rcu_onl_gp_seq = READ_ONCE(rsp->gp_seq);
-	rdp->rcu_onl_gp_flags = READ_ONCE(rsp->gp_flags);
+	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
+	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
 	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
 		/* Report QS -after- changing ->qsmaskinitnext! */
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
@@ -3666,7 +3665,6 @@ static void __init rcu_init_one(void)
 	int i;
 	int j;
 	struct rcu_node *rnp;
-	struct rcu_state *rsp = &rcu_state;
 
 	BUILD_BUG_ON(RCU_NUM_LVLS > ARRAY_SIZE(buf));  /* Fix buf[] init! */
 
@@ -3677,14 +3675,15 @@ static void __init rcu_init_one(void)
 	/* Initialize the level-tracking arrays. */
 
 	for (i = 1; i < rcu_num_lvls; i++)
-		rsp->level[i] = rsp->level[i - 1] + num_rcu_lvl[i - 1];
+		rcu_state.level[i] =
+			rcu_state.level[i - 1] + num_rcu_lvl[i - 1];
 	rcu_init_levelspread(levelspread, num_rcu_lvl);
 
 	/* Initialize the elements themselves, starting from the leaves. */
 
 	for (i = rcu_num_lvls - 1; i >= 0; i--) {
 		cpustride *= levelspread[i];
-		rnp = rsp->level[i];
+		rnp = rcu_state.level[i];
 		for (j = 0; j < num_rcu_lvl[i]; j++, rnp++) {
 			raw_spin_lock_init(&ACCESS_PRIVATE(rnp, lock));
 			lockdep_set_class_and_name(&ACCESS_PRIVATE(rnp, lock),
@@ -3692,9 +3691,9 @@ static void __init rcu_init_one(void)
 			raw_spin_lock_init(&rnp->fqslock);
 			lockdep_set_class_and_name(&rnp->fqslock,
 						   &rcu_fqs_class[i], fqs[i]);
-			rnp->gp_seq = rsp->gp_seq;
-			rnp->gp_seq_needed = rsp->gp_seq;
-			rnp->completedqs = rsp->gp_seq;
+			rnp->gp_seq = rcu_state.gp_seq;
+			rnp->gp_seq_needed = rcu_state.gp_seq;
+			rnp->completedqs = rcu_state.gp_seq;
 			rnp->qsmask = 0;
 			rnp->qsmaskinit = 0;
 			rnp->grplo = j * cpustride;
@@ -3708,7 +3707,7 @@ static void __init rcu_init_one(void)
 			} else {
 				rnp->grpnum = j % levelspread[i - 1];
 				rnp->grpmask = 1UL << rnp->grpnum;
-				rnp->parent = rsp->level[i - 1] +
+				rnp->parent = rcu_state.level[i - 1] +
 					      j / levelspread[i - 1];
 			}
 			rnp->level = i;
@@ -3722,8 +3721,8 @@ static void __init rcu_init_one(void)
 		}
 	}
 
-	init_swait_queue_head(&rsp->gp_wq);
-	init_swait_queue_head(&rsp->expedited_wq);
+	init_swait_queue_head(&rcu_state.gp_wq);
+	init_swait_queue_head(&rcu_state.expedited_wq);
 	rnp = rcu_first_leaf_node();
 	for_each_possible_cpu(i) {
 		while (i > rnp->grphi)
-- 
2.17.1

