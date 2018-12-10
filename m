Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFB1C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05CA2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05CA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeLJRPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:15:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728514AbeLJRNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:40 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9EE030020B2;
        Mon, 10 Dec 2018 17:13:39 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 800B619936;
        Mon, 10 Dec 2018 17:13:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 23B5A223BF9; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 08/52] fuse: add fuse_iqueue_ops callbacks
Date:   Mon, 10 Dec 2018 12:12:34 -0500
Message-Id: <20181210171318.16998-9-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 10 Dec 2018 17:13:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Hajnoczi <stefanha@redhat.com>

The /dev/fuse device uses fiq->waitq and fasync to signal that requests
are available.  These mechanisms do not apply to virtio-fs.  This patch
introduces callbacks so alternative behavior can be used.

Note that queue_interrupt() changes along these lines:

  spin_lock(&fiq->waitq.lock);
  wake_up_locked(&fiq->waitq);
+ kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
  spin_unlock(&fiq->waitq.lock);
- kill_fasync(&fiq->fasync, SIGIO, POLL_IN);

Since queue_request() and queue_forget() also call kill_fasync() inside
the spinlock this should be safe.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 fs/fuse/cuse.c   |  2 +-
 fs/fuse/dev.c    | 50 ++++++++++++++++++++++++++++++++++----------------
 fs/fuse/fuse_i.h | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/inode.c  | 18 +++++++++++++-----
 4 files changed, 93 insertions(+), 23 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 8f68181256c0..98dc780cbafa 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -503,7 +503,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 	 * Limit the cuse channel to requests that can
 	 * be represented in file->f_cred->user_ns.
 	 */
-	fuse_conn_init(&cc->fc, file->f_cred->user_ns);
+	fuse_conn_init(&cc->fc, file->f_cred->user_ns, &fuse_dev_fiq_ops, NULL);
 
 	fud = fuse_dev_alloc(&cc->fc);
 	if (!fud) {
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 7fd627d5cf58..b26ee5ed8974 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -371,13 +371,33 @@ static unsigned int fuse_req_hash(u64 unique)
 	return hash_long(unique & ~FUSE_INT_REQ_BIT, FUSE_PQ_HASH_BITS);
 }
 
-static void queue_request(struct fuse_iqueue *fiq, struct fuse_req *req)
+/**
+ * A new request is available, wake fiq->waitq
+ */
+static void fuse_dev_wake_and_unlock(struct fuse_iqueue *fiq)
+__releases(fiq->waitq.lock)
 {
-	req->in.h.len = sizeof(struct fuse_in_header) +
-		fuse_len_args(req->in.numargs, (struct fuse_arg *) req->in.args);
-	list_add_tail(&req->list, &fiq->pending);
 	wake_up_locked(&fiq->waitq);
 	kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
+	spin_unlock(&fiq->waitq.lock);
+}
+
+const struct fuse_iqueue_ops fuse_dev_fiq_ops = {
+	.wake_forget_and_unlock		= fuse_dev_wake_and_unlock,
+	.wake_interrupt_and_unlock	= fuse_dev_wake_and_unlock,
+	.wake_pending_and_unlock	= fuse_dev_wake_and_unlock,
+};
+EXPORT_SYMBOL_GPL(fuse_dev_fiq_ops);
+
+static void queue_request_and_unlock(struct fuse_iqueue *fiq,
+				     struct fuse_req *req)
+__releases(fiq->waitq.lock)
+{
+	req->in.h.len = sizeof(struct fuse_in_header) +
+		fuse_len_args(req->in.numargs,
+			      (struct fuse_arg *) req->in.args);
+	list_add_tail(&req->list, &fiq->pending);
+	fiq->ops->wake_pending_and_unlock(fiq);
 }
 
 void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
