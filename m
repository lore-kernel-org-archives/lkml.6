Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87B8C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 14:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953FD21546
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 14:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TbAw+hrV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953FD21546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJTWih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:38:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35272 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbeJTWig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:38:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9KENrg3163460;
        Sat, 20 Oct 2018 14:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=dP7tKOQOVr2JK6GxTllAKeQzR7f0x1sxzeLDI1E8Wt4=;
 b=TbAw+hrVxEKe3+37oIKf4ALgjG8uF7alqBhsw6dJEYTAhhSzu7Hd6UQ/ntxkB2YlbQbS
 G8RatSoQ9Kfs2xw9zB3R0R67QtfeHJZj8+ZH2KnBnlBC6umHZ5KywWs39IOjbbdWShCK
 ZVYCK5vGDADIVvl/scc8Yai8MtIWobVBs8LEWn4X36deR90N+LWAz0gL0PUkcnxspW/d
 mwTDh8b8t6Bw2Kir5ycXBCX4JBJ1GEKe1nvlVb7RzUZ8XJsQOoA8ZC3Ug30ssdt8hbDQ
 jH84j6qrMaBhITVgFgxpOXkyTeMiBSJ678eqILZaaF5wWe0u/ascFfwYz7FNlTUZWi6H tA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2n7w0q8vh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Oct 2018 14:27:51 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9KERpua003368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Oct 2018 14:27:51 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9KERoSb003749;
        Sat, 20 Oct 2018 14:27:50 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 20 Oct 2018 07:27:27 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     martin.petersen@oracle.com, tom.leiming@gmail.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] block: fix the DISCARD request merge
Date:   Sat, 20 Oct 2018 22:29:37 +0800
Message-Id: <1540045777-10290-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9051 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=998
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810200135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two cases when handle DISCARD merge
 - max_discard_segments == 1
   bios need to be contiguous
 - max_discard_segments > 1
   Only nvme right now. It takes every bio as a range and different
   range needn't to be contiguous.

But now, attempt_merge screws this up. It always consider contiguity
for DISCARD for the case max_discard_segments > 1 and cannot merge
contiguous DISCARD for the case max_discard_segments == 1, because
rq_attempt_discard_merge always returns false in this case.
This patch fixes both of the two cases above.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---

V2:
  - Add max_discard_segments > 1 checking in attempt_merge
  - Change patch title and comment
  - Add more comment in attempt_merge

 block/blk-merge.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 42a4674..8f22374 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -734,8 +734,15 @@ static struct request *attempt_merge(struct request_queue *q,
 	/*
 	 * not contiguous
 	 */
-	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
-		return NULL;
+	if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next)) {
+		/*
+		 * When max_discard_segments is bigger than 1 (only nvme right
+		 * now), needn't consider the contiguity.
+		 */
+		if (!(req_op(req) == REQ_OP_DISCARD &&
+		      queue_max_discard_segments(q) > 1))
+			return NULL;
+	}
 
 	if (rq_data_dir(req) != rq_data_dir(next)
 	    || req->rq_disk != next->rq_disk
@@ -757,10 +764,17 @@ static struct request *attempt_merge(struct request_queue *q,
 	 * If we are allowed to merge, then append bio list
 	 * from next to rq and release next. merge_requests_fn
 	 * will have updated segment counts, update sector
-	 * counts here. Handle DISCARDs separately, as they
-	 * have separate settings.
+	 * counts here.
+	 * Two cases of Handling DISCARD:
+	 *  - max_discard_segments == 1
+	 *    The bios need to be contiguous.
+	 *  - max_discard_segments > 1
+	 *    Only nvme right now. It takes every bio as a
+	 *    range and send them to controller together. The ranges
+	 *    needn't to be contiguous.
 	 */
-	if (req_op(req) == REQ_OP_DISCARD) {
+	if (req_op(req) == REQ_OP_DISCARD &&
+	    queue_max_discard_segments(q) > 1) {
 		if (!req_attempt_discard_merge(q, req, next))
 			return NULL;
 	} else if (!ll_merge_requests_fn(q, req, next))
-- 
2.7.4

