Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8F5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 04:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFEF20854
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 04:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfBWEmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 23:42:19 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:13159 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBWEmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 23:42:18 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1N4gGnj010941;
        Sat, 23 Feb 2019 13:42:16 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Sat, 23 Feb 2019 13:42:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1N4g9fo010888
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 23 Feb 2019 13:42:15 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH] printk: Introduce "store now but print later" prefix.
Date:   Sat, 23 Feb 2019 13:42:10 +0900
Message-Id: <1550896930-12324-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are callers which print many lines in

  $header_text_line
  $body_text_lines
  $trailer_text_line

format, and some of them print $body_text_lines part from atomic context
(or context where spending too much time can result in a lockup). SysRq-t
(which might call printk() on all threads from interrupt context) and the
OOM killer (which might call printk() on all threads from RCU critical
section, and which cannot make forward progress by sending SIGKILL to OOM
victims unless all printk() completes) are such callers. For such callers,
storing all printk() messages to logbuf as soon as possible and then start
actual printing to consoles (after e.g. leaving critical section, sending
SIGKILL to OOM victims) is preferable.

There has been an effort to offload actual printing to a dedicated kernel
thread. But such offloading is not yet accepted due to "print out printk()
messages as soon as possible" versus "don't lockup the system by spending
too much time inside printk()" collision. Therefore, I propose per
printk() flag while utilizing currently available synchronous printing
logic.

This patch tries to address "don't lockup the system" with minimal risk of
failing to "print out printk() messages", by allowing printk() callers to
tell printk() "store $body_text_lines lines into logbuf but start actual
printing after $trailer_text_line line is stored into logbuf". This patch
is different from existing printk_deferred(), for printk_deferred() is
intended for scheduler/timekeeping use only. Moreover, what this patch
wants to do is "do not try to print out printk() messages as soon as
possible", for accumulated stalling period cannot be decreased if
printk_deferred() from e.g. dump_tasks() from out_of_memory() immediately
prints out the messages. The point of this patch is to defer the stalling
duration to after leaving the critical section.

Hereafter, I call printk() with "store now but print later" as "async"
printk(), and printk() with "store now and print now" as "sync" printk().

Since storing $body_text_lines into logbuf using "async" printk() becomes
very fast (latency is reduced from some milliseconds to some microseconds),
the risk of failing to loose $body_text_lines lines which would have been
printed out if "sync" printk() were used is small.

Since actual printing starts as soon as a "sync" printk() is called (which
might be from a CPU which is not processing a series of "async" printk()),
the risk of failing to print out critical messages won't increase provided
that printk() for critical messages (e.g. oops) are "sync" printk().

The possibility of failing to store all printk() messages to logbuf might
be increased by using "async" printk(). But since we have a lot of RAM
nowadays, allocating large logbuf enough to hold the entire SysRq-t output
using log_buf_len= kernel command line parameter won't be difficult.

There is a possibility that a thread which called "sync" printk() stalls
for unexpectedly long period due to previously called a lot of "async"
printk(). Such thread is expected to be the thread itself who did a lot of
"async" printk(), and accumulated stalling period will be there even if
that thread did "sync" printk(). This patch counts on console_waiter in
console_trylock_spinning() for transferring control back from a random
thread which did an innocent "sync" printk() to a thread which did a lot
of "async" printk() by recommending such thread to use "sync" printk() for
$trailer_text_line. Such expectation may fail, but it can't be solved until
we get a really asynchronous printing using lockless consoles. Until that
time, let's try whether failing such expectation leads to horrible
consequences. If it turns out to be horrible consequences, we could add
hints for judging which thread (console_owner or console_waiter) should
continue printing (e.g. prefer schedulable process context over atomic
process context, prefer atomic process context over soft IRQ context,
prefer soft IRQ context over hard IRQ context, and/or track number of
records stored by "async" printk() into "struct task_struct" and compare
it at console_trylock_spinning()). If that still fails, we can temporarily
disable "async" printk() inside vprintk_emit().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/kern_levels.h | 18 ++++++++++++++++++
 include/linux/printk.h      | 28 ++++++++++++++++++++++++++++
 kernel/printk/internal.h    |  4 ++--
 kernel/printk/printk.c      | 16 +++++++++++++---
 kernel/printk/printk_safe.c |  2 +-
 5 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/include/linux/kern_levels.h b/include/linux/kern_levels.h
