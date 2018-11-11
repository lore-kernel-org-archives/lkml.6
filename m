Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029AEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2197214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2197214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbeKLFVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:21:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726310AbeKLFVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:21:48 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJNuE1003536
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:32:23 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npdvs8c54-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:32:23 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:32:22 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:32:18 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJWHVo18481210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:32:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EFE0B2068;
        Sun, 11 Nov 2018 19:32:17 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B868B205F;
        Sun, 11 Nov 2018 19:32:17 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:32:17 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4C20116C5D59; Sun, 11 Nov 2018 11:32:18 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 1/4] rcu: Eliminate BUG_ON() for sync.c
Date:   Sun, 11 Nov 2018 11:32:14 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111193156.GA3666@linux.ibm.com>
References: <20181111193156.GA3666@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-0068-0000-0000-0000035E47A8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116015; UDB=6.00578730; IPR=6.00896115;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:32:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-0069-0000-0000-000046644886
Message-Id: <20181111193217.4010-1-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=808 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sync.c file has a number of calls to BUG_ON(), which panics the
kernel, which is not a good strategy for devices (like embedded) that
don't have a way to capture console output.  This commit therefore
changes these BUG_ON() calls to WARN_ON_ONCE(), but does so quite naively.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/rcu/sync.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index 3f943efcf61c..a6ba446a9693 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -125,8 +125,7 @@ void rcu_sync_enter(struct rcu_sync *rsp)
 		rsp->gp_state = GP_PENDING;
 	spin_unlock_irq(&rsp->rss_lock);
 
-	BUG_ON(need_wait && need_sync);
-
+	WARN_ON_ONCE(need_wait && need_sync);
 	if (need_sync) {
 		gp_ops[rsp->gp_type].sync();
 		rsp->gp_state = GP_PASSED;
@@ -139,7 +138,7 @@ void rcu_sync_enter(struct rcu_sync *rsp)
 		 * Nobody has yet been allowed the 'fast' path and thus we can
 		 * avoid doing any sync(). The callback will get 'dropped'.
 		 */
-		BUG_ON(rsp->gp_state != GP_PASSED);
+		WARN_ON_ONCE(rsp->gp_state != GP_PASSED);
 	}
 }
 
@@ -166,8 +165,8 @@ static void rcu_sync_func(struct rcu_head *rhp)
 	struct rcu_sync *rsp = container_of(rhp, struct rcu_sync, cb_head);
 	unsigned long flags;
 
-	BUG_ON(rsp->gp_state != GP_PASSED);
-	BUG_ON(rsp->cb_state == CB_IDLE);
+	WARN_ON_ONCE(rsp->gp_state != GP_PASSED);
+	WARN_ON_ONCE(rsp->cb_state == CB_IDLE);
 
 	spin_lock_irqsave(&rsp->rss_lock, flags);
 	if (rsp->gp_count) {
@@ -225,7 +224,7 @@ void rcu_sync_dtor(struct rcu_sync *rsp)
 {
 	int cb_state;
 
-	BUG_ON(rsp->gp_count);
+	WARN_ON_ONCE(rsp->gp_count);
 
 	spin_lock_irq(&rsp->rss_lock);
 	if (rsp->cb_state == CB_REPLAY)
@@ -235,6 +234,6 @@ void rcu_sync_dtor(struct rcu_sync *rsp)
 
 	if (cb_state != CB_IDLE) {
 		gp_ops[rsp->gp_type].wait();
-		BUG_ON(rsp->cb_state != CB_IDLE);
+		WARN_ON_ONCE(rsp->cb_state != CB_IDLE);
 	}
 }
-- 
2.17.1

