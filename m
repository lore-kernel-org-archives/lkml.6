Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751721AbeB1Cor (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 21:44:47 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:59810 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751605AbeB1Cop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 21:44:45 -0500
From: Liu Song <liu.song11@zte.com.cn>
To: richard@nod.at, dedekind1@gmail.com, adrian.hunter@intel.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn,
        liu.song11@zte.com.cn
Subject: [PATCH] fs/UBIFS: make 'sum' definition closer to where it is used
Date: Wed, 28 Feb 2018 10:42:03 +0800
Message-Id: <1519785723-105686-1-git-send-email-liu.song11@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-02-28 10:44:44,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-02-28 10:44:32,
        Serialize complete at 2018-02-28 10:44:32
X-MAIL: mse01.zte.com.cn w1S2ieNW074802
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Local var sum is only used in one branch, and it may be not used if 
it is defined outside the branch. Try to move the definition into 
the branch to make it closer to where it is actually used. 

Signed-off-by: Liu Song <liu.song11@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 fs/ubifs/find.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/find.c b/fs/ubifs/find.c
index 2dcf3d4..4eb11c1 100644
--- a/fs/ubifs/find.c
+++ b/fs/ubifs/find.c
@@ -233,7 +233,7 @@ static const struct ubifs_lprops *scan_for_dirty(struct ubifs_info *c,
 int ubifs_find_dirty_leb(struct ubifs_info *c, struct ubifs_lprops *ret_lp,
 			 int min_space, int pick_free)
 {
-	int err = 0, sum, exclude_index = pick_free == 2 ? 1 : 0;
+	int err = 0, exclude_index = pick_free == 2 ? 1 : 0;
 	const struct ubifs_lprops *lp = NULL, *idx_lp = NULL;
 	struct ubifs_lpt_heap *heap, *idx_heap;
 
@@ -285,6 +285,7 @@ int ubifs_find_dirty_leb(struct ubifs_info *c, struct ubifs_lprops *ret_lp,
 	idx_heap = &c->lpt_heap[LPROPS_DIRTY_IDX - 1];
 
 	if (idx_heap->cnt && !exclude_index) {
+		int sum;
 		idx_lp = idx_heap->arr[0];
 		sum = idx_lp->free + idx_lp->dirty;
 		/*
-- 
1.8.3.1
