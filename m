Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbeETJAa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 05:00:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58389 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeETJAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 05:00:25 -0400
Date: Sun, 20 May 2018 11:00:22 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86 fixes for 4.17
Message-ID: <alpine.DEB.2.21.1805201043040.1599@nanos.tec.linutronix.de>
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

An unfortunately larger set of fixes, but a large portion is
selftests. Part of that pull-request was already sent with the core pull
request because we had to merge pieces for dependency resolution.

 - Fix the missing clusterid initializaiton for x2apic cluster management
   which caused boot failures due to IPIs being sent to the wrong cluster

 - Drop TX_COMPAT when a 64bit executable is exec()'ed from a compat task

 - Wrap access to __supported_pte_mask in __startup_64() where clang
   compile fails due to a non PC relative access being generated.

 - Two fixes for 5 level paging fallout in the decompressor: Handle GOT
   correctly for paging_prepare() and cleanup_trampoline(). Fix the page
   table handling in cleanup_trampoline() to avoid page table corruption.

 - Stop special casing protection key 0 as this is inconsistent with the
   manpage and also inconsistent with the allocation map handling.

 - Override the protection key wen moving away from PROT_EXEC to prevent
   inaccessible memory.

 - Fix and update the protection key selftests to address breakage and to
   cover the above issue

 - Add a MOV SS self test

 The bits already contained in the core pull request:

 - Unbreak the BPF compilation which got broken by the unconditional
   requirement of asm-goto, which is not supported by clang.

 - Prevent probing on exception masking instructions in uprobes and kprobes
   to avoid the issues of the delayed exceptions instead of having an ugly
   workaround.

 - Prevent a double free_page() in the error path of do_kexec_load()

 - Header sync for tools.


Thanks,

	tglx

------------------>
Alexander Potapenko (1):
      x86/boot/64/clang: Use fixup_pointer() to access '__supported_pte_mask'

Alexei Starovoitov (1):
      x86/cpufeature: Guard asm_volatile_goto usage for BPF compilation

Andy Lutomirski (1):
      x86/selftests: Add mov_to_ss test

Dave Hansen (13):
      x86/pkeys/selftests: Give better unexpected fault error messages
      x86/pkeys/selftests: Stop using assert()
      x86/pkeys/selftests: Remove dead debugging code, fix dprint_in_signal
      x86/pkeys/selftests: Avoid printf-in-signal deadlocks
      x86/pkeys/selftests: Allow faults on unknown keys
      x86/pkeys/selftests: Factor out "instruction page"
      x86/pkeys/selftests: Add PROT_EXEC test
      x86/pkeys/selftests: Fix pkey exhaustion test off-by-one
      x86/pkeys: Override pkey when moving away from PROT_EXEC
      x86/pkeys/selftests: Fix pointer math
      x86/pkeys/selftests: Save off 'prot' for allocations
      x86/pkeys/selftests: Add a test for pkey 0
      x86/pkeys: Do not special case protection key 0

Dmitry Safonov (1):
      x86/mm: Drop TS_COMPAT on 64-bit exec() syscall

Ingo Molnar (3):
      objtool, kprobes/x86: Sync the latest <asm/insn.h> header with tools/objtool/arch/x86/include/asm/insn.h
      x86/pkeys/selftests: Adjust the self-test to fresh distros that export the pkeys ABI
      x86/mpx/selftests: Adjust the self-test to fresh distros that export the MPX ABI

Kirill A. Shutemov (2):
      x86/boot/compressed/64: Set up GOT for paging_prepare() and cleanup_trampoline()
      x86/boot/compressed/64: Fix moving page table out of trampoline memory

Masami Hiramatsu (2):
      kprobes/x86: Prohibit probing on exception masking instructions
      uprobes/x86: Prohibit probing on MOV SS instruction

Tetsuo Handa (1):
      x86/kexec: Avoid double free_page() upon do_kexec_load() failure

Thomas Gleixner (1):
      x86/apic/x2apic: Initialize cluster ID properly


 arch/x86/boot/compressed/head_64.S            |  79 +++++--
 arch/x86/boot/compressed/pgtable_64.c         |  14 +-
 arch/x86/include/asm/cpufeature.h             |  15 ++
 arch/x86/include/asm/insn.h                   |  18 ++
 arch/x86/include/asm/mmu_context.h            |   2 +-
 arch/x86/include/asm/pkeys.h                  |  18 +-
 arch/x86/kernel/apic/x2apic_cluster.c         |   1 +
 arch/x86/kernel/head64.c                      |  10 +-
 arch/x86/kernel/kprobes/core.c                |   4 +
 arch/x86/kernel/machine_kexec_32.c            |   6 +-
 arch/x86/kernel/machine_kexec_64.c            |   5 +-
 arch/x86/kernel/process_64.c                  |   1 +
 arch/x86/kernel/uprobes.c                     |   4 +
 arch/x86/mm/pkeys.c                           |  21 +-
 samples/bpf/Makefile                          |   2 +-
 tools/objtool/arch/x86/include/asm/insn.h     |  18 ++
 tools/testing/selftests/x86/Makefile          |   2 +-
 tools/testing/selftests/x86/mov_ss_trap.c     | 285 ++++++++++++++++++++++++++
 tools/testing/selftests/x86/mpx-mini-test.c   |   7 +-
 tools/testing/selftests/x86/pkey-helpers.h    |  20 +-
 tools/testing/selftests/x86/protection_keys.c | 254 ++++++++++++++++-------
 21 files changed, 654 insertions(+), 132 deletions(-)
 create mode 100644 tools/testing/selftests/x86/mov_ss_trap.c

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fca012baba19..8169e8b7a4dc 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -305,6 +305,25 @@ ENTRY(startup_64)
 	/* Set up the stack */
 	leaq	boot_stack_end(%rbx), %rsp
 
+	/*
+	 * paging_prepare() and cleanup_trampoline() below can have GOT
+	 * references. Adjust the table with address we are running at.
+	 *
+	 * Zero RAX for adjust_got: the GOT was not adjusted before;
+	 * there's no adjustment to undo.
+	 */
+	xorq	%rax, %rax
+
+	/*
+	 * Calculate the address the binary is loaded at and use it as
+	 * a GOT adjustment.
+	 */
+	call	1f
+1:	popq	%rdi
+	subq	$1b, %rdi
+
+	call	adjust_got
+
 	/*
 	 * At this point we are in long mode with 4-level paging enabled,
 	 * but we might want to enable 5-level paging or vice versa.
@@ -370,10 +389,14 @@ trampoline_return:
 	/*
 	 * cleanup_trampoline() would restore trampoline memory.
 	 *
+	 * RDI is address of the page table to use instead of page table
+	 * in trampoline memory (if required).
+	 *
 	 * RSI holds real mode data and needs to be preserved across
 	 * this function call.
 	 */
 	pushq	%rsi
+	leaq	top_pgtable(%rbx), %rdi
 	call	cleanup_trampoline
 	popq	%rsi
 
@@ -381,6 +404,21 @@ trampoline_return:
 	pushq	$0
 	popfq
 
