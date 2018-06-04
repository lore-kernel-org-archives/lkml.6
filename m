Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbeFDQtL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:49:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37490 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbeFDQtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:49:09 -0400
X-Google-Smtp-Source: ADUXVKIfZ19/eMEs4ks6BUacIrg+oQcLhr/fhkvJdsWRjLE+UC4Mh3QYHQSxp9v1cBtzRyAJIF6NxQ==
Date: Mon, 4 Jun 2018 18:49:05 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/debug changes for v4.18
Message-ID: <20180604164905.GA31538@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-debug-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-debug-for-linus

   # HEAD: 4dba072cd097f35fa8f77c49d909ada2b079a4c4 x86/dumpstack: Explain the reasoning for the prologue and buffer size

This tree contains the x86 oops code printing reorganization and cleanups from 
Borislav Betkov, with a particular focus in enhancing opcode dumping all around.

 Thanks,

	Ingo

------------------>
Borislav Petkov (9):
      x86/dumpstack: Remove code_bytes
      x86/dumpstack: Unexport oops_begin()
      x86/dumpstack: Carve out code-dumping into a function
      x86/dumpstack: Improve opcodes dumping in the code section
      x86/dumpstack: Add loglevel argument to show_opcodes()
      x86/fault: Dump user opcode bytes on fatal faults
      x86/dumpstack: Add a show_ip() function
      x86/dumpstack: Save first regs set for the executive summary
      x86/dumpstack: Explain the reasoning for the prologue and buffer size


 Documentation/admin-guide/kernel-parameters.txt |   5 -
 arch/x86/include/asm/stacktrace.h               |   2 +
 arch/x86/kernel/dumpstack.c                     | 144 ++++++++++++------------
 arch/x86/kernel/process_32.c                    |   8 +-
 arch/x86/mm/fault.c                             |   7 +-
 5 files changed, 80 insertions(+), 86 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11fc28ecdb6d..47aa554e41b7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -587,11 +587,6 @@
 			Sets the size of memory pool for coherent, atomic dma
 			allocations, by default set to 256K.
 
-	code_bytes	[X86] How many bytes of object code to print
-			in an oops report.
-			Range: 0 - 8192
-			Default: 64
-
 	com20020=	[HW,NET] ARCnet - COM20020 chipset
 			Format:
 			<io>[,<irq>[,<nodeID>[,<backplane>[,<ckp>[,<timeout>]]]]]
diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index 133d9425fced..b6dc698f992a 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -111,4 +111,6 @@ static inline unsigned long caller_frame_pointer(void)
 	return (unsigned long)frame;
 }
 
+void show_opcodes(u8 *rip, const char *loglvl);
+void show_ip(struct pt_regs *regs, const char *loglvl);
 #endif /* _ASM_X86_STACKTRACE_H */
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 18fa9d74c182..666a284116ac 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -22,11 +22,14 @@
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
 
+#define OPCODE_BUFSIZE 64
+
 int panic_on_unrecovered_nmi;
 int panic_on_io_nmi;
-static unsigned int code_bytes = 64;
 static int die_counter;
 
