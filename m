Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753337AbeDPHzV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 03:55:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60318 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbeDPHzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 03:55:19 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk, ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: mark hctx RESTART when get budget fails
Date: Mon, 16 Apr 2018 15:55:36 +0800
Message-Id: <1523865336-17326-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8864 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804160073
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When get budget fails, blk_mq_sched_dispatch_requests does not do
anything to ensure the hctx to be restarted. We can survive from
this, because only the scsi implements .get_budget and it always
runs the hctx queues when request is completed.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-sched.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 25c14c5..49e7cd9 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -102,8 +102,10 @@ static void blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
 				!e->type->ops.mq.has_work(hctx))
 			break;
 
-		if (!blk_mq_get_dispatch_budget(hctx))
+		if (!blk_mq_get_dispatch_budget(hctx)) {
+			blk_mq_sched_mark_restart_hctx(hctx);
 			break;
+		}
 
 		rq = e->type->ops.mq.dispatch_request(hctx);
 		if (!rq) {
@@ -148,8 +150,10 @@ static void blk_mq_do_dispatch_ctx(struct blk_mq_hw_ctx *hctx)
 		if (!sbitmap_any_bit_set(&hctx->ctx_map))
 			break;
 
-		if (!blk_mq_get_dispatch_budget(hctx))
+		if (!blk_mq_get_dispatch_budget(hctx)) {
+			blk_mq_sched_mark_restart_hctx(hctx);
 			break;
+		}
 
 		rq = blk_mq_dequeue_from_ctx(hctx, ctx);
 		if (!rq) {
-- 
2.7.4
