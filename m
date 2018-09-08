Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E690C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F8E20855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 02:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F8E20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeIHG7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:59:30 -0400
Received: from a2nlsmtp01-04.prod.iad2.secureserver.net ([198.71.225.38]:36876
        "EHLO a2nlsmtp01-04.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727217AbeIHG7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:59:30 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with ESMTP
        id ySlnfkWo64ToEySlnfAVll; Fri, 07 Sep 2018 19:14:43 -0700
x-originating-ip: 107.180.71.197
Received: from longli by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <longli@linuxonhyperv2.linuxonhyperv.com>)
        id 1fySln-0005Es-LM; Fri, 07 Sep 2018 19:14:43 -0700
From:   Long Li <longli@linuxonhyperv.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>
Subject: [Patch v3 15/16] CIFS: Add support for direct I/O write
Date:   Sat,  8 Sep 2018 02:13:47 +0000
Message-Id: <20180908021348.19956-16-longli@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908021348.19956-1-longli@linuxonhyperv.com>
References: <20180908021348.19956-1-longli@linuxonhyperv.com>
Reply-To: longli@microsoft.com
X-CMAE-Envelope: MS4wfBnLnWGSCuMl28yetwaglQSw1lZoRiuQfWqaCZ52jtt73LAbbuS1AJjKJLoJLUOCSs0wcU2IZm+vO4KPnMpGrDF4+zXpiwX3AD6uqz/DZPF+hK8ZUIYV
 MeEznLhUPgnrnpzZk215ywUxv6pKSJULruIXox/iFNR3yCu8pKhMyuwxPBxFlynx11LhiVnhm5ftDDyGKkBTk0lT/gsKTK8K/rjTqfQJl3gAg1w+efN1Bmj6
 /J6CDVyPQ007/yfdTPZiZik+RcTOmI1/qTPo99WaFQEcKgvD8xAHy8vr7Z2rKB6zXGIwYKdM6IfcqmXQcDSfyznYdFsaJyW+kbt6f6qWdJjc5mjljewKpsaY
 /OffcAflXi/tJWNUFIJDLZSCw9R0jvP11yqPaD2/O+cYz6axHBYQ4NQQNOSXzd+fLx5fNOfa
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Long Li <longli@microsoft.com>

With direct I/O write, user supplied buffers are pinned to the memory and data
are transferred directly from user buffers to the transport layer.

Change in v3: added support for kernel AIO

Signed-off-by: Long Li <longli@microsoft.com>
---
 fs/cifs/cifsfs.h |   1 +
 fs/cifs/file.c   | 195 ++++++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 165 insertions(+), 31 deletions(-)

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
index 476b2a1..76e0266 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2537,6 +2537,8 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
 	loff_t saved_offset = offset;
 	pid_t pid;
 	struct TCP_Server_Info *server;
+	struct page **pagevec;
+	size_t start;
 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
 		pid = open_file->pid;
@@ -2553,38 +2555,74 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
 		if (rc)
 			break;
 
