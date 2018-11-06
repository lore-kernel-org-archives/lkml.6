Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20A9C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BE52081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BE52081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388622AbeKFX2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:28:24 -0500
Received: from relay.sw.ru ([185.231.240.75]:41724 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388509AbeKFX2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:28:23 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.90_1)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gK1wY-00053v-3B; Tue, 06 Nov 2018 17:02:58 +0300
Subject: [PATCH RFC] fuse: Prevent background write requests increase inode
 size
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 06 Nov 2018 17:02:57 +0300
Message-ID: <154151286725.17550.12307253489084032792.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Miklos,

this is not a well-tested patch, this is a concept,
showing the places, where it looks we have a problem.

Commit 7879c4e58b7c made io->async careless about inode size,
and this is wrong. Asyncronuos background requests may be sent
to userspace after inode becomes unlocked, when background
queue is throttled. In this case we execute a write request
extending inode size without any protection, and this ruines
everything. Fix that.

Also, some write background requests do not increment fi->writectr,
e.g.:
	fuse_direct_IO()
	  fuse_direct_io()
	    fuse_send_write()
	      fuse_async_req_send()
	        fuse_request_send_background()

This is a reason fuse_sync_writes() does not work as expected.
Fix that too.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/file.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index cc2121b37bf5..0b71a3c96168 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -610,6 +610,9 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
 static void fuse_aio_complete_req(struct fuse_conn *fc, struct fuse_req *req)
 {
 	struct fuse_io_priv *io = req->io;
+	struct kiocb *iocb = io->iocb;
+	struct file *file = iocb->ki_filp;
+	struct fuse_inode *fi = get_fuse_inode(file_inode(file));
 	ssize_t pos = -1;
 
 	fuse_release_user_pages(req, io->should_dirty);
@@ -625,6 +628,12 @@ static void fuse_aio_complete_req(struct fuse_conn *fc, struct fuse_req *req)
 	}
 
 	fuse_aio_complete(io, req->out.h.error, pos);
+
+	if (io->write) {
+		spin_lock(&fc->lock);
+		fi->writectr--;
+		spin_unlock(&fc->lock);
+	}
 }
 
 static size_t fuse_async_req_send(struct fuse_conn *fc, struct fuse_req *req,
@@ -966,6 +975,7 @@ static size_t fuse_send_write(struct fuse_req *req, struct fuse_io_priv *io,
 {
 	struct kiocb *iocb = io->iocb;
 	struct file *file = iocb->ki_filp;
+	struct fuse_inode *fi = get_fuse_inode(file_inode(file));
 	struct fuse_file *ff = file->private_data;
 	struct fuse_conn *fc = ff->fc;
 	struct fuse_write_in *inarg = &req->misc.write.in;
@@ -981,8 +991,12 @@ static size_t fuse_send_write(struct fuse_req *req, struct fuse_io_priv *io,
 		inarg->lock_owner = fuse_lock_owner_id(fc, owner);
 	}
 
-	if (io->async)
+	if (io->async) {
+		spin_lock(&fc->lock);
+		fi->writectr++;
+		spin_unlock(&fc->lock);
 		return fuse_async_req_send(fc, req, count, io);
+	}
 
 	fuse_request_send(fc, req);
 	return req->misc.write.out.size;
@@ -2904,8 +2918,10 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * We cannot asynchronously extend the size of a file.
 	 * In such case the aio will behave exactly like sync io.
 	 */
-	if ((offset + count > i_size) && iov_iter_rw(iter) == WRITE)
+	if ((offset + count > i_size) && iov_iter_rw(iter) == WRITE) {
 		io->blocking = true;
+		io->async = false;
+	}
 
 	if (io->async && io->blocking) {
 		/*

