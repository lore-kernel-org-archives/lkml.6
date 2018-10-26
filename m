Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2D2ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447582082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fFshc5Yn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447582082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeJZQi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:38:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55490 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeJZQi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:38:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9Q7xdCV192381;
        Fri, 26 Oct 2018 08:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=AMySOZ5jhqcRj7ylV7zfJ/ZWlrY7lN9hpV4nlgSyC/M=;
 b=fFshc5Ynl+WfG7z5a7oBGZgAzlHje3IPaJzzmZ2Sivaa9dPzsNW03ZVL/UDfR/880EM7
 GNYRfdGNCYQvGeYYzaY2FHcsbiTUE5ORjUI0gptBwvqDRPAUGazhMxZxhIcAP4WD0OGW
 ASldNbEdhWbE4kyDwioRNsh6GHhGzkpOL2tUpCOO3TX3K0C8GCE7rwD6j1iGDLe8cdIQ
 wwEpnJo3xroAE/Mj5LmSIJzEvT9wSV7SLaxoQy377nkrsbGqHOXRZVyhu9GFkhr/h3Il
 2WYIPyWGxQZASv1cwTnhICJAB5ghwPGddgmOpof+WWzhHbU8wjYZD/IGY2tzqDnM5fhZ nw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2n7vaqdrf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 08:02:52 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9Q82qu5001055
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 08:02:52 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9Q82pgU009173;
        Fri, 26 Oct 2018 08:02:51 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Oct 2018 01:02:51 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] blk-mq: refactor the code of issue request directly
Date:   Sat, 27 Oct 2018 00:01:09 +0800
Message-Id: <1540569671-6589-2-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540569671-6589-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1540569671-6589-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9057 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810260072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Merge blk_mq_try_issue_directly and __blk_mq_try_issue_directly
into one interface which is able to handle the return value from
.queue_rq callback. Due to we can only issue directly w/o io
scheduler, so remove the blk_mq_get_driver_tag.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 109 ++++++++++++++++++++++++++-------------------------------
 1 file changed, 50 insertions(+), 59 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index dcf10e3..a81d2ca 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1700,8 +1700,6 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	blk_qc_t new_cookie;
 	blk_status_t ret;
 
-	new_cookie = request_to_qc_t(hctx, rq);
-
 	/*
 	 * For OK queue, we are done. For error, caller may kill it.
 	 * Any other error (busy), just add it to our list as we
@@ -1711,7 +1709,7 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	switch (ret) {
 	case BLK_STS_OK:
 		blk_mq_update_dispatch_busy(hctx, false);
-		*cookie = new_cookie;
+		new_cookie = request_to_qc_t(hctx, rq);
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
@@ -1720,86 +1718,79 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
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
+/*
+ * When the bypass is true, the caller is responsible for handling the
+ * request if it is not issued. The only exception is that io scheduler
+ * is set.
+ */
+static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
-						bool bypass_insert)
+						bool bypass)
 {
 	struct request_queue *q = rq->q;
-	bool run_queue = true;
+	blk_status_t ret = BLK_STS_OK;
+	bool insert = true;
+	int srcu_idx;
+
+	if (q->elevator)
+		goto out;
 
+	hctx_lock(hctx, &srcu_idx);
 	/*
-	 * RCU or SRCU read lock is needed before checking quiesced flag.
+	 * hctx_lock is needed before checking quiesced flag.
 	 *
-	 * When queue is stopped or quiesced, ignore 'bypass_insert' from
-	 * blk_mq_request_issue_directly(), and return BLK_STS_OK to caller,
-	 * and avoid driver to try to dispatch again.
+	 * When queue is stopped or quiesced, ignore 'bypass', insert and return
+	 * BLK_STS_OK to caller, and avoid driver to try to dispatch again.
 	 */
-	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
-		run_queue = false;
-		bypass_insert = false;
-		goto insert;
-	}
-
-	if (q->elevator && !bypass_insert)
-		goto insert;
+	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q))
+		goto out_unlock;
 
-	if (!blk_mq_get_dispatch_budget(hctx))
-		goto insert;
-
-	if (!blk_mq_get_driver_tag(rq)) {
-		blk_mq_put_dispatch_budget(hctx);
-		goto insert;
+	if (!blk_mq_get_dispatch_budget(hctx)) {
+		insert = !bypass;
+		ret = bypass ? BLK_STS_RESOURCE : BLK_STS_OK;
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
-
-	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false);
-	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
-		blk_mq_sched_insert_request(rq, false, true, false);
-	else if (ret != BLK_STS_OK)
-		blk_mq_end_request(rq, ret);
+	ret = __blk_mq_issue_directly(hctx, rq, cookie);
+	switch(ret) {
+	case BLK_STS_OK:
+		insert = false;
+		break;
+	case BLK_STS_DEV_RESOURCE:
+	case BLK_STS_RESOURCE:
+		insert = !bypass;
+		break;
+	default:
+		if (!bypass)
+			blk_mq_end_request(rq, ret);
+		insert = false;
+		break;
+	}
 
+out_unlock:
 	hctx_unlock(hctx, srcu_idx);
+out:
+	if (insert)
+		blk_mq_sched_insert_request(rq, false, true, false);
+	return ret;
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
+	return  blk_mq_try_issue_directly(hctx, rq, NULL, true);
 }
 
 void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
@@ -1921,13 +1912,13 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
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

