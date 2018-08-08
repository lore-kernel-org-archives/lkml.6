Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C982C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D41216FA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tB/sEoVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D41216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeHHKjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:39:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33548 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeHHKjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:39:33 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w788Iwjw052776;
        Wed, 8 Aug 2018 08:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=KA1igWk87pWNUCvdK9JHhww4vyxbcAUh7tYjMIFjUpw=;
 b=tB/sEoVf9SxJDv5grlKEJETqX5seAidYm/p1IbrRcnaGs2BMKUMiogEEEILMV9b0ToZC
 p5nBALAXdrGPBH8azlk2WS9oV6+rpBlgZCLld51Uj597uS13WRX37ChiIB53TUvhXSPa
 qgutr4nKKwSQgBeNXNuoheetS3iap7t/23geQ0ejmEbwdtg2f342ZXGfSbOa4xyoBJEG
 baYb8hFTj7XGed2cTn3ekRViHLRhrJqW/fHqoEcvn2DfNfbqThIQkLZ44g5SFzpux/dK
 MmAFtTEXaqlABURs2nFvPKLZD2zD1deytEBkuFfKp0omvZ4zv51U6nunhMRE40kuJZMB eg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kn3jt4rbw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Aug 2018 08:20:55 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w788KsJF015615
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Aug 2018 08:20:54 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w788KsWp017894;
        Wed, 8 Aug 2018 08:20:54 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Aug 2018 01:20:54 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: count the hctx as active before allocate tag
Date:   Wed,  8 Aug 2018 16:22:28 +0800
Message-Id: <1533716548-1645-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8978 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=869
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808080087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we count the hctx as active after allocate tag
successfully. The other shared-tags users could exhaust the tags
and starve a non-active and waiting-tag hctx. Count the hctx as
active before try to allocate tag to fix this.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae44e85..acd40eb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -369,6 +369,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
 			e->type->ops.mq.limit_depth(op, data);
 	}
 
+	blk_mq_tag_busy(data.hctx);
+
 	tag = blk_mq_get_tag(data);
 	if (tag == BLK_MQ_TAG_FAIL) {
 		if (put_ctx_on_error) {
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

