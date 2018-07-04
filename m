Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680F3C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B82A2245C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B82A2245C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934021AbeGDI5c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:57:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932324AbeGDI5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:57:13 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BEB749B44F8FA;
        Wed,  4 Jul 2018 16:56:59 +0800 (CST)
Received: from SZV1000284525.huawei.com (10.120.216.130) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.382.0; Wed, 4 Jul 2018 16:56:55 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 1/2] f2fs: fix to avoid broken of dnode block list
Date:   Wed, 4 Jul 2018 16:56:14 +0800
Message-ID: <20180704085614.13004-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f2fs recovery flow is relying on dnode block link list, it means fsynced
file recovery depends on previous dnode's persistence in the list, so
during fsync() we should wait on all regular inode's dnode writebacked
before issuing flush.

By this way, we can avoid dnode block list being broken by out-of-order
IO submission due to IO scheduler or driver.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2: add missing definition modification in f2fs.h.
 fs/f2fs/f2fs.h |  2 +-
 fs/f2fs/file.c | 17 ++++-------------
 fs/f2fs/node.c |  4 ++--
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 859ecde81dd0..a9da5a089cb4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2825,7 +2825,7 @@ pgoff_t f2fs_get_next_page_offset(struct dnode_of_data *dn, pgoff_t pgofs);
 int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode);
 int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from);
 int f2fs_truncate_xattr_node(struct inode *inode);
-int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino);
+int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi);
 int f2fs_remove_inode_page(struct inode *inode);
 struct page *f2fs_new_inode_page(struct inode *inode);
 struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 752ff678bfe0..ecca7b833268 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -292,19 +292,10 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		goto sync_nodes;
 	}
 
-	/*
-	 * If it's atomic_write, it's just fine to keep write ordering. So
-	 * here we don't need to wait for node write completion, since we use
-	 * node chain which serializes node blocks. If one of node writes are
-	 * reordered, we can see simply broken chain, resulting in stopping
-	 * roll-forward recovery. It means we'll recover all or none node blocks
-	 * given fsync mark.
-	 */
-	if (!atomic) {
-		ret = f2fs_wait_on_node_pages_writeback(sbi, ino);
-		if (ret)
-			goto out;
-	}
+
+	ret = f2fs_wait_on_node_pages_writeback(sbi);
+	if (ret)
+		goto out;
 
 	/* once recovery info is written, don't need to tack this */
 	f2fs_remove_ino_entry(sbi, ino, APPEND_INO);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 849c2ed9c152..0810c8117d46 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1710,7 +1710,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 	return ret;
 }
 
-int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
+int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi)
 {
 	pgoff_t index = 0;
 	struct pagevec pvec;
@@ -1726,7 +1726,7 @@ int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi, nid_t ino)
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pvec.pages[i];
 
-			if (ino && ino_of_node(page) == ino) {
+			if (IS_DNODE(page) && is_cold_node(page)) {
 				f2fs_wait_on_page_writeback(page, NODE, true);
 				if (TestClearPageError(page))
 					ret = -EIO;
-- 
2.18.0.rc1

