Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93145C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 546482086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fp2aTDx6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 546482086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbeJLRhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:37:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48992 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbeJLRhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:37:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9CA4aFf147470;
        Fri, 12 Oct 2018 10:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=/bkO0BrR1JivtILyNmExe07M5GqhYeTrxgnB6cVPpjI=;
 b=Fp2aTDx68v7P4zbNP/3rfaYKKtZul/rgb54R+3iS5n4d7xfPagqR3zd0LEAt/YdhzF9z
 fr7hJhMQbj9LpuZZb/CTwGumHvUcDLjnZIYcnOig13xdxj1fmGfCOm8sohoMbyiIIodC
 uubnoQC432TOMeXHMUGfOQe4eR6hPDnNqkeRI2qBWpGjB50pRBG5D8L0jUf8eNROVujQ
 w+zQVZGxRIZchU+8fre55JxBXQLXhSWiU6zAlfc27SSjCx5MMFPFgqI2jL9q2VQ34Kro
 BTYg2lKYymon7pC6pN82iaT1/Ht0cm5EUnBrm0CTKKFxldm22DifwpBM9qfOhiaaxo3n OQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2mxnprhjd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Oct 2018 10:05:36 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9CA5UeF015533
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Oct 2018 10:05:30 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9CA5UYe003351;
        Fri, 12 Oct 2018 10:05:30 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Oct 2018 10:05:29 +0000
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/4] blk-mq: realloc hctx when hw queue is mapped to another node
Date:   Fri, 12 Oct 2018 18:07:27 +0800
Message-Id: <1539338848-1789-4-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539338848-1789-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1539338848-1789-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9043 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810120101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the hw queues and mq_map are updated, a hctx could be mapped
to a different numa node. At this moment, we need to realloc the
hctx. If fail to do that, go on using previous hctx.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 82 +++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 26 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9805d6a..34f3973 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2504,6 +2504,39 @@ static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
 	return hw_ctx_size;
 }
 
+static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
+		struct blk_mq_tag_set *set, struct request_queue *q,
+		int hctx_idx, int node)
+{
+	struct blk_mq_hw_ctx *hctx;
+
+	hctx = kzalloc_node(blk_mq_hw_ctx_size(set),
+			GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
+			node);
+	if (!hctx)
+		return NULL;
+
+	if (!zalloc_cpumask_var_node(&hctx->cpumask,
+				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
+				node)) {
+		kfree(hctx);
+		return NULL;
+	}
+
+	atomic_set(&hctx->nr_active, 0);
+	hctx->numa_node = node;
+	hctx->queue_num = hctx_idx;
+
+	if (blk_mq_init_hctx(q, set, hctx, hctx_idx)) {
+		free_cpumask_var(hctx->cpumask);
+		kfree(hctx);
+		return NULL;
+	}
+	blk_mq_hctx_kobj_init(hctx);
+
+	return hctx;
+}
+
 static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 						struct request_queue *q)
 {
@@ -2514,37 +2547,34 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 	mutex_lock(&q->sysfs_lock);
 	for (i = 0; i < set->nr_hw_queues; i++) {
 		int node;
-
-		if (hctxs[i])
-			continue;
+		struct blk_mq_hw_ctx *hctx;
 
 		node = blk_mq_hw_queue_to_node(q->mq_map, i);
-		hctxs[i] = kzalloc_node(blk_mq_hw_ctx_size(set),
-				GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
-				node);
-		if (!hctxs[i])
-			break;
-
-		if (!zalloc_cpumask_var_node(&hctxs[i]->cpumask,
-					GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY,
-					node)) {
-			kfree(hctxs[i]);
-			hctxs[i] = NULL;
-			break;
-		}
-
-		atomic_set(&hctxs[i]->nr_active, 0);
-		hctxs[i]->numa_node = node;
-		hctxs[i]->queue_num = i;
+		/*
+		 * If the hw queue has been mapped to another numa node,
+		 * we need to realloc the hctx. If allocation fails, fallback
+		 * to use the previous one.
+		 */
+		if (hctxs[i] && (hctxs[i]->numa_node == node))
+			continue;
 
-		if (blk_mq_init_hctx(q, set, hctxs[i], i)) {
-			free_cpumask_var(hctxs[i]->cpumask);
-			kfree(hctxs[i]);
-			hctxs[i] = NULL;
-			break;
+		hctx = blk_mq_alloc_and_init_hctx(set, q, i, node);
+		if (hctx) {
+			if (hctxs[i]) {
+				blk_mq_exit_hctx(q, set, hctxs[i], i);
+				kobject_put(&hctxs[i]->kobj);
+			}
+			hctxs[i] = hctx;
+		} else {
+			if (hctxs[i])
+				pr_warn("Allocate new hctx on node %d fails,\
+						fallback to previous one on node %d\n",
+						node, hctxs[i]->numa_node);
+			else
+				break;
 		}
-		blk_mq_hctx_kobj_init(hctxs[i]);
 	}
+
 	for (j = i; j < q->nr_hw_queues; j++) {
 		struct blk_mq_hw_ctx *hctx = hctxs[j];
 
-- 
2.7.4

