Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0109C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6AF21F43
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6AF21F43
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbeGCMNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:13:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50763 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752251AbeGCMNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:13:42 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9227020D72EA2;
        Tue,  3 Jul 2018 20:13:39 +0800 (CST)
Received: from SZV1000284525.huawei.com (10.120.216.130) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.382.0; Tue, 3 Jul 2018 20:13:33 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: let checkpoint flush dnode page of regular
Date:   Tue, 3 Jul 2018 20:12:53 +0800
Message-ID: <20180703121253.44560-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180703121253.44560-1-yuchao0@huawei.com>
References: <20180703121253.44560-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fsyncer will wait on all dnode pages of regular writeback before flushing,
if there are async dnode pages blocked by IO scheduler, it may decrease
fsync's performance.

In this patch, we choose to let f2fs_balance_fs_bg() to trigger checkpoint
to flush these dnode pages of regular, so async IO of dnode page can be
elimitnated, making fsyncer only need to wait for sync IO.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c    | 8 +++++++-
 fs/f2fs/node.h    | 5 +++++
 fs/f2fs/segment.c | 4 +++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 0810c8117d46..eeee582cee32 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1384,6 +1384,10 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
 
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+			IS_DNODE(page) && is_cold_node(page))
+		goto redirty_out;
+
 	/* get old block addr of this node page */
 	nid = nid_of_node(page);
 	f2fs_bug_on(sbi, page->index != nid);
@@ -1698,10 +1702,12 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 	}
 
 	if (step < 2) {
+		if (wbc->sync_mode == WB_SYNC_NONE && step == 1)
+			goto out;
 		step++;
 		goto next_step;
 	}
-
+out:
 	if (nwritten)
 		f2fs_submit_merged_write(sbi, NODE);
 
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index b95e49e4a928..b0da4c26eebb 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -135,6 +135,11 @@ static inline bool excess_cached_nats(struct f2fs_sb_info *sbi)
 	return NM_I(sbi)->nat_cnt >= DEF_NAT_CACHE_THRESHOLD;
 }
 
+static inline bool excess_dirty_nodes(struct f2fs_sb_info *sbi)
+{
+	return get_pages(sbi, F2FS_DIRTY_NODES) >= sbi->blocks_per_seg * 8;
+}
+
 enum mem_type {
 	FREE_NIDS,	/* indicates the free nid list */
 	NAT_ENTRIES,	/* indicates the cached nat entry */
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bbe6e1596611..13f5e3665bf0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -503,7 +503,8 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 	else
 		f2fs_build_free_nids(sbi, false, false);
 
-	if (!is_idle(sbi) && !excess_dirty_nats(sbi))
+	if (!is_idle(sbi) &&
+		(!excess_dirty_nats(sbi) && !excess_dirty_nodes(sbi)))
 		return;
 
 	/* checkpoint is the only way to shrink partial cached entries */
@@ -511,6 +512,7 @@ void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 			!f2fs_available_free_memory(sbi, INO_ENTRIES) ||
 			excess_prefree_segs(sbi) ||
 			excess_dirty_nats(sbi) ||
+			excess_dirty_nodes(sbi) ||
 			f2fs_time_over(sbi, CP_TIME)) {
 		if (test_opt(sbi, DATA_FLUSH)) {
 			struct blk_plug plug;
-- 
2.18.0.rc1

