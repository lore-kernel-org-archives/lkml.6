Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E86C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BFF21874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546575633;
	bh=AdBdhI0wNEHnRS0xHXT9PYbegyI4DnY4KfHaq4c9Jv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aqelnwo4z8Ym31f0zDY4GoxUNMCGFYh70rP86LOXZMwXcqj713cGZOHp9H2BzLupr
	 lrevNcp/6vkoW1eqfI0kt2vY1y4mTIfPinQe+dH8YxnZfQx2ckzJtkHVJb8oAtRlPO
	 wwW43weZRwVtQoqS0EE5zPt7ZLJClqJ0ih/wRKDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfADEUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 23:20:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:56232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727353AbfADEU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 23:20:28 -0500
Received: from localhost (unknown [104.132.1.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29C4621871;
        Fri,  4 Jan 2019 04:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546575627;
        bh=AdBdhI0wNEHnRS0xHXT9PYbegyI4DnY4KfHaq4c9Jv0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rkCaBQSXhuQe/E9fIoi/rx3txxGZduL7EBgy0Qm8MYGkaqzaev3ft+X7fkODjpldL
         Nuv0YuocGK+PyfLLED3Qe7LAA1vf4J6lb4T3UPHyHChGRWZ7nDLDTS17S9a63Itb2P
         VImiUiRYKQ+RAe6PebkzhfRNGtTZOrvhpo5OdW7o=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: don't access node/meta inode mapping after iput
Date:   Thu,  3 Jan 2019 20:20:25 -0800
Message-Id: <20190104042025.31982-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20190104042025.31982-1-jaegeuk@kernel.org>
References: <20190104042025.31982-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes wrong access of address spaces of node and meta inodes after iput.

Fixes: 60aa4d5536ab ("f2fs: fix use-after-free issue when accessing sbi->stat_info")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/debug.c | 19 ++++++++++++-------
 fs/f2fs/super.c |  5 +++++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index ebcc121920ba..503fde8349e6 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -96,8 +96,10 @@ static void update_general_status(struct f2fs_sb_info *sbi)
 	si->free_secs = free_sections(sbi);
 	si->prefree_count = prefree_segments(sbi);
 	si->dirty_count = dirty_segments(sbi);
-	si->node_pages = NODE_MAPPING(sbi)->nrpages;
-	si->meta_pages = META_MAPPING(sbi)->nrpages;
+	if (sbi->node_inode)
+		si->node_pages = NODE_MAPPING(sbi)->nrpages;
+	if (sbi->meta_inode)
+		si->meta_pages = META_MAPPING(sbi)->nrpages;
 	si->nats = NM_I(sbi)->nat_cnt;
 	si->dirty_nats = NM_I(sbi)->dirty_nat_cnt;
 	si->sits = MAIN_SEGS(sbi);
@@ -175,7 +177,6 @@ static void update_sit_info(struct f2fs_sb_info *sbi)
 static void update_mem_info(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_stat_info *si = F2FS_STAT(sbi);
-	unsigned npages;
 	int i;
 
 	if (si->base_mem)
@@ -258,10 +259,14 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
 						sizeof(struct extent_node);
 
 	si->page_mem = 0;
-	npages = NODE_MAPPING(sbi)->nrpages;
-	si->page_mem += (unsigned long long)npages << PAGE_SHIFT;
-	npages = META_MAPPING(sbi)->nrpages;
-	si->page_mem += (unsigned long long)npages << PAGE_SHIFT;
+	if (sbi->node_inode) {
+		unsigned npages = NODE_MAPPING(sbi)->nrpages;
+		si->page_mem += (unsigned long long)npages << PAGE_SHIFT;
+	}
+	if (sbi->meta_inode) {
+		unsigned npages = META_MAPPING(sbi)->nrpages;
+		si->page_mem += (unsigned long long)npages << PAGE_SHIFT;
+	}
 }
 
 static int stat_show(struct seq_file *s, void *v)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index c46a1d4318d4..14f033e1ab42 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1075,7 +1075,10 @@ static void f2fs_put_super(struct super_block *sb)
 	f2fs_bug_on(sbi, sbi->fsync_node_num);
 
 	iput(sbi->node_inode);
+	sbi->node_inode = NULL;
+
 	iput(sbi->meta_inode);
+	sbi->meta_inode = NULL;
 
 	/*
 	 * iput() can update stat information, if f2fs_write_checkpoint()
@@ -3410,6 +3413,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	f2fs_release_ino_entry(sbi, true);
 	truncate_inode_pages_final(NODE_MAPPING(sbi));
 	iput(sbi->node_inode);
+	sbi->node_inode = NULL;
 free_stats:
 	f2fs_destroy_stats(sbi);
 free_nm:
@@ -3422,6 +3426,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_meta_inode:
 	make_bad_inode(sbi->meta_inode);
 	iput(sbi->meta_inode);
+	sbi->meta_inode = NULL;
 free_io_dummy:
 	mempool_destroy(sbi->write_io_dummy);
 free_percpu:
-- 
2.19.0.605.g01d371f741-goog