index bf2389c..dc924a3 100644
--- a/include/linux/kern_levels.h
+++ b/include/linux/kern_levels.h
@@ -23,6 +23,24 @@
  */
 #define KERN_CONT	KERN_SOH "c"
 
+/*
+ * Annotation for a "store now but print later" line of log printout.
+ * Such lines will be printed when printk() without this annotation is called.
+ * Users of this annotation are encouraged to do a final printk() without
+ * this annotation after a series of printk() with this annotation.
+ */
+#define KERN_ASYNC		KERN_SOH "a"
+#define KERN_EMERG_ASYNC	KERN_ASYNC KERN_EMERG
+#define KERN_ALERT_ASYNC	KERN_ASYNC KERN_ALERT
+#define KERN_CRIT_ASYNC		KERN_ASYNC KERN_CRIT
+#define KERN_ERR_ASYNC		KERN_ASYNC KERN_ERR
+#define KERN_WARNING_ASYNC	KERN_ASYNC KERN_WARNING
+#define KERN_NOTICE_ASYNC	KERN_ASYNC KERN_NOTICE
+#define KERN_INFO_ASYNC		KERN_ASYNC KERN_INFO
+#define KERN_DEBUG_ASYNC	KERN_ASYNC KERN_DEBUG
+#define KERN_DEFAULT_ASYNC	KERN_ASYNC KERN_DEFAULT
+#define KERN_CONT_ASYNC		KERN_ASYNC KERN_CONT
+
 /* integer equivalents of KERN_<LEVEL> */
 #define LOGLEVEL_SCHED		-2	/* Deferred messages from sched code
 					 * are set to this special level */
diff --git a/include/linux/printk.h b/include/linux/printk.h
index d7c77ed..5c27561 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -167,6 +167,7 @@ asmlinkage __printf(1, 0)
 
 asmlinkage __printf(1, 2) __cold
 int printk(const char *fmt, ...);
