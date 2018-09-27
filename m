Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2FAC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98DC721571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nih9Dj9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98DC721571
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeI0Q75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:59:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40926 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbeI0Q74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:59:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8RAdFFc180000;
        Thu, 27 Sep 2018 10:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=HkKuifm6HndyIPAiUM/dsxQmb5jn/HcD2CQ1W0hSYcY=;
 b=Nih9Dj9uVB+5yThlU5f71ZTZwkYnXtcV7R/+r6ls8pEjq6uFlkyMFiZQyiOSr6ZTbg7l
 du/xDG/j0fTHiqI3soBUcV0v0LSi9YdH8OMp01+iyktCSWaJw6Bys1cm1OdmNBVO2bQw
 BYxcocQtKM3JeCDeZbCNaG3lMWe9Wv/U2VMp3DfmF06GX+nOGZ9UMai/xT/YGHrAdMC3
 kWr6WuyJH29cf+pslbSZw+kktyqqVvWMfla1mqPjtJlpcWP6GfXJ2COOoSBdzKJPj/9z
 HmesMd5/qnYyCAquboW7EzhIv/D8r7T0DeCsBPHlYzjdVUnHTWbWXTGuuZl9gSuV2u2B 3w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2mnd5ts9vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 10:41:14 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8RAfD6r008170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 10:41:13 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8RAfDlW021352;
        Thu, 27 Sep 2018 10:41:13 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Sep 2018 03:41:12 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] blk-mq: adjust debugfs and sysfs register when updating nr_hw_queues
Date:   Thu, 27 Sep 2018 18:43:03 +0800
Message-Id: <1538044984-2147-2-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538044984-2147-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1538044984-2147-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9028 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809270109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk-mq debugfs and sysfs entries need to be removed before updating
queue map, otherwise, we get get wrong result there. This patch fixes
it and remove the redundant debugfs and sysfs register/unregister
operations during __blk_mq_update_nr_hw_queues.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 85a1c1a..6356455 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2137,8 +2137,6 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 		struct blk_mq_tag_set *set,
 		struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 {
-	blk_mq_debugfs_unregister_hctx(hctx);
-
 	if (blk_mq_hw_queue_mapped(hctx))
 		blk_mq_tag_idle(hctx);
 
@@ -2165,6 +2163,7 @@ static void blk_mq_exit_hw_queues(struct request_queue *q,
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (i == nr_queue)
 			break;
+		blk_mq_debugfs_unregister_hctx(hctx);
 		blk_mq_exit_hctx(q, set, hctx, i);
 	}
 }
@@ -2222,8 +2221,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	if (hctx->flags & BLK_MQ_F_BLOCKING)
 		init_srcu_struct(hctx->srcu);
 
-	blk_mq_debugfs_register_hctx(q, hctx);
-
 	return 0;
 
  free_fq:
@@ -2512,8 +2509,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	int i, j;
 	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
 
-	blk_mq_sysfs_unregister(q);
-
 	/* protect against switching io scheduler  */
 	mutex_lock(&q->sysfs_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
@@ -2561,7 +2556,6 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	}
 	q->nr_hw_queues = i;
 	mutex_unlock(&q->sysfs_lock);
-	blk_mq_sysfs_register(q);
 }
 
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
@@ -2659,25 +2653,6 @@ void blk_mq_free_queue(struct request_queue *q)
 	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
 }
 
-/* Basically redo blk_mq_init_queue with queue frozen */
-static void blk_mq_queue_reinit(struct request_queue *q)
-{
-	WARN_ON_ONCE(!atomic_read(&q->mq_freeze_depth));
-
-	blk_mq_debugfs_unregister_hctxs(q);
-	blk_mq_sysfs_unregister(q);
-
-	/*
-	 * redo blk_mq_init_cpu_queues and blk_mq_init_hw_queues. FIXME: maybe
-	 * we should change hctx numa_node according to the new topology (this
-	 * involves freeing and re-allocating memory, worth doing?)
-	 */
-	blk_mq_map_swqueue(q);
-
-	blk_mq_sysfs_register(q);
-	blk_mq_debugfs_register_hctxs(q);
-}
-
 static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 {
 	int i;
@@ -2987,11 +2962,21 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		if (!blk_mq_elv_switch_none(&head, q))
 			goto switch_back;
 
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		blk_mq_debugfs_unregister_hctxs(q);
+		blk_mq_sysfs_unregister(q);
+	}
+
 	set->nr_hw_queues = nr_hw_queues;
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_realloc_hw_ctxs(set, q);
-		blk_mq_queue_reinit(q);
+		blk_mq_map_swqueue(q);
+	}
+
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		blk_mq_sysfs_register(q);
+		blk_mq_debugfs_register_hctxs(q);
 	}
 
 switch_back:
-- 
2.7.4

