Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeB1FI3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 00:08:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbeB1FI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 00:08:28 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA0C21795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: do gc in greedy mode for whole range if gc_urgent mode is set
Date: Tue, 27 Feb 2018 21:08:26 -0800
Message-Id: <20180228050826.83137-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c9-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, f2fs conducts GC on 8GB range only based on slow cost-benefit.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index bc9420ce2275..bfb7a4a3a929 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -162,12 +162,17 @@ static int select_gc_type(struct f2fs_gc_kthread *gc_th, int gc_type)
 {
 	int gc_mode = (gc_type == BG_GC) ? GC_CB : GC_GREEDY;
 
-	if (gc_th && gc_th->gc_idle) {
+	if (!gc_th)
+		return gc_mode;
+
+	if (gc_th->gc_idle) {
 		if (gc_th->gc_idle == 1)
 			gc_mode = GC_CB;
 		else if (gc_th->gc_idle == 2)
 			gc_mode = GC_GREEDY;
 	}
+	if (gc_th->gc_urgent)
+		gc_mode = GC_GREEDY;
 	return gc_mode;
 }
 
@@ -189,7 +194,9 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
 	}
 
 	/* we need to check every dirty segments in the FG_GC case */
-	if (gc_type != FG_GC && p->max_search > sbi->max_victim_search)
+	if (gc_type != FG_GC &&
+			(sbi->gc_thread && !sbi->gc_thread->gc_urgent) &&
+			p->max_search > sbi->max_victim_search)
 		p->max_search = sbi->max_victim_search;
 
 	/* let's select beginning hot/small space first in no_heap mode*/
-- 
2.15.0.531.g2ccb3012c9-goog
