Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92405C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D0A20846
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVarQL71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D0A20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbeIACb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 22:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbeIACb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 22:31:28 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F5DB20845;
        Fri, 31 Aug 2018 22:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535754116;
        bh=DWp18ROVSZjlX0irE5KR+Ng0x9HBdRE8zkaegMBWesI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=GVarQL71YmYZ1PON9rbxoNQ/vToRfqoMOrjX/dh+k1FRCDo5ocre4upZXKD4ngnNn
         8yxV/huGizKru4BvVbtSg9B22wL6CuREC+e5DI2vtgY65ws+873SviROHEa5bUt1gC
         Ea93zMJHmFn9xpuyotgRZXl8Sh9vdNNE+lT22fg4=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 3/3] x86/pti/64: Remove the SYSCALL64 entry trampoline
Date:   Fri, 31 Aug 2018 15:21:49 -0700
Message-Id: <ace91432011c01b721af764bc15b6c24a772f885.1535753890.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1535753890.git.luto@kernel.org>
References: <cover.1535753890.git.luto@kernel.org>
In-Reply-To: <cover.1535753890.git.luto@kernel.org>
References: <cover.1535753890.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SYSCALL64 trampoline has a couple of nice properties:

 - The usual sequence of SWAPGS followed by two GS-relative accesses to
   set up RSP is somewhat slow because the GS-relative accesses need
   to wait for SWAPGS to finish.  The trampoline approach allows
   RIP-relative accesses to set up RSP, which avoids the stall.

 - The trampoline avoids any percpu access before CR3 is set up,
   which means that no percpu memory needs to be mapped in the user
   page tables.  This prevents using Meltdown to read any percpu memory
   outside the cpu_entry_area and prevents using timing leaks
   to directly locate the percpu areas.

The downsides of using a trampoline may outweigh the upsides, however.
It adds an extra non-contiguous I$ cache line to system calls, and it
forces an indirect jump to transfer control back to the normal kernel
text after CR3 is set up.  The latter is because x86 lacks a 64-bit
direct jump instruction that could jump from the trampoline to the entry
text.  With retpolines enabled, the indirect jump is extremely slow.

This patch changes the code to map the percpu TSS into the user page
tables to allow the non-trampoline SYSCALL64 path to work under PTI.
This does not add a new direct information leak, since the TSS is
readable by Meltdown from the cpu_entry_area alias regardless.  It
does allow a timing attack to locate the percpu area, but KASLR is
more or less a lost cause against local attack on CPUs vulnerable to
Meltdown regardless.  As far as I'm concerned, on current hardware,
KASLR is only useful to mitigate remote attacks that try to attack
the kernel without first gaining RCE against a vulnerable user
process.

On Skylake, with CONFIG_RETPOLINE=y and KPTI on, this reduces
syscall overhead from ~237ns to ~228ns.

There is a possible alternative approach: we could instead move the
trampoline within 2G of the entry text and make a separate copy for
each CPU.  Then we could use a direct jump to rejoin the normal
entry path.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_64.S             | 66 +--------------------------
 arch/x86/include/asm/cpu_entry_area.h |  2 -
 arch/x86/include/asm/sections.h       |  1 -
 arch/x86/kernel/asm-offsets.c         |  2 -
 arch/x86/kernel/cpu/common.c          | 11 +----
 arch/x86/kernel/kprobes/core.c        | 10 +---
 arch/x86/kernel/vmlinux.lds.S         | 10 ----
 arch/x86/mm/cpu_entry_area.c          | 36 ---------------
 arch/x86/mm/pti.c                     | 33 +++++++++++++-
 9 files changed, 35 insertions(+), 136 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1796c42e08af..19927211b175 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -142,67 +142,6 @@ END(native_usergs_sysret64)
  * with them due to bugs in both AMD and Intel CPUs.
  */
 
