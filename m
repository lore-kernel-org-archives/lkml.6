Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeDQHNk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 03:13:40 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:60392 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbeDQHNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 03:13:38 -0400
From: Jiang Biao <jiang.biao2@zte.com.cn>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn,
        wen.yang99@zte.com.cn
Subject: [PATCH] blkcg: not hold blkcg lock when deactivating policy.
Date: Tue, 17 Apr 2018 15:10:33 +0800
Message-Id: <1523949033-91148-1-git-send-email-jiang.biao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-04-17 15:13:19,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-04-17 15:13:11,
        Serialize complete at 2018-04-17 15:13:11
X-MAIL: mse01.zte.com.cn w3H7DF72068129
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in the comment of blkcg_activate_policy(),
*Update of each blkg is protected by both queue and blkcg locks so
that holding either lock and testing blkcg_policy_enabled() is
always enough for dereferencing policy data.*
with queue lock held, there is no need to hold blkcg lock in
blkcg_deactivate_policy(). Similar case is in
blkcg_activate_policy(), which has removed holding of blkcg lock in
commit 4c55f4f9ad3001ac1fefdd8d8ca7641d18558e23.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Tejun Heo <tj@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index c2033a2..2b7f8d0 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1367,17 +1367,12 @@ void blkcg_deactivate_policy(struct request_queue *q,
 	__clear_bit(pol->plid, q->blkcg_pols);
 
 	list_for_each_entry(blkg, &q->blkg_list, q_node) {
-		/* grab blkcg lock too while removing @pd from @blkg */
-		spin_lock(&blkg->blkcg->lock);
-
 		if (blkg->pd[pol->plid]) {
 			if (pol->pd_offline_fn)
 				pol->pd_offline_fn(blkg->pd[pol->plid]);
 			pol->pd_free_fn(blkg->pd[pol->plid]);
 			blkg->pd[pol->plid] = NULL;
 		}
-
-		spin_unlock(&blkg->blkcg->lock);
 	}
 
 	spin_unlock_irq(q->queue_lock);
-- 
2.7.4
