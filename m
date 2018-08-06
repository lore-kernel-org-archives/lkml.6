Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE51C46473
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00BF219C4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rqV+xmNO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B00BF219C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeHFKjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:39:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51904 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeHFKjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cYduYFeDVLVC4oMSl/Mqd2GZ9VdhB90E2+ZT48eaChM=; b=rqV+xmNOQXkoYFUnffXZzO/Ie
        1v9GIpwd5MZexL2yukUZ2ytc0enMPzi80d/R7YqU97G01DHKMshTK83SlwBPOtZQnzdhjLsr6vBhf
        8UTyDS76+/FIa0kNFz46WTd/HM2tJen28yuLaphs7hYEolhgcMogfqkUPHIgh9AgMHJLRO3ivfxdB
        d9y/pknTD0ACs3sNm3LEcN6tfe4id+FTfHagJzqUPONSO06ynediYrNP/VoW11plyi38jmDp37rtz
        mGr0dVW9yiXjhyY9d/8TfrhFIOHyji4QkfelRE+3VvG0d0n1tom1AJRXIbYh1Bttna4V8S5QwTS+9
        YxJ0uL2ng==;
Received: from 212095005054.public.telering.at ([212.95.5.54] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmav1-0001Nz-Oa; Mon, 06 Aug 2018 08:31:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     Avi Kivity <avi@scylladb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] aio: implement IOCB_CMD_POLL
Date:   Mon,  6 Aug 2018 10:30:57 +0200
Message-Id: <20180806083058.14724-4-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180806083058.14724-1-hch@lst.de>
References: <20180806083058.14724-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple one-shot poll through the io_submit() interface.  To poll for
a file descriptor the application should submit an iocb of type
IOCB_CMD_POLL.  It will poll the fd for the events specified in the
the first 32 bits of the aio_buf field of the iocb.

Unlike poll or epoll without EPOLLONESHOT this interface always works
in one shot mode, that is once the iocb is completed, it will have to be
resubmitted.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Avi Kivity <avi@scylladb.com>
---
 fs/aio.c                     | 178 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/aio_abi.h |   6 +-
 2 files changed, 180 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index fe2018ada32c..2fd19521d8a8 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -5,6 +5,7 @@
  *	Implements an efficient asynchronous io interface.
  *
  *	Copyright 2000, 2001, 2002 Red Hat, Inc.  All Rights Reserved.
+ *	Copyright 2018 Christoph Hellwig.
  *
  *	See ../COPYING for licensing terms.
  */
@@ -165,10 +166,21 @@ struct fsync_iocb {
 	bool			datasync;
 };
 
+struct poll_iocb {
+	struct file		*file;
+	struct wait_queue_head	*head;
+	__poll_t		events;
+	bool			woken;
+	bool			cancelled;
+	struct wait_queue_entry	wait;
+	struct work_struct	work;
+};
+
 struct aio_kiocb {
 	union {
 		struct kiocb		rw;
 		struct fsync_iocb	fsync;
+		struct poll_iocb	poll;
 	};
 
 	struct kioctx		*ki_ctx;
@@ -1601,6 +1613,169 @@ static int aio_fsync(struct fsync_iocb *req, struct iocb *iocb, bool datasync)
 	return 0;
 }
 