+static struct pt_regs exec_summary_regs;
+
 bool in_task_stack(unsigned long *stack, struct task_struct *task,
 		   struct stack_info *info)
 {
@@ -69,9 +72,62 @@ static void printk_stack_address(unsigned long address, int reliable,
 	printk("%s %s%pB\n", log_lvl, reliable ? "" : "? ", (void *)address);
 }
 
+/*
+ * There are a couple of reasons for the 2/3rd prologue, courtesy of Linus:
+ *
+ * In case where we don't have the exact kernel image (which, if we did, we can
+ * simply disassemble and navigate to the RIP), the purpose of the bigger
+ * prologue is to have more context and to be able to correlate the code from
+ * the different toolchains better.
+ *
+ * In addition, it helps in recreating the register allocation of the failing
+ * kernel and thus make sense of the register dump.
+ *
+ * What is more, the additional complication of a variable length insn arch like
+ * x86 warrants having longer byte sequence before rIP so that the disassembler
+ * can "sync" up properly and find instruction boundaries when decoding the
+ * opcode bytes.
+ *
+ * Thus, the 2/3rds prologue and 64 byte OPCODE_BUFSIZE is just a random
+ * guesstimate in attempt to achieve all of the above.
+ */
+void show_opcodes(u8 *rip, const char *loglvl)
+{
+	unsigned int code_prologue = OPCODE_BUFSIZE * 2 / 3;
+	u8 opcodes[OPCODE_BUFSIZE];
+	u8 *ip;
+	int i;
+
+	printk("%sCode: ", loglvl);
+
+	ip = (u8 *)rip - code_prologue;
+	if (probe_kernel_read(opcodes, ip, OPCODE_BUFSIZE)) {
+		pr_cont("Bad RIP value.\n");
+		return;
+	}
+
+	for (i = 0; i < OPCODE_BUFSIZE; i++, ip++) {
+		if (ip == rip)
+			pr_cont("<%02x> ", opcodes[i]);
+		else
+			pr_cont("%02x ", opcodes[i]);
+	}
+	pr_cont("\n");
+}
+
+void show_ip(struct pt_regs *regs, const char *loglvl)
+{
+#ifdef CONFIG_X86_32
+	printk("%sEIP: %pS\n", loglvl, (void *)regs->ip);
+#else
+	printk("%sRIP: %04x:%pS\n", loglvl, (int)regs->cs, (void *)regs->ip);
+#endif
+	show_opcodes((u8 *)regs->ip, loglvl);
+}
+
 void show_iret_regs(struct pt_regs *regs)
 {
-	printk(KERN_DEFAULT "RIP: %04x:%pS\n", (int)regs->cs, (void *)regs->ip);
+	show_ip(regs, KERN_DEFAULT);
 	printk(KERN_DEFAULT "RSP: %04x:%016lx EFLAGS: %08lx", (int)regs->ss,
 		regs->sp, regs->flags);
 }
@@ -267,7 +323,6 @@ unsigned long oops_begin(void)
 	bust_spinlocks(1);
 	return flags;
 }
-EXPORT_SYMBOL_GPL(oops_begin);
 NOKPROBE_SYMBOL(oops_begin);
 
 void __noreturn rewind_stack_do_exit(int signr);
@@ -287,6 +342,9 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	raw_local_irq_restore(flags);
 	oops_exit();
 
+	/* Executive summary in case the oops scrolled away */
+	__show_regs(&exec_summary_regs, true);
+
 	if (!signr)
 		return;
 	if (in_interrupt())
@@ -305,10 +363,10 @@ NOKPROBE_SYMBOL(oops_end);
 
 int __die(const char *str, struct pt_regs *regs, long err)
 {
-#ifdef CONFIG_X86_32
-	unsigned short ss;
-	unsigned long sp;
-#endif
+	/* Save the regs of the first oops for the executive summary later. */
+	if (!die_counter)
+		exec_summary_regs = *regs;
+
 	printk(KERN_DEFAULT
 	       "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff, ++die_counter,
 	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT"         : "",
@@ -318,26 +376,13 @@ int __die(const char *str, struct pt_regs *regs, long err)
 	       IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION) ?
 	       (boot_cpu_has(X86_FEATURE_PTI) ? " PTI" : " NOPTI") : "");
 
+	show_regs(regs);
+	print_modules();
+
 	if (notify_die(DIE_OOPS, str, regs, err,
 			current->thread.trap_nr, SIGSEGV) == NOTIFY_STOP)
 		return 1;
 
-	print_modules();
-	show_regs(regs);
-#ifdef CONFIG_X86_32
-	if (user_mode(regs)) {
-		sp = regs->sp;
-		ss = regs->ss;
-	} else {
-		sp = kernel_stack_pointer(regs);
-		savesegment(ss, ss);
-	}
-	printk(KERN_EMERG "EIP: %pS SS:ESP: %04x:%08lx\n",
-	       (void *)regs->ip, ss, sp);
-#else
-	/* Executive summary in case the oops scrolled away */
-	printk(KERN_ALERT "RIP: %pS RSP: %016lx\n", (void *)regs->ip, regs->sp);
-#endif
 	return 0;
 }
 NOKPROBE_SYMBOL(__die);
@@ -356,30 +401,9 @@ void die(const char *str, struct pt_regs *regs, long err)
 	oops_end(flags, regs, sig);
 }
 
