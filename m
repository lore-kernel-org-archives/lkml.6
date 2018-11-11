Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D701FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97283214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97283214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbeKLFSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:18:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbeKLFSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:18:36 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wABJNuSx047374
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:29:13 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2npd3s9vt4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 14:29:12 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 11 Nov 2018 19:29:11 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 11 Nov 2018 19:29:07 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wABJT6Fm25821236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 11 Nov 2018 19:29:06 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 054D3B206E;
        Sun, 11 Nov 2018 19:29:06 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3005B206A;
        Sun, 11 Nov 2018 19:29:05 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.24])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Nov 2018 19:29:05 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9936D16C5DA1; Sun, 11 Nov 2018 11:29:06 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 09/14] rcu: Speed up expedited GPs when interrupting RCU reader
Date:   Sun, 11 Nov 2018 11:28:59 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181111192839.GA32144@linux.ibm.com>
References: <20181111192839.GA32144@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18111119-0052-0000-0000-0000035421B3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010028; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01116014; UDB=6.00578730; IPR=6.00896114;
 MB=3.00024114; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-11 19:29:10
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18111119-0053-0000-0000-00005EBB1CAE
Message-Id: <20181111192904.3199-9-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-11_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811110185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In PREEMPT kernels, an expedited grace period might send an IPI to a
CPU that is executing an RCU read-side critical section.  In that case,
it would be nice if the rcu_read_unlock() directly interacted with the
RCU core code to immediately report the quiescent state.  And this does
happen in the case where the reader has been preempted.  But it would
also be a nice performance optimization if immediate reporting also
happened in the preemption-free case.

This commit therefore adds an ->exp_hint field to the task_struct structure's
->rcu_read_unlock_special field.  The IPI handler sets this hint when
it has interrupted an RCU read-side critical section, and this causes
the outermost rcu_read_unlock() call to invoke rcu_read_unlock_special(),
which, if preemption is enabled, reports the quiescent state immediately.
If preemption is disabled, then the report is required to be deferred
until preemption (or bottom halves or interrupts or whatever) is re-enabled.

Because this is a hint, it does nothing for more complicated cases.  For
example, if the IPI interrupts an RCU reader, but interrupts are disabled
across the rcu_read_unlock(), but another rcu_read_lock() is executed
before interrupts are re-enabled, the hint will already have been cleared.
If you do crazy things like this, reporting will be deferred until some
later RCU_SOFTIRQ handler, context switch, cond_resched(), or similar.

Reported-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/sched.h    |  4 +++-
 kernel/rcu/tree_exp.h    |  4 +++-
 kernel/rcu/tree_plugin.h | 14 +++++++++++---
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a51c13c2b1a0..e4c7b6241088 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -572,8 +572,10 @@ union rcu_special {
 	struct {
 		u8			blocked;
 		u8			need_qs;
+		u8			exp_hint; /* Hint for performance. */
+		u8			pad; /* No garbage from compiler! */
 	} b; /* Bits. */
-	u16 s; /* Set of bits. */
+	u32 s; /* Set of bits. */
 };
 
 enum perf_event_task_context {
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index e669ccf3751b..928fe5893a57 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -692,8 +692,10 @@ static void sync_rcu_exp_handler(void *unused)
 	 */
 	if (t->rcu_read_lock_nesting > 0) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		if (rnp->expmask & rdp->grpmask)
+		if (rnp->expmask & rdp->grpmask) {
 			rdp->deferred_qs = true;
+			WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, true);
+		}
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 05915e536336..618956cc7a55 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -642,13 +642,21 @@ static void rcu_read_unlock_special(struct task_struct *t)
 
 	local_irq_save(flags);
 	irqs_were_disabled = irqs_disabled_flags(flags);
-	if ((preempt_bh_were_disabled || irqs_were_disabled) &&
-	    t->rcu_read_unlock_special.b.blocked) {
+	if (preempt_bh_were_disabled || irqs_were_disabled) {
+		WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
 		/* Need to defer quiescent state until everything is enabled. */
-		raise_softirq_irqoff(RCU_SOFTIRQ);
+		if (irqs_were_disabled) {
+			/* Enabling irqs does not reschedule, so... */
+			raise_softirq_irqoff(RCU_SOFTIRQ);
+		} else {
+			/* Enabling BH or preempt does reschedule, so... */
+			set_tsk_need_resched(current);
+			set_preempt_need_resched();
+		}
 		local_irq_restore(flags);
 		return;
 	}
+	WRITE_ONCE(t->rcu_read_unlock_special.b.exp_hint, false);
 	rcu_preempt_deferred_qs_irqrestore(t, flags);
 }
 
-- 
2.17.1

