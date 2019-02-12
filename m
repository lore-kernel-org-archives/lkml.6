Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB5CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666CF2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbfBLOaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:30:35 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43714 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729495AbfBLOa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:30:29 -0500
Received: from [5.158.153.53] (helo=linux.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtZ4i-0005Af-Hu; Tue, 12 Feb 2019 15:30:16 +0100
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
Subject: [RFC PATCH v1 09/25] printk: remove exclusive console hack
Date:   Tue, 12 Feb 2019 15:29:47 +0100
Message-Id: <20190212143003.48446-10-john.ogness@linutronix.de>
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

In order to support printing the printk log history when new
consoles are registered, a global exclusive_console variable is
temporarily set. This only works because printk runs with
preemption disabled.

When console printing is moved to a fully preemptible dedicated
kthread, this hack no longer works.

Remove exclusive_console usage.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 08e079b95652..5a5a685bb128 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -251,11 +251,6 @@ static void __up_console_sem(unsigned long ip)
 static int console_locked, console_suspended;
 
 /*
- * If exclusive_console is non-NULL then only this console is to be printed to.
- */
-static struct console *exclusive_console;
-
-/*
  *	Array of consoles built from command line options (console=)
  */
 
@@ -423,7 +418,6 @@ static u32 log_next_idx;
 /* the next printk record to write to the console */
 static u64 console_seq;
 static u32 console_idx;
-static u64 exclusive_console_stop_seq;
 
 /* the next printk record to read after the last 'clear' command */
 static u64 clear_seq;
@@ -1761,8 +1755,6 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
 		return;
 
 	for_each_console(con) {
-		if (exclusive_console && con != exclusive_console)
-			continue;
 		if (!(con->flags & CON_ENABLED))
 			continue;
 		if (!con->write)
@@ -2044,7 +2036,6 @@ static u64 syslog_seq;
 static u32 syslog_idx;
 static u64 console_seq;
 static u32 console_idx;
-static u64 exclusive_console_stop_seq;
 static u64 log_first_seq;
 static u32 log_first_idx;
 static u64 log_next_seq;
@@ -2413,12 +2404,6 @@ void console_unlock(void)
 			goto skip;
 		}
 
-		/* Output to all consoles once old messages replayed. */
-		if (unlikely(exclusive_console &&
-			     console_seq >= exclusive_console_stop_seq)) {
-			exclusive_console = NULL;
-		}
-
 		len += msg_print_text(msg,
 				console_msg_format & MSG_FORMAT_SYSLOG,
 				printk_time, text + len, sizeof(text) - len);
@@ -2736,17 +2721,6 @@ void register_console(struct console *newcon)
 		logbuf_lock_irqsave(flags);
 		console_seq = syslog_seq;
 		console_idx = syslog_idx;
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
 		logbuf_unlock_irqrestore(flags);
 	}
 	console_unlock();
@@ -2758,6 +2732,10 @@ void register_console(struct console *newcon)
 	 * boot consoles, real consoles, etc - this is to ensure that end
 	 * users know there might be something in the kernel's log buffer that
 	 * went to the bootconsole (that they do not see on the real console)
+	 *
+	 * This message is also important because it will trigger the
+	 * printk kthread to begin dumping the log buffer to the newly
+	 * registered console.
 	 */
 	pr_info("%sconsole [%s%d] enabled\n",
 		(newcon->flags & CON_BOOT) ? "boot" : "" ,
-- 
2.11.0

