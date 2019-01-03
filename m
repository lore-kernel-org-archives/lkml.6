Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3971C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE33720578
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfACLc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:32:56 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:54952 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfACLc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:32:56 -0500
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x03BWYMv026253;
        Thu, 3 Jan 2019 20:32:34 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Thu, 03 Jan 2019 20:32:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x03BWTTZ026228
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 3 Jan 2019 20:32:33 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tty/n_hdlc: fix sleep in !TASK_RUNNING state warning
To:     Jiri Slaby <jslaby@suse.cz>, Paul Fulghum <paulkf@microgate.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
References: <000000000000449587057e1e6f8b@google.com>
 <49b3b189-a51f-6a97-0e1f-bc3f2c305299@I-love.SAKURA.ne.jp>
 <FEBFE826-8D27-4A0B-86A5-BA559921CADC@microgate.com>
 <cf9b7323-da1c-20cd-4d50-1080fbe52467@i-love.sakura.ne.jp>
 <ba6de468-d36d-cd33-9a13-520102b676c6@suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <98eec651-d1ab-48e5-309b-7e748981cfdd@i-love.sakura.ne.jp>
Date:   Thu, 3 Jan 2019 20:32:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ba6de468-d36d-cd33-9a13-520102b676c6@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/03 18:09, Jiri Slaby wrote:
> On 02. 01. 19, 16:04, Tetsuo Handa wrote:
>> +	if (wait_event_interruptible(tty->read_wait,
>> +	     (ret = -EIO, test_bit(TTY_OTHER_CLOSED, &tty->flags)) ||
>> +	     (ret = 0, tty_hung_up_p(file)) ||
>> +	     (rbuf = n_hdlc_buf_get(&n_hdlc->rx_buf_list)) != NULL ||
>> +	     (ret = -EAGAIN, tty_io_nonblock(tty, file))))
>> +		return -EINTR;
> 
> Oh, that looks really ugly. Could you move all this to a function
> returning a bool and taking &ret and &rbuf as parameters?
> 

OK. Something like this?

From 725c55be437b6ce3b578a045cc7ddeeb2bbeb4b3 Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Thu, 3 Jan 2019 20:29:49 +0900
Subject: [PATCH] tty/n_hdlc: Use wait_event_interruptible() and same sanity
 checks.

We can use wait_event_interruptible() in order to make it easier to
understand. Also, since the reason of using different level/frequency of
sanity checks for read and write is unclear while nowadays we have rich
fuzzing/sanitizing tools, let's use same sanity checks for read and write.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/tty/n_hdlc.c | 154 ++++++++++++++++++++-------------------------------
 1 file changed, 61 insertions(+), 93 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 8223d02..c497ef1 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -548,6 +548,27 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 
 }	/* end of n_hdlc_tty_receive() */
 
+static bool __n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
+			      struct n_hdlc *n_hdlc, int *ret,
+			      struct n_hdlc_buf **rbuf)
+{
+	if (test_bit(TTY_OTHER_CLOSED, &tty->flags)) {
+		*ret = -EIO;
+		return true;
+	}
+	if (tty_hung_up_p(file))
+		return true;
+	*rbuf = n_hdlc_buf_get(&n_hdlc->rx_buf_list);
+	if (*rbuf)
+		return true;
+	/* no data */
+	if (tty_io_nonblock(tty, file)) {
+		*ret = -EAGAIN;
+		return true;
+	}
+	return false;
+}
+
 /**
  * n_hdlc_tty_read - Called to retrieve one frame of data (if available)
  * @tty - pointer to tty instance data
@@ -562,14 +583,13 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 {
 	struct n_hdlc *n_hdlc = tty2n_hdlc(tty);
 	int ret = 0;
-	struct n_hdlc_buf *rbuf;
-	DECLARE_WAITQUEUE(wait, current);
+	struct n_hdlc_buf *rbuf = NULL;
 
 	if (debuglevel >= DEBUG_LEVEL_INFO)	
 		printk("%s(%d)n_hdlc_tty_read() called\n",__FILE__,__LINE__);
 		
 	/* Validate the pointers */
-	if (!n_hdlc)
+	if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC)
 		return -EIO;
 
 	/* verify user access to buffer */
@@ -579,60 +599,41 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 		return -EFAULT;
 	}
 
