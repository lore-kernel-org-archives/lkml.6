Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8744BC04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1626A20834
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 11:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1626A20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbeLAWm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 17:42:59 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:32376 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbeLAWm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 17:42:59 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wB1BUOx6006520;
        Sat, 1 Dec 2018 20:30:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Sat, 01 Dec 2018 20:30:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wB1BUI12006483
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 1 Dec 2018 20:30:24 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: don't unconditionally shortcut print_time()
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
References: <1543056613-4779-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181129141921.djeumz723fr7pasn@pathway.suse.cz>
 <201811300226.wAU2Q2JG060388@www262.sakura.ne.jp>
 <20181130123027.cyqfi2k34nh2gjmx@pathway.suse.cz>
 <02b4ce85-c1e5-6601-e3a7-cecfbd5298dc@i-love.sakura.ne.jp>
Message-ID: <8634f952-7a14-055d-943c-d219ab5d8c1b@i-love.sakura.ne.jp>
Date:   Sat, 1 Dec 2018 20:30:16 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <02b4ce85-c1e5-6601-e3a7-cecfbd5298dc@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From bc9ea8e7878a618fd4490ec287eb691fee144acb Mon Sep 17 00:00:00 2001
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date: Sat, 1 Dec 2018 19:37:42 +0900
Subject: [PATCH] printk: fix printk_time race.

Since printk_time can be toggled via /sys/module/printk/parameters/time ,
it is not safe to assume that output length does not change across
multiple msg_print_text() calls. If we hit this race, we can observe
failures such as SYSLOG_ACTION_READ_ALL writes more bytes than userspace
has supplied, SYSLOG_ACTION_SIZE_UNREAD returns -EFAULT when succeeded,
SYSLOG_ACTION_READ reads garbage memory or even triggers an kernel oops
at _copy_to_user() due to integer overflow.

To close this race, get a snapshot value of printk_time and pass it to
SYSLOG_ACTION_READ, SYSLOG_ACTION_READ_ALL, SYSLOG_ACTION_SIZE_UNREAD and
kmsg_dump_get_buffer().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 68 +++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5c2079d..64ed21d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -403,6 +403,7 @@ __packed __aligned(4)
 static u64 syslog_seq;
 static u32 syslog_idx;
 static size_t syslog_partial;
+static bool syslog_time;
 
 /* index and sequence number of the first record stored in the buffer */
 static u64 log_first_seq;
@@ -1228,12 +1229,7 @@ static inline void boot_delay_msec(int level)
 
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
@@ -1242,7 +1238,8 @@ static size_t print_time(u64 ts, char *buf)
 		       (unsigned long)ts, rem_nsec / 1000);
 }
 
