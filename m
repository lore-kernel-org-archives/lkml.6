Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248AEC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E85892082F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfA2VyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:54:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48012 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbfA2VyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:54:06 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E5B0C07457B;
        Tue, 29 Jan 2019 21:54:05 +0000 (UTC)
Received: from llong.com (dhcp-17-91.bos.redhat.com [10.18.17.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D1F75D96F;
        Tue, 29 Jan 2019 21:54:04 +0000 (UTC)
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
Subject: [PATCH v3 2/4] locking/qspinlock_stat: Track the no MCS node available case
Date:   Tue, 29 Jan 2019 22:53:46 +0100
Message-Id: <1548798828-16156-3-git-send-email-longman@redhat.com>
In-Reply-To: <1548798828-16156-1-git-send-email-longman@redhat.com>
References: <1548798828-16156-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 29 Jan 2019 21:54:05 +0000 (UTC)
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
 kernel/locking/qspinlock.c      |  3 ++-
 kernel/locking/qspinlock_stat.h | 21 +++++++++++++++------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 0875053..21ee51b 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -422,6 +422,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	 * simple enough.
 	 */
 	if (unlikely(idx >= MAX_NODES)) {
+		qstat_inc(qstat_lock_no_node, true);
 		while (!queued_spin_trylock(lock))
 			cpu_relax();
 		goto release;
@@ -432,7 +433,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	/*
 	 * Keep counts of non-zero index values:
 	 */
-	qstat_inc(qstat_lock_idx1 + idx - 1, idx);
+	qstat_inc(qstat_lock_use_node2 + idx - 1, idx);
 
 	/*
 	 * Ensure that we increment the head node->count before initialising
diff --git a/kernel/locking/qspinlock_stat.h b/kernel/locking/qspinlock_stat.h
index 42d3d8d..365ce6d 100644
--- a/kernel/locking/qspinlock_stat.h
+++ b/kernel/locking/qspinlock_stat.h
@@ -30,6 +30,13 @@
  *   pv_wait_node	- # of vCPU wait's at a non-head queue node
  *   lock_pending	- # of locking operations via pending code
  *   lock_slowpath	- # of locking operations via MCS lock queue
+ *   lock_use_node2	- # of locking operations that use 2nd percpu node
+ *   lock_use_node3	- # of locking operations that use 3rd percpu node
+ *   lock_use_node4	- # of locking operations that use 4th percpu node
+ *   lock_no_node	- # of locking operations without using percpu node
+ *
+ * Subtracting lock_use_node[234] from lock_slowpath will give you
+ * lock_use_node1.
  *
  * Writing to the "reset_counters" file will reset all the above counter
  * values.
@@ -55,9 +62,10 @@ enum qlock_stats {
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
 	qstat_num,	/* Total number of statistical counters */
 	qstat_reset_cnts = qstat_num,
 };
@@ -85,9 +93,10 @@ enum qlock_stats {
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
 	[qstat_reset_cnts]         = "reset_counters",
 };
 
-- 
1.8.3.1