+	/*
+	 * Previously we've adjusted the GOT with address the binary was
+	 * loaded at. Now we need to re-adjust for relocation address.
+	 *
+	 * Calculate the address the binary is loaded at, so that we can
+	 * undo the previous GOT adjustment.
+	 */
+	call	1f
+1:	popq	%rax
+	subq	$1b, %rax
+
+	/* The new adjustment is the relocation address */
+	movq	%rbx, %rdi
+	call	adjust_got
+
 /*
  * Copy the compressed kernel to the end of our buffer
  * where decompression in place becomes safe.
@@ -481,19 +519,6 @@ relocated:
 	shrq	$3, %rcx
 	rep	stosq
 
-/*
- * Adjust our own GOT
- */
-	leaq	_got(%rip), %rdx
-	leaq	_egot(%rip), %rcx
-1:
-	cmpq	%rcx, %rdx
-	jae	2f
-	addq	%rbx, (%rdx)
-	addq	$8, %rdx
-	jmp	1b
-2:
-	
 /*
  * Do the extraction, and jump to the new kernel..
  */
@@ -512,6 +537,27 @@ relocated:
  */
 	jmp	*%rax
 
+/*
+ * Adjust the global offset table
+ *
+ * RAX is the previous adjustment of the table to undo (use 0 if it's the
+ * first time we touch GOT).
+ * RDI is the new adjustment to apply.
+ */
+adjust_got:
+	/* Walk through the GOT adding the address to the entries */
+	leaq	_got(%rip), %rdx
+	leaq	_egot(%rip), %rcx
+1:
+	cmpq	%rcx, %rdx
+	jae	2f
+	subq	%rax, (%rdx)	/* Undo previous adjustment */
+	addq	%rdi, (%rdx)	/* Apply the new adjustment */
+	addq	$8, %rdx
+	jmp	1b
+2:
+	ret
+
 	.code32
 /*
  * This is the 32-bit trampoline that will be copied over to low memory.
@@ -649,3 +695,10 @@ boot_stack_end:
 	.balign 4096
 pgtable:
 	.fill BOOT_PGT_SIZE, 1, 0
+
+/*
+ * The page table is going to be used instead of page table in the trampoline
+ * memory.
+ */
+top_pgtable:
+	.fill PAGE_SIZE, 1, 0
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 32af1cbcd903..a362fa0b849c 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -22,14 +22,6 @@ struct paging_config {
 /* Buffer to preserve trampoline memory */
 static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
 
-/*
- * The page table is going to be used instead of page table in the trampoline
- * memory.
- *
- * It must not be in BSS as BSS is cleared after cleanup_trampoline().
- */
-static char top_pgtable[PAGE_SIZE] __aligned(PAGE_SIZE) __section(.data);
-
 /*
  * Trampoline address will be printed by extract_kernel() for debugging
  * purposes.
@@ -134,7 +126,7 @@ struct paging_config paging_prepare(void)
 	return paging_config;
 }
 
-void cleanup_trampoline(void)
+void cleanup_trampoline(void *pgtable)
 {
 	void *trampoline_pgtable;
 
@@ -145,8 +137,8 @@ void cleanup_trampoline(void)
 	 * if it's there.
 	 */
 	if ((void *)__native_read_cr3() == trampoline_pgtable) {
-		memcpy(top_pgtable, trampoline_pgtable, PAGE_SIZE);
-		native_write_cr3((unsigned long)top_pgtable);
+		memcpy(pgtable, trampoline_pgtable, PAGE_SIZE);
+		native_write_cr3((unsigned long)pgtable);
 	}
 
 	/* Restore trampoline memory */
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index b27da9602a6d..aced6c9290d6 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -140,6 +140,20 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 
 #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
 
+#if defined(__clang__) && !defined(CC_HAVE_ASM_GOTO)
+
+/*
+ * Workaround for the sake of BPF compilation which utilizes kernel
+ * headers, but clang does not support ASM GOTO and fails the build.
+ */
+#ifndef __BPF_TRACING__
+#warning "Compiler lacks ASM_GOTO support. Add -D __BPF_TRACING__ to your compiler arguments"
+#endif
+
+#define static_cpu_has(bit)            boot_cpu_has(bit)
+
+#else
+
 /*
  * Static testing of CPU features.  Used the same as boot_cpu_has().
  * These will statically patch the target code for additional
@@ -195,6 +209,7 @@ static __always_inline __pure bool _static_cpu_has(u16 bit)
 		boot_cpu_has(bit) :				\
 		_static_cpu_has(bit)				\
 )
+#endif
 
 #define cpu_has_bug(c, bit)		cpu_has(c, (bit))
 #define set_cpu_bug(c, bit)		set_cpu_cap(c, (bit))
diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index b3e32b010ab1..c2c01f84df75 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -208,4 +208,22 @@ static inline int insn_offset_immediate(struct insn *insn)
 	return insn_offset_displacement(insn) + insn->displacement.nbytes;
 }
 
+#define POP_SS_OPCODE 0x1f
+#define MOV_SREG_OPCODE 0x8e
+
+/*
+ * Intel SDM Vol.3A 6.8.3 states;
+ * "Any single-step trap that would be delivered following the MOV to SS
+ * instruction or POP to SS instruction (because EFLAGS.TF is 1) is
+ * suppressed."
+ * This function returns true if @insn is MOV SS or POP SS. On these
+ * instructions, single stepping is suppressed.
+ */
+static inline int insn_masking_exception(struct insn *insn)
+{
+	return insn->opcode.bytes[0] == POP_SS_OPCODE ||
+		(insn->opcode.bytes[0] == MOV_SREG_OPCODE &&
+		 X86_MODRM_REG(insn->modrm.bytes[0]) == 2);
+}
+
 #endif /* _ASM_X86_INSN_H */
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 57e3785d0d26..cf9911b5a53c 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -193,7 +193,7 @@ static inline int init_new_context(struct task_struct *tsk,
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
-		/* pkey 0 is the default and always allocated */
+		/* pkey 0 is the default and allocated implicitly */
 		mm->context.pkey_allocation_map = 0x1;
 		/* -1 means unallocated or invalid */
 		mm->context.execute_only_pkey = -1;
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index a0ba1ffda0df..851c04b7a092 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_PKEYS_H
 #define _ASM_X86_PKEYS_H
 
+#define ARCH_DEFAULT_PKEY	0
+
 #define arch_max_pkey() (boot_cpu_has(X86_FEATURE_OSPKE) ? 16 : 1)
 
 extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
@@ -15,7 +17,7 @@ extern int __execute_only_pkey(struct mm_struct *mm);
 static inline int execute_only_pkey(struct mm_struct *mm)
 {
 	if (!boot_cpu_has(X86_FEATURE_OSPKE))
-		return 0;
+		return ARCH_DEFAULT_PKEY;
 
 	return __execute_only_pkey(mm);
 }
@@ -49,13 +51,21 @@ bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 {
 	/*
 	 * "Allocated" pkeys are those that have been returned
-	 * from pkey_alloc().  pkey 0 is special, and never
-	 * returned from pkey_alloc().
+	 * from pkey_alloc() or pkey 0 which is allocated
+	 * implicitly when the mm is created.
 	 */
-	if (pkey <= 0)
+	if (pkey < 0)
 		return false;
 	if (pkey >= arch_max_pkey())
 		return false;
+	/*
+	 * The exec-only pkey is set in the allocation map, but
+	 * is not available to any of the user interfaces like
+	 * mprotect_pkey().
+	 */
+	if (pkey == mm->context.execute_only_pkey)
+		return false;
+
 	return mm_pkey_allocation_map(mm) & (1U << pkey);
 }
 
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 8b04234e010b..7685444a106b 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -116,6 +116,7 @@ static void init_x2apic_ldr(void)
 			goto update;
 	}
 	cmsk = cluster_hotplug_mask;
+	cmsk->clusterid = cluster;
 	cluster_hotplug_mask = NULL;
 update:
 	this_cpu_write(cluster_masks, cmsk);
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 0c408f8c4ed4..2d29e47c056e 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -104,6 +104,12 @@ static bool __head check_la57_support(unsigned long physaddr)
 }
 #endif
 
