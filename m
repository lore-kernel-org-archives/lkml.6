Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79837C282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4750420989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfAUHgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:36:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51208 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbfAUHgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:36:23 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 68B73C0222;
        Mon, 21 Jan 2019 02:50:22 +0000 (UTC)
Received: from llong.com (ovpn-120-230.rdu2.redhat.com [10.10.120.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C3AA1048132;
        Mon, 21 Jan 2019 02:50:20 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        James Morse <james.morse@arm.com>,
        SRINIVAS <srinivas.eeda@oracle.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/5] locking/qspinlock_stat: Track the no MCS node available case
Date:   Sun, 20 Jan 2019 21:49:51 -0500
Message-Id: <1548038994-30073-3-git-send-email-longman@redhat.com>
In-Reply-To: <1548038994-30073-1-git-send-email-longman@redhat.com>
References: <1548038994-30073-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 21 Jan 2019 02:50:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Track the number of slowpath locking operations that are being done
without any MCS node available as well renaming lock_index[123] to make
them more descriptive.

Using these stat counters is one way to find out if a code path is
being exercised.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c      |  4 +++-
 kernel/locking/qspinlock_stat.h | 24 ++++++++++++++++++------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 5bb06df..8163633 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -395,6 +395,7 @@ static noinline void acquire_lock_no_node(struct qspinlock *lock)
  */
 static noinline void spin_on_waiting(struct qspinlock *lock)
 {
+	qstat_inc(qstat_lock_waiting, true);
 	atomic_cond_read_relaxed(&lock->val, !(VAL & _Q_WAITING_VAL));
 
 	/* Clear the pending bit now */
@@ -548,6 +549,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 */
 	if (unlikely(idx >= MAX_NODES)) {
 		acquire_lock_no_node(lock);
+		qstat_inc(qstat_lock_no_node, true);
 		goto release;
 	}
 
@@ -556,7 +558,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	/*
 	 * Keep counts of non-zero index values:
 	 */
-	qstat_inc(qstat_lock_idx1 + idx - 1, idx);
+	qstat_inc(qstat_lock_use_node2 + idx - 1, idx);
 
 	/*
 	 * Ensure that we increment the head node->count before initialising
diff --git a/kernel/locking/qspinlock_stat.h b/kernel/locking/qspinlock_stat.h
index 42d3d8d..4f8ca8c 100644
--- a/kernel/locking/qspinlock_stat.h
+++ b/kernel/locking/qspinlock_stat.h
@@ -30,6 +30,14 @@
  *   pv_wait_node	- # of vCPU wait's at a non-head queue node
  *   lock_pending	- # of locking operations via pending code
  *   lock_slowpath	- # of locking operations via MCS lock queue
+ *   lock_use_node2	- # of locking operations that use 2nd percpu node
+ *   lock_use_node3	- # of locking operations that use 3rd percpu node
+ *   lock_use_node4	- # of locking operations that use 4th percpu node
+ *   lock_no_node	- # of locking operations without using percpu node
+ *   lock_waiting	- # of locking operations with waiting bit set
+ *
+ * Subtraccting lock_use_node[234] from lock_slowpath will give you
+ * lock_use_node1.
  *
  * Writing to the "reset_counters" file will reset all the above counter
  * values.
@@ -55,9 +63,11 @@ enum qlock_stats {
 	qstat_pv_wait_node,
 	qstat_lock_pending,
 	qstat_lock_slowpath,
-	qstat_lock_idx1,
-	qstat_lock_idx2,
-	qstat_lock_idx3,
+	qstat_lock_use_node2,
+	qstat_lock_use_node3,
+	qstat_lock_use_node4,
+	qstat_lock_no_node,
+	qstat_lock_waiting,
 	qstat_num,	/* Total number of statistical counters */
 	qstat_reset_cnts = qstat_num,
 };
@@ -85,9 +95,11 @@ enum qlock_stats {
 	[qstat_pv_wait_node]       = "pv_wait_node",
 	[qstat_lock_pending]       = "lock_pending",
 	[qstat_lock_slowpath]      = "lock_slowpath",
-	[qstat_lock_idx1]	   = "lock_index1",
-	[qstat_lock_idx2]	   = "lock_index2",
-	[qstat_lock_idx3]	   = "lock_index3",
+	[qstat_lock_use_node2]	   = "lock_use_node2",
+	[qstat_lock_use_node3]	   = "lock_use_node3",
+	[qstat_lock_use_node4]	   = "lock_use_node4",
+	[qstat_lock_no_node]	   = "lock_no_node",
+	[qstat_lock_waiting]	   = "lock_waiting",
 	[qstat_reset_cnts]         = "reset_counters",
 };
 
-- 
1.8.3.1

