Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426158AbeBOQhp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:37:45 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:57791 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1426071AbeBOQgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:36:17 -0500
From: Nadav Amit <namit@vmware.com>
To: Ingo Molnar <mingo@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, Willy Tarreau <w@1wt.eu>,
        Nadav Amit <nadav.amit@gmail.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH RFC v2 4/6] x86: Disable PTI on compatibility mode
Date: Thu, 15 Feb 2018 08:36:00 -0800
Message-ID: <20180215163602.61162-5-namit@vmware.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180215163602.61162-1-namit@vmware.com>
References: <20180215163602.61162-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the understanding that there should be no way for userspace to
address the kernel-space from compatibility mode, disable it while
running in compatibility mode as long as the 64-bit code segment of the
user is not used.

Reenabling PTI is performed by restoring NX-bits to the userspace
mappings, flushing the TLBs, and notifying all the CPUs that use the
affected mm to disable PTI. Each core responds by removing the present
bit for the 64-bit code-segment, and marking that PTI is disabled on
that core.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/pti.h   |  39 +++++++++++++
 arch/x86/kernel/process_64.c |  13 ++++-
 arch/x86/kernel/traps.c      |  23 +++++++-
 arch/x86/mm/pti.c            | 130 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 201 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index 78a333699874..d04954ebb0d4 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -31,6 +31,42 @@ static inline void pti_update_user_cs64(unsigned short prev_pti_disable,
 	write_gdt_entry(d, GDT_ENTRY_DEFAULT_USER_CS, &user_cs, DESCTYPE_S);
 }
 
+void __pti_reenable(void);
+
+static inline void pti_reenable(void)
+{
+	if (!static_cpu_has(X86_FEATURE_PTI) || !mm_pti_disable(current->mm))
+		return;
+
+	__pti_reenable();
+}
+
+void __pti_disable(unsigned short type);
+
+static inline void pti_disable(unsigned short type)
+{
+	/*
+	 * To allow PTI to be disabled, we must:
+	 *
+	 * 1. Have PTI enabled.
+	 * 2. Have SMEP enabled, since the lack of NX-bit on user mappings
+	 *    raises general security concerns.
+	 * 3. Have NX-bit enabled, since reenabling PTI has a corner case in
+	 *    which the kernel tables are restored instead of those of those of
+	 *    the user. Having NX-bit causes this scenario to trigger a spurious
+	 *    page-fault when control is returned to the user, and allow the
+	 *    entry code to restore the page-tables to their correct state.
+	 */
+	if (!static_cpu_has(X86_FEATURE_PTI) ||
+	    !static_cpu_has(X86_FEATURE_SMEP) ||
+	    !static_cpu_has(X86_FEATURE_NX))
+		return;
+
+	__pti_disable(type);
+}
+
+bool pti_handle_segment_not_present(long error_code);
+
 extern void pti_init(void);
 extern void pti_check_boottime_disable(void);
 #else
@@ -38,6 +74,9 @@ static inline unsigned short mm_pti_disable(struct mm_struct *mm) { return 0; }
 static inline unsigned short mm_pti_disable(struct mm_struct *mm);
 static inline void pti_update_user_cs64(unsigned short prev_pti_disable,
 					unsigned short next_pti_disable) { }
+static inline void pti_disable(unsigned short type) { }
+static inline void pti_reenable(void) { }
+static inline bool pti_handle_segment_not_present(long error_code) { return false; }
 static inline void pti_check_boottime_disable(void) { }
 #endif
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index c75466232016..24d3429b4191 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -54,6 +54,7 @@
 #include <asm/vdso.h>
 #include <asm/intel_rdt_sched.h>
 #include <asm/unistd.h>
+#include <asm/pti.h>
 #ifdef CONFIG_IA32_EMULATION
 /* Not included via unistd.h */
 #include <asm/unistd_32_ia32.h>