@@ -392,12 +412,11 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
 	if (fiq->connected) {
 		fiq->forget_list_tail->next = forget;
 		fiq->forget_list_tail = forget;
-		wake_up_locked(&fiq->waitq);
-		kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
+		fiq->ops->wake_forget_and_unlock(fiq);
 	} else {
 		kfree(forget);
+		spin_unlock(&fiq->waitq.lock);
 	}
-	spin_unlock(&fiq->waitq.lock);
 }
 
 static void flush_bg_queue(struct fuse_conn *fc)
@@ -413,8 +432,7 @@ static void flush_bg_queue(struct fuse_conn *fc)
 		fc->active_background++;
 		spin_lock(&fiq->waitq.lock);
 		req->in.h.unique = fuse_get_unique(fiq);
-		queue_request(fiq, req);
-		spin_unlock(&fiq->waitq.lock);
+		queue_request_and_unlock(fiq, req);
 	}
 }
 
@@ -481,10 +499,10 @@ static void queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 	}
 	if (list_empty(&req->intr_entry)) {
 		list_add_tail(&req->intr_entry, &fiq->interrupts);
-		wake_up_locked(&fiq->waitq);
+		fiq->ops->wake_interrupt_and_unlock(fiq);
+	} else {
+		spin_unlock(&fiq->waitq.lock);
 	}
-	spin_unlock(&fiq->waitq.lock);
-	kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
 }
 
 static void request_wait_answer(struct fuse_conn *fc, struct fuse_req *req)
