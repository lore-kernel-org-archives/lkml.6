Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeBCCse (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 21:48:34 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:41338 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752513AbeBCCs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 21:48:27 -0500
From: Yunlong Song <yunlong.song@huawei.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>, <yuchao0@huawei.com>,
        <yunlong.song@icloud.com>, <yunlong.song@huawei.com>
CC: <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] f2fs: add GC_WRITTEN_PAGE to gc atomic file
Date: Sat, 3 Feb 2018 10:47:48 +0800
Message-ID: <1517626068-49739-2-git-send-email-yunlong.song@huawei.com>
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1517626068-49739-1-git-send-email-yunlong.song@huawei.com>
References: <1517626068-49739-1-git-send-email-yunlong.song@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.107.193.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables to gc atomic file by adding GC_WRITTEN_PAGE to
identify the gced pages of atomic file, which can avoid
register_inmem_page in set_page_dirty, so the gced pages will not mix
with the inmem pages.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/data.c    |  7 ++++++-
 fs/f2fs/gc.c      | 25 ++++++++++++++++++-------
 fs/f2fs/segment.h |  3 +++
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index edafcb6..5e1fc5d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -120,6 +120,10 @@ static void f2fs_write_end_io(struct bio *bio)
 
 		dec_page_count(sbi, type);
 		clear_cold_data(page);
+		if (IS_GC_WRITTEN_PAGE(page)) {
+			set_page_private(page, 0);
+			ClearPagePrivate(page);
+		}
 		end_page_writeback(page);
 	}
 	if (!get_pages(sbi, F2FS_WB_CP_DATA) &&
@@ -2418,7 +2422,8 @@ static int f2fs_set_data_page_dirty(struct page *page)
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
 
-	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
+	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)
+		&& !IS_GC_WRITTEN_PAGE(page)) {
 		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
 			register_inmem_page(inode, page);
 			return 1;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 84ab3ff..9d54ddb 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -622,10 +622,6 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
 		goto out;
 
-	if (f2fs_is_atomic_file(inode) &&
-		!f2fs_is_commit_atomic_write(inode))
-		goto out;
-
 	if (f2fs_is_pinned_file(inode)) {
 		f2fs_pin_file_control(inode, true);
 		goto out;
@@ -680,6 +676,12 @@ static void move_data_block(struct inode *inode, block_t bidx,
 		goto put_page_out;
 	}
 
+	if (f2fs_is_atomic_file(inode) &&
+		!f2fs_is_commit_atomic_write(inode) &&
+		!IS_GC_WRITTEN_PAGE(fio.encrypted_page)) {
+		set_page_private(fio.encrypted_page, (unsigned long)GC_WRITTEN_PAGE);
+		SetPagePrivate(fio.encrypted_page);
+	}
 	set_page_dirty(fio.encrypted_page);
 	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true);
 	if (clear_page_dirty_for_io(fio.encrypted_page))
@@ -730,9 +732,6 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
 		goto out;
 
-	if (f2fs_is_atomic_file(inode) &&
-		!f2fs_is_commit_atomic_write(inode))
-		goto out;
 	if (f2fs_is_pinned_file(inode)) {
 		if (gc_type == FG_GC)
 			f2fs_pin_file_control(inode, true);
@@ -742,6 +741,12 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 	if (gc_type == BG_GC) {
 		if (PageWriteback(page))
 			goto out;
+		if (f2fs_is_atomic_file(inode) &&
+			!f2fs_is_commit_atomic_write(inode) &&
+			!IS_GC_WRITTEN_PAGE(page)) {
+			set_page_private(page, (unsigned long)GC_WRITTEN_PAGE);
+			SetPagePrivate(page);
+		}
 		set_page_dirty(page);
 		set_cold_data(page);
 	} else {
@@ -762,6 +767,12 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 		int err;
 
 retry:
+		if (f2fs_is_atomic_file(inode) &&
+			!f2fs_is_commit_atomic_write(inode) &&
+			!IS_GC_WRITTEN_PAGE(page)) {
+			set_page_private(page, (unsigned long)GC_WRITTEN_PAGE);
+			SetPagePrivate(page);
+		}
 		set_page_dirty(page);
 		f2fs_wait_on_page_writeback(page, DATA, true);
 		if (clear_page_dirty_for_io(page)) {
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index f11c4bc..f0a6432 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -203,11 +203,14 @@ struct segment_allocation {
  */
 #define ATOMIC_WRITTEN_PAGE		((unsigned long)-1)
 #define DUMMY_WRITTEN_PAGE		((unsigned long)-2)
+#define GC_WRITTEN_PAGE		((unsigned long)-3)
 
 #define IS_ATOMIC_WRITTEN_PAGE(page)			\
 		(page_private(page) == (unsigned long)ATOMIC_WRITTEN_PAGE)
 #define IS_DUMMY_WRITTEN_PAGE(page)			\
 		(page_private(page) == (unsigned long)DUMMY_WRITTEN_PAGE)
+#define IS_GC_WRITTEN_PAGE(page)			\
+		(page_private(page) == (unsigned long)GC_WRITTEN_PAGE)
 
 struct inmem_pages {
 	struct list_head list;
-- 
1.8.5.2