+/* Code in __startup_64() can be relocated during execution, but the compiler
+ * doesn't have to generate PC-relative relocations when accessing globals from
+ * that function. Clang actually does not generate them, which leads to
+ * boot-time crashes. To work around this problem, every global pointer must
+ * be adjusted using fixup_pointer().
+ */
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
@@ -113,6 +119,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	p4dval_t *p4d;
 	pudval_t *pud;
 	pmdval_t *pmd, pmd_entry;
+	pteval_t *mask_ptr;
 	bool la57;
 	int i;
 	unsigned int *next_pgt_ptr;
@@ -196,7 +203,8 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
 	/* Filter out unsupported __PAGE_KERNEL_* bits: */
-	pmd_entry &= __supported_pte_mask;
+	mask_ptr = fixup_pointer(&__supported_pte_mask, physaddr);
+	pmd_entry &= *mask_ptr;
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 0715f827607c..6f4d42377fe5 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -370,6 +370,10 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 	if (insn->opcode.bytes[0] == BREAKPOINT_INSTRUCTION)
 		return 0;
 
+	/* We should not singlestep on the exception masking instructions */
+	if (insn_masking_exception(insn))
+		return 0;
+
 #ifdef CONFIG_X86_64
 	/* Only x86_64 has RIP relative instructions */
 	if (insn_rip_relative(insn)) {
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 60cdec6628b0..d1ab07ec8c9a 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -57,12 +57,17 @@ static void load_segments(void)
 static void machine_kexec_free_page_tables(struct kimage *image)
 {
 	free_page((unsigned long)image->arch.pgd);
+	image->arch.pgd = NULL;
 #ifdef CONFIG_X86_PAE
 	free_page((unsigned long)image->arch.pmd0);
+	image->arch.pmd0 = NULL;
 	free_page((unsigned long)image->arch.pmd1);
+	image->arch.pmd1 = NULL;
 #endif
 	free_page((unsigned long)image->arch.pte0);
+	image->arch.pte0 = NULL;
 	free_page((unsigned long)image->arch.pte1);
+	image->arch.pte1 = NULL;
 }
 
 static int machine_kexec_alloc_page_tables(struct kimage *image)
@@ -79,7 +84,6 @@ static int machine_kexec_alloc_page_tables(struct kimage *image)
 	    !image->arch.pmd0 || !image->arch.pmd1 ||
 #endif
 	    !image->arch.pte0 || !image->arch.pte1) {
-		machine_kexec_free_page_tables(image);
 		return -ENOMEM;
 	}
 	return 0;
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index a5e55d832d0a..6010449ca6d2 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -39,9 +39,13 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 static void free_transition_pgtable(struct kimage *image)
 {
 	free_page((unsigned long)image->arch.p4d);
+	image->arch.p4d = NULL;
 	free_page((unsigned long)image->arch.pud);
+	image->arch.pud = NULL;
 	free_page((unsigned long)image->arch.pmd);
+	image->arch.pmd = NULL;
 	free_page((unsigned long)image->arch.pte);
+	image->arch.pte = NULL;
 }
 
 static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
@@ -91,7 +95,6 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
 	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL_EXEC_NOENC));
 	return 0;
 err:
-	free_transition_pgtable(image);
 	return result;
 }
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4b100fe0f508..12bb445fb98d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -542,6 +542,7 @@ void set_personality_64bit(void)
 	clear_thread_flag(TIF_X32);
 	/* Pretend that this comes from a 64bit execve */
 	task_pt_regs(current)->orig_ax = __NR_execve;
+	current_thread_info()->status &= ~TS_COMPAT;
 
 	/* Ensure the corresponding mm is not marked. */
 	if (current->mm)
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 85c7ef23d99f..c84bb5396958 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -299,6 +299,10 @@ static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool
 	if (is_prefix_bad(insn))
 		return -ENOTSUPP;
 
+	/* We should not singlestep on the exception masking instructions */
+	if (insn_masking_exception(insn))
+		return -ENOTSUPP;
+
 	if (x86_64)
 		good_insns = good_insns_64;
 	else
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index d7bc0eea20a5..6e98e0a7c923 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -94,26 +94,27 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot, int pkey
 	 */
 	if (pkey != -1)
 		return pkey;
-	/*
-	 * Look for a protection-key-drive execute-only mapping
-	 * which is now being given permissions that are not
-	 * execute-only.  Move it back to the default pkey.
-	 */
-	if (vma_is_pkey_exec_only(vma) &&
-	    (prot & (PROT_READ|PROT_WRITE))) {
-		return 0;
-	}
+
 	/*
 	 * The mapping is execute-only.  Go try to get the
 	 * execute-only protection key.  If we fail to do that,
 	 * fall through as if we do not have execute-only
-	 * support.
+	 * support in this mm.
 	 */
 	if (prot == PROT_EXEC) {
 		pkey = execute_only_pkey(vma->vm_mm);
 		if (pkey > 0)
 			return pkey;
+	} else if (vma_is_pkey_exec_only(vma)) {
+		/*
+		 * Protections are *not* PROT_EXEC, but the mapping
+		 * is using the exec-only pkey.  This mapping was
+		 * PROT_EXEC and will no longer be.  Move back to
+		 * the default pkey.
+		 */
+		return ARCH_DEFAULT_PKEY;
 	}
+
 	/*
 	 * This is a vanilla, non-pkey mprotect (or we failed to
 	 * setup execute-only), inherit the pkey from the VMA we
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 4d6a6edd4bf6..092947676143 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -255,7 +255,7 @@ $(obj)/tracex5_kern.o: $(obj)/syscall_nrs.h
 $(obj)/%.o: $(src)/%.c
 	$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) -I$(obj) \
 		-I$(srctree)/tools/testing/selftests/bpf/ \
-		-D__KERNEL__ -Wno-unused-value -Wno-pointer-sign \
+		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
 		-D__TARGET_ARCH_$(ARCH) -Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
 		-Wno-address-of-packed-member -Wno-tautological-compare \
diff --git a/tools/objtool/arch/x86/include/asm/insn.h b/tools/objtool/arch/x86/include/asm/insn.h
index b3e32b010ab1..c2c01f84df75 100644
--- a/tools/objtool/arch/x86/include/asm/insn.h
+++ b/tools/objtool/arch/x86/include/asm/insn.h
@@ -208,4 +208,22 @@ static inline int insn_offset_immediate(struct insn *insn)
 	return insn_offset_displacement(insn) + insn->displacement.nbytes;
 }
 
+#define POP_SS_OPCODE 0x1f
+#define MOV_SREG_OPCODE 0x8e
+
+/*
+ * Intel SDM Vol.3A 6.8.3 states;
+ * "Any single-step trap that would be delivered following the MOV to SS
+ * instruction or POP to SS instruction (because EFLAGS.TF is 1) is
+ * suppressed."
+ * This function returns true if @insn is MOV SS or POP SS. On these
+ * instructions, single stepping is suppressed.
+ */
+static inline int insn_masking_exception(struct insn *insn)
+{
+	return insn->opcode.bytes[0] == POP_SS_OPCODE ||
+		(insn->opcode.bytes[0] == MOV_SREG_OPCODE &&
+		 X86_MODRM_REG(insn->modrm.bytes[0]) == 2);
+}
+
 #endif /* _ASM_X86_INSN_H */
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index d744991c0f4f..39f66bc29b82 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -11,7 +11,7 @@ CAN_BUILD_X86_64 := $(shell ./check_cc.sh $(CC) trivial_64bit_program.c)
 
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl mpx-mini-test ioperm \
-			protection_keys test_vdso test_vsyscall
+			protection_keys test_vdso test_vsyscall mov_ss_trap
 TARGETS_C_32BIT_ONLY := entry_from_vm86 syscall_arg_fault test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
