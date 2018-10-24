Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194BDC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8422064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8422064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbeJXSil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:38:41 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:16372 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeJXSil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:38:41 -0400
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9OABBCc045516;
        Wed, 24 Oct 2018 19:11:11 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Wed, 24 Oct 2018 19:11:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9OAB75E045503
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 24 Oct 2018 19:11:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v5] printk: Add line-buffered printk() API.
Date:   Wed, 24 Oct 2018 19:11:10 +0900
Message-Id: <1540375870-6235-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we want to print a whole line without being disturbed by
concurrent printk() from interrupts and/or other threads, for printk()
which does not end with '\n' can be disturbed.

Since mixed printk() output makes it hard to interpret, this patch
introduces API for line-buffered printk() output (so that we can make
sure that printk() ends with '\n').

Since functions introduced by this patch are merely wrapping
printk()/vprintk() calls in order to minimize possibility of using
"struct cont", it is safe to replace printk()/vprintk() with this API.
Since we want to remove "struct cont" eventually, we will try to remove
both "implicit printk() users who are expecting KERN_CONT behavior" and
"explicit pr_cont()/printk(KERN_CONT) users". Therefore, converting to
this API is recommended.

After this patch, we will consider how we can add context identifier to
each line of printk() output (so that we can group multiple lines into
one block when parsing). Therefore, if converting to this API does not
fit for some reason, you might be able to consider converting to multiple
printk() calls which end with '\n'.

Details:

  A structure named "struct printk_buffer" is introduced for buffering
  up to LOG_LINE_MAX bytes of printk() output which did not end with '\n'.

  get_printk_buffer() tries to assign a "struct printk_buffer" from
  statically preallocated array. get_printk_buffer() returns NULL if
  all "struct printk_buffer" are in use, but the caller does not need to
  check for NULL.

  put_printk_buffer() flushes and releases the "struct printk_buffer".
  put_printk_buffer() must match corresponding get_printk_buffer() as with
  rcu_read_unlock() must match corresponding rcu_read_lock().

  Three functions vprintk_buffered(), printk_buffered() and
  flush_printk_buffer() are provided for using "struct printk_buffer".
  These are like vfprintf(), fprintf(), fflush() except that these receive
  "struct printk_buffer *" for the first argument.

  vprintk_buffered() and printk_buffered() behave like vprintk() and
  printk() respectively if "struct printk_buffer *" argument is NULL.
  flush_printk_buffer() and put_printk_buffer() become no-op if
  "struct printk_buffer *" argument is NULL. Therefore, the caller of
  get_printk_buffer() does not need to check for NULL.

How to use this API:

  (1) Call get_printk_buffer() and acquire "struct printk_buffer *".

  (2) Rewrite printk() calls in the following way. The "ptr" is
      "struct printk_buffer *" obtained in step (1).

      printk(fmt, ...)     => printk_buffered(ptr, fmt, ...)
      vprintk(fmt, args)   => vprintk_buffered(ptr, fmt, args)
      pr_emerg(fmt, ...)   => bpr_emerg(ptr, fmt, ...)
      pr_alert(fmt, ...)   => bpr_alert(ptr, fmt, ...)
      pr_crit(fmt, ...)    => bpr_crit(ptr, fmt, ...)
      pr_err(fmt, ...)     => bpr_err(ptr, fmt, ...)
      pr_warning(fmt, ...) => bpr_warning(ptr, fmt, ...)
      pr_warn(fmt, ...)    => bpr_warn(ptr, fmt, ...)
      pr_notice(fmt, ...)  => bpr_notice(ptr, fmt, ...)
      pr_info(fmt, ...)    => bpr_info(ptr, fmt, ...)
      pr_cont(fmt, ...)    => bpr_cont(ptr, fmt, ...)

  (3) Release "struct printk_buffer" by calling put_printk_buffer().

