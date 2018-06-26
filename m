Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7192AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344432633B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344432633B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935133AbeFZAQU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:16:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934217AbeFZAHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:02 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q04X9X181873
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:01 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju96qjk3m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:01 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:00 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06uCK5243196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BAABDB2066;
        Mon, 25 Jun 2018 20:06:50 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FC16B2071;
        Mon, 25 Jun 2018 20:06:50 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:50 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0A3FA16CA097; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 05/40] rcu: Make quiescent-state reporting use ->gp_seq
Date:   Mon, 25 Jun 2018 17:08:24 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0060-0000-0000-00000282665B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052328; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0061-0000-0000-0000459336AC
Message-Id: <20180626000859.23572-5-paulmck@linux.vnet.ibm.com>
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

This commit switches the functions reporting quiescent states from
use of ->gpnum to ->gp_seq.  In either case, the point is to handle
races where a given grace period ends before a quiescent state can
be reported.  Failing to catch these races would result in too-short
grace periods, hence the checking.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b9e69bbbecf5..001596f05111 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2242,7 +2242,7 @@ static void rcu_report_qs_rsp(struct rcu_state *rsp, unsigned long flags)
  * must be represented by the same rcu_node structure (which need not be a
  * leaf rcu_node structure, though it often will be).  The gps parameter
  * is the grace-period snapshot, which means that the quiescent states
- * are valid only if rnp->gpnum is equal to gps.  That structure's lock
+ * are valid only if rnp->gp_seq is equal to gps.  That structure's lock
  * must be held upon entry, and it is released before return.
  */
 static void
@@ -2257,7 +2257,7 @@ rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
 
 	/* Walk up the rcu_node hierarchy. */
 	for (;;) {
-		if (!(rnp->qsmask & mask) || rnp->gpnum != gps) {
+		if (!(rnp->qsmask & mask) || rnp->gp_seq != gps) {
 
 			/*
 			 * Our bit has already been cleared, or the
@@ -2335,8 +2335,8 @@ static void rcu_report_unblock_qs_rnp(struct rcu_state *rsp,
 		return;
 	}
 
-	/* Report up the rest of the hierarchy, tracking current ->gpnum. */
-	gps = rnp->gpnum;
+	/* Report up the rest of the hierarchy, tracking current ->gp_seq. */
+	gps = rnp->gp_seq;
 	mask = rnp->grpmask;
 	raw_spin_unlock_rcu_node(rnp);	/* irqs remain disabled. */
 	raw_spin_lock_rcu_node(rnp_p);	/* irqs already disabled. */
@@ -2357,8 +2357,8 @@ rcu_report_qs_rdp(int cpu, struct rcu_state *rsp, struct rcu_data *rdp)
 
 	rnp = rdp->mynode;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	if (rdp->cpu_no_qs.b.norm || rdp->gpnum != rnp->gpnum ||
-	    rnp->completed == rnp->gpnum || rdp->gpwrap) {
+	if (rdp->cpu_no_qs.b.norm || rdp->gp_seq != rnp->gp_seq ||
+	    rdp->gpwrap) {
 
 		/*
 		 * The grace period in which this quiescent state was
@@ -2383,7 +2383,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_state *rsp, struct rcu_data *rdp)
 		 */
 		needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
 
-		rcu_report_qs_rnp(mask, rsp, rnp, rnp->gpnum, flags);
+		rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
 		if (needwake)
 			rcu_gp_kthread_wake(rsp);
@@ -2688,8 +2688,8 @@ static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *rsp))
 			}
 		}
 		if (mask != 0) {
-			/* Idle/offline CPUs, report (releases rnp->lock. */
-			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gpnum, flags);
+			/* Idle/offline CPUs, report (releases rnp->lock). */
+			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
 		} else {
 			/* Nothing to do here, so just drop the lock. */
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-- 
2.17.1