diff --git a/tools/testing/selftests/x86/mov_ss_trap.c b/tools/testing/selftests/x86/mov_ss_trap.c
new file mode 100644
index 000000000000..3c3a022654f3
--- /dev/null
+++ b/tools/testing/selftests/x86/mov_ss_trap.c
@@ -0,0 +1,285 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mov_ss_trap.c: Exercise the bizarre side effects of a watchpoint on MOV SS
+ *
+ * This does MOV SS from a watchpointed address followed by various
+ * types of kernel entries.  A MOV SS that hits a watchpoint will queue
+ * up a #DB trap but will not actually deliver that trap.  The trap
+ * will be delivered after the next instruction instead.  The CPU's logic
+ * seems to be:
+ *
+ *  - Any fault: drop the pending #DB trap.
+ *  - INT $N, INT3, INTO, SYSCALL, SYSENTER: enter the kernel and then
+ *    deliver #DB.
+ *  - ICEBP: enter the kernel but do not deliver the watchpoint trap
+ *  - breakpoint: only one #DB is delivered (phew!)
+ *
+ * There are plenty of ways for a kernel to handle this incorrectly.  This
+ * test tries to exercise all the cases.
+ *
+ * This should mostly cover CVE-2018-1087 and CVE-2018-8897.
+ */
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <sys/ptrace.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/user.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <err.h>
+#include <string.h>
+#include <setjmp.h>
+#include <sys/prctl.h>
+
+#define X86_EFLAGS_RF (1UL << 16)
+
+#if __x86_64__
+# define REG_IP REG_RIP
+#else
+# define REG_IP REG_EIP
+#endif
+
+unsigned short ss;
+extern unsigned char breakpoint_insn[];
+sigjmp_buf jmpbuf;
+static unsigned char altstack_data[SIGSTKSZ];
+
+static void enable_watchpoint(void)
+{
+	pid_t parent = getpid();
+	int status;
+
+	pid_t child = fork();
+	if (child < 0)
+		err(1, "fork");
+
+	if (child) {
+		if (waitpid(child, &status, 0) != child)
+			err(1, "waitpid for child");
+	} else {
+		unsigned long dr0, dr1, dr7;
+
+		dr0 = (unsigned long)&ss;
+		dr1 = (unsigned long)breakpoint_insn;
+		dr7 = ((1UL << 1) |	/* G0 */
+		       (3UL << 16) |	/* RW0 = read or write */
+		       (1UL << 18) |	/* LEN0 = 2 bytes */
+		       (1UL << 3));	/* G1, RW1 = insn */
+
+		if (ptrace(PTRACE_ATTACH, parent, NULL, NULL) != 0)
+			err(1, "PTRACE_ATTACH");
+
+		if (waitpid(parent, &status, 0) != parent)
+			err(1, "waitpid for child");
+
+		if (ptrace(PTRACE_POKEUSER, parent, (void *)offsetof(struct user, u_debugreg[0]), dr0) != 0)
+			err(1, "PTRACE_POKEUSER DR0");
+
+		if (ptrace(PTRACE_POKEUSER, parent, (void *)offsetof(struct user, u_debugreg[1]), dr1) != 0)
+			err(1, "PTRACE_POKEUSER DR1");
+
+		if (ptrace(PTRACE_POKEUSER, parent, (void *)offsetof(struct user, u_debugreg[7]), dr7) != 0)
+			err(1, "PTRACE_POKEUSER DR7");
+
+		printf("\tDR0 = %lx, DR1 = %lx, DR7 = %lx\n", dr0, dr1, dr7);
+
+		if (ptrace(PTRACE_DETACH, parent, NULL, NULL) != 0)
+			err(1, "PTRACE_DETACH");
+
+		exit(0);
+	}
+}
+
+static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
+		       int flags)
+{
+	struct sigaction sa;
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handler;
+	sa.sa_flags = SA_SIGINFO | flags;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(sig, &sa, 0))
+		err(1, "sigaction");
+}
+
+static char const * const signames[] = {
+	[SIGSEGV] = "SIGSEGV",
+	[SIGBUS] = "SIBGUS",
+	[SIGTRAP] = "SIGTRAP",
+	[SIGILL] = "SIGILL",
+};
+
+static void sigtrap(int sig, siginfo_t *si, void *ctx_void)
+{
+	ucontext_t *ctx = ctx_void;
+
+	printf("\tGot SIGTRAP with RIP=%lx, EFLAGS.RF=%d\n",
+	       (unsigned long)ctx->uc_mcontext.gregs[REG_IP],
+	       !!(ctx->uc_mcontext.gregs[REG_EFL] & X86_EFLAGS_RF));
+}
+
+static void handle_and_return(int sig, siginfo_t *si, void *ctx_void)
+{
+	ucontext_t *ctx = ctx_void;
+
+	printf("\tGot %s with RIP=%lx\n", signames[sig],
+	       (unsigned long)ctx->uc_mcontext.gregs[REG_IP]);
+}
+
+static void handle_and_longjmp(int sig, siginfo_t *si, void *ctx_void)
+{
+	ucontext_t *ctx = ctx_void;
+
+	printf("\tGot %s with RIP=%lx\n", signames[sig],
+	       (unsigned long)ctx->uc_mcontext.gregs[REG_IP]);
+
+	siglongjmp(jmpbuf, 1);
+}
+
+int main()
+{
+	unsigned long nr;
+
+	asm volatile ("mov %%ss, %[ss]" : [ss] "=m" (ss));
+	printf("\tSS = 0x%hx, &SS = 0x%p\n", ss, &ss);
+
+	if (prctl(PR_SET_PTRACER, PR_SET_PTRACER_ANY, 0, 0, 0) == 0)
+		printf("\tPR_SET_PTRACER_ANY succeeded\n");
+
+	printf("\tSet up a watchpoint\n");
+	sethandler(SIGTRAP, sigtrap, 0);
+	enable_watchpoint();
+
+	printf("[RUN]\tRead from watched memory (should get SIGTRAP)\n");
+	asm volatile ("mov %[ss], %[tmp]" : [tmp] "=r" (nr) : [ss] "m" (ss));
+
+	printf("[RUN]\tMOV SS; INT3\n");
+	asm volatile ("mov %[ss], %%ss; int3" :: [ss] "m" (ss));
+
+	printf("[RUN]\tMOV SS; INT 3\n");
+	asm volatile ("mov %[ss], %%ss; .byte 0xcd, 0x3" :: [ss] "m" (ss));
+
+	printf("[RUN]\tMOV SS; CS CS INT3\n");
+	asm volatile ("mov %[ss], %%ss; .byte 0x2e, 0x2e; int3" :: [ss] "m" (ss));
+
+	printf("[RUN]\tMOV SS; CSx14 INT3\n");
+	asm volatile ("mov %[ss], %%ss; .fill 14,1,0x2e; int3" :: [ss] "m" (ss));
+
+	printf("[RUN]\tMOV SS; INT 4\n");
+	sethandler(SIGSEGV, handle_and_return, SA_RESETHAND);
+	asm volatile ("mov %[ss], %%ss; int $4" :: [ss] "m" (ss));
+
+#ifdef __i386__
+	printf("[RUN]\tMOV SS; INTO\n");
+	sethandler(SIGSEGV, handle_and_return, SA_RESETHAND);
+	nr = -1;
+	asm volatile ("add $1, %[tmp]; mov %[ss], %%ss; into"
+		      : [tmp] "+r" (nr) : [ss] "m" (ss));
+#endif
+
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		printf("[RUN]\tMOV SS; ICEBP\n");
+
+		/* Some emulators (e.g. QEMU TCG) don't emulate ICEBP. */
+		sethandler(SIGILL, handle_and_longjmp, SA_RESETHAND);
+
+		asm volatile ("mov %[ss], %%ss; .byte 0xf1" :: [ss] "m" (ss));
+	}
+
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		printf("[RUN]\tMOV SS; CLI\n");
+		sethandler(SIGSEGV, handle_and_longjmp, SA_RESETHAND);
+		asm volatile ("mov %[ss], %%ss; cli" :: [ss] "m" (ss));
+	}
+
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		printf("[RUN]\tMOV SS; #PF\n");
+		sethandler(SIGSEGV, handle_and_longjmp, SA_RESETHAND);
+		asm volatile ("mov %[ss], %%ss; mov (-1), %[tmp]"
+			      : [tmp] "=r" (nr) : [ss] "m" (ss));
+	}
+
+	/*
+	 * INT $1: if #DB has DPL=3 and there isn't special handling,
+	 * then the kernel will die.
+	 */
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		printf("[RUN]\tMOV SS; INT 1\n");
+		sethandler(SIGSEGV, handle_and_longjmp, SA_RESETHAND);
+		asm volatile ("mov %[ss], %%ss; int $1" :: [ss] "m" (ss));
+	}
+
+#ifdef __x86_64__
+	/*
+	 * In principle, we should test 32-bit SYSCALL as well, but
+	 * the calling convention is so unpredictable that it's
+	 * not obviously worth the effort.
+	 */
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		printf("[RUN]\tMOV SS; SYSCALL\n");
+		sethandler(SIGILL, handle_and_longjmp, SA_RESETHAND);
+		nr = SYS_getpid;
+		/*
+		 * Toggle the high bit of RSP to make it noncanonical to
+		 * strengthen this test on non-SMAP systems.
+		 */
+		asm volatile ("btc $63, %%rsp\n\t"
+			      "mov %[ss], %%ss; syscall\n\t"
+			      "btc $63, %%rsp"
+			      : "+a" (nr) : [ss] "m" (ss)
+			      : "rcx"
+#ifdef __x86_64__
+				, "r11"
+#endif
+			);
+	}
+#endif
+
+	printf("[RUN]\tMOV SS; breakpointed NOP\n");
+	asm volatile ("mov %[ss], %%ss; breakpoint_insn: nop" :: [ss] "m" (ss));
+
+	/*
+	 * Invoking SYSENTER directly breaks all the rules.  Just handle
+	 * the SIGSEGV.
+	 */
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		printf("[RUN]\tMOV SS; SYSENTER\n");
+		stack_t stack = {
+			.ss_sp = altstack_data,
+			.ss_size = SIGSTKSZ,
+		};
+		if (sigaltstack(&stack, NULL) != 0)
+			err(1, "sigaltstack");
+		sethandler(SIGSEGV, handle_and_longjmp, SA_RESETHAND | SA_ONSTACK);
+		nr = SYS_getpid;
+		asm volatile ("mov %[ss], %%ss; SYSENTER" : "+a" (nr)
+			      : [ss] "m" (ss) : "flags", "rcx"
+#ifdef __x86_64__
+				, "r11"
+#endif
+			);
+
+		/* We're unreachable here.  SYSENTER forgets RIP. */
+	}
+
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		printf("[RUN]\tMOV SS; INT $0x80\n");
+		sethandler(SIGSEGV, handle_and_longjmp, SA_RESETHAND);
+		nr = 20;	/* compat getpid */
+		asm volatile ("mov %[ss], %%ss; int $0x80"
+			      : "+a" (nr) : [ss] "m" (ss)
+			      : "flags"
+#ifdef __x86_64__
+				, "r8", "r9", "r10", "r11"
+#endif
+			);
+	}
+
+	printf("[OK]\tI aten't dead\n");
+	return 0;
+}
diff --git a/tools/testing/selftests/x86/mpx-mini-test.c b/tools/testing/selftests/x86/mpx-mini-test.c
index 9c0325e1ea68..50f7e9272481 100644
--- a/tools/testing/selftests/x86/mpx-mini-test.c
+++ b/tools/testing/selftests/x86/mpx-mini-test.c
@@ -368,6 +368,11 @@ static int expected_bnd_index = -1;
 uint64_t shadow_plb[NR_MPX_BOUNDS_REGISTERS][2]; /* shadow MPX bound registers */
 unsigned long shadow_map[NR_MPX_BOUNDS_REGISTERS];
 
