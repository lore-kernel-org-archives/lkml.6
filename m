Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436DEC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0956F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfBLObg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:31:36 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43825 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbfBLOam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:30:42 -0500
Received: from [5.158.153.53] (helo=linux.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtZ4v-0005Af-7c; Tue, 12 Feb 2019 15:30:29 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC PATCH v1 23/25] printk: implement syslog
Date:   Tue, 12 Feb 2019 15:30:01 +0100
Message-Id: <20190212143003.48446-24-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190212143003.48446-1-john.ogness@linutronix.de>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since printk messages are now logged to a new ring buffer, update
the syslog functions to pull the messages from there.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 340 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 235 insertions(+), 105 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ed1ec8c23e97..241d142a2755 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -387,10 +387,12 @@ DECLARE_STATIC_PRINTKRB_CPULOCK(printk_cpulock);
 /* record buffer */
 DECLARE_STATIC_PRINTKRB(printk_rb, CONFIG_LOG_BUF_SHIFT, &printk_cpulock);
 
+static DEFINE_MUTEX(syslog_lock);
+DECLARE_STATIC_PRINTKRB_ITER(syslog_iter, &printk_rb);
+
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
 static u64 syslog_seq;
-static u32 syslog_idx;
 static size_t syslog_partial;
 static bool syslog_time;
 
@@ -1249,30 +1251,42 @@ static size_t msg_print_text(const struct printk_log *msg, bool syslog,
 	return len;
 }
 
