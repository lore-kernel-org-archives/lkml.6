Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBB2C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313F421BC7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3GXFrF9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313F421BC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeHIEaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:30:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37240 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeHIEav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:30:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w79257tT032869;
        Thu, 9 Aug 2018 02:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=0AQIJHlhYnPQF/Ro1u5tZroeNx25UA4ETL0XUSNbgrU=;
 b=3GXFrF9L2N09f32V9uEvK4x1i6SIzaWoc17u+JCgW1AEP3A8enEcWDE1ims0qg0zsKN2
 9e2cDkQMuE7q0zRPEIxkSBk3mVb7AZk41tG3um7HJAy+857WnMsACbHk0hTVRjjtGMiT
 ciZs1PssR302YvPhkaz3VAE8X8F1omjn4QsYJHzsEHnabLNLt/gMHoDZ8e2KECZhdhfD
 h13nOLgpACDk0+RY5VeIq9HCsGP03F6h8NR8QFQR/i9RcAyC2HDLscrzveJajjonHYR8
 tqilkSDtmhWCXHYlvRX/Vzo4a2IHqIui/MCBZzzokMYwNGvmx5U+AUQnZM6zUEZRJXa/ gg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2kn4sq02ta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Aug 2018 02:08:25 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7928PaV003225
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Aug 2018 02:08:25 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7928OWm003842;
        Thu, 9 Aug 2018 02:08:24 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Aug 2018 19:08:24 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     tom.leiming@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3] blk-mq: count the hctx as active before allocate tag
Date:   Thu,  9 Aug 2018 10:09:58 +0800
Message-Id: <1533780598-23972-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8979 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=821
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808090021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we count the hctx as active after allocate driver tag
successfully. If a previously inactive hctx try to get tag first
time, it may fails and need to wait. However, due to the stale tag
->active_queues, the other shared-tags users are still able to
occupy all driver tags while there is someone waiting for tag.
Consequently, even if the previously inactive hctx is waked up, it
still may not be able to get a tag and could be starved.

To fix it, we count the hctx as active before try to allocate driver
tag, then when it is waiting the tag, the other shared-tag users
will reserve budget for it.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---

V3:
  add more detailed comment

V2:
  only invoke blk_mq_tag_busy w/o io scheduler in blk_mq_get_request

 block/blk-mq-tag.c | 3 +++
 block/blk-mq.c     | 8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 09b2ee6..a8ebcbd 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -23,6 +23,9 @@ bool blk_mq_has_free_tags(struct blk_mq_tags *tags)
 
 /*
  * If a previously inactive queue goes active, bump the active user count.
+ * We need to do this before try to allocate driver tag, then even if fail
+ * to get tag when first time, the other shared-tag users could reserve
+ * budget for it.
  */
 bool __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
 {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae44e85..75ac3fbd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -285,7 +285,7 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 		rq->tag = -1;
 		rq->internal_tag = tag;
 	} else {
-		if (blk_mq_tag_busy(data->hctx)) {
+		if (data->hctx->flags & BLK_MQ_F_TAG_SHARED) {
 			rq_flags = RQF_MQ_INFLIGHT;
 			atomic_inc(&data->hctx->nr_active);
 		}
@@ -367,6 +367,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 		if (!op_is_flush(op) && e->type->ops.mq.limit_depth &&
 		    !(data->flags & BLK_MQ_REQ_RESERVED))
 			e->type->ops.mq.limit_depth(op, data);
+	} else {
+		blk_mq_tag_busy(data->hctx);
 	}
 
 	tag = blk_mq_get_tag(data);
@@ -972,6 +974,7 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 		.hctx = blk_mq_map_queue(rq->q, rq->mq_ctx->cpu),
 		.flags = wait ? 0 : BLK_MQ_REQ_NOWAIT,
 	};
+	bool shared;
 
 	might_sleep_if(wait);
 
@@ -981,9 +984,10 @@ bool blk_mq_get_driver_tag(struct request *rq, struct blk_mq_hw_ctx **hctx,
 	if (blk_mq_tag_is_reserved(data.hctx->sched_tags, rq->internal_tag))
 		data.flags |= BLK_MQ_REQ_RESERVED;
 
+	shared = blk_mq_tag_busy(data.hctx);
 	rq->tag = blk_mq_get_tag(&data);
 	if (rq->tag >= 0) {
-		if (blk_mq_tag_busy(data.hctx)) {
+		if (shared) {
 			rq->rq_flags |= RQF_MQ_INFLIGHT;
 			atomic_inc(&data.hctx->nr_active);
 		}
-- 
2.7.4

