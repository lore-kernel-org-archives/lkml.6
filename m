Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tcenDatWGlsZNgAAmS7hNA
	; Fri, 08 Jun 2018 10:48:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C2643607E4; Fri,  8 Jun 2018 10:48:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DEB1060275;
	Fri,  8 Jun 2018 10:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DEB1060275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeFHKsa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 06:48:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:34209 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbeFHKs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 06:48:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 18AFDAF48;
        Fri,  8 Jun 2018 10:48:26 +0000 (UTC)
Date: Fri, 8 Jun 2018 12:48:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, "4 . 13+" <stable@vger.kernel.org>
Subject: Re: [PATCH] printk/nmi: Prevent deadlock when serializing NMI
 backtraces
Message-ID: <20180608104825.e7xoxteelaxnwx66@pathway.suse.cz>
References: <20180517143903.19339-1-pmladek@suse.com>
 <20180605124729.3vix5nlkjpjzdljx@pathway.suse.cz>
 <20180606051029.GA19211@tigerII.localdomain>
 <20180606103356.GB19211@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606103356.GB19211@tigerII.localdomain>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-06-06 19:33:56, Sergey Senozhatsky wrote:
> On (06/06/18 14:10), Sergey Senozhatsky wrote:
> > On (06/05/18 14:47), Petr Mladek wrote:
> > [..]
> > > Grr, the ABBA deadlock is still there. NMIs are not sent to the other
> > > CPUs atomically. Even if we detect that logbuf_lock is available
> > > in printk_nmi_enter() on some CPUs, it might still get locked on
> > > another CPU before the other CPU gets NMI.
> > 
> > Can we do something about "B"? :) I mean - any chance we can rework
> > locking in nmi_cpu_backtrace()?
> 
> Sorry, I don't have that much free time at the moment, so can't
> fully concentrate on this issue.
> 
> Here is a quick-n-dirty thought.
> 
> The whole idea of printk_nmi() was to reduce the number of locks
> we take performing printk() from NMI context - ideally down to 0.
> We added logbuf spin_lock later on. One lock was fine. But then
> we added another one - nmi_cpu_backtrace() lock. And two locks is
> too many. So can we drop the nmi_cpu_backtrace() lock, and in
> exchange extend printk-safe API with functions that will disable/enable
> PRINTK_NMI_DEFERRED_CONTEXT_MASK on a particular CPU?

I ended with similar conclusion. I am just nervous by the fact that
the check in printk_nmi_enter() will always be unreliable. We already
deal with situations when we want to check the actual lock state
in panic(). Also the lock in nmi_cpu_backtrace() need not be
the only lock serializing NMIs. I am always surprised what code
can be called in NMI.

I played with this a bit and came up with the following:


>From 25c904dbe8eb95d823b311a343f39ed926b7a7b2 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Fri, 8 Jun 2018 11:21:07 +0200
Subject: [PATCH] printk/nmi: More reliable approach to use the main
log buffer in NMI

The check whether logbuf_lock is available is not safe in
printk_nmi_enter(). It might get blocked by another CPU that
takes the lock and enter NMI later.

The race still would be acceptable if the other CPU could
finish the NMI handler independently. But this is not a case
with nmi_trigger_cpumask_backtrace(). It has to serialize
all NMI handlers to prevent mixed output.

It would be possible to make the decision later in vprintk_emit().
But it would cause mixed output and make
nmi_trigger_cpumask_backtrace() unusable.

Also it would be possible to avoid the serialization and force using
the per-CPU buffers in nmi_cpu_backtrace(). But this problem is generic
and we do not know how many other such deadlocks are possible.

But wait, the motivation to use the main log buffer in NMI was for
flushing ftrace log in panic(). It can produce hundreds of lines
that do not fit the per-CPU buffers. The good think is that they
have its own time stamp and can be sorted later. Therefore it might
be acceptable to risk the mixed output in this case.

This patch introduces new printk_nmi_direct() context. It tries
to use the main log buffer when possible but there is a risk of
mixed messages. It will be used only when flushing the ftrace
buffer.

