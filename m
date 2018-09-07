Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1187BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CF32075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CF32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeIGVDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:03:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726655AbeIGVDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:03:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A55EE80823E3;
        Fri,  7 Sep 2018 16:21:23 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BA302027EA0;
        Fri,  7 Sep 2018 16:21:13 +0000 (UTC)
Date:   Sat, 8 Sep 2018 00:21:08 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, jsmart2021@gmail.com,
        sagi@grimberg.me, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        jthumshirn@suse.de, bart.vanassche@wdc.com,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/3] Introduce a light-weight queue close feature
Message-ID: <20180907162107.GA9056@ming.t460p>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180905212659.GB21352@ming.t460p>
 <b7074098-ab79-53b2-5cc6-25f859c4c666@oracle.com>
 <20180906125659.GA31250@ming.t460p>
 <51b4019b-8773-b76d-ee00-4399a86dbf16@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b4019b-8773-b76d-ee00-4399a86dbf16@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 07 Sep 2018 16:21:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 07 Sep 2018 16:21:23 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 09:55:21PM +0800, jianchao.wang wrote:
> 
> 
> On 09/06/2018 08:57 PM, Ming Lei wrote:
> > On Thu, Sep 06, 2018 at 09:51:43AM +0800, jianchao.wang wrote:
> >> Hi Ming
> >>
> >> On 09/06/2018 05:27 AM, Ming Lei wrote:
> >>> On Wed, Sep 05, 2018 at 12:09:43PM +0800, Jianchao Wang wrote:
> >>>> Dear all
> >>>>
> >>>> As we know, queue freeze is used to stop new IO comming in and drain
> >>>> the request queue. And the draining queue here is necessary, because
> >>>> queue freeze kills the percpu-ref q_usage_counter and need to drain
> >>>> the q_usage_counter before switch it back to percpu mode. This could
> >>>> be a trouble when we just want to prevent new IO.
> >>>>
> >>>> In nvme-pci, nvme_dev_disable freezes queues to prevent new IO.
> >>>> nvme_reset_work will unfreeze and wait to drain the queues. However,
> >>>> if IO timeout at the moment, no body could do recovery as nvme_reset_work
> >>>> is waiting. We will encounter IO hang.
> >>>
> >>> As we discussed this nvme time issue before, I have pointed out that
> >>> this is because of blk_mq_unfreeze_queue()'s limit which requires that
> >>> unfreeze can only be done when this queue ref counter drops to zero.
> >>>
> >>> For this nvme timeout case, we may relax the limit, for example,
> >>> introducing another API of blk_freeze_queue_stop() as counter-pair of
> >>> blk_freeze_queue_start(), and simply switch the percpu-ref to percpu mode
> >>> from atomic mode inside the new API.
> >>
> >> Looks like we cannot switch a percpu-ref to percpu mode directly w/o drain it.
> >> Some references maybe lost.
> >>
> >> static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
> >> {
> >> 	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
> >> 	int cpu;
> >>
> >> 	BUG_ON(!percpu_count);
> >>
> >> 	if (!(ref->percpu_count_ptr & __PERCPU_REF_ATOMIC))
> >> 		return;
> >>
> >> 	atomic_long_add(PERCPU_COUNT_BIAS, &ref->count);
> >>
> >> 	/*
> >> 	 * Restore per-cpu operation.  smp_store_release() is paired
> >> 	 * with READ_ONCE() in __ref_is_percpu() and guarantees that the
> >> 	 * zeroing is visible to all percpu accesses which can see the
> >> 	 * following __PERCPU_REF_ATOMIC clearing.i
> >> 	 */
> >> 	for_each_possible_cpu(cpu)
> >> 		*per_cpu_ptr(percpu_count, cpu) = 0;
> >>
> >> 	smp_store_release(&ref->percpu_count_ptr,
> >> 			  ref->percpu_count_ptr & ~__PERCPU_REF_ATOMIC);
> > 
> > Before REF_ATOMIC is cleared, all counting is done on the atomic type
> > of &ref->count, and it is easy to keep the reference counter at
> > ATOMIC mode. Also the reference counter can only be READ at atomic mode.
> > 
> > So could you explain a bit how the lost may happen? And it is lost at
> > atomic mode or percpu mode?
> 
> I just mean __percpu_ref_switch_percpu just zeros the percpu_count.
> It doesn't give the original values back to the percpu_count from atomic count

The original value has been added to the atomic part of the refcount,
please see percpu_ref_switch_to_atomic_rcu(), so zeroing is fine.

What do you think of the following patch? Which will allow to reinit one
percpu_refcount from atomic mode when it doesn't drop to zero.

--
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 85a1c1a59c72..c05d8924b4cb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -134,19 +134,33 @@ void blk_mq_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight_rw, &mi);
 }
 
-void blk_freeze_queue_start(struct request_queue *q)
+static void __blk_freeze_queue_start(struct request_queue *q, bool kill_sync)
 {
 	int freeze_depth;
 
 	freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
 	if (freeze_depth == 1) {
-		percpu_ref_kill(&q->q_usage_counter);
+		if (kill_sync)
+			percpu_ref_kill_sync(&q->q_usage_counter);
+		else
+			percpu_ref_kill(&q->q_usage_counter);
 		if (q->mq_ops)
 			blk_mq_run_hw_queues(q, false);
 	}
 }