@@ -543,11 +561,10 @@ static void __fuse_request_send(struct fuse_conn *fc, struct fuse_req *req)
 		req->out.h.error = -ENOTCONN;
 	} else {
 		req->in.h.unique = fuse_get_unique(fiq);
-		queue_request(fiq, req);
 		/* acquire extra reference, since request is still needed
 		   after fuse_request_end() */
 		__fuse_get_request(req);
-		spin_unlock(&fiq->waitq.lock);
+		queue_request_and_unlock(fiq, req);
 
 		request_wait_answer(fc, req);
 		/* Pairs with smp_wmb() in fuse_request_end() */
@@ -680,10 +697,11 @@ static int fuse_request_send_notify_reply(struct fuse_conn *fc,
 	req->in.h.unique = unique;
 	spin_lock(&fiq->waitq.lock);
 	if (fiq->connected) {
-		queue_request(fiq, req);
+		queue_request_and_unlock(fiq, req);
 		err = 0;
+	} else {
+		spin_unlock(&fiq->waitq.lock);
 	}
-	spin_unlock(&fiq->waitq.lock);
 
 	return err;
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f41ebc723e01..60ebe3c2e2c3 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -454,6 +454,39 @@ struct fuse_req {
 	struct file *stolen_file;
 };
 
+struct fuse_iqueue;
+
+/**
+ * Input queue callbacks
+ *
+ * Input queue signalling is device-specific.  For example, the /dev/fuse file
+ * uses fiq->waitq and fasync to wake processes that are waiting on queue
+ * readiness.  These callbacks allow other device types to respond to input
+ * queue activity.
+ */
+struct fuse_iqueue_ops {
+	/**
+	 * Signal that a forget has been queued
+	 */
+	void (*wake_forget_and_unlock)(struct fuse_iqueue *fiq)
+	__releases(fiq->waitq.lock);
+
+	/**
+	 * Signal that an INTERRUPT request has been queued
+	 */
+	void (*wake_interrupt_and_unlock)(struct fuse_iqueue *fiq)
+	__releases(fiq->waitq.lock);
+
+	/**
+	 * Signal that a request has been queued
+	 */
+	void (*wake_pending_and_unlock)(struct fuse_iqueue *fiq)
+	__releases(fiq->waitq.lock);
+};
+
+/** /dev/fuse input queue operations */
+extern const struct fuse_iqueue_ops fuse_dev_fiq_ops;
+
 struct fuse_iqueue {
 	/** Connection established */
 	unsigned connected;
@@ -479,6 +512,12 @@ struct fuse_iqueue {
 
 	/** O_ASYNC requests */
 	struct fasync_struct *fasync;
+
+	/** Device-specific callbacks */
+	const struct fuse_iqueue_ops *ops;
+
+	/** Device-specific state */
+	void *priv;
 };
 
 #define FUSE_PQ_HASH_BITS 8
@@ -982,7 +1021,8 @@ struct fuse_conn *fuse_conn_get(struct fuse_conn *fc);
 /**
  * Initialize fuse_conn
  */
-void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns);
+void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
+		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv);
 
 /**
  * Release reference to fuse_conn
@@ -1002,10 +1042,14 @@ int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
  * Fill in superblock and initialize fuse connection
  * @sb: partially-initialized superblock to fill in
  * @mount_data: mount parameters
+ * @fiq_ops: fuse input queue operations
+ * @fiq_priv: device-specific state for fuse_iqueue
  * @fudptr: fuse_dev pointer to fill in, should contain NULL on entry
  */
 int fuse_fill_super_common(struct super_block *sb,
 			   struct fuse_mount_data *mount_data,
+			   const struct fuse_iqueue_ops *fiq_ops,
+			   void *fiq_priv,
 			   void **fudptr);
 
 /**
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 65fd59fc1e81..31bb817575c4 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -574,7 +574,9 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-static void fuse_iqueue_init(struct fuse_iqueue *fiq)
+static void fuse_iqueue_init(struct fuse_iqueue *fiq,
+			     const struct fuse_iqueue_ops *ops,
+			     void *priv)
 {
 	memset(fiq, 0, sizeof(struct fuse_iqueue));
 	init_waitqueue_head(&fiq->waitq);
@@ -582,6 +584,8 @@ static void fuse_iqueue_init(struct fuse_iqueue *fiq)
 	INIT_LIST_HEAD(&fiq->interrupts);
 	fiq->forget_list_tail = &fiq->forget_list_head;
 	fiq->connected = 1;
+	fiq->ops = ops;
+	fiq->priv = priv;
 }
 
 static void fuse_pqueue_init(struct fuse_pqueue *fpq)
@@ -595,7 +599,8 @@ static void fuse_pqueue_init(struct fuse_pqueue *fpq)
 	fpq->connected = 1;
 }
 
-void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns)
+void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
+		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv)
 {
 	memset(fc, 0, sizeof(*fc));
 	spin_lock_init(&fc->lock);
@@ -605,7 +610,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns)
 	atomic_set(&fc->dev_count, 1);
 	init_waitqueue_head(&fc->blocked_waitq);
 	init_waitqueue_head(&fc->reserved_req_waitq);
-	fuse_iqueue_init(&fc->iq);
+	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
 	INIT_LIST_HEAD(&fc->devices);
@@ -1067,6 +1072,8 @@ EXPORT_SYMBOL_GPL(fuse_dev_free);
 
 int fuse_fill_super_common(struct super_block *sb,
 			   struct fuse_mount_data *mount_data,
+			   const struct fuse_iqueue_ops *fiq_ops,
+			   void *fiq_priv,
 			   void **fudptr)
 {
 	struct fuse_dev *fud;
@@ -1115,7 +1122,7 @@ int fuse_fill_super_common(struct super_block *sb,
 	if (!fc)
 		goto err;
 
-	fuse_conn_init(fc, sb->s_user_ns);
+	fuse_conn_init(fc, sb->s_user_ns, fiq_ops, fiq_priv);
 	fc->release = fuse_free_conn;
 
 	fud = fuse_dev_alloc(fc);
@@ -1226,7 +1233,8 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
 	    (file->f_cred->user_ns != sb->s_user_ns))
 		goto err_fput;
 
-	err = fuse_fill_super_common(sb, &d, &file->private_data);
+	err = fuse_fill_super_common(sb, &d, &fuse_dev_fiq_ops, NULL,
+				     &file->private_data);
 err_fput:
 	fput(file);
 err:
-- 
2.13.6

