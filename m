Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B61C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8476521731
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8476521731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeKLFS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:18:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726776AbeKLFSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:18:37 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJNxuB003631
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:29:13 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2npdvs89qh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:29:13 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:29:12 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:29:07 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJT6Ms45154534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:29:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3354B2066;
        Sun, 11 Nov 2018 19:29:05 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8F6DB205F;
        Sun, 11 Nov 2018 19:29:05 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:29:05 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A499E16C5DA3; Sun, 11 Nov 2018 11:29:06 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 11/14] rcu: Avoid signed integer overflow in rcu_preempt_deferred_qs()
Date:   Sun, 11 Nov 2018 11:29:01 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111192839.GA32144@linux.ibm.com>
References: <20181111192839.GA32144@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-0040-0000-0000-00000490883C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116014; UDB=6.00577119; IPR=6.00896114;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:29:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-0041-0000-0000-0000089990E9
Message-Id: <20181111192904.3199-11-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subtracting INT_MIN can be interpreted as unconditional signed integer
overflow, which according to the C standard is undefined behavior.
Therefore, kernel build arguments notwithstanding, it would be good to
future-proof the code.  This commit therefore substitutes INT_MAX for
INT_MIN in order to avoid undefined behavior.

While in the neighborhood, this commit also creates some meaningful names
for INT_MAX and friends in order to improve readability, as suggested
by Joel Fernandes.

Reported-by: Ran Rozenstein <ranro@mellanox.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree_plugin.h | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0bb1c1593ca4..3ed43f8cb029 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -397,6 +397,11 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 	return rnp->gp_tasks != NULL;
 }
 
+/* Bias and limit values for ->rcu_read_lock_nesting. */
+#define RCU_NEST_BIAS INT_MAX
+#define RCU_NEST_NMAX (-INT_MAX / 2)
+#define RCU_NEST_PMAX (INT_MAX / 2)
+
 /*
  * Preemptible RCU implementation for rcu_read_lock().
  * Just increment ->rcu_read_lock_nesting, shared state will be updated
@@ -405,6 +410,8 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
 void __rcu_read_lock(void)
 {
 	current->rcu_read_lock_nesting++;
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING))
+		WARN_ON_ONCE(current->rcu_read_lock_nesting > RCU_NEST_PMAX);
 	barrier();  /* critical section after entry code. */
 }
 EXPORT_SYMBOL_GPL(__rcu_read_lock);
@@ -424,20 +431,18 @@ void __rcu_read_unlock(void)
 		--t->rcu_read_lock_nesting;
 	} else {
 		barrier();  /* critical section before exit code. */
-		t->rcu_read_lock_nesting = INT_MIN;
+		t->rcu_read_lock_nesting = -RCU_NEST_BIAS;
 		barrier();  /* assign before ->rcu_read_unlock_special load */
 		if (unlikely(READ_ONCE(t->rcu_read_unlock_special.s)))
 			rcu_read_unlock_special(t);
 		barrier();  /* ->rcu_read_unlock_special load before assign */
 		t->rcu_read_lock_nesting = 0;
 	}
-#ifdef CONFIG_PROVE_LOCKING
-	{
-		int rrln = READ_ONCE(t->rcu_read_lock_nesting);
+	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
+		int rrln = t->rcu_read_lock_nesting;
 
-		WARN_ON_ONCE(rrln < 0 && rrln > INT_MIN / 2);
+		WARN_ON_ONCE(rrln < 0 && rrln > RCU_NEST_NMAX);
 	}
-#endif /* #ifdef CONFIG_PROVE_LOCKING */
 }
 EXPORT_SYMBOL_GPL(__rcu_read_unlock);
 
@@ -617,11 +622,11 @@ static void rcu_preempt_deferred_qs(struct task_struct *t)
 	if (!rcu_preempt_need_deferred_qs(t))
 		return;
 	if (couldrecurse)
-		t->rcu_read_lock_nesting -= INT_MIN;
+		t->rcu_read_lock_nesting -= RCU_NEST_BIAS;
 	local_irq_save(flags);
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 	if (couldrecurse)
-		t->rcu_read_lock_nesting += INT_MIN;
+		t->rcu_read_lock_nesting += RCU_NEST_BIAS;
 }
 
 /*
-- 
2.17.1

