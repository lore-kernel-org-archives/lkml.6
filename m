Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E22AC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4355A2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 09:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NLYF7NtU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4355A2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeJZSCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 14:02:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52148 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 14:02:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9Q9J8Vo017699;
        Fri, 26 Oct 2018 09:26:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=DVsT1P9EQbgOncA6VVOziLLOZzf4VL5zAOb/i3z2x5w=;
 b=NLYF7NtUL1IzafXcyGj6hjXd3H1f7KA8nM52rmZRprA1diBx8kuYMhYeF/nQzcktPy+6
 hPfsNJpl5apLbG+MD2oVL/tD8Mp7Jq1lHh+sxutf82FiU4+t+9U05RWstJaXo9bra4C2
 WqDgpu2qW6ZFZeLEf+pPPEjXyw0IybXuHGCfhQf+PnRt5Wf1ImK/gwg1Gj5R/HihHGgR
 Xf/SR8mpowSgQXu7e7q4dsSLLuEEUml5cZAYFj1EfRhNSb3CjdqjwqrPcAs/nCsQ0zFe
 HIJqVezire8UgMo/lSxYVfDOYnAyFTCCfz/U+Nt+Oq6Q1hQz5JwecoXID6I0M/FTJiR4 5Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n7w0r673r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 09:26:17 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9Q9QH2Y010066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Oct 2018 09:26:17 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9Q9QGTF031051;
        Fri, 26 Oct 2018 09:26:17 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 26 Oct 2018 02:26:16 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     martin.petersen@oracle.com, tom.leiming@gmail.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4] block: fix the DISCARD request merge
Date:   Fri, 26 Oct 2018 17:28:36 +0800
Message-Id: <1540546116-1620-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9057 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810260083
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

 block/blk-merge.c | 47 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 42a4674..cf817c7a 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -714,6 +714,32 @@ static void blk_account_io_merge(struct request *req)
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
@@ -731,12 +757,6 @@ static struct request *attempt_merge(struct request_queue *q,
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
@@ -760,11 +780,19 @@ static struct request *attempt_merge(struct request_queue *q,
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
@@ -888,8 +916,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 
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

