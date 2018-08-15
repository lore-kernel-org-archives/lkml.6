Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907A9C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4010C215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LhsCHhgf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4010C215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeHOKO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 06:14:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36666 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeHOKOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 06:14:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7F7Nmr6184661;
        Wed, 15 Aug 2018 07:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=40yAeL1Sy/vJ8SZKgYeDWKUEKmX3DNo2pQDTae1ZcDQ=;
 b=LhsCHhgfygGE+Eo5jPoqeFyTsWIWjNcC1oCLAk72PfIZFIeF3DXVo+AvyOcfwRBRpasP
 Y6KLoXANuI8PvNsoixWDrb3ZUQVP3mDRfCh3HldWn7EgczD++319XYnkvV11UBk0kVwS
 FB8wJkQCJShjpKQrOHN+0zeWp3zEOiyVmUGkWb/ouAjne2xyCL0OASyaEbGFOgoGeoWK
 2CUi/6jISeQLwW1chD1sr/rBRU0wVVpXj5DCOxeUZjOZVwmIcxROaZDEGF/PZRVifbm4
 HzaeoSDnsHLYVSXeSNNcnFgxetF1CMGQNDR13O6Ml4grK/NT//bOA5GOAXCcD48i9c4j 9g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2ksqrpbdqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 07:23:51 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7F7NnbP002628
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Aug 2018 07:23:50 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7F7NnWV006228;
        Wed, 15 Aug 2018 07:23:49 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Aug 2018 00:23:48 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     tom.leiming@gmail.com, bart.vanassche@wdc.com,
        keith.busch@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] blk-mq: init hctx sched after update cpu & nr_hw_queues mapping
Date:   Wed, 15 Aug 2018 15:25:14 +0800
Message-Id: <1534317915-5041-2-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8985 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808150081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kyber depends on the mapping between cpu and nr_hw_queues. When
update nr_hw_queues, elevator_type->ops.mq.init_hctx will be
invoked before the mapping is adapted correctly, this would cause
terrible result. A simply way to fix this is switch the io scheduler
to none before update the nr_hw_queues, and then get it back after
update nr_hw_queues. To achieve this, we add a new member elv_type
in request_queue to save the original elevator and adapt and export
elevator_switch_mq.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c         | 37 +++++++++++++++++++++++++++++--------
 block/blk.h            |  2 ++
 block/elevator.c       | 20 ++++++++++++--------
 include/linux/blkdev.h |  3 +++
 4 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5efd789..89904cc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -112,6 +112,7 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
 	struct mq_inflight mi = { .part = part, .inflight = inflight, };
 
 	inflight[0] = inflight[1] = 0;
+
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
 }
 
@@ -2147,8 +2148,6 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 	if (set->ops->exit_request)
 		set->ops->exit_request(set, hctx->fq->flush_rq, hctx_idx);
 
-	blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
-
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
 
@@ -2216,12 +2215,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
 		goto free_bitmap;
 
-	if (blk_mq_sched_init_hctx(q, hctx, hctx_idx))
-		goto exit_hctx;
-
 	hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size);
 	if (!hctx->fq)
-		goto sched_exit_hctx;
+		goto exit_hctx;
 
 	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx, node))
 		goto free_fq;
@@ -2235,8 +2231,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 
  free_fq:
 	kfree(hctx->fq);
- sched_exit_hctx:
-	blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
  exit_hctx:
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
@@ -2913,6 +2907,25 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue(q);
 
+	/*
+	 * switch io scheduler to NULL to clean up the data in it.
+	 * will get it back after update mapping between cpu and hw queues.
+	 */
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (!q->elevator) {
+			q->elv_type = NULL;
+			continue;
+		}
+		q->elv_type = q->elevator->type;
+		mutex_lock(&q->sysfs_lock);
+		/*
+		 * elevator_release will put it.
+		 */
+		__module_get(q->elv_type->elevator_owner);
+		elevator_switch_mq(q, NULL);
+		mutex_unlock(&q->sysfs_lock);
+	}
+
 	set->nr_hw_queues = nr_hw_queues;
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
@@ -2920,6 +2933,14 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_queue_reinit(q);
 	}
 
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (!q->elv_type)
+			continue;
+
+		mutex_lock(&q->sysfs_lock);
+		elevator_switch_mq(q, q->elv_type);
+		mutex_unlock(&q->sysfs_lock);
+	}
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_unfreeze_queue(q);
 }
diff --git a/block/blk.h b/block/blk.h
index d4d67e9..0c9bc8d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -234,6 +234,8 @@ static inline void elv_deactivate_rq(struct request_queue *q, struct request *rq
 
 int elevator_init(struct request_queue *);
 int elevator_init_mq(struct request_queue *q);
+int elevator_switch_mq(struct request_queue *q,
+			      struct elevator_type *new_e);
 void elevator_exit(struct request_queue *, struct elevator_queue *);
 int elv_register_queue(struct request_queue *q);
 void elv_unregister_queue(struct request_queue *q);
diff --git a/block/elevator.c b/block/elevator.c
index fa828b5..5ea6e7d 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -933,16 +933,13 @@ void elv_unregister(struct elevator_type *e)
 }
 EXPORT_SYMBOL_GPL(elv_unregister);
 
-static int elevator_switch_mq(struct request_queue *q,
+int elevator_switch_mq(struct request_queue *q,
 			      struct elevator_type *new_e)
 {
 	int ret;
 
 	lockdep_assert_held(&q->sysfs_lock);
 
-	blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue(q);
-
 	if (q->elevator) {
 		if (q->elevator->registered)
 			elv_unregister_queue(q);
@@ -968,8 +965,6 @@ static int elevator_switch_mq(struct request_queue *q,
 		blk_add_trace_msg(q, "elv switch: none");
 
 out:
-	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
 	return ret;
 }
 
@@ -1021,8 +1016,17 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 
 	lockdep_assert_held(&q->sysfs_lock);
 
-	if (q->mq_ops)
-		return elevator_switch_mq(q, new_e);
+	if (q->mq_ops) {
+		blk_mq_freeze_queue(q);
+		blk_mq_quiesce_queue(q);
+
+		err = elevator_switch_mq(q, new_e);
+
+		blk_mq_unquiesce_queue(q);
+		blk_mq_unfreeze_queue(q);
+
+		return err;
+	}
 
 	/*
 	 * Turn on BYPASS and drain all requests w/ elevator private data.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d6869e0..ee930c4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -437,6 +437,9 @@ struct request_queue {
 	struct list_head	queue_head;
 	struct request		*last_merge;
 	struct elevator_queue	*elevator;
+
+	/* used when update nr_hw_queues */
+	struct elevator_type	*elv_type;
 	int			nr_rqs[2];	/* # allocated [a]sync rqs */
 	int			nr_rqs_elvpriv;	/* # allocated rqs w/ elvpriv */
 
-- 
2.7.4

