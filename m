Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856EFC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422F62086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wu4dMI6p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422F62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeJLRhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:37:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33336 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbeJLRhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:37:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9CA4KYm011747;
        Fri, 12 Oct 2018 10:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=pEF4n6wCcRzKn7ZwHolr/TYpOoOBiwbt3M1Hte5rMy8=;
 b=wu4dMI6pEUUH6ANzV9JqNbO9bHRPek9GKCoEprOh0eYkkqhuy2sX9QmiaLkOIXHQsH2+
 ivIrPTqvaYA/mnl4rX+fcFFntfxveVJinKaQ0O3P8wlmctDyy+Rkw9s0TdxJoe7YeAvt
 lQd37jBEunBtliXjcluGIZxhGF64RiJdhp0oXpDulPBbJNGArqE3YM19JXHXvgh48jCm
 Zlyvnxoh5rw9nWuZu0m7lTXm+brCIPbf06gBxGXWmdI+/XJy/X6ceNWEr3PuXjYCYuOh
 AEHUackHr/7zyOCb+MLRziRPZAIQ2nVnjc4mUp+kDNAScGXBBXoicmD2cFWbsJ8nhfsE Vg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2mxn0qhqqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Oct 2018 10:05:34 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9CA5Sqk014712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Oct 2018 10:05:28 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9CA5SgM003339;
        Fri, 12 Oct 2018 10:05:28 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Oct 2018 10:05:27 +0000
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/4] blk-mq: change gfp flags to GFP_NOIO in blk_mq_realloc_hw_ctxs
Date:   Fri, 12 Oct 2018 18:07:26 +0800
Message-Id: <1539338848-1789-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539338848-1789-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1539338848-1789-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9043 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=839
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810120101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_mq_realloc_hw_ctxs could be invoked during update hw queues.
At the momemt, IO is blocked. Change the gfp flags from GFP_KERNEL
to GFP_NOIO to avoid forever hang during memory allocation in
blk_mq_realloc_hw_ctxs.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-core.c  |  2 +-
 block/blk-flush.c |  6 +++---
 block/blk-mq.c    | 17 ++++++++++-------
 block/blk.h       |  2 +-
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index cff0a60..4fe7084 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1160,7 +1160,7 @@ int blk_init_allocated_queue(struct request_queue *q)
 {
 	WARN_ON_ONCE(q->mq_ops);
 
-	q->fq = blk_alloc_flush_queue(q, NUMA_NO_NODE, q->cmd_size);
+	q->fq = blk_alloc_flush_queue(q, NUMA_NO_NODE, q->cmd_size, GFP_KERNEL);
 	if (!q->fq)
 		return -ENOMEM;
 
diff --git a/block/blk-flush.c b/block/blk-flush.c
index ce41f66..8b44b86 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -566,12 +566,12 @@ int blkdev_issue_flush(struct block_device *bdev, gfp_t gfp_mask,
 EXPORT_SYMBOL(blkdev_issue_flush);
 
 struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
-		int node, int cmd_size)
+		int node, int cmd_size, gfp_t flags)
 {
 	struct blk_flush_queue *fq;
 	int rq_sz = sizeof(struct request);
 
-	fq = kzalloc_node(sizeof(*fq), GFP_KERNEL, node);
+	fq = kzalloc_node(sizeof(*fq), flags, node);
 	if (!fq)
 		goto fail;
 
@@ -579,7 +579,7 @@ struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
 		spin_lock_init(&fq->mq_flush_lock);
 
 	rq_sz = round_up(rq_sz + cmd_size, cache_line_size());
-	fq->flush_rq = kzalloc_node(rq_sz, GFP_KERNEL, node);
+	fq->flush_rq = kzalloc_node(rq_sz, flags, node);
 	if (!fq->flush_rq)
 		goto fail_rq;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 32be432..9805d6a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2193,12 +2193,12 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	 * runtime
 	 */
 	hctx->ctxs = kmalloc_array_node(nr_cpu_ids, sizeof(void *),
-					GFP_KERNEL, node);
+			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY, node);
 	if (!hctx->ctxs)
 		goto unregister_cpu_notifier;
 
-	if (sbitmap_init_node(&hctx->ctx_map, nr_cpu_ids, ilog2(8), GFP_KERNEL,
-			      node))
+	if (sbitmap_init_node(&hctx->ctx_map, nr_cpu_ids, ilog2(8),
+				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY, node))
 		goto free_ctxs;
 
 	hctx->nr_ctx = 0;
@@ -2211,7 +2211,8 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
 		goto free_bitmap;
 
-	hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size);
+	hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size,
+			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
 	if (!hctx->fq)
 		goto exit_hctx;
 
@@ -2519,12 +2520,14 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 		node = blk_mq_hw_queue_to_node(q->mq_map, i);
 		hctxs[i] = kzalloc_node(blk_mq_hw_ctx_size(set),
-					GFP_KERNEL, node);
+				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
+				node);
 		if (!hctxs[i])
 			break;
 
-		if (!zalloc_cpumask_var_node(&hctxs[i]->cpumask, GFP_KERNEL,
-						node)) {
+		if (!zalloc_cpumask_var_node(&hctxs[i]->cpumask,
+					GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
+					node)) {
 			kfree(hctxs[i]);
 			hctxs[i] = NULL;
 			break;
diff --git a/block/blk.h b/block/blk.h
index 9db4e38..0f86eda 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -124,7 +124,7 @@ static inline void __blk_get_queue(struct request_queue *q)
 }
 
 struct blk_flush_queue *blk_alloc_flush_queue(struct request_queue *q,
-		int node, int cmd_size);
+		int node, int cmd_size, gfp_t flags);
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
 int blk_init_rl(struct request_list *rl, struct request_queue *q,
-- 
2.7.4

