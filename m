Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135CCC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC8A20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDC8A20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbeIMTCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:02:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33634 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730002AbeIMTCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:02:41 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0E46CD19;
        Thu, 13 Sep 2018 13:53:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Tejun Heo <tj@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 049/197] workqueue: skip lockdep wq dependency in cancel_work_sync()
Date:   Thu, 13 Sep 2018 15:29:58 +0200
Message-Id: <20180913131843.501619084@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit d6e89786bed977f37f55ffca11e563f6d2b1e3b5 ]

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
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/workqueue.c |   37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2843,7 +2843,8 @@ reflush:
 }
 EXPORT_SYMBOL_GPL(drain_workqueue);
 
-static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr)
+static bool start_flush_work(struct work_struct *work, struct wq_barrier *barr,
+			     bool from_cancel)
 {
 	struct worker *worker = NULL;
 	struct worker_pool *pool;
@@ -2885,7 +2886,8 @@ static bool start_flush_work(struct work
 	 * workqueues the deadlock happens when the rescuer stalls, blocking
 	 * forward progress.
 	 */
-	if (pwq->wq->saved_max_active == 1 || pwq->wq->rescuer) {
+	if (!from_cancel &&
+	    (pwq->wq->saved_max_active == 1 || pwq->wq->rescuer)) {
 		lock_map_acquire(&pwq->wq->lockdep_map);
 		lock_map_release(&pwq->wq->lockdep_map);
 	}
@@ -2896,6 +2898,22 @@ already_gone:
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
@@ -2909,18 +2927,7 @@ already_gone:
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
 
@@ -2986,7 +2993,7 @@ static bool __cancel_work_timer(struct w
 	 * isn't executing.
 	 */
 	if (wq_online)
-		flush_work(work);
+		__flush_work(work, true);
 
 	clear_work_data(work);
 


