Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9D9C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B1820881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B1820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeJPVgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:36:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbeJPVgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:36:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7199B88E5A;
        Tue, 16 Oct 2018 13:46:00 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 894722E64A;
        Tue, 16 Oct 2018 13:45:57 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] locking/qspinlock_stat: Count instances of nested lock slowpaths
Date:   Tue, 16 Oct 2018 09:45:06 -0400
Message-Id: <1539697507-28084-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 16 Oct 2018 13:46:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued spinlock supports up to 4 levels of lock slowpath nesting -
user context, soft IRQ, hard IRQ and NMI. However, we are not sure how
often the nesting happens. So 3 more per-cpu stat counters are added
to track the number of instances where nesting index goes to 1, 2 and
3 respectively.

On a dual-socket 64-core 128-thread Zen server, the following were stat
counter values under different circumstances.

         State                      slowpath   index1   index2   index3
         -----                      --------   ------   ------   -------
  After bootup                      1,012,150    82       0        0
  After parallel build + perf-top 125,195,009    82       0        0

So the chance of needing more than 2 levels of nesting is extremely rare.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c      | 5 +++++
 kernel/locking/qspinlock_stat.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index bfaeb05..7099bbe 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -378,6 +378,11 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	node += idx;
 
 	/*
+	 * Keep counts of non-zero index values
+	 */
+	qstat_inc(qstat_lock_idx1 + idx - 1, idx);
+
+	/*
 	 * Ensure that we increment the head node->count before initialising
 	 * the actual node. If the compiler is kind enough to reorder these
 	 * stores, then an IRQ could overwrite our assignments.
diff --git a/kernel/locking/qspinlock_stat.h b/kernel/locking/qspinlock_stat.h
index 6bd78c0..42d3d8d 100644
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
@@ -82,6 +85,9 @@ enum qlock_stats {
 	[qstat_pv_wait_node]       = "pv_wait_node",
 	[qstat_lock_pending]       = "lock_pending",
 	[qstat_lock_slowpath]      = "lock_slowpath",
+	[qstat_lock_idx1]	   = "lock_index1",
+	[qstat_lock_idx2]	   = "lock_index2",
+	[qstat_lock_idx3]	   = "lock_index3",
 	[qstat_reset_cnts]         = "reset_counters",
 };
 
-- 
1.8.3.1

