Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1019FECDFBB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14C520854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 17:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAet3PKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14C520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbeGVSnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 14:43:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729890AbeGVSnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 14:43:03 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D0292086A;
        Sun, 22 Jul 2018 17:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532281536;
        bh=9AMZrR3eFb4ke9GXsf3k/MHW53BkrXKLNqCcaBjz1CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=hAet3PKLikhEQYH4u5HWLJBv0fSb+nF6/IUZ/qtHb4pa3sU7wI36U/4kjWsF4HnhH
         jr90CKWQnZSxWScmRwue3o13uPWULvHLvMKVSGYz7iT5mNurfn0W4CSs5JmTxeFOk2
         3ca30N85i8YAupS9Hn4N/uWfFD7o8vc7CyBXgyoc=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [RFC 2/2] x86/pti/64: Remove the SYSCALL64 entry trampoline
Date:   Sun, 22 Jul 2018 10:45:27 -0700
Message-Id: <1e3d01ce04315218d3f8ee269528bb774a4d1d60.1532281180.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1532281180.git.luto@kernel.org>
References: <cover.1532281180.git.luto@kernel.org>
In-Reply-To: <cover.1532281180.git.luto@kernel.org>
References: <cover.1532281180.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TODO: benchmark!

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

There is a possible alternative approach: we could instead move the
trampoline within 2G of the entry text and make a separate copy for
each CPU.  Then we could use a direct jump to rejoin the normal
entry path.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_64.S      | 66 +---------------------------------
 arch/x86/kernel/cpu/common.c   | 11 +-----
 arch/x86/kernel/kprobes/core.c | 10 +-----
 arch/x86/kernel/vmlinux.lds.S  | 10 ------
 arch/x86/mm/cpu_entry_area.c   |  5 ---
 arch/x86/mm/pti.c              | 24 ++++++++++++-
 6 files changed, 26 insertions(+), 100 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1f7cf8407cfb..ab19f47ae187 100644
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
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index eb4cb3efd20e..0209af82de53 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1513,19 +1513,10 @@ EXPORT_PER_CPU_SYMBOL(__preempt_count);
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
index 6f4d42377fe5..09693d89757d 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1172,18 +1172,10 @@ NOKPROBE_SYMBOL(longjmp_break_handler);
 
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
index 5e1458f609a1..ba5e7d896eca 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -115,16 +115,6 @@ SECTIONS
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
index b45f5aaefd74..419d203d8520 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -80,8 +80,6 @@ static void percpu_setup_debug_store(int cpu)
 static void __init setup_cpu_entry_area(int cpu)
 {
 #ifdef CONFIG_X86_64
-	extern char _entry_trampoline[];
-
 	/* On 64-bit systems, we use a read-only fixmap GDT and TSS. */
 	pgprot_t gdt_prot = PAGE_KERNEL_RO;
 	pgprot_t tss_prot = PAGE_KERNEL_RO;
@@ -143,9 +141,6 @@ static void __init setup_cpu_entry_area(int cpu)
 	cea_map_percpu_pages(&get_cpu_entry_area(cpu)->exception_stacks,
 			     &per_cpu(exception_stacks, cpu),
 			     sizeof(exception_stacks) / PAGE_SIZE, PAGE_KERNEL);
-
-	cea_set_pte(&get_cpu_entry_area(cpu)->entry_trampoline,
-		     __pa_symbol(_entry_trampoline), PAGE_KERNEL_RX);
 #endif
 	percpu_setup_debug_store(cpu);
 }
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 4d418e705878..5d5d512f6d14 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -360,11 +360,33 @@ static void __init pti_clone_p4d(unsigned long addr)
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
+		set_pte(target_pte, pfn_pte(pa >> PAGE_SHIFT, PAGE_KERNEL));
+	}
 }
 
 /*
-- 
2.17.1

