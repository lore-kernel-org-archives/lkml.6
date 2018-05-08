Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933234AbeEHSKt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:10:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:54278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932849AbeEHSGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:06:21 -0400
From: Mark Fasheh <mfasheh@suse.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Mark Fasheh <mfasheh@suse.de>
Subject: [PATCH 64/76] fs/read: Use inode_sb() helper instead of inode->i_sb
Date: Tue,  8 May 2018 11:04:24 -0700
Message-Id: <20180508180436.716-65-mfasheh@suse.de>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180508180436.716-1-mfasheh@suse.de>
References: <20180508180436.716-1-mfasheh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mark Fasheh <mfasheh@suse.de>
---
 fs/read_write.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index f8547b82dfb3..cf9900707558 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -146,7 +146,7 @@ loff_t generic_file_llseek(struct file *file, loff_t offset, int whence)
 	struct inode *inode = file->f_mapping->host;
 
 	return generic_file_llseek_size(file, offset, whence,
-					inode->i_sb->s_maxbytes,
+					inode_sb(inode)->s_maxbytes,
 					i_size_read(inode));
 }
 EXPORT_SYMBOL(generic_file_llseek);
@@ -1389,7 +1389,8 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		goto fput_out;
 
 	if (!max)
-		max = min(in_inode->i_sb->s_maxbytes, out_inode->i_sb->s_maxbytes);
+		max = min(inode_sb(in_inode)->s_maxbytes,
+			  inode_sb(out_inode)->s_maxbytes);
 
 	if (unlikely(pos + count > max)) {
 		retval = -EOVERFLOW;
@@ -1549,7 +1550,7 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 		return -EBADF;
 
 	/* this could be relaxed once a method supports cross-fs copies */
-	if (inode_in->i_sb != inode_out->i_sb)
+	if (inode_sb(inode_in) != inode_sb(inode_out))
 		return -EXDEV;
 
 	if (len == 0)
@@ -1694,7 +1695,7 @@ int vfs_clone_file_prep_inodes(struct inode *inode_in, loff_t pos_in,
 			       struct inode *inode_out, loff_t pos_out,
 			       u64 *len, bool is_dedupe)
 {
-	loff_t bs = inode_out->i_sb->s_blocksize;
+	loff_t bs = inode_sb(inode_out)->s_blocksize;
 	loff_t blen;
 	loff_t isize;
 	bool same_inode = (inode_in == inode_out);
@@ -1808,7 +1809,7 @@ int vfs_clone_file_range(struct file *file_in, loff_t pos_in,
 	 * the same mount. Practically, they only need to be on the same file
 	 * system.
 	 */
-	if (inode_in->i_sb != inode_out->i_sb)
+	if (inode_sb(inode_in) != inode_sb(inode_out))
 		return -EXDEV;
 
 	if (!(file_in->f_mode & FMODE_READ) ||
-- 
2.15.1
