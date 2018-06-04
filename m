Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeFDJDT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:03:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46538 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbeFDJDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:03:17 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk, ming.lei@redhat.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] blk-mq: return when BLK_MQ_S_STOPPED in blk_mq_run_work_fn
Date: Mon,  4 Jun 2018 17:03:55 +0800
Message-Id: <1528103035-8009-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8913 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=880
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806040113
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if hctx is stopped, don't run the queue in blk_mq_run_work_fn.

Fixes: 15fe8a9 (blk-mq: remove blk_mq_delay_queue())
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9ce9cac..d0ee928 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1578,7 +1578,7 @@ static void blk_mq_run_work_fn(struct work_struct *work)
 	 * If we are stopped, don't run the queue.
 	 */
 	if (test_bit(BLK_MQ_S_STOPPED, &hctx->state))
-		clear_bit(BLK_MQ_S_STOPPED, &hctx->state);
+		return;
 
 	__blk_mq_run_hw_queue(hctx);
 }
-- 
2.7.4
