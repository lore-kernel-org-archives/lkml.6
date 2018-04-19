Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbeDSBnB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 21:43:01 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36109 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752262AbeDSBnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 21:43:00 -0400
X-Google-Smtp-Source: AIpwx4+pmkCxnQnygyGiMS8vcb2dq/JABfW6xg6kT5gswep9CAUXHbk0W0IfPmH8hq3n2Gmsj3GLNg==
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCHv2] printk: wake up klogd in vprintk_emit
Date: Thu, 19 Apr 2018 10:42:50 +0900
Message-Id: <20180419014250.5692-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180414030145.26304-1-sergey.senozhatsky@gmail.com>
References: <20180414030145.26304-1-sergey.senozhatsky@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We wake up klogd very late - only when current console_sem owner
is done pushing pending kernel messages to the serial/net consoles.
In some cases this results in lost syslog messages, because kernel
log buffer is a circular buffer and if we don't wakeup syslog long
enough there are chances that logbuf simply will wrap around.

The patch moves the klog wake up call to vprintk_emit(), which is
the only legit way for a kernel message to appear in the logbuf,
right before we attempt to grab the console_sem (possibly spinning
on it waiting for the hand off) and call console drivers.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2f4af216bd6e..247808333ba4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1908,6 +1908,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
 
+	wake_up_klogd();
 	return printed_len;
 }
 EXPORT_SYMBOL(vprintk_emit);
@@ -2289,9 +2290,7 @@ void console_unlock(void)
 {
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
 	static char text[LOG_LINE_MAX + PREFIX_MAX];
-	static u64 seen_seq;
 	unsigned long flags;
-	bool wake_klogd = false;
 	bool do_cond_resched, retry;
 
 	if (console_suspended) {
@@ -2335,11 +2334,6 @@ void console_unlock(void)
 
 		printk_safe_enter_irqsave(flags);
 		raw_spin_lock(&logbuf_lock);
-		if (seen_seq != log_next_seq) {
-			wake_klogd = true;
-			seen_seq = log_next_seq;
-		}
-
 		if (console_seq < log_first_seq) {
 			len = sprintf(text, "** %u printk messages dropped **\n",
 				      (unsigned)(log_first_seq - console_seq));
@@ -2397,7 +2391,7 @@ void console_unlock(void)
 
 		if (console_lock_spinning_disable_and_check()) {
 			printk_safe_exit_irqrestore(flags);
-			goto out;
+			return;
 		}
 
 		printk_safe_exit_irqrestore(flags);
@@ -2429,10 +2423,6 @@ void console_unlock(void)
 
 	if (retry && console_trylock())
 		goto again;
-
-out:
-	if (wake_klogd)
-		wake_up_klogd();
 }
 EXPORT_SYMBOL(console_unlock);
 
-- 
2.17.0
