Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932828AbeCJSVg (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 13:21:36 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:42611 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932783AbeCJSVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 13:21:34 -0500
X-Google-Smtp-Source: AG47ELtcI2AM8Tm9DTSVz6NHVfW0huIwTQpCiTfU90iFv74GG8P5PZZWBR6oCWkRtOpVF+YTzb67Dw==
From: Andiry Xu <jix024@eng.ucsd.edu>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc: dan.j.williams@intel.com, andy.rudoff@intel.com, coughlan@redhat.com,
        swanson@cs.ucsd.edu, david@fromorbit.com, jack@suse.com,
        swhiteho@redhat.com, miklos@szeredi.hu, andiry.xu@gmail.com,
        Andiry Xu <jix024@cs.ucsd.edu>
Subject: [RFC v2 64/83] File operation: open, fsync, flush.
Date: Sat, 10 Mar 2018 10:18:45 -0800
Message-Id: <1520705944-6723-65-git-send-email-jix024@eng.ucsd.edu>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
References: <1520705944-6723-1-git-send-email-jix024@eng.ucsd.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andiry Xu <jix024@cs.ucsd.edu>

NOVA persists file metadata and data before returning to the user space.
Hence, fsync is a no-op if the file is not mmaped.

Signed-off-by: Andiry Xu <jix024@cs.ucsd.edu>
---
 fs/nova/file.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/fs/nova/file.c b/fs/nova/file.c
index ecaf20a..f60fdf3 100644
--- a/fs/nova/file.c
+++ b/fs/nova/file.c
@@ -66,9 +66,59 @@ static loff_t nova_llseek(struct file *file, loff_t offset, int origin)
 	return offset;
 }
 
+/* This function is called by both msync() and fsync().
+ * TODO: Check if we can avoid calling nova_flush_buffer() for fsync. We use
+ * movnti to write data to files, so we may want to avoid doing unnecessary
+ * nova_flush_buffer() on fsync()
+ */
+static int nova_fsync(struct file *file, loff_t start, loff_t end, int datasync)
+{
+	struct address_space *mapping = file->f_mapping;
+	unsigned long start_pgoff, end_pgoff;
+	int ret = 0;
+	timing_t fsync_time;
+
+	NOVA_START_TIMING(fsync_t, fsync_time);
+
+	if (datasync)
+		NOVA_STATS_ADD(fdatasync, 1);
+
+	/* No need to flush if the file is not mmaped */
+	if (!mapping_mapped(mapping))
+		goto persist;
+
+	start_pgoff = start >> PAGE_SHIFT;
+	end_pgoff = (end + 1) >> PAGE_SHIFT;
+	nova_dbgv("%s: msync pgoff range %lu to %lu\n",
+			__func__, start_pgoff, end_pgoff);
+
+	ret = generic_file_fsync(file, start, end, datasync);
+
+persist:
+	PERSISTENT_BARRIER();
+	NOVA_END_TIMING(fsync_t, fsync_time);
+
+	return ret;
+}
+
+/* This callback is called when a file is closed */
+static int nova_flush(struct file *file, fl_owner_t id)
+{
+	PERSISTENT_BARRIER();
+	return 0;
+}
+
+static int nova_open(struct inode *inode, struct file *filp)
+{
+	return generic_file_open(inode, filp);
+}
+
 
 const struct file_operations nova_dax_file_operations = {
 	.llseek		= nova_llseek,
+	.open		= nova_open,
+	.fsync		= nova_fsync,
+	.flush		= nova_flush,
 };
 
 const struct inode_operations nova_file_inode_operations = {
-- 
2.7.4
