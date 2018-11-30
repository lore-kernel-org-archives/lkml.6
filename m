Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A54C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68032081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E68032081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeK3Nd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:33:56 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:34565 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbeK3Nd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 08:33:56 -0500
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wAU2Q3U5060394;
        Fri, 30 Nov 2018 11:26:03 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Fri, 30 Nov 2018 11:26:03 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wAU2Q2tP060389;
        Fri, 30 Nov 2018 11:26:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id wAU2Q2JG060388;
        Fri, 30 Nov 2018 11:26:02 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201811300226.wAU2Q2JG060388@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH] printk: don't unconditionally shortcut
 =?ISO-2022-JP?B?cHJpbnRfdGltZSgp?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Date:   Fri, 30 Nov 2018 11:26:02 +0900
References: <1543056613-4779-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp> <20181129141921.djeumz723fr7pasn@pathway.suse.cz>
In-Reply-To: <20181129141921.djeumz723fr7pasn@pathway.suse.cz>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek wrote:
> See syslog_print_all() and kmsg_dump_get_buffer(). They
> start with calling msg_print_text() many times to calculate
> how many messages fit into the given buffer. Then they
> blindly copy the messages into the buffer.
> 
> Now, the buffer might overflow if the size is calculated
> with printk_time disabled and the messages are copied with
> printk_time enabled.
> 

Indeed, SYSLOG_ACTION_READ_ALL case can write more bytes than userspace
has supplied, resulting in possible memory corruption in userpsace. And
obtaining a snapshot of printk_time under logbuf_lock won't help, for we
need to drop logbuf_lock before calling copy_to_user().

----------
@@ -1365,6 +1365,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	if (!text)
 		return -ENOMEM;
 
+	printk_time = false;
 	logbuf_lock_irq();
 	/*
 	 * Find first record that fits, including all following records,
@@ -1409,6 +1410,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 		seq++;
 
 		logbuf_unlock_irq();
+		printk_time = true;
 		if (copy_to_user(buf + len, text, textlen))
 			len = -EFAULT;
 		else
----------

----------
#include <sys/klog.h>
#define SYSLOG_ACTION_READ_ALL 3

int main(int argc, char *argv[])
{
        char buffer[4096];
        int i;
        for (i = 0; i < sizeof(buffer); i++)
                if (klogctl(SYSLOG_ACTION_READ_ALL, buffer, i) > i)
                        return 1;
        return 0;
}
----------

----------
syslog(SYSLOG_ACTION_READ_ALL, "", 0)   = 0
(...snipped...)
syslog(SYSLOG_ACTION_READ_ALL, "", 59)  = 0
syslog(SYSLOG_ACTION_READ_ALL, "<6>IPv6: ADDRCONF(NETDEV_CHANGE): ens32: link becomes ready\n", 60) = 60
(...snipped...)
syslog(SYSLOG_ACTION_READ_ALL, "<6>IPv6: ADDRCONF(NETDEV_CHANGE): ens32: link becomes ready\n", 114) = 60
syslog(SYSLOG_ACTION_READ_ALL, "<6>IPv6: ADDRCONF(NETDEV_UP): ens32: link is not ready\n<6>[   10.517132] IPv6: ADDRCONF(NETDEV_CHANGE): ens32: link becomes ready\n", 115) = 130
----------

> IMHO, passing it as parameter to msg_print_text(), print_prefix(),
> and print_time() looks acceptable.

Below is a patch for passing a snapshot of printk_time to msg_print_text(),
but we are still failing to close a race explained at bottom.

 kernel/printk/printk.c | 59 ++++++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 31 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1b2a029..3838a6b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1215,12 +1215,7 @@ static inline void boot_delay_msec(int level)
 
 static size_t print_time(u64 ts, char *buf)
 {
-	unsigned long rem_nsec;
-
-	if (!printk_time)
-		return 0;
-
-	rem_nsec = do_div(ts, 1000000000);
+	unsigned long rem_nsec = do_div(ts, 1000000000);
 
 	if (!buf)
 		return snprintf(NULL, 0, "[%5lu.000000] ", (unsigned long)ts);
@@ -1229,7 +1224,8 @@ static size_t print_time(u64 ts, char *buf)
 		       (unsigned long)ts, rem_nsec / 1000);
 }
 
-static size_t print_prefix(const struct printk_log *msg, bool syslog, char *buf)
+static size_t print_prefix(const struct printk_log *msg, bool syslog,
+			   bool time, char *buf)
 {
 	size_t len = 0;
 	unsigned int prefix = (msg->facility << 3) | msg->level;
@@ -1248,11 +1244,13 @@ static size_t print_prefix(const struct printk_log *msg, bool syslog, char *buf)
 		}
 	}
 
-	len += print_time(msg->ts_nsec, buf ? buf + len : NULL);
+	if (time)
+		len += print_time(msg->ts_nsec, buf ? buf + len : NULL);
 	return len;
 }
 
-static size_t msg_print_text(const struct printk_log *msg, bool syslog, char *buf, size_t size)
+static size_t msg_print_text(const struct printk_log *msg, bool syslog,
+			     bool time, char *buf, size_t size)
 {
 	const char *text = log_text(msg);
 	size_t text_size = msg->text_len;
@@ -1271,17 +1269,17 @@ static size_t msg_print_text(const struct printk_log *msg, bool syslog, char *bu
 		}
 
 		if (buf) {
-			if (print_prefix(msg, syslog, NULL) +
+			if (print_prefix(msg, syslog, time, NULL) +
 			    text_len + 1 >= size - len)
 				break;
 
-			len += print_prefix(msg, syslog, buf + len);
+			len += print_prefix(msg, syslog, time, buf + len);
 			memcpy(buf + len, text, text_len);
 			len += text_len;
 			buf[len++] = '\n';
 		} else {
 			/* SYSLOG_ACTION_* buffer size only calculation */
