Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB42C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9749A20856
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 11:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J9K2fnvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9749A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeJ0Uax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 16:30:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41102 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727723AbeJ0Uax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 16:30:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9RBmxLS134533;
        Sat, 27 Oct 2018 11:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=IfS9dAyxmugdEk74kB7msmDS1Lvxj07McR1SyBFBGHk=;
 b=J9K2fnvzLTzysW1V6INO2/klXEAq8O4UrjpCTwTmxjGCpOa0EAWajOYqjxjgcyXwHBIE
 BqSshdLjgvkar1fHyxcQIWLjj3+WDuClA5o3z/7WEm+BDN/64VbaGGoVnM3WRSJq8Dmi
 ztTAFUe7Dz+6SNYAzUKjCmEl9nVvNzAknw1vK2va0IcaFP4vI///ytyveahCTCslz93+
 rSBLGxq6GOQAFanQWhGeImNK9dEVDrxEL9PLAZi3cK7SsYbMoqL1kUp6udRwyIONmHgZ
 qmiar6sMHkaL81WdViF39120UpBJL60qnY+lV6N5UKt2/SN3fnvO8ZwgiAJhoFp2SnxT DA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2ncgnqgmft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Oct 2018 11:50:06 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9RBo0W5021294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Oct 2018 11:50:00 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9RBo0mb027167;
        Sat, 27 Oct 2018 11:50:00 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 27 Oct 2018 04:49:59 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     martin.petersen@oracle.com, tom.leiming@gmail.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5] block: fix the DISCARD request merge
Date:   Sat, 27 Oct 2018 19:52:14 +0800
Message-Id: <1540641134-21485-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9058 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810270111
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

V5:
 - get rid of the redundant 'else' in blk_discard_mergable

V4:
 - introduce blk_try_req_merge as suggestion of Christoph.

V3:
 - Introduce blk_discard_mergable into attempt_merge and
   blk_try_merge.
 - Some comment changes.

V2:
 - Add max_discard_segments > 1 checking in attempt_merge.
 - Change patch title and comment.
 - Add more comment in attempt_merge

 block/blk-merge.c | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 42a4674..6b5ad27 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -714,6 +714,31 @@ static void blk_account_io_merge(struct request *req)
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
+	return false;
+}
+
+enum elv_merge blk_try_req_merge(struct request *req, struct request *next)
+{
+	if (blk_discard_mergable(req))
+		return ELEVATOR_DISCARD_MERGE;
+	else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next))
+		return ELEVATOR_BACK_MERGE;
+
+	return ELEVATOR_NO_MERGE;
+}
 
 /*
  * For non-mq, this has to be called with the request spinlock acquired.
@@ -731,12 +756,6 @@ static struct request *attempt_merge(struct request_queue *q,
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
@@ -760,11 +779,19 @@ static struct request *attempt_merge(struct request_queue *q,
 	 * counts here. Handle DISCARDs separately, as they
 	 * have separate settings.
 	 */
-	if (req_op(req) == REQ_OP_DISCARD) {
+
+	switch (blk_try_req_merge(req, next)) {
+	case ELEVATOR_DISCARD_MERGE:
 		if (!req_attempt_discard_merge(q, req, next))
 			return NULL;
-	} else if (!ll_merge_requests_fn(q, req, next))
+		break;
+	case ELEVATOR_BACK_MERGE:
+		if (!ll_merge_requests_fn(q, req, next))
+			return NULL;
+		break;
+	default:
 		return NULL;
+	}
 
 	/*
 	 * If failfast settings disagree or any of the two is already
@@ -888,8 +915,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 
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

