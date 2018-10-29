Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDA1C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F8F2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4iZysp28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F8F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbeJ2RVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:21:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37816 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729436AbeJ2RVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:21:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9T8TTwq013617;
        Mon, 29 Oct 2018 08:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=ljr1AVEDeyqNV2z//1XrWvkspXgCo1lAbTrhPYSDkVY=;
 b=4iZysp28Gnx43sHBnyCb1jPyW2Q+9mlOOb+NLiAnv5O93edK8fZS4uxX6lICXNRZ/3Az
 ju0C1wmIyzndC4jgIDtj/zM/IJ9qjPiwt5gM3JBN6d8w3zQwFE1cFUXu82ELSs+O46nR
 L82pRQbh8iYAF1nMK7VEz2qQpqa0i9e5mqkjZoGzX+RpZh/sTgaR7R3NfF7Oe74R3xwj
 56XyPvR/ZrZ1alXCPB7pgULf6As+yjj2lvZj3QGNQ2DX513/TlY7SKuCzRsE2M0cwpaY
 DgGNuTeFqBSIhxnUgyt4O4lDWoBGxNuxi3Ay/bS3bebAuuW5V4UJrRP2Ov2Rt/IJn3gg nw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2ncfypm5vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Oct 2018 08:34:09 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9T8Y8jt013068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Oct 2018 08:34:08 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9T8Y8ud010591;
        Mon, 29 Oct 2018 08:34:08 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Oct 2018 01:34:08 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/4] blk-mq: insert request without involving any io scheduler
Date:   Mon, 29 Oct 2018 16:33:31 +0800
Message-Id: <1540802013-2921-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540802013-2921-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1540802013-2921-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9060 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810290082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When try to issue request directly, if the queue is stopped or
quiesced, 'bypass_insert' will be ignored and return BLK_STS_OK to
caller to avoid it dispatch request again. Then the request will
be inserted with blk_mq_sched_insert_request. This is not correct
for dm-rq case where we should avoid to pass through the underlying
paths' io scheduler.

To fix it, use blk_mq_request_bypass_insert to insert the request
into hctx->dispatch directly.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0f6328b..e0aa068 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1729,13 +1729,14 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 }
 
 enum mq_decision {
+	MQ_INSERT_DISPATCH,
 	MQ_INSERT_QUEUE,
 	MQ_END_REQUEST,
 	MQ_DO_NOTHING,
 };
 
 static inline enum mq_decision
-	blk_mq_make_dicision(blk_status_t ret, bool bypass_insert)
+	blk_mq_make_dicision(blk_status_t ret, bool bypass_insert, bool force)
 {
 	enum mq_decision dec;
 
@@ -1745,7 +1746,10 @@ static inline enum mq_decision
 		break;
 	case BLK_STS_DEV_RESOURCE:
 	case BLK_STS_RESOURCE:
-		dec = bypass_insert ? MQ_DO_NOTHING : MQ_INSERT_QUEUE;
+		if (force)
+			dec = bypass_insert ? MQ_INSERT_DISPATCH : MQ_INSERT_QUEUE;
+		else
+			dec = bypass_insert ? MQ_DO_NOTHING : MQ_INSERT_QUEUE;
 		break;
 	default:
 		dec = bypass_insert ? MQ_DO_NOTHING : MQ_END_REQUEST;
@@ -1761,7 +1765,7 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						bool bypass_insert)
 {
 	struct request_queue *q = rq->q;
-	bool run_queue = true;
+	bool run_queue = true, force = false;
 	enum mq_decision dec;
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int srcu_idx;
@@ -1776,7 +1780,7 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	 */
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
 		run_queue = false;
-		bypass_insert = false;
+		force = true;
 		goto out_unlock;
 	}
 
@@ -1795,8 +1799,11 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 out_unlock:
 	hctx_unlock(hctx, srcu_idx);
 
-	dec = blk_mq_make_dicision(ret, bypass_insert);
+	dec = blk_mq_make_dicision(ret, bypass_insert, force);
 	switch(dec) {
+	case MQ_INSERT_DISPATCH:
+		blk_mq_request_bypass_insert(rq, run_queue);
+		break;
 	case MQ_INSERT_QUEUE:
 		blk_mq_sched_insert_request(rq, false, run_queue, false);
 		break;
-- 
2.7.4

