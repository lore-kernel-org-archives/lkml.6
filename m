Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF35C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8EB420644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EB420644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeH3Cx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:53:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52892 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727597AbeH3CxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:53:25 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMs0Ax122059
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:16 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m64a28kr9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:16 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:54:15 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:54:09 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMs9oc18415710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:54:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1445B2067;
        Wed, 29 Aug 2018 18:53:04 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA5FDB206B;
        Wed, 29 Aug 2018 18:53:04 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:53:04 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C80AF16C91DE; Wed, 29 Aug 2018 15:54:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 23/24] rcu: Define rcu_all_qs() only in !PREEMPT builds
Date:   Wed, 29 Aug 2018 15:54:04 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829225340.GA7019@linux.vnet.ibm.com>
References: <20180829225340.GA7019@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0072-0000-0000-0000039969A9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080749; UDB=6.00557500; IPR=6.00860734;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:54:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0073-0000-0000-0000493EB981
Message-Id: <20180829225405.7275-23-paulmck@linux.vnet.ibm.com>
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

Now that rcu_all_qs() is used only in !PREEMPT builds, move it to
tree_plugin.h so that it is defined only in those builds.  This in
turn means that rcu_momentary_dyntick_idle() is only used in !PREEMPT
builds, but it is simply marked __maybe_unused in order to keep it
near the rest of the dyntick-idle code.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/rcutree.h  |  2 ++
 kernel/rcu/tree.c        | 41 +---------------------------------------
 kernel/rcu/tree_plugin.h | 39 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index d09a9abe9440..7f83179177d1 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -66,7 +66,9 @@ void rcu_scheduler_starting(void);
 extern int rcu_scheduler_active __read_mostly;
 void rcu_end_inkernel_boot(void);
 bool rcu_is_watching(void);
+#ifndef CONFIG_PREEMPT
 void rcu_all_qs(void);
+#endif
 
 /* RCUtree hotplug events */
 int rcutree_prepare_cpu(unsigned int cpu);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e8fbb7ee76cc..5f2a12a65b42 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -356,7 +356,7 @@ bool rcu_eqs_special_set(int cpu)
  *
  * The caller must have disabled interrupts and must not be idle.
  */
-static void rcu_momentary_dyntick_idle(void)
+static void __maybe_unused rcu_momentary_dyntick_idle(void)
 {
 	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 	int special;
@@ -381,45 +381,6 @@ static int rcu_is_cpu_rrupt_from_idle(void)
 	       __this_cpu_read(rcu_dynticks.dynticks_nmi_nesting) <= 1;
 }
 
-/*
- * Register an urgently needed quiescent state.  If there is an
- * emergency, invoke rcu_momentary_dyntick_idle() to do a heavy-weight
- * dyntick-idle quiescent state visible to other CPUs, which will in
- * some cases serve for expedited as well as normal grace periods.
- * Either way, register a lightweight quiescent state.
- *
- * The barrier() calls are redundant in the common case when this is
- * called externally, but just in case this is called from within this
- * file.
- *
- */
-void rcu_all_qs(void)
-{
-	unsigned long flags;
-
-	if (!raw_cpu_read(rcu_dynticks.rcu_urgent_qs))
-		return;
-	preempt_disable();
-	/* Load rcu_urgent_qs before other flags. */
-	if (!smp_load_acquire(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs))) {
-		preempt_enable();
-		return;
-	}
-	this_cpu_write(rcu_dynticks.rcu_urgent_qs, false);
-	barrier(); /* Avoid RCU read-side critical sections leaking down. */
-	if (unlikely(raw_cpu_read(rcu_dynticks.rcu_need_heavy_qs))) {
-		local_irq_save(flags);
-		rcu_momentary_dyntick_idle();
-		local_irq_restore(flags);
-	}
-	if (unlikely(raw_cpu_read(rcu_data.cpu_no_qs.b.exp)))
-		rcu_qs();
-	this_cpu_inc(rcu_dynticks.rcu_qs_ctr);
-	barrier(); /* Avoid RCU read-side critical sections leaking up. */
-	preempt_enable();
-}
-EXPORT_SYMBOL_GPL(rcu_all_qs);
-
 #define DEFAULT_RCU_BLIMIT 10     /* Maximum callbacks per rcu_do_batch. */
 static long blimit = DEFAULT_RCU_BLIMIT;
 #define DEFAULT_RCU_QHIMARK 10000 /* If this many pending, ignore blimit. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index cd4c1b979446..7add1c297500 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -947,6 +947,45 @@ static void rcu_qs(void)
 	rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
 }
 
+/*
+ * Register an urgently needed quiescent state.  If there is an
+ * emergency, invoke rcu_momentary_dyntick_idle() to do a heavy-weight
+ * dyntick-idle quiescent state visible to other CPUs, which will in
+ * some cases serve for expedited as well as normal grace periods.
+ * Either way, register a lightweight quiescent state.
+ *
+ * The barrier() calls are redundant in the common case when this is
+ * called externally, but just in case this is called from within this
+ * file.
+ *
+ */
+void rcu_all_qs(void)
+{
+	unsigned long flags;
+
+	if (!raw_cpu_read(rcu_dynticks.rcu_urgent_qs))
+		return;
+	preempt_disable();
+	/* Load rcu_urgent_qs before other flags. */
+	if (!smp_load_acquire(this_cpu_ptr(&rcu_dynticks.rcu_urgent_qs))) {
+		preempt_enable();
+		return;
+	}
+	this_cpu_write(rcu_dynticks.rcu_urgent_qs, false);
+	barrier(); /* Avoid RCU read-side critical sections leaking down. */
+	if (unlikely(raw_cpu_read(rcu_dynticks.rcu_need_heavy_qs))) {
+		local_irq_save(flags);
+		rcu_momentary_dyntick_idle();
+		local_irq_restore(flags);
+	}
+	if (unlikely(raw_cpu_read(rcu_data.cpu_no_qs.b.exp)))
+		rcu_qs();
+	this_cpu_inc(rcu_dynticks.rcu_qs_ctr);
+	barrier(); /* Avoid RCU read-side critical sections leaking up. */
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(rcu_all_qs);
+
 /*
  * Note a PREEMPT=n context switch.  The caller must have disabled interrupts.
  */
-- 
2.17.1