-			len += print_prefix(msg, syslog, NULL);
+			len += print_prefix(msg, syslog, time, NULL);
 			len += text_len;
 			len++;
 		}
@@ -1320,7 +1318,8 @@ static int syslog_print(char __user *buf, int size)
 
 		skip = syslog_partial;
 		msg = log_from_idx(syslog_idx);
-		n = msg_print_text(msg, true, text, LOG_LINE_MAX + PREFIX_MAX);
+		n = msg_print_text(msg, true, printk_time, text,
+				   LOG_LINE_MAX + PREFIX_MAX);
 		if (n - syslog_partial <= size) {
 			/* message fits into buffer, move forward */
 			syslog_idx = log_next(syslog_idx);
@@ -1360,11 +1359,13 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	u64 next_seq;
 	u64 seq;
 	u32 idx;
+	bool time;
 
 	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
+	time = printk_time;
 	logbuf_lock_irq();
 	/*
 	 * Find first record that fits, including all following records,
@@ -1375,7 +1376,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	while (seq < log_next_seq) {
 		struct printk_log *msg = log_from_idx(idx);
 
-		len += msg_print_text(msg, true, NULL, 0);
+		len += msg_print_text(msg, true, time, NULL, 0);
 		idx = log_next(idx);
 		seq++;
 	}
@@ -1386,7 +1387,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	while (len > size && seq < log_next_seq) {
 		struct printk_log *msg = log_from_idx(idx);
 
-		len -= msg_print_text(msg, true, NULL, 0);
+		len -= msg_print_text(msg, true, time, NULL, 0);
 		idx = log_next(idx);
 		seq++;
 	}
@@ -1397,14 +1398,9 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	len = 0;
 	while (len >= 0 && seq < next_seq) {
 		struct printk_log *msg = log_from_idx(idx);
-		int textlen;
+		int textlen = msg_print_text(msg, true, time, text,
+					     LOG_LINE_MAX + PREFIX_MAX);
 
-		textlen = msg_print_text(msg, true, text,
-					 LOG_LINE_MAX + PREFIX_MAX);
-		if (textlen < 0) {
-			len = textlen;
-			break;
-		}
 		idx = log_next(idx);
 		seq++;
 
@@ -1532,7 +1528,8 @@ int do_syslog(int type, char __user *buf, int len, int source)
 			while (seq < log_next_seq) {
 				struct printk_log *msg = log_from_idx(idx);
 
-				error += msg_print_text(msg, true, NULL, 0);
+				error += msg_print_text(msg, true, printk_time,
+							NULL, 0);
 				idx = log_next(idx);
 				seq++;
 			}
@@ -2028,8 +2025,8 @@ static void console_lock_spinning_enable(void) { }
 static int console_lock_spinning_disable_and_check(void) { return 0; }
 static void call_console_drivers(const char *ext_text, size_t ext_len,
 				 const char *text, size_t len) {}
-static size_t msg_print_text(const struct printk_log *msg,
-			     bool syslog, char *buf, size_t size) { return 0; }
+static size_t msg_print_text(const struct printk_log *msg, bool syslog,
+			     bool time, char *buf, size_t size) { return 0; }
 static bool suppress_message_printing(int level) { return false; }
 
 #endif /* CONFIG_PRINTK */
@@ -2387,8 +2384,7 @@ void console_unlock(void)
 
 		len += msg_print_text(msg,
 				console_msg_format & MSG_FORMAT_SYSLOG,
-				text + len,
-				sizeof(text) - len);
+				printk_time, text + len, sizeof(text) - len);
 		if (nr_ext_console_drivers) {
 			ext_len = msg_print_ext_header(ext_text,
 						sizeof(ext_text),
@@ -3112,7 +3108,7 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
 		goto out;
 
 	msg = log_from_idx(dumper->cur_idx);
-	l = msg_print_text(msg, syslog, line, size);
+	l = msg_print_text(msg, syslog, printk_time, line, size);
 
 	dumper->cur_idx = log_next(dumper->cur_idx);
 	dumper->cur_seq++;
@@ -3183,6 +3179,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	u32 next_idx;
 	size_t l = 0;
 	bool ret = false;
+	bool time = printk_time;
 
 	if (!dumper->active)
 		goto out;
@@ -3206,7 +3203,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	while (seq < dumper->next_seq) {
 		struct printk_log *msg = log_from_idx(idx);
 
-		l += msg_print_text(msg, true, NULL, 0);
+		l += msg_print_text(msg, true, time, NULL, 0);
 		idx = log_next(idx);
 		seq++;
 	}
@@ -3217,7 +3214,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	while (l > size && seq < dumper->next_seq) {
 		struct printk_log *msg = log_from_idx(idx);
 
-		l -= msg_print_text(msg, true, NULL, 0);
+		l -= msg_print_text(msg, true, time, NULL, 0);
 		idx = log_next(idx);
 		seq++;
 	}
@@ -3230,7 +3227,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	while (seq < dumper->next_seq) {
 		struct printk_log *msg = log_from_idx(idx);
 
-		l += msg_print_text(msg, syslog, buf + l, size - l);
+		l += msg_print_text(msg, syslog, time, buf + l, size - l);
 		idx = log_next(idx);
 		seq++;
 	}
-- 
1.8.3.1

The remaining race is that klogctl(SYSLOG_ACTION_SIZE_UNREAD) after klogctl(SYSLOG_ACTION_READ)
can return negative value upon success, for SYSLOG_ACTION_SIZE_UNREAD depends that printk_time
did not change (from true to false) after SYSLOG_ACTION_READ updated syslog_partial. To close
this race, we need to make sure that printk_time is evaluated only once for each record.
That is, evaluate printk_time upon e.g. log_store() rather than upon msg_print_text().

 kernel/printk/printk.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1b2a029..c692fbc 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -421,6 +421,8 @@ __packed __aligned(4)
 static u64 clear_seq;
 static u32 clear_idx;
 
+static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
+
 #define PREFIX_MAX		32
 #define LOG_LINE_MAX		(1024 - PREFIX_MAX)
 
@@ -620,7 +622,9 @@ static int log_store(int facility, int level,
 	msg->facility = facility;
 	msg->level = level & 7;
 	msg->flags = flags & 0x1f;
-	if (ts_nsec > 0)
+	if (!printk_time)
+		msg->ts_nsec = (u64) -1ULL;
+	else if (ts_nsec > 0)
 		msg->ts_nsec = ts_nsec;
 	else
 		msg->ts_nsec = local_clock();
@@ -1210,14 +1214,13 @@ static inline void boot_delay_msec(int level)
 }
 #endif
 
-static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
 module_param_named(time, printk_time, bool, S_IRUGO | S_IWUSR);
 
 static size_t print_time(u64 ts, char *buf)
 {
 	unsigned long rem_nsec;
 
-	if (!printk_time)
+	if (ts == (u64) -1ULL)
 		return 0;
 
 	rem_nsec = do_div(ts, 1000000000);
-- 
1.8.3.1
