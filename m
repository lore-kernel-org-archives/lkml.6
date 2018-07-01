Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E67EC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3E0255C3
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3E0255C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753822AbeGARLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:11:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37248 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031493AbeGAQkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:40:49 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5B8D2AA6;
        Sun,  1 Jul 2018 16:40:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Sebastian Sanchez <sebastian.sanchez@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.17 093/220] IB/hfi1: Optimize kthread pointer locking when queuing CQ entries
Date:   Sun,  1 Jul 2018 18:21:57 +0200
Message-Id: <20180701160912.298804652@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Sanchez <sebastian.sanchez@intel.com>

commit af8aab71370a692eaf7e7969ba5b1a455ac20113 upstream.

All threads queuing CQ entries on different CQs are unnecessarily
synchronized by a spin lock to check if the CQ kthread worker hasn't
been destroyed before queuing an CQ entry.

The lock used in 6efaf10f163d ("IB/rdmavt: Avoid queuing work into a
destroyed cq kthread worker") is a device global lock and will have
poor performance at scale as completions are entered from a large
number of CPUs.

Convert to use RCU where the read side of RCU is rvt_cq_enter() to
determine that the worker is alive prior to triggering the
completion event.
Apply write side RCU semantics in rvt_driver_cq_init() and
rvt_cq_exit().

Fixes: 6efaf10f163d ("IB/rdmavt: Avoid queuing work into a destroyed cq kthread worker")
Cc: <stable@vger.kernel.org> # 4.14.x
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Sebastian Sanchez <sebastian.sanchez@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/sw/rdmavt/cq.c |   31 +++++++++++++++++++------------
 include/rdma/rdma_vt.h            |    2 +-
 2 files changed, 20 insertions(+), 13 deletions(-)

--- a/drivers/infiniband/sw/rdmavt/cq.c
+++ b/drivers/infiniband/sw/rdmavt/cq.c
@@ -120,17 +120,20 @@ void rvt_cq_enter(struct rvt_cq *cq, str
 	if (cq->notify == IB_CQ_NEXT_COMP ||
 	    (cq->notify == IB_CQ_SOLICITED &&
 	     (solicited || entry->status != IB_WC_SUCCESS))) {
+		struct kthread_worker *worker;
+
 		/*
 		 * This will cause send_complete() to be called in
 		 * another thread.
 		 */
-		spin_lock(&cq->rdi->n_cqs_lock);
-		if (likely(cq->rdi->worker)) {
+		rcu_read_lock();
+		worker = rcu_dereference(cq->rdi->worker);
+		if (likely(worker)) {
 			cq->notify = RVT_CQ_NONE;
 			cq->triggered++;
-			kthread_queue_work(cq->rdi->worker, &cq->comptask);
+			kthread_queue_work(worker, &cq->comptask);
 		}
-		spin_unlock(&cq->rdi->n_cqs_lock);
+		rcu_read_unlock();
 	}
 
 	spin_unlock_irqrestore(&cq->lock, flags);
@@ -512,7 +515,7 @@ int rvt_driver_cq_init(struct rvt_dev_in
 	int cpu;
 	struct kthread_worker *worker;
 
-	if (rdi->worker)
+	if (rcu_access_pointer(rdi->worker))
 		return 0;
 
 	spin_lock_init(&rdi->n_cqs_lock);
@@ -524,7 +527,7 @@ int rvt_driver_cq_init(struct rvt_dev_in
 		return PTR_ERR(worker);
 
 	set_user_nice(worker->task, MIN_NICE);
-	rdi->worker = worker;
+	RCU_INIT_POINTER(rdi->worker, worker);
 	return 0;
 }
 
@@ -536,15 +539,19 @@ void rvt_cq_exit(struct rvt_dev_info *rd
 {
 	struct kthread_worker *worker;
 
-	/* block future queuing from send_complete() */
-	spin_lock_irq(&rdi->n_cqs_lock);
-	worker = rdi->worker;
+	if (!rcu_access_pointer(rdi->worker))
+		return;
+
+	spin_lock(&rdi->n_cqs_lock);
+	worker = rcu_dereference_protected(rdi->worker,
+					   lockdep_is_held(&rdi->n_cqs_lock));
 	if (!worker) {
-		spin_unlock_irq(&rdi->n_cqs_lock);
+		spin_unlock(&rdi->n_cqs_lock);
 		return;
 	}
-	rdi->worker = NULL;
-	spin_unlock_irq(&rdi->n_cqs_lock);
+	RCU_INIT_POINTER(rdi->worker, NULL);
+	spin_unlock(&rdi->n_cqs_lock);
+	synchronize_rcu();
 
 	kthread_destroy_worker(worker);
 }
--- a/include/rdma/rdma_vt.h
+++ b/include/rdma/rdma_vt.h
@@ -402,7 +402,7 @@ struct rvt_dev_info {
 	spinlock_t pending_lock; /* protect pending mmap list */
 
 	/* CQ */
-	struct kthread_worker *worker; /* per device cq worker */
+	struct kthread_worker __rcu *worker; /* per device cq worker */
 	u32 n_cqs_allocated;    /* number of CQs allocated for device */
 	spinlock_t n_cqs_lock; /* protect count of in use cqs */
 


