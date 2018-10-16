Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F74C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E302089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E302089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeJPVgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:36:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbeJPVge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:36:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 28CDB308429C;
        Tue, 16 Oct 2018 13:46:01 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 921162E64A;
        Tue, 16 Oct 2018 13:46:00 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] locking/pvqspinlock: Extend node size when pvqspinlock is configured
Date:   Tue, 16 Oct 2018 09:45:07 -0400
Message-Id: <1539697507-28084-2-git-send-email-longman@redhat.com>
In-Reply-To: <1539697507-28084-1-git-send-email-longman@redhat.com>
References: <1539697507-28084-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 16 Oct 2018 13:46:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qspinlock code supports up to 4 level of slowpath nesting using
four per-cpu mcs_spinlock structures. For 64-bit architectures, they
fit nicely in one 64-byte cacheline.

For para-virtualized (PV) qspinlock, it needs to store more information
in the per-cpu node structure than there is space for. It uses a trick
to use a second cacheline to hold the extra information that it needs.
So PV qspinlock needs to access two extra cachelines for its information
whereas the native qspinlock code only needs one extra cacheline.

Counter profiling of the qspinlock code, however, revealed that it
was very rare to use more than two levels of slowpath nesting. So it
doesn't make sense to penalize PV qspinlock code in order to have four
mcs_spinlock structures in the same cacheline to optimize for a case
in the native qspinlock code that rarely happens.

The per-cpu node structure is now extended to have two more long
words when PV qspinlock lock is configured to hold the extra data
that it needs.  As a result, the PV qspinlock code will enjoy the same
benefit of using just one extra cacheline like the native counterpart
for most cases.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c          | 34 ++++++++++++++++++++++++++--------
 kernel/locking/qspinlock_paravirt.h |  4 +---
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 7099bbe..389bdb7 100644
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
+ * want to penalize pvqspinlock to optimize for a rare case in native
+ * qspinlock.
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
@@ -371,11 +389,11 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
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
 	 * Keep counts of non-zero index values
@@ -506,7 +524,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	/*
 	 * release the node
 	 */
-	__this_cpu_dec(mcs_nodes[0].count);
+	__this_cpu_dec(qnodes[0].mcs.count);
 }
 EXPORT_SYMBOL(queued_spin_lock_slowpath);
 
diff --git a/kernel/locking/qspinlock_paravirt.h b/kernel/locking/qspinlock_paravirt.h
index 5a0cf5f..0130e48 100644
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
-- 
1.8.3.1

