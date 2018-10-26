Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD194ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9549C2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="txO/NUUo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9549C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJZQjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:39:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51724 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeJZQi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:38:59 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9Q7x9IW141839;
        Fri, 26 Oct 2018 08:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=U3dcBfxuwVQrFHyzotA4CjzOMhfRCpz/VvmHSxU0+vo=;
 b=txO/NUUofgREDSR4wQLxfOTjiGKhFDTnZ1jyiT/pk4Nr8wbZYxyIV8WhvaRz6Z1Sxpij
 EO8+/9F9BiMJshQgJbHtSpWCc3PTksY61BB0NKC9DJPdXy+rAPffGTYtlS8+P+Vu1qVC
 OLhLL3Mq4ZJAha53KQBlnVVsh+UO0llqPFqOFkTPFTwzqXntaC28ObMIbleB/3VOmQaX
 /2O6EEJeEFXZlF68VXYi7StnTWvuGpPsSxGalChyzhsPX9+X+hqavj9WIBfyKlNluk12
 rrx74ETvtIMyjEyRo2T/2YQnO2+bWvW8KVtxAVzvOo/hB7tjOJ2hb4vv2DKiDA9er1qt Kg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n7w0r5qxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 08:02:54 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9Q82s8I032309
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 08:02:54 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9Q82rDJ004421;
        Fri, 26 Oct 2018 08:02:53 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Oct 2018 01:02:53 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/3] blk-mq: issue directly with bypass 'false' in blk_mq_sched_insert_requests
Date:   Sat, 27 Oct 2018 00:01:10 +0800
Message-Id: <1540569671-6589-3-git-send-email-jianchao.w.wang@oracle.com>
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

It is not necessary to issue request directly with bypass 'true' in
blk_mq_sched_insert_requests and insert the non-issued requests
itself. Just set bypass to 'false' and let blk_mq_try_issue_directly
handle them.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-sched.c |  8 +++-----
 block/blk-mq.c       | 10 +---------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 29bfe80..23cd97e 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -411,12 +411,10 @@ void blk_mq_sched_insert_requests(struct request_queue *q,
 		 * busy in case of 'none' scheduler, and this way may save
 		 * us one extra enqueue & dequeue to sw queue.
 		 */
-		if (!hctx->dispatch_busy && !e && !run_queue_async) {
+		if (!hctx->dispatch_busy && !e && !run_queue_async)
 			blk_mq_try_issue_list_directly(hctx, list);
-			if (list_empty(list))
-				return;
-		}
-		blk_mq_insert_requests(hctx, ctx, list);
+		else
+			blk_mq_insert_requests(hctx, ctx, list);
 	}
 
 	blk_mq_run_hw_queue(hctx, run_queue_async);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index a81d2ca..71b829c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1802,15 +1802,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 				queuelist);
 
 		list_del_init(&rq->queuelist);
-		ret = blk_mq_request_issue_directly(rq);
-		if (ret != BLK_STS_OK) {
-			if (ret == BLK_STS_RESOURCE ||
-					ret == BLK_STS_DEV_RESOURCE) {
-				list_add(&rq->queuelist, list);
-				break;
-			}
-			blk_mq_end_request(rq, ret);
-		}
+		ret = blk_mq_try_issue_directly(hctx, rq, NULL, false);
 	}
 }
 
-- 
2.7.4