Note that since "struct printk_buffer" buffers only up to one line, there
is no need to rewrite if it is known that the "struct printk_buffer" is
empty and printk() ends with '\n'.

  Good example:

    printk("Hello ");    =>  buf = get_printk_buffer();
    pr_cont("world.\n");     printk_buffered(buf, "Hello ");
                             printk_buffered(buf, "world.\n");
                             put_printk_buffer(buf);

  Pointless example:

    printk("Hello\n");   =>  buf = get_printk_buffer();
    printk("World.\n");      printk_buffered(buf, "Hello\n");
                             printk_buffered(buf, "World.\n");
                             put_printk_buffer(buf);

Somebody might forget to call put_printk_buffer(). For those who want to
debug why all buffers are in use, CONFIG_DEBUG_PRINTK_BUFFERED option is
available. This option reports when/where get_printk_buffer() was called
and put_printk_buffer() is not yet called.

Note that bpr_devel() and bpr_debug() are not defined. This is
because pr_devel()/pr_debug() should not be followed by pr_cont()
because pr_devel()/pr_debug() are conditionally enabled; output from
pr_devel()/pr_debug() should always end with '\n'.

Previous version was proposed at
https://lkml.kernel.org/r/1539405580-4569-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp .

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 include/linux/printk.h          |  38 ++++++
 kernel/printk/Makefile          |   2 +-
 kernel/printk/printk_buffered.c | 279 ++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug               |   8 ++
 4 files changed, 326 insertions(+), 1 deletion(-)
 create mode 100644 kernel/printk/printk_buffered.c

diff --git a/include/linux/printk.h b/include/linux/printk.h
index cf3eccf..3b18a7e 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -157,6 +157,7 @@ static inline void printk_nmi_direct_enter(void) { }
 static inline void printk_nmi_direct_exit(void) { }
 #endif /* PRINTK_NMI */
 
