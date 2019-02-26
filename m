Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696E9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42EFC2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfBZMuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:50:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:42256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726084AbfBZMuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:50:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8D7EB631;
        Tue, 26 Feb 2019 12:50:02 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH] printk/console: Do not suppress information about dropped messages
Date:   Tue, 26 Feb 2019 13:49:45 +0100
Message-Id: <20190226124945.7078-1-pmladek@suse.com>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The warning about dropped messages gets lost when the current
message is above console_loglevel and suppressed.

The suppressed messages allow even slow consoles to caught up
with a flood of messages. The consoles must not get slowed
down by many warnings. Instead, the warning is delayed until
the next printable message.

The handling of newly registered consoles is handled with a compromise:

  + It does not make sense to reply the log when it is already behind.
    This prevents a bogus number at the beginning of the replayed log.

  + The counter is restarted when switching to all consoles. This
    prevents a bogus number on already registered consoles.

  + The last number in the replayed log might be lower than reality.
    But it does not look worth existing.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c | 54 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b4d26388bc62..c3f287422ef4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -420,6 +420,7 @@ static u32 log_next_idx;
 /* the next printk record to write to the console */
 static u64 console_seq;
 static u32 console_idx;
+static u64 console_dropped_cnt;
 static u64 exclusive_console_stop_seq;
 
 /* the next printk record to read after the last 'clear' command */
@@ -2060,6 +2061,7 @@ static u64 syslog_seq;
 static u32 syslog_idx;
 static u64 console_seq;
 static u32 console_idx;
+static u64 console_dropped_cnt;
 static u64 exclusive_console_stop_seq;
 static u64 log_first_seq;
 static u32 log_first_idx;
@@ -2398,20 +2400,24 @@ void console_unlock(void)
 	for (;;) {
 		struct printk_log *msg;
 		size_t ext_len = 0;
-		size_t len;
+		size_t len = 0;
 
 		printk_safe_enter_irqsave(flags);
 		raw_spin_lock(&logbuf_lock);
+
+		/* Reset dropped msg count when switching to all consoles. */
+		if (unlikely(exclusive_console &&
+			     exclusive_console_stop_seq < log_first_seq)) {
+			console_dropped_cnt = 0;
+			console_seq = exclusive_console_stop_seq;
+		}
+
 		if (console_seq < log_first_seq) {
-			len = sprintf(text,
-				      "** %llu printk messages dropped **\n",
-				      log_first_seq - console_seq);
+			console_dropped_cnt += log_first_seq - console_seq;
 
 			/* messages are gone, move to first one */
 			console_seq = log_first_seq;
 			console_idx = log_first_idx;
-		} else {
-			len = 0;
 		}
 skip:
 		if (console_seq == log_next_seq)
@@ -2435,6 +2441,13 @@ void console_unlock(void)
 			exclusive_console = NULL;
 		}
 
+		if (unlikely(console_dropped_cnt)) {
+			len = sprintf(text,
+				      "** %llu printk messages dropped **\n",
+				      console_dropped_cnt);
+			console_dropped_cnt = 0;
+		}
+
 		len += msg_print_text(msg,
 				console_msg_format & MSG_FORMAT_SYSLOG,
 				printk_time, text + len, sizeof(text) - len);
@@ -2750,19 +2763,22 @@ void register_console(struct console *newcon)
 		 * for us.
 		 */
 		logbuf_lock_irqsave(flags);
-		console_seq = syslog_seq;
-		console_idx = syslog_idx;
-		/*
-		 * We're about to replay the log buffer.  Only do this to the
-		 * just-registered console to avoid excessive message spam to
-		 * the already-registered consoles.
-		 *
-		 * Set exclusive_console with disabled interrupts to reduce
-		 * race window with eventual console_flush_on_panic() that
-		 * ignores console_lock.
-		 */
-		exclusive_console = newcon;
-		exclusive_console_stop_seq = console_seq;
+		/* Nothing to replay when consoles are already behind. */
+		if (!console_dropped_cnt) {
+			console_seq = syslog_seq;
+			console_idx = syslog_idx;
+			/*
+			 * We're about to replay the log buffer.  Only do this
+			 * to the just-registered console to avoid excessive
+			 * message spam to the already-registered consoles.
+			 *
+			 * Set exclusive_console with disabled interrupts to
+			 * reduce race window with eventual
+			 * console_flush_on_panic() that ignores console_lock.
+			 */
+			exclusive_console = newcon;
+			exclusive_console_stop_seq = console_seq;
+		}
 		logbuf_unlock_irqrestore(flags);
 	}
 	console_unlock();
-- 
2.13.7

