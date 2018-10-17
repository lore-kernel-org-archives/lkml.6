Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFB1ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0E521526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0E521526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeJQRHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:07:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40315 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbeJQRHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:07:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9H9C4am278077
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Oct 2018 02:12:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9H9C4tD278074;
        Wed, 17 Oct 2018 02:12:04 -0700
Date:   Wed, 17 Oct 2018 02:12:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-0fa809ca7f81c47bea6706bc689e941eb25d7e89@git.kernel.org>
Cc:     tglx@linutronix.de, longman@redhat.com, mingo@kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, paulmck@linux.vnet.ibm.com, hpa@zytor.com
Reply-To: akpm@linux-foundation.org, tglx@linutronix.de,
          longman@redhat.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          peterz@infradead.org, paulmck@linux.vnet.ibm.com,
          will.deacon@arm.com, hpa@zytor.com
In-Reply-To: <1539697507-28084-2-git-send-email-longman@redhat.com>
References: <1539697507-28084-2-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/pvqspinlock: Extend node size when
 pvqspinlock is configured
Git-Commit-ID: 0fa809ca7f81c47bea6706bc689e941eb25d7e89
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0fa809ca7f81c47bea6706bc689e941eb25d7e89
Gitweb:     https://git.kernel.org/tip/0fa809ca7f81c47bea6706bc689e941eb25d7e89
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Tue, 16 Oct 2018 09:45:07 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 17 Oct 2018 08:37:32 +0200

locking/pvqspinlock: Extend node size when pvqspinlock is configured

The qspinlock code supports up to 4 levels of slowpath nesting using
four per-CPU mcs_spinlock structures. For 64-bit architectures, they
fit nicely in one 64-byte cacheline.

For para-virtualized (PV) qspinlocks it needs to store more information
in the per-CPU node structure than there is space for. It uses a trick
to use a second cacheline to hold the extra information that it needs.
So PV qspinlock needs to access two extra cachelines for its information
whereas the native qspinlock code only needs one extra cacheline.

Freshly added counter profiling of the qspinlock code, however, revealed
that it was very rare to use more than two levels of slowpath nesting.
So it doesn't make sense to penalize PV qspinlock code in order to have
four mcs_spinlock structures in the same cacheline to optimize for a case
in the native qspinlock code that rarely happens.

Extend the per-CPU node structure to have two more long words when PV
qspinlock locks are configured to hold the extra data that it needs.

As a result, the PV qspinlock code will enjoy the same benefit of using
just one extra cacheline like the native counterpart, for most cases.

[ mingo: Minor changelog edits. ]

Signed-off-by: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/1539697507-28084-2-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/qspinlock.c          | 34 ++++++++++++++++++++++++++--------
 kernel/locking/qspinlock_paravirt.h |  4 +---
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index ce6af1ee2cac..8a8c3c208c5e 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -74,12 +74,24 @@
  */
 
 #include "mcs_spinlock.h"
+#define MAX_NODES	4
 
+/*
+ * On 64-bit architectures, the mcs_spinlock structure will be 16 bytes in
+ * size and four of them will fit nicely in one 64-byte cacheline. For
+ * pvqspinlock, however, we need more space for extra data. To accommodate
+ * that, we insert two more long words to pad it up to 32 bytes. IOW, only
+ * two of them can fit in a cacheline in this case. That is OK as it is rare
+ * to have more than 2 levels of slowpath nesting in actual use. We don't
+ * want to penalize pvqspinlocks to optimize for a rare case in native
+ * qspinlocks.
+ */
+struct qnode {
+	struct mcs_spinlock mcs;
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
-#define MAX_NODES	8
-#else
-#define MAX_NODES	4
+	long reserved[2];
 #endif
+};
 
 /*
  * The pending bit spinning loop count.
@@ -101,7 +113,7 @@
  *
  * PV doubles the storage and uses the second cacheline for PV state.
  */
-static DEFINE_PER_CPU_ALIGNED(struct mcs_spinlock, mcs_nodes[MAX_NODES]);
+static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);
 
 /*
  * We must be able to distinguish between no-tail and the tail at 0:0,
@@ -126,7 +138,13 @@ static inline __pure struct mcs_spinlock *decode_tail(u32 tail)
 	int cpu = (tail >> _Q_TAIL_CPU_OFFSET) - 1;
 	int idx = (tail &  _Q_TAIL_IDX_MASK) >> _Q_TAIL_IDX_OFFSET;
 
-	return per_cpu_ptr(&mcs_nodes[idx], cpu);
+	return per_cpu_ptr(&qnodes[idx].mcs, cpu);
+}
+
+static inline __pure
+struct mcs_spinlock *grab_mcs_node(struct mcs_spinlock *base, int idx)
+{
+	return &((struct qnode *)base + idx)->mcs;
 }
 
 #define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
@@ -390,11 +408,11 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 queue:
 	qstat_inc(qstat_lock_slowpath, true);
 pv_queue:
-	node = this_cpu_ptr(&mcs_nodes[0]);
+	node = this_cpu_ptr(&qnodes[0].mcs);
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
 
-	node += idx;
+	node = grab_mcs_node(node, idx);
 
 	/*
 	 * Keep counts of non-zero index values:
@@ -534,7 +552,7 @@ release:
 	/*
 	 * release the node
 	 */
-	__this_cpu_dec(mcs_nodes[0].count);
+	__this_cpu_dec(qnodes[0].mcs.count);
 }
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 5a0cf5f9008c..0130e488ebfe 100644
--- a/kernel/locking/qspinlock_paravirt.h
+++ b/kernel/locking/qspinlock_paravirt.h
@@ -49,8 +49,6 @@ enum vcpu_state {
 
 struct pv_node {
 	struct mcs_spinlock	mcs;
-	struct mcs_spinlock	__res[3];
-
 	int			cpu;
 	u8			state;
 };
@@ -281,7 +279,7 @@ static void pv_init_node(struct mcs_spinlock *node)
 {
 	struct pv_node *pn = (struct pv_node *)node;
 
-	BUILD_BUG_ON(sizeof(struct pv_node) > 5*sizeof(struct mcs_spinlock));
+	BUILD_BUG_ON(sizeof(struct pv_node) > sizeof(struct qnode));
 
 	pn->cpu = smp_processor_id();
 	pn->state = vcpu_running;
