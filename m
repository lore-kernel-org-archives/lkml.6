Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeCJHHy (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 02:07:54 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60703 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeCJHHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 02:07:52 -0500
Date: Fri, 9 Mar 2018 23:07:15 -0800
From: tip-bot for Francis Deslauriers <tipbot@zytor.com>
Message-ID: <tip-c07a8f8b08ba683ea24f3ac9159f37ae94daf47f@git.kernel.org>
Cc: dvlasenk@redhat.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org,
        jpoimboe@redhat.com, bp@alien8.de, mingo@kernel.org, brgerst@gmail.com,
        luto@kernel.org, francis.deslauriers@efficios.com, tglx@linutronix.de
Reply-To: jpoimboe@redhat.com, bp@alien8.de, mingo@kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, dvlasenk@redhat.com,
        francis.deslauriers@efficios.com, tglx@linutronix.de,
        brgerst@gmail.com, luto@kernel.org
In-Reply-To: <1520565492-4637-2-git-send-email-francis.deslauriers@efficios.com>
References: <1520565492-4637-2-git-send-email-francis.deslauriers@efficios.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/kprobes: Fix kernel crash when probing
 .entry_trampoline code
Git-Commit-ID: c07a8f8b08ba683ea24f3ac9159f37ae94daf47f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c07a8f8b08ba683ea24f3ac9159f37ae94daf47f
Gitweb:     https://git.kernel.org/tip/c07a8f8b08ba683ea24f3ac9159f37ae94daf47f
Author:     Francis Deslauriers <francis.deslauriers@efficios.com>
AuthorDate: Thu, 8 Mar 2018 22:18:12 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 09:58:36 +0100

x86/kprobes: Fix kernel crash when probing .entry_trampoline code

Disable the kprobe probing of the entry trampoline:

.entry_trampoline is a code area that is used to ensure page table
isolation between userspace and kernelspace.

At the beginning of the execution of the trampoline, we load the
kernel's CR3 register. This has the effect of enabling the translation
of the kernel virtual addresses to physical addresses. Before this
happens most kernel addresses can not be translated because the running
process' CR3 is still used.

If a kprobe is placed on the trampoline code before that change of the
CR3 register happens the kernel crashes because int3 handling pages are
not accessible.

To fix this, add the .entry_trampoline section to the kprobe blacklist
to prohibit the probing of code before all the kernel pages are
accessible.

Signed-off-by: Francis Deslauriers <francis.deslauriers@efficios.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: mathieu.desnoyers@efficios.com
Cc: mhiramat@kernel.org
Link: http://lkml.kernel.org/r/1520565492-4637-2-git-send-email-francis.deslauriers@efficios.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/sections.h |  1 +
 arch/x86/kernel/kprobes/core.c  | 10 +++++++++-
 arch/x86/kernel/vmlinux.lds.S   |  2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index d6baf23782bc..5c019d23d06b 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -10,6 +10,7 @@ extern struct exception_table_entry __stop___ex_table[];
 
 #if defined(CONFIG_X86_64)
 extern char __end_rodata_hpage_align[];
+extern char __entry_trampoline_start[], __entry_trampoline_end[];
 #endif
 
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index bd36f3c33cd0..0715f827607c 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1168,10 +1168,18 @@ NOKPROBE_SYMBOL(longjmp_break_handler);
 
 bool arch_within_kprobe_blacklist(unsigned long addr)
 {
+	bool is_in_entry_trampoline_section = false;
+
+#ifdef CONFIG_X86_64
+	is_in_entry_trampoline_section =
+		(addr >= (unsigned long)__entry_trampoline_start &&
+		 addr < (unsigned long)__entry_trampoline_end);
+#endif
 	return  (addr >= (unsigned long)__kprobes_text_start &&
 		 addr < (unsigned long)__kprobes_text_end) ||
 		(addr >= (unsigned long)__entry_text_start &&
-		 addr < (unsigned long)__entry_text_end);
+		 addr < (unsigned long)__entry_text_end) ||
+		is_in_entry_trampoline_section;
 }
 
 int __init arch_init_kprobes(void)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 9b138a06c1a4..b854ebf5851b 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -118,9 +118,11 @@ SECTIONS
 
 #ifdef CONFIG_X86_64
 		. = ALIGN(PAGE_SIZE);
+		VMLINUX_SYMBOL(__entry_trampoline_start) = .;
 		_entry_trampoline = .;
 		*(.entry_trampoline)
 		. = ALIGN(PAGE_SIZE);
+		VMLINUX_SYMBOL(__entry_trampoline_end) = .;
 		ASSERT(. - _entry_trampoline == PAGE_SIZE, "entry trampoline is too big");
 #endif
 
