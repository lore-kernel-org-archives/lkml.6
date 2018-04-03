Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeDCTlH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 15:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751749AbeDCTlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 15:41:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F71214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Tue, 3 Apr 2018 15:41:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>
Subject: [RFC][PATCH] tracing, printk: Force no hashing when trace_printk()
 is used
Message-ID: <20180403154102.150b1be0@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While debugging an issue I needed to see if the pointers were being
processed correctly with trace_printk() and after using "%p" and
triggering my bug and trace output, I was disappointed that all my
pointers were random garbage and didn't produce anything useful for me.
I had to rewrite all the trace_printk()s to use "%lx" instead.

As trace_printk() is not to be used for anything but debugging, and
this is enforced by printing in the dmesg:

 **********************************************************
 **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
 **                                                      **
 ** trace_printk() being used. Allocating extra memory.  **
 **                                                      **
 ** This means that this is a DEBUG kernel and it is     **
 ** unsafe for production use.                           **
 **                                                      **
 ** If you see this message and you are not debugging    **
 ** the kernel, report this immediately to your vendor!  **
 **                                                      **
 **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
 **********************************************************

on boot up if trace_printk() is used (or when a module is loaded that
uses trace_printk()), we can safely assume that the use of
trace_printk() is not going to be accidentally added to production code
(and if it is, they should be whacked with an overcooked spaghetti
noodle).

A new bool is added called "trace_debug" and if it is set, then %p will
not be hashed.

Both trace_debug is set and kptr_restrict is set to zero in the same
code that produces the above banner. This will allow trace_printk() to
not be affected by security code, as trace_printk() should never be run
on a machine that needs security of this kind.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/include/linux/printk.h b/include/linux/printk.h
index e9b603ee9953..7ef6c31d874a 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -278,6 +278,7 @@ static inline void printk_safe_flush_on_panic(void)
 #endif
 
 extern int kptr_restrict;
+extern bool trace_debug;
 
 extern asmlinkage void dump_stack(void) __cold;
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0f47e653ffd8..cb58cd4ee3a7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2864,6 +2864,10 @@ void trace_printk_init_buffers(void)
 
 	buffers_allocated = 1;
 
+	/* This is a debug kernel, allow pointers to be shown */
+	trace_debug = true;
+	kptr_restrict = 0;
+
 	/*
 	 * trace_printk_init_buffers() can be called by modules.
 	 * If that happens, then we need to start cmdline recording
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 89f8a4a4b770..425644ceedcb 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1345,6 +1345,7 @@ char *uuid_string(char *buf, char *end, const u8 *addr,
 }
 
 int kptr_restrict __read_mostly;
+bool trace_debug __read_mostly;
 
 static noinline_for_stack
 char *restricted_pointer(char *buf, char *end, const void *ptr,
@@ -1962,6 +1963,10 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return pointer_string(buf, end, ptr, spec);
 	}
 
+	/* When the kernel is in debugging mode, show all pointers */
+	if (trace_debug)
+		return restricted_pointer(buf, end, ptr, spec);
+
 	/* default is to _not_ leak addresses, hash before printing */
 	return ptr_to_id(buf, end, ptr, spec);
 }