+/* Failed address bound checks: */
+#ifndef SEGV_BNDERR
+# define SEGV_BNDERR	3
+#endif
+
 /*
  * The kernel is supposed to provide some information about the bounds
  * exception in the siginfo.  It should match what we have in the bounds
@@ -419,8 +424,6 @@ void handler(int signum, siginfo_t *si, void *vucontext)
 		br_count++;
 		dprintf1("#BR 0x%jx (total seen: %d)\n", status, br_count);
 
-#define SEGV_BNDERR     3  /* failed address bound checks */
-
 		dprintf2("Saw a #BR! status 0x%jx at %016lx br_reason: %jx\n",
 				status, ip, br_reason);
 		dprintf2("si_signo: %d\n", si->si_signo);
diff --git a/tools/testing/selftests/x86/pkey-helpers.h b/tools/testing/selftests/x86/pkey-helpers.h
index b3cb7670e026..254e5436bdd9 100644
--- a/tools/testing/selftests/x86/pkey-helpers.h
+++ b/tools/testing/selftests/x86/pkey-helpers.h
@@ -26,30 +26,26 @@ static inline void sigsafe_printf(const char *format, ...)
 {
 	va_list ap;
 
-	va_start(ap, format);
 	if (!dprint_in_signal) {
+		va_start(ap, format);
 		vprintf(format, ap);
+		va_end(ap);
 	} else {
 		int ret;
-		int len = vsnprintf(dprint_in_signal_buffer,
-				    DPRINT_IN_SIGNAL_BUF_SIZE,
-				    format, ap);
 		/*
-		 * len is amount that would have been printed,
-		 * but actual write is truncated at BUF_SIZE.
+		 * No printf() functions are signal-safe.
+		 * They deadlock easily. Write the format
+		 * string to get some output, even if
+		 * incomplete.
 		 */
-		if (len > DPRINT_IN_SIGNAL_BUF_SIZE)
-			len = DPRINT_IN_SIGNAL_BUF_SIZE;
-		ret = write(1, dprint_in_signal_buffer, len);
+		ret = write(1, format, strlen(format));
 		if (ret < 0)
-			abort();
+			exit(1);
 	}
-	va_end(ap);
 }
 #define dprintf_level(level, args...) do {	\
 	if (level <= DEBUG_LEVEL)		\
 		sigsafe_printf(args);		\