@@ -530,8 +531,10 @@ void set_personality_64bit(void)
 	task_pt_regs(current)->orig_ax = __NR_execve;
 
 	/* Ensure the corresponding mm is not marked. */
-	if (current->mm)
+	if (current->mm) {
 		current->mm->context.ia32_compat = 0;
+		pti_reenable();
+	}
 
 	/* TBD: overwrites user setup. Should have two bits.
 	   But 64bit processes have always behaved this way,
@@ -545,8 +548,10 @@ static void __set_personality_x32(void)
 #ifdef CONFIG_X86_X32
 	clear_thread_flag(TIF_IA32);
 	set_thread_flag(TIF_X32);
-	if (current->mm)
+	if (current->mm) {
 		current->mm->context.ia32_compat = TIF_X32;
+		pti_reenable();
+	}
 	current->personality &= ~READ_IMPLIES_EXEC;
 	/*
 	 * in_compat_syscall() uses the presence of the x32 syscall bit
@@ -566,8 +571,10 @@ static void __set_personality_ia32(void)
 #ifdef CONFIG_IA32_EMULATION
 	set_thread_flag(TIF_IA32);
 	clear_thread_flag(TIF_X32);
-	if (current->mm)
+	if (current->mm) {
 		current->mm->context.ia32_compat = TIF_IA32;
+		pti_disable(PTI_DISABLE_IA32);
+	}
 	current->personality |= force_personality32;
 	/* Prepare the first "return" to user space */
 	task_pt_regs(current)->orig_ax = __NR_ia32_execve;
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 446c9ef8cfc3..65d8ccb20175 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -61,6 +61,7 @@
 #include <asm/mpx.h>
 #include <asm/vm86.h>
 #include <asm/umip.h>
+#include <asm/pti.h>
 
 #ifdef CONFIG_X86_64
 #include <asm/x86_init.h>
@@ -315,7 +316,6 @@ DO_ERROR(X86_TRAP_OF,     SIGSEGV, "overflow",			overflow)
 DO_ERROR(X86_TRAP_UD,     SIGILL,  "invalid opcode",		invalid_op)
 DO_ERROR(X86_TRAP_OLD_MF, SIGFPE,  "coprocessor segment overrun",coprocessor_segment_overrun)
 DO_ERROR(X86_TRAP_TS,     SIGSEGV, "invalid TSS",		invalid_TSS)
-DO_ERROR(X86_TRAP_NP,     SIGBUS,  "segment not present",	segment_not_present)
 DO_ERROR(X86_TRAP_SS,     SIGBUS,  "stack segment",		stack_segment)
 DO_ERROR(X86_TRAP_AC,     SIGBUS,  "alignment check",		alignment_check)
 
@@ -529,6 +529,27 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
 	do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, NULL);
 }
 
+dotraplinkage void
+do_segment_not_present(struct pt_regs *regs, long error_code)
+{
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
+	cond_local_irq_enable(regs);
+
+	/*
+	 * 64-bit mode was disabled to prevent unnecessary page table isolation.
+	 * Enable it, and from now on page-tables will be switched on kernel
+	 * entry. Due to potential race conditions, we check the error code to
+	 * see whether it references the __USER_CS, and ensure we only handle a
+	 * single event per thread.
+	 */
+	if (pti_handle_segment_not_present(error_code))
+		return;
+
+	do_trap(X86_TRAP_NP, SIGTRAP, "segment not present", regs, error_code,
+		NULL);
+}
+NOKPROBE_SYMBOL(do_segment_not_present);
+
 dotraplinkage void
 do_general_protection(struct pt_regs *regs, long error_code)
 {
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index a973a291a34d..18d936c5aa31 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -148,6 +148,136 @@ pgd_t __pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
 	return pgd;
 }
 
