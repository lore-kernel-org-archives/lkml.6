Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17307C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 07:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A249824B12
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 07:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A249824B12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeFWHFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 03:05:39 -0400
Received: from verein.lst.de ([213.95.11.211]:59701 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbeFWHFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 03:05:37 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0915668C4E; Sat, 23 Jun 2018 09:15:08 +0200 (CEST)
Date:   Sat, 23 Jun 2018 09:15:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        kernel test robot <xiaolong.ye@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, lkp@01.org
Subject: Re: [lkp-robot] [fs]  3deb642f0d:  will-it-scale.per_process_ops
        -8.8% regression
Message-ID: <20180623071508.GA848@lst.de>
References: <20180622082752.GX11011@yexl-desktop> <20180622150251.GA12802@lst.de> <20180622151409.GA30522@ZenIV.linux.org.uk> <20180622152850.GA14366@lst.de> <20180622161802.GA18957@lst.de> <20180622200255.GB30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622200255.GB30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 09:02:55PM +0100, Al Viro wrote:
> > While at the same time corect poll code already checks net_busy_loop_on
> > to set POLL_BUSY_LOOP.  So except for sockets where people set the
> > timeout to 0 the code already does the right thing as-is.  IMHO not
> > really worth wasting a FMODE_* flag for it, but if you insist I'll add
> > it.
> 
> It's not just that - there's also an issue of extra indirect call on the
> fast path for sockets.  You get this method of yours + ->poll_mask(),
> which hits another indirect to per-family ->poll_mask().  It might be
> better to have these combined, sparing us an extra indirect call.
> 
> Just give it the same calling conventions as ->poll_mask() have...

The problem is that for the busy poll we want the actual busy poll +
__pollwait + ->poll_mask.  Which is going to make that new poll_busy_loop
with a return value look exactly like ->poll.

So for now I'm tempted to just do this:

---
From 4abf23f6565ff2a74f1859758f9c894abe476a00 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Sat, 23 Jun 2018 09:02:59 +0200
Subject: FOLD: remove ->poll_busy_loop again

Busy looping always comes in from poll(2) or select(2).  So instead of
adding a separate method we can just do it at the beginning of ->poll
for now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/select.c        |  8 --------
 include/linux/fs.h |  1 -
 net/socket.c       | 20 ++++++--------------
 3 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 25327efca2f9..c68f7cdc777a 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -38,14 +38,6 @@ __poll_t vfs_poll(struct file *file, struct poll_table_struct *pt)
 {
 	unsigned int events = poll_requested_events(pt);
 
-	/*
-	 * XXX: might be worth adding a f_mode flag to see if busy looping is
-	 * supported.  Although callers probably only keep setting it when
-	 * supported, that's why POLL_BUSY_LOOP is reported in the output.
-	 */
-	if ((events & POLL_BUSY_LOOP) && file->f_op->poll_busy_loop)
-		file->f_op->poll_busy_loop(file, events);
-
 	if (file->f_op->poll) {
 		return file->f_op->poll(file, pt);
 	} else if (file->f_poll_head) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 82133bd1a047..bfaebdc03878 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1722,7 +1722,6 @@ struct file_operations {
 	int (*iterate_shared) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
 	__poll_t (*poll_mask) (struct file *, __poll_t);
-	void (*poll_busy_loop)(struct file *file, __poll_t events);
 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
diff --git a/net/socket.c b/net/socket.c
index b52e5b900e09..0aaa49190b30 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -131,19 +131,6 @@ static ssize_t sock_splice_read(struct file *file, loff_t *ppos,
 				struct pipe_inode_info *pipe, size_t len,
 				unsigned int flags);
 
-#ifdef CONFIG_NET_RX_BUSY_POLL
-static void sock_poll_busy_loop(struct file *file, __poll_t events)
-{
-	struct socket *sock = file->private_data;
-
-	/* once, only if requested by syscall */
-	if (sk_can_busy_loop(sock->sk))
-		sk_busy_loop(sock->sk, 1);
-}
-#else
-#define sock_poll_busy_loop	NULL
-#endif
-
 /*
  *	Socket files have a set of 'special' operations as well as the generic file ones. These don't appear
  *	in the operation structures but are done directly via the socketcall() multiplexor.
@@ -155,7 +142,6 @@ static const struct file_operations socket_file_ops = {
 	.read_iter =	sock_read_iter,
 	.write_iter =	sock_write_iter,
 	.poll_mask =	sock_poll_mask,
-	.poll_busy_loop = sock_poll_busy_loop,
 	.poll =		sock_poll,
 	.unlocked_ioctl = sock_ioctl,
 #ifdef CONFIG_COMPAT
@@ -1163,6 +1149,12 @@ static __poll_t sock_poll(struct file *file, poll_table *wait)
 	struct socket *sock = file->private_data;
 	__poll_t events = poll_requested_events(wait), mask = 0;
 
+	/*
+	 * Poll once, if requested by syscall.
+	 */
+	if ((events & POLL_BUSY_LOOP) && sk_can_busy_loop(sock->sk))
+		sk_busy_loop(sock->sk, 1);
+
 	if (sock->ops->poll) {
 		mask = sock->ops->poll(file, sock, wait);
 	} else if (sock->ops->poll_mask) {
-- 
2.17.1