-static int syslog_print(char __user *buf, int size)
+static int syslog_print(char __user *buf, int size, char *text,
+			char *msgbuf, int *locked)
 {
-	char *text;
+	struct prb_iterator iter;
 	struct printk_log *msg;
 	int len = 0;
-
-	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
-	if (!text)
-		return -ENOMEM;
+	u64 seq;
+	int ret;
 
 	while (size > 0) {
 		size_t n;
 		size_t skip;
 
-		logbuf_lock_irq();
-		if (syslog_seq < log_first_seq) {
-			/* messages are gone, move to first one */
-			syslog_seq = log_first_seq;
-			syslog_idx = log_first_idx;
-			syslog_partial = 0;
+		for (;;) {
+			prb_iter_copy(&iter, &syslog_iter);
+			ret = prb_iter_next(&iter, msgbuf,
+					    PRINTK_RECORD_MAX, &seq);
+			if (ret < 0) {
+				/* messages are gone, move to first one */
+				prb_iter_init(&syslog_iter, &printk_rb,
+					      &syslog_seq);
+				syslog_partial = 0;
+				continue;
+			}
+			break;
 		}
-		if (syslog_seq == log_next_seq) {
-			logbuf_unlock_irq();
+		if (ret == 0)
 			break;
+
+		/*
+		 * If messages have been missed, the partial tracker
+		 * is no longer valid and must be reset.
+		 */
+		if (syslog_seq > 0 && seq - 1 != syslog_seq) {
+			syslog_seq = seq - 1;
+			syslog_partial = 0;
 		}
 
 		/*
@@ -1282,131 +1296,212 @@ static int syslog_print(char __user *buf, int size)
 		if (!syslog_partial)
 			syslog_time = printk_time;
 
+		msg = (struct printk_log *)msgbuf;
+
 		skip = syslog_partial;
-		msg = log_from_idx(syslog_idx);
 		n = msg_print_text(msg, true, syslog_time, text,
-				   LOG_LINE_MAX + PREFIX_MAX);
+				   PRINTK_SPRINT_MAX);
 		if (n - syslog_partial <= size) {
 			/* message fits into buffer, move forward */
-			syslog_idx = log_next(syslog_idx);
-			syslog_seq++;
+			prb_iter_next(&syslog_iter, NULL, 0, &syslog_seq);
 			n -= syslog_partial;
 			syslog_partial = 0;
-		} else if (!len){
+		} else if (!len) {
 			/* partial read(), remember position */
 			n = size;
 			syslog_partial += n;
 		} else
 			n = 0;
-		logbuf_unlock_irq();
 
 		if (!n)
 			break;
 
+		mutex_unlock(&syslog_lock);
 		if (copy_to_user(buf, text + skip, n)) {
 			if (!len)
 				len = -EFAULT;
+			*locked = 0;
 			break;
 		}
+		ret = mutex_lock_interruptible(&syslog_lock);
 
 		len += n;
 		size -= n;
 		buf += n;
+
+		if (ret) {
+			if (!len)
+				len = ret;
+			*locked = 0;
+			break;
+		}
 	}
 
-	kfree(text);
 	return len;
 }
 
-static int syslog_print_all(char __user *buf, int size, bool clear)
+static int count_remaining(struct prb_iterator *iter, u64 until_seq,
+			   char *msgbuf, int size, bool records, bool time)
 {
-	char *text;
+	struct prb_iterator local_iter;
+	struct printk_log *msg;
 	int len = 0;
-	u64 next_seq;
 	u64 seq;
-	u32 idx;
+	int ret;
+
+	prb_iter_copy(&local_iter, iter);
+	for (;;) {
+		ret = prb_iter_next(&local_iter, msgbuf, size, &seq);
+		if (ret == 0) {
+			break;
+		} else if (ret < 0) {
+			/* the iter is invalid, restart from head */
+			prb_iter_init(&local_iter, &printk_rb, NULL);
+			len = 0;
+			continue;
+		}
+
+		if (until_seq && seq >= until_seq)
+			break;
+
+		if (records) {
+			len++;
+		} else {
+			msg = (struct printk_log *)msgbuf;
+			len += msg_print_text(msg, true, time, NULL, 0);
+		}
+	}
+
+	return len;
+}
+
+static void syslog_clear(void)
+{
+	struct prb_iterator iter;
+	int ret;
+
+	prb_iter_init(&iter, &printk_rb, &clear_seq);
+	for (;;) {
+		ret = prb_iter_next(&iter, NULL, 0, &clear_seq);
+		if (ret == 0)
+			break;
+		else if (ret < 0)
+			prb_iter_init(&iter, &printk_rb, &clear_seq);
+	}
+}
+
+static int syslog_print_all(char __user *buf, int size, bool clear)
+{
+	struct prb_iterator iter;
+	struct printk_log *msg;
+	char *msgbuf = NULL;
+	char *text = NULL;
+	int textlen;
+	u64 seq = 0;
+	int len = 0;
 	bool time;
+	int ret;
 
-	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
+	text = kmalloc(PRINTK_SPRINT_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
+	msgbuf = kmalloc(PRINTK_RECORD_MAX, GFP_KERNEL);
+	if (!msgbuf) {
+		kfree(text);
+		return -ENOMEM;
+	}
 
 	time = printk_time;
-	logbuf_lock_irq();
+
 	/*
-	 * Find first record that fits, including all following records,
-	 * into the user-provided buffer for this dump.
+	 * Setup iter to last event before clear. Clear may
+	 * be lost, but keep going with a best effort.
 	 */
-	seq = clear_seq;
-	idx = clear_idx;
-	while (seq < log_next_seq) {
-		struct printk_log *msg = log_from_idx(idx);
+	prb_iter_init(&iter, &printk_rb, NULL);
+	prb_iter_seek(&iter, clear_seq);
 
-		len += msg_print_text(msg, true, time, NULL, 0);
-		idx = log_next(idx);
-		seq++;
-	}
+	/* count the total bytes after clear */
+	len = count_remaining(&iter, 0, msgbuf, PRINTK_RECORD_MAX,
+			      false, time);
 
-	/* move first record forward until length fits into the buffer */
-	seq = clear_seq;
-	idx = clear_idx;
-	while (len > size && seq < log_next_seq) {
-		struct printk_log *msg = log_from_idx(idx);
+	/* move iter forward until length fits into the buffer */
+	while (len > size) {
+		ret = prb_iter_next(&iter, msgbuf,
+				    PRINTK_RECORD_MAX, &seq);
+		if (ret == 0) {
+			break;
+		} else if (ret < 0) {
+			/*
+			 * The iter is now invalid so clear will
+			 * also be invalid. Restart from the head.
+			 */
+			prb_iter_init(&iter, &printk_rb, NULL);
+			len = count_remaining(&iter, 0, msgbuf,
+					      PRINTK_RECORD_MAX, false, time);
+			continue;
+		}
 
+		msg = (struct printk_log *)msgbuf;
 		len -= msg_print_text(msg, true, time, NULL, 0);
-		idx = log_next(idx);
-		seq++;
-	}
 
-	/* last message fitting into this dump */
-	next_seq = log_next_seq;
+		if (clear)
+			clear_seq = seq;
+	}
 
+	/* copy messages to buffer */
 	len = 0;
-	while (len >= 0 && seq < next_seq) {
-		struct printk_log *msg = log_from_idx(idx);
-		int textlen = msg_print_text(msg, true, time, text,
-					     LOG_LINE_MAX + PREFIX_MAX);
+	while (len >= 0 && len < size) {
+		if (clear)
+			clear_seq = seq;
 
-		idx = log_next(idx);
-		seq++;
+		ret = prb_iter_next(&iter, msgbuf,
+				    PRINTK_RECORD_MAX, &seq);
+		if (ret == 0) {
+			break;
+		} else if (ret < 0) {
+			/*
+			 * The iter is now invalid. Make a best
+			 * effort to grab the rest of the log
+			 * from the new head.
+			 */
+			prb_iter_init(&iter, &printk_rb, NULL);
+			continue;
+		}
+
+		msg = (struct printk_log *)msgbuf;
+		textlen = msg_print_text(msg, true, time, text,
+					 PRINTK_SPRINT_MAX);
+		if (textlen < 0) {
+			len = textlen;
+			break;
+		}
 
-		logbuf_unlock_irq();
 		if (copy_to_user(buf + len, text, textlen))
 			len = -EFAULT;
 		else
 			len += textlen;
-		logbuf_lock_irq();
-
-		if (seq < log_first_seq) {
-			/* messages are gone, move to next one */
-			seq = log_first_seq;
-			idx = log_first_idx;
-		}
 	}
 
-	if (clear) {
-		clear_seq = log_next_seq;
-		clear_idx = log_next_idx;
-	}
-	logbuf_unlock_irq();
+	if (clear && !seq)
+		syslog_clear();
 
-	kfree(text);
+	if (text)
+		kfree(text);
+	if (msgbuf)
+		kfree(msgbuf);
 	return len;
 }
 
-static void syslog_clear(void)
-{
-	logbuf_lock_irq();
-	clear_seq = log_next_seq;
-	clear_idx = log_next_idx;
-	logbuf_unlock_irq();
-}
-
 int do_syslog(int type, char __user *buf, int len, int source)
 {
 	bool clear = false;
 	static int saved_console_loglevel = LOGLEVEL_DEFAULT;
+	struct prb_iterator iter;
+	char *msgbuf = NULL;
+	char *text = NULL;
+	int locked;
 	int error;
+	int ret;
 
 	error = check_syslog_permissions(type, source);
 	if (error)
@@ -1424,11 +1519,49 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			return 0;
 		if (!access_ok(buf, len))
 			return -EFAULT;
-		error = wait_event_interruptible(log_wait,
-						 syslog_seq != log_next_seq);
+
+		text = kmalloc(PRINTK_SPRINT_MAX, GFP_KERNEL);
+		msgbuf = kmalloc(PRINTK_RECORD_MAX, GFP_KERNEL);
+		if (!text || !msgbuf) {
+			error = -ENOMEM;
+			goto out;
+		}
+
+		error = mutex_lock_interruptible(&syslog_lock);
 		if (error)
-			return error;
-		error = syslog_print(buf, len);
+			goto out;
+
+		/*
+		 * Wait until a first message is available. Use a copy
+		 * because no iteration should occur for syslog now.
+		 */
+		for (;;) {
+			prb_iter_copy(&iter, &syslog_iter);
+
+			mutex_unlock(&syslog_lock);
+			ret = prb_iter_wait_next(&iter, NULL, 0, NULL);
+			if (ret == -ERESTARTSYS) {
+				error = ret;
+				goto out;
+			}
+			error = mutex_lock_interruptible(&syslog_lock);
+			if (error)
+				goto out;
+
+			if (ret == -EINVAL) {
+				prb_iter_init(&syslog_iter, &printk_rb,
+					      &syslog_seq);
+				syslog_partial = 0;
+				continue;
+			}
+			break;
+		}
+
+		/* print as much as will fit in the user buffer */
+		locked = 1;
+		error = syslog_print(buf, len, text, msgbuf, &locked);
+		if (locked)
+			mutex_unlock(&syslog_lock);
 		break;
 	/* Read/clear last kernel messages */
 	case SYSLOG_ACTION_READ_CLEAR:
@@ -1473,47 +1606,45 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		break;
 	/* Number of chars in the log buffer */
 	case SYSLOG_ACTION_SIZE_UNREAD:
-		logbuf_lock_irq();
-		if (syslog_seq < log_first_seq) {
-			/* messages are gone, move to first one */
-			syslog_seq = log_first_seq;
-			syslog_idx = log_first_idx;
-			syslog_partial = 0;
-		}
+		msgbuf = kmalloc(PRINTK_RECORD_MAX, GFP_KERNEL);
+		if (!msgbuf)
+			return -ENOMEM;
+
+		error = mutex_lock_interruptible(&syslog_lock);
+		if (error)
+			goto out;
+
 		if (source == SYSLOG_FROM_PROC) {
 			/*
 			 * Short-cut for poll(/"proc/kmsg") which simply checks
 			 * for pending data, not the size; return the count of
 			 * records, not the length.
 			 */
-			error = log_next_seq - syslog_seq;
+			error = count_remaining(&syslog_iter, 0, msgbuf,
+						PRINTK_RECORD_MAX, true,
+						printk_time);
 		} else {
-			u64 seq = syslog_seq;
-			u32 idx = syslog_idx;
-			bool time = syslog_partial ? syslog_time : printk_time;
-
-			while (seq < log_next_seq) {
-				struct printk_log *msg = log_from_idx(idx);
-
-				error += msg_print_text(msg, true, time, NULL,
-							0);
-				time = printk_time;
-				idx = log_next(idx);
-				seq++;
-			}
+			error = count_remaining(&syslog_iter, 0, msgbuf,
+						PRINTK_RECORD_MAX, false,
+						printk_time);
 			error -= syslog_partial;
 		}
-		logbuf_unlock_irq();
+
+		mutex_unlock(&syslog_lock);
 		break;
 	/* Size of the log buffer */
 	case SYSLOG_ACTION_SIZE_BUFFER:
-		error = log_buf_len;
+		error = prb_buffer_size(&printk_rb);
 		break;
 	default:
 		error = -EINVAL;
 		break;
 	}
-
+out:
+	if (msgbuf)
+		kfree(msgbuf);
+	if (text)
+		kfree(text);
 	return error;
 }
 
@@ -1932,7 +2063,6 @@ EXPORT_SYMBOL(printk);
 #define printk_time		false
 
 static u64 syslog_seq;
-static u32 syslog_idx;
 static u64 log_first_seq;
 static u32 log_first_idx;
 static u64 log_next_seq;
-- 
2.11.0

