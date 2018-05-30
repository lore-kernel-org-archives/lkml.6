Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932398AbeE3Tuk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 15:50:40 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:60152
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932312AbeE3TuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 15:50:06 -0400
x-originating-ip: 107.180.71.197
From: Long Li <longli@linuxonhyperv.com>
To: Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v2 14/15] CIFS: Add support for direct I/O write
Date: Wed, 30 May 2018 12:48:06 -0700
Message-Id: <20180530194807.31657-15-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180530194807.31657-1-longli@linuxonhyperv.com>
References: <20180530194807.31657-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfP7ZAtMVKrbH2V0wa8Kzp7fPsIttG6C8sZ9JQ3Xe7txcMUfLCTeBqUNtOFSkxwVXSv3XSecXgLNVq1mBBNBIQvejKbmyvUlz+7xYqldQzktKnocnMeiw
 VuLPcQMXn4Q7Leq9p6P2qk94xMFBsXM9oaBVjsw0s8lQvYJ3g+SgnmdjRpa/veTO3Cl5wwDJMYrZowI/qMWfFV6DMRXnPDv0oWBnk7KxbUsbEIT6eWQ/hFXI
 gN1bh8CdyNhSk7i+/Tfqmq9GarWiANxO6mvQ0zVzLFeQCyvBpaB8xCRzxFFPfrVLH5BOzqmowYYPi1iVwEbFMJh7f2NKH4CkG5BMDEahvtQucOiqlcA+Jq4o
 L4/OtcbK5mpgY0zlquWYzC3p7MdcHZw87JPI+ElhWHOPOIuYAjJ4dyD5z8td6WrkiDgh71yV
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

Implement the function for direct I/O write. It doesn't support AIO, which
will be implemented in a follow up patch.

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/cifsfs.h |   1 +
 fs/cifs/file.c   | 165 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 166 insertions(+)

diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 7fba9aa..e9c5103 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -105,6 +105,7 @@ extern ssize_t cifs_user_readv(struct kiocb *iocb, struct iov_iter *to);
 extern ssize_t cifs_direct_readv(struct kiocb *iocb, struct iov_iter *to);
 extern ssize_t cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to);
 extern ssize_t cifs_user_writev(struct kiocb *iocb, struct iov_iter *from);
+extern ssize_t cifs_direct_writev(struct kiocb *iocb, struct iov_iter *from);
 extern ssize_t cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from);
 extern int cifs_lock(struct file *, int, struct file_lock *);
 extern int cifs_fsync(struct file *, loff_t, loff_t, int);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index e6e6f24..8c385b1 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2461,6 +2461,35 @@ cifs_uncached_writedata_release(struct kref *refcount)
 
 static void collect_uncached_write_data(struct cifs_aio_ctx *ctx);
 
+static void cifs_direct_writedata_release(struct kref *refcount)
+{
+	int i;
+	struct cifs_writedata *wdata = container_of(refcount,
+					struct cifs_writedata, refcount);
+
+	for (i = 0; i < wdata->nr_pages; i++)
+		put_page(wdata->pages[i]);
+
+	cifs_writedata_release(refcount);
+}
+
+static void cifs_direct_writev_complete(struct work_struct *work)
+{
+	struct cifs_writedata *wdata = container_of(work,
+					struct cifs_writedata, work);
+	struct inode *inode = d_inode(wdata->cfile->dentry);
+	struct cifsInodeInfo *cifsi = CIFS_I(inode);
+
+	spin_lock(&inode->i_lock);
+	cifs_update_eof(cifsi, wdata->offset, wdata->bytes);
+	if (cifsi->server_eof > inode->i_size)
+		i_size_write(inode, cifsi->server_eof);
+	spin_unlock(&inode->i_lock);
+
+	complete(&wdata->done);
+	kref_put(&wdata->refcount, cifs_direct_writedata_release);
+}
+
 static void
 cifs_uncached_writev_complete(struct work_struct *work)
 {
@@ -2703,6 +2732,142 @@ static void collect_uncached_write_data(struct cifs_aio_ctx *ctx)
 		complete(&ctx->done);
 }
 
