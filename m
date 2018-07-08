Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE671C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6956B208CC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 14:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV0viIX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6956B208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754075AbeGHOFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 10:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751738AbeGHOFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 10:05:18 -0400
Received: from localhost.localdomain (unknown [49.77.239.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02A98208D5;
        Sun,  8 Jul 2018 14:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531058718;
        bh=0Lqrum6P5RsuCSobKOfnKVSUmJhZK593OLp1REfc3a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XV0viIX5tSQy8MbIs4Ony2XPUZWF3lhYJTkQ9Jk/cDSh96jyg0YnhPvfp2aK2YpAH
         Rg/0vCzdSMNDM34TaoUZzv1mJ4Y8iS2N6g2qGUCRyQ9C7bLT+3kDTuMfBlxZnsab4S
         Qlvp0fM71K96MS1bwGobz8JgohZnHuQsJg5KQtAo=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3 2/2] f2fs: let checkpoint flush dnode page of regular
Date:   Sun,  8 Jul 2018 22:04:43 +0800
Message-Id: <20180708140443.23244-2-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
In-Reply-To: <20180708140443.23244-1-chao@kernel.org>
References: <20180708140443.23244-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Fsyncer will wait on all dnode pages of regular writeback before flushing,
if there are async dnode pages blocked by IO scheduler, it may decrease
fsync's performance.

In this patch, we choose to let f2fs_balance_fs_bg() to trigger checkpoint
to flush these dnode pages of regular, so async IO of dnode page can be
elimitnated, making fsyncer only need to wait for sync IO.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- rebase code.
 fs/f2fs/node.c    | 8 +++++++-
 fs/f2fs/node.h    | 5 +++++
 fs/f2fs/segment.c | 4 +++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 31dc372c56a0..c48e2a2e5e82 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1453,6 +1453,10 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		goto redirty_out;
 
+	if (wbc->sync_mode == WB_SYNC_NONE &&
+			IS_DNODE(page) && is_cold_node(page))
+		goto redirty_out;
+
 	/* get old block addr of this node page */
 	nid = nid_of_node(page);
 	f2fs_bug_on(sbi, page->index != nid);
@@ -1778,10 +1782,12 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
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
index 47b6595a078c..99beaf0a2dea 100644
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
2.16.2.17.g38e79b1fd

