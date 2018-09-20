Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442FCC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA11E2152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lPQtLx33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA11E2152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732466AbeITP72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:59:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39718 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbeITP71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:59:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8KAEAbq069185;
        Thu, 20 Sep 2018 10:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=caQR3mcQVm0y+/BNMSplK3Ti+/fZfJbNdENNojzT3gg=;
 b=lPQtLx33llMyFw0Rw/VJIYq6EMYaHgy0e/zW1rkBqV66WiTgvzr355SJ8kG5TWlVbbCA
 0kaOmWOy6++HLHaQgR3+yc4MVhCkq4ycUwR/AktXBisk71cl1U0SdDiDJc+Pk4D0+B51
 mxi5z+JxMIGbUrAhWgUZ6bcoCNAZpYsqhezmV9kbZUpQJOm+jvDA5TICVUtxrUvqOpXD
 hU7EC8BWPRdDNasgGeOgJ4ZkdqNtUR1AdzrpSkFcETCdCao9it5V4O7eCRM+hUsRN/n3
 0YwqSzp/4WAXPxk2mp2Driet3WPxuHT3ba1gNb2JkWQYfzVg2bIJ/PIOy4bXu2fU/yPc gg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mgtqr9rty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Sep 2018 10:16:37 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8KAGaE1017303
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Sep 2018 10:16:36 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8KAGZUH023984;
        Thu, 20 Sep 2018 10:16:35 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Sep 2018 03:16:35 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk, tj@kernel.org, kent.overstreet@gmail.com,
        ming.lei@redhat.com, bart.vanassche@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] block, scsi: rework the preempt only mode
Date:   Thu, 20 Sep 2018 18:18:23 +0800
Message-Id: <1537438703-25217-4-git-send-email-jianchao.w.wang@oracle.com>
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

Migrate preempt-only mode from queue_flags to queue_gate. Because
the queue_gate checking and __percpu_ref_get_many are under the
same sched rcu critical section, we don't need extra synchronize_sched
after blk_mq_freeze_queue any more.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-core.c        | 32 ++++++++++----------------------
 block/blk-mq-debugfs.c  |  1 -
 block/blk.h             |  1 +
 drivers/scsi/scsi_lib.c | 12 ++++--------
 include/linux/blkdev.h  |  3 ---
 5 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f8b8fe2..c8d642a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -429,13 +429,13 @@ EXPORT_SYMBOL(blk_sync_queue);
  */
 int blk_set_preempt_only(struct request_queue *q)
 {
-	return blk_queue_flag_test_and_set(QUEUE_FLAG_PREEMPT_ONLY, q);
+	return test_and_set_bit(BLK_QUEUE_GATE_PREEMPT_ONLY, &q->queue_gate);
 }
 EXPORT_SYMBOL_GPL(blk_set_preempt_only);
 
 void blk_clear_preempt_only(struct request_queue *q)
 {
-	blk_queue_flag_clear(QUEUE_FLAG_PREEMPT_ONLY, q);
+	clear_bit(BLK_QUEUE_GATE_PREEMPT_ONLY, &q->queue_gate);
 	wake_up_all(&q->mq_freeze_wq);
 }
 EXPORT_SYMBOL_GPL(blk_clear_preempt_only);
@@ -919,6 +919,10 @@ static inline bool blk_queue_gate_allow(struct request_queue *q,
 	if (test_bit(BLK_QUEUE_GATE_FROZEN, &q->queue_gate))
 		return false;
 
+	if (test_bit(BLK_QUEUE_GATE_PREEMPT_ONLY, &q->queue_gate) &&
+			!(flags & BLK_MQ_REQ_PREEMPT))
+		return false;
+
 	return true;
 }
 
