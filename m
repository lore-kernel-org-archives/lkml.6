Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933595AbeBMH2o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:28:44 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933481AbeBMH2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:28:42 -0500
Date: Tue, 13 Feb 2018 15:28:34 +0800
From: Dave Young <dyoung@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v2] printk: move dump stack related code to lib/dump_stack.c
Message-ID: <20180213072834.GA24784@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dump_stack related stuff should belong to lib/dump_stack.c thus move them
there. Also conditionally compile lib/dump_stack.c since dump_stack code
does not make sense if printk is disabled.

Signed-off-by: Dave Young <dyoung@redhat.com>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
---
Note: dump stack etc still share printk.h as before, I would keep it as is
since a lot of files need it.
 include/linux/printk.h |    7 ++++-
 kernel/printk/printk.c |   60 -------------------------------------------------
 lib/Makefile           |    3 +-
 lib/dump_stack.c       |   60 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 63 deletions(-)

--- linux-x86.orig/kernel/printk/printk.c
+++ linux-x86/kernel/printk/printk.c
@@ -42,13 +42,11 @@
 #include <linux/rculist.h>
 #include <linux/poll.h>
 #include <linux/irq_work.h>
-#include <linux/utsname.h>
 #include <linux/ctype.h>
 #include <linux/uio.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
-#include <linux/kexec.h>
 
 #include <linux/uaccess.h>
 #include <asm/sections.h>
@@ -3257,62 +3255,4 @@ void kmsg_dump_rewind(struct kmsg_dumper
 }
 EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 
-static char dump_stack_arch_desc_str[128];
-
-/**
- * dump_stack_set_arch_desc - set arch-specific str to show with task dumps
- * @fmt: printf-style format string
- * @...: arguments for the format string
- *
- * The configured string will be printed right after utsname during task
- * dumps.  Usually used to add arch-specific system identifiers.  If an
- * arch wants to make use of such an ID string, it should initialize this
- * as soon as possible during boot.
- */
-void __init dump_stack_set_arch_desc(const char *fmt, ...)
-{
-	va_list args;
-
-	va_start(args, fmt);
-	vsnprintf(dump_stack_arch_desc_str, sizeof(dump_stack_arch_desc_str),
-		  fmt, args);
-	va_end(args);
-}
-
-/**
- * dump_stack_print_info - print generic debug info for dump_stack()
- * @log_lvl: log level
- *
- * Arch-specific dump_stack() implementations can use this function to
- * print out the same debug information as the generic dump_stack().
- */
-void dump_stack_print_info(const char *log_lvl)
-{
-	printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s\n",
-	       log_lvl, raw_smp_processor_id(), current->pid, current->comm,
-	       kexec_crash_loaded() ? "Kdump: loaded " : "",
-	       print_tainted(),
-	       init_utsname()->release,
-	       (int)strcspn(init_utsname()->version, " "),
-	       init_utsname()->version);
-
-	if (dump_stack_arch_desc_str[0] != '\0')
-		printk("%sHardware name: %s\n",
-		       log_lvl, dump_stack_arch_desc_str);
-
-	print_worker_info(log_lvl, current);
-}
-
-/**
- * show_regs_print_info - print generic debug info for show_regs()
- * @log_lvl: log level
- *
- * show_regs() implementations can use this function to print out generic
- * debug information.
- */
-void show_regs_print_info(const char *log_lvl)
-{
-	dump_stack_print_info(log_lvl);
-}
-
 #endif
--- linux-x86.orig/lib/dump_stack.c
+++ linux-x86/lib/dump_stack.c
@@ -10,6 +10,66 @@
 #include <linux/sched/debug.h>
 #include <linux/smp.h>
 #include <linux/atomic.h>
+#include <linux/kexec.h>
+#include <linux/utsname.h>
+
+static char dump_stack_arch_desc_str[128];
+
+/**
+ * dump_stack_set_arch_desc - set arch-specific str to show with task dumps
+ * @fmt: printf-style format string
+ * @...: arguments for the format string
+ *
+ * The configured string will be printed right after utsname during task
+ * dumps.  Usually used to add arch-specific system identifiers.  If an
+ * arch wants to make use of such an ID string, it should initialize this
+ * as soon as possible during boot.
+ */
+void __init dump_stack_set_arch_desc(const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vsnprintf(dump_stack_arch_desc_str, sizeof(dump_stack_arch_desc_str),
+		  fmt, args);
+	va_end(args);
+}
+
+/**
+ * dump_stack_print_info - print generic debug info for dump_stack()
+ * @log_lvl: log level
+ *
+ * Arch-specific dump_stack() implementations can use this function to
+ * print out the same debug information as the generic dump_stack().
+ */
+void dump_stack_print_info(const char *log_lvl)
+{
+	printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s\n",
+	       log_lvl, raw_smp_processor_id(), current->pid, current->comm,
+	       kexec_crash_loaded() ? "Kdump: loaded " : "",
+	       print_tainted(),
+	       init_utsname()->release,
+	       (int)strcspn(init_utsname()->version, " "),
+	       init_utsname()->version);
+
+	if (dump_stack_arch_desc_str[0] != '\0')
+		printk("%sHardware name: %s\n",
+		       log_lvl, dump_stack_arch_desc_str);
+
+	print_worker_info(log_lvl, current);
+}
+
+/**
+ * show_regs_print_info - print generic debug info for show_regs()
+ * @log_lvl: log level
+ *
+ * show_regs() implementations can use this function to print out generic
+ * debug information.
+ */
+void show_regs_print_info(const char *log_lvl)
+{
+	dump_stack_print_info(log_lvl);
+}
 
 static void __dump_stack(void)
 {
--- linux-x86.orig/include/linux/printk.h
+++ linux-x86/include/linux/printk.h
@@ -201,6 +201,7 @@ void __init setup_log_buf(int early);
 __printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...);
 void dump_stack_print_info(const char *log_lvl);
 void show_regs_print_info(const char *log_lvl);
+extern asmlinkage void dump_stack(void) __cold;
 extern void printk_safe_init(void);
 extern void printk_safe_flush(void);
 extern void printk_safe_flush_on_panic(void);
@@ -264,6 +265,10 @@ static inline void show_regs_print_info(
 {
 }
 
+static inline asmlinkage void dump_stack(void)
+{
+}
+
 static inline void printk_safe_init(void)
 {
 }
@@ -279,8 +284,6 @@ static inline void printk_safe_flush_on_
 
 extern int kptr_restrict;
 
-extern asmlinkage void dump_stack(void) __cold;
-
 #ifndef pr_fmt
 #define pr_fmt(fmt) fmt
 #endif
--- linux-x86.orig/lib/Makefile
+++ linux-x86/lib/Makefile
@@ -18,7 +18,7 @@ KCOV_INSTRUMENT_debugobjects.o := n
 KCOV_INSTRUMENT_dynamic_debug.o := n
 
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
-	 rbtree.o radix-tree.o dump_stack.o timerqueue.o\
+	 rbtree.o radix-tree.o timerqueue.o\
 	 idr.o int_sqrt.o extable.o \
 	 sha1.o chacha20.o irq_regs.o argv_split.o \
 	 flex_proportions.o ratelimit.o show_mem.o \
@@ -26,6 +26,7 @@ lib-y := ctype.o string.o vsprintf.o cmd
 	 earlycpio.o seq_buf.o siphash.o \
 	 nmi_backtrace.o nodemask.o win_minmax.o
 
+lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_MMU) += ioremap.o
 lib-$(CONFIG_SMP) += cpumask.o
 lib-$(CONFIG_DMA_DIRECT_OPS) += dma-direct.o
