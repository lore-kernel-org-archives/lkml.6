Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9D2C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B63620811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B63620811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeLNGVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:21:46 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726615AbeLNGVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:21:41 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0ADEABB1E2A42;
        Fri, 14 Dec 2018 14:21:32 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Fri, 14 Dec 2018 14:21:25 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 2/3] f2fs: check PageWriteback flag for ordered case
Date:   Fri, 14 Dec 2018 14:21:21 +0800
Message-ID: <20181214062121.9256-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For all ordered cases in f2fs_wait_on_page_writeback(), we need to
check PageWriteback status, so let's clean up to relocate the check
into f2fs_wait_on_page_writeback().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
- cover f2fs_sync_meta_pages and f2fs_write_cache_pages as well.
 fs/f2fs/checkpoint.c | 2 --
 fs/f2fs/data.c       | 1 -
 fs/f2fs/node.c       | 3 ---
 fs/f2fs/segment.c    | 6 ++++--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 4f02461f348c..f6c01487456a 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -372,7 +372,6 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 
 			f2fs_wait_on_page_writeback(page, META, true);
 
-			BUG_ON(PageWriteback(page));
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
@@ -1291,7 +1290,6 @@ static void commit_checkpoint(struct f2fs_sb_info *sbi,
 	int err;
 
 	f2fs_wait_on_page_writeback(page, META, true);
-	f2fs_bug_on(sbi, PageWriteback(page));
 
 	memcpy(page_address(page), src, PAGE_SIZE);
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index fd3a1e5ab6d9..d4cf4e1f83f2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2154,7 +2154,6 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 					goto continue_unlock;
 			}
 
-			BUG_ON(PageWriteback(page));
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c09df777f66f..30a4427aaa94 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1599,7 +1599,6 @@ int f2fs_move_node_page(struct page *node_page, int gc_type)
 		};
 
 		f2fs_wait_on_page_writeback(node_page, NODE, true);
-		f2fs_bug_on(F2FS_P_SB(node_page), PageWriteback(node_page));
 
 		set_page_dirty(node_page);
 
@@ -1691,7 +1690,6 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			}
 
 			f2fs_wait_on_page_writeback(page, NODE, true);
-			BUG_ON(PageWriteback(page));
 
 			set_fsync_mark(page, 0);
 			set_dentry_mark(page, 0);
@@ -1825,7 +1823,6 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 
 			f2fs_wait_on_page_writeback(page, NODE, true);
 
-			BUG_ON(PageWriteback(page));
 			if (!clear_page_dirty_for_io(page))
 				goto continue_unlock;
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e2e971e89b2d..007a6f6c74c7 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3281,10 +3281,12 @@ void f2fs_wait_on_page_writeback(struct page *page,
 		struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 
 		f2fs_submit_merged_write_cond(sbi, NULL, page, 0, type);
-		if (ordered)
+		if (ordered) {
 			wait_on_page_writeback(page);
-		else
+			f2fs_bug_on(sbi, PageWriteback(page));
+		} else {
 			wait_for_stable_page(page);
+		}
 	}
 }
 
-- 
2.18.0.rc1