-	add_wait_queue(&tty->read_wait, &wait);
-
-	for (;;) {
-		if (test_bit(TTY_OTHER_CLOSED, &tty->flags)) {
-			ret = -EIO;
-			break;
-		}
-		if (tty_hung_up_p(file))
-			break;
-
-		set_current_state(TASK_INTERRUPTIBLE);
-
-		rbuf = n_hdlc_buf_get(&n_hdlc->rx_buf_list);
-		if (rbuf) {
-			if (rbuf->count > nr) {
-				/* too large for caller's buffer */
-				ret = -EOVERFLOW;
-			} else {
-				__set_current_state(TASK_RUNNING);
-				if (copy_to_user(buf, rbuf->buf, rbuf->count))
-					ret = -EFAULT;
-				else
-					ret = rbuf->count;
-			}
-
-			if (n_hdlc->rx_free_buf_list.count >
-			    DEFAULT_RX_BUF_COUNT)
-				kfree(rbuf);
-			else
-				n_hdlc_buf_put(&n_hdlc->rx_free_buf_list, rbuf);
-			break;
-		}
-			
-		/* no data */
-		if (tty_io_nonblock(tty, file)) {
-			ret = -EAGAIN;
-			break;
-		}
-
-		schedule();
-
-		if (signal_pending(current)) {
-			ret = -EINTR;
-			break;
-		}
+	if (wait_event_interruptible(tty->read_wait,
+				     __n_hdlc_tty_read(tty, file, n_hdlc, &ret,
+						       &rbuf)))
+		return -EINTR;
+	if (rbuf) {
+		if (rbuf->count > nr)
+			/* too large for caller's buffer */
+			ret = -EOVERFLOW;
+		else if (copy_to_user(buf, rbuf->buf, rbuf->count))
+			ret = -EFAULT;
+		else
+			ret = rbuf->count;
+		if (n_hdlc->rx_free_buf_list.count > DEFAULT_RX_BUF_COUNT)
+			kfree(rbuf);
+		else
+			n_hdlc_buf_put(&n_hdlc->rx_free_buf_list, rbuf);
 	}
-
-	remove_wait_queue(&tty->read_wait, &wait);
-	__set_current_state(TASK_RUNNING);
-
 	return ret;
 	
 }	/* end of n_hdlc_tty_read() */
 
+static bool __n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
+			       struct n_hdlc *n_hdlc, int *error,
+			       struct n_hdlc_buf **tbuf)
+{
+	*tbuf = n_hdlc_buf_get(&n_hdlc->tx_free_buf_list);
+	if (*tbuf)
+		return true;
+	if (tty_io_nonblock(tty, file)) {
+		*error = -EAGAIN;
+		return true;
+	}
+	return false;
+}
+
 /**
  * n_hdlc_tty_write - write a single frame of data to device
  * @tty	- pointer to associated tty device instance data
@@ -645,20 +646,16 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 			    const unsigned char *data, size_t count)
 {
-	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
+	struct n_hdlc *n_hdlc = tty2n_hdlc(tty);
 	int error = 0;
-	DECLARE_WAITQUEUE(wait, current);
 	struct n_hdlc_buf *tbuf;
 
 	if (debuglevel >= DEBUG_LEVEL_INFO)	
 		printk("%s(%d)n_hdlc_tty_write() called count=%zd\n",
 			__FILE__,__LINE__,count);
-		
-	/* Verify pointers */
-	if (!n_hdlc)
-		return -EIO;
 
-	if (n_hdlc->magic != HDLC_MAGIC)
+	/* Validate the pointers */
+	if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC)
 		return -EIO;
 
 	/* verify frame size */
@@ -670,40 +667,12 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 				maxframe );
 		count = maxframe;
 	}
-	
-	add_wait_queue(&tty->write_wait, &wait);
-
-	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
-	
-		tbuf = n_hdlc_buf_get(&n_hdlc->tx_free_buf_list);
-		if (tbuf)
-			break;
-
-		if (tty_io_nonblock(tty, file)) {
-			error = -EAGAIN;
-			break;
-		}
-		schedule();
-			
-		n_hdlc = tty2n_hdlc (tty);
-		if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC || 
-		    tty != n_hdlc->tty) {
-			printk("n_hdlc_tty_write: %p invalid after wait!\n", n_hdlc);
-			error = -EIO;
-			break;
-		}
-			
-		if (signal_pending(current)) {
-			error = -EINTR;
-			break;
-		}
-	}
-
-	__set_current_state(TASK_RUNNING);
-	remove_wait_queue(&tty->write_wait, &wait);
 
-	if (!error) {		
+	if (wait_event_interruptible(tty->write_wait,
+				     __n_hdlc_tty_write(tty, file, n_hdlc,
+							&error, &tbuf)))
+		return -EINTR;
+	if (tbuf) {
 		/* Retrieve the user's buffer */
 		memcpy(tbuf->buf, data, count);
 
@@ -712,7 +681,6 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 		n_hdlc_buf_put(&n_hdlc->tx_buf_list,tbuf);
 		n_hdlc_send_frames(n_hdlc,tty);
 	}
-
 	return error;
 	
 }	/* end of n_hdlc_tty_write() */
-- 
1.8.3.1