+
+void blk_freeze_queue_start(struct request_queue *q)
+{
+	__blk_freeze_queue_start(q, false);
+}
 EXPORT_SYMBOL_GPL(blk_freeze_queue_start);
 
+void blk_freeze_queue_start_sync(struct request_queue *q)
+{
+	__blk_freeze_queue_start(q, true);
+}
+EXPORT_SYMBOL_GPL(blk_freeze_queue_start_sync);
+
 void blk_mq_freeze_queue_wait(struct request_queue *q)
 {
 	wait_event(q->mq_freeze_wq, percpu_ref_is_zero(&q->q_usage_counter));
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd8ec1dd9219..bde5a054597d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3644,7 +3644,7 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_freeze_queue_start(ns->queue);
+		blk_freeze_queue_start_sync(ns->queue);
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d668682f91df..7b9ac1f9bce3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2328,7 +2328,6 @@ static void nvme_reset_work(struct work_struct *work)
 		new_state = NVME_CTRL_ADMIN_ONLY;
 	} else {
 		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
 		/* hit this only when allocate tagset fails */
 		if (nvme_dev_add(dev))
 			new_state = NVME_CTRL_ADMIN_ONLY;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1da59c16f637..5cf8e3a6335c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -280,6 +280,7 @@ void blk_mq_tagset_busy_iter(struct blk_mq_tag_set *tagset,
 void blk_mq_freeze_queue(struct request_queue *q);
 void blk_mq_unfreeze_queue(struct request_queue *q);
 void blk_freeze_queue_start(struct request_queue *q);
+void blk_freeze_queue_start_sync(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 009cdf3d65b6..36f4428b2a6c 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -127,6 +127,8 @@ static inline void percpu_ref_kill(struct percpu_ref *ref)
 	percpu_ref_kill_and_confirm(ref, NULL);
 }
 
+extern void percpu_ref_kill_sync(struct percpu_ref *ref);
+
 /*
  * Internal helper.  Don't use outside percpu-refcount proper.  The
  * function doesn't return the pointer and let the caller test it for NULL
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 9f96fa7bc000..4c0ee5eda2d6 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -130,8 +130,10 @@ static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
 	unsigned long count = 0;
 	int cpu;
 
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		count += *per_cpu_ptr(percpu_count, cpu);
+		*per_cpu_ptr(percpu_count, cpu) = 0;
+	}
 
 	pr_debug("global %ld percpu %ld",
 		 atomic_long_read(&ref->count), (long)count);
@@ -187,7 +189,6 @@ static void __percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 {
 	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
-	int cpu;
 
 	BUG_ON(!percpu_count);
 
@@ -196,15 +197,6 @@ static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 
 	atomic_long_add(PERCPU_COUNT_BIAS, &ref->count);
 
-	/*
-	 * Restore per-cpu operation.  smp_store_release() is paired
-	 * with READ_ONCE() in __ref_is_percpu() and guarantees that the
-	 * zeroing is visible to all percpu accesses which can see the
-	 * following __PERCPU_REF_ATOMIC clearing.
-	 */
-	for_each_possible_cpu(cpu)
-		*per_cpu_ptr(percpu_count, cpu) = 0;
-
 	smp_store_release(&ref->percpu_count_ptr,
 			  ref->percpu_count_ptr & ~__PERCPU_REF_ATOMIC);
 }
@@ -278,6 +270,23 @@ void percpu_ref_switch_to_atomic_sync(struct percpu_ref *ref)
 EXPORT_SYMBOL_GPL(percpu_ref_switch_to_atomic_sync);
 
 /**
+ * percpu_ref_kill_sync - drop the initial ref and and wait for the
+ * switch to complete.
+ * @ref: percpu_ref to kill
+ *
+ * Must be used to drop the initial ref on a percpu refcount; must be called
+ * precisely once before shutdown.
+ *
+ * Switches @ref into atomic mode before gathering up the percpu counters
+ * and dropping the initial ref.
+ */
+void percpu_ref_kill_sync(struct percpu_ref *ref)
+{
+	percpu_ref_kill(ref);
+	wait_event(percpu_ref_switch_waitq, !ref->confirm_switch);
+}
+
+/**
  * percpu_ref_switch_to_percpu - switch a percpu_ref to percpu mode
  * @ref: percpu_ref to switch to percpu mode
  *
@@ -349,7 +358,7 @@ EXPORT_SYMBOL_GPL(percpu_ref_kill_and_confirm);
  *
  * Re-initialize @ref so that it's in the same state as when it finished
  * percpu_ref_init() ignoring %PERCPU_REF_INIT_DEAD.  @ref must have been
- * initialized successfully and reached 0 but not exited.
+ * initialized successfully and in atomic mode but not exited.
  *
  * Note that percpu_ref_tryget[_live]() are safe to perform on @ref while
  * this function is in progress.
@@ -357,10 +366,11 @@ EXPORT_SYMBOL_GPL(percpu_ref_kill_and_confirm);
 void percpu_ref_reinit(struct percpu_ref *ref)
 {
 	unsigned long flags;
+	unsigned long __percpu *percpu_count;
 
 	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
 
-	WARN_ON_ONCE(!percpu_ref_is_zero(ref));
+	WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
 
 	ref->percpu_count_ptr &= ~__PERCPU_REF_DEAD;
 	percpu_ref_get(ref);

Thanks,
Ming
