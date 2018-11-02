Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D8CC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEBE2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qWu450Er"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BEBE2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbeKBQQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 12:16:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46322 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbeKBQQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 12:16:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA278p4E052023;
        Fri, 2 Nov 2018 07:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=T+bmX7Zqj753umvIWRaK2lmXBxtIoXAE0V0dNmNRtGI=;
 b=qWu450Eruwv8BZo/T8nmY4yZjJQodLbGReLNUtygBiTqHyvkxF2KM0q9QTbJqc+tlyTN
 ir8Q6xKfjoF9/Jb/+CJEa+lEy518G4GAgoW/gY2HOZ4Di93SDXluiV3k6Z9P0xO7WDeA
 EHeLitW4M7JlRoJwM6rDLmMkzb4ptH73GRmHq8DvoJG6ERoCRgVHdcX9w7LAXNXfVvZp
 bJfi3NT8T8gnDEA3Z+aLWljiH2Olhi9CJWRu2GgAjpZqZFXSKRfqcbOqyHVSF67DUL+9
 uHzvtZPMOa7TcarqM8/6JtFZMWETSIHsFZ1JFAxzYMo4KqZDp68m82iakMZ25CeqQXlV 7Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2nducmhgbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Nov 2018 07:10:14 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA27AECf019620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Nov 2018 07:10:14 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA27ADBs005689;
        Fri, 2 Nov 2018 07:10:13 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Nov 2018 00:10:13 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/5] blk-mq: make __blk_mq_issue_directly be able to accept NULL cookie pointer
Date:   Fri,  2 Nov 2018 15:08:52 +0800
Message-Id: <1541142536-1431-2-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541142536-1431-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1541142536-1431-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9064 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=943
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811020067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make __blk_mq_issue_directly be able to accept a NULL cookie pointer
and remove the dummy unused_cookie in blk_mq_request_issue_directly.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index dcf10e3..af5b591 100644
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
@@ -1711,19 +1709,23 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	switch (ret) {
 	case BLK_STS_OK:
 		blk_mq_update_dispatch_busy(hctx, false);
-		*cookie = new_cookie;
+		new_cookie = request_to_qc_t(hctx, rq);
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
 		blk_mq_update_dispatch_busy(hctx, true);
 		__blk_mq_requeue_request(rq);
+		new_cookie = BLK_QC_T_NONE;
 		break;
 	default:
 		blk_mq_update_dispatch_busy(hctx, false);
-		*cookie = BLK_QC_T_NONE;
+		new_cookie = BLK_QC_T_NONE;
 		break;
 	}
 
+	if (cookie)
+		*cookie = new_cookie;
+
 	return ret;
 }
 
@@ -1791,12 +1793,11 @@ blk_status_t blk_mq_request_issue_directly(struct request *rq)
 {
 	blk_status_t ret;
 	int srcu_idx;
-	blk_qc_t unused_cookie;
 	struct blk_mq_ctx *ctx = rq->mq_ctx;
 	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(rq->q, ctx->cpu);
 
 	hctx_lock(hctx, &srcu_idx);
-	ret = __blk_mq_try_issue_directly(hctx, rq, &unused_cookie, true);
+	ret = __blk_mq_try_issue_directly(hctx, rq, NULL, true);
 	hctx_unlock(hctx, srcu_idx);
 
 	return ret;
-- 
2.7.4

