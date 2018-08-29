Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC040C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DAB20647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DAB20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeH3CxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:53:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44482 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727599AbeH3CxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:53:23 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMs27r047561
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:15 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m64f00chy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:15 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:54:12 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:54:08 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMs7Gq1180042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:54:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D3D9B2072;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B584B2068;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6CF7316C91CB; Wed, 29 Aug 2018 15:54:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 07/24] rcutorture: Remove the "rcu_bh" and "sched" torture types
Date:   Wed, 29 Aug 2018 15:53:48 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829225340.GA7019@linux.vnet.ibm.com>
References: <20180829225340.GA7019@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0068-0000-0000-00000331BA5B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080749; UDB=6.00557500; IPR=6.00860734;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:54:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0069-0000-0000-0000458F1C57
Message-Id: <20180829225405.7275-7-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the RCU-bh and RCU-sched update-side functions are simple
wrappers around their RCU counterparts, there isn't a whole lot of point
in testing them.  This commit therefore removes the "rcu_bh" and "sched"
torture types from rcutorture.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcutorture.c | 89 ++---------------------------------------
 1 file changed, 3 insertions(+), 86 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1bc0e37dffa8..a228ad762fba 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -128,7 +128,7 @@ torture_param(int, verbose, 1,
 
 static char *torture_type = "rcu";
 module_param(torture_type, charp, 0444);
-MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, rcu_bh, ...)");
+MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
 
 static int nrealreaders;
 static int ncbflooders;
@@ -438,47 +438,6 @@ static struct rcu_torture_ops rcu_ops = {
 	.name		= "rcu"
 };
 
-/*
- * Definitions for rcu_bh torture testing.
- */
-
-static int rcu_bh_torture_read_lock(void) __acquires(RCU_BH)
-{
-	rcu_read_lock_bh();
-	return 0;
-}
-
-static void rcu_bh_torture_read_unlock(int idx) __releases(RCU_BH)
-{
-	rcu_read_unlock_bh();
-}
-
-static void rcu_bh_torture_deferred_free(struct rcu_torture *p)
-{
-	call_rcu_bh(&p->rtort_rcu, rcu_torture_cb);
-}
-
-static struct rcu_torture_ops rcu_bh_ops = {
-	.ttype		= RCU_BH_FLAVOR,
-	.init		= rcu_sync_torture_init,
-	.readlock	= rcu_bh_torture_read_lock,
-	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
-	.readunlock	= rcu_bh_torture_read_unlock,
-	.get_gp_seq	= rcu_bh_get_gp_seq,
-	.gp_diff	= rcu_seq_diff,
-	.deferred_free	= rcu_bh_torture_deferred_free,
-	.sync		= synchronize_rcu_bh,
-	.exp_sync	= synchronize_rcu_bh_expedited,
-	.call		= call_rcu_bh,
-	.cb_barrier	= rcu_barrier_bh,
-	.fqs		= rcu_bh_force_quiescent_state,
-	.stats		= NULL,
-	.irq_capable	= 1,
-	.extendables	= (RCUTORTURE_RDR_BH | RCUTORTURE_RDR_IRQ),
-	.ext_irq_conflict = RCUTORTURE_RDR_RCU,
-	.name		= "rcu_bh"
-};
-
 /*
  * Don't even think about trying any of these in real life!!!
  * The names includes "busted", and they really means it!
@@ -666,48 +625,6 @@ static struct rcu_torture_ops busted_srcud_ops = {
 	.name		= "busted_srcud"
 };
 
-/*
- * Definitions for sched torture testing.
- */
-
-static int sched_torture_read_lock(void)
-{
-	preempt_disable();
-	return 0;
-}
-
-static void sched_torture_read_unlock(int idx)
-{
-	preempt_enable();
-}
-
-static void rcu_sched_torture_deferred_free(struct rcu_torture *p)
-{
-	call_rcu_sched(&p->rtort_rcu, rcu_torture_cb);
-}
-
-static struct rcu_torture_ops sched_ops = {
-	.ttype		= RCU_SCHED_FLAVOR,
-	.init		= rcu_sync_torture_init,
-	.readlock	= sched_torture_read_lock,
-	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
-	.readunlock	= sched_torture_read_unlock,
-	.get_gp_seq	= rcu_sched_get_gp_seq,
-	.gp_diff	= rcu_seq_diff,
-	.deferred_free	= rcu_sched_torture_deferred_free,
-	.sync		= synchronize_sched,
-	.exp_sync	= synchronize_sched_expedited,
-	.get_state	= get_state_synchronize_sched,
-	.cond_sync	= cond_synchronize_sched,
-	.call		= call_rcu_sched,
-	.cb_barrier	= rcu_barrier_sched,
-	.fqs		= rcu_sched_force_quiescent_state,
-	.stats		= NULL,
-	.irq_capable	= 1,
-	.extendables	= RCUTORTURE_MAX_EXTEND,
-	.name		= "sched"
-};
-
 /*
  * Definitions for RCU-tasks torture testing.
  */
@@ -1956,8 +1873,8 @@ rcu_torture_init(void)
 	int cpu;
 	int firsterr = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
-		&rcu_ops, &rcu_bh_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops,
-		&busted_srcud_ops, &sched_ops, &tasks_ops,
+		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops,
+		&busted_srcud_ops, &tasks_ops,
 	};
 
 	if (!torture_init_begin(torture_type, verbose))
-- 
2.17.1