-		nr_pages = get_numpages(wsize, len, &cur_len);
-		wdata = cifs_writedata_alloc(nr_pages,
+		if (ctx->direct_io) {
+			cur_len = iov_iter_get_pages_alloc(
+				from, &pagevec, wsize, &start);
+			if (cur_len < 0) {
+				cifs_dbg(VFS,
+					"direct_writev couldn't get user pages "
+					"(rc=%zd) iter type %d iov_offset %lu count"
+					" %lu\n",
+					cur_len, from->type,
+					from->iov_offset, from->count);
+				dump_stack();
+				break;
+			}
+			iov_iter_advance(from, cur_len);
+
+			nr_pages = (cur_len + start + PAGE_SIZE - 1) / PAGE_SIZE;
+
+			wdata = cifs_writedata_direct_alloc(pagevec,
 					     cifs_uncached_writev_complete);
-		if (!wdata) {
-			rc = -ENOMEM;
-			add_credits_and_wake_if(server, credits, 0);
-			break;
-		}
+			if (!wdata) {
+				rc = -ENOMEM;
+				add_credits_and_wake_if(server, credits, 0);
+				break;
+			}
 
-		rc = cifs_write_allocate_pages(wdata->pages, nr_pages);
-		if (rc) {
-			kfree(wdata);
-			add_credits_and_wake_if(server, credits, 0);
-			break;
-		}
 
-		num_pages = nr_pages;
-		rc = wdata_fill_from_iovec(wdata, from, &cur_len, &num_pages);
-		if (rc) {
-			for (i = 0; i < nr_pages; i++)
-				put_page(wdata->pages[i]);
-			kfree(wdata);
-			add_credits_and_wake_if(server, credits, 0);
-			break;
-		}
+			wdata->page_offset = start;
+			wdata->tailsz =
+				nr_pages > 1 ?
+					cur_len - (PAGE_SIZE - start) -
+					(nr_pages - 2) * PAGE_SIZE :
+					cur_len;
+		} else {
+			nr_pages = get_numpages(wsize, len, &cur_len);
+			wdata = cifs_writedata_alloc(nr_pages,
+					     cifs_uncached_writev_complete);
+			if (!wdata) {
+				rc = -ENOMEM;
+				add_credits_and_wake_if(server, credits, 0);
+				break;
+			}
 
-		/*
-		 * Bring nr_pages down to the number of pages we actually used,
-		 * and free any pages that we didn't use.
-		 */
-		for ( ; nr_pages > num_pages; nr_pages--)
-			put_page(wdata->pages[nr_pages - 1]);
+			rc = cifs_write_allocate_pages(wdata->pages, nr_pages);
+			if (rc) {
+				kfree(wdata);
+				add_credits_and_wake_if(server, credits, 0);
+				break;
+			}
+
+			num_pages = nr_pages;
+			rc = wdata_fill_from_iovec(wdata, from, &cur_len, &num_pages);
+			if (rc) {
+				for (i = 0; i < nr_pages; i++)
+					put_page(wdata->pages[i]);
+				kfree(wdata);
+				add_credits_and_wake_if(server, credits, 0);
+				break;
+			}
+
+			/*
+			 * Bring nr_pages down to the number of pages we actually used,
+			 * and free any pages that we didn't use.
+			 */
+			for ( ; nr_pages > num_pages; nr_pages--)
+				put_page(wdata->pages[nr_pages - 1]);
+
+			wdata->tailsz = cur_len - ((nr_pages - 1) * PAGE_SIZE);
+		}
 
 		wdata->sync_mode = WB_SYNC_ALL;
 		wdata->nr_pages = nr_pages;
@@ -2593,7 +2631,6 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
 		wdata->pid = pid;
 		wdata->bytes = cur_len;
 		wdata->pagesz = PAGE_SIZE;
-		wdata->tailsz = cur_len - ((nr_pages - 1) * PAGE_SIZE);
 		wdata->credits = credits;
 		wdata->ctx = ctx;
 		kref_get(&ctx->refcount);
@@ -2687,8 +2724,9 @@ static void collect_uncached_write_data(struct cifs_aio_ctx *ctx)
 		kref_put(&wdata->refcount, cifs_uncached_writedata_release);
 	}
 
-	for (i = 0; i < ctx->npages; i++)
-		put_page(ctx->bv[i].bv_page);
+	if (!ctx->direct_io)
+		for (i = 0; i < ctx->npages; i++)
+			put_page(ctx->bv[i].bv_page);
 
 	cifs_stats_bytes_written(tcon, ctx->total_len);
 	set_bit(CIFS_INO_INVALID_MAPPING, &CIFS_I(dentry->d_inode)->flags);
@@ -2703,6 +2741,101 @@ static void collect_uncached_write_data(struct cifs_aio_ctx *ctx)
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
+	size_t len = iov_iter_count(from);
+	int rc;
+	struct cifs_aio_ctx *ctx;
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
+	ctx = cifs_aio_ctx_alloc();
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->cfile = cifsFileInfo_get(cfile);
+
+	if (!is_sync_kiocb(iocb))
+		ctx->iocb = iocb;
+
+	ctx->pos = iocb->ki_pos;
+
+	ctx->direct_io = true;
+	ctx->iter = *from;
+	ctx->len = len;
+
+	/* grab a lock here due to read response handlers can access ctx */
+	mutex_lock(&ctx->aio_mutex);
+
+	rc = cifs_write_from_iter(iocb->ki_pos, ctx->len, from,
+				  cfile, cifs_sb, &ctx->list, ctx);
+
+	/*
+	 * If at least one write was successfully sent, then discard any rc
+	 * value from the later writes. If the other write succeeds, then
+	 * we'll end up returning whatever was written. If it fails, then
+	 * we'll get a new rc value from that.
+	 */
+	if (!list_empty(&ctx->list))
+		rc = 0;
+
+	mutex_unlock(&ctx->aio_mutex);
+
+	if (rc) {
+		kref_put(&ctx->refcount, cifs_aio_ctx_release);
+		return rc;
+	}
+
+	if (!is_sync_kiocb(iocb)) {
+		kref_put(&ctx->refcount, cifs_aio_ctx_release);
+		return -EIOCBQUEUED;
+	}
+
+	rc = wait_for_completion_killable(&ctx->done);
+	if (rc) {
+		mutex_lock(&ctx->aio_mutex);
+		ctx->rc = rc = -EINTR;
+		total_written = ctx->total_len;
+		mutex_unlock(&ctx->aio_mutex);
+	} else {
+		rc = ctx->rc;
+		total_written = ctx->total_len;
+	}
+
+	kref_put(&ctx->refcount, cifs_aio_ctx_release);
+
+	if (unlikely(!total_written))
+		return rc;
+
+	iocb->ki_pos += total_written;
+	return total_written;
+}
+
 ssize_t cifs_user_writev(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
-- 
2.7.4