The special printk_nmi per-CPU buffers will always be used in
the other situation again. As a result, nmi_cpu_backtrace() need
not longer be serialized.

Fixes: 719f6a7040f1bdaf96 ("printk: Use the main logbuf in NMI when logbuf_lock is available")
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/printk.h      |  4 ++++
 kernel/printk/internal.h    |  8 ++++++-
 kernel/printk/printk.c      |  8 ++++++-
 kernel/printk/printk_safe.c | 57 ++++++++++++++++++++++++---------------------
 kernel/trace/trace.c        |  4 +++-
 lib/nmi_backtrace.c         |  3 ---
 6 files changed, 51 insertions(+), 33 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 6d7e800affd8..872fbdf8df26 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -148,9 +148,13 @@ void early_printk(const char *s, ...) { }
 #ifdef CONFIG_PRINTK_NMI
 extern void printk_nmi_enter(void);
 extern void printk_nmi_exit(void);
+extern void printk_nmi_direct_enter(void);
+extern void printk_nmi_direct_exit(void);
 #else
 static inline void printk_nmi_enter(void) { }
 static inline void printk_nmi_exit(void) { }
+static void printk_nmi_direct_enter(void) { }
+static void printk_nmi_direct_exit(void) { }
 #endif /* PRINTK_NMI */
 
 #ifdef CONFIG_PRINTK
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 2a7d04049af4..47db66e41ab4 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -19,11 +19,17 @@
 #ifdef CONFIG_PRINTK
 
 #define PRINTK_SAFE_CONTEXT_MASK	 0x3fffffff
-#define PRINTK_NMI_DEFERRED_CONTEXT_MASK 0x40000000
+#define PRINTK_NMI_DIRECT_CONTEXT_MASK	 0x40000000
 #define PRINTK_NMI_CONTEXT_MASK		 0x80000000
 
 extern raw_spinlock_t logbuf_lock;
 
