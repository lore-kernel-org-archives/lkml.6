Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932850AbeCJSVj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:21:39 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40023 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932670AbeCJSVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:35 -0500
X-Google-Smtp-Source: AG47ELv1iOGQcHLmGCU1XzPjJzg/qAMn08Pw/kSjuaI3ZKd4X7C1Akp30h2mftwriOfcC152ViofoA==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 65/83] File operation: read.
Date: Sat, 10 Mar 2018 10:18:46 -0800
Message-Id: <1520705944-6723-66-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

NOVA is a DAX file system and does not use page cache.
For read, NOVA looks up the file write entry by searching the radix tree,
and copies data from pmem pages to user buffer directly.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/file.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/fs/nova/file.c b/fs/nova/file.c
index f60fdf3..842da45 100644
--- a/fs/nova/file.c
+++ b/fs/nova/file.c
@@ -113,9 +113,153 @@ static int nova_open(struct inode *inode, struct file *filp)
 	return generic_file_open(inode, filp);
 }
 
+static ssize_t
+do_dax_mapping_read(struct file *filp, char __user *buf,
+	size_t len, loff_t *ppos)
+{
+	struct inode *inode = filp->f_mapping->host;
+	struct super_block *sb = inode->i_sb;
+	struct nova_inode_info *si = NOVA_I(inode);
+	struct nova_inode_info_header *sih = &si->header;
+	struct nova_file_write_entry *entry;
+	pgoff_t index, end_index;
+	unsigned long offset;
+	loff_t isize, pos;
+	size_t copied = 0, error = 0;
+	timing_t memcpy_time;
+
+	pos = *ppos;
+	index = pos >> PAGE_SHIFT;
+	offset = pos & ~PAGE_MASK;
+
+	if (!access_ok(VERIFY_WRITE, buf, len)) {
+		error = -EFAULT;
+		goto out;
+	}
+
+	isize = i_size_read(inode);
+	if (!isize)
+		goto out;
+
+	nova_dbgv("%s: inode %lu, offset %lld, count %lu, size %lld\n",
+		__func__, inode->i_ino,	pos, len, isize);
+
+	if (len > isize - pos)
+		len = isize - pos;
+
+	if (len <= 0)
+		goto out;
+
+	end_index = (isize - 1) >> PAGE_SHIFT;
+	do {
+		unsigned long nr, left;
+		unsigned long nvmm;
+		void *dax_mem = NULL;
+		int zero = 0;
+
+		/* nr is the maximum number of bytes to copy from this page */
+		if (index >= end_index) {
+			if (index > end_index)
+				goto out;
+			nr = ((isize - 1) & ~PAGE_MASK) + 1;
+			if (nr <= offset)
+				goto out;
+		}
+
+		entry = nova_get_write_entry(sb, sih, index);
+		if (unlikely(entry == NULL)) {
+			nova_dbgv("Required extent not found: pgoff %lu, inode size %lld\n",
+				index, isize);
+			nr = PAGE_SIZE;
+			zero = 1;
+			goto memcpy;
+		}
+
+		/* Find contiguous blocks */
+		if (index < entry->pgoff ||
+			index - entry->pgoff >= entry->num_pages) {
+			nova_err(sb, "%s ERROR: %lu, entry pgoff %llu, num %u, blocknr %llu\n",
+				__func__, index, entry->pgoff,
+				entry->num_pages, entry->block >> PAGE_SHIFT);
+			return -EINVAL;
+		}
+		if (entry->reassigned == 0) {
+			nr = (entry->num_pages - (index - entry->pgoff))
+				* PAGE_SIZE;
+		} else {
+			nr = PAGE_SIZE;
+		}
+
+		nvmm = get_nvmm(sb, sih, entry, index);
+		dax_mem = nova_get_block(sb, (nvmm << PAGE_SHIFT));
+
+memcpy:
+		nr = nr - offset;
+		if (nr > len - copied)
+			nr = len - copied;
+
+		NOVA_START_TIMING(memcpy_r_nvmm_t, memcpy_time);
+
+		if (!zero)
+			left = __copy_to_user(buf + copied,
+						dax_mem + offset, nr);
+		else
+			left = __clear_user(buf + copied, nr);
+
+		NOVA_END_TIMING(memcpy_r_nvmm_t, memcpy_time);
+
+		if (left) {
+			nova_dbg("%s ERROR!: bytes %lu, left %lu\n",
+				__func__, nr, left);
+			error = -EFAULT;
+			goto out;
+		}
+
+		copied += (nr - left);
+		offset += (nr - left);
+		index += offset >> PAGE_SHIFT;
+		offset &= ~PAGE_MASK;
+	} while (copied < len);
+
+out:
+	*ppos = pos + copied;
+	if (filp)
+		file_accessed(filp);
+
+	NOVA_STATS_ADD(read_bytes, copied);
+
+	nova_dbgv("%s returned %zu\n", __func__, copied);
+	return copied ? copied : error;
+}
+
+/*
+ * Wrappers. We need to use the read lock to avoid
+ * concurrent truncate operation. No problem for write because we held
+ * lock.
+ */
+static ssize_t nova_dax_file_read(struct file *filp, char __user *buf,
+			    size_t len, loff_t *ppos)
+{
+	struct inode *inode = filp->f_mapping->host;
+	struct nova_inode_info *si = NOVA_I(inode);
+	struct nova_inode_info_header *sih = &si->header;
+	ssize_t res;
+	timing_t dax_read_time;
+
+	NOVA_START_TIMING(dax_read_t, dax_read_time);
+	inode_lock_shared(inode);
+	sih_lock_shared(sih);
+	res = do_dax_mapping_read(filp, buf, len, ppos);
+	sih_unlock_shared(sih);
+	inode_unlock_shared(inode);
+	NOVA_END_TIMING(dax_read_t, dax_read_time);
+	return res;
+}
+
 
 const struct file_operations nova_dax_file_operations = {
 	.llseek		= nova_llseek,
+	.read		= nova_dax_file_read,
 	.open		= nova_open,
 	.fsync		= nova_fsync,
 	.flush		= nova_flush,
-- 
2.7.4
