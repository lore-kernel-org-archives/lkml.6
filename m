Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A052AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5677120872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 13:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="koQENWX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5677120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754147AbeFTNWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 09:22:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45232 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752884AbeFTNWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 09:22:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5KDEO1Y102990;
        Wed, 20 Jun 2018 13:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=lJF6yJEise7hnnRWgWLx7IxWE5ngHpBxiRlJikvZ23w=;
 b=koQENWX1KdJF6Gu9bin4z+gYWdsa4Pnb6lZBqcZXKfLQMhSf5CbEjspSSyQo4kgYWpFF
 mHrJV6CsJ5OpW2aTe+bMIJ0SfNoQDdZf5IykFtoK3pQdrJbPFSqpgngsB3TSr/i5vk3T
 bQ9UbweDSkdMejYv5ZHTmE11RK/hbUQuvZPh6W/U6LbLbq6dBm1IBkYVAzRRhcA958ep
 H0F9FI9ziB4p+7C33GA2DmoIkUSfSF+u+pmcqfiY/4mCN5xhmg64Lr+SO8yBwZpeSPiG
 YjBCaMWeXdfS6oAXWFMwEqjGsFznrMA1CTwbiuQm4XUJYKgog1Tf2VYIifXXSeMQjqls VA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jmtgwvem0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 13:22:05 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5KDM5E9032234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 13:22:05 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5KDM4Vg029748;
        Wed, 20 Jun 2018 13:22:04 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 06:22:03 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
        keith.busch@intel.com, josef@toxicpanda.com, ulf.hansson@linaro.org
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] blk-mq: prevent normal completion from entering a timeout request
Date:   Wed, 20 Jun 2018 21:22:40 +0800
Message-Id: <1529500964-28429-2-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1529500964-28429-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=787
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scsi time out and error handler are based on an assumption that
normal completion mustn't do anything on an timeout request.
After 12f5b931 (blk-mq: Remove generation seqeunce), we lost this.
To regain it, introduce blk_mq_mark_rq_complete which change state
from IN-FLIGHT to COMPLETE atomically. It will be added to
blk_mq_complete_request and blk_mq_check_expired to avoid the race
between timeout and normal io completion path.

Because we have hand over the task to complete a timeout request to
LLDD timeout path by invoking blk_mq_complete_request, export
__blk_mq_complete_request for LLDD to complete the timeout request.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c         | 22 +++++++++++++++-------
 include/linux/blk-mq.h |  1 +
 include/linux/blkdev.h |  6 ++++++
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 70c65bb..a73acbd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -473,6 +473,7 @@ static void __blk_mq_free_request(struct request *rq)
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, ctx->cpu);
 	const int sched_tag = rq->internal_tag;
 
+	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 	if (rq->tag != -1)
 		blk_mq_put_tag(hctx, hctx->tags, ctx, rq->tag);
 	if (sched_tag != -1)
@@ -509,7 +510,6 @@ void blk_mq_free_request(struct request *rq)
 	if (blk_rq_rl(rq))
 		blk_put_rl(blk_rq_rl(rq));
 
-	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
 	if (refcount_dec_and_test(&rq->ref))
 		__blk_mq_free_request(rq);
 }
@@ -552,15 +552,17 @@ static void __blk_mq_complete_request_remote(void *data)
 	rq->q->softirq_done_fn(rq);
 }
 
-static void __blk_mq_complete_request(struct request *rq)
+/*
+ * The LLDD timeout path must invoke this interface to complete
+ * the request.
+ */
+void __blk_mq_complete_request(struct request *rq)
 {
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	bool shared = false;
 	int cpu;
 
-	if (cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) !=
-			MQ_RQ_IN_FLIGHT)
-		return;
+	WARN_ON(blk_mq_rq_state(rq) != MQ_RQ_COMPLETE);
 
 	if (rq->internal_tag != -1)
 		blk_mq_sched_completed_request(rq);
@@ -584,6 +586,7 @@ static void __blk_mq_complete_request(struct request *rq)
 	}
 	put_cpu();
 }
+EXPORT_SYMBOL(__blk_mq_complete_request);
 
 static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
 	__releases(hctx->srcu)
@@ -617,7 +620,9 @@ void blk_mq_complete_request(struct request *rq)
 {
 	if (unlikely(blk_should_fake_timeout(rq->q)))
 		return;
-	__blk_mq_complete_request(rq);
+
+	if (blk_mq_mark_rq_complete(rq))
+		__blk_mq_complete_request(rq);
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
 
@@ -783,6 +788,7 @@ static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 
 	req->rq_flags &= ~RQF_TIMED_OUT;
 	blk_add_timer(req);
+	WRITE_ONCE(req->state, MQ_RQ_IN_FLIGHT);
 }
 
 static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
@@ -835,8 +841,10 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 	 * expired; if it is not expired, then the request was completed and
 	 * reallocated as a new request.
 	 */
-	if (blk_mq_req_expired(rq, next))
+	if (blk_mq_req_expired(rq, next) &&
+		blk_mq_mark_rq_complete(rq)) {
 		blk_mq_rq_timed_out(rq, reserved);
+	}
 	if (refcount_dec_and_test(&rq->ref))
 		__blk_mq_free_request(rq);
 }
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index e3147eb..0a509ae 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -259,6 +259,7 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 void blk_mq_complete_request(struct request *rq);
+void __blk_mq_complete_request(struct request *rq);
 bool blk_mq_bio_list_merge(struct request_queue *q, struct list_head *list,
 			   struct bio *bio);
 bool blk_mq_queue_stopped(struct request_queue *q);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9154570..37511c4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -272,6 +272,12 @@ struct request {
 #endif
 };
 
+static inline bool blk_mq_mark_rq_complete(struct request *rq)
+{
+	return (cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
+			MQ_RQ_IN_FLIGHT);
+}
+
 static inline bool blk_op_is_scsi(unsigned int op)
 {
 	return op == REQ_OP_SCSI_IN || op == REQ_OP_SCSI_OUT;
-- 
2.7.4

