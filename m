Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751630AbeBYLgH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 06:36:07 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38844 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751545AbeBYLgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 06:36:03 -0500
Date: Sun, 25 Feb 2018 12:35:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] x86/dumpstack: Cleanups and user opcode bytes Code:
 section
Message-ID: <20180225113543.GB10469@pd.tnic>
References: <20180219202826.19797-1-bp@alien8.de>
 <CALCETrXgT0rLLziiOnv51tZioJ2bNKc1eNniu46dDOvW5=PxYQ@mail.gmail.com>
 <20180220192956.si2a6m3ckskexvte@treble>
 <20180220204435.GC24320@pd.tnic>
 <20180221091553.gxnvhbitiewo2mjc@gmail.com>
 <20180221175429.GC9989@pd.tnic>
 <CA+55aFxOcAdN4mnK49F1ObiXoyB2xaREd04JGosgxTd_ufuzpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFxOcAdN4mnK49F1ObiXoyB2xaREd04JGosgxTd_ufuzpg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 01:39:52PM -0800, Linus Torvalds wrote:
> which are actually about the crash. The rest is almost entirely useless.
> 
> Do I know what the corrent answer is? No.

Ok, I hear ya. I finally have some time to poke at this. So here's a new
splat, see below. Incremental diff at the end:

RSP is part of the registers dump now, after the GPRs.

I've added "EXEC SUMMARY" markers for now, for ease of discussing
this. Will remove them later.

My silly idea is to save the first regs when we enter __die(), i.e.,
die_counter == 0 and dump them in oops_end() as an exec summary.

I guess we can expand that executive summary into a full-fledged
function which dumps everything critical needed to debug an issue.

Lemme read the rest of the thread now.

