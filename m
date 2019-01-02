Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61598C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C3E72063F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 15:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfABPEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 10:04:31 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:49528 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728026AbfABPEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 10:04:30 -0500
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x02F48uL041874;
        Thu, 3 Jan 2019 00:04:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Thu, 03 Jan 2019 00:04:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x02F42bs041791
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 3 Jan 2019 00:04:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] tty/n_hdlc: fix sleep in !TASK_RUNNING state warning
To:     Paul Fulghum <paulkf@microgate.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org
References: <000000000000449587057e1e6f8b@google.com>
 <49b3b189-a51f-6a97-0e1f-bc3f2c305299@I-love.SAKURA.ne.jp>
 <FEBFE826-8D27-4A0B-86A5-BA559921CADC@microgate.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <cf9b7323-da1c-20cd-4d50-1080fbe52467@i-love.sakura.ne.jp>
Date:   Thu, 3 Jan 2019 00:04:02 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <FEBFE826-8D27-4A0B-86A5-BA559921CADC@microgate.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/01/01 12:11, Paul Fulghum wrote:
> NAK to this patch. It causes lost wakeups in both read and write paths.
> 
> The write path does not need changing.
> 
> The read path can be fixed by setting current to TASK_RUNNING at the top of the if (rbuf) block
> so the warning is not triggered by copy_to_user(). If this block runs the condition is satisfied
> and it breaks out of the polling loop where it is already being set to TASK_RUNNING and removed
> from the wait queue. This particular path just needs to account for the copy_to_user which occurs
> before breaking out.
> 
> I’ll make a patch to do this when I have the ability to test it in a day or two.
> 

OK. Then, any chance it is rewritten using wait_event_interruptible() in order to reduce lines?
( wait_event_interruptible() automatically calls might_sleep(), but is it acceptable for you? )

---
 drivers/tty/n_hdlc.c | 126 ++++++++++++---------------------------------------
 1 file changed, 30 insertions(+), 96 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 8223d02..2e4ccf9 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -562,8 +562,7 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 {
 	struct n_hdlc *n_hdlc = tty2n_hdlc(tty);
 	int ret = 0;
-	struct n_hdlc_buf *rbuf;
-	DECLARE_WAITQUEUE(wait, current);
+	struct n_hdlc_buf *rbuf = NULL;
 
 	if (debuglevel >= DEBUG_LEVEL_INFO)	
 		printk("%s(%d)n_hdlc_tty_read() called\n",__FILE__,__LINE__);
@@ -579,58 +578,26 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
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
+	     (ret = -EIO, test_bit(TTY_OTHER_CLOSED, &tty->flags)) ||
+	     (ret = 0, tty_hung_up_p(file)) ||
+	     (rbuf = n_hdlc_buf_get(&n_hdlc->rx_buf_list)) != NULL ||
+	     (ret = -EAGAIN, tty_io_nonblock(tty, file))))
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
-	
 }	/* end of n_hdlc_tty_read() */
 
 /**
@@ -645,21 +612,13 @@ static ssize_t n_hdlc_tty_read(struct tty_struct *tty, struct file *file,
 static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 			    const unsigned char *data, size_t count)
 {
-	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
+	struct n_hdlc *n_hdlc;
 	int error = 0;
-	DECLARE_WAITQUEUE(wait, current);
-	struct n_hdlc_buf *tbuf;
+	struct n_hdlc_buf *tbuf = NULL;
 
 	if (debuglevel >= DEBUG_LEVEL_INFO)	
 		printk("%s(%d)n_hdlc_tty_write() called count=%zd\n",
 			__FILE__,__LINE__,count);
-		
-	/* Verify pointers */
-	if (!n_hdlc)
-		return -EIO;
-
-	if (n_hdlc->magic != HDLC_MAGIC)
-		return -EIO;
 
 	/* verify frame size */
 	if (count > maxframe ) {
@@ -670,40 +629,14 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 				maxframe );
 		count = maxframe;
 	}
-	
-	add_wait_queue(&tty->write_wait, &wait);
 
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
-
-	if (!error) {		
+	if (wait_event_interruptible(tty->write_wait,
+	     (error = -EIO, n_hdlc = tty2n_hdlc(tty), /* Verify pointers */
+	      !n_hdlc || n_hdlc->magic != HDLC_MAGIC || tty != n_hdlc->tty) ||
+	     (tbuf = n_hdlc_buf_get(&n_hdlc->tx_free_buf_list)) != NULL ||
+	     (error = -EAGAIN, tty_io_nonblock(tty, file))))
+		return -EINTR;
+	if (tbuf) {
 		/* Retrieve the user's buffer */
 		memcpy(tbuf->buf, data, count);
 
@@ -711,8 +644,9 @@ static ssize_t n_hdlc_tty_write(struct tty_struct *tty, struct file *file,
 		tbuf->count = error = count;
 		n_hdlc_buf_put(&n_hdlc->tx_buf_list,tbuf);
 		n_hdlc_send_frames(n_hdlc,tty);
+	} else if (error == -EIO) {
+		printk("n_hdlc_tty_write: %p invalid!\n", n_hdlc);
 	}
-
 	return error;
 	
 }	/* end of n_hdlc_tty_write() */
-- 
1.8.3.1
