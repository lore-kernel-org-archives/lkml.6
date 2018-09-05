Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC95C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B96720861
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B96720861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeIEQ7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:59:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbeIEQ6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:58:40 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9B9B2087C;
        Wed,  5 Sep 2018 12:28:37 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fxWvF-0002E2-13; Wed, 05 Sep 2018 08:28:37 -0400
Message-Id: <20180905122836.928502373@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Sep 2018 08:28:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: [PATCH RT 16/22] crypto: cryptd - add a lock instead preempt_disable/local_bh_disable
References: <20180905122754.443196118@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.63-rt41-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 21aedb30d85979697f79a72a084e5d781e323663 ]

cryptd has a per-CPU lock which protected with local_bh_disable() and
preempt_disable().
Add an explicit spin_lock to make the locking context more obvious and
visible to lockdep. Since it is a per-CPU lock, there should be no lock
contention on the actual spinlock.
There is a small race-window where we could be migrated to another CPU
after the cpu_queue has been obtain. This is not a problem because the
actual ressource is protected by the spinlock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 crypto/cryptd.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/crypto/cryptd.c b/crypto/cryptd.c
index 248f6ba41688..54b7985c8caa 100644
--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -37,6 +37,7 @@
 struct cryptd_cpu_queue {
 	struct crypto_queue queue;
 	struct work_struct work;
+	spinlock_t qlock;
 };
 
 struct cryptd_queue {
@@ -115,6 +116,7 @@ static int cryptd_init_queue(struct cryptd_queue *queue,
 		cpu_queue = per_cpu_ptr(queue->cpu_queue, cpu);
 		crypto_init_queue(&cpu_queue->queue, max_cpu_qlen);
 		INIT_WORK(&cpu_queue->work, cryptd_queue_worker);
+		spin_lock_init(&cpu_queue->qlock);
 	}
 	return 0;
 }
@@ -139,8 +141,10 @@ static int cryptd_enqueue_request(struct cryptd_queue *queue,
 	atomic_t *refcnt;
 	bool may_backlog;
 
-	cpu = get_cpu();
-	cpu_queue = this_cpu_ptr(queue->cpu_queue);
+	cpu_queue = raw_cpu_ptr(queue->cpu_queue);
+	spin_lock_bh(&cpu_queue->qlock);
+	cpu = smp_processor_id();
+
 	err = crypto_enqueue_request(&cpu_queue->queue, request);
 
 	refcnt = crypto_tfm_ctx(request->tfm);
@@ -157,7 +161,7 @@ static int cryptd_enqueue_request(struct cryptd_queue *queue,
 	atomic_inc(refcnt);
 
 out_put_cpu:
-	put_cpu();
+	spin_unlock_bh(&cpu_queue->qlock);
 
 	return err;
 }
@@ -173,16 +177,11 @@ static void cryptd_queue_worker(struct work_struct *work)
 	cpu_queue = container_of(work, struct cryptd_cpu_queue, work);
 	/*
 	 * Only handle one request at a time to avoid hogging crypto workqueue.
-	 * preempt_disable/enable is used to prevent being preempted by
-	 * cryptd_enqueue_request(). local_bh_disable/enable is used to prevent
-	 * cryptd_enqueue_request() being accessed from software interrupts.
 	 */
-	local_bh_disable();
-	preempt_disable();
+	spin_lock_bh(&cpu_queue->qlock);
 	backlog = crypto_get_backlog(&cpu_queue->queue);
 	req = crypto_dequeue_request(&cpu_queue->queue);
-	preempt_enable();
-	local_bh_enable();
+	spin_unlock_bh(&cpu_queue->qlock);
 
 	if (!req)
 		return;
-- 
2.18.0


