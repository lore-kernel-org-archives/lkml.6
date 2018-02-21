Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938466AbeBURyt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:54:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54506 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934039AbeBURyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:54:45 -0500
Date: Wed, 21 Feb 2018 18:54:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] x86/dumpstack: Cleanups and user opcode bytes Code:
 section
Message-ID: <20180221175429.GC9989@pd.tnic>
References: <20180219202826.19797-1-bp@alien8.de>
 <CALCETrXgT0rLLziiOnv51tZioJ2bNKc1eNniu46dDOvW5=PxYQ@mail.gmail.com>
 <20180220192956.si2a6m3ckskexvte@treble>
 <20180220204435.GC24320@pd.tnic>
 <20180221091553.gxnvhbitiewo2mjc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180221091553.gxnvhbitiewo2mjc@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 10:15:53AM +0100, Ingo Molnar wrote:
> That looks really useful!

Ok, lemme run it by Linus too as he probably stares at this part of the
output a *lot* :-)

Combined patch at the end. I'll split it later.

@Linus: also, pls have a look at
https://lkml.kernel.org/r/20180219202826.19797-6-bp@alien8.de

I've added Code: section to user faults too because there might be
some usefulness in seeing the user opcode bytes when it faults. Some
arguments in the commit message there.

Anyway, here's a 64-bit splat. I'm basically dumping opcode bytes
everytime we dump RIP.

