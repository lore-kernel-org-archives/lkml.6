Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932377AbeCJCDy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 21:03:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:45314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751211AbeCJCDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 21:03:53 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCD620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: align memory boundary for bitops
Date: Fri,  9 Mar 2018 18:03:48 -0800
Message-Id: <20180310020348.69129-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c9-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For example, in arm64, free_nid_bitmap should be aligned to word size in order
to use bit operations.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h          |  2 +-
 fs/f2fs/node.c          | 20 +++++++++++++++++---
 include/linux/f2fs_fs.h |  4 ++++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 88f2b420de27..641b4b98d373 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -766,7 +766,7 @@ struct f2fs_nm_info {
 	unsigned int nid_cnt[MAX_NID_STATE];	/* the number of free node id */
 	spinlock_t nid_list_lock;	/* protect nid lists ops */
 	struct mutex build_lock;	/* lock for build free nids */
-	unsigned char (*free_nid_bitmap)[NAT_ENTRY_BITMAP_SIZE];
+	unsigned char **free_nid_bitmap;
 	unsigned char *nat_block_bitmap;
 	unsigned short *free_nid_count;	/* free nid count of NAT block */
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b86e2b15b619..f7886b46478d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2708,12 +2708,20 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
 static int init_free_nid_cache(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
+	int i;
 
-	nm_i->free_nid_bitmap = f2fs_kvzalloc(sbi, nm_i->nat_blocks *
-					NAT_ENTRY_BITMAP_SIZE, GFP_KERNEL);
+	nm_i->free_nid_bitmap = f2fs_kzalloc(sbi, nm_i->nat_blocks *
+				sizeof(unsigned char *), GFP_KERNEL);
 	if (!nm_i->free_nid_bitmap)
 		return -ENOMEM;
 
+	for (i = 0; i < nm_i->nat_blocks; i++) {
+		nm_i->free_nid_bitmap[i] = f2fs_kvzalloc(sbi,
+				NAT_ENTRY_BITMAP_SIZE_ALIGNED, GFP_KERNEL);
+		if (!nm_i->free_nid_bitmap)
+			return -ENOMEM;
+	}
+
 	nm_i->nat_block_bitmap = f2fs_kvzalloc(sbi, nm_i->nat_blocks / 8,
 								GFP_KERNEL);
 	if (!nm_i->nat_block_bitmap)
@@ -2804,7 +2812,13 @@ void destroy_node_manager(struct f2fs_sb_info *sbi)
 	up_write(&nm_i->nat_tree_lock);
 
 	kvfree(nm_i->nat_block_bitmap);
-	kvfree(nm_i->free_nid_bitmap);
+	if (nm_i->free_nid_bitmap) {
+		int i;
+
+		for (i = 0; i < nm_i->nat_blocks; i++)
+			kvfree(nm_i->free_nid_bitmap[i]);
+		kfree(nm_i->free_nid_bitmap);
+	}
 	kvfree(nm_i->free_nid_count);
 
 	kfree(nm_i->nat_bitmap);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 124787e8db58..aa5db8b5521a 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -305,6 +305,10 @@ struct f2fs_node {
  */
 #define NAT_ENTRY_PER_BLOCK (PAGE_SIZE / sizeof(struct f2fs_nat_entry))
 #define NAT_ENTRY_BITMAP_SIZE	((NAT_ENTRY_PER_BLOCK + 7) / 8)
+#define NAT_ENTRY_BITMAP_SIZE_ALIGNED				\
+	((NAT_ENTRY_BITMAP_SIZE + BITS_PER_LONG - 1) /		\
+	BITS_PER_LONG * BITS_PER_LONG)
+
 
 struct f2fs_nat_entry {
 	__u8 version;		/* latest version of cached nat entry */
-- 
2.15.0.531.g2ccb3012c9-goog
