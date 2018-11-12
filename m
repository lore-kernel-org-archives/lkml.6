Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05EABC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC087223CB
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 09:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Kob37Re5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC087223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbeKLTQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:16:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52496 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbeKLTQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:16:39 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAC9O57L084990;
        Mon, 12 Nov 2018 09:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=JMISNNELkc/MJcaZT1zyxKPSDBx1P0VUi7Pkxv+2ED0=;
 b=Kob37Re552K4IUGPG6IZDNSxZDz7hMqD7QtTM63eNx9h+K+INPcjq+tMr/iYFvE5NPU/
 lBm7YzTrtAS7hzU56jaEOjATVgMS8avT52sniVaH66PNm9gCAIjUfSOSlG7KDDOSmQDR
 +SNUNornutq+wFIHtiB2f7sjH/M4SmCw9T/DTydIn1Ag+/LpN0bBG7kVVR4+nyFHe4Vz
 P0blE4rKrPAnqRTcqeS7T0tOAgjwt5TIV1uoWQYxbl96jGF94veCAoTDQp1MxmxyUE0e
 KQ4funfc+xEs7O0wtnsvG5QtxwPd/SGcmjbSaqdCoOcUZnv/S19KswwJr3Q5eOyvT6QO PQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2nnw6ec78a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Nov 2018 09:24:15 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAC9OERp029618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Nov 2018 09:24:14 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAC9OEKw007312;
        Mon, 12 Nov 2018 09:24:14 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.70.234)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 12 Nov 2018 01:24:14 -0800
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 5/6] blk-mq: issue directly with bypass 'false' in blk_mq_sched_insert_requests
Date:   Mon, 12 Nov 2018 17:23:28 +0800
Message-Id: <1542014609-1769-6-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9074 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811120086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not necessary to issue request directly with bypass 'true'
in blk_mq_sched_insert_requests and insert the non-issued requests
itself. Just set bypass to 'false' and let blk_mq_try_issue_directly
handle them totally.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-sched.c |  8 +++-----
 block/blk-mq.c       | 11 +----------
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 66fda19..9af57c8 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -410,12 +410,10 @@ void blk_mq_sched_insert_requests(struct blk_mq_hw_ctx *hctx,
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
index 7915f44..f27d547 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1880,20 +1880,11 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct list_head *list)
 {
 	while (!list_empty(list)) {
-		blk_status_t ret;
 		struct request *rq = list_first_entry(list, struct request,
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
+		blk_mq_try_issue_directly(hctx, rq, NULL, false);
 	}
 }
 
-- 
2.7.4

