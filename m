Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B370C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BB020865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 14:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BB020865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeKYBS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 20:18:26 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:24108 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbeKYBSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 20:18:25 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wAOET4uE057658;
        Sat, 24 Nov 2018 23:29:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Sat, 24 Nov 2018 23:29:04 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wAOESxoA057538
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 24 Nov 2018 23:29:04 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] printk: deduplicate print_prefix() calls
Date:   Sat, 24 Nov 2018 23:28:36 +0900
Message-Id: <1543069716-3246-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1543056613-4779-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1543056613-4779-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since /sys/module/printk/parameters/time can change from N to Y between
"msg_print_text() called print_prefix() with buf == NULL" and
"msg_print_text() again calls print_prefix() with buf != NULL", it is not
safe for print_time() to unconditionally return 0 if printk_time == false.

But print_prefix() is called by only msg_print_text(), and print_prefix()
is called once more for calculating output length of prefix, and there is
no need to recalculate it when one log entry contains multiple lines.

Since max output length for syslog marker and timestamp are known to be
small enough, let's close this race by deduplicating print_prefix() calls.

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/printk/printk.c | 64 +++++++++++++++-----------------------------------
 1 file changed, 19 insertions(+), 45 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 1b2a029..eac4c80 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1213,50 +1213,26 @@ static inline void boot_delay_msec(int level)
 static bool printk_time = IS_ENABLED(CONFIG_PRINTK_TIME);
 module_param_named(time, printk_time, bool, S_IRUGO | S_IWUSR);
 
-static size_t print_time(u64 ts, char *buf)
-{
-	unsigned long rem_nsec;
-
-	if (!printk_time)
-		return 0;
-
-	rem_nsec = do_div(ts, 1000000000);
-
-	if (!buf)
-		return snprintf(NULL, 0, "[%5lu.000000] ", (unsigned long)ts);
-
-	return sprintf(buf, "[%5lu.%06lu] ",
-		       (unsigned long)ts, rem_nsec / 1000);
-}
-
-static size_t print_prefix(const struct printk_log *msg, bool syslog, char *buf)
-{
-	size_t len = 0;
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
-
-	len += print_time(msg->ts_nsec, buf ? buf + len : NULL);
-	return len;
-}
-
 static size_t msg_print_text(const struct printk_log *msg, bool syslog, char *buf, size_t size)
 {
 	const char *text = log_text(msg);
 	size_t text_size = msg->text_len;
 	size_t len = 0;
+	char prefix[32]; /* "<2047>[18446744073.709551] " */
+	size_t prefix_len = 0;
+
+	if (syslog)
+		prefix_len += snprintf(prefix, sizeof(prefix), "<%u>",
+				       (msg->facility << 3) | msg->level);
+	if (printk_time) {
+		u64 ts = msg->ts_nsec;
+		unsigned long rem_nsec = do_div(ts, 1000000000);
+
+		prefix_len += snprintf(prefix + prefix_len,
+				       sizeof(prefix) - prefix_len,
+				       "[%5lu.%06lu] ", (unsigned long)ts,
+				       rem_nsec / 1000);
+	}
 
 	do {
 		const char *next = memchr(text, '\n', text_size);
@@ -1271,19 +1247,17 @@ static size_t msg_print_text(const struct printk_log *msg, bool syslog, char *bu
 		}
 
 		if (buf) {
-			if (print_prefix(msg, syslog, NULL) +
-			    text_len + 1 >= size - len)
+			if (prefix_len + text_len + 1 >= size - len)
 				break;
 
-			len += print_prefix(msg, syslog, buf + len);
+			memcpy(buf + len, prefix, prefix_len);
+			len += prefix_len;
 			memcpy(buf + len, text, text_len);
 			len += text_len;
 			buf[len++] = '\n';
 		} else {
 			/* SYSLOG_ACTION_* buffer size only calculation */
-			len += print_prefix(msg, syslog, NULL);
-			len += text_len;
-			len++;
+			len += prefix_len + text_len + 1;
 		}
 
 		text = next;
-- 
1.8.3.1