-	fflush(NULL);				\
 } while (0)
 #define dprintf0(args...) dprintf_level(0, args)
 #define dprintf1(args...) dprintf_level(1, args)
diff --git a/tools/testing/selftests/x86/protection_keys.c b/tools/testing/selftests/x86/protection_keys.c
index f15aa5a76fe3..460b4bdf4c1e 100644
--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -72,10 +72,9 @@ extern void abort_hooks(void);
 				test_nr, iteration_nr);	\
 		dprintf0("errno at assert: %d", errno);	\
 		abort_hooks();			\
-		assert(condition);		\
+		exit(__LINE__);			\
 	}					\
 } while (0)
-#define raw_assert(cond) assert(cond)
 
 void cat_into_file(char *str, char *file)
 {
@@ -87,12 +86,17 @@ void cat_into_file(char *str, char *file)
 	 * these need to be raw because they are called under
 	 * pkey_assert()
 	 */
-	raw_assert(fd >= 0);
+	if (fd < 0) {
+		fprintf(stderr, "error opening '%s'\n", str);
+		perror("error: ");
+		exit(__LINE__);
+	}
+
 	ret = write(fd, str, strlen(str));
 	if (ret != strlen(str)) {
 		perror("write to file failed");
 		fprintf(stderr, "filename: '%s' str: '%s'\n", file, str);
-		raw_assert(0);
+		exit(__LINE__);
 	}
 	close(fd);
 }
@@ -191,26 +195,30 @@ void lots_o_noops_around_write(int *write_to_me)
 #ifdef __i386__
 
 #ifndef SYS_mprotect_key
-# define SYS_mprotect_key 380
+# define SYS_mprotect_key	380
 #endif
+
 #ifndef SYS_pkey_alloc
-# define SYS_pkey_alloc	 381
-# define SYS_pkey_free	 382
+# define SYS_pkey_alloc		381
+# define SYS_pkey_free		382
 #endif
-#define REG_IP_IDX REG_EIP
-#define si_pkey_offset 0x14
+
+#define REG_IP_IDX		REG_EIP
+#define si_pkey_offset		0x14
 
 #else
 
 #ifndef SYS_mprotect_key
-# define SYS_mprotect_key 329
+# define SYS_mprotect_key	329
 #endif
+
 #ifndef SYS_pkey_alloc
-# define SYS_pkey_alloc	 330
-# define SYS_pkey_free	 331
+# define SYS_pkey_alloc		330
+# define SYS_pkey_free		331
 #endif
-#define REG_IP_IDX REG_RIP
-#define si_pkey_offset 0x20
+
+#define REG_IP_IDX		REG_RIP
+#define si_pkey_offset		0x20
 
 #endif
 
@@ -225,8 +233,14 @@ void dump_mem(void *dumpme, int len_bytes)
 	}
 }
 
-#define SEGV_BNDERR     3  /* failed address bound checks */
-#define SEGV_PKUERR     4
+/* Failed address bound checks: */
+#ifndef SEGV_BNDERR
+# define SEGV_BNDERR		3
+#endif
+
+#ifndef SEGV_PKUERR
+# define SEGV_PKUERR		4
+#endif
 
 static char *si_code_str(int si_code)
 {
@@ -289,13 +303,6 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 		dump_mem(pkru_ptr - 128, 256);
 	pkey_assert(*pkru_ptr);
 
-	si_pkey_ptr = (u32 *)(((u8 *)si) + si_pkey_offset);
-	dprintf1("si_pkey_ptr: %p\n", si_pkey_ptr);
-	dump_mem(si_pkey_ptr - 8, 24);
-	siginfo_pkey = *si_pkey_ptr;
-	pkey_assert(siginfo_pkey < NR_PKEYS);
-	last_si_pkey = siginfo_pkey;
-
 	if ((si->si_code == SEGV_MAPERR) ||
 	    (si->si_code == SEGV_ACCERR) ||
 	    (si->si_code == SEGV_BNDERR)) {
@@ -303,6 +310,13 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 		exit(4);
 	}
 
+	si_pkey_ptr = (u32 *)(((u8 *)si) + si_pkey_offset);
+	dprintf1("si_pkey_ptr: %p\n", si_pkey_ptr);
+	dump_mem((u8 *)si_pkey_ptr - 8, 24);
+	siginfo_pkey = *si_pkey_ptr;
+	pkey_assert(siginfo_pkey < NR_PKEYS);
+	last_si_pkey = siginfo_pkey;
+
 	dprintf1("signal pkru from xsave: %08x\n", *pkru_ptr);
 	/* need __rdpkru() version so we do not do shadow_pkru checking */
 	dprintf1("signal pkru from  pkru: %08x\n", __rdpkru());
@@ -311,22 +325,6 @@ void signal_handler(int signum, siginfo_t *si, void *vucontext)
 	dprintf1("WARNING: set PRKU=0 to allow faulting instruction to continue\n");
 	pkru_faults++;
 	dprintf1("<<<<==================================================\n");
-	return;
-	if (trapno == 14) {
-		fprintf(stderr,
-			"ERROR: In signal handler, page fault, trapno = %d, ip = %016lx\n",
-			trapno, ip);
-		fprintf(stderr, "si_addr %p\n", si->si_addr);
-		fprintf(stderr, "REG_ERR: %lx\n",
-				(unsigned long)uctxt->uc_mcontext.gregs[REG_ERR]);
-		exit(1);
-	} else {
-		fprintf(stderr, "unexpected trap %d! at 0x%lx\n", trapno, ip);
-		fprintf(stderr, "si_addr %p\n", si->si_addr);
-		fprintf(stderr, "REG_ERR: %lx\n",
-				(unsigned long)uctxt->uc_mcontext.gregs[REG_ERR]);
-		exit(2);
-	}
 	dprint_in_signal = 0;
 }
 
@@ -393,10 +391,15 @@ pid_t fork_lazy_child(void)
 	return forkret;
 }
 
-#define PKEY_DISABLE_ACCESS    0x1
-#define PKEY_DISABLE_WRITE     0x2
+#ifndef PKEY_DISABLE_ACCESS
+# define PKEY_DISABLE_ACCESS	0x1
+#endif
+
+#ifndef PKEY_DISABLE_WRITE
+# define PKEY_DISABLE_WRITE	0x2
+#endif
 
