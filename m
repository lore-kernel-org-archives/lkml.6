Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeDQDoT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 23:44:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42104 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeDQDoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 23:44:17 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: start request gstate with gen 1
Date: Tue, 17 Apr 2018 11:44:43 +0800
Message-Id: <1523936683-1522-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8865 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=960
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804170033
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rq->gstate and rq->aborted_gstate both are zero before rqs are
allocated. If we have a small timeout, when the timer fires,
there could be rqs that are never allocated, and also there could
be rq that has been allocated but not initialized and started. At
the moment, the rq->gstate and rq->aborted_gstate both are 0, thus
the blk_mq_terminate_expired will identify the rq is timed out and
invoke .timeout early.

For scsi, this will cause scsi_times_out to be invoked before the
scsi_cmnd is not initialized, scsi_cmnd->device is still NULL at
the moment, then we will get crash.

Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Martin Steigerwald <Martin@Lichtvoll.de>
Cc: stable@vger.kernel.org
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-core.c | 4 ++++
 block/blk-mq.c   | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index abcb868..ce62681 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -201,6 +201,10 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->part = NULL;
 	seqcount_init(&rq->gstate_seq);
 	u64_stats_init(&rq->aborted_gstate_sync);
+	/*
+	 * See comment of blk_mq_init_request
+	 */
+	WRITE_ONCE(rq->gstate, MQ_RQ_GEN_INC);
 }
 EXPORT_SYMBOL(blk_rq_init);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f5c7dbc..d62030a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2069,6 +2069,13 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 
 	seqcount_init(&rq->gstate_seq);
 	u64_stats_init(&rq->aborted_gstate_sync);
+	/*
+	 * start gstate with gen 1 instead of 0, otherwise it will be equal
+	 * to aborted_gstate, and be identified timed out by
+	 * blk_mq_terminate_expired.
+	 */
+	WRITE_ONCE(rq->gstate, MQ_RQ_GEN_INC);
+
 	return 0;
 }
 
-- 
2.7.4
