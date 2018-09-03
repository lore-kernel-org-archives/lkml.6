Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E2DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1831920661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1831920661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbeICVqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:46:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45768 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728380AbeICVqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:46:45 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E8122D24;
        Mon,  3 Sep 2018 17:25:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.14 122/165] fuse: umount should wait for all requests
Date:   Mon,  3 Sep 2018 18:56:48 +0200
Message-Id: <20180903165701.670340768@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit b8f95e5d13f5f0191dcb4b9113113d241636e7cb upstream.

fuse_abort_conn() does not guarantee that all async requests have actually
finished aborting (i.e. their ->end() function is called).  This could
actually result in still used inodes after umount.

Add a helper to wait until all requests are fully done.  This is done by
looking at the "num_waiting" counter.  When this counter drops to zero, we
can be sure that no more requests are outstanding.

Fixes: 0d8e84b0432b ("fuse: simplify request abort")
Cc: <stable@vger.kernel.org> # v4.2
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dev.c    |   23 +++++++++++++++++++----
 fs/fuse/fuse_i.h |    1 +
 fs/fuse/inode.c  |    2 ++
 3 files changed, 22 insertions(+), 4 deletions(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -131,6 +131,16 @@ static bool fuse_block_alloc(struct fuse
 	return !fc->initialized || (for_background && fc->blocked);
 }
 
+static void fuse_drop_waiting(struct fuse_conn *fc)
+{
+	if (fc->connected) {
+		atomic_dec(&fc->num_waiting);
+	} else if (atomic_dec_and_test(&fc->num_waiting)) {
+		/* wake up aborters */
+		wake_up_all(&fc->blocked_waitq);
+	}
+}
+
 static struct fuse_req *__fuse_get_req(struct fuse_conn *fc, unsigned npages,
 				       bool for_background)
 {
@@ -171,7 +181,7 @@ static struct fuse_req *__fuse_get_req(s
 	return req;
 
  out:
-	atomic_dec(&fc->num_waiting);
+	fuse_drop_waiting(fc);
 	return ERR_PTR(err);
 }
 
@@ -278,7 +288,7 @@ void fuse_put_request(struct fuse_conn *
 
 		if (test_bit(FR_WAITING, &req->flags)) {
 			__clear_bit(FR_WAITING, &req->flags);
-			atomic_dec(&fc->num_waiting);
+			fuse_drop_waiting(fc);
 		}
 
 		if (req->stolen_file)
@@ -364,7 +374,7 @@ static void request_end(struct fuse_conn
 	struct fuse_iqueue *fiq = &fc->iq;
 
 	if (test_and_set_bit(FR_FINISHED, &req->flags))
-		goto out_put_req;
+		goto put_request;
 
 	spin_lock(&fiq->waitq.lock);
 	list_del_init(&req->intr_entry);
@@ -393,7 +403,7 @@ static void request_end(struct fuse_conn
 	wake_up(&req->waitq);
 	if (req->end)
 		req->end(fc, req);
-out_put_req:
+put_request:
 	fuse_put_request(fc, req);
 }
 
@@ -2141,6 +2151,11 @@ void fuse_abort_conn(struct fuse_conn *f
 }
 EXPORT_SYMBOL_GPL(fuse_abort_conn);
 
+void fuse_wait_aborted(struct fuse_conn *fc)
+{
+	wait_event(fc->blocked_waitq, atomic_read(&fc->num_waiting) == 0);
+}
+
 int fuse_dev_release(struct inode *inode, struct file *file)
 {
 	struct fuse_dev *fud = fuse_get_dev(file);
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -852,6 +852,7 @@ void fuse_request_send_background_locked
 
 /* Abort all requests */
 void fuse_abort_conn(struct fuse_conn *fc);
+void fuse_wait_aborted(struct fuse_conn *fc);
 
 /**
  * Invalidate inode attributes
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -400,6 +400,8 @@ static void fuse_put_super(struct super_
 	fuse_send_destroy(fc);
 
 	fuse_abort_conn(fc);
+	fuse_wait_aborted(fc);
+
 	mutex_lock(&fuse_mutex);
 	list_del(&fc->entry);
 	fuse_ctl_remove_conn(fc);