+ssize_t cifs_direct_writev(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	ssize_t total_written = 0;
+	struct cifsFileInfo *cfile;
+	struct cifs_tcon *tcon;
+	struct cifs_sb_info *cifs_sb;
+	struct TCP_Server_Info *server;
+	pid_t pid;
+	unsigned long nr_pages;
+	loff_t offset = iocb->ki_pos;
+	size_t len = iov_iter_count(from);
+	int rc;
+	struct cifs_writedata *wdata;
+
+	/*
+	 * iov_iter_get_pages_alloc doesn't work with ITER_KVEC.
+	 * In this case, fall back to non-direct write function.
+	 */
+	if (from->type & ITER_KVEC) {
+		cifs_dbg(FYI, "use non-direct cifs_user_writev for kvec I/O\n");
+		return cifs_user_writev(iocb, from);
+	}
+
+	rc = generic_write_checks(iocb, from);
+	if (rc <= 0)
+		return rc;
+
+	cifs_sb = CIFS_FILE_SB(file);
+	cfile = file->private_data;
+	tcon = tlink_tcon(cfile->tlink);
+	server = tcon->ses->server;
+
+	if (!server->ops->async_writev)
+		return -ENOSYS;
+
+	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
+		pid = cfile->pid;
+	else
+		pid = current->tgid;
+
+	do {
+		unsigned int wsize, credits;
+		struct page **pagevec;
+		size_t start;
+		ssize_t cur_len;
+
+		rc = server->ops->wait_mtu_credits(server, cifs_sb->wsize,
+						   &wsize, &credits);
+		if (rc)
+			break;
+
+		cur_len = iov_iter_get_pages_alloc(
+				from, &pagevec, wsize, &start);
+		if (cur_len < 0) {
+			cifs_dbg(VFS,
+				"direct_writev couldn't get user pages "
+				"(rc=%zd) iter type %d iov_offset %lu count"
+				" %lu\n",
+				cur_len, from->type,
+				from->iov_offset, from->count);
+			dump_stack();
+			break;
+		}
+		if (cur_len < 0)
+			break;
+
+		nr_pages = (cur_len + start + PAGE_SIZE - 1) / PAGE_SIZE;
+
+		wdata = cifs_writedata_direct_alloc(pagevec,
+					     cifs_direct_writev_complete);
+		if (!wdata) {
+			rc = -ENOMEM;
+			add_credits_and_wake_if(server, credits, 0);
+			break;
+		}
+
+		wdata->nr_pages = nr_pages;
+		wdata->page_offset = start;
+		wdata->pagesz = PAGE_SIZE;
+		wdata->tailsz =
+			nr_pages > 1 ?
+			cur_len - (PAGE_SIZE - start) -
+				(nr_pages - 2) * PAGE_SIZE :
+			cur_len;
+
+		wdata->sync_mode = WB_SYNC_ALL;
+		wdata->offset = (__u64)offset;
+		wdata->cfile = cifsFileInfo_get(cfile);
+		wdata->pid = pid;
+		wdata->bytes = cur_len;
+		wdata->credits = credits;
+
+		rc = 0;
+		if (wdata->cfile->invalidHandle)
+			rc = cifs_reopen_file(wdata->cfile, false);
+
+		if (!rc)
+			rc = server->ops->async_writev(wdata,
+					cifs_direct_writedata_release);
+
+		if (rc) {
+			add_credits_and_wake_if(server, wdata->credits, 0);
+			kref_put(&wdata->refcount,
+				 cifs_direct_writedata_release);
+			if (rc == -EAGAIN)
+				continue;
+			break;
+		}
+
+		wait_for_completion(&wdata->done);
+		if (wdata->result) {
+			rc = wdata->result;
+			kref_put(&wdata->refcount,
+					cifs_direct_writedata_release);
+			if (rc == -EAGAIN)
+				continue;
+			break;
+		}
+
+		kref_put(&wdata->refcount, cifs_direct_writedata_release);
+
+		iov_iter_advance(from, cur_len);
+		total_written += cur_len;
+		offset += cur_len;
+		len -= cur_len;
+	} while (len);
+
+	if (unlikely(!total_written))
+		return rc;
+
+	iocb->ki_pos += total_written;
+	return total_written;
+
+}
+
 ssize_t cifs_user_writev(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
-- 
2.7.4
