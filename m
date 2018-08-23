Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CC9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188162098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188162098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeHWT4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 15:56:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727545AbeHWT4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 15:56:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 305BC40241C6;
        Thu, 23 Aug 2018 16:26:20 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEDFC10D178B;
        Thu, 23 Aug 2018 16:26:19 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] xfs: Use wake_q for waking up log space waiters
Date:   Thu, 23 Aug 2018 12:26:10 -0400
Message-Id: <1535041570-24102-3-git-send-email-longman@redhat.com>
In-Reply-To: <1535041570-24102-1-git-send-email-longman@redhat.com>
References: <1535041570-24102-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 23 Aug 2018 16:26:20 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 23 Aug 2018 16:26:20 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running the AIM7 fserver workload on a 2-socket 24-core 48-thread
Broadwell system, it was found that there were severe spinlock contention
in the XFS code. In particular, native_queued_spin_lock_slowpath()
consumes 69.7% of cpu time. The xlog_grant_head_check() function call and
its sub-function calls underneath it consumed 27.2% of the cpu time. This
function tried to wake up tasks in the log space wait queue and then
put itself into the wait queue if there is not enough log space left.

The process of waking up task can be time consuming and it is not
really necessary to hold an XFS lock while doing the wakeups. So the
xlog_grant_head_wake() function is modified to put the tasks to be waken
up into a wake_q to be passed to wake_up_q() without holding the lock.

Corresponding changes are made in xlog_grant_head_wait() to dequeue the
tasks from the wait queue after they are put into the wake_q. This avoids
multiple wakeups of the same task from different log space waiters.
Multiple wakeups seems to be a possibility in the existing code too.

With the use of the wake_q, the cpu time used by
native_queued_spin_lock_slowpath() dropped to 39.6%. However, the
performance of the AIM7 fserver workload increased from 91,485.51
jobs/min to 397,290.21 jobs/min which was more than 4X improvement.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/xfs/xfs_log.c | 48 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index c3b610b..1402ad3 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2000-2005 Silicon Graphics, Inc.
  * All Rights Reserved.
  */
+#include <linux/sched/wake_q.h>
+
 #include "xfs.h"
 #include "xfs_fs.h"
 #include "xfs_shared.h"
@@ -221,19 +223,21 @@
 xlog_grant_head_wake(
 	struct xlog		*log,
 	struct xlog_grant_head	*head,
-	int			*free_bytes)
+	int			*free_bytes,
+	struct wake_q_head	*wakeq)
 {
-	struct xlog_ticket	*tic;
+	struct xlog_ticket	*tic, *next;
 	int			need_bytes;
 
-	list_for_each_entry(tic, &head->waiters, t_queue) {
+	list_for_each_entry_safe(tic, next, &head->waiters, t_queue) {
 		need_bytes = xlog_ticket_reservation(log, head, tic);
 		if (*free_bytes < need_bytes)
 			return false;
 
 		*free_bytes -= need_bytes;
 		trace_xfs_log_grant_wake_up(log, tic);
-		wake_up_process(tic->t_task);
+		wake_q_add(wakeq, tic->t_task);
+		list_del_init(&tic->t_queue);
 	}
 
 	return true;
@@ -247,13 +251,14 @@
 	int			need_bytes) __releases(&head->lock)
 					    __acquires(&head->lock)
 {
-	list_add_tail(&tic->t_queue, &head->waiters);
-
 	do {
+		list_add_tail(&tic->t_queue, &head->waiters);
+
 		if (XLOG_FORCED_SHUTDOWN(log))
 			goto shutdown;
 		xlog_grant_push_ail(log, need_bytes);
 
+sleep:
 		__set_current_state(TASK_UNINTERRUPTIBLE);
 		spin_unlock(&head->lock);
 
@@ -264,11 +269,18 @@
 		trace_xfs_log_grant_wake(log, tic);
 
 		spin_lock(&head->lock);
+
+		/*
+		 * The current task should have been dequeued from the
+		 * list before it is waken up.
+		 */
+		if (unlikely(!list_empty(&tic->t_queue)))
+			goto sleep;
+
 		if (XLOG_FORCED_SHUTDOWN(log))
 			goto shutdown;
 	} while (xlog_space_left(log, &head->grant) < need_bytes);
 
-	list_del_init(&tic->t_queue);
 	return 0;
 shutdown:
 	list_del_init(&tic->t_queue);
@@ -301,6 +313,7 @@
 {
 	int			free_bytes;
 	int			error = 0;
+	DEFINE_WAKE_Q(wakeq);
 
 	ASSERT(!(log->l_flags & XLOG_ACTIVE_RECOVERY));
 
@@ -313,9 +326,16 @@
 	*need_bytes = xlog_ticket_reservation(log, head, tic);
 	free_bytes = xlog_space_left(log, &head->grant);
 	if (!list_empty_careful(&head->waiters)) {
+		bool wake_all;
+
 		spin_lock(&head->lock);
-		if (!xlog_grant_head_wake(log, head, &free_bytes) ||
-		    free_bytes < *need_bytes) {
+		wake_all = xlog_grant_head_wake(log, head, &free_bytes, &wakeq);
+		if (!wake_q_empty(&wakeq)) {
+			spin_unlock(&head->lock);
+			wake_up_q(&wakeq);
+			spin_lock(&head->lock);
+		}
+		if (!wake_all || free_bytes < *need_bytes) {
 			error = xlog_grant_head_wait(log, head, tic,
 						     *need_bytes);
 		}
@@ -1068,6 +1088,7 @@
 {
 	struct xlog		*log = mp->m_log;
 	int			free_bytes;
+	DEFINE_WAKE_Q(wakeq);
 
 	if (XLOG_FORCED_SHUTDOWN(log))
 		return;
@@ -1077,8 +1098,11 @@
 
 		spin_lock(&log->l_write_head.lock);
 		free_bytes = xlog_space_left(log, &log->l_write_head.grant);
-		xlog_grant_head_wake(log, &log->l_write_head, &free_bytes);
+		xlog_grant_head_wake(log, &log->l_write_head, &free_bytes,
+				     &wakeq);
 		spin_unlock(&log->l_write_head.lock);
+		wake_up_q(&wakeq);
+		wake_q_init(&wakeq);
 	}
 
 	if (!list_empty_careful(&log->l_reserve_head.waiters)) {
@@ -1086,8 +1110,10 @@
 
 		spin_lock(&log->l_reserve_head.lock);
 		free_bytes = xlog_space_left(log, &log->l_reserve_head.grant);
-		xlog_grant_head_wake(log, &log->l_reserve_head, &free_bytes);
+		xlog_grant_head_wake(log, &log->l_reserve_head, &free_bytes,
+				     &wakeq);
 		spin_unlock(&log->l_reserve_head.lock);
+		wake_up_q(&wakeq);
 	}
 }
 
-- 
1.8.3.1

