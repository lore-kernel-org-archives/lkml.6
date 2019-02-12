Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F28CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBB22186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfBLOdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:33:03 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43705 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfBLOa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:30:29 -0500
Received: from [5.158.153.53] (helo=linux.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtZ4h-0005Af-QL; Tue, 12 Feb 2019 15:30:16 +0100
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
Subject: [RFC PATCH v1 08/25] printk: add ring buffer and kthread
Date:   Tue, 12 Feb 2019 15:29:46 +0100
Message-Id: <20190212143003.48446-9-john.ogness@linutronix.de>
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

The printk ring buffer provides an NMI-safe interface for writing
messages to a ring buffer. Using such a buffer for alleviates printk
callers from the current burdens of disabled preemption while calling
the console drivers (and possibly printing out many messages that
another task put into the log buffer).

Create a ring buffer to be used for storing messages to be
printed to the consoles.

Create a dedicated printk kthread to block on the ring buffer
and call the console drivers for the read messages.

NOTE: The printk_delay is relocated to _after_ the message is
      printed, where it makes more sense.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d3d170374ceb..08e079b95652 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -44,6 +44,8 @@
 #include <linux/irq_work.h>
 #include <linux/ctype.h>
 #include <linux/uio.h>
+#include <linux/kthread.h>
+#include <linux/printk_ringbuffer.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
@@ -397,7 +399,12 @@ DEFINE_RAW_SPINLOCK(logbuf_lock);
 		printk_safe_exit_irqrestore(flags);	\
 	} while (0)
 
+DECLARE_STATIC_PRINTKRB_CPULOCK(printk_cpulock);
+
 #ifdef CONFIG_PRINTK
+/* record buffer */
+DECLARE_STATIC_PRINTKRB(printk_rb, CONFIG_LOG_BUF_SHIFT, &printk_cpulock);
+
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
 static u64 syslog_seq;
@@ -744,6 +751,10 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 	return p - buf;
 }
 
+#define PRINTK_SPRINT_MAX (LOG_LINE_MAX + PREFIX_MAX)
+#define PRINTK_RECORD_MAX (sizeof(struct printk_log) + \
+				CONSOLE_EXT_LOG_MAX + PRINTK_SPRINT_MAX)
+
 /* /dev/kmsg - userspace message inject/listen interface */
 struct devkmsg_user {
 	u64 seq;
@@ -1566,6 +1577,34 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
 	return do_syslog(type, buf, len, SYSLOG_FROM_READER);
 }
 
+static void format_text(struct printk_log *msg, u64 seq,
+			char *ext_text, size_t *ext_len,
+			char *text, size_t *len, bool time)
+{
+	if (suppress_message_printing(msg->level)) {
+		/*
+		 * Skip record that has level above the console
+		 * loglevel and update each console's local seq.
+		 */
+		*len = 0;
+		*ext_len = 0;
+		return;
+	}
+
+	*len = msg_print_text(msg, console_msg_format & MSG_FORMAT_SYSLOG,
+			      time, text, PRINTK_SPRINT_MAX);
+	if (nr_ext_console_drivers) {
+		*ext_len = msg_print_ext_header(ext_text, CONSOLE_EXT_LOG_MAX,
+						msg, seq);
+		*ext_len += msg_print_ext_body(ext_text + *ext_len,
+					       CONSOLE_EXT_LOG_MAX - *ext_len,
+					       log_dict(msg), msg->dict_len,
+					       log_text(msg), msg->text_len);
+	} else {
+		*ext_len = 0;
+	}
+}
+
 /*
  * Special console_lock variants that help to reduce the risk of soft-lockups.
  * They allow to pass console_lock to another printk() call using a busy wait.
@@ -2899,6 +2938,72 @@ void wake_up_klogd(void)
 	preempt_enable();
 }
 
+static int printk_kthread_func(void *data)
+{
+	struct prb_iterator iter;
+	struct printk_log *msg;
+	size_t ext_len;
+	char *ext_text;
+	u64 master_seq;
+	size_t len;
+	char *text;
+	char *buf;
+	int ret;
+
+	ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
+	text = kmalloc(PRINTK_SPRINT_MAX, GFP_KERNEL);
+	buf = kmalloc(PRINTK_RECORD_MAX, GFP_KERNEL);
+	if (!ext_text || !text || !buf)
+		return -1;
+
+	prb_iter_init(&iter, &printk_rb, NULL);
+
+	/* the printk kthread never exits */
+	for (;;) {
+		ret = prb_iter_wait_next(&iter, buf,
+					 PRINTK_RECORD_MAX, &master_seq);
+		if (ret == -ERESTARTSYS) {
+			continue;
+		} else if (ret < 0) {
+			/* iterator invalid, start over */
+			prb_iter_init(&iter, &printk_rb, NULL);
+			continue;
+		}
+
+		msg = (struct printk_log *)buf;
+		format_text(msg, master_seq, ext_text, &ext_len, text,
+			    &len, printk_time);
+
+		console_lock();
+		if (len > 0 || ext_len > 0) {
+			call_console_drivers(ext_text, ext_len, text, len);
+			boot_delay_msec(msg->level);
+			printk_delay();
+		}
+		console_unlock();
+	}
+
+	kfree(ext_text);
+	kfree(text);
+	kfree(buf);
+
+	return 0;
+}
+
+static int __init init_printk_kthread(void)
+{
+	struct task_struct *thread;
+
+	thread = kthread_run(printk_kthread_func, NULL, "printk");
+	if (IS_ERR(thread)) {
+		pr_err("printk: unable to create printing thread\n");
+		return PTR_ERR(thread);
+	}
+
+	return 0;
+}
+late_initcall(init_printk_kthread);
+
 void defer_console_output(void)
 {
 	preempt_disable();
-- 
2.11.0