@@ -929,39 +933,23 @@ static inline bool blk_queue_gate_allow(struct request_queue *q,
  */
 int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
 {
-	const bool preempt = flags & BLK_MQ_REQ_PREEMPT;
-
 	while (true) {
-		bool success = false;
-
 		rcu_read_lock_sched();
 		if (blk_queue_gate_allow(q, flags)) {
 			__percpu_ref_get_many(&q->q_usage_counter, 1);
-			/*
-			 * The code that sets the PREEMPT_ONLY flag is
-			 * responsible for ensuring that that flag is globally
-			 * visible before the queue is unfrozen.
-			 */
-			if (preempt || !blk_queue_preempt_only(q)) {
-				success = true;
-			} else {
-				percpu_ref_put(&q->q_usage_counter);
-			}
+			rcu_read_unlock_sched();
+			return 0;
 		}
 		rcu_read_unlock_sched();
 
-		if (success)
-			return 0;
-
 		if (flags & BLK_MQ_REQ_NOWAIT)
 			return -EBUSY;
 
 		smp_rmb();
 
 		wait_event(q->mq_freeze_wq,
-			   (blk_queue_gate_allow(q, flags) &&
-			    (preempt || !blk_queue_preempt_only(q))) ||
-			   blk_queue_dying(q));
+				blk_queue_gate_allow(q, flags) ||
+				blk_queue_dying(q));
 		if (blk_queue_dying(q))
 			return -ENODEV;
 	}
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index cb1e6cf..4174951 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -132,7 +132,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(REGISTERED),
 	QUEUE_FLAG_NAME(SCSI_PASSTHROUGH),
 	QUEUE_FLAG_NAME(QUIESCED),
-	QUEUE_FLAG_NAME(PREEMPT_ONLY),
 };
 #undef QUEUE_FLAG_NAME
 
diff --git a/block/blk.h b/block/blk.h
index 19d2c00..e38060b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -21,6 +21,7 @@ extern struct dentry *blk_debugfs_root;
 
 enum blk_queue_gate_flag_t {
 	BLK_QUEUE_GATE_FROZEN,
+	BLK_QUEUE_GATE_PREEMPT_ONLY,
 };
 
 struct blk_flush_queue {
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 1980648..3c9c33a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3058,17 +3058,13 @@ scsi_device_quiesce(struct scsi_device *sdev)
 	WARN_ON_ONCE(sdev->quiesced_by && sdev->quiesced_by != current);
 
 	blk_set_preempt_only(q);
-
 	blk_mq_freeze_queue(q);
+	blk_mq_unfreeze_queue(q);
 	/*
-	 * Ensure that the effect of blk_set_preempt_only() will be visible
-	 * for percpu_ref_tryget() callers that occur after the queue
-	 * unfreeze even if the queue was already frozen before this function
-	 * was called. See also https://lwn.net/Articles/573497/.
+	 * When we reach here:
+	 *  - PREEMPT_ONLY gate flag is globally visible
+	 *  - no non-preempt request in queue
 	 */
-	synchronize_sched();
-	blk_mq_unfreeze_queue(q);
-
 	mutex_lock(&sdev->state_mutex);
 	err = scsi_device_set_state(sdev, SDEV_QUIESCE);
 	if (err == 0)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9f3f0d7..caa73b8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -700,7 +700,6 @@ struct request_queue {
 #define QUEUE_FLAG_REGISTERED  26	/* queue has been registered to a disk */
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED    28	/* queue has been quiesced */
-#define QUEUE_FLAG_PREEMPT_ONLY	29	/* only process REQ_PREEMPT requests */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
@@ -738,8 +737,6 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
 			     REQ_FAILFAST_DRIVER))
 #define blk_queue_quiesced(q)	test_bit(QUEUE_FLAG_QUIESCED, &(q)->queue_flags)
-#define blk_queue_preempt_only(q)				\
-	test_bit(QUEUE_FLAG_PREEMPT_ONLY, &(q)->queue_flags)
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
 
 extern int blk_set_preempt_only(struct request_queue *q);
-- 
2.7.4

