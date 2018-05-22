Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeEVHHW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:07:22 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43988 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbeEVHHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:07:20 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: add plug trace event for multiple hw queues case
Date: Tue, 22 May 2018 15:08:10 +0800
Message-Id: <1526972890-1878-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8900 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=972
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805220085
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no plug trace event for multiple hw queues. This is
confusing when check block trace event log and find unplug one
there. Add plug trace event when request is added to a empty plug
list.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9ce9cac..ddf726a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1935,6 +1935,9 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			same_queue_rq = NULL;
 		if (same_queue_rq)
 			list_del_init(&same_queue_rq->queuelist);
+		else
+			trace_block_plug(q);
+
 		list_add_tail(&rq->queuelist, &plug->mq_list);
 
 		blk_mq_put_ctx(data.ctx);
-- 
2.7.4
