Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD1CC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B219D2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g833a1kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B219D2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbeJ2RV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:21:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37968 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbeJ2RV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:21:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9T8Spjm013186;
        Mon, 29 Oct 2018 08:34:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=FeJiBIM4gj+Uv4+k6aC45dq/teyiiFKjX9alY/b/HNs=;
 b=g833a1kppqZdB0Qna3OBPACCftFIIYLwAJY5hXtVkGzzXwCCoZu7+jrJ8lmv0J/6SKJV
 zjzDq98hUVt0ia6UXcgGgUe+HlMSExoR9nDV30ddDlz/2yXnffR0hlXCKw0Coj/33tcd
 OPU4bVT8XG2sg7F84IZ/jwEINt5OuTXLT352T12ugbZ27TaeQ6VULAOCkRH92GwEMGgE
 tPzkBdkdJ0YvdtNFrzuIEG9MX5I2gi65UGWLjqz+yRhHBakmP+AGfOfx8lDpWeebGkCE
 ZhZlS70Sd0BQIZTUX6eTXeSLiNkWOF88b8kgV5cwjL+w53UXk5yAz7WZgnvKr/AklHFX yQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2ncfypm5ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Oct 2018 08:34:16 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9T8YAXE027565
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Oct 2018 08:34:10 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9T8YAJH008228;
        Mon, 29 Oct 2018 08:34:10 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Oct 2018 01:34:09 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/4] blk-mq: issue directly with bypass_insert 'false' in blk_mq_sched_insert_requests
Date:   Mon, 29 Oct 2018 16:33:32 +0800
Message-Id: <1540802013-2921-4-git-send-email-jianchao.w.wang@oracle.com>
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

It is not necessary to issue request directly with bypass_insert
'true' in blk_mq_sched_insert_requests and insert the non-issued
requests itself. Just set bypass_insert to 'false' and let
blk_mq_try_issue_directly handle them.

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
index e0aa068..9c6c858 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1834,15 +1834,7 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
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

