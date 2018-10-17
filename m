Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4DEECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7865621523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7865621523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeJQRGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:06:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52137 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbeJQRGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:06:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9H9BWSE277853
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Oct 2018 02:11:32 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9H9BVZa277850;
        Wed, 17 Oct 2018 02:11:31 -0700
Date:   Wed, 17 Oct 2018 02:11:31 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-1222109a53637f96c581224198b86856d503f892@git.kernel.org>
Cc:     akpm@linux-foundation.org, longman@redhat.com,
        paulmck@linux.vnet.ibm.com, tglx@linutronix.de,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org,
        peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          will.deacon@arm.com, tglx@linutronix.de, peterz@infradead.org,
          mingo@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
          longman@redhat.com, paulmck@linux.vnet.ibm.com
In-Reply-To: <1539697507-28084-1-git-send-email-longman@redhat.com>
References: <1539697507-28084-1-git-send-email-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/qspinlock_stat: Count instances of
 nested lock slowpaths
Git-Commit-ID: 1222109a53637f96c581224198b86856d503f892
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

Commit-ID:  1222109a53637f96c581224198b86856d503f892
Gitweb:     https://git.kernel.org/tip/1222109a53637f96c581224198b86856d503f892
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Tue, 16 Oct 2018 09:45:06 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 17 Oct 2018 08:37:31 +0200

locking/qspinlock_stat: Count instances of nested lock slowpaths

Queued spinlock supports up to 4 levels of lock slowpath nesting -
user context, soft IRQ, hard IRQ and NMI. However, we are not sure how
often the nesting happens.

So add 3 more per-CPU stat counters to track the number of instances where
nesting index goes to 1, 2 and 3 respectively.

On a dual-socket 64-core 128-thread Zen server, the following were the
new stat counter values under different circumstances:

         State                         slowpath   index1   index2   index3
         -----                         --------   ------   ------   -------
  After bootup                         1,012,150    82       0        0
  After parallel build + perf-top    125,195,009    82       0        0

So the chance of having more than 2 levels of nesting is extremely low.

[ mingo: Minor changelog edits. ]

Signed-off-by: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/1539697507-28084-1-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/qspinlock.c      | 5 +++++
 kernel/locking/qspinlock_stat.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 341ca666bc60..ce6af1ee2cac 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -396,6 +396,11 @@ pv_queue:
 
 	node += idx;
 
+	/*
+	 * Keep counts of non-zero index values:
+	 */
+	qstat_inc(qstat_lock_idx1 + idx - 1, idx);
+
 	/*
 	 * Ensure that we increment the head node->count before initialising
 	 * the actual node. If the compiler is kind enough to reorder these
diff --git a/kernel/locking/qspinlock_stat.h b/kernel/locking/qspinlock_stat.h
index 6bd78c0740fc..42d3d8dc8f49 100644
--- a/kernel/locking/qspinlock_stat.h
+++ b/kernel/locking/qspinlock_stat.h
@@ -55,6 +55,9 @@ enum qlock_stats {
 	qstat_pv_wait_node,
 	qstat_lock_pending,
 	qstat_lock_slowpath,
+	qstat_lock_idx1,
+	qstat_lock_idx2,
+	qstat_lock_idx3,
 	qstat_num,	/* Total number of statistical counters */
 	qstat_reset_cnts = qstat_num,
 };
@@ -82,6 +85,9 @@ static const char * const qstat_names[qstat_num + 1] = {
 	[qstat_pv_wait_node]       = "pv_wait_node",
 	[qstat_lock_pending]       = "lock_pending",
 	[qstat_lock_slowpath]      = "lock_slowpath",
+	[qstat_lock_idx1]	   = "lock_index1",
+	[qstat_lock_idx2]	   = "lock_index2",
+	[qstat_lock_idx3]	   = "lock_index3",
 	[qstat_reset_cnts]         = "reset_counters",
 };
 
