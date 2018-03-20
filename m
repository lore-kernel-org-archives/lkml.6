Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeCTPIl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:08:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751128AbeCTPIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:08:40 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D25621736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: clean up with F2FS_BLK_ALIGN
Date: Tue, 20 Mar 2018 23:08:29 +0800
Message-Id: <20180320150830.2630-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Clean up F2FS_BYTES_TO_BLK(x + F2FS_BLKSIZE - 1) with F2FS_BLK_ALIGN(x).

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 3 +--
 fs/f2fs/node.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ee88058acd63..8068b015ece5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -573,7 +573,6 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 int truncate_blocks(struct inode *inode, u64 from, bool lock)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	unsigned int blocksize = inode->i_sb->s_blocksize;
 	struct dnode_of_data dn;
 	pgoff_t free_from;
 	int count = 0, err = 0;
@@ -582,7 +581,7 @@ int truncate_blocks(struct inode *inode, u64 from, bool lock)
 
 	trace_f2fs_truncate_blocks_enter(inode, from);
 
-	free_from = (pgoff_t)F2FS_BYTES_TO_BLK(from + blocksize - 1);
+	free_from = (pgoff_t)F2FS_BLK_ALIGN(from);
 
 	if (free_from >= sbi->max_file_blocks)
 		goto free_partial;
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f7886b46478d..ecfc2465da9b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2581,8 +2581,7 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 	if (!enabled_nat_bits(sbi, NULL))
 		return 0;
 
-	nm_i->nat_bits_blocks = F2FS_BYTES_TO_BLK((nat_bits_bytes << 1) + 8 +
-						F2FS_BLKSIZE - 1);
+	nm_i->nat_bits_blocks = F2FS_BLK_ALIGN((nat_bits_bytes << 1) + 8);
 	nm_i->nat_bits = f2fs_kzalloc(sbi,
 			nm_i->nat_bits_blocks << F2FS_BLKSIZE_BITS, GFP_KERNEL);
 	if (!nm_i->nat_bits)
-- 
2.16.2.17.g38e79b1fd