[   22.762334] sysrq: SysRq : Trigger a crash
[   22.763456] BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
[   22.765416] PGD 7b64d067 P4D 7b64d067 PUD 79402067 PMD 0 
[   22.766121] Oops: 0002 [#1] PREEMPT SMP
[   22.766121] CPU: 0 PID: 3666 Comm: bash Not tainted 4.16.0-rc2+ #20
[   22.766121] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[   22.766121] RIP: 0010:sysrq_handle_crash+0x17/0x20
[   22.766121] Code: eb d1 e8 4d 19 b7 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e8 96 27 bd ff c7 05 14 24 19 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 86 24 c2 ff fb e9 
[   22.766121] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 0000000000000000
[   22.766121] RDX: 0000000000000000 RSI: ffffffff8110154a RDI: 0000000000000063
[   22.766121] RBP: ffffffff82271480 R08: 0000000000000185 R09: 00000000000ba1de
[   22.766121] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000a
[   22.766121] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   22.766121] RSP: 0018:ffffc90000703df0 EFLAGS: 00010246
[   22.766121] FS:  00007ffff7fdb700(0000) GS:ffff88007ec00000(0000) knlGS:0000000000000000
[   22.766121] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   22.766121] CR2: 0000000000000000 CR3: 000000007b711000 CR4: 00000000000406f0
[   22.766121] Call Trace:
[   22.766121]  __handle_sysrq+0x9e/0x160
[   22.766121]  write_sysrq_trigger+0x2b/0x30
[   22.766121]  proc_reg_write+0x38/0x70
[   22.766121]  __vfs_write+0x36/0x160
[   22.766121]  ? __fd_install+0x69/0x110
[   22.766121]  ? preempt_count_add+0x74/0xb0
[   22.766121]  ? _raw_spin_lock+0x13/0x30
[   22.766121]  ? set_close_on_exec+0x41/0x80
[   22.766121]  ? preempt_count_sub+0xa8/0x100
[   22.766121]  vfs_write+0xc0/0x190
[   22.766121]  SyS_write+0x64/0xe0
[   22.766121]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   22.766121]  do_syscall_64+0x70/0x130
[   22.766121]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
[   22.766121] RIP: 0033:0x7ffff74b9620
[   22.766121] Code: ff 73 01 c3 48 8b 0d 68 98 2c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 83 3d bd f1 2c 00 00 75 10 b8 01 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 ce 8f 01 00 48 89 04 
[   22.766121]  ORIG_RAX: 0000000000000001
[   22.766121] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ffff74b9620
[   22.766121] RDX: 0000000000000002 RSI: 0000000000705408 RDI: 0000000000000001
[   22.766121] RBP: 0000000000705408 R08: 000000000000000a R09: 00007ffff7fdb700
[   22.766121] R10: 00007fffffffe490 R11: 0000000000000246 R12: 00007ffff77842a0
[   22.766121] R13: 0000000000000002 R14: 0000000000000001 R15: 0000000000000000
[   22.766121] RSP: 002b:00007fffffffe638 EFLAGS: 00000246
[   22.766121] Modules linked in:
[   22.766121] CR2: 0000000000000000
[   22.817404] ---[ end trace 374137bfd9ca49cc ]---
[   22.818727] <EXEC SUMMARY>:
[   22.819608] RIP: 0010:sysrq_handle_crash+0x17/0x20
[   22.820906] Code: eb d1 e8 4d 19 b7 ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 e8 96 27 bd ff c7 05 14 24 19 01 01 00 00 00 0f ae f8 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 e8 86 24 c2 ff fb e9 
[   22.824896] RAX: 0000000000000000 RBX: 0000000000000063 RCX: 0000000000000000
[   22.826208] RDX: 0000000000000000 RSI: ffffffff8110154a RDI: 0000000000000063
[   22.827506] RBP: ffffffff82271480 R08: 0000000000000185 R09: 00000000000ba1de
[   22.828935] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000a
[   22.830257] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   22.831535] RSP: 0018:ffffc90000703df0 EFLAGS: 00010246
[   22.831536] </EXEC SUMMARY>:
[   22.836493] Kernel panic - not syncing: Fatal exception
[   22.837871] Kernel Offset: disabled
[   22.838648] ---[ end Kernel panic - not syncing: Fatal exception


---
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 0037bdc9e252..e71319194f6c 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -31,6 +31,8 @@ static u8 __opc[OPCODE_BUFSIZE];
 static u8 *opcodes = __opc;
 static int die_counter;
 
+static struct pt_regs exec_summary_regs;
+
 bool in_task_stack(unsigned long *stack, struct task_struct *task,
 		   struct stack_info *info)
 {
@@ -323,6 +325,11 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 	raw_local_irq_restore(flags);
 	oops_exit();
 
+	/* Executive summary in case the oops scrolled away */
+	pr_emerg("<EXEC SUMMARY>:\n");
+	__show_regs(&exec_summary_regs, false);
+	pr_emerg("</EXEC SUMMARY>:\n");
+
 	if (!signr)
 		return;
 	if (in_interrupt())
@@ -341,6 +348,13 @@ NOKPROBE_SYMBOL(oops_end);
 
 int __die(const char *str, struct pt_regs *regs, long err)
 {
+
+	/*
+	 * Save the first regs for the executive summary.
+	 */
+	if (!die_counter)
+		exec_summary_regs = *regs;
+
 	printk(KERN_DEFAULT
 	       "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff, ++die_counter,
 	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT"         : "",
@@ -350,15 +364,13 @@ int __die(const char *str, struct pt_regs *regs, long err)
 	       IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION) ?
 	       (boot_cpu_has(X86_FEATURE_PTI) ? " PTI" : " NOPTI") : "");
 
+	show_regs(regs);
+
 	if (notify_die(DIE_OOPS, str, regs, err,
 			current->thread.trap_nr, SIGSEGV) == NOTIFY_STOP)
 		return 1;
 
 	print_modules();
-	show_regs(regs);
-
-	/* Executive summary in case the oops scrolled away */
-	show_ip(regs, KERN_EMERG);
 
 	return 0;
 }
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 8a1da018f0d5..b3c19f734442 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -699,7 +699,6 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		printk(KERN_CONT "paging request");
 
 	printk(KERN_CONT " at %px\n", (void *) address);
-	printk(KERN_ALERT "IP: %pS\n", (void *)regs->ip);
 
 	dump_pagetable(address);
 }


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
