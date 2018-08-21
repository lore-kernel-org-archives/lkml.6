Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93094C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C47213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r51EC270"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C47213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbeHUKc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:32:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44292 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeHUKc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:32:29 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7L790cO070841;
        Tue, 21 Aug 2018 07:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=UF1/mlU5g2XiCBwjJOjli9yb6K7NMgakc0k5V25svDw=;
 b=r51EC270IinIPTD/qwR3V5R2jNj5zJu7ZMKEaEC9qn5lS5skw26+sNNi1pwIyKJLSD7t
 9UM4Ch7qpVSh3EI+XPVCw5mCLWmsTe3zmk0t3Ayn3J2ubbyegzvMtT4NruwPfMFbV/wY
 xCGtoCl6VBCsp5FDb6DB8sBO8jCO7grzfOQNrPI7ibPxIR5mljUNWy8aindkZ/zYnuKp
 sw7ExRTB1cBvkgX96FXcO9ZIb2xNuVA1tDOYv+o35+U9jz29c5JjwnV6sTNUffsTWwuP
 q/3lcT1YaVmfxW77qtwhGzhLDGDSYY9UuUmYW2qG52GjT3KwCu4kRSbY/YylMCSVtG9P PQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2kxavtjjx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Aug 2018 07:13:27 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7L7DQlb027736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Aug 2018 07:13:27 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7L7DQbM021326;
        Tue, 21 Aug 2018 07:13:26 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Aug 2018 00:13:26 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     tom.leiming@gmail.com, bart.vanassche@wdc.com,
        keith.busch@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/2] blk-mq: init hctx sched after update ctx and hctx mapping
Date:   Tue, 21 Aug 2018 15:15:03 +0800
Message-Id: <1534835704-3607-2-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534835704-3607-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1534835704-3607-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8991 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808210076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, when update nr_hw_queues, IO scheduler's init_hctx will
be invoked before the mapping between ctx and hctx is adapted
correctly by blk_mq_map_swqueue. The IO scheduler init_hctx (kyber)
may depend on this mapping and get wrong result and panic finally.
A simply way to fix this is that switch the IO scheduler to 'none'
before update the nr_hw_queues, and then switch it back after
update nr_hw_queues. blk_mq_sched_init_/exit_hctx are removed due
to nobody use them any more.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-sched.c | 44 -------------------------
 block/blk-mq-sched.h |  5 ---
 block/blk-mq.c       | 92 +++++++++++++++++++++++++++++++++++++++++++++++-----
 block/blk.h          |  2 ++
 block/elevator.c     | 20 +++++++-----
 5 files changed, 98 insertions(+), 65 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index cf9c66c..29bfe80 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -462,50 +462,6 @@ static void blk_mq_sched_tags_teardown(struct request_queue *q)
 		blk_mq_sched_free_tags(set, hctx, i);
 }
 
-int blk_mq_sched_init_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
-			   unsigned int hctx_idx)
-{
-	struct elevator_queue *e = q->elevator;
-	int ret;
-
-	if (!e)
-		return 0;
-
-	ret = blk_mq_sched_alloc_tags(q, hctx, hctx_idx);
-	if (ret)
-		return ret;
-
-	if (e->type->ops.mq.init_hctx) {
-		ret = e->type->ops.mq.init_hctx(hctx, hctx_idx);
-		if (ret) {
-			blk_mq_sched_free_tags(q->tag_set, hctx, hctx_idx);
-			return ret;
-		}
-	}
-
-	blk_mq_debugfs_register_sched_hctx(q, hctx);
-
-	return 0;
-}
-
-void blk_mq_sched_exit_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
-			    unsigned int hctx_idx)
-{
-	struct elevator_queue *e = q->elevator;
-
-	if (!e)
-		return;
-
-	blk_mq_debugfs_unregister_sched_hctx(hctx);
-
-	if (e->type->ops.mq.exit_hctx && hctx->sched_data) {
-		e->type->ops.mq.exit_hctx(hctx, hctx_idx);
-		hctx->sched_data = NULL;
-	}
-
-	blk_mq_sched_free_tags(q->tag_set, hctx, hctx_idx);
-}
-
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e)
 {
 	struct blk_mq_hw_ctx *hctx;
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 0cb8f93..4e028ee 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -28,11 +28,6 @@ void blk_mq_sched_dispatch_requests(struct blk_mq_hw_ctx *hctx);
 int blk_mq_init_sched(struct request_queue *q, struct elevator_type *e);
 void blk_mq_exit_sched(struct request_queue *q, struct elevator_queue *e);
 
-int blk_mq_sched_init_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
-			   unsigned int hctx_idx);
-void blk_mq_sched_exit_hctx(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
-			    unsigned int hctx_idx);
-
 static inline bool
 blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio)
 {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5efd789..9c8c8c7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2147,8 +2147,6 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 	if (set->ops->exit_request)
 		set->ops->exit_request(set, hctx->fq->flush_rq, hctx_idx);
 
-	blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
-
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
 
@@ -2216,12 +2214,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
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
@@ -2235,8 +2230,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 
  free_fq:
 	kfree(hctx->fq);
- sched_exit_hctx:
-	blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
  exit_hctx:
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
@@ -2898,10 +2891,81 @@ int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr)
 	return ret;
 }
 