+static inline void aio_poll_complete(struct aio_kiocb *iocb, __poll_t mask)
+{
+	struct file *file = iocb->poll.file;
+
+	aio_complete(iocb, mangle_poll(mask), 0);
+	fput(file);
+}
+
+static void aio_poll_complete_work(struct work_struct *work)
+{
+	struct poll_iocb *req = container_of(work, struct poll_iocb, work);
+	struct aio_kiocb *iocb = container_of(req, struct aio_kiocb, poll);
+	struct poll_table_struct pt = { ._key = req->events };
+	struct kioctx *ctx = iocb->ki_ctx;
+	__poll_t mask = 0;
+
+	if (!READ_ONCE(req->cancelled))
+		mask = vfs_poll(req->file, &pt) & req->events;
+
+	/*
+	 * Note that ->ki_cancel callers also delete iocb from active_reqs after
+	 * calling ->ki_cancel.  We need the ctx_lock roundtrip here to
+	 * synchronize with them.  In the cancellation case the list_del_init
+	 * itself is not actually needed, but harmless so we keep it in to
+	 * avoid further branches in the fast path.
+	 */
+	spin_lock_irq(&ctx->ctx_lock);
+	if (!mask && !READ_ONCE(req->cancelled)) {
+		add_wait_queue(req->head, &req->wait);
+		spin_unlock_irq(&ctx->ctx_lock);
+		return;
+	}
+	list_del_init(&iocb->ki_list);
+	spin_unlock_irq(&ctx->ctx_lock);
+
+	aio_poll_complete(iocb, mask);
+}
+
+/* assumes we are called with irqs disabled */
+static int aio_poll_cancel(struct kiocb *iocb)
+{
+	struct aio_kiocb *aiocb = container_of(iocb, struct aio_kiocb, rw);
+	struct poll_iocb *req = &aiocb->poll;
+
+	spin_lock(&req->head->lock);
+	WRITE_ONCE(req->cancelled, true);
+	if (!list_empty(&req->wait.entry)) {
+		list_del_init(&req->wait.entry);
+		schedule_work(&aiocb->poll.work);
+	}
+	spin_unlock(&req->head->lock);
+
+	return 0;
+}
+
+static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
+		void *key)
+{
+	struct poll_iocb *req = container_of(wait, struct poll_iocb, wait);
+	__poll_t mask = key_to_poll(key);
+
+	req->woken = true;
+
+	/* for instances that support it check for an event match first: */
+	if (mask && !(mask & req->events))
+		return 0;
+
+	list_del_init(&req->wait.entry);
+	schedule_work(&req->work);
+	return 1;
+}
+
+struct aio_poll_table {
+	struct poll_table_struct	pt;
+	struct aio_kiocb		*iocb;
+	int				error;
+};
+
+static void
+aio_poll_queue_proc(struct file *file, struct wait_queue_head *head,
+		struct poll_table_struct *p)
+{
+	struct aio_poll_table *pt = container_of(p, struct aio_poll_table, pt);
+
+	/* multiple wait queues per file are not supported */
+	if (unlikely(pt->iocb->poll.head)) {
+		pt->error = -EINVAL;
+		return;
+	}
+
+	pt->error = 0;
+	pt->iocb->poll.head = head;
+	add_wait_queue(head, &pt->iocb->poll.wait);
+}
+
+static ssize_t aio_poll(struct aio_kiocb *aiocb, struct iocb *iocb)
+{
+	struct kioctx *ctx = aiocb->ki_ctx;
+	struct poll_iocb *req = &aiocb->poll;
+	struct aio_poll_table apt;
+	__poll_t mask;
+
+	/* reject any unknown events outside the normal event mask. */
+	if ((u16)iocb->aio_buf != iocb->aio_buf)
+		return -EINVAL;
+	/* reject fields that are not defined for poll */
+	if (iocb->aio_offset || iocb->aio_nbytes || iocb->aio_rw_flags)
+		return -EINVAL;
+
+	INIT_WORK(&req->work, aio_poll_complete_work);
+	req->events = demangle_poll(iocb->aio_buf) | EPOLLERR | EPOLLHUP;
+	req->file = fget(iocb->aio_fildes);
+	if (unlikely(!req->file))
+		return -EBADF;
+
+	apt.pt._qproc = aio_poll_queue_proc;
+	apt.pt._key = req->events;
+	apt.iocb = aiocb;
+	apt.error = -EINVAL; /* same as no support for IOCB_CMD_POLL */
+
+	/* initialized the list so that we can do list_empty checks */
+	INIT_LIST_HEAD(&req->wait.entry);
+	init_waitqueue_func_entry(&req->wait, aio_poll_wake);
+
+	/* one for removal from waitqueue, one for this function */
+	refcount_set(&aiocb->ki_refcnt, 2);
+
+	mask = vfs_poll(req->file, &apt.pt) & req->events;
+	if (unlikely(!req->head)) {
+		/* we did not manage to set up a waitqueue, done */
+		goto out;
+	}
+
+	spin_lock_irq(&ctx->ctx_lock);
+	spin_lock(&req->head->lock);
+	if (req->woken) {
+		/* wake_up context handles the rest */
+		mask = 0;
+		apt.error = 0;
+	} else if (mask || apt.error) {
+		/* if we get an error or a mask we are done */
+		WARN_ON_ONCE(list_empty(&req->wait.entry));
+		list_del_init(&req->wait.entry);
+	} else {
+		/* actually waiting for an event */
+		list_add_tail(&aiocb->ki_list, &ctx->active_reqs);
+		aiocb->ki_cancel = aio_poll_cancel;
+	}
+	spin_unlock(&req->head->lock);
+	spin_unlock_irq(&ctx->ctx_lock);
+
+out:
+	if (unlikely(apt.error)) {
+		fput(req->file);
+		return apt.error;
+	}
+
+	if (mask)
+		aio_poll_complete(aiocb, mask);
+	iocb_put(aiocb);
+	return 0;
+}
+
 static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 			 bool compat)
 {
@@ -1674,6 +1849,9 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 	case IOCB_CMD_FDSYNC:
 		ret = aio_fsync(&req->fsync, &iocb, true);
 		break;
+	case IOCB_CMD_POLL:
+		ret = aio_poll(req, &iocb);
+		break;
 	default:
 		pr_debug("invalid aio operation %d\n", iocb.aio_lio_opcode);
 		ret = -EINVAL;
diff --git a/include/uapi/linux/aio_abi.h b/include/uapi/linux/aio_abi.h
index d4593a6062ef..ce43d340f010 100644
--- a/include/uapi/linux/aio_abi.h
+++ b/include/uapi/linux/aio_abi.h
@@ -38,10 +38,8 @@ enum {
 	IOCB_CMD_PWRITE = 1,
 	IOCB_CMD_FSYNC = 2,
 	IOCB_CMD_FDSYNC = 3,
-	/* These two are experimental.
-	 * IOCB_CMD_PREADX = 4,
-	 * IOCB_CMD_POLL = 5,
-	 */
+	/* 4 was the experimental IOCB_CMD_PREADX */
+	IOCB_CMD_POLL = 5,
 	IOCB_CMD_NOOP = 6,
 	IOCB_CMD_PREADV = 7,
 	IOCB_CMD_PWRITEV = 8,
-- 
2.18.0