-	.pushsection .entry_trampoline, "ax"
-
-/*
- * The code in here gets remapped into cpu_entry_area's trampoline.  This means
- * that the assembler and linker have the wrong idea as to where this code
- * lives (and, in fact, it's mapped more than once, so it's not even at a
- * fixed address).  So we can't reference any symbols outside the entry
- * trampoline and expect it to work.
- *
- * Instead, we carefully abuse %rip-relative addressing.
- * _entry_trampoline(%rip) refers to the start of the remapped) entry
- * trampoline.  We can thus find cpu_entry_area with this macro:
- */
-
-#define CPU_ENTRY_AREA \
-	_entry_trampoline - CPU_ENTRY_AREA_entry_trampoline(%rip)
-
-/* The top word of the SYSENTER stack is hot and is usable as scratch space. */
-#define RSP_SCRATCH	CPU_ENTRY_AREA_entry_stack + \
-			SIZEOF_entry_stack - 8 + CPU_ENTRY_AREA
-
-ENTRY(entry_SYSCALL_64_trampoline)
-	UNWIND_HINT_EMPTY
-	swapgs
-
-	/* Stash the user RSP. */
-	movq	%rsp, RSP_SCRATCH
-
-	/* Note: using %rsp as a scratch reg. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
-
-	/* Load the top of the task stack into RSP */
-	movq	CPU_ENTRY_AREA_tss + TSS_sp1 + CPU_ENTRY_AREA, %rsp
-
-	/* Start building the simulated IRET frame. */
-	pushq	$__USER_DS			/* pt_regs->ss */
-	pushq	RSP_SCRATCH			/* pt_regs->sp */
-	pushq	%r11				/* pt_regs->flags */
-	pushq	$__USER_CS			/* pt_regs->cs */
-	pushq	%rcx				/* pt_regs->ip */
-
-	/*
-	 * x86 lacks a near absolute jump, and we can't jump to the real
-	 * entry text with a relative jump.  We could push the target
-	 * address and then use retq, but this destroys the pipeline on
-	 * many CPUs (wasting over 20 cycles on Sandy Bridge).  Instead,
-	 * spill RDI and restore it in a second-stage trampoline.
-	 */
-	pushq	%rdi
-	movq	$entry_SYSCALL_64_stage2, %rdi
-	JMP_NOSPEC %rdi
-END(entry_SYSCALL_64_trampoline)
-
-	.popsection
-
-ENTRY(entry_SYSCALL_64_stage2)
-	UNWIND_HINT_EMPTY
-	popq	%rdi
-	jmp	entry_SYSCALL_64_after_hwframe
-END(entry_SYSCALL_64_stage2)
-
 ENTRY(entry_SYSCALL_64)
 	UNWIND_HINT_EMPTY
 	/*
@@ -212,11 +151,8 @@ ENTRY(entry_SYSCALL_64)
 	 */
 
 	swapgs