[   18.304872] sysrq: SysRq : Trigger a crash
[   18.306961] BUG: unable to handle kernel NULL pointer dereference at           (null)
[   18.310702] IP: sysrq_handle_crash+0x17/0x20
[   18.312830] PGD 7a972067 P4D 7a972067 PUD 7a351067 PMD 0 
[   18.316431] Oops: 0002 [#1] PREEMPT SMP
[   18.317219] Modules linked in:
[   18.317865] CPU: 6 PID: 3681 Comm: bash Not tainted 4.16.0-rc1+ #14
[   18.319237] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   18.321162] RIP: 0010:sysrq_handle_crash+0x17/0x20
[   18.322273] RSP: 0018:ffffc90000c23df0 EFLAGS: 00010246
[   18.322274] Code: eb d1 e8 fd ca b6 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e8 f6 de bc ff c7 05 84 0d 1a 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 86 df c1 ff fb 66 
[   18.331362] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 0000000000000000
[   18.332660] RDX: 0000000000000000 RSI: ffffffff81103293 RDI: 0000000000000063
[   18.333931] RBP: ffffffff82271880 R08: 00000000000001a4 R09: 000000000004a6e8
[   18.335209] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000a
[   18.336874] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   18.338732] FS:  00007ffff7fdb700(0000) GS:ffff88007ed80000(0000) knlGS:0000000000000000
[   18.344827] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   18.346395] CR2: 0000000000000000 CR3: 000000007c39e000 CR4: 00000000000406e0
[   18.348205] Call Trace:
[   18.348905]  __handle_sysrq+0x9e/0x160
[   18.349835]  write_sysrq_trigger+0x2b/0x30
[   18.350827]  proc_reg_write+0x38/0x70
[   18.351747]  __vfs_write+0x36/0x160
[   18.356573]  ? __fd_install+0x69/0x110
[   18.357516]  ? preempt_count_add+0x74/0xb0
[   18.358509]  ? _raw_spin_lock+0x13/0x30
[   18.359454]  ? set_close_on_exec+0x41/0x80
[   18.360468]  ? preempt_count_sub+0xa8/0x100
[   18.361476]  vfs_write+0xc0/0x190
[   18.362327]  SyS_write+0x64/0xe0
[   18.363162]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   18.364269]  do_syscall_64+0x76/0x140
[   18.368969]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[   18.370390] RIP: 0033:0x7ffff74b9620
[   18.371479] RSP: 002b:00007fffffffe7a8 EFLAGS: 00000246
[   18.371481] Code: ff 73 01 c3 48 8b 0d 68 98 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d bd f1 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ce 8f 01 00 48 89 04 
[   18.377743]  ORIG_RAX: 0000000000000001
[   18.381942] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ffff74b9620
[   18.383212] RDX: 0000000000000002 RSI: 0000000000705408 RDI: 0000000000000001
[   18.384490] RBP: 0000000000705408 R08: 000000000000000a R09: 00007ffff7fdb700
[   18.385759] R10: 00007ffff77826a0 R11: 0000000000000246 R12: 00007ffff77842a0
[   18.387024] R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000
[   18.388437] RIP: 0010:sysrq_handle_crash+0x17/0x20
[   18.389550] RSP: 0018:ffffc90000c23df0 EFLAGS: 00010246
[   18.389550] Code: eb d1 e8 fd ca b6 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e8 f6 de bc ff c7 05 84 0d 1a 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 86 df c1 ff fb 66 
[   18.398707] CR2: 0000000000000000
[   18.399864] ---[ end trace e17dc9a4aa5cc4d9 ]---
[   18.401351] Kernel panic - not syncing: Fatal exception
[   18.401678] Kernel Offset: disabled
[   18.408342] ---[ end Kernel panic - not syncing: Fatal exception

32-bit, respectively:

[   20.992127] sysrq: SysRq : Trigger a crash
[   20.994364] BUG: unable to handle kernel NULL pointer dereference at   (null)
[   20.997892] IP: sysrq_handle_crash+0x1d/0x30
[   20.999807] *pde = 00000000 
[   21.000512] Oops: 0002 [#1] PREEMPT SMP
[   21.007170] Modules linked in:
[   21.008299] CPU: 4 PID: 2079 Comm: bash Not tainted 4.16.0-rc1+ #18
[   21.022652] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   21.024480] EIP: sysrq_handle_crash+0x1d/0x30 SS:ESP: 0068:f3f21e8c
[   21.026929] Code: bf ff eb d6 e8 35 eb b9 ff 90 8d 74 26 00 0f 1f 44 00 00 55 89 e5 e8 d3 dd bf ff c7 05 b4 ba c3 c1 01 00 00 00 0f ae f8 0f 1f 00 <c6> 05 00 00 00 00 01 5d c3 8d 76 00 8d bc 27 00 00 00 00 0f 1f 
[   21.037904] EAX: 00000000 EBX: 0000000a ECX: 00000000 EDX: c1505fe0
[   21.039740] ESI: 00000063 EDI: 00000000 EBP: f3f21e8c ESP: f3f21e8c
[   21.041575]  DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
[   21.043233] CR0: 80050033 CR2: 00000000 CR3: 33e6c000 CR4: 000406d0
[   21.049620] Call Trace:
[   21.050286]  __handle_sysrq+0x93/0x130
[   21.051167]  ? sysrq_filter+0x3c0/0x3c0
[   21.052053]  write_sysrq_trigger+0x27/0x40
[   21.052977]  proc_reg_write+0x4d/0x80
[   21.053939]  ? proc_reg_poll+0x70/0x70
[   21.055209]  __vfs_write+0x38/0x160
[   21.056433]  ? preempt_count_sub+0xa0/0x110
[   21.057805]  ? __fd_install+0x51/0xd0
[   21.063481]  ? __sb_start_write+0x4c/0xc0
[   21.064811]  ? preempt_count_sub+0xa0/0x110
[   21.066193]  vfs_write+0x98/0x180
[   21.067371]  SyS_write+0x4f/0xb0
[   21.068592]  do_fast_syscall_32+0x9e/0x210
[   21.069946]  entry_SYSENTER_32+0x53/0x86
[   21.071257] EIP: 0xb7fccce9 SS:ESP: 007b:bfa15fc0
[   21.072733] Code: 55 08 8b 80 64 cd ff ff 85 d2 74 02 89 02 5d c3 8b 04 24 c3 8b 0c 24 c3 8b 1c 24 c3 8b 3c 24 c3 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 
[   21.081472] EAX: ffffffda EBX: 00000001 ECX: 081e8a08 EDX: 00000002
[   21.081474] ESI: 00000002 EDI: b7f97d80 EBP: 081e8a08 ESP: bfa15fc0
[   21.081476]  DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b
[   21.081482] EIP: sysrq_handle_crash+0x1d/0x30 SS:ESP: 0068:f3f21e8c
[   21.081483] Code: bf ff eb d6 e8 35 eb b9 ff 90 8d 74 26 00 0f 1f 44 00 00 55 89 e5 e8 d3 dd bf ff c7 05 b4 ba c3 c1 01 00 00 00 0f ae f8 0f 1f 00 <c6> 05 00 00 00 00 01 5d c3 8d 76 00 8d bc 27 00 00 00 00 0f 1f 
[   21.104318] CR2: 0000000000000000
[   21.105155] ---[ end trace 7a104a17e091751a ]---
[   21.106160] Kernel panic - not syncing: Fatal exception
[   21.106479] Kernel Offset: disabled
[   21.108329] ---[ end Kernel panic - not syncing: Fatal exception

Combined diff ontop:

---
diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index 0630eeb18bbc..b6dc698f992a 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -112,4 +112,5 @@ static inline unsigned long caller_frame_pointer(void)
 }
 
 void show_opcodes(u8 *rip, const char *loglvl);
+void show_ip(struct pt_regs *regs, const char *loglvl);
 #endif /* _ASM_X86_STACKTRACE_H */
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 3d595e4cf280..b60232d9969b 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -73,14 +73,56 @@ static void printk_stack_address(unsigned long address, int reliable,
 	printk("%s %s%pB\n", log_lvl, reliable ? "" : "? ", (void *)address);
 }
 
-void show_opcodes(u8 *rip, const char *loglvl);
+void show_opcodes(u8 *rip, const char *loglvl)
+{
+	unsigned int code_prologue = code_bytes * 43 / OPCODE_BUFSIZE;
+	u8 *ip;
+	int i;
 
-void show_iret_regs(struct pt_regs *regs)
+	printk("%sCode: ", loglvl);
+
+	ip = (u8 *)rip - code_prologue;
+	if (probe_kernel_read(opcodes, ip, code_bytes)) {
+		pr_cont(" Bad RIP value.\n");
+		return;
+	}
+
+	for (i = 0; i < code_bytes; i++, ip++) {
+		if (ip == (u8 *)rip)
+			pr_cont("<%02x> ", opcodes[i]);
+		else
+			pr_cont("%02x ", opcodes[i]);
+	}
+	pr_cont("\n");
+}
+
+void show_ip(struct pt_regs *regs, const char *loglvl)
 {
-	printk(KERN_DEFAULT "RIP: %04x:%pS\n", (int)regs->cs, (void *)regs->ip);
-	printk(KERN_DEFAULT "RSP: %04x:%016lx EFLAGS: %08lx", (int)regs->ss,
+#ifdef CONFIG_X86_32
+	unsigned short ss;
+	unsigned long sp;
+
+	if (user_mode(regs)) {
+		sp = regs->sp;
+		ss = regs->ss;
+	} else {
+		sp = kernel_stack_pointer(regs);
+		savesegment(ss, ss);
+	}
+
+	printk("%sEIP: %pS SS:ESP: %04x:%08lx\n", loglvl, (void *)regs->ip, ss, sp);
+#else
+	printk("%sRIP: %04x:%pS\n", loglvl, (int)regs->cs, (void *)regs->ip);
+	printk("%sRSP: %04x:%016lx EFLAGS: %08lx", loglvl, (int)regs->ss,
 		regs->sp, regs->flags);
-	show_opcodes((u8 *)regs->ip, KERN_DEFAULT);
+#endif
+
+	show_opcodes((u8 *)regs->ip, loglvl);
+}
+
+void show_iret_regs(struct pt_regs *regs)
+{
+	show_ip(regs, KERN_DEFAULT);
 }
 
 static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
@@ -312,10 +354,6 @@ NOKPROBE_SYMBOL(oops_end);
 
 int __die(const char *str, struct pt_regs *regs, long err)
 {
-#ifdef CONFIG_X86_32
-	unsigned short ss;
-	unsigned long sp;
-#endif
 	printk(KERN_DEFAULT
 	       "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff, ++die_counter,
 	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT"         : "",
@@ -331,20 +369,10 @@ int __die(const char *str, struct pt_regs *regs, long err)
 
 	print_modules();
 	show_regs(regs);
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
+
 	/* Executive summary in case the oops scrolled away */
-	printk(KERN_ALERT "RIP: %pS RSP: %016lx\n", (void *)regs->ip, regs->sp);
-#endif
+	show_ip(regs, KERN_EMERG);
+
 	return 0;
 }
 NOKPROBE_SYMBOL(__die);
@@ -391,29 +419,6 @@ static int __init code_bytes_setup(char *s)
 }
 __setup("code_bytes=", code_bytes_setup);
 
-void show_opcodes(u8 *rip, const char *loglvl)
-{
-	unsigned int code_prologue = code_bytes * 43 / OPCODE_BUFSIZE;
-	u8 *ip;
-	int i;
-
-	printk("%sCode: ", loglvl);
-
-	ip = (u8 *)rip - code_prologue;
-	if (probe_kernel_read(opcodes, ip, code_bytes)) {
-		pr_cont(" Bad RIP value.\n");
-		return;
-	}
-
-	for (i = 0; i < code_bytes; i++, ip++) {
-		if (ip == (u8 *)rip)
-			pr_cont("<%02x> ", opcodes[i]);
-		else
-			pr_cont("%02x ", opcodes[i]);
-	}
-	pr_cont("\n");
-}
-
 void show_regs(struct pt_regs *regs)
 {
 	bool all = true;
@@ -434,7 +439,5 @@ void show_regs(struct pt_regs *regs)
 
 		if (regs->ip < PAGE_OFFSET)
 			pr_cont(" Bad RIP value.\n");
-		else
-			show_opcodes((u8 *)regs->ip, KERN_DEFAULT);
 	}
 }
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 5224c6099184..3d1f1226b972 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -76,9 +76,7 @@ void __show_regs(struct pt_regs *regs, int all)
 		savesegment(gs, gs);
 	}
 
-	printk(KERN_DEFAULT "EIP: %pS\n", (void *)regs->ip);
-	printk(KERN_DEFAULT "EFLAGS: %08lx CPU: %d\n", regs->flags,
-		raw_smp_processor_id());
+	show_ip(regs, KERN_DEFAULT);
 
 	printk(KERN_DEFAULT "EAX: %08lx EBX: %08lx ECX: %08lx EDX: %08lx\n",
 		regs->ax, regs->bx, regs->cx, regs->dx);


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
