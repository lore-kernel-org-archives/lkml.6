Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A6AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCB0208A5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCB0208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933955AbeFRNrd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:47:33 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45728 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932630AbeFRNrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:47:32 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fUuVG-0000zz-Tz; Mon, 18 Jun 2018 13:47:30 +0000
Date:   Mon, 18 Jun 2018 14:47:30 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] __poll_t regressions this cycle
Message-ID: <20180618134730.GO30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Some misannotations cropped up in this cycle's merges;
the fixes are trivial.  Do you prefer it in one commit, or
split into per-driver pieces?

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 95283f3bb51c..7fbb86215809 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4412,7 +4412,7 @@ static __poll_t binder_poll(struct file *filp,
 
 	thread = binder_get_thread(proc);
 	if (!thread)
-		return POLLERR;
+		return EPOLLERR;
 
 	binder_inner_proc_lock(thread->proc);
 	thread->looper |= BINDER_LOOPER_STATE_POLL;
diff --git a/drivers/char/random.c b/drivers/char/random.c
index a8fb0020ba5c..a7b9be0c7c7e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -722,7 +722,7 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 		/* should we wake readers? */
 		if (entropy_bits >= random_read_wakeup_bits &&
 		    wq_has_sleeper(&random_wait)) {
-			wake_up_interruptible_poll(&random_wait, POLLIN);
+			wake_up_interruptible_poll(&random_wait, EPOLLIN);
 			kill_fasync(&fasync, SIGIO, POLL_IN);
 		}
 		/* If the input pool is getting full, send some
@@ -1396,7 +1396,7 @@ static size_t account(struct entropy_store *r, size_t nbytes, int min,
 	trace_debit_entropy(r->name, 8 * ibytes);
 	if (ibytes &&
 	    (r->entropy_count >> ENTROPY_SHIFT) < random_write_wakeup_bits) {
-		wake_up_interruptible_poll(&random_wait, POLLOUT);
+		wake_up_interruptible_poll(&random_wait, EPOLLOUT);
 		kill_fasync(&fasync, SIGIO, POLL_OUT);
 	}
 
diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
index 9f8312137cad..7763c55f355d 100644
--- a/drivers/gpu/drm/drm_debugfs_crc.c
+++ b/drivers/gpu/drm/drm_debugfs_crc.c
@@ -307,17 +307,17 @@ static ssize_t crtc_crc_read(struct file *filep, char __user *user_buf,
 	return LINE_LEN(crc->values_cnt);
 }
 
-static unsigned int crtc_crc_poll(struct file *file, poll_table *wait)
+static __poll_t crtc_crc_poll(struct file *file, poll_table *wait)
 {
 	struct drm_crtc *crtc = file->f_inode->i_private;
 	struct drm_crtc_crc *crc = &crtc->crc;
-	unsigned ret;
+	__poll_t ret;
 
 	poll_wait(file, &crc->wq, wait);
 
 	spin_lock_irq(&crc->lock);
 	if (crc->source && crtc_crc_data_count(crc))
-		ret = POLLIN | POLLRDNORM;
+		ret = EPOLLIN | EPOLLRDNORM;
 	else
 		ret = 0;
 	spin_unlock_irq(&crc->lock);
diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
index fb83d1375638..5efef9f6e76d 100644
--- a/drivers/misc/ibmvmc.c
+++ b/drivers/misc/ibmvmc.c
@@ -999,11 +999,11 @@ static ssize_t ibmvmc_read(struct file *file, char *buf, size_t nbytes,
  * Return:
  *	poll.h return values
  */
-static unsigned int ibmvmc_poll(struct file *file, poll_table *wait)
+static __poll_t ibmvmc_poll(struct file *file, poll_table *wait)
 {
 	struct ibmvmc_file_session *session;
 	struct ibmvmc_hmc *hmc;
-	unsigned int mask = 0;
+	__poll_t mask = 0;
 
 	session = file->private_data;
 	if (!session)
@@ -1016,7 +1016,7 @@ static unsigned int ibmvmc_poll(struct file *file, poll_table *wait)
 	poll_wait(file, &ibmvmc_read_wait, wait);
 
 	if (hmc->queue_head != hmc->queue_tail)
-		mask |= POLLIN | POLLRDNORM;
+		mask |= EPOLLIN | EPOLLRDNORM;
 
 	return mask;
 }
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 7465f17e1559..826e7e1fc34f 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -600,10 +600,10 @@ static __poll_t mei_poll(struct file *file, poll_table *wait)
 			mei_cl_read_start(cl, mei_cl_mtu(cl), file);
 	}
 
