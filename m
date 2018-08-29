Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440CCC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE9420647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE9420647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeH3CxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:53:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727574AbeH3CxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:53:23 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMs37D013538
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:14 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m629dvpum-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:14 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:54:13 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:54:08 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMs7mV1180040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:54:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 195B4B2064;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBEE1B206A;
        Wed, 29 Aug 2018 18:53:02 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:53:02 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 636C516C91C9; Wed, 29 Aug 2018 15:54:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 05/24] rcutorture: Add RCU-bh and RCU-sched support for extended readers
Date:   Wed, 29 Aug 2018 15:53:46 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829225340.GA7019@linux.vnet.ibm.com>
References: <20180829225340.GA7019@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0072-0000-0000-0000039969A7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080749; UDB=6.00557500; IPR=6.00860734;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:54:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0073-0000-0000-0000493EB97D
Message-Id: <20180829225405.7275-5-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is now a single consolidated RCU flavor, rcutorture
needs to test extending of RCU readers via rcu_read_lock_bh() and
rcu_read_lock_sched().  This commit adds this support, with added checks
(just like for local_bh_enable()) to ensure that rcu_read_unlock_bh()
will not be invoked while interrupts are disabled.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcutorture.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index c55d1483886e..1bc0e37dffa8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -66,13 +66,16 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@us.ibm.com> and Josh Triplett <josh@jos
 /* Bits for ->extendables field, extendables param, and related definitions. */
 #define RCUTORTURE_RDR_SHIFT	 8	/* Put SRCU index in upper bits. */
 #define RCUTORTURE_RDR_MASK	 ((1 << RCUTORTURE_RDR_SHIFT) - 1)
-#define RCUTORTURE_RDR_BH	 0x1	/* Extend readers by disabling bh. */
-#define RCUTORTURE_RDR_IRQ	 0x2	/*  ... disabling interrupts. */
-#define RCUTORTURE_RDR_PREEMPT	 0x4	/*  ... disabling preemption. */
-#define RCUTORTURE_RDR_RCU	 0x8	/*  ... entering another RCU reader. */
-#define RCUTORTURE_RDR_NBITS	 4	/* Number of bits defined above. */
-#define RCUTORTURE_MAX_EXTEND	 (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_IRQ | \
-				  RCUTORTURE_RDR_PREEMPT)
+#define RCUTORTURE_RDR_BH	 0x01	/* Extend readers by disabling bh. */
+#define RCUTORTURE_RDR_IRQ	 0x02	/*  ... disabling interrupts. */
+#define RCUTORTURE_RDR_PREEMPT	 0x04	/*  ... disabling preemption. */
+#define RCUTORTURE_RDR_RBH	 0x08	/*  ... rcu_read_lock_bh(). */
+#define RCUTORTURE_RDR_SCHED	 0x10	/*  ... rcu_read_lock_sched(). */
+#define RCUTORTURE_RDR_RCU	 0x20	/*  ... entering another RCU reader. */
+#define RCUTORTURE_RDR_NBITS	 6	/* Number of bits defined above. */
+#define RCUTORTURE_MAX_EXTEND	 \
+	(RCUTORTURE_RDR_BH | RCUTORTURE_RDR_IRQ | RCUTORTURE_RDR_PREEMPT | \
+	 RCUTORTURE_RDR_RBH | RCUTORTURE_RDR_SCHED)
 #define RCUTORTURE_RDR_MAX_LOOPS 0x7	/* Maximum reader extensions. */
 					/* Must be power of two minus one. */
 
@@ -1217,6 +1220,10 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 		local_irq_disable();
 	if (statesnew & RCUTORTURE_RDR_PREEMPT)
 		preempt_disable();
+	if (statesnew & RCUTORTURE_RDR_RBH)
+		rcu_read_lock_bh();
+	if (statesnew & RCUTORTURE_RDR_SCHED)
+		rcu_read_lock_sched();
 	if (statesnew & RCUTORTURE_RDR_RCU)
 		idxnew = cur_ops->readlock() << RCUTORTURE_RDR_SHIFT;
 
@@ -1227,6 +1234,10 @@ static void rcutorture_one_extend(int *readstate, int newstate,
 		local_bh_enable();
 	if (statesold & RCUTORTURE_RDR_PREEMPT)
 		preempt_enable();
+	if (statesold & RCUTORTURE_RDR_RBH)
+		rcu_read_unlock_bh();
+	if (statesold & RCUTORTURE_RDR_SCHED)
+		rcu_read_unlock_sched();
 	if (statesold & RCUTORTURE_RDR_RCU)
 		cur_ops->readunlock(idxold >> RCUTORTURE_RDR_SHIFT);
 
@@ -1269,10 +1280,11 @@ rcutorture_extend_mask(int oldmask, struct torture_random_state *trsp)
 		mask = mask & randmask2;
 	else
 		mask = mask & (1 << (randmask2 % RCUTORTURE_RDR_NBITS));
+	/* Can't enable bh w/irq disabled. */
 	if ((mask & RCUTORTURE_RDR_IRQ) &&
-	    !(mask & RCUTORTURE_RDR_BH) &&
-	    (oldmask & RCUTORTURE_RDR_BH))
-		mask |= RCUTORTURE_RDR_BH; /* Can't enable bh w/irq disabled. */
+	    ((!(mask & RCUTORTURE_RDR_BH) && (oldmask & RCUTORTURE_RDR_BH)) ||
+	     (!(mask & RCUTORTURE_RDR_RBH) && (oldmask & RCUTORTURE_RDR_RBH))))
+		mask |= RCUTORTURE_RDR_BH | RCUTORTURE_RDR_RBH;
 	if ((mask & RCUTORTURE_RDR_IRQ) &&
 	    !(mask & cur_ops->ext_irq_conflict) &&
 	    (oldmask & cur_ops->ext_irq_conflict))
-- 
2.17.1

