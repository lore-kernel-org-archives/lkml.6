Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E809DC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51D92082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RTPyIxiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51D92082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeJXLb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:31:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37182 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeJXLb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:31:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9O34UpT144651;
        Wed, 24 Oct 2018 03:05:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=8fXUAKSrJRfFsx03BMWStnZB7/MToZv3Ic1P6zpjaro=;
 b=RTPyIxiWm/EX35W9RTWNBhvnWnRzGx9bu9q8y0Y1HmUxUcw50BElMKU+R9VX4vHbDIk1
 dtEHunG2021FKHB6eSkvbE4xcNQRKQSaRaA1nqAyTMYNz24b+JsBm573cyLCfL+W73Sn
 2fTPjE6rmkWFsrbpHBbEcmKJD4akdONUg8dQ2wM5q/X5NCCgY912eKQ2QlgEgyVVMSLQ
 p2xyxISekAFzGWHifCw/BFg1arGWIGc4tcFoEK6D3wIKiWKeTwvU1p86g7GjQqGI0N6x
 VAREwlt7XriAzDAfoejnWd5sfXYt7sS/uaeMiUjRODsixoupPXvhSHlE7gM121PfqDh6 mw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2n7vaq0tv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 03:05:20 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9O35D7b010018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Oct 2018 03:05:14 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9O35DQg022106;
        Wed, 24 Oct 2018 03:05:13 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Oct 2018 20:05:13 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     martin.petersen@oracle.com, tom.leiming@gmail.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3] block: fix the DISCARD request merge
Date:   Wed, 24 Oct 2018 11:07:30 +0800
Message-Id: <1540350450-15208-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9055 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810240025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two cases when handle DISCARD merge.
If max_discard_segments == 1, the bios/requests need to be contiguous
to merge. If max_discard_segments > 1, it takes every bio as a range
and different range needn't to be contiguous.

But now, attempt_merge screws this up. It always consider contiguity
for DISCARD for the case max_discard_segments > 1 and cannot merge
contiguous DISCARD for the case max_discard_segments == 1, because
rq_attempt_discard_merge always returns false in this case.
This patch fixes both of the two cases above.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---

V3:
 - Introduce blk_discard_mergable into attempt_merge and
   blk_try_merge.
 - Some comment changes.

V2:
 - Add max_discard_segments > 1 checking in attempt_merge.
 - Change patch title and comment.
 - Add more comment in attempt_merge

 block/blk-merge.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 42a4674..b258de0 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -714,6 +714,22 @@ static void blk_account_io_merge(struct request *req)
 		part_stat_unlock();
 	}
 }
+/*
+ * Two cases of handling DISCARD merge:
+ * If max_discard_segments > 1, the driver takes every bio
+ * as a range and send them to controller together. The ranges
+ * needn't to be contiguous.
+ * Otherwise, the bios/requests will be handled as same as
+ * others which should be contiguous.
+ */
+static inline bool blk_discard_mergable(struct request *req)
+{
+	if (req_op(req) == REQ_OP_DISCARD &&
+	    queue_max_discard_segments(req->q) > 1)
+		return true;
+	else
+		return false;
+}
 
 /*
  * For non-mq, this has to be called with the request spinlock acquired.
@@ -731,12 +747,6 @@ static struct request *attempt_merge(struct request_queue *q,
 	if (req_op(req) != req_op(next))
 		return NULL;
 
-	/*
-	 * not contiguous
-	 */
-	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
-		return NULL;
-
 	if (rq_data_dir(req) != rq_data_dir(next)
 	    || req->rq_disk != next->rq_disk
 	    || req_no_special_merge(next))
@@ -760,11 +770,16 @@ static struct request *attempt_merge(struct request_queue *q,
 	 * counts here. Handle DISCARDs separately, as they
 	 * have separate settings.
 	 */
-	if (req_op(req) == REQ_OP_DISCARD) {
+
+	if (blk_discard_mergable(req)) {
 		if (!req_attempt_discard_merge(q, req, next))
 			return NULL;
-	} else if (!ll_merge_requests_fn(q, req, next))
+	} else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next)) {
+		if (!ll_merge_requests_fn(q, req, next))
+			return NULL;
+	} else {
 		return NULL;
+	}
 
 	/*
 	 * If failfast settings disagree or any of the two is already
@@ -888,8 +903,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
 {
-	if (req_op(rq) == REQ_OP_DISCARD &&
-	    queue_max_discard_segments(rq->q) > 1)
+	if (blk_discard_mergable(rq))
 		return ELEVATOR_DISCARD_MERGE;
 	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
 		return ELEVATOR_BACK_MERGE;
-- 
2.7.4