-	if (req_events & (POLLOUT | POLLWRNORM)) {
+	if (req_events & (EPOLLOUT | EPOLLWRNORM)) {
 		poll_wait(file, &cl->tx_wait, wait);
 		if (cl->tx_cb_queued < dev->tx_queue_limit)
-			mask |= POLLOUT | POLLWRNORM;
+			mask |= EPOLLOUT | EPOLLWRNORM;
 	}
 
 out:
diff --git a/drivers/scsi/cxlflash/ocxl_hw.c b/drivers/scsi/cxlflash/ocxl_hw.c
index 0a95b5f25380..1b6198e5a565 100644
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -1015,20 +1015,20 @@ static inline bool ctx_event_pending(struct ocxlflash_context *ctx)
  *
  * Return: poll mask
  */
-static unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
+static __poll_t afu_poll(struct file *file, struct poll_table_struct *poll)
 {
 	struct ocxlflash_context *ctx = file->private_data;
 	struct device *dev = ctx->hw_afu->dev;
 	ulong lock_flags;
-	int mask = 0;
+	__poll_t mask = 0;
 
 	poll_wait(file, &ctx->wq, poll);
 
 	spin_lock_irqsave(&ctx->slock, lock_flags);
 	if (ctx_event_pending(ctx))
-		mask |= POLLIN | POLLRDNORM;
+		mask |= EPOLLIN | EPOLLRDNORM;
 	else if (ctx->state == CLOSED)
-		mask |= POLLERR;
+		mask |= EPOLLERR;
 	spin_unlock_irqrestore(&ctx->slock, lock_flags);
 
 	dev_dbg(dev, "%s: Poll wait completed for pe %i mask %i\n",
diff --git a/fs/select.c b/fs/select.c
index 317891ff8165..1335288ed67a 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -39,7 +39,7 @@ __poll_t vfs_poll(struct file *file, struct poll_table_struct *pt)
 	if (file->f_op->poll) {
 		return file->f_op->poll(file, pt);
 	} else if (file_has_poll_mask(file)) {
-		unsigned int events = poll_requested_events(pt);
+		__poll_t events = poll_requested_events(pt);
 		struct wait_queue_head *head;
 
 		if (pt && pt->_qproc) {
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index ab751a150f70..1c5f9693af4c 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -185,7 +185,7 @@ static __poll_t rds_poll(struct file *file, struct socket *sock,
 	if (rs->rs_snd_bytes < rds_sk_sndbuf(rs))
 		mask |= (EPOLLOUT | EPOLLWRNORM);
 	if (sk->sk_err || !skb_queue_empty(&sk->sk_error_queue))
-		mask |= POLLERR;
+		mask |= EPOLLERR;
 	read_unlock_irqrestore(&rs->rs_recv_lock, flags);
 
 	/* clear state any time we wake a seen-congested socket */
diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 36919a254ba3..82d321b8e61b 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -307,9 +307,9 @@ static __poll_t xsk_poll_mask(struct socket *sock, __poll_t events)
 	struct xdp_sock *xs = xdp_sk(sk);
 
 	if (xs->rx && !xskq_empty_desc(xs->rx))
-		mask |= POLLIN | POLLRDNORM;
+		mask |= EPOLLIN | EPOLLRDNORM;
 	if (xs->tx && !xskq_full_desc(xs->tx))
-		mask |= POLLOUT | POLLWRNORM;
+		mask |= EPOLLOUT | EPOLLWRNORM;
 
 	return mask;
 }
