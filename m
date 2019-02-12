Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEB7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97F7214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbfBLOa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:30:58 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43852 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfBLOa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:30:56 -0500
Received: from [5.158.153.53] (helo=linux.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtZ4r-0005Af-F2; Tue, 12 Feb 2019 15:30:25 +0100
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
Subject: [RFC PATCH v1 19/25] printk: introduce emergency messages
Date:   Tue, 12 Feb 2019 15:29:57 +0100
Message-Id: <20190212143003.48446-20-john.ogness@linutronix.de>
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

Console messages are generally either critical or non-critical.
Critical messages are messages such as crashes or sysrq output.
Critical messages should never be lost because generally they provide
important debugging information.

Since all console messages are output via a fully preemptible printk
kernel thread, it is possible that messages are not output because
that thread cannot be scheduled (BUG in scheduler, run-away RT task,
etc).

To allow critical messages to be output independent of the
schedulability of the printk task, introduce an emergency mechanism
that _immediately_ outputs the message to the consoles. To avoid
possible unbounded latency issues, the emergency mechanism only
outputs the printk line provided by the caller and ignores any
pending messages in the log buffer.

Critical messages are identified as messages (by default) with log
level LOGLEVEL_WARNING or more critical. This is configurable via the
kernel option CONSOLE_LOGLEVEL_EMERGENCY.

Any messages output as emergency messages are skipped by the printk
thread on those consoles that output the emergency message.

In order for a console driver to support emergency messages, the
write_atomic function must be implemented by the driver. If not
implemented, the emergency messages are handled like all other
messages and are printed by the printk thread.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 include/linux/printk.h |   2 +
 kernel/printk/printk.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++---
 lib/Kconfig.debug      |  17 ++++++++
 3 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index a79a736b54b6..58bd06d88ea3 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -59,6 +59,7 @@ static inline const char *printk_skip_headers(const char *buffer)
  */
 #define CONSOLE_LOGLEVEL_DEFAULT CONFIG_CONSOLE_LOGLEVEL_DEFAULT
 #define CONSOLE_LOGLEVEL_QUIET	 CONFIG_CONSOLE_LOGLEVEL_QUIET
+#define CONSOLE_LOGLEVEL_EMERGENCY CONFIG_CONSOLE_LOGLEVEL_EMERGENCY
 
 extern int console_printk[];
 
@@ -66,6 +67,7 @@ extern int console_printk[];
 #define default_message_loglevel (console_printk[1])
 #define minimum_console_loglevel (console_printk[2])
 #define default_console_loglevel (console_printk[3])
+#define emergency_console_loglevel (console_printk[4])
 
 static inline void console_silent(void)
 {
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0ff7c3942464..eebe6f4fdbba 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -45,6 +45,7 @@
 #include <linux/ctype.h>
 #include <linux/uio.h>
 #include <linux/kthread.h>
+#include <linux/clocksource.h>
 #include <linux/printk_ringbuffer.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
@@ -61,11 +62,12 @@
 #include "braille.h"
 #include "internal.h"
 
-int console_printk[4] = {
+int console_printk[5] = {
 	CONSOLE_LOGLEVEL_DEFAULT,	/* console_loglevel */
 	MESSAGE_LOGLEVEL_DEFAULT,	/* default_message_loglevel */
 	CONSOLE_LOGLEVEL_MIN,		/* minimum_console_loglevel */
 	CONSOLE_LOGLEVEL_DEFAULT,	/* default_console_loglevel */
+	CONSOLE_LOGLEVEL_EMERGENCY,	/* emergency_console_loglevel */
 };
 
 atomic_t ignore_console_lock_warning __read_mostly = ATOMIC_INIT(0);
@@ -474,6 +476,9 @@ static u32 log_next(u32 idx)
 	return idx + msg->len;
 }
 
+static void printk_emergency(char *buffer, int level, u64 ts_nsec, u16 cpu,
+			     char *text, u16 text_len);
+
 /* insert record into the buffer, discard old ones, update heads */
 static int log_store(int facility, int level,
 		     enum log_flags flags, u64 ts_nsec, u16 cpu,
@@ -1587,7 +1592,7 @@ static void printk_write_history(struct console *con, u64 master_seq)
  * The console_lock must be held.
  */
 static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
-				 const char *text, size_t len)
+				 const char *text, size_t len, int level)
 {
 	struct console *con;
 
@@ -1607,6 +1612,18 @@ static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
 			con->wrote_history = 1;
 			con->printk_seq = seq - 1;
 		}
+		if (con->write_atomic && level < emergency_console_loglevel) {
+			/* skip emergency messages, already printed */
+			if (con->printk_seq < seq)
+				con->printk_seq = seq;
+			continue;
+		}
+		if (con->flags & CON_BOOT) {
+			/* skip emergency messages, already printed */
+			if (con->printk_seq < seq)
+				con->printk_seq = seq;
+			continue;
+		}
 		if (!con->write)
 			continue;
 		if (!cpu_online(raw_smp_processor_id()) &&
@@ -1718,8 +1735,12 @@ asmlinkage int vprintk_emit(int facility, int level,
 
 	cpu = raw_smp_processor_id();
 
-	text = rbuf;
-	text_len = vscnprintf(text, PRINTK_SPRINT_MAX, fmt, args);
+	/*
+	 * If this turns out to be an emergency message, there
+	 * may need to be a prefix added. Leave room for it.
+	 */
+	text = rbuf + PREFIX_MAX;
+	text_len = vscnprintf(text, PRINTK_SPRINT_MAX - PREFIX_MAX, fmt, args);
 
 	/* strip and flag a trailing newline */
 	if (text_len && text[text_len-1] == '\n') {
@@ -1755,6 +1776,14 @@ asmlinkage int vprintk_emit(int facility, int level,
 	if (dict)
 		lflags |= LOG_PREFIX|LOG_NEWLINE;
 
+	/*
+	 * NOTE:
+	 * - rbuf points to beginning of allocated buffer
+	 * - text points to beginning of text
+	 * - there is room before text for prefix
+	 */
+	printk_emergency(rbuf, level, ts_nsec, cpu, text, text_len);
+
 	printed_len = log_store(facility, level, lflags, ts_nsec, cpu,
 				dict, dictlen, text, text_len);
 
@@ -1847,7 +1876,7 @@ static ssize_t msg_print_ext_body(char *buf, size_t size,
 				  char *dict, size_t dict_len,
 				  char *text, size_t text_len) { return 0; }
 static void call_console_drivers(u64 seq, const char *ext_text, size_t ext_len,
-				 const char *text, size_t len) {}
+				 const char *text, size_t len, int level) {}
 static size_t msg_print_text(const struct printk_log *msg, bool syslog,
 			     bool time, char *buf, size_t size) { return 0; }
 static bool suppress_message_printing(int level) { return false; }
@@ -2579,7 +2608,7 @@ static int printk_kthread_func(void *data)
 
 		console_lock();
 		call_console_drivers(master_seq, ext_text,
-				     ext_len, text, len);
+				     ext_len, text, len, msg->level);
 		if (len > 0 || ext_len > 0)
 			printk_delay(msg->level);
 		console_unlock();
@@ -2983,6 +3012,76 @@ void kmsg_dump_rewind(struct kmsg_dumper *dumper)
 	logbuf_unlock_irqrestore(flags);
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
+
+static bool console_can_emergency(int level)
+{
+	struct console *con;
+
+	for_each_console(con) {
+		if (!(con->flags & CON_ENABLED))
+			continue;
+		if (con->write_atomic && level < emergency_console_loglevel)
+			return true;
+		if (con->write && (con->flags & CON_BOOT))
+			return true;
+	}
+	return false;
+}
+
+static void call_emergency_console_drivers(int level, const char *text,
+					   size_t text_len)
+{
+	struct console *con;
+
+	for_each_console(con) {
+		if (!(con->flags & CON_ENABLED))
+			continue;
+		if (con->write_atomic && level < emergency_console_loglevel) {
+			con->write_atomic(con, text, text_len);
+			continue;
+		}
+		if (con->write && (con->flags & CON_BOOT)) {
+			con->write(con, text, text_len);
+			continue;
+		}
+	}
+}
+
+static void printk_emergency(char *buffer, int level, u64 ts_nsec, u16 cpu,
+			     char *text, u16 text_len)
+{
+	struct printk_log msg;
+	size_t prefix_len;
+
+	if (!console_can_emergency(level))
+		return;
+
+	msg.level = level;
+	msg.ts_nsec = ts_nsec;
+	msg.cpu = cpu;
+	msg.facility = 0;
+
+	/* "text" must have PREFIX_MAX preceding bytes available */
+
+	prefix_len = print_prefix(&msg,
+				  console_msg_format & MSG_FORMAT_SYSLOG,
+				  printk_time, buffer);
+	/* move the prefix forward to the beginning of the message text */
+	text -= prefix_len;
+	memmove(text, buffer, prefix_len);
+	text_len += prefix_len;
+
+	text[text_len++] = '\n';
+
+	call_emergency_console_drivers(level, text, text_len);
+
+	touch_softlockup_watchdog_sync();
+	clocksource_touch_watchdog();
+	rcu_cpu_stall_reset();
+	touch_nmi_watchdog();
+
+	printk_delay(level);
+}
 #endif
 
 void console_atomic_lock(unsigned int *flags)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d4df5b24d75e..38d2fe5df425 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -43,6 +43,23 @@ config CONSOLE_LOGLEVEL_QUIET
 	  will be used as the loglevel. IOW passing "quiet" will be the
 	  equivalent of passing "loglevel=<CONSOLE_LOGLEVEL_QUIET>"
 
+config CONSOLE_LOGLEVEL_EMERGENCY
+	int "Emergency console loglevel (1-15)"
+	range 1 15
+	default "5"
+	help
+	  The loglevel to determine if a console message is an emergency
+	  message.
+
+	  If supported by the console driver, emergency messages will be
+	  flushed to the console immediately. This can cause significant system
+	  latencies so the value should be set such that only significant
+	  messages are classified as emergency messages.
+
+	  Setting a default here is equivalent to passing in
+	  emergency_loglevel=<x> in the kernel bootargs. emergency_loglevel=<x>
+	  continues to override whatever value is specified here as well.
+
 config MESSAGE_LOGLEVEL_DEFAULT
 	int "Default message log level (1-7)"
 	range 1 7
-- 
2.11.0

