Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751235AbeCID0N (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 22:26:13 -0500
Received: from mail.efficios.com ([167.114.142.138]:44782 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbeCID0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 22:26:11 -0500
From: Francis Deslauriers <francis.deslauriers@efficios.com>
To: mhiramat@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [PATCH 1/1] x86/kprobes: Prohibit probing of .entry_trampoline code
Date: Thu,  8 Mar 2018 22:18:12 -0500
Message-Id: <1520565492-4637-2-git-send-email-francis.deslauriers@efficios.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520565492-4637-1-git-send-email-francis.deslauriers@efficios.com>
References: <1520565492-4637-1-git-send-email-francis.deslauriers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/include/asm/sections.h |  1 +
 arch/x86/kernel/kprobes/core.c  | 10 +++++++++-
 arch/x86/kernel/vmlinux.lds.S   |  2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index d6baf23..5c019d2 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -10,6 +10,7 @@ extern struct exception_table_entry __stop___ex_table[];
 
 #if defined(CONFIG_X86_64)
 extern char __end_rodata_hpage_align[];
+extern char __entry_trampoline_start[], __entry_trampoline_end[];
 #endif
 
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index bd36f3c..0715f82 100644
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
index 9b138a0..b854ebf 100644
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
 
-- 
2.7.4