-	/*
-	 * This path is only taken when PAGE_TABLE_ISOLATION is disabled so it
-	 * is not required to switch CR3.
-	 */
 	movq	%rsp, PER_CPU_VAR(rsp_scratch)
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 	/* Construct struct pt_regs on stack */
diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 4a7884b8dca5..29c706415443 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -30,8 +30,6 @@ struct cpu_entry_area {
 	 */
 	struct tss_struct tss;
 
-	char entry_trampoline[PAGE_SIZE];
-
 #ifdef CONFIG_X86_64
 	/*
 	 * Exception stacks used for IST entries.
diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 4a911a382ade..8ea1cfdbeabc 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -11,7 +11,6 @@ extern char __end_rodata_aligned[];
 
 #if defined(CONFIG_X86_64)
 extern char __end_rodata_hpage_align[];
-extern char __entry_trampoline_start[], __entry_trampoline_end[];
 #endif
 
 #endif	/* _ASM_X86_SECTIONS_H */
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index fc2e90d3429a..083c01309027 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -99,8 +99,6 @@ void common(void) {
 	OFFSET(TLB_STATE_user_pcid_flush_mask, tlb_state, user_pcid_flush_mask);
 
 	/* Layout info for cpu_entry_area */
-	OFFSET(CPU_ENTRY_AREA_tss, cpu_entry_area, tss);
-	OFFSET(CPU_ENTRY_AREA_entry_trampoline, cpu_entry_area, entry_trampoline);
 	OFFSET(CPU_ENTRY_AREA_entry_stack, cpu_entry_area, entry_stack_page);
 	DEFINE(SIZEOF_entry_stack, sizeof(struct entry_stack));
 	DEFINE(MASK_entry_stack, (~(sizeof(struct entry_stack) - 1)));
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 84dee5ab745a..83068258c856 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1530,19 +1530,10 @@ EXPORT_PER_CPU_SYMBOL(__preempt_count);
 /* May not be marked __init: used by software suspend */
 void syscall_init(void)
 {
-	extern char _entry_trampoline[];
-	extern char entry_SYSCALL_64_trampoline[];
-
 	int cpu = smp_processor_id();
-	unsigned long SYSCALL64_entry_trampoline =
-		(unsigned long)get_cpu_entry_area(cpu)->entry_trampoline +
-		(entry_SYSCALL_64_trampoline - _entry_trampoline);
 
 	wrmsr(MSR_STAR, 0, (__USER32_CS << 16) | __KERNEL_CS);
-	if (static_cpu_has(X86_FEATURE_PTI))
-		wrmsrl(MSR_LSTAR, SYSCALL64_entry_trampoline);
-	else
-		wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
+	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
 
 #ifdef CONFIG_IA32_EMULATION
 	wrmsrl(MSR_CSTAR, (unsigned long)entry_SYSCALL_compat);
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index b0d1e81c96bb..f802cf5b4478 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1066,18 +1066,10 @@ NOKPROBE_SYMBOL(kprobe_exceptions_notify);
 
 bool arch_within_kprobe_blacklist(unsigned long addr)
 {
-	bool is_in_entry_trampoline_section = false;
-
-#ifdef CONFIG_X86_64
-	is_in_entry_trampoline_section =
-		(addr >= (unsigned long)__entry_trampoline_start &&
-		 addr < (unsigned long)__entry_trampoline_end);
-#endif
 	return  (addr >= (unsigned long)__kprobes_text_start &&
 		 addr < (unsigned long)__kprobes_text_end) ||
 		(addr >= (unsigned long)__entry_text_start &&
-		 addr < (unsigned long)__entry_text_end) ||
-		is_in_entry_trampoline_section;
+		 addr < (unsigned long)__entry_text_end);
 }
 
 int __init arch_init_kprobes(void)
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 8bde0a419f86..9c77d2df9c27 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -118,16 +118,6 @@ SECTIONS
 		*(.fixup)
 		*(.gnu.warning)
 
-#ifdef CONFIG_X86_64
-		. = ALIGN(PAGE_SIZE);
-		__entry_trampoline_start = .;
-		_entry_trampoline = .;
-		*(.entry_trampoline)
-		. = ALIGN(PAGE_SIZE);
-		__entry_trampoline_end = .;
-		ASSERT(. - _entry_trampoline == PAGE_SIZE, "entry trampoline is too big");
-#endif
-
 #ifdef CONFIG_RETPOLINE
 		__indirect_thunk_start = .;
 		*(.text.__x86.indirect_thunk)
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 076ebdce9bd4..12d7e7fb4efd 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -15,7 +15,6 @@ static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_page, entry_stack_storage)
 #ifdef CONFIG_X86_64
 static DEFINE_PER_CPU_PAGE_ALIGNED(char, exception_stacks
 	[(N_EXCEPTION_STACKS - 1) * EXCEPTION_STKSZ + DEBUG_STKSZ]);
-static DEFINE_PER_CPU(struct kcore_list, kcore_entry_trampoline);
 #endif
 
 struct cpu_entry_area *get_cpu_entry_area(int cpu)
@@ -83,8 +82,6 @@ static void percpu_setup_debug_store(int cpu)
 static void __init setup_cpu_entry_area(int cpu)
 {
 #ifdef CONFIG_X86_64
-	extern char _entry_trampoline[];
-
 	/* On 64-bit systems, we use a read-only fixmap GDT and TSS. */
 	pgprot_t gdt_prot = PAGE_KERNEL_RO;
 	pgprot_t tss_prot = PAGE_KERNEL_RO;
@@ -146,43 +143,10 @@ static void __init setup_cpu_entry_area(int cpu)
 	cea_map_percpu_pages(&get_cpu_entry_area(cpu)->exception_stacks,
 			     &per_cpu(exception_stacks, cpu),
 			     sizeof(exception_stacks) / PAGE_SIZE, PAGE_KERNEL);
-
-	cea_set_pte(&get_cpu_entry_area(cpu)->entry_trampoline,
-		     __pa_symbol(_entry_trampoline), PAGE_KERNEL_RX);
-	/*
-	 * The cpu_entry_area alias addresses are not in the kernel binary
-	 * so they do not show up in /proc/kcore normally.  This adds entries
-	 * for them manually.
-	 */
-	kclist_add_remap(&per_cpu(kcore_entry_trampoline, cpu),
-			 _entry_trampoline,
-			 &get_cpu_entry_area(cpu)->entry_trampoline, PAGE_SIZE);
 #endif
 	percpu_setup_debug_store(cpu);
 }
 
-#ifdef CONFIG_X86_64
-int arch_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
-		     char *name)
-{
-	unsigned int cpu, ncpu = 0;
-
-	if (symnum >= num_possible_cpus())
-		return -EINVAL;
-
-	for_each_possible_cpu(cpu) {
-		if (ncpu++ >= symnum)
-			break;
-	}
-
-	*value = (unsigned long)&get_cpu_entry_area(cpu)->entry_trampoline;
-	*type = 't';
-	strlcpy(name, "__entry_SYSCALL_64_trampoline", KSYM_NAME_LEN);
-
-	return 0;
-}
-#endif
-
 static __init void setup_cpu_entry_area_ptes(void)
 {
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 31341ae7309f..7e79154846c8 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -434,11 +434,42 @@ static void __init pti_clone_p4d(unsigned long addr)
 }
 
 /*
- * Clone the CPU_ENTRY_AREA into the user space visible page table.
+ * Clone the CPU_ENTRY_AREA and associated data into the user space visible
+ * page table.
  */
 static void __init pti_clone_user_shared(void)
 {
+	unsigned cpu;
+
 	pti_clone_p4d(CPU_ENTRY_AREA_BASE);
+
+	for_each_possible_cpu(cpu) {
+		/*
+		 * The SYSCALL64 entry code needs to be able to find the
+		 * thread stack and needs one word of scratch space in which
+		 * to spill a register.  All of this lives in the TSS, in
+		 * the sp1 and sp2 slots.
+		 *
+		 * This is done for all possible CPUs during boot to ensure
+		 * that it's propagated to all mms.  If we were to add one of
+		 * these mappings during CPU hotplug, we would need to take
+		 * some measure to make sure that every mm that subsequently
+		 * ran on that CPU would have the relevant PGD entry in its
+		 * pagetables.  The usual vmalloc_fault() mechanism would not
+		 * work for page faults taken in entry_SYSCALL_64 before RSP
+		 * is set up.
+		 */
+
+		unsigned long va = (unsigned long)&per_cpu(cpu_tss_rw, cpu);
+		phys_addr_t pa = per_cpu_ptr_to_phys((void *)va);
+		pte_t *target_pte;
+
+		target_pte = pti_user_pagetable_walk_pte(va);
+		if (WARN_ON(!target_pte))
+			return;
+
+		*target_pte = pfn_pte(pa >> PAGE_SHIFT, PAGE_KERNEL);
+	}
 }
 
 #else /* CONFIG_X86_64 */
-- 
2.17.1

