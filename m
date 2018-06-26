Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 263A7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C7F26323
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C7F26323
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935131AbeFZANH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:13:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934264AbeFZAHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:03 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q04Umk181709
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:03 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju96qjk4g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:02 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:02 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06u0I1769886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 232BCB2065;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3F36B2064;
        Mon, 25 Jun 2018 20:06:50 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:50 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 10DF316CA098; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 06/40] rcu: Convert conditional grace-period primitives to ->gp_seq
Date:   Mon, 25 Jun 2018 17:08:25 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0052-0000-0000-00000303F3CE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052328; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0053-0000-0000-00005D23BCCA
Message-Id: <20180626000859.23572-6-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=990 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit converts get_state_synchronize_rcu(), cond_synchronize_rcu(),
get_state_synchronize_sched(), and cond_synchronize_sched() from ->gpnum
and ->completed to ->gp_seq.  Note that this also introduces a full
memory barrier in the already-done paths off cond_synchronize_rcu() and
cond_synchronize_sched(), as work with LKMM indicates that the earlier
smp_load_acquire() were insufficiently strong in some situations where
these two functions were called just as the grace period ended.  In such
cases, these two functions would not gain the benefit of memory ordering
at the end of the grace period.

Please note that the performance impact is negligible, as you shouldn't
be using either function anywhere near a fastpath in any case.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 42 ++++++++++--------------------------------
 1 file changed, 10 insertions(+), 32 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 001596f05111..1a3a7d402a20 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3180,16 +3180,10 @@ unsigned long get_state_synchronize_rcu(void)
 {
 	/*
 	 * Any prior manipulation of RCU-protected data must happen
-	 * before the load from ->gpnum.
+	 * before the load from ->gp_seq.
 	 */
 	smp_mb();  /* ^^^ */
-
-	/*
-	 * Make sure this load happens before the purportedly
-	 * time-consuming work between get_state_synchronize_rcu()
-	 * and cond_synchronize_rcu().
-	 */
-	return smp_load_acquire(&rcu_state_p->gpnum);
+	return rcu_seq_snap(&rcu_state_p->gp_seq);
 }
 EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
 
@@ -3209,15 +3203,10 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
  */
 void cond_synchronize_rcu(unsigned long oldstate)
 {
-	unsigned long newstate;
-
-	/*
-	 * Ensure that this load happens before any RCU-destructive
-	 * actions the caller might carry out after we return.
-	 */
-	newstate = smp_load_acquire(&rcu_state_p->completed);
-	if (ULONG_CMP_GE(oldstate, newstate))
+	if (!rcu_seq_done(&rcu_state_p->gp_seq, oldstate))
 		synchronize_rcu();
+	else
+		smp_mb(); /* Ensure GP ends before subsequent accesses. */
 }
 EXPORT_SYMBOL_GPL(cond_synchronize_rcu);
 
@@ -3232,16 +3221,10 @@ unsigned long get_state_synchronize_sched(void)
 {
 	/*
 	 * Any prior manipulation of RCU-protected data must happen
-	 * before the load from ->gpnum.
+	 * before the load from ->gp_seq.
 	 */
 	smp_mb();  /* ^^^ */
-
-	/*
-	 * Make sure this load happens before the purportedly
-	 * time-consuming work between get_state_synchronize_sched()
-	 * and cond_synchronize_sched().
-	 */
-	return smp_load_acquire(&rcu_sched_state.gpnum);
+	return rcu_seq_snap(&rcu_sched_state.gp_seq);
 }
 EXPORT_SYMBOL_GPL(get_state_synchronize_sched);
 
@@ -3261,15 +3244,10 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_sched);
  */
 void cond_synchronize_sched(unsigned long oldstate)
 {
-	unsigned long newstate;
-
-	/*
-	 * Ensure that this load happens before any RCU-destructive
-	 * actions the caller might carry out after we return.
-	 */
-	newstate = smp_load_acquire(&rcu_sched_state.completed);
-	if (ULONG_CMP_GE(oldstate, newstate))
+	if (!rcu_seq_done(&rcu_sched_state.gp_seq, oldstate))
 		synchronize_sched();
+	else
+		smp_mb(); /* Ensure GP ends before subsequent accesses. */
 }
 EXPORT_SYMBOL_GPL(cond_synchronize_sched);
 
-- 
2.17.1

