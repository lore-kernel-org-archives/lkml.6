Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50374C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E806214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E806214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbeHVNN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:13:26 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:53988 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbeHVNNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:13:25 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fsPlJ-0007Qa-D8; Wed, 22 Aug 2018 11:49:13 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        Byungchul Park <byungchul.park@lge.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 1/2] workqueue: skip lockdep wq dependency in cancel_work_sync()
Date:   Wed, 22 Aug 2018 11:49:03 +0200
Message-Id: <20180822094904.15718-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180822094904.15718-1-johannes@sipsolutions.net>
References: <20180822094904.15718-1-johannes@sipsolutions.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In cancel_work_sync(), we can only have one of two cases, even
with an ordered workqueue:
 * the work isn't running, just cancelled before it started
 * the work is running, but then nothing else can be on the
   workqueue before it

Thus, we need to skip the lockdep workqueue dependency handling,
otherwise we get false positive reports from lockdep saying that
we have a potential deadlock when the workqueue also has other
work items with locking, e.g.

  work1_function() { mutex_lock(&mutex); ... }
  work2_function() { /* nothing */ }

  other_function() {
    queue_work(ordered_wq, &work1);
    queue_work(ordered_wq, &work2);
    mutex_lock(&mutex);
    cancel_work_sync(&work2);
  }

As described above, this isn't a problem, but lockdep will
currently flag it as if cancel_work_sync() was flush_work(),
which *is* a problem.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 kernel/workqueue.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 78b192071ef7..a6c2b823f348 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2843,7 +2843,8 @@ void drain_workqueue(struct workqueue_struct *wq)
 }
 EXPORT_SYMBOL_GPL(drain_workqueue);
 
-static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr)
+static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
+			     bool from_cancel)
 {
 	struct worker *worker = NULL;
 	struct worker_pool *pool;
@@ -2885,7 +2886,8 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr)
 	 * workqueues the deadlock happens when the rescuer stalls, blocking
 	 * forward progress.
 	 */
-	if (pwq->wq->saved_max_active == 1 || pwq->wq->rescuer) {
+	if (!from_cancel &&
+	    (pwq->wq->saved_max_active == 1 || pwq->wq->rescuer)) {
 		lock_map_acquire(&pwq->wq->lockdep_map);
 		lock_map_release(&pwq->wq->lockdep_map);
 	}
@@ -2896,6 +2898,22 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr)
 	return false;
 }
 
+static bool __flush_work(struct work_struct *work, bool from_cancel)
+{
+	struct wq_barrier barr;
+
+	if (WARN_ON(!wq_online))
+		return false;
+
+	if (start_flush_work(work, &barr, from_cancel)) {
+		wait_for_completion(&barr.done);
+		destroy_work_on_stack(&barr.work);
+		return true;
+	} else {
+		return false;
+	}
+}
+
 /**
  * flush_work - wait for a work to finish executing the last queueing instance
  * @work: the work to flush
@@ -2909,18 +2927,7 @@ static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr)
  */
 bool flush_work(struct work_struct *work)
 {
-	struct wq_barrier barr;
-
-	if (WARN_ON(!wq_online))
-		return false;
-
-	if (start_flush_work(work, &barr)) {
-		wait_for_completion(&barr.done);
-		destroy_work_on_stack(&barr.work);
-		return true;
-	} else {
-		return false;
-	}
+	return __flush_work(work, false);
 }
 EXPORT_SYMBOL_GPL(flush_work);
 
@@ -2986,7 +2993,7 @@ static bool __cancel_work_timer(struct work_struct *work, bool is_dwork)
 	 * isn't executing.
 	 */
 	if (wq_online)
-		flush_work(work);
+		__flush_work(work, true);
 
 	clear_work_data(work);
 
-- 
2.14.4