+#ifdef CONFIG_PRINTK_NMI
+__printf(1, 0) int vprintk_nmi(const char *fmt, va_list args);
+#else
+__printf(1, 0) int vprintk_nmi(const char *fmt, va_list args) { return 0; }
+#endif
+
 __printf(1, 0) int vprintk_default(const char *fmt, va_list args);
 __printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
 __printf(1, 0) int vprintk_func(const char *fmt, va_list args);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 247808333ba4..cf55bece43d9 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1845,7 +1845,13 @@ asmlinkage int vprintk_emit(int facility, int level,
 	printk_delay();
 
 	/* This stops the holder of console_sem just where we want him */
-	logbuf_lock_irqsave(flags);
+	printk_safe_enter_irqsave(flags);
+	if (in_nmi() && !raw_spin_trylock(&logbuf_lock)) {
+		printed_len = vprintk_nmi(fmt, args);
+		printk_safe_exit_irqrestore(flags);
+		return printed_len;
+	} else
+		raw_spin_lock(&logbuf_lock);
 	/*
 	 * The printf needs to come first; we need the syslog
 	 * prefix which might be passed-in as a parameter.
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index d7d091309054..bf8e3ebfca8e 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -299,40 +299,43 @@ void printk_safe_flush_on_panic(void)
  * one writer running. But the buffer might get flushed from another
  * CPU, so we need to be careful.
  */
-static __printf(1, 0) int vprintk_nmi(const char *fmt, va_list args)
+__printf(1, 0) int vprintk_nmi(const char *fmt, va_list args)
 {
 	struct printk_safe_seq_buf *s = this_cpu_ptr(&nmi_print_seq);
 
 	return printk_safe_log_store(s, fmt, args);
 }
 
-void printk_nmi_enter(void)
+/*
+ * Try to use the main log buffer even in NMI context. It falls
+ * back to vprintk_nmi() when the lock is not available. The decision
+ * is made in vprintk_emit().
+ *
+ * Therefore there is not a risk of a deadlock. But the messages might
+ * get reordered when anyone uses the lock in parallel and only some
+ * messages are stored directly.
+ */
+void printk_nmi_direct_enter(void)
 {
-	/*
-	 * The size of the extra per-CPU buffer is limited. Use it only when
-	 * the main one is locked. If this CPU is not in the safe context,
-	 * the lock must be taken on another CPU and we could wait for it.
-	 */
-	if ((this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK) &&
-	    raw_spin_is_locked(&logbuf_lock)) {
-		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
-	} else {
-		this_cpu_or(printk_context, PRINTK_NMI_DEFERRED_CONTEXT_MASK);
-	}
+	if (!(this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK))
+		return;
+
+	this_cpu_or(printk_context, PRINTK_NMI_DIRECT_CONTEXT_MASK);
 }
 
-void printk_nmi_exit(void)
+void printk_nmi_direct_exit(void)
 {
-	this_cpu_and(printk_context,
-		     ~(PRINTK_NMI_CONTEXT_MASK |
-		       PRINTK_NMI_DEFERRED_CONTEXT_MASK));
+	this_cpu_and(printk_context, ~PRINTK_NMI_DIRECT_CONTEXT_MASK);
 }
 
-#else
+void printk_nmi_enter(void)
+{
+	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
+}
 
-static __printf(1, 0) int vprintk_nmi(const char *fmt, va_list args)
+void printk_nmi_exit(void)
 {
-	return 0;
+	this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
 }
 
 #endif /* CONFIG_PRINTK_NMI */
@@ -363,6 +366,13 @@ void __printk_safe_exit(void)
 
 __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 {
+	/*
+	 * Try to use the main logbuf even in NMI. But avoid calling console
+	 * drivers that might have their own locks.
+	 */
+	if (this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)
+		return vprintk_deferred(fmt, args);
+
 	/* Use extra buffer in NMI when logbuf_lock is taken or in safe mode. */
 	if (this_cpu_read(printk_context) & PRINTK_NMI_CONTEXT_MASK)
 		return vprintk_nmi(fmt, args);
@@ -371,13 +381,6 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
 	if (this_cpu_read(printk_context) & PRINTK_SAFE_CONTEXT_MASK)
 		return vprintk_safe(fmt, args);
 
-	/*
-	 * Use the main logbuf when logbuf_lock is available in NMI.
-	 * But avoid calling console drivers that might have their own locks.
-	 */
-	if (this_cpu_read(printk_context) & PRINTK_NMI_DEFERRED_CONTEXT_MASK)
-		return vprintk_deferred(fmt, args);
-
 	/* No obstacles. */
 	return vprintk_default(fmt, args);
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 108ce3e1dc13..38b6dbe1709b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8279,6 +8279,7 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 	tracing_off();
 
 	local_irq_save(flags);
+	printk_nmi_direct_enter();
 
 	/* Simulate the iterator */
 	trace_init_global_iter(&iter);
@@ -8358,7 +8359,8 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 	for_each_tracing_cpu(cpu) {
 		atomic_dec(&per_cpu_ptr(iter.trace_buffer->data, cpu)->disabled);
 	}
- 	atomic_dec(&dump_running);
+	atomic_dec(&dump_running);
+	printk_nmi_direct_exit();
 	local_irq_restore(flags);
 }
 EXPORT_SYMBOL_GPL(ftrace_dump);
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 61a6b5aab07e..15ca78e1c7d4 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -87,11 +87,9 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 
 bool nmi_cpu_backtrace(struct pt_regs *regs)
 {
-	static arch_spinlock_t lock = __ARCH_SPIN_LOCK_UNLOCKED;
 	int cpu = smp_processor_id();
 
 	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
-		arch_spin_lock(&lock);
 		if (regs && cpu_in_idle(instruction_pointer(regs))) {
 			pr_warn("NMI backtrace for cpu %d skipped: idling at %pS\n",
 				cpu, (void *)instruction_pointer(regs));
@@ -102,7 +100,6 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 			else
 				dump_stack();
 		}
-		arch_spin_unlock(&lock);
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return true;
 	}
-- 
2.13.6
