Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeBDPJs (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 10:09:48 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51612 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeBDPJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 10:09:41 -0500
Date: Sun, 4 Feb 2018 16:09:40 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86 updates for 4.16
Message-ID: <alpine.DEB.2.21.1802041605570.1035@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

A small set of changes:

  - A fixup for kexec related to 5-level paging mode. That covers most of
    the cases except kexec from a 5-level kernel to a 4-level kernel. The
    latter needs more work and is going to come in 4.17

  - Two trivial fixes for build warnings triggered by LTO and gcc-8.

Thanks,

	tglx

------------------>
Arnd Bergmann (2):
      x86/dumpstack: Avoid uninitlized variable
      x86/power: Fix swsusp_arch_resume prototype

Kirill A. Shutemov (1):
      x86/kexec: Make kexec (mostly) work in 5-level paging mode


 arch/x86/kernel/dumpstack.c          | 2 +-
 arch/x86/kernel/relocate_kernel_64.S | 8 ++++++++
 arch/x86/power/hibernate_32.c        | 2 +-
 arch/x86/power/hibernate_64.c        | 2 +-
 include/linux/suspend.h              | 2 ++
 kernel/power/power.h                 | 3 ---
 6 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index afbecff161d1..a2d8a3908670 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -109,7 +109,7 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	struct stack_info stack_info = {0};
 	unsigned long visit_mask = 0;
 	int graph_idx = 0;
-	bool partial;
+	bool partial = false;
 
 	printk("%sCall Trace:\n", log_lvl);
 
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 307d3bac5f04..11eda21eb697 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -68,6 +68,9 @@ relocate_kernel:
 	movq	%cr4, %rax
 	movq	%rax, CR4(%r11)
 
+	/* Save CR4. Required to enable the right paging mode later. */
+	movq	%rax, %r13
+
 	/* zero out flags, and disable interrupts */
 	pushq $0
 	popfq
@@ -126,8 +129,13 @@ identity_mapped:
 	/*
 	 * Set cr4 to a known state:
 	 *  - physical address extension enabled
+	 *  - 5-level paging, if it was enabled before
 	 */
 	movl	$X86_CR4_PAE, %eax
+	testq	$X86_CR4_LA57, %r13
+	jz	1f
+	orl	$X86_CR4_LA57, %eax
+1:
 	movq	%rax, %cr4
 
 	jmp 1f
diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index c35fdb585c68..afc4ed7b1578 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -145,7 +145,7 @@ static inline void resume_init_first_level_page_table(pgd_t *pg_dir)
 #endif
 }
 
-int swsusp_arch_resume(void)
+asmlinkage int swsusp_arch_resume(void)
 {
 	int error;
 
diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index f910c514438f..0ef5e5204968 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -174,7 +174,7 @@ static int relocate_restore_code(void)
 	return 0;
 }
 
-int swsusp_arch_resume(void)
+asmlinkage int swsusp_arch_resume(void)
 {
 	int error;
 
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index cc22a24516d6..440b62f7502e 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -384,6 +384,8 @@ extern int swsusp_page_is_forbidden(struct page *);
 extern void swsusp_set_page_free(struct page *);
 extern void swsusp_unset_page_free(struct page *);
 extern unsigned long get_safe_page(gfp_t gfp_mask);
+extern asmlinkage int swsusp_arch_suspend(void);
+extern asmlinkage int swsusp_arch_resume(void);
 
 extern void hibernation_set_ops(const struct platform_hibernation_ops *ops);
 extern int hibernate(void);
diff --git a/kernel/power/power.h b/kernel/power/power.h
index f29cd178df90..9e58bdc8a562 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -104,9 +104,6 @@ extern int in_suspend;
 extern dev_t swsusp_resume_device;
 extern sector_t swsusp_resume_block;
 
-extern asmlinkage int swsusp_arch_suspend(void);
-extern asmlinkage int swsusp_arch_resume(void);
-
 extern int create_basic_memory_bitmaps(void);
 extern void free_basic_memory_bitmaps(void);
 extern int hibernate_preallocate_memory(void);