-static size_t print_prefix(const struct printk_log *msg, bool syslog, char *buf)
+static size_t print_prefix(const struct printk_log *msg, bool syslog,
+			   bool time, char *buf)
 {
 	size_t len = 0;
 	unsigned int prefix = (msg->facility << 3) | msg->level;
@@ -1261,11 +1258,13 @@ static size_t print_prefix(const struct printk_log *msg, bool syslog, char *buf)
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
@@ -1284,17 +1283,17 @@ static size_t msg_print_text(const struct printk_log *msg, bool syslog, char *bu
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
@@ -1331,9 +1330,17 @@ static int syslog_print(char __user *buf, int size)
 			break;
 		}
 
+		/*
+		 * To keep reading/counting partial line consistent,
+		 * use printk_time value as of the biginning of a line.
+		 */
+		if (!syslog_partial)
+			syslog_time = printk_time;
+
 		skip = syslog_partial;
 		msg = log_from_idx(syslog_idx);
-		n = msg_print_text(msg, true, text, LOG_LINE_MAX + PREFIX_MAX);
+		n = msg_print_text(msg, true, syslog_time, text,
+				   LOG_LINE_MAX + PREFIX_MAX);
 		if (n - syslog_partial <= size) {
 			/* message fits into buffer, move forward */
 			syslog_idx = log_next(syslog_idx);
@@ -1373,11 +1380,13 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
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
@@ -1388,7 +1397,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	while (seq < log_next_seq) {
 		struct printk_log *msg = log_from_idx(idx);
 
-		len += msg_print_text(msg, true, NULL, 0);
+		len += msg_print_text(msg, true, time, NULL, 0);
 		idx = log_next(idx);
 		seq++;
 	}
@@ -1399,7 +1408,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	while (len > size && seq < log_next_seq) {
 		struct printk_log *msg = log_from_idx(idx);
 
-		len -= msg_print_text(msg, true, NULL, 0);
+		len -= msg_print_text(msg, true, time, NULL, 0);
 		idx = log_next(idx);
 		seq++;
 	}
@@ -1410,14 +1419,9 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
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
 
@@ -1541,11 +1545,13 @@ int do_syslog(int type, char __user *buf, int len, int source)
 		} else {
 			u64 seq = syslog_seq;
 			u32 idx = syslog_idx;
+			bool f = syslog_partial ? syslog_time : printk_time;
 
 			while (seq < log_next_seq) {
 				struct printk_log *msg = log_from_idx(idx);
 
-				error += msg_print_text(msg, true, NULL, 0);
+				error += msg_print_text(msg, true, f, NULL, 0);
+				f = printk_time;
 				idx = log_next(idx);
 				seq++;
 			}
@@ -2026,8 +2032,8 @@ static void console_lock_spinning_enable(void) { }
 static int console_lock_spinning_disable_and_check(void) { return 0; }
 static void call_console_drivers(const char *ext_text, size_t ext_len,
 				 const char *text, size_t len) {}
-static size_t msg_print_text(const struct printk_log *msg,
-			     bool syslog, char *buf, size_t size) { return 0; }
+static size_t msg_print_text(const struct printk_log *msg, bool syslog,
+			     bool time, char *buf, size_t size) { return 0; }
 static bool suppress_message_printing(int level) { return false; }
 
 #endif /* CONFIG_PRINTK */
@@ -2385,8 +2391,7 @@ void console_unlock(void)
 
 		len += msg_print_text(msg,
 				console_msg_format & MSG_FORMAT_SYSLOG,
-				text + len,
-				sizeof(text) - len);
+				printk_time, text + len, sizeof(text) - len);
 		if (nr_ext_console_drivers) {
 			ext_len = msg_print_ext_header(ext_text,
 						sizeof(ext_text),
@@ -3110,7 +3115,7 @@ bool kmsg_dump_get_line_nolock(struct kmsg_dumper *dumper, bool syslog,
 		goto out;
 
 	msg = log_from_idx(dumper->cur_idx);
-	l = msg_print_text(msg, syslog, line, size);
+	l = msg_print_text(msg, syslog, printk_time, line, size);
 
 	dumper->cur_idx = log_next(dumper->cur_idx);
 	dumper->cur_seq++;
@@ -3181,6 +3186,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	u32 next_idx;
 	size_t l = 0;
 	bool ret = false;
+	bool time = printk_time;
 
 	if (!dumper->active)
 		goto out;
@@ -3204,7 +3210,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	while (seq < dumper->next_seq) {
 		struct printk_log *msg = log_from_idx(idx);
 
-		l += msg_print_text(msg, true, NULL, 0);
+		l += msg_print_text(msg, true, time, NULL, 0);
 		idx = log_next(idx);
 		seq++;
 	}
@@ -3215,7 +3221,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	while (l > size && seq < dumper->next_seq) {
 		struct printk_log *msg = log_from_idx(idx);
 
-		l -= msg_print_text(msg, true, NULL, 0);
+		l -= msg_print_text(msg, true, time, NULL, 0);
 		idx = log_next(idx);
 		seq++;
 	}
@@ -3228,7 +3234,7 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
 	while (seq < dumper->next_seq) {
 		struct printk_log *msg = log_from_idx(idx);
 
-		l += msg_print_text(msg, syslog, buf + l, size - l);
+		l += msg_print_text(msg, syslog, time, buf + l, size - l);
 		idx = log_next(idx);
 		seq++;
 	}
-- 
1.8.3.1

