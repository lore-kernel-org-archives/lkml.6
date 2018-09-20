Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D02ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1CC2152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DuU9Zi2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1CC2152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387453AbeITP7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:59:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39806 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730654AbeITP7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:59:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8KAELSD069248;
        Thu, 20 Sep 2018 10:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=+evWuUa36LTRNnzPaQqRnLeyvL7xtt2aVrG6OpR2mVc=;
 b=DuU9Zi2YVfnlnhM6VZrJMZLxw8mV8HwnwjpqQX7eXwOP9uSuHCN2ztare5cy6h13/GMO
 F8WFDFxVYqceeKYNQaZSWpGv8QWOZI3vJZfvj2mjW7zwwXr6EnSC8Ix5Sl+wEodqQfqQ
 8HC9V0hMbEKtH/CpobNg9VbGfra3YPcaXkHAvH0rSq6JD8Az77waJ52JvK6WdvqzvQ71
 uCspbq/WAh8usIzqFwQmF/sIgC50RGTS5RFUscxRM1aFneYHQctfHklpSV8HpI9bno0o
 YjayaVb6u+PH9oAe8cKuJT/iuw2ZaxP/3JyyiOt72TwJctkQjphTpviZvr0UBqNDhuBe lQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2mgtqr9ru3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Sep 2018 10:16:40 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8KAGXpE032501
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Sep 2018 10:16:34 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8KAGXbt023972;
        Thu, 20 Sep 2018 10:16:33 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Sep 2018 03:16:32 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk, tj@kernel.org, kent.overstreet@gmail.com,
        ming.lei@redhat.com, bart.vanassche@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] blk-core: rework the queue freeze
Date:   Thu, 20 Sep 2018 18:18:22 +0800
Message-Id: <1537438703-25217-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9021 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809200105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous queue freeze depends on the percpu_ref_kill/reinit.
But the limit is that we have to drain the q_usage_counter when
unfreeze the queue.

To improve this, we implement our own condition checking, namely
queue_gate, instead of depending on the __PERCPU_REF_DEAD. Then
put both the checking on queue_gate and __percpu_ref_get_many
under sched rcu lock. At the same time, switch the percpu ref mode
between atomic and percpu with percpu_ref_switch_to_atomic/percpu.

After this, introduce the BLK_QUEUE_GATE_FROZEN on queue_gate to
implement queue freeze feature. Then we could unfreeze the queue
anytime without drain the queue.

In addition, this fashion will be convinient to implement other
condition checking, such as preempt-only mode.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-core.c        | 28 +++++++++++++++++-----------
 block/blk-mq.c          |  8 ++++++--
 block/blk.h             |  4 ++++
 drivers/scsi/scsi_lib.c |  2 +-
 include/linux/blkdev.h  |  2 ++
 5 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index dee56c2..f8b8fe2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -910,6 +910,18 @@ struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
+static inline bool blk_queue_gate_allow(struct request_queue *q,
+		blk_mq_req_flags_t flags)
+{
+	if (likely(!q->queue_gate))
+		return true;
+
+	if (test_bit(BLK_QUEUE_GATE_FROZEN, &q->queue_gate))
+		return false;
+
+	return true;
+}
+
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
@@ -922,8 +934,9 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 	while (true) {
 		bool success = false;
 
-		rcu_read_lock();
-		if (percpu_ref_tryget_live(&q->q_usage_counter)) {
+		rcu_read_lock_sched();
+		if (blk_queue_gate_allow(q, flags)) {
+			__percpu_ref_get_many(&q->q_usage_counter, 1);
 			/*
 			 * The code that sets the PREEMPT_ONLY flag is
 			 * responsible for ensuring that that flag is globally
@@ -935,7 +948,7 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 				percpu_ref_put(&q->q_usage_counter);
 			}
 		}
-		rcu_read_unlock();
+		rcu_read_unlock_sched();
 
 		if (success)
 			return 0;
@@ -943,17 +956,10 @@ int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 		if (flags & BLK_MQ_REQ_NOWAIT)
 			return -EBUSY;
 
-		/*
-		 * read pair of barrier in blk_freeze_queue_start(),
-		 * we need to order reading __PERCPU_REF_DEAD flag of
-		 * .q_usage_counter and reading .mq_freeze_depth or
-		 * queue dying flag, otherwise the following wait may
-		 * never return if the two reads are reordered.
-		 */
 		smp_rmb();
 
 		wait_event(q->mq_freeze_wq,
-			   (atomic_read(&q->mq_freeze_depth) == 0 &&
+			   (blk_queue_gate_allow(q, flags) &&
 			    (preempt || !blk_queue_preempt_only(q))) ||
 			   blk_queue_dying(q));
 		if (blk_queue_dying(q))
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 85a1c1a..fc90ad3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -140,7 +140,9 @@ void blk_freeze_queue_start(struct request_queue *q)
 
 	freeze_depth = atomic_inc_return(&q->mq_freeze_depth);
 	if (freeze_depth == 1) {
-		percpu_ref_kill(&q->q_usage_counter);
+		set_bit(BLK_QUEUE_GATE_FROZEN, &q->queue_gate);
+		percpu_ref_put(&q->q_usage_counter);
+		percpu_ref_switch_to_atomic(&q->q_usage_counter, NULL);
 		if (q->mq_ops)
 			blk_mq_run_hw_queues(q, false);
 	}
@@ -198,7 +200,9 @@ void blk_mq_unfreeze_queue(struct request_queue *q)
 	freeze_depth = atomic_dec_return(&q->mq_freeze_depth);
 	WARN_ON_ONCE(freeze_depth < 0);
 	if (!freeze_depth) {
-		percpu_ref_reinit(&q->q_usage_counter);
+		clear_bit(BLK_QUEUE_GATE_FROZEN, &q->queue_gate);
+		percpu_ref_get(&q->q_usage_counter);
+		percpu_ref_switch_to_percpu(&q->q_usage_counter);
 		wake_up_all(&q->mq_freeze_wq);
 	}
 }
diff --git a/block/blk.h b/block/blk.h
index 9db4e38..19d2c00 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -19,6 +19,10 @@
 extern struct dentry *blk_debugfs_root;
 #endif
 
+enum blk_queue_gate_flag_t {
+	BLK_QUEUE_GATE_FROZEN,
+};
+
 struct blk_flush_queue {
 	unsigned int		flush_queue_delayed:1;
 	unsigned int		flush_pending_idx:1;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0adfb3b..1980648 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3066,7 +3066,7 @@ scsi_device_quiesce(struct scsi_device *sdev)
 	 * unfreeze even if the queue was already frozen before this function
 	 * was called. See also https://lwn.net/Articles/573497/.
 	 */
-	synchronize_rcu();
+	synchronize_sched();
 	blk_mq_unfreeze_queue(q);
 
 	mutex_lock(&sdev->state_mutex);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d6869e0..9f3f0d7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -647,6 +647,8 @@ struct request_queue {
 	struct rcu_head		rcu_head;
 	wait_queue_head_t	mq_freeze_wq;
 	struct percpu_ref	q_usage_counter;
+	unsigned long		queue_gate;
+
 	struct list_head	all_q_node;
 
 	struct blk_mq_tag_set	*tag_set;
-- 
2.7.4

