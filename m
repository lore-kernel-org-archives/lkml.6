Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58DFC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A5E20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A5E20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbeLKJt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:49:59 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:53163 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeLKJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:49:57 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBB9nB3b035492;
        Tue, 11 Dec 2018 18:49:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Tue, 11 Dec 2018 18:49:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBB9n6x4035468
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Dec 2018 18:49:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] printk: Remove print_prefix() calls with NULL buffer.
Date:   Tue, 11 Dec 2018 18:49:05 +0900
Message-Id: <1544521745-11925-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can save lines/size by removing print_prefix() with buf == NULL.
This patch makes no functional change.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/printk/printk.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 49bcf0e..1306fe0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1227,13 +1227,15 @@ static inline void boot_delay_msec(int level)
 static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
 module_param_named(time, printk_time, bool, S_IRUGO | S_IWUSR);
 
+static size_t print_syslog(unsigned int level, char *buf)
+{
+	return sprintf(buf, "<%u>", level);
+}
+
 static size_t print_time(u64 ts, char *buf)
 {
 	unsigned long rem_nsec = do_div(ts, 1000000000);
 
-	if (!buf)
-		return snprintf(NULL, 0, "[%5lu.000000] ", (unsigned long)ts);
-
 	return sprintf(buf, "[%5lu.%06lu] ",
 		       (unsigned long)ts, rem_nsec / 1000);
 }
@@ -1242,24 +1244,11 @@ static size_t print_prefix(const struct printk_log *msg, bool syslog,
 			   bool time, char *buf)
 {
 	size_t len = 0;
-	unsigned int prefix = (msg->facility << 3) | msg->level;
-
-	if (syslog) {
-		if (buf) {
-			len += sprintf(buf, "<%u>", prefix);
-		} else {
-			len += 3;
-			if (prefix > 999)
-				len += 3;
-			else if (prefix > 99)
-				len += 2;
-			else if (prefix > 9)
-				len++;
-		}
-	}
 
+	if (syslog)
+		len = print_syslog((msg->facility << 3) | msg->level, buf);
 	if (time)
-		len += print_time(msg->ts_nsec, buf ? buf + len : NULL);
+		len += print_time(msg->ts_nsec, buf + len);
 	return len;
 }
 
@@ -1269,6 +1258,8 @@ static size_t msg_print_text(const struct printk_log *msg, bool syslog,
 	const char *text = log_text(msg);
 	size_t text_size = msg->text_len;
 	size_t len = 0;
+	char prefix[PREFIX_MAX];
+	const size_t prefix_len = print_prefix(msg, syslog, time, prefix);
 
 	do {
 		const char *next = memchr(text, '\n', text_size);
@@ -1283,19 +1274,17 @@ static size_t msg_print_text(const struct printk_log *msg, bool syslog,
 		}
 
 		if (buf) {
-			if (print_prefix(msg, syslog, time, NULL) +
-			    text_len + 1 >= size - len)
+			if (prefix_len + text_len + 1 >= size - len)
 				break;
 
-			len += print_prefix(msg, syslog, time, buf + len);
+			memcpy(buf + len, prefix, prefix_len);
+			len += prefix_len;
 			memcpy(buf + len, text, text_len);
 			len += text_len;
 			buf[len++] = '\n';
 		} else {
 			/* SYSLOG_ACTION_* buffer size only calculation */
-			len += print_prefix(msg, syslog, time, NULL);
-			len += text_len;
-			len++;
+			len += prefix_len + text_len + 1;
 		}
 
 		text = next;
-- 
1.8.3.1

