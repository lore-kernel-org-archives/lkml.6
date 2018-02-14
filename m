Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967141AbeBNKdN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:33:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:26770 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754602AbeBNKdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:33:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,511,1511856000";
   d="scan'208";a="18335607"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/asm: Use PAGE_SIZE instead of 4096 where appropriate
Date: Wed, 14 Feb 2018 13:32:53 +0300
Message-Id: <20180214103253.42066-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cyrill pointed that it makes sense to replace 4096 to PAGE_SIZE in
head_64.S.

This patch replaces 4096 with PAGE_SIZE everywhere in assembly code
where it fits semantically.

Suggested-by: Cyrill Gorcunov <gorcunov@gmail.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/head_64.S        | 4 ++--
 arch/x86/entry/vsyscall/vsyscall_emu_64.S | 4 ++--
 arch/x86/kernel/head_32.S                 | 2 +-
 arch/x86/lib/clear_page_64.S              | 7 ++++---
 arch/x86/lib/copy_page_64.S               | 5 +++--
 arch/x86/purgatory/setup-x86_64.S         | 5 +++--
 arch/x86/purgatory/stack.S                | 6 ++++--
 7 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 99a0e7993252..4fa83b90af8e 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -652,10 +652,10 @@ trampoline_save:
  * Space for page tables (not in .bss so not zeroed)
  */
 	.section ".pgtable","a",@nobits
-	.balign 4096
+	.balign PAGE_SIZE
 pgtable:
 	.fill BOOT_PGT_SIZE, 1, 0
 
 	.global pgtable_trampoline
 pgtable_trampoline:
-	.fill 4096, 1, 0
+	.fill PAGE_SIZE, 1, 0
diff --git a/arch/x86/entry/vsyscall/vsyscall_emu_64.S b/arch/x86/entry/vsyscall/vsyscall_emu_64.S
index c9596a9af159..ac3e37bcff48 100644
--- a/arch/x86/entry/vsyscall/vsyscall_emu_64.S
+++ b/arch/x86/entry/vsyscall/vsyscall_emu_64.S
@@ -32,6 +32,6 @@ __vsyscall_page:
 	syscall
 	ret
 
-	.balign 4096, 0xcc
+	.balign PAGE_SIZE, 0xcc
 
-	.size __vsyscall_page, 4096
+	.size __vsyscall_page, PAGE_SIZE
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index c29020907886..ab10212f34ab 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -530,7 +530,7 @@ initial_pg_fixmap:
 	.fill 1024,4,0
 .globl empty_zero_page
 empty_zero_page:
-	.fill 4096,1,0
+	.fill PAGE_SIZE,1,0
 .globl swapper_pg_dir
 swapper_pg_dir:
 	.fill 1024,4,0
diff --git a/arch/x86/lib/clear_page_64.S b/arch/x86/lib/clear_page_64.S
index 81b1635d67de..ef0d0bc09a5d 100644
--- a/arch/x86/lib/clear_page_64.S
+++ b/arch/x86/lib/clear_page_64.S
@@ -2,6 +2,7 @@
 #include <asm/cpufeatures.h>
 #include <asm/alternative-asm.h>
 #include <asm/export.h>
+#include <asm/page_types.h>
 
 /*
  * Most CPUs support enhanced REP MOVSB/STOSB instructions. It is
@@ -15,7 +16,7 @@
  * %rdi	- page
  */
 ENTRY(clear_page_rep)
-	movl $4096/8,%ecx
+	movl $PAGE_SIZE/8,%ecx
 	xorl %eax,%eax
 	rep stosq
 	ret
@@ -24,7 +25,7 @@ EXPORT_SYMBOL_GPL(clear_page_rep)
 
 ENTRY(clear_page_orig)
 	xorl   %eax,%eax
-	movl   $4096/64,%ecx
+	movl   $PAGE_SIZE/64,%ecx
 	.p2align 4
 .Lloop:
 	decl	%ecx
@@ -45,7 +46,7 @@ ENDPROC(clear_page_orig)
 EXPORT_SYMBOL_GPL(clear_page_orig)
 
 ENTRY(clear_page_erms)
-	movl $4096,%ecx
+	movl $PAGE_SIZE,%ecx
 	xorl %eax,%eax
 	rep stosb
 	ret
diff --git a/arch/x86/lib/copy_page_64.S b/arch/x86/lib/copy_page_64.S
index fd2d09afa097..8c6ef546b3f0 100644
--- a/arch/x86/lib/copy_page_64.S
+++ b/arch/x86/lib/copy_page_64.S
@@ -5,6 +5,7 @@
 #include <asm/cpufeatures.h>
 #include <asm/alternative-asm.h>
 #include <asm/export.h>
+#include <asm/page_types.h>
 
 /*
  * Some CPUs run faster using the string copy instructions (sane microcode).
@@ -15,7 +16,7 @@
 	ALIGN
 ENTRY(copy_page)
 	ALTERNATIVE "jmp copy_page_regs", "", X86_FEATURE_REP_GOOD
-	movl	$4096/8, %ecx
+	movl	$PAGE_SIZE/8, %ecx
 	rep	movsq
 	ret
 ENDPROC(copy_page)
@@ -26,7 +27,7 @@ ENTRY(copy_page_regs)
 	movq	%rbx,	(%rsp)
 	movq	%r12,	1*8(%rsp)
 
-	movl	$(4096/64)-5,	%ecx
+	movl	$(PAGE_SIZE/64)-5,	%ecx
 	.p2align 4
 .Loop64:
 	dec	%rcx
diff --git a/arch/x86/purgatory/setup-x86_64.S b/arch/x86/purgatory/setup-x86_64.S
index dfae9b9e60b5..3eff1c8bde70 100644
--- a/arch/x86/purgatory/setup-x86_64.S
+++ b/arch/x86/purgatory/setup-x86_64.S
@@ -10,6 +10,7 @@
  * Version 2.  See the file COPYING for more details.
  */
 #include <asm/purgatory.h>
+#include <asm/page_types.h>
 
 	.text
 	.globl purgatory_start
@@ -53,7 +54,7 @@ gdt:	/* 0x00 unusable segment
 gdt_end:
 
 	.bss
-	.balign 4096
+	.balign PAGE_SIZE
 lstack:
-	.skip 4096
+	.skip PAGE_SIZE
 lstack_end:
diff --git a/arch/x86/purgatory/stack.S b/arch/x86/purgatory/stack.S
index 50a4147f91fb..f39989a6b7d5 100644
--- a/arch/x86/purgatory/stack.S
+++ b/arch/x86/purgatory/stack.S
@@ -7,13 +7,15 @@
  * Version 2.  See the file COPYING for more details.
  */
 
+#include <asm/page_types.h>
+
 	/* A stack for the loaded kernel.
 	 * Separate and in the data section so it can be prepopulated.
 	 */
 	.data
-	.balign 4096
+	.balign PAGE_SIZE
 	.globl stack, stack_end
 
 stack:
-	.skip 4096
+	.skip PAGE_SIZE
 stack_end:
-- 
2.15.1
