Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932746AbeDXC2N (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 22:28:13 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35236 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeDXC2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 22:28:12 -0400
X-Google-Smtp-Source: AIpwx498m37fFCsMaifPgY0k7LTJvalfI7fX7zT5rGRkp0nTIkNSqV6kaOmfV264FiWN9L7kBTgr8w==
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCH] printk: do not call console drivers from printk_safe context
Date: Tue, 24 Apr 2018 11:28:02 +0900
Message-Id: <20180424022802.1330-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling console drivers from printk_safe() context does not really
make call_console_drivers() any safer, because printk_safe() has
nothing to do with console drivers or the underlying code. At the
same time printk()-s from console drivers are fine, they don't
deadlock the system. We need printk_safe() because of the way
vprintk_emit() works -- we protect logbuf lock, console_owner_lock
and console_sem spin_lock with printk_safe, -- not because of the
console drivers (which don't deal with logbuf, console_owner_lock
or console_sem locks). Hence we can call console drivers outside
of printk_safe() context.

Another thing to notice is that,
printk_safe() introduces unneeded complexity, since any printk()
message from console drivers has to be stored in per-CPU printk_safe()
buffer first, then be flushed via IRQ work:
	call_console_drivers()
	 printk()
	  printk_safe_log_store()
	   IRQ_work()
	    printk_safe_flush_buffer()
	     printk_deferred()
	      log_store()
	       irq_work_queue()               *
	        wake_up_klogd_work_func()     *

Note that this also costs us extra IRQ work [along with the IRQ work
that flushes printk_safe() buffer] - we flush per-CPU printk_safe()
buffers via printk_deferred().

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/internal.h | 7 ++++++-
 kernel/printk/printk.c   | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 2a7d04049af4..f3ba1bf08590 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -55,8 +55,13 @@ void __printk_safe_exit(void);
 	} while (0)
 
 #else
+static void __printk_safe_enter(void) {}
+static void __printk_safe_exit(void) {}
 
-__printf(1, 0) int vprintk_func(const char *fmt, va_list args) { return 0; }
+static __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
+{
+	return 0;
+}
 
 /*
  * In !PRINTK builds we still export logbuf_lock spin_lock, console_sem
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2f4af216bd6e..9acb25ce6081 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2391,9 +2391,11 @@ void console_unlock(void)
 		 */
 		console_lock_spinning_enable();
 
+		__printk_safe_exit();
 		stop_critical_timings();	/* don't trace print latency */
 		call_console_drivers(ext_text, ext_len, text, len);
 		start_critical_timings();
+		__printk_safe_enter();
 
 		if (console_lock_spinning_disable_and_check()) {
 			printk_safe_exit_irqrestore(flags);
-- 
2.17.0