+static void pti_update_user_pgds(struct mm_struct *mm, bool pti_enable)
+{
+	int i;
+
+	if (!(__supported_pte_mask & _PAGE_NX))
+		return;
+
+	for (i = 0; i < PTRS_PER_PGD / 2; i++) {
+		pgd_t pgd, *pgdp = &mm->pgd[i];
+
+		pgd = *pgdp;
+
+		if ((pgd.pgd & (_PAGE_USER|_PAGE_PRESENT)) !=
+			(_PAGE_USER|_PAGE_PRESENT))
+			continue;
+
+		if (pti_enable)
+			pgd.pgd |= _PAGE_NX;
+		else
+			pgd.pgd &= ~_PAGE_NX;
+
+		*pgdp = pgd;
+	}
+}
+
+static void pti_cpu_update_func(void *info)
+{
+	struct mm_struct *mm = (struct mm_struct *)info;
+
+	if (mm != this_cpu_read(cpu_tlbstate.loaded_mm))
+		return;
+
+	/*
+	 * Keep CS64 and CPU settings in sync despite potential concurrent
+	 * updates.
+	 */
+	set_cpu_pti_disable(READ_ONCE(mm->context.pti_disable));
+}
+
+/*
+ * Reenable PTI after it was selectively disabled. Since the mm is in use, and
+ * the NX-bit of the PGD may be set while the user still uses the kernel PGD, it
+ * may lead to spurious page-faults. The page-fault handler should be able to
+ * handle them gracefully.
+ */
+void __pti_reenable(void)
+{
+	struct mm_struct *mm = current->mm;
+	int cpu;
+
+	if (!mm_pti_disable(mm))
+		return;
+
+	/*
+	 * Prevent spurious page-fault storm while we set the NX-bit and have
+	 * yet not updated the per-CPU pti_disable flag.
+	 */
+	down_write(&mm->mmap_sem);
+
+	if (!mm_pti_disable(mm))
+		goto out;
+
+	/*
+	 * First, mark the PTI is enabled. Although we do anything yet, we are
+	 * safe as long as we do not reenable CS64. Since we did not update the
+	 * page tables yet, this may lead to spurious page-faults, but we need
+	 * the pti_disable in mm to be set for __pti_set_user_pgd() to do the
+	 * right thing.  Holding mmap_sem would ensure matter we hold the
+	 * mmap_sem to prevent them from swamping the system.
+	 */
+	mm->context.pti_disable = PTI_DISABLE_OFF;
+
+	/* Second, restore the NX bits. */
+	pti_update_user_pgds(mm, true);
+
+	/*
+	 * Third, flush the entire mm. By doing so we also force the processes
+	 * to reload the correct page-table on return. This also provides a
+	 * barrier before we restore USER_CS, ensuring we see the update
+	 * cpumask.
+	 */
+	flush_tlb_mm(mm);
+
+	/*
+	 * Finally, restore CS64 to its correct state and mark that PTI is
+	 * reenabled.
+	 */
+	cpu = get_cpu();
+	pti_cpu_update_func(mm);
+	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
+		smp_call_function_many(mm_cpumask(mm), pti_cpu_update_func,
+				       mm, 1);
+	put_cpu();
+
+out:
+	up_write(&mm->mmap_sem);
+}
+
+void __pti_disable(unsigned short type)
+{
+	struct mm_struct *mm = current->mm;
+
+	/*
+	 * Give disabling options with higher value higher priority, as they are
+	 * permanent and not transient. This also avoids re-disabling.
+	 */
+	if (mm_pti_disable(mm) >= type)
+		return;
+
+	mm->context.pti_disable = type;
+
+	pti_update_user_pgds(mm, false);
+
+	preempt_disable();
+	set_cpu_pti_disable(type);
+	preempt_enable();
+}
+
+bool pti_handle_segment_not_present(long error_code)
+{
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return false;
+
+	if ((unsigned short)error_code != GDT_ENTRY_DEFAULT_USER_CS << 3)
+		return false;
+
+	pti_reenable();
+	return true;
+}
+
 /*
  * Walk the user copy of the page tables (optionally) trying to allocate
  * page table pages on the way down.
-- 
2.14.1
