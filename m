Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933009AbeCJSYj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:24:39 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33067 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932918AbeCJSVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:47 -0500
X-Google-Smtp-Source: AG47ELvOJrbtR7E4ak9HmHrSHoxI+3Exg6VTdYrlIOJ7fWZLaupizZ5mizbOEJAPlnTwq1L3qzS0uQ==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 75/83] File operation: read/write iter.
Date: Sat, 10 Mar 2018 10:18:56 -0800
Message-Id: <1520705944-6723-76-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

They use the iomap framework to do read/write. Due to software overheads
they are slower than dax read/write.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/file.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/fs/nova/file.c b/fs/nova/file.c
index 0ae0333..7e90415 100644
--- a/fs/nova/file.c
+++ b/fs/nova/file.c
@@ -260,6 +260,69 @@ static long nova_fallocate(struct file *file, int mode, loff_t offset,
 	return ret;
 }
 
+static ssize_t nova_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	struct inode *inode = iocb->ki_filp->f_mapping->host;
+	ssize_t ret;
+	timing_t read_iter_time;
+
+	if (!iov_iter_count(to))
+		return 0;
+
+	NOVA_START_TIMING(read_iter_t, read_iter_time);
+
+	inode_lock_shared(inode);
+	ret = dax_iomap_rw(iocb, to, &nova_iomap_ops);
+	inode_unlock_shared(inode);
+
+	file_accessed(iocb->ki_filp);
+	NOVA_END_TIMING(read_iter_t, read_iter_time);
+	return ret;
+}
+
+static ssize_t nova_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+	struct nova_inode_info *si = NOVA_I(inode);
+	struct nova_inode_info_header *sih = &si->header;
+	loff_t offset;
+	size_t count;
+	ssize_t ret;
+	timing_t write_iter_time;
+
+	NOVA_START_TIMING(write_iter_t, write_iter_time);
+	inode_lock(inode);
+	ret = generic_write_checks(iocb, from);
+	if (ret <= 0)
+		goto out_unlock;
+
+	ret = file_remove_privs(file);
+	if (ret)
+		goto out_unlock;
+
+	ret = file_update_time(file);
+	if (ret)
+		goto out_unlock;
+
+	count = iov_iter_count(from);
+	offset = iocb->ki_pos;
+
+	ret = dax_iomap_rw(iocb, from, &nova_iomap_ops);
+	if (ret > 0 && iocb->ki_pos > i_size_read(inode)) {
+		i_size_write(inode, iocb->ki_pos);
+		sih->i_size = iocb->ki_pos;
+		mark_inode_dirty(inode);
+	}
+
+out_unlock:
+	inode_unlock(inode);
+	if (ret > 0)
+		ret = generic_write_sync(iocb, ret);
+	NOVA_END_TIMING(write_iter_t, write_iter_time);
+	return ret;
+}
+
 static ssize_t
 do_dax_mapping_read(struct file *filp, char __user *buf,
 	size_t len, loff_t *ppos)
@@ -645,6 +708,8 @@ const struct file_operations nova_dax_file_operations = {
 	.llseek		= nova_llseek,
 	.read		= nova_dax_file_read,
 	.write		= nova_dax_file_write,
+	.read_iter	= nova_dax_read_iter,
+	.write_iter	= nova_dax_write_iter,
 	.mmap		= nova_dax_file_mmap,
 	.open		= nova_open,
 	.fsync		= nova_fsync,
-- 
2.7.4
