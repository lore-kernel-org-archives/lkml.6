Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AA8ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2A52124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2A52124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387459AbeGLW7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:59:43 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49396 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733242AbeGLW7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:59:43 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fdkNN-0006lk-Eb; Thu, 12 Jul 2018 22:47:53 +0000
Date:   Thu, 12 Jul 2018 23:47:53 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: speakup: fix wraparound in uaccess length check
Message-ID: <20180712224753.GE30522@ZenIV.linux.org.uk>
References: <20180712222935.257776-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712222935.257776-1-jannh@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 12:29:36AM +0200, Jann Horn wrote:
> From: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> From: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> If softsynthx_read() is called with `count < 3`, `count - 3` wraps, causing
> the loop to copy as much data as available to the provided buffer. If
> softsynthx_read() is invoked through sys_splice(), this causes an
> unbounded kernel write; but even when userspace just reads from it
> normally, a small size could cause userspace crashes.

Or you could try this (completely untested, though):

diff --git a/drivers/staging/speakup/speakup_soft.c b/drivers/staging/speakup/speakup_soft.c
index a61bc41b82d7..198936ed0b54 100644
--- a/drivers/staging/speakup/speakup_soft.c
+++ b/drivers/staging/speakup/speakup_soft.c
@@ -192,13 +192,10 @@ static int softsynth_close(struct inode *inode, struct file *fp)
 	return 0;
 }
 
-static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
-			       loff_t *pos, int unicode)
+static ssize_t softsynthx_read_iter(struct kiocb *iocb, struct iov_iter *to, int unicode)
 {
 	int chars_sent = 0;
-	char __user *cp;
 	char *init;
-	u16 ch;
 	int empty;
 	unsigned long flags;
 	DEFINE_WAIT(wait);
@@ -211,7 +208,7 @@ static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
 		if (!synth_buffer_empty() || speakup_info.flushing)
 			break;
 		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
-		if (fp->f_flags & O_NONBLOCK) {
+		if (iocb->ki_flags & IOCB_NOWAIT) {
 			finish_wait(&speakup_event, &wait);
 			return -EAGAIN;
 		}
@@ -224,11 +221,14 @@ static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
 	}
 	finish_wait(&speakup_event, &wait);
 
-	cp = buf;
 	init = get_initstring();
 
 	/* Keep 3 bytes available for a 16bit UTF-8-encoded character */
-	while (chars_sent <= count - 3) {
+	while (iov_iter_count(to)) {
+		u_char s[3];
+		int l, n;
+		u16 ch;
+
 		if (speakup_info.flushing) {
 			speakup_info.flushing = 0;
 			ch = '\x18';
@@ -244,60 +244,47 @@ static ssize_t softsynthx_read(struct file *fp, char __user *buf, size_t count,
 		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 
 		if ((!unicode && ch < 0x100) || (unicode && ch < 0x80)) {
-			u_char c = ch;
-
-			if (copy_to_user(cp, &c, 1))
-				return -EFAULT;
-
-			chars_sent++;
-			cp++;
+			s[0] = ch;
+			l = 1;
 		} else if (unicode && ch < 0x800) {
-			u_char s[2] = {
-				0xc0 | (ch >> 6),
-				0x80 | (ch & 0x3f)
-			};
-
-			if (copy_to_user(cp, s, sizeof(s)))
-				return -EFAULT;
-
-			chars_sent += sizeof(s);
-			cp += sizeof(s);
+			s[0] = 0xc0 | (ch >> 6);
+			s[1] = 0x80 | (ch & 0x3f);
+			l = 2;
 		} else if (unicode) {
-			u_char s[3] = {
-				0xe0 | (ch >> 12),
-				0x80 | ((ch >> 6) & 0x3f),
-				0x80 | (ch & 0x3f)
-			};
-
-			if (copy_to_user(cp, s, sizeof(s)))
-				return -EFAULT;
-
-			chars_sent += sizeof(s);
-			cp += sizeof(s);
+			s[0] = 0xe0 | (ch >> 12);
+			s[1] = 0x80 | ((ch >> 6) & 0x3f);
+			s[2] = 0x80 | (ch & 0x3f);
+			l = 3;
 		}
-
+		n = copy_to_iter(s, l, to);
+		if (n != l) {
+			iov_iter_revert(to, n);
+			spin_lock_irqsave(&speakup_info.spinlock, flags);
+			break;
+		}
+		chars_sent += l;
 		spin_lock_irqsave(&speakup_info.spinlock, flags);
 	}
-	*pos += chars_sent;
+	iocb->ki_pos += chars_sent;
 	empty = synth_buffer_empty();
 	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
 	if (empty) {
 		speakup_start_ttys();
-		*pos = 0;
+		iocb->ki_pos = 0;
 	}
 	return chars_sent;
 }
 
-static ssize_t softsynth_read(struct file *fp, char __user *buf, size_t count,
+static ssize_t softsynth_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			      loff_t *pos)
 {
-	return softsynthx_read(fp, buf, count, pos, 0);
+	return softsynthx_read_iter(iocb, to, 0);
 }
 
-static ssize_t softsynthu_read(struct file *fp, char __user *buf, size_t count,
+static ssize_t softsynthu_read_iter(struct kiocb *iocb, struct iov_iter *to)
 			       loff_t *pos)
 {
-	return softsynthx_read(fp, buf, count, pos, 1);
+	return softsynthx_read_iter(iocb, to, 1);
 }
 
 static int last_index;
@@ -343,7 +330,7 @@ static unsigned char get_index(struct spk_synth *synth)
 static const struct file_operations softsynth_fops = {
 	.owner = THIS_MODULE,
 	.poll = softsynth_poll,
-	.read = softsynth_read,
+	.read_iter = softsynth_read_iter,
 	.write = softsynth_write,
 	.open = softsynth_open,
 	.release = softsynth_close,
@@ -352,7 +339,7 @@ static const struct file_operations softsynth_fops = {
 static const struct file_operations softsynthu_fops = {
 	.owner = THIS_MODULE,
 	.poll = softsynth_poll,
-	.read = softsynthu_read,
+	.read_iter = softsynthu_read_iter,
 	.write = softsynth_write,
 	.open = softsynth_open,
 	.release = softsynth_close,