+/*
+ * request_queue and elevator_type pair.
+ * It is just used by __blk_mq_update_nr_hw_queues to cache
+ * the elevator_type associated with a request_queue.
+ */
+struct blk_mq_qe_pair {
+	struct list_head node;
+	struct request_queue *q;
+	struct elevator_type *type;
+};
+
+/*
+ * Cache the elevator_type in qe pair list and switch the
+ * io scheduler to 'none'
+ */
+static bool blk_mq_elv_switch_none(struct list_head *head,
+		struct request_queue *q)
+{
+	struct blk_mq_qe_pair *qe;
+
+	if (!q->elevator)
+		return true;
+
+	qe = kmalloc(sizeof(*qe), GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
+	if (!qe)
+		return false;
+
+	INIT_LIST_HEAD(&qe->node);
+	qe->q = q;
+	qe->type = q->elevator->type;
+	list_add(&qe->node, head);
+
+	mutex_lock(&q->sysfs_lock);
+	/*
+	 * After elevator_switch_mq, the previous elevator_queue will be
+	 * released by elevator_release. The reference of the io scheduler
+	 * module get by elevator_get will also be put. So we need to get
+	 * a reference of the io scheduler module here to prevent it to be
+	 * removed.
+	 */
+	__module_get(qe->type->elevator_owner);
+	elevator_switch_mq(q, NULL);
+	mutex_unlock(&q->sysfs_lock);
+
+	return true;
+}
+
+static void blk_mq_elv_switch_back(struct list_head *head,
+		struct request_queue *q)
+{
+	struct blk_mq_qe_pair *qe;
+	struct elevator_type *t = NULL;
+
+	list_for_each_entry(qe, head, node)
+		if (qe->q == q) {
+			t = qe->type;
+			break;
+		}
+
+	if (!t)
+		return;
+
+	list_del(&qe->node);
+	kfree(qe);
+
+	mutex_lock(&q->sysfs_lock);
+	elevator_switch_mq(q, t);
+	mutex_unlock(&q->sysfs_lock);
+}
+
 static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 							int nr_hw_queues)
 {
 	struct request_queue *q;
+	LIST_HEAD(head);
 
 	lockdep_assert_held(&set->tag_list_lock);
 
@@ -2912,6 +2976,14 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue(q);
+	/*
+	 * Switch IO scheduler to 'none', cleaning up the data associated
+	 * with the previous scheduler. We will switch back once we are done
+	 * updating the new sw to hw queue mappings.
+	 */
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		if (!blk_mq_elv_switch_none(&head, q))
+			goto switch_back;
 
 	set->nr_hw_queues = nr_hw_queues;
 	blk_mq_update_queue_map(set);
@@ -2920,6 +2992,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_queue_reinit(q);
 	}
 
+switch_back:
+	list_for_each_entry(q, &set->tag_list, tag_set_list)
+		blk_mq_elv_switch_back(&head, q);
+
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
-- 
2.7.4