+#define printk_async(fmt, ...) printk(KERN_ASYNC fmt, ##__VA_ARGS__)
 
 /*
  * Special printk facility for scheduler/timekeeping use only, _DO_NOT_USE_ !
@@ -294,19 +295,34 @@ static inline void printk_safe_flush_on_panic(void)
  */
 #define pr_emerg(fmt, ...) \
 	printk(KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_emerg_async(fmt, ...) \
+	printk(KERN_EMERG_ASYNC pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_alert(fmt, ...) \
 	printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_alert_async(fmt, ...) \
+	printk(KERN_ALERT_ASYNC pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_crit(fmt, ...) \
 	printk(KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_crit_async(fmt, ...) \
+	printk(KERN_CRIT_ASYNC pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_err(fmt, ...) \
 	printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_err_async(fmt, ...) \
+	printk(KERN_ERR_ASYNC pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_warning(fmt, ...) \
 	printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_warning_async(fmt, ...) \
+	printk(KERN_WARNING_ASYNC pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_warn pr_warning
+#define pr_warn_async pr_warning_async
 #define pr_notice(fmt, ...) \
 	printk(KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_notice_async(fmt, ...) \
+	printk(KERN_NOTICE_ASYNC pr_fmt(fmt), ##__VA_ARGS__)
 #define pr_info(fmt, ...) \
 	printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_info_async(fmt, ...) \
+	printk(KERN_INFO_ASYNC pr_fmt(fmt), ##__VA_ARGS__)
 /*
  * Like KERN_CONT, pr_cont() should only be used when continuing
  * a line with no newline ('\n') enclosed. Otherwise it defaults
@@ -314,14 +330,20 @@ static inline void printk_safe_flush_on_panic(void)
  */
 #define pr_cont(fmt, ...) \
 	printk(KERN_CONT fmt, ##__VA_ARGS__)
+#define pr_cont_async(fmt, ...) \
+	printk(KERN_CONT_ASYNC fmt, ##__VA_ARGS__)
 
 /* pr_devel() should produce zero code unless DEBUG is defined */
 #ifdef DEBUG
 #define pr_devel(fmt, ...) \
 	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_devel_async(fmt, ...) \
+	printk(KERN_DEBUG_ASYNC pr_fmt(fmt), ##__VA_ARGS__)
 #else
 #define pr_devel(fmt, ...) \
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_devel_async(fmt, ...) \
+	no_printk(KERN_DEBUG_ASYNC pr_fmt(fmt), ##__VA_ARGS__)
 #endif
 
 
@@ -332,12 +354,18 @@ static inline void printk_safe_flush_on_panic(void)
 /* dynamic_pr_debug() uses pr_fmt() internally so we don't need it here */
 #define pr_debug(fmt, ...) \
 	dynamic_pr_debug(fmt, ##__VA_ARGS__)
+#define pr_debug_async(fmt, ...) \
+	dynamic_pr_debug(KERN_ASYNC fmt, ##__VA_ARGS__)
 #elif defined(DEBUG)
 #define pr_debug(fmt, ...) \
 	printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_debug_async(fmt, ...) \
+	printk(KERN_DEBUG_ASYNC pr_fmt(fmt), ##__VA_ARGS__)
 #else
 #define pr_debug(fmt, ...) \
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
+#define pr_debug_async(fmt, ...) \
+	no_printk(KERN_DEBUG_ASYNC pr_fmt(fmt), ##__VA_ARGS__)
 #endif
 
 /*
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 0f18988..a1c9b5c 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -24,8 +24,8 @@
 
 extern raw_spinlock_t logbuf_lock;
 
-__printf(5, 0)
-int vprintk_store(int facility, int level,
+__printf(6, 0)
+int vprintk_store(bool *async, int facility, int level,
 		  const char *dict, size_t dictlen,
 		  const char *fmt, va_list args);
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 02ca827..af365a7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1884,7 +1884,7 @@ static size_t log_output(int facility, int level, enum log_flags lflags, const c
 }
 
 /* Must be called under logbuf_lock. */
-int vprintk_store(int facility, int level,
+int vprintk_store(bool *async, int facility, int level,
 		  const char *dict, size_t dictlen,
 		  const char *fmt, va_list args)
 {
@@ -1899,6 +1899,15 @@ int vprintk_store(int facility, int level,
 	 */
 	text_len = vscnprintf(text, sizeof(textbuf), fmt, args);
 
+	/* check "store now but print later" request */
+	if (text_len > 1 && text[0] == KERN_ASYNC[0] &&
+	    text[1] == KERN_ASYNC[1]) {
+		if (async)
+			*async = true;
+		text_len -= 2;
+		text += 2;
+	}
+
 	/* mark and strip a trailing newline */
 	if (text_len && text[text_len-1] == '\n') {
 		text_len--;
@@ -1942,6 +1951,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	bool in_sched = false, pending_output;
 	unsigned long flags;
 	u64 curr_log_seq;
+	bool async = false;
 
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
@@ -1954,8 +1964,8 @@ asmlinkage int vprintk_emit(int facility, int level,
 	/* This stops the holder of console_sem just where we want him */
 	logbuf_lock_irqsave(flags);
 	curr_log_seq = log_next_seq;
-	printed_len = vprintk_store(facility, level, dict, dictlen, fmt, args);
-	pending_output = (curr_log_seq != log_next_seq);
+	printed_len = vprintk_store(&async, facility, level, dict, dictlen, fmt, args);
+	pending_output = !async && (curr_log_seq != log_next_seq);
 	logbuf_unlock_irqrestore(flags);
 
 	/* If called from the scheduler, we can not call up(). */
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index 0913b4d..979c7b4 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -380,7 +380,7 @@ void __printk_safe_exit(void)
 	    raw_spin_trylock(&logbuf_lock)) {
 		int len;
 
-		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
+		len = vprintk_store(NULL, 0, LOGLEVEL_DEFAULT, NULL, 0, fmt, args);
 		raw_spin_unlock(&logbuf_lock);
 		defer_console_output();
 		return len;
-- 
1.8.3.1