-u32 pkey_get(int pkey, unsigned long flags)
+static u32 hw_pkey_get(int pkey, unsigned long flags)
 {
 	u32 mask = (PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE);
 	u32 pkru = __rdpkru();
@@ -418,7 +421,7 @@ u32 pkey_get(int pkey, unsigned long flags)
 	return masked_pkru;
 }
 
-int pkey_set(int pkey, unsigned long rights, unsigned long flags)
+static int hw_pkey_set(int pkey, unsigned long rights, unsigned long flags)
 {
 	u32 mask = (PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE);
 	u32 old_pkru = __rdpkru();
@@ -452,15 +455,15 @@ void pkey_disable_set(int pkey, int flags)
 		pkey, flags);
 	pkey_assert(flags & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
 
-	pkey_rights = pkey_get(pkey, syscall_flags);
+	pkey_rights = hw_pkey_get(pkey, syscall_flags);
 
-	dprintf1("%s(%d) pkey_get(%d): %x\n", __func__,
+	dprintf1("%s(%d) hw_pkey_get(%d): %x\n", __func__,
 			pkey, pkey, pkey_rights);
 	pkey_assert(pkey_rights >= 0);
 
 	pkey_rights |= flags;
 
-	ret = pkey_set(pkey, pkey_rights, syscall_flags);
+	ret = hw_pkey_set(pkey, pkey_rights, syscall_flags);
 	assert(!ret);
 	/*pkru and flags have the same format */
 	shadow_pkru |= flags << (pkey * 2);
@@ -468,8 +471,8 @@ void pkey_disable_set(int pkey, int flags)
 
 	pkey_assert(ret >= 0);
 
-	pkey_rights = pkey_get(pkey, syscall_flags);
-	dprintf1("%s(%d) pkey_get(%d): %x\n", __func__,
+	pkey_rights = hw_pkey_get(pkey, syscall_flags);
+	dprintf1("%s(%d) hw_pkey_get(%d): %x\n", __func__,
 			pkey, pkey, pkey_rights);
 
 	dprintf1("%s(%d) pkru: 0x%x\n", __func__, pkey, rdpkru());
@@ -483,24 +486,24 @@ void pkey_disable_clear(int pkey, int flags)
 {
 	unsigned long syscall_flags = 0;
 	int ret;
-	int pkey_rights = pkey_get(pkey, syscall_flags);
+	int pkey_rights = hw_pkey_get(pkey, syscall_flags);
 	u32 orig_pkru = rdpkru();
 
 	pkey_assert(flags & (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
 
-	dprintf1("%s(%d) pkey_get(%d): %x\n", __func__,
+	dprintf1("%s(%d) hw_pkey_get(%d): %x\n", __func__,
 			pkey, pkey, pkey_rights);
 	pkey_assert(pkey_rights >= 0);
 
 	pkey_rights |= flags;
 
-	ret = pkey_set(pkey, pkey_rights, 0);
+	ret = hw_pkey_set(pkey, pkey_rights, 0);
 	/* pkru and flags have the same format */
 	shadow_pkru &= ~(flags << (pkey * 2));
 	pkey_assert(ret >= 0);
 
-	pkey_rights = pkey_get(pkey, syscall_flags);
-	dprintf1("%s(%d) pkey_get(%d): %x\n", __func__,
+	pkey_rights = hw_pkey_get(pkey, syscall_flags);
+	dprintf1("%s(%d) hw_pkey_get(%d): %x\n", __func__,
 			pkey, pkey, pkey_rights);
 
 	dprintf1("%s(%d) pkru: 0x%x\n", __func__, pkey, rdpkru());
@@ -674,10 +677,12 @@ int mprotect_pkey(void *ptr, size_t size, unsigned long orig_prot,
 struct pkey_malloc_record {
 	void *ptr;
 	long size;
+	int prot;
 };
 struct pkey_malloc_record *pkey_malloc_records;
+struct pkey_malloc_record *pkey_last_malloc_record;
 long nr_pkey_malloc_records;
-void record_pkey_malloc(void *ptr, long size)
+void record_pkey_malloc(void *ptr, long size, int prot)
 {
 	long i;
 	struct pkey_malloc_record *rec = NULL;
@@ -709,6 +714,8 @@ void record_pkey_malloc(void *ptr, long size)
 		(int)(rec - pkey_malloc_records), rec, ptr, size);
 	rec->ptr = ptr;
 	rec->size = size;
+	rec->prot = prot;
+	pkey_last_malloc_record = rec;
 	nr_pkey_malloc_records++;
 }
 
@@ -753,7 +760,7 @@ void *malloc_pkey_with_mprotect(long size, int prot, u16 pkey)
 	pkey_assert(ptr != (void *)-1);
 	ret = mprotect_pkey((void *)ptr, PAGE_SIZE, prot, pkey);
 	pkey_assert(!ret);
-	record_pkey_malloc(ptr, size);
+	record_pkey_malloc(ptr, size, prot);
 	rdpkru();
 
 	dprintf1("%s() for pkey %d @ %p\n", __func__, pkey, ptr);
@@ -774,7 +781,7 @@ void *malloc_pkey_anon_huge(long size, int prot, u16 pkey)
 	size = ALIGN_UP(size, HPAGE_SIZE * 2);
 	ptr = mmap(NULL, size, PROT_NONE, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
 	pkey_assert(ptr != (void *)-1);
-	record_pkey_malloc(ptr, size);
+	record_pkey_malloc(ptr, size, prot);
 	mprotect_pkey(ptr, size, prot, pkey);
 
 	dprintf1("unaligned ptr: %p\n", ptr);
@@ -847,7 +854,7 @@ void *malloc_pkey_hugetlb(long size, int prot, u16 pkey)
 	pkey_assert(ptr != (void *)-1);
 	mprotect_pkey(ptr, size, prot, pkey);
 
-	record_pkey_malloc(ptr, size);
+	record_pkey_malloc(ptr, size, prot);
 
 	dprintf1("mmap()'d hugetlbfs for pkey %d @ %p\n", pkey, ptr);
 	return ptr;
@@ -869,7 +876,7 @@ void *malloc_pkey_mmap_dax(long size, int prot, u16 pkey)
 
 	mprotect_pkey(ptr, size, prot, pkey);
 
-	record_pkey_malloc(ptr, size);
+	record_pkey_malloc(ptr, size, prot);
 
 	dprintf1("mmap()'d for pkey %d @ %p\n", pkey, ptr);
 	close(fd);
@@ -918,13 +925,21 @@ void *malloc_pkey(long size, int prot, u16 pkey)
 }
 
 int last_pkru_faults;
+#define UNKNOWN_PKEY -2
 void expected_pk_fault(int pkey)
 {
 	dprintf2("%s(): last_pkru_faults: %d pkru_faults: %d\n",
 			__func__, last_pkru_faults, pkru_faults);
 	dprintf2("%s(%d): last_si_pkey: %d\n", __func__, pkey, last_si_pkey);
 	pkey_assert(last_pkru_faults + 1 == pkru_faults);
-	pkey_assert(last_si_pkey == pkey);
+
+       /*
+	* For exec-only memory, we do not know the pkey in
+	* advance, so skip this check.
+	*/
+	if (pkey != UNKNOWN_PKEY)
+		pkey_assert(last_si_pkey == pkey);
+
 	/*
 	 * The signal handler shold have cleared out PKRU to let the
 	 * test program continue.  We now have to restore it.
@@ -939,10 +954,11 @@ void expected_pk_fault(int pkey)
 	last_si_pkey = -1;
 }
 
-void do_not_expect_pk_fault(void)
-{
-	pkey_assert(last_pkru_faults == pkru_faults);
-}
+#define do_not_expect_pk_fault(msg)	do {			\
+	if (last_pkru_faults != pkru_faults)			\
+		dprintf0("unexpected PK fault: %s\n", msg);	\
+	pkey_assert(last_pkru_faults == pkru_faults);		\
+} while (0)
 
 int test_fds[10] = { -1 };
 int nr_test_fds;
@@ -1151,12 +1167,15 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 	pkey_assert(i < NR_PKEYS*2);
 
 	/*
-	 * There are 16 pkeys supported in hardware.  One is taken
-	 * up for the default (0) and another can be taken up by
-	 * an execute-only mapping.  Ensure that we can allocate
-	 * at least 14 (16-2).
+	 * There are 16 pkeys supported in hardware.  Three are
+	 * allocated by the time we get here:
+	 *   1. The default key (0)
+	 *   2. One possibly consumed by an execute-only mapping.
+	 *   3. One allocated by the test code and passed in via
+	 *      'pkey' to this function.
+	 * Ensure that we can allocate at least another 13 (16-3).
 	 */
-	pkey_assert(i >= NR_PKEYS-2);
+	pkey_assert(i >= NR_PKEYS-3);
 
 	for (i = 0; i < nr_allocated_pkeys; i++) {
 		err = sys_pkey_free(allocated_pkeys[i]);
@@ -1165,6 +1184,35 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 	}
 }
 
+/*
+ * pkey 0 is special.  It is allocated by default, so you do not
+ * have to call pkey_alloc() to use it first.  Make sure that it
+ * is usable.
+ */
+void test_mprotect_with_pkey_0(int *ptr, u16 pkey)
+{
+	long size;
+	int prot;
+
+	assert(pkey_last_malloc_record);
+	size = pkey_last_malloc_record->size;
+	/*
+	 * This is a bit of a hack.  But mprotect() requires
+	 * huge-page-aligned sizes when operating on hugetlbfs.
+	 * So, make sure that we use something that's a multiple
+	 * of a huge page when we can.
+	 */
+	if (size >= HPAGE_SIZE)
+		size = HPAGE_SIZE;
+	prot = pkey_last_malloc_record->prot;
+
+	/* Use pkey 0 */
+	mprotect_pkey(ptr, size, prot, 0);
+
+	/* Make sure that we can set it back to the original pkey. */
+	mprotect_pkey(ptr, size, prot, pkey);
+}
+
 void test_ptrace_of_child(int *ptr, u16 pkey)
 {
 	__attribute__((__unused__)) int peek_result;
@@ -1228,7 +1276,7 @@ void test_ptrace_of_child(int *ptr, u16 pkey)
 	pkey_assert(ret != -1);
 	/* Now access from the current task, and expect NO exception: */
 	peek_result = read_ptr(plain_ptr);
-	do_not_expect_pk_fault();
+	do_not_expect_pk_fault("read plain pointer after ptrace");
 
 	ret = ptrace(PTRACE_DETACH, child_pid, ignored, 0);
 	pkey_assert(ret != -1);
@@ -1241,12 +1289,9 @@ void test_ptrace_of_child(int *ptr, u16 pkey)
 	free(plain_ptr_unaligned);
 }
 
-void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
+void *get_pointer_to_instructions(void)
 {
 	void *p1;
-	int scratch;
-	int ptr_contents;
-	int ret;
 
 	p1 = ALIGN_PTR_UP(&lots_o_noops_around_write, PAGE_SIZE);
 	dprintf3("&lots_o_noops: %p\n", &lots_o_noops_around_write);
@@ -1256,7 +1301,23 @@ void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
 	/* Point 'p1' at the *second* page of the function: */
 	p1 += PAGE_SIZE;
 
+	/*
+	 * Try to ensure we fault this in on next touch to ensure
+	 * we get an instruction fault as opposed to a data one
+	 */
 	madvise(p1, PAGE_SIZE, MADV_DONTNEED);
+
+	return p1;
+}
+
+void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
+{
+	void *p1;
+	int scratch;
+	int ptr_contents;
+	int ret;
+
+	p1 = get_pointer_to_instructions();
 	lots_o_noops_around_write(&scratch);
 	ptr_contents = read_ptr(p1);
 	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
@@ -1272,12 +1333,55 @@ void test_executing_on_unreadable_memory(int *ptr, u16 pkey)
 	 */
 	madvise(p1, PAGE_SIZE, MADV_DONTNEED);
 	lots_o_noops_around_write(&scratch);
-	do_not_expect_pk_fault();
+	do_not_expect_pk_fault("executing on PROT_EXEC memory");
 	ptr_contents = read_ptr(p1);
 	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
 	expected_pk_fault(pkey);
 }
 
+void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
+{
+	void *p1;
+	int scratch;
+	int ptr_contents;
+	int ret;
+
+	dprintf1("%s() start\n", __func__);
+
+	p1 = get_pointer_to_instructions();
+	lots_o_noops_around_write(&scratch);
+	ptr_contents = read_ptr(p1);
+	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
+
+	/* Use a *normal* mprotect(), not mprotect_pkey(): */
+	ret = mprotect(p1, PAGE_SIZE, PROT_EXEC);
+	pkey_assert(!ret);
+
+	dprintf2("pkru: %x\n", rdpkru());
+
+	/* Make sure this is an *instruction* fault */
+	madvise(p1, PAGE_SIZE, MADV_DONTNEED);
+	lots_o_noops_around_write(&scratch);
+	do_not_expect_pk_fault("executing on PROT_EXEC memory");
+	ptr_contents = read_ptr(p1);
+	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
+	expected_pk_fault(UNKNOWN_PKEY);
+
+	/*
+	 * Put the memory back to non-PROT_EXEC.  Should clear the
+	 * exec-only pkey off the VMA and allow it to be readable
+	 * again.  Go to PROT_NONE first to check for a kernel bug
+	 * that did not clear the pkey when doing PROT_NONE.
+	 */
+	ret = mprotect(p1, PAGE_SIZE, PROT_NONE);
+	pkey_assert(!ret);
+
+	ret = mprotect(p1, PAGE_SIZE, PROT_READ|PROT_EXEC);
+	pkey_assert(!ret);
+	ptr_contents = read_ptr(p1);
+	do_not_expect_pk_fault("plain read on recently PROT_EXEC area");
+}
+
 void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 {
 	int size = PAGE_SIZE;
@@ -1302,6 +1406,8 @@ void (*pkey_tests[])(int *ptr, u16 pkey) = {
 	test_kernel_gup_of_access_disabled_region,
 	test_kernel_gup_write_to_write_disabled_region,
 	test_executing_on_unreadable_memory,
+	test_implicit_mprotect_exec_only_memory,
+	test_mprotect_with_pkey_0,
 	test_ptrace_of_child,
 	test_pkey_syscalls_on_non_allocated_pkey,
 	test_pkey_syscalls_bad_args,
