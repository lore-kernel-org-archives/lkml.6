Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C9AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517A42064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517A42064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeH3CVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:21:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36380 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727356AbeH3CTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:19:54 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMIhGR084115
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:56 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m629duw32-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:56 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:20:55 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:20:50 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMKn3t3932464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:20:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A63DB2077;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1183EB2067;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 28CAC16C91CB; Wed, 29 Aug 2018 15:20:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 07/19] rcu: Apply RCU-bh QSes to RCU-sched and RCU-preempt when safe
Date:   Wed, 29 Aug 2018 15:20:35 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829222021.GA29944@linux.vnet.ibm.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0052-0000-0000-000003281F37
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080738; UDB=6.00557494; IPR=6.00860723;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:20:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0053-0000-0000-00005DE5F2E8
Message-Id: <20180829222047.319-7-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One necessary step towards consolidating the three flavors of RCU is to
make sure that the resulting consolidated "one flavor to rule them all"
correctly handles networking denial-of-service attacks.  One thing that
allows RCU-bh to do so is that __do_softirq() invokes rcu_bh_qs() every
so often, and so something similar has to happen for consolidated RCU.

This must be done carefully.  For example, if a preemption-disabled
region of code takes an interrupt which does softirq processing before
returning, consolidated RCU must ignore the resulting rcu_bh_qs()
invocations -- preemption is still disabled, and that means an RCU
reader for the consolidated flavor.

This commit therefore creates a new rcu_softirq_qs() that is called only
from the ksoftirqd task, thus avoiding the interrupted-a-preempted-region
problem.  This new rcu_softirq_qs() function invokes rcu_sched_qs(),
rcu_preempt_qs(), and rcu_preempt_deferred_qs().  The latter call handles
any deferred quiescent states.

Note that __do_softirq() still invokes rcu_bh_qs().  It will continue to
do so until a later stage of cleanup when the RCU-bh flavor is removed.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Fix !SMP issue located by kbuild test robot. ]
---
 include/linux/rcutiny.h  | 5 +++++
 include/linux/rcutree.h  | 1 +
 kernel/rcu/tree.c        | 7 +++++++
 kernel/rcu/tree.h        | 1 +
 kernel/rcu/tree_plugin.h | 5 +++++
 kernel/softirq.c         | 2 ++
 6 files changed, 21 insertions(+)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index f617ab19bb51..bcfbc40a7239 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -90,6 +90,11 @@ static inline void kfree_call_rcu(struct rcu_head *head,
 	call_rcu(head, func);
 }
 
+static inline void rcu_softirq_qs(void)
+{
+	rcu_sched_qs();
+}
+
 #define rcu_note_context_switch(preempt) \
 	do { \
 		rcu_sched_qs(); \
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 914655848ef6..664b580695d6 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -30,6 +30,7 @@
 #ifndef __LINUX_RCUTREE_H
 #define __LINUX_RCUTREE_H
 
+void rcu_softirq_qs(void);
 void rcu_note_context_switch(bool preempt);
 int rcu_needs_cpu(u64 basem, u64 *nextevt);
 void rcu_cpu_stall_reset(void);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d2b6ade692c9..9b6bd12133c4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -255,6 +255,13 @@ void rcu_bh_qs(void)
 	}
 }
 
+void rcu_softirq_qs(void)
+{
+	rcu_sched_qs();
+	rcu_preempt_qs();
+	rcu_preempt_deferred_qs(current);
+}
+
 /*
  * Steal a bit from the bottom of ->dynticks for idle entry/exit
  * control.  Initially this is for TLB flushing.
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 025bd2e5592b..e02c882861eb 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -433,6 +433,7 @@ DECLARE_PER_CPU(char, rcu_cpu_has_work);
 
 /* Forward declarations for rcutree_plugin.h */
 static void rcu_bootup_announce(void);
+static void rcu_preempt_qs(void);
 static void rcu_preempt_note_context_switch(bool preempt);
 static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp);
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 527a52792dce..c686bf63bba5 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -974,6 +974,11 @@ static void __init rcu_bootup_announce(void)
 	rcu_bootup_announce_oddness();
 }
 
+/* Because preemptible RCU does not exist, we can ignore its QSes. */
+static void rcu_preempt_qs(void)
+{
+}
+
 /*
  * Because preemptible RCU does not exist, we never have to check for
  * CPUs being in quiescent states.
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 6f584861d329..ebd69694144a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -302,6 +302,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	}
 
 	rcu_bh_qs();
+	if (__this_cpu_read(ksoftirqd) == current)
+		rcu_softirq_qs();
 	local_irq_disable();
 
 	pending = local_softirq_pending();
-- 
2.17.1

