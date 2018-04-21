Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeDUGxL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 02:53:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750855AbeDUGxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 02:53:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D33E214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jaegeuk@kernel.org
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: check cap_resource only for data blocks
Date: Fri, 20 Apr 2018 23:53:08 -0700
Message-Id: <20180421065308.84211-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the rule to check cap_resource for data blocks, not inode
or node blocks in order to avoid selinux denial.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9f2bc78a9f5b..8f3ad9662d13 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1611,7 +1611,7 @@ static inline bool f2fs_has_xattr_block(unsigned int ofs)
 }
 
 static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
-					struct inode *inode)
+					struct inode *inode, bool cap)
 {
 	if (!inode)
 		return true;
@@ -1624,7 +1624,7 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
 	if (!gid_eq(F2FS_OPTION(sbi).s_resgid, GLOBAL_ROOT_GID) &&
 					in_group_p(F2FS_OPTION(sbi).s_resgid))
 		return true;
-	if (capable(CAP_SYS_RESOURCE))
+	if (cap && capable(CAP_SYS_RESOURCE))
 		return true;
 	return false;
 }
@@ -1659,7 +1659,7 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	avail_user_block_count = sbi->user_block_count -
 					sbi->current_reserved_blocks;
 
-	if (!__allow_reserved_blocks(sbi, inode))
+	if (!__allow_reserved_blocks(sbi, inode, true))
 		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
 
 	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
@@ -1866,7 +1866,7 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
 	valid_block_count = sbi->total_valid_block_count +
 					sbi->current_reserved_blocks + 1;
 
-	if (!__allow_reserved_blocks(sbi, inode))
+	if (!__allow_reserved_blocks(sbi, inode, false))
 		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
 
 	if (unlikely(valid_block_count > sbi->user_block_count)) {
-- 
2.17.0.484.g0c8726318c-goog