+struct printk_buffer;
 #ifdef CONFIG_PRINTK
 asmlinkage __printf(5, 0)
 int vprintk_emit(int facility, int level,
@@ -173,6 +174,13 @@ int printk_emit(int facility, int level,
 
 asmlinkage __printf(1, 2) __cold
 int printk(const char *fmt, ...);
+struct printk_buffer *get_printk_buffer(void);
+bool flush_printk_buffer(struct printk_buffer *ptr);
+__printf(2, 3)
+int printk_buffered(struct printk_buffer *ptr, const char *fmt, ...);
+__printf(2, 0)
+int vprintk_buffered(struct printk_buffer *ptr, const char *fmt, va_list args);
+void put_printk_buffer(struct printk_buffer *ptr);
 
 /*
  * Special printk facility for scheduler/timekeeping use only, _DO_NOT_USE_ !
@@ -220,6 +228,19 @@ int printk(const char *s, ...)
 {
 	return 0;
 }
+static inline struct printk_buffer *get_printk_buffer(void)
+{
+	return NULL;
+}
+static inline bool flush_printk_buffer(struct printk_buffer *ptr)
+{
+	return false;
+}
+#define printk_buffered(ptr, fmt, ...) printk(fmt, ##__VA_ARGS__)
+#define vprintk_buffered(ptr, fmt, args) vprintk(fmt, args)
+static inline void put_printk_buffer(struct printk_buffer *ptr)
+{
+}
 static inline __printf(1, 2) __cold
 int printk_deferred(const char *s, ...)
 {
@@ -330,6 +351,23 @@ static inline void printk_safe_flush_on_panic(void)
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #endif
 
+#define bpr_emerg(ptr, fmt, ...) \
+	printk_buffered(ptr, KERN_EMERG pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_alert(ptr, fmt, ...) \
+	printk_buffered(ptr, KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_crit(ptr, fmt, ...) \
+	printk_buffered(ptr, KERN_CRIT pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_err(ptr, fmt, ...) \
+	printk_buffered(ptr, KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_warning(ptr, fmt, ...) \
+	printk_buffered(ptr, KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_warn bpr_warning
+#define bpr_notice(ptr, fmt, ...) \
+	printk_buffered(ptr, KERN_NOTICE pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_info(ptr, fmt, ...) \
+	printk_buffered(ptr, KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
+#define bpr_cont(ptr, fmt, ...) \
+	printk_buffered(ptr, KERN_CONT fmt, ##__VA_ARGS__)
 
 /* If you are writing a driver, please use dev_dbg instead */
 #if defined(CONFIG_DYNAMIC_DEBUG)
diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
index 4a2ffc3..23b1547 100644
--- a/kernel/printk/Makefile
+++ b/kernel/printk/Makefile
@@ -1,3 +1,3 @@
 obj-y	= printk.o
-obj-$(CONFIG_PRINTK)	+= printk_safe.o
+obj-$(CONFIG_PRINTK)	+= printk_safe.o printk_buffered.o
 obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+= braille.o
diff --git a/kernel/printk/printk_buffered.c b/kernel/printk/printk_buffered.c
new file mode 100644
index 0000000..d29960c
--- /dev/null
+++ b/kernel/printk/printk_buffered.c
@@ -0,0 +1,279 @@
+/*
+ * printk_buffered.c - Line buffered printk() for avoiding KERN_CONT usage.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/types.h> /* DECLARE_BITMAP() */
+#include <linux/preempt.h> /* in_nmi() */
+#include <linux/workqueue.h> /* queue_work() */
+#include <linux/stacktrace.h> /* save_stack_trace() */
+#include <linux/sched.h> /* cond_resched() */
+#include <linux/printk.h>
+
+/*
+ * Should be sync with definitions in printk.c in order to avoid truncated
+ * printk() output due to limitations.
+ */
+#define PREFIX_MAX		32
+#define LOG_LINE_MAX		(1024 - PREFIX_MAX)
+
+/* A structure for line-buffered printk() output. */
+struct printk_buffer {
+	unsigned short int used; /* Valid bytes in buf[]. */
+	char buf[LOG_LINE_MAX];
+} __aligned(1024);
+
+/*
+ * Number of statically preallocated buffers.
+ *
+ * We can introduce a kernel config option if someone wants to tune this value.
+ * But since "struct printk_buffer" makes difference only when there are
+ * multiple threads concurrently calling printk() which does not end with '\n',
+ * and this API will fallback to normal printk() when all buffers are in use,
+ * it is possible that nobody needs to tune this value.
+ */
+#define NUM_LINE_BUFFERS 16
+
+static struct printk_buffer printk_buffers[NUM_LINE_BUFFERS];
+static DECLARE_BITMAP(printk_buffers_in_use, NUM_LINE_BUFFERS);
+
+#ifdef CONFIG_DEBUG_PRINTK_BUFFERED
+#define PRINTK_BUFFERS_MAX_TRACE_ENTRIES 20
+static struct {
+	unsigned long stamp;
+	struct stack_trace trace;
+	unsigned long entries[PRINTK_BUFFERS_MAX_TRACE_ENTRIES];
+} printk_buffers_dump[NUM_LINE_BUFFERS];
+static int buffer_users_report_scheduled;
+
+static void report_buffer_users(struct work_struct *work)
+{
+	long i;
+	unsigned int j;
+
+	/*
+	 * This report is racy. But it does not worth introducing a lock
+	 * dependency.
+	 */
+	pr_info("printk: All line buffers are in use.\n");
+	for (i = 0; i < NUM_LINE_BUFFERS; i++) {
+		if (!test_bit(i, printk_buffers_in_use))
+			continue;
+		pr_info("buffer[%lu] was reserved %lu jiffies ago by\n",
+			i, jiffies - printk_buffers_dump[i].stamp);
+		for (j = 0; j < printk_buffers_dump[i].trace.nr_entries; j++)
+			pr_info("  %pS\n", (void *)
+				printk_buffers_dump[i].entries[j]);
+		cond_resched();
+	}
+}
+#endif
+
+static inline void save_caller_info(const long i)
+{
+#ifdef CONFIG_DEBUG_PRINTK_BUFFERED
+	if (buffer_users_report_scheduled)
+		return;
+	printk_buffers_dump[i].stamp = jiffies;
+	printk_buffers_dump[i].trace.nr_entries = 0;
+	printk_buffers_dump[i].trace.entries = printk_buffers_dump[i].entries;
+	printk_buffers_dump[i].trace.max_entries =
+		PRINTK_BUFFERS_MAX_TRACE_ENTRIES;
+	printk_buffers_dump[i].trace.skip = 0;
+	save_stack_trace(&printk_buffers_dump[i].trace);
+#endif
+}
+
+static void dump_caller_info(void)
+{
+#ifdef CONFIG_DEBUG_PRINTK_BUFFERED
+	static DECLARE_WORK(work, report_buffer_users);
+
+	/*
+	 * Oops, out of "struct printk_buffer" happened. Fallback to normal
+	 * printk().
+	 *
+	 * If you think that it might be due to missing put_printk_buffer()
+	 * calls, you can enable CONFIG_DEBUG_PRINTK_BUFFERED.
+	 * Then, who is using the buffers will be reported (from workqueue
+	 * context because reporting NUM_LINE_BUFFERS entries
+	 * from atomic context might be too slow). If it does not look like
+	 * missing put_printk_buffer() calls, you might want to increase
+	 * NUM_LINE_BUFFERS.
+	 *
+	 * But if it turns out that allocating "struct printk_buffer" on stack
+	 * or in .bss section or from kzalloc() is more suitable than tuning
+	 * NUM_LINE_BUFFERS, we can update to do so.
+	 */
+	if (!in_nmi() && !cmpxchg(&buffer_users_report_scheduled, 0, 1))
+		queue_work(system_unbound_wq, &work);
+#elif defined(CONFIG_STACKTRACE)
+	printk_once("Out of printk buffers. Please consider CONFIG_DEBUG_PRINTK_BUFFERED=y\n");
+#endif
+}
+
+/**
+ * get_printk_buffer - Try to get printk_buffer.
+ *
+ * Returns pointer to "struct printk_buffer" on success, NULL otherwise.
+ *
+ * If this function returned "struct printk_buffer", the caller is responsible
+ * for passing it to put_printk_buffer() so that "struct printk_buffer" can be
+ * reused in the future.
+ *
+ * Even if this function returned NULL, the caller does not need to check for
+ * NULL, for passing NULL to printk_buffered() simply acts like normal printk()
+ * and passing NULL to flush_printk_buffer()/put_printk_buffer() is a no-op.
+ */
+struct printk_buffer *get_printk_buffer(void)
+{
+	long i;
+
+	for (i = 0; i < NUM_LINE_BUFFERS; i++) {
+		if (test_and_set_bit_lock(i, printk_buffers_in_use))
+			continue;
+		printk_buffers[i].used = 0;
+		save_caller_info(i);
+		return &printk_buffers[i];
+	}
+	dump_caller_info();
+	return NULL;
+}
+EXPORT_SYMBOL(get_printk_buffer);
+
+/**
+ * vprintk_buffered - Try to vprintk() in line buffered mode.
+ *
+ * @ptr:  Pointer to "struct printk_buffer". It can be NULL.
+ * @fmt:  printk() format string.
+ * @args: va_list structure.
+ *
+ * Returns the return value of vprintk().
+ *
+ * Try to store to @ptr first. If it fails, flush @ptr and then try to store to
+ * @ptr again. If it still fails, use unbuffered printing.
+ */
+int vprintk_buffered(struct printk_buffer *ptr, const char *fmt, va_list args)
+{
+	va_list tmp_args;
+	int fmt_offset;
+	int r;
+
+	if (!ptr)
+		goto unbuffered;
+	/*
+	 * Skip KERN_CONT here based on an assumption that KERN_CONT will be
+	 * given via "fmt" argument when KERN_CONT is given.
+	 */
+	fmt_offset = (printk_get_level(fmt) == 'c') ? 2 : 0;
+ retry:
+	va_copy(tmp_args, args);
+	r = vsnprintf(ptr->buf + ptr->used, sizeof(ptr->buf) - ptr->used,
+		      fmt + fmt_offset, tmp_args);
+	va_end(tmp_args);
+	if (r + ptr->used < sizeof(ptr->buf)) {
+		ptr->used += r;
+		/* Flush already completed lines if any. */
+		for (r = ptr->used - 1; r >= 0; r--) {
+			if (ptr->buf[r] != '\n')
+				continue;
+			ptr->buf[r++] = '\0';
+			printk("%s\n", ptr->buf);
+			ptr->used -= r;
+			memmove(ptr->buf, ptr->buf + r, ptr->used);
+			break;
+		}
+		return r;
+	}
+	/*
+	 * Since this "ptr" is dedicated to the caller, there is no possibility
+	 * of retrying more than once in one vprintk_buffered() call.
+	 */
+	if (flush_printk_buffer(ptr))
+		goto retry;
+ unbuffered:
+	return vprintk(fmt, args);
+}
+
+/**
+ * printk_buffered - Try to printk() in line buffered mode.
+ *
+ * @ptr: Pointer to "struct printk_buffer". It can be NULL.
+ * @fmt: printk() format string, followed by arguments.
+ *
+ * Returns the return value of printk().
+ *
+ * Try to store to @ptr first. If it fails, flush @ptr and then try to store to
+ * @ptr again. If it still fails, use unbuffered printing.
+ */
+int printk_buffered(struct printk_buffer *ptr, const char *fmt, ...)
+{
+	va_list args;
+	int r;
+
+	va_start(args, fmt);
+	r = vprintk_buffered(ptr, fmt, args);
+	va_end(args);
+	return r;
+}
+EXPORT_SYMBOL(printk_buffered);
+
+/**
+ * flush_printk_buffer - Flush incomplete line in printk_buffer.
+ *
+ * @ptr: Pointer to "struct printk_buffer". It can be NULL.
+ *
+ * Returns true if flushed something, false otherwise.
+ *
+ * Flush if @ptr contains partial data. But usually there is no need to call
+ * this function because @ptr is flushed by put_printk_buffer().
+ */
+bool flush_printk_buffer(struct printk_buffer *ptr)
+{
+	if (!ptr || !ptr->used)
+		return false;
+	/* vprintk_buffered() keeps 0 <= ptr->used < sizeof(ptr->buf) true. */
+	ptr->buf[ptr->used] = '\0';
+	printk("%s", ptr->buf);
+	ptr->used = 0;
+	return true;
+}
+EXPORT_SYMBOL(flush_printk_buffer);
+
+/**
+ * put_printk_buffer - Release printk_buffer.
+ *
+ * @ptr: Pointer to "struct printk_buffer". It can be NULL.
+ *
+ * Returns nothing.
+ *
+ * Flush and release @ptr.
+ */
+void put_printk_buffer(struct printk_buffer *ptr)
+{
+	long i = (unsigned long) ptr - (unsigned long) printk_buffers;
+
+	if (!ptr)
+		return;
+	if (WARN_ON_ONCE(i % sizeof(struct printk_buffer)))
+		return;
+	i /= sizeof(struct printk_buffer);
+	if (WARN_ON_ONCE(i < 0 || i >= NUM_LINE_BUFFERS))
+		return;
+	if (ptr->used)
+		flush_printk_buffer(ptr);
+	clear_bit_unlock(i, printk_buffers_in_use);
+}
+EXPORT_SYMBOL(put_printk_buffer);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8d24f4e..6b192ec 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -146,6 +146,14 @@ config DYNAMIC_DEBUG
 	  See Documentation/admin-guide/dynamic-debug-howto.rst for additional
 	  information.
 
+config DEBUG_PRINTK_BUFFERED
+	bool "Debug statically preallocated line buffers"
+	default n
+	depends on PRINTK && STACKTRACE
+	help
+	  Select this if you want to know who is using statically preallocated
+	  "struct printk_buffer" when out of "struct printk_buffer" happened.
+
 endmenu # "printk and dmesg options"
 
 menu "Compile-time checks and compiler options"
-- 
1.8.3.1

