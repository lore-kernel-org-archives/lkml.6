Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8D2C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85EC2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pkrg9UdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85EC2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeKBQQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 12:16:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46382 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeKBQQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 12:16:32 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA278qwF052039;
        Fri, 2 Nov 2018 07:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=TcDT+stwGD3sRN+O6m4lBwRAKKPXFhnXDlpIbDb0E7A=;
 b=Pkrg9UdQpBEQDZIVjMo9a6dndXq8JoF6FGhE9V5KPC9imF9HrWy1qAtMBUrww3Fwf8xC
 g/ZKgIJ4F2uxFKu7mnoLEVx/mFs1J8/pIel4ooVxpe8SgdAGVDY5Ndnsh8fRcEwIwXwf
 PfKdDFgFoZhQq18xtZx8LhuGgOvU5DDXCmDd8Lv1RKxC7sdZGXUj5Dm9Oz3KNY7CHbjo
 WsBCpLNKNHrtePzss6kbvs2j3FpPwKAoblJkOF0Hd6BsMsopjUopxZ+wNl/+0Us8Zn27
 oT8V3gG7ME3XRND4HUEiytATDSxbF2CtTva6GS5GXywfxZnMDKUkakqoWkbkfGCGAJu3 ig== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nducmhgbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Nov 2018 07:10:19 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA27AHH3003385
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Nov 2018 07:10:18 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA27AH7n004851;
        Fri, 2 Nov 2018 07:10:17 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Nov 2018 00:10:17 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 3/5] blk-mq: fix issue directly case when q is stopped or quiesced
Date:   Fri,  2 Nov 2018 15:08:54 +0800
Message-Id: <1541142536-1431-4-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541142536-1431-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1541142536-1431-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9064 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811020067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When try to issue request directly, if the queue is stopped or
quiesced, 'bypass' will be ignored and return BLK_STS_OK to caller
to avoid it dispatch request again. Then the request will be
inserted with blk_mq_sched_insert_request. This is not correct
for dm-rq case where we should avoid to pass through the underlying
path's io scheduler.

To fix it, add new mq_issue_decision entry MQ_ISSUE_INSERT_DISPATCH
for above case where the request need to be inserted forcibly.
And use blk_mq_request_bypass_insert to insert the request into
hctx->dispatch directly.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 962fdfc..a0b9b6c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1731,12 +1731,13 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 enum mq_issue_decision {
 	MQ_ISSUE_INSERT_QUEUE,
+	MQ_ISSUE_INSERT_DISPATCH,
 	MQ_ISSUE_END_REQUEST,
 	MQ_ISSUE_DO_NOTHING,
 };
 
 static inline enum mq_issue_decision
-	blk_mq_make_dicision(blk_status_t ret, bool bypass)
+	blk_mq_make_dicision(blk_status_t ret, bool bypass, bool force)
 {
 	enum mq_issue_decision dec;
 
@@ -1746,7 +1747,10 @@ static inline enum mq_issue_decision
 		break;
 	case BLK_STS_DEV_RESOURCE:
 	case BLK_STS_RESOURCE:
-		dec = bypass ? MQ_ISSUE_DO_NOTHING : MQ_ISSUE_INSERT_QUEUE;
+		if (force)
+			dec = bypass ? MQ_ISSUE_INSERT_DISPATCH : MQ_ISSUE_INSERT_QUEUE;
+		else
+			dec = bypass ? MQ_ISSUE_DO_NOTHING : MQ_ISSUE_INSERT_QUEUE;
 		break;
 	default:
 		dec = bypass ? MQ_ISSUE_DO_NOTHING : MQ_ISSUE_END_REQUEST;
@@ -1762,7 +1766,7 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						bool bypass)
 {
 	struct request_queue *q = rq->q;
-	bool run_queue = true;
+	bool run_queue = true, force = false;
 	blk_status_t ret = BLK_STS_RESOURCE;
 	enum mq_issue_decision dec;
 	int srcu_idx;
@@ -1778,7 +1782,7 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	 */
 	if (blk_mq_hctx_stopped(hctx) || blk_queue_quiesced(q)) {
 		run_queue = false;
-		bypass = false;
+		force = true;
 		goto out_unlock;
 	}
 
@@ -1798,11 +1802,14 @@ static blk_status_t blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 out_unlock:
 	hctx_unlock(hctx, srcu_idx);
 
-	dec = blk_mq_make_dicision(ret, bypass);
+	dec = blk_mq_make_dicision(ret, bypass, force);
 	switch(dec) {
 	case MQ_ISSUE_INSERT_QUEUE:
 		blk_mq_sched_insert_request(rq, false, run_queue, false);
 		break;
+	case MQ_ISSUE_INSERT_DISPATCH:
+		blk_mq_request_bypass_insert(rq, run_queue);
+		break;
 	case MQ_ISSUE_END_REQUEST:
 		blk_mq_end_request(rq, ret);
 		break;
-- 
2.7.4

