Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3B8C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2152084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V7jHkB17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2152084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbeJ2RhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:37:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36674 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbeJ2RhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:37:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9T8nK1J030773;
        Mon, 29 Oct 2018 08:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=J7hzrmRyP/DeIBJ0y33e7T6MdMhAdvKFF9gj5cwGn8A=;
 b=V7jHkB176GRoQSoIMWjxGfYzmZvzsn4G8Ri3YpGLEycPT4TZhqV4Ot0lXjYuexfrVCVQ
 jCbccjVPMbmGJdQtGKYufzaMbYUJHXNfxYF6qM4oBVmTk+3JWDCm6UqFlFgv3DbeUbFb
 NRlD/mclHDigD0kkM6HxtpA/zsPzvIA8D9oLqcph0jrFHxecI8xiH4Yi+asK4o9UoIGN
 LYtNEq3Aiv+nf8aLbuXcXWPbMe3X08ThzMsvzH4Vvm+9m69kllUxUI67byjS7zskj5xV
 nGaDC8CZ8tioiOoAKh0WXkDox1JGClYZu85+EO4Qq40fzYR7oFU6DzwJMIUQ2FPo9iNU hQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2nduckrxpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Oct 2018 08:49:23 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9T8nMxt003013
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Oct 2018 08:49:22 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9T8nMTB004540;
        Mon, 29 Oct 2018 08:49:22 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Oct 2018 01:49:21 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/4] blk-mq: refactor the code of issue request directly
Date:   Mon, 29 Oct 2018 16:49:08 +0800
Message-Id: <1540802951-5408-2-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540802951-5408-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1540802951-5408-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9060 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810290085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge blk_mq_try_issue_directly and __blk_mq_try_issue_directly
into one interface which is able to handle the return value from
.queue_rq callback. To make the code clearer, introduce new helpers
blk_mq_make_decision and enum mq_decision.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 104 +++++++++++++++++++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 44 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index dcf10e3..0f6328b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1711,7 +1711,6 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	switch (ret) {
 	case BLK_STS_OK:
 		blk_mq_update_dispatch_busy(hctx, false);
-		*cookie = new_cookie;
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
@@ -1720,86 +1719,103 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 		break;
 	default:
 		blk_mq_update_dispatch_busy(hctx, false);
-		*cookie = BLK_QC_T_NONE;
+		new_cookie = BLK_QC_T_NONE;
 		break;
 	}
 
+	if (cookie)
+		*cookie = new_cookie;
 	return ret;
 }
 
-static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
+enum mq_decision {
+	MQ_INSERT_QUEUE,
+	MQ_END_REQUEST,
+	MQ_DO_NOTHING,
+};
+
+static inline enum mq_decision
+	blk_mq_make_dicision(blk_status_t ret, bool bypass_insert)
+{
+	enum mq_decision dec;
+
+	switch(ret) {
+	case BLK_STS_OK:
+		dec = MQ_DO_NOTHING;
+		break;
+	case BLK_STS_DEV_RESOURCE:
+	case BLK_STS_RESOURCE:
+		dec = bypass_insert ? MQ_DO_NOTHING : MQ_INSERT_QUEUE;
+		break;
+	default:
+		dec = bypass_insert ? MQ_DO_NOTHING : MQ_END_REQUEST;
+		break;
+	}
+
+	return dec;
+}
+
+static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
 						bool bypass_insert)
 {
 	struct request_queue *q = rq->q;
 	bool run_queue = true;
+	enum mq_decision dec;
+	blk_status_t ret = BLK_STS_RESOURCE;
+	int srcu_idx;
 
+	hctx_lock(hctx, &srcu_idx);
 	/*
-	 * RCU or SRCU read lock is needed before checking quiesced flag.
+	 * hctx_lock is needed before checking quiesced flag.
 	 *
-	 * When queue is stopped or quiesced, ignore 'bypass_insert' from
-	 * blk_mq_request_issue_directly(), and return BLK_STS_OK to caller,
-	 * and avoid driver to try to dispatch again.
+	 * When queue is stopped or quiesced, ignore 'bypass_insert',
+	 * and return BLK_STS_OK to caller, and avoid driver to try to
+	 * dispatch again.
 	 */
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
 		run_queue = false;
 		bypass_insert = false;
-		goto insert;
+		goto out_unlock;
 	}
 
 	if (q->elevator && !bypass_insert)
-		goto insert;
+		goto out_unlock;
 
 	if (!blk_mq_get_dispatch_budget(hctx))
-		goto insert;
+		goto out_unlock;
 
 	if (!blk_mq_get_driver_tag(rq)) {
 		blk_mq_put_dispatch_budget(hctx);
-		goto insert;
+		goto out_unlock;
 	}
 
-	return __blk_mq_issue_directly(hctx, rq, cookie);
-insert:
-	if (bypass_insert)
-		return BLK_STS_RESOURCE;
-
-	blk_mq_sched_insert_request(rq, false, run_queue, false);
-	return BLK_STS_OK;
-}
-
-static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
-		struct request *rq, blk_qc_t *cookie)
-{
-	blk_status_t ret;
-	int srcu_idx;
-
-	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
-
-	hctx_lock(hctx, &srcu_idx);
+	ret = __blk_mq_issue_directly(hctx, rq, cookie);
+out_unlock:
+	hctx_unlock(hctx, srcu_idx);
 
-	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false);
-	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
-		blk_mq_sched_insert_request(rq, false, true, false);
-	else if (ret != BLK_STS_OK)
+	dec = blk_mq_make_dicision(ret, bypass_insert);
+	switch(dec) {
+	case MQ_INSERT_QUEUE:
+		blk_mq_sched_insert_request(rq, false, run_queue, false);
+		break;
+	case MQ_END_REQUEST:
 		blk_mq_end_request(rq, ret);
+		break;
+	default:
+		return ret;
+	}
 
-	hctx_unlock(hctx, srcu_idx);
+	return BLK_STS_OK;
 }
 
 blk_status_t blk_mq_request_issue_directly(struct request *rq)
 {
-	blk_status_t ret;
-	int srcu_idx;
-	blk_qc_t unused_cookie;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(rq->q, ctx->cpu);
 
-	hctx_lock(hctx, &srcu_idx);
-	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true);
-	hctx_unlock(hctx, srcu_idx);
-
-	return ret;
+	return blk_mq_try_issue_directly(hctx, rq, NULL, true);
 }
 
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
@@ -1921,13 +1937,13 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			data.hctx = blk_mq_map_queue(q,
 					same_queue_rq->mq_ctx->cpu);
 			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
-					&cookie);
+					&cookie, false);
 		}
 	} else if ((q->nr_hw_queues > 1 && is_sync) || (!q->elevator &&
 			!data.hctx->dispatch_busy)) {
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
-		blk_mq_try_issue_directly(data.hctx, rq, &cookie);
+		blk_mq_try_issue_directly(data.hctx, rq, &cookie, false);
 	} else {
 		blk_mq_put_ctx(data.ctx);
 		blk_mq_bio_to_request(rq, bio);
-- 
2.7.4