-static int __init code_bytes_setup(char *s)
-{
-	ssize_t ret;
-	unsigned long val;
-
-	if (!s)
-		return -EINVAL;
-
-	ret = kstrtoul(s, 0, &val);
-	if (ret)
-		return ret;
-
-	code_bytes = val;
-	if (code_bytes > 8192)
-		code_bytes = 8192;
-
-	return 1;
-}
-__setup("code_bytes=", code_bytes_setup);
-
 void show_regs(struct pt_regs *regs)
 {
 	bool all = true;
-	int i;
 
 	show_regs_print_info(KERN_DEFAULT);
 
@@ -389,36 +413,8 @@ void show_regs(struct pt_regs *regs)
 	__show_regs(regs, all);
 
 	/*
-	 * When in-kernel, we also print out the stack and code at the
-	 * time of the fault..
+	 * When in-kernel, we also print out the stack at the time of the fault..
 	 */
-	if (!user_mode(regs)) {
-		unsigned int code_prologue = code_bytes * 43 / 64;
-		unsigned int code_len = code_bytes;
-		unsigned char c;
-		u8 *ip;
-
+	if (!user_mode(regs))
 		show_trace_log_lvl(current, regs, NULL, KERN_DEFAULT);
-
-		printk(KERN_DEFAULT "Code: ");
-
-		ip = (u8 *)regs->ip - code_prologue;
-		if (ip < (u8 *)PAGE_OFFSET || probe_kernel_address(ip, c)) {
-			/* try starting at IP */
-			ip = (u8 *)regs->ip;
-			code_len = code_len - code_prologue + 1;
-		}
-		for (i = 0; i < code_len; i++, ip++) {
-			if (ip < (u8 *)PAGE_OFFSET ||
-					probe_kernel_address(ip, c)) {
-				pr_cont(" Bad RIP value.");
-				break;
-			}
-			if (ip == (u8 *)regs->ip)
-				pr_cont("<%02x> ", c);
-			else
-				pr_cont("%02x ", c);
-		}
-	}
-	pr_cont("\n");
 }
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 5224c6099184..0ae659de21eb 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -76,16 +76,14 @@ void __show_regs(struct pt_regs *regs, int all)
 		savesegment(gs, gs);
 	}
 
-	printk(KERN_DEFAULT "EIP: %pS\n", (void *)regs->ip);
-	printk(KERN_DEFAULT "EFLAGS: %08lx CPU: %d\n", regs->flags,
-		raw_smp_processor_id());
+	show_ip(regs, KERN_DEFAULT);
 
 	printk(KERN_DEFAULT "EAX: %08lx EBX: %08lx ECX: %08lx EDX: %08lx\n",
 		regs->ax, regs->bx, regs->cx, regs->dx);
 	printk(KERN_DEFAULT "ESI: %08lx EDI: %08lx EBP: %08lx ESP: %08lx\n",
 		regs->si, regs->di, regs->bp, sp);
-	printk(KERN_DEFAULT " DS: %04x ES: %04x FS: %04x GS: %04x SS: %04x\n",
-	       (u16)regs->ds, (u16)regs->es, (u16)regs->fs, gs, ss);
+	printk(KERN_DEFAULT "DS: %04x ES: %04x FS: %04x GS: %04x SS: %04x EFLAGS: %08lx\n",
+	       (u16)regs->ds, (u16)regs->es, (u16)regs->fs, gs, ss, regs->flags);
 
 	if (!all)
 		return;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 73bd8c95ac71..a3fd94eff04d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -828,6 +828,8 @@ static inline void
 show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 		unsigned long address, struct task_struct *tsk)
 {
+	const char *loglvl = task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG;
+
 	if (!unhandled_signal(tsk, SIGSEGV))
 		return;
 
@@ -835,13 +837,14 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 		return;
 
 	printk("%s%s[%d]: segfault at %lx ip %px sp %px error %lx",
-		task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG,
-		tsk->comm, task_pid_nr(tsk), address,
+		loglvl, tsk->comm, task_pid_nr(tsk), address,
 		(void *)regs->ip, (void *)regs->sp, error_code);
 
 	print_vma_addr(KERN_CONT " in ", regs->ip);
 
 	printk(KERN_CONT "\n");
+
+	show_opcodes((u8 *)regs->ip, loglvl);
 }
 
 static void
