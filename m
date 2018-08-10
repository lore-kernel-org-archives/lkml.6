Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC20FC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4B12240E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 11:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F4B12240E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeHJOWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 10:22:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:38700 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727534AbeHJOWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 10:22:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B563DAE84;
        Fri, 10 Aug 2018 11:52:57 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org
Cc:     akataria@vmware.com, rusty@rustcorp.com.au,
        boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH 04/10] x86/paravirt: use a single ops structure
Date:   Fri, 10 Aug 2018 13:52:46 +0200
Message-Id: <20180810115252.18213-5-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180810115252.18213-1-jgross@suse.com>
References: <20180810115252.18213-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using six globally visible paravirt ops structures combine
them in a single structure, keeping the original structures as
sub-structures.

This avoids the need to assemble struct paravirt_patch_template at
runtime on the stack each time apply_paravirt() is being called (i.e.
when loading a module).

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/hyperv/mmu.c                 |   4 +-
 arch/x86/include/asm/paravirt.h       |  51 ++++---
 arch/x86/include/asm/paravirt_types.h |  13 +-
 arch/x86/kernel/alternative.c         |   2 +-
 arch/x86/kernel/asm-offsets.c         |  14 +-
 arch/x86/kernel/asm-offsets_64.c      |   7 +-
 arch/x86/kernel/cpu/common.c          |   2 +-
 arch/x86/kernel/cpu/vmware.c          |   4 +-
 arch/x86/kernel/kvm.c                 |  18 ++-
 arch/x86/kernel/kvmclock.c            |   4 +-
 arch/x86/kernel/paravirt-spinlocks.c  |  15 +-
 arch/x86/kernel/paravirt.c            | 278 +++++++++++++++++-----------------
 arch/x86/kernel/tsc.c                 |   2 +-
 arch/x86/kernel/vsmp_64.c             |  11 +-
 arch/x86/xen/enlighten_pv.c           |  32 ++--
 arch/x86/xen/irq.c                    |   2 +-
 arch/x86/xen/mmu_hvm.c                |   2 +-
 arch/x86/xen/mmu_pv.c                 |  28 ++--
 arch/x86/xen/spinlock.c               |  12 +-
 arch/x86/xen/time.c                   |   4 +-
 drivers/xen/time.c                    |   2 +-
 21 files changed, 249 insertions(+), 258 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index de27615c51ea..b34768cfb204 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -228,9 +228,9 @@ void hyperv_setup_mmu_ops(void)
 
 	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED)) {
 		pr_info("Using hypercall for remote TLB flush\n");
-		pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others;
+		pv_ops.pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others;
 	} else {
 		pr_info("Using ext hypercall for remote TLB flush\n");
-		pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others_ex;
+		pv_ops.pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others_ex;
 	}
 }
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 76b4b5c056f3..1b86bb319393 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -265,11 +265,11 @@ static inline void set_iopl_mask(unsigned mask)
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void)
 {
-	pv_cpu_ops.io_delay();
+	pv_ops.pv_cpu_ops.io_delay();
 #ifdef REALLY_SLOW_IO
-	pv_cpu_ops.io_delay();
-	pv_cpu_ops.io_delay();
-	pv_cpu_ops.io_delay();
+	pv_ops.pv_cpu_ops.io_delay();
+	pv_ops.pv_cpu_ops.io_delay();
+	pv_ops.pv_cpu_ops.io_delay();
 #endif
 }
 
@@ -432,7 +432,7 @@ static inline void ptep_modify_prot_commit(struct mm_struct *mm, unsigned long a
 {
 	if (sizeof(pteval_t) > sizeof(long))
 		/* 5 arg words */
-		pv_mmu_ops.ptep_modify_prot_commit(mm, addr, ptep, pte);
+		pv_ops.pv_mmu_ops.ptep_modify_prot_commit(mm, addr, ptep, pte);
 	else
 		PVOP_VCALL4(pv_mmu_ops.ptep_modify_prot_commit,
 			    mm, addr, ptep, pte.pte);
@@ -453,7 +453,7 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 {
 	if (sizeof(pteval_t) > sizeof(long))
 		/* 5 arg words */
-		pv_mmu_ops.set_pte_at(mm, addr, ptep, pte);
+		pv_ops.pv_mmu_ops.set_pte_at(mm, addr, ptep, pte);
 	else
 		PVOP_VCALL4(pv_mmu_ops.set_pte_at, mm, addr, ptep, pte.pte);
 }
@@ -663,7 +663,7 @@ static inline void arch_flush_lazy_mmu_mode(void)
 static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
 				phys_addr_t phys, pgprot_t flags)
 {
-	pv_mmu_ops.set_fixmap(idx, phys, flags);
+	pv_ops.pv_mmu_ops.set_fixmap(idx, phys, flags);
 }
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PARAVIRT_SPINLOCKS)
@@ -694,6 +694,9 @@ static __always_inline bool pv_vcpu_is_preempted(long cpu)
 	return PVOP_CALLEE1(bool, pv_lock_ops.vcpu_is_preempted, cpu);
 }
 
+void __raw_callee_save___native_queued_spin_unlock(struct qspinlock *lock);
+bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
+
 #endif /* SMP && PARAVIRT_SPINLOCKS */
 
 #ifdef CONFIG_X86_32
@@ -862,7 +865,7 @@ extern void default_banner(void);
 	COND_POP(set, CLBR_RCX, rcx);		\
 	COND_POP(set, CLBR_RAX, rax)
 
-#define PARA_PATCH(struct, off)        ((PARAVIRT_PATCH_##struct + (off)) / 8)
+#define PARA_PATCH(off)		((off) / 8)
 #define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
 #define PARA_INDIRECT(addr)	*addr(%rip)
 #else
@@ -877,35 +880,35 @@ extern void default_banner(void);
 	COND_POP(set, CLBR_EDI, edi);		\
 	COND_POP(set, CLBR_EAX, eax)
 
-#define PARA_PATCH(struct, off)        ((PARAVIRT_PATCH_##struct + (off)) / 4)
+#define PARA_PATCH(off)		((off) / 4)
 #define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .long, 4)
 #define PARA_INDIRECT(addr)	*%cs:addr
 #endif
 
 #define INTERRUPT_RETURN						\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_iret),			\
+	PARA_SITE(PARA_PATCH(PV_CPU_iret),				\
 		  ANNOTATE_RETPOLINE_SAFE;				\
-		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_iret);)
+		  jmp PARA_INDIRECT(pv_ops+PV_CPU_iret);)
 
 #define DISABLE_INTERRUPTS(clobbers)					\
-	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_disable),		\
+	PARA_SITE(PARA_PATCH(PV_IRQ_irq_disable),			\
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
 		  ANNOTATE_RETPOLINE_SAFE;				\
-		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_disable);	\
+		  call PARA_INDIRECT(pv_ops+PV_IRQ_irq_disable);	\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
 #define ENABLE_INTERRUPTS(clobbers)					\
-	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_irq_enable),		\
+	PARA_SITE(PARA_PATCH(PV_IRQ_irq_enable),			\
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);		\
 		  ANNOTATE_RETPOLINE_SAFE;				\
-		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_irq_enable);	\
+		  call PARA_INDIRECT(pv_ops+PV_IRQ_irq_enable);		\
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 
 #ifdef CONFIG_X86_32
 #define GET_CR0_INTO_EAX				\
 	push %ecx; push %edx;				\
 	ANNOTATE_RETPOLINE_SAFE;				\
-	call PARA_INDIRECT(pv_cpu_ops+PV_CPU_read_cr0);	\
+	call PARA_INDIRECT(pv_ops+PV_CPU_read_cr0);	\
 	pop %edx; pop %ecx
 #else	/* !CONFIG_X86_32 */
 
@@ -915,7 +918,7 @@ extern void default_banner(void);
  * inlined, or the swapgs instruction must be trapped and emulated.
  */
 #define SWAPGS_UNSAFE_STACK						\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), swapgs)
+	PARA_SITE(PARA_PATCH(PV_CPU_swapgs), swapgs)
 
 /*
  * Note: swapgs is very special, and in practise is either going to be
@@ -924,26 +927,26 @@ extern void default_banner(void);
  * it.
  */
 #define SWAPGS								\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs),		\
+	PARA_SITE(PARA_PATCH(PV_CPU_swapgs),				\
 		  ANNOTATE_RETPOLINE_SAFE;				\
-		  call PARA_INDIRECT(pv_cpu_ops+PV_CPU_swapgs);		\
+		  call PARA_INDIRECT(pv_ops+PV_CPU_swapgs);		\
 		 )
 
 #define GET_CR2_INTO_RAX				\
 	ANNOTATE_RETPOLINE_SAFE;				\
-	call PARA_INDIRECT(pv_mmu_ops+PV_MMU_read_cr2);
+	call PARA_INDIRECT(pv_ops+PV_MMU_read_cr2);
 
 #define USERGS_SYSRET64							\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_usergs_sysret64),	\
+	PARA_SITE(PARA_PATCH(PV_CPU_usergs_sysret64),			\
 		  ANNOTATE_RETPOLINE_SAFE;				\
-		  jmp PARA_INDIRECT(pv_cpu_ops+PV_CPU_usergs_sysret64);)
+		  jmp PARA_INDIRECT(pv_ops+PV_CPU_usergs_sysret64);)
 
 #ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(clobbers)                                        \
-	PARA_SITE(PARA_PATCH(pv_irq_ops, PV_IRQ_save_fl),	    \
+	PARA_SITE(PARA_PATCH(PV_IRQ_save_fl),			    \
 		  PV_SAVE_REGS(clobbers | CLBR_CALLEE_SAVE);        \
 		  ANNOTATE_RETPOLINE_SAFE;			    \
-		  call PARA_INDIRECT(pv_irq_ops+PV_IRQ_save_fl);    \
+		  call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);	    \
 		  PV_RESTORE_REGS(clobbers | CLBR_CALLEE_SAVE);)
 #endif
 
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index b900088cd244..ed024e90b863 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -327,19 +327,14 @@ struct paravirt_patch_template {
 } __no_randomize_layout;
 
 extern struct pv_info pv_info;
-extern struct pv_init_ops pv_init_ops;
-extern struct pv_time_ops pv_time_ops;
-extern struct pv_cpu_ops pv_cpu_ops;
-extern struct pv_irq_ops pv_irq_ops;
-extern struct pv_mmu_ops pv_mmu_ops;
-extern struct pv_lock_ops pv_lock_ops;
+extern struct paravirt_patch_template pv_ops;
 
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
 
 #define paravirt_type(op)				\
 	[paravirt_typenum] "i" (PARAVIRT_PATCH(op)),	\
-	[paravirt_opptr] "i" (&(op))
+	[paravirt_opptr] "i" (&(pv_ops.op))
 #define paravirt_clobber(clobber)		\
 	[paravirt_clobber] "i" (clobber)
 
@@ -500,9 +495,9 @@ int paravirt_disable_iospace(void);
 #endif	/* CONFIG_X86_32 */
 
 #ifdef CONFIG_PARAVIRT_DEBUG
-#define PVOP_TEST_NULL(op)	BUG_ON(op == NULL)
+#define PVOP_TEST_NULL(op)	BUG_ON(pv_ops.op == NULL)
 #else
-#define PVOP_TEST_NULL(op)	((void)op)
+#define PVOP_TEST_NULL(op)	((void)pv_ops.op)
 #endif
 
 #define PVOP_RETMASK(rettype)						\
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 9729cee11149..7cfeda749382 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -594,7 +594,7 @@ void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
 		BUG_ON(p->len > MAX_PATCH_LEN);
 		/* prep the buffer with the original instructions */
 		memcpy(insnbuf, p->instr, p->len);
-		used = pv_init_ops.patch(p->instrtype, insnbuf,
+		used = pv_ops.pv_init_ops.patch(p->instrtype, insnbuf,
 					 (unsigned long)p->instr, p->len);
 
 		BUG_ON(used > p->len);
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index dcb008c320fe..bec9fc3498f8 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -66,13 +66,13 @@ void common(void) {
 
 #ifdef CONFIG_PARAVIRT
 	BLANK();
-	OFFSET(PARAVIRT_PATCH_pv_cpu_ops, paravirt_patch_template, pv_cpu_ops);
-	OFFSET(PARAVIRT_PATCH_pv_irq_ops, paravirt_patch_template, pv_irq_ops);
-	OFFSET(PV_IRQ_irq_disable, pv_irq_ops, irq_disable);
-	OFFSET(PV_IRQ_irq_enable, pv_irq_ops, irq_enable);
-	OFFSET(PV_CPU_iret, pv_cpu_ops, iret);
-	OFFSET(PV_CPU_read_cr0, pv_cpu_ops, read_cr0);
-	OFFSET(PV_MMU_read_cr2, pv_mmu_ops, read_cr2);
+	OFFSET(PV_IRQ_irq_disable, paravirt_patch_template,
+	       pv_irq_ops.irq_disable);
+	OFFSET(PV_IRQ_irq_enable, paravirt_patch_template,
+	       pv_irq_ops.irq_enable);
+	OFFSET(PV_CPU_iret, paravirt_patch_template, pv_cpu_ops.iret);
+	OFFSET(PV_CPU_read_cr0, paravirt_patch_template, pv_cpu_ops.read_cr0);
+	OFFSET(PV_MMU_read_cr2, paravirt_patch_template, pv_mmu_ops.read_cr2);
 #endif
 
 #ifdef CONFIG_XEN
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index b2dcd161f514..2add567c1b2a 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -21,10 +21,11 @@ static char syscalls_ia32[] = {
 int main(void)
 {
 #ifdef CONFIG_PARAVIRT
-	OFFSET(PV_CPU_usergs_sysret64, pv_cpu_ops, usergs_sysret64);
-	OFFSET(PV_CPU_swapgs, pv_cpu_ops, swapgs);
+	OFFSET(PV_CPU_usergs_sysret64, paravirt_patch_template,
+	       pv_cpu_ops.usergs_sysret64);
+	OFFSET(PV_CPU_swapgs, paravirt_patch_template, pv_cpu_ops.swapgs);
 #ifdef CONFIG_DEBUG_ENTRY
-	OFFSET(PV_IRQ_save_fl, pv_irq_ops, save_fl);
+	OFFSET(PV_IRQ_save_fl, paravirt_patch_template, pv_irq_ops.save_fl);
 #endif
 	BLANK();
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index eb4cb3efd20e..3893df059174 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1225,7 +1225,7 @@ static void generic_identify(struct cpuinfo_x86 *c)
 # ifdef CONFIG_PARAVIRT
 	do {
 		extern void native_iret(void);
-		if (pv_cpu_ops.iret == native_iret)
+		if (pv_ops.pv_cpu_ops.iret == native_iret)
 			set_cpu_bug(c, X86_BUG_ESPFIX);
 	} while (0);
 # else
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 8e005329648b..f85302a308f2 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -97,14 +97,14 @@ static void __init vmware_sched_clock_setup(void)
 	d->cyc2ns_offset = mul_u64_u32_shr(tsc_now, d->cyc2ns_mul,
 					   d->cyc2ns_shift);
 
-	pv_time_ops.sched_clock = vmware_sched_clock;
+	pv_ops.pv_time_ops.sched_clock = vmware_sched_clock;
 	pr_info("using sched offset of %llu ns\n", d->cyc2ns_offset);
 }
 
 static void __init vmware_paravirt_ops_setup(void)
 {
 	pv_info.name = "VMware hypervisor";
-	pv_cpu_ops.io_delay = paravirt_nop;
+	pv_ops.pv_cpu_ops.io_delay = paravirt_nop;
 
 	if (vmware_tsc_khz && vmw_sched_clock)
 		vmware_sched_clock_setup();
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5b2300b818af..610da165aa26 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -292,7 +292,7 @@ static void __init paravirt_ops_setup(void)
 	pv_info.name = "KVM";
 
 	if (kvm_para_has_feature(KVM_FEATURE_NOP_IO_DELAY))
-		pv_cpu_ops.io_delay = kvm_io_delay;
+		pv_ops.pv_cpu_ops.io_delay = kvm_io_delay;
 
 #ifdef CONFIG_X86_IO_APIC
 	no_timer_check = 1;
@@ -549,13 +549,13 @@ static void __init kvm_guest_init(void)
 
 	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
 		has_steal_clock = 1;
-		pv_time_ops.steal_clock = kvm_steal_clock;
+		pv_ops.pv_time_ops.steal_clock = kvm_steal_clock;
 	}
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
 	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
 	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))
-		pv_mmu_ops.flush_tlb_others = kvm_flush_tlb_others;
+		pv_ops.pv_mmu_ops.flush_tlb_others = kvm_flush_tlb_others;
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
 		apic_set_eoi_write(kvm_guest_apic_eoi_write);
@@ -749,13 +749,15 @@ void __init kvm_spinlock_init(void)
 		return;
 
 	__pv_init_lock_hash();
-	pv_lock_ops.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
-	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
-	pv_lock_ops.wait = kvm_wait;
-	pv_lock_ops.kick = kvm_kick_cpu;
+	pv_ops.pv_lock_ops.queued_spin_lock_slowpath =
+		__pv_queued_spin_lock_slowpath;
+	pv_ops.pv_lock_ops.queued_spin_unlock =
+		PV_CALLEE_SAVE(__pv_queued_spin_unlock);
+	pv_ops.pv_lock_ops.wait = kvm_wait;
+	pv_ops.pv_lock_ops.kick = kvm_kick_cpu;
 
 	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
-		pv_lock_ops.vcpu_is_preempted =
+		pv_ops.pv_lock_ops.vcpu_is_preempted =
 			PV_CALLEE_SAVE(__kvm_vcpu_is_preempted);
 	}
 }
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 3b8e7c13c614..10a6071b209a 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -104,13 +104,13 @@ static u64 kvm_sched_clock_read(void)
 static inline void kvm_sched_clock_init(bool stable)
 {
 	if (!stable) {
-		pv_time_ops.sched_clock = kvm_clock_read;
+		pv_ops.pv_time_ops.sched_clock = kvm_clock_read;
 		clear_sched_clock_stable();
 		return;
 	}
 
 	kvm_sched_clock_offset = kvm_clock_read();
-	pv_time_ops.sched_clock = kvm_sched_clock_read;
+	pv_ops.pv_time_ops.sched_clock = kvm_sched_clock_read;
 
 	printk(KERN_INFO "kvm-clock: using sched offset of %llu cycles\n",
 			kvm_sched_clock_offset);
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 71f2d1125ec0..9569481cadb3 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -17,7 +17,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__native_queued_spin_unlock);
 
 bool pv_is_native_spin_unlock(void)
 {
-	return pv_lock_ops.queued_spin_unlock.func ==
+	return pv_ops.pv_lock_ops.queued_spin_unlock.func ==
 		__raw_callee_save___native_queued_spin_unlock;
 }
 
@@ -29,17 +29,6 @@ PV_CALLEE_SAVE_REGS_THUNK(__native_vcpu_is_preempted);
 
 bool pv_is_native_vcpu_is_preempted(void)
 {
-	return pv_lock_ops.vcpu_is_preempted.func ==
+	return pv_ops.pv_lock_ops.vcpu_is_preempted.func ==
 		__raw_callee_save___native_vcpu_is_preempted;
 }
-
-struct pv_lock_ops pv_lock_ops = {
-#ifdef CONFIG_SMP
-	.queued_spin_lock_slowpath = native_queued_spin_lock_slowpath,
-	.queued_spin_unlock = PV_CALLEE_SAVE(__native_queued_spin_unlock),
-	.wait = paravirt_nop,
-	.kick = paravirt_nop,
-	.vcpu_is_preempted = PV_CALLEE_SAVE(__native_vcpu_is_preempted),
-#endif /* SMP */
-};
-EXPORT_SYMBOL(pv_lock_ops);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index f0c462fe2808..40ec68135f7a 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -127,29 +127,14 @@ void __init native_pv_lock_init(void)
 		static_branch_disable(&virt_spin_lock_key);
 }
 
-/*
- * Neat trick to map patch type back to the call within the
- * corresponding structure.
- */
-static void *get_call_destination(u8 type)
-{
-	struct paravirt_patch_template tmpl = {
-		.pv_init_ops = pv_init_ops,
-		.pv_time_ops = pv_time_ops,
-		.pv_cpu_ops = pv_cpu_ops,
-		.pv_irq_ops = pv_irq_ops,
-		.pv_mmu_ops = pv_mmu_ops,
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
-		.pv_lock_ops = pv_lock_ops,
-#endif
-	};
-	return *((void **)&tmpl + type);
-}
-
 unsigned paravirt_patch_default(u8 type, void *insnbuf,
 				unsigned long addr, unsigned len)
 {
-	void *opfunc = get_call_destination(type);
+	/*
+	 * Neat trick to map patch type back to the call within the
+	 * corresponding structure.
+	 */
+	void *opfunc = *((void **)&pv_ops + type);
 	unsigned ret;
 
 	if (opfunc == NULL)
@@ -315,77 +300,6 @@ struct pv_info pv_info = {
 #endif
 };
 
-struct pv_init_ops pv_init_ops = {
-	.patch = native_patch,
-};
-
-struct pv_time_ops pv_time_ops = {
-	.sched_clock = native_sched_clock,
-	.steal_clock = native_steal_clock,
-};
-
-__visible struct pv_irq_ops pv_irq_ops = {
-	.save_fl = __PV_IS_CALLEE_SAVE(native_save_fl),
-	.restore_fl = __PV_IS_CALLEE_SAVE(native_restore_fl),
-	.irq_disable = __PV_IS_CALLEE_SAVE(native_irq_disable),
-	.irq_enable = __PV_IS_CALLEE_SAVE(native_irq_enable),
-	.safe_halt = native_safe_halt,
-	.halt = native_halt,
-};
-
-__visible struct pv_cpu_ops pv_cpu_ops = {
-	.cpuid = native_cpuid,
-	.get_debugreg = native_get_debugreg,
-	.set_debugreg = native_set_debugreg,
-	.read_cr0 = native_read_cr0,
-	.write_cr0 = native_write_cr0,
-	.write_cr4 = native_write_cr4,
-#ifdef CONFIG_X86_64
-	.read_cr8 = native_read_cr8,
-	.write_cr8 = native_write_cr8,
-#endif
-	.wbinvd = native_wbinvd,
-	.read_msr = native_read_msr,
-	.write_msr = native_write_msr,
-	.read_msr_safe = native_read_msr_safe,
-	.write_msr_safe = native_write_msr_safe,
-	.read_pmc = native_read_pmc,
-	.load_tr_desc = native_load_tr_desc,
-	.set_ldt = native_set_ldt,
-	.load_gdt = native_load_gdt,
-	.load_idt = native_load_idt,
-	.store_tr = native_store_tr,
-	.load_tls = native_load_tls,
-#ifdef CONFIG_X86_64
-	.load_gs_index = native_load_gs_index,
-#endif
-	.write_ldt_entry = native_write_ldt_entry,
-	.write_gdt_entry = native_write_gdt_entry,
-	.write_idt_entry = native_write_idt_entry,
-
-	.alloc_ldt = paravirt_nop,
-	.free_ldt = paravirt_nop,
-
-	.load_sp0 = native_load_sp0,
-
-#ifdef CONFIG_X86_64
-	.usergs_sysret64 = native_usergs_sysret64,
-#endif
-	.iret = native_iret,
-	.swapgs = native_swapgs,
-
-	.set_iopl_mask = native_set_iopl_mask,
-	.io_delay = native_io_delay,
-
-	.start_context_switch = paravirt_nop,
-	.end_context_switch = paravirt_nop,
-};
-
-/* At this point, native_get/set_debugreg has real function entries */
-NOKPROBE_SYMBOL(native_get_debugreg);
-NOKPROBE_SYMBOL(native_set_debugreg);
-NOKPROBE_SYMBOL(native_load_idt);
-
 #if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
 /* 32-bit pagetable entries */
 #define PTE_IDENT	__PV_IS_CALLEE_SAVE(_paravirt_ident_32)
@@ -394,84 +308,162 @@ NOKPROBE_SYMBOL(native_load_idt);
 #define PTE_IDENT	__PV_IS_CALLEE_SAVE(_paravirt_ident_64)
 #endif
 
-struct pv_mmu_ops pv_mmu_ops __ro_after_init = {
-
-	.read_cr2 = native_read_cr2,
-	.write_cr2 = native_write_cr2,
-	.read_cr3 = __native_read_cr3,
-	.write_cr3 = native_write_cr3,
-
-	.flush_tlb_user = native_flush_tlb,
-	.flush_tlb_kernel = native_flush_tlb_global,
-	.flush_tlb_one_user = native_flush_tlb_one_user,
-	.flush_tlb_others = native_flush_tlb_others,
-
-	.pgd_alloc = __paravirt_pgd_alloc,
-	.pgd_free = paravirt_nop,
+struct paravirt_patch_template pv_ops = {
+	/* Init ops. */
+	.pv_init_ops.patch = native_patch,
+
+	/* Time ops. */
+	.pv_time_ops.sched_clock = native_sched_clock,
+	.pv_time_ops.steal_clock = native_steal_clock,
+
+	/* Cpu ops. */
+	.pv_cpu_ops.cpuid = native_cpuid,
+	.pv_cpu_ops.get_debugreg = native_get_debugreg,
+	.pv_cpu_ops.set_debugreg = native_set_debugreg,
+	.pv_cpu_ops.read_cr0 = native_read_cr0,
+	.pv_cpu_ops.write_cr0 = native_write_cr0,
+	.pv_cpu_ops.write_cr4 = native_write_cr4,
+#ifdef CONFIG_X86_64
+	.pv_cpu_ops.read_cr8 = native_read_cr8,
+	.pv_cpu_ops.write_cr8 = native_write_cr8,
+#endif
+	.pv_cpu_ops.wbinvd = native_wbinvd,
+	.pv_cpu_ops.read_msr = native_read_msr,
+	.pv_cpu_ops.write_msr = native_write_msr,
+	.pv_cpu_ops.read_msr_safe = native_read_msr_safe,
+	.pv_cpu_ops.write_msr_safe = native_write_msr_safe,
+	.pv_cpu_ops.read_pmc = native_read_pmc,
+	.pv_cpu_ops.load_tr_desc = native_load_tr_desc,
+	.pv_cpu_ops.set_ldt = native_set_ldt,
+	.pv_cpu_ops.load_gdt = native_load_gdt,
+	.pv_cpu_ops.load_idt = native_load_idt,
+	.pv_cpu_ops.store_tr = native_store_tr,
+	.pv_cpu_ops.load_tls = native_load_tls,
+#ifdef CONFIG_X86_64
+	.pv_cpu_ops.load_gs_index = native_load_gs_index,
+#endif
+	.pv_cpu_ops.write_ldt_entry = native_write_ldt_entry,
+	.pv_cpu_ops.write_gdt_entry = native_write_gdt_entry,
+	.pv_cpu_ops.write_idt_entry = native_write_idt_entry,
 
-	.alloc_pte = paravirt_nop,
-	.alloc_pmd = paravirt_nop,
-	.alloc_pud = paravirt_nop,
-	.alloc_p4d = paravirt_nop,
-	.release_pte = paravirt_nop,
-	.release_pmd = paravirt_nop,
-	.release_pud = paravirt_nop,
-	.release_p4d = paravirt_nop,
+	.pv_cpu_ops.alloc_ldt = paravirt_nop,
+	.pv_cpu_ops.free_ldt = paravirt_nop,
 
-	.set_pte = native_set_pte,
-	.set_pte_at = native_set_pte_at,
-	.set_pmd = native_set_pmd,
+	.pv_cpu_ops.load_sp0 = native_load_sp0,
 
-	.ptep_modify_prot_start = __ptep_modify_prot_start,
-	.ptep_modify_prot_commit = __ptep_modify_prot_commit,
+#ifdef CONFIG_X86_64
+	.pv_cpu_ops.usergs_sysret64 = native_usergs_sysret64,
+#endif
+	.pv_cpu_ops.iret = native_iret,
+	.pv_cpu_ops.swapgs = native_swapgs,
+
+	.pv_cpu_ops.set_iopl_mask = native_set_iopl_mask,
+	.pv_cpu_ops.io_delay = native_io_delay,
+
+	.pv_cpu_ops.start_context_switch = paravirt_nop,
+	.pv_cpu_ops.end_context_switch = paravirt_nop,
+
+	/* Irq ops. */
+	.pv_irq_ops.save_fl = __PV_IS_CALLEE_SAVE(native_save_fl),
+	.pv_irq_ops.restore_fl = __PV_IS_CALLEE_SAVE(native_restore_fl),
+	.pv_irq_ops.irq_disable = __PV_IS_CALLEE_SAVE(native_irq_disable),
+	.pv_irq_ops.irq_enable = __PV_IS_CALLEE_SAVE(native_irq_enable),
+	.pv_irq_ops.safe_halt = native_safe_halt,
+	.pv_irq_ops.halt = native_halt,
+
+	/* Mmu ops. */
+	.pv_mmu_ops.read_cr2 = native_read_cr2,
+	.pv_mmu_ops.write_cr2 = native_write_cr2,
+	.pv_mmu_ops.read_cr3 = __native_read_cr3,
+	.pv_mmu_ops.write_cr3 = native_write_cr3,
+
+	.pv_mmu_ops.flush_tlb_user = native_flush_tlb,
+	.pv_mmu_ops.flush_tlb_kernel = native_flush_tlb_global,
+	.pv_mmu_ops.flush_tlb_one_user = native_flush_tlb_one_user,
+	.pv_mmu_ops.flush_tlb_others = native_flush_tlb_others,
+
+	.pv_mmu_ops.pgd_alloc = __paravirt_pgd_alloc,
+	.pv_mmu_ops.pgd_free = paravirt_nop,
+
+	.pv_mmu_ops.alloc_pte = paravirt_nop,
+	.pv_mmu_ops.alloc_pmd = paravirt_nop,
+	.pv_mmu_ops.alloc_pud = paravirt_nop,
+	.pv_mmu_ops.alloc_p4d = paravirt_nop,
+	.pv_mmu_ops.release_pte = paravirt_nop,
+	.pv_mmu_ops.release_pmd = paravirt_nop,
+	.pv_mmu_ops.release_pud = paravirt_nop,
+	.pv_mmu_ops.release_p4d = paravirt_nop,
+
+	.pv_mmu_ops.set_pte = native_set_pte,
+	.pv_mmu_ops.set_pte_at = native_set_pte_at,
+	.pv_mmu_ops.set_pmd = native_set_pmd,
+
+	.pv_mmu_ops.ptep_modify_prot_start = __ptep_modify_prot_start,
+	.pv_mmu_ops.ptep_modify_prot_commit = __ptep_modify_prot_commit,
 
 #if CONFIG_PGTABLE_LEVELS >= 3
 #ifdef CONFIG_X86_PAE
-	.set_pte_atomic = native_set_pte_atomic,
-	.pte_clear = native_pte_clear,
-	.pmd_clear = native_pmd_clear,
+	.pv_mmu_ops.set_pte_atomic = native_set_pte_atomic,
+	.pv_mmu_ops.pte_clear = native_pte_clear,
+	.pv_mmu_ops.pmd_clear = native_pmd_clear,
 #endif
-	.set_pud = native_set_pud,
+	.pv_mmu_ops.set_pud = native_set_pud,
 
-	.pmd_val = PTE_IDENT,
-	.make_pmd = PTE_IDENT,
+	.pv_mmu_ops.pmd_val = PTE_IDENT,
+	.pv_mmu_ops.make_pmd = PTE_IDENT,
 
 #if CONFIG_PGTABLE_LEVELS >= 4
-	.pud_val = PTE_IDENT,
-	.make_pud = PTE_IDENT,
+	.pv_mmu_ops.pud_val = PTE_IDENT,
+	.pv_mmu_ops.make_pud = PTE_IDENT,
 
-	.set_p4d = native_set_p4d,
+	.pv_mmu_ops.set_p4d = native_set_p4d,
 
 #if CONFIG_PGTABLE_LEVELS >= 5
-	.p4d_val = PTE_IDENT,
-	.make_p4d = PTE_IDENT,
+	.pv_mmu_ops.p4d_val = PTE_IDENT,
+	.pv_mmu_ops.make_p4d = PTE_IDENT,
 
-	.set_pgd = native_set_pgd,
+	.pv_mmu_ops.set_pgd = native_set_pgd,
 #endif /* CONFIG_PGTABLE_LEVELS >= 5 */
 #endif /* CONFIG_PGTABLE_LEVELS >= 4 */
 #endif /* CONFIG_PGTABLE_LEVELS >= 3 */
 
-	.pte_val = PTE_IDENT,
-	.pgd_val = PTE_IDENT,
+	.pv_mmu_ops.pte_val = PTE_IDENT,
+	.pv_mmu_ops.pgd_val = PTE_IDENT,
 
-	.make_pte = PTE_IDENT,
-	.make_pgd = PTE_IDENT,
+	.pv_mmu_ops.make_pte = PTE_IDENT,
+	.pv_mmu_ops.make_pgd = PTE_IDENT,
 
-	.dup_mmap = paravirt_nop,
-	.exit_mmap = paravirt_nop,
-	.activate_mm = paravirt_nop,
+	.pv_mmu_ops.dup_mmap = paravirt_nop,
+	.pv_mmu_ops.exit_mmap = paravirt_nop,
+	.pv_mmu_ops.activate_mm = paravirt_nop,
 
-	.lazy_mode = {
+	.pv_mmu_ops.lazy_mode = {
 		.enter = paravirt_nop,
 		.leave = paravirt_nop,
 		.flush = paravirt_nop,
 	},
 
-	.set_fixmap = native_set_fixmap,
+	.pv_mmu_ops.set_fixmap = native_set_fixmap,
+
+#if defined(CONFIG_PARAVIRT_SPINLOCKS)
+	/* Lock ops. */
+#ifdef CONFIG_SMP
+	.pv_lock_ops.queued_spin_lock_slowpath =
+		native_queued_spin_lock_slowpath,
+	.pv_lock_ops.queued_spin_unlock =
+		PV_CALLEE_SAVE(__native_queued_spin_unlock),
+	.pv_lock_ops.wait = paravirt_nop,
+	.pv_lock_ops.kick = paravirt_nop,
+	.pv_lock_ops.vcpu_is_preempted =
+		PV_CALLEE_SAVE(__native_vcpu_is_preempted),
+#endif /* SMP */
+#endif
 };
 
-EXPORT_SYMBOL_GPL(pv_time_ops);
-EXPORT_SYMBOL    (pv_cpu_ops);
-EXPORT_SYMBOL    (pv_mmu_ops);
+/* At this point, native_get/set_debugreg has real function entries */
+NOKPROBE_SYMBOL(native_get_debugreg);
+NOKPROBE_SYMBOL(native_set_debugreg);
+NOKPROBE_SYMBOL(native_load_idt);
+
+EXPORT_SYMBOL_GPL(pv_ops);
 EXPORT_SYMBOL_GPL(pv_info);
-EXPORT_SYMBOL    (pv_irq_ops);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 74392d9d51e0..42b936dd5846 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -230,7 +230,7 @@ unsigned long long sched_clock(void)
 
 bool using_native_sched_clock(void)
 {
-	return pv_time_ops.sched_clock == native_sched_clock;
+	return pv_ops.pv_time_ops.sched_clock == native_sched_clock;
 }
 #else
 unsigned long long
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index f194e5e1e95c..85425584f9a7 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -111,11 +111,12 @@ static void __init set_vsmp_pv_ops(void)
 
 	if (cap & ctl & (1 << 4)) {
 		/* Setup irq ops and turn on vSMP  IRQ fastpath handling */
-		pv_irq_ops.irq_disable = PV_CALLEE_SAVE(vsmp_irq_disable);
-		pv_irq_ops.irq_enable  = PV_CALLEE_SAVE(vsmp_irq_enable);
-		pv_irq_ops.save_fl  = PV_CALLEE_SAVE(vsmp_save_fl);
-		pv_irq_ops.restore_fl  = PV_CALLEE_SAVE(vsmp_restore_fl);
-		pv_init_ops.patch = vsmp_patch;
+		pv_ops.pv_irq_ops.irq_disable =
+			PV_CALLEE_SAVE(vsmp_irq_disable);
+		pv_ops.pv_irq_ops.irq_enable = PV_CALLEE_SAVE(vsmp_irq_enable);
+		pv_ops.pv_irq_ops.save_fl = PV_CALLEE_SAVE(vsmp_save_fl);
+		pv_ops.pv_irq_ops.restore_fl = PV_CALLEE_SAVE(vsmp_restore_fl);
+		pv_ops.pv_init_ops.patch = vsmp_patch;
 		ctl &= ~(1 << 4);
 	}
 	writel(ctl, address + 4);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 439a94bf89ad..dbb3a3b24cf8 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -998,11 +998,15 @@ void __ref xen_setup_vcpu_info_placement(void)
 	 * percpu area for all cpus, so make use of it.
 	 */
 	if (xen_have_vcpu_info_placement) {
-		pv_irq_ops.save_fl = __PV_IS_CALLEE_SAVE(xen_save_fl_direct);
-		pv_irq_ops.restore_fl = __PV_IS_CALLEE_SAVE(xen_restore_fl_direct);
-		pv_irq_ops.irq_disable = __PV_IS_CALLEE_SAVE(xen_irq_disable_direct);
-		pv_irq_ops.irq_enable = __PV_IS_CALLEE_SAVE(xen_irq_enable_direct);
-		pv_mmu_ops.read_cr2 = xen_read_cr2_direct;
+		pv_ops.pv_irq_ops.save_fl =
+			__PV_IS_CALLEE_SAVE(xen_save_fl_direct);
+		pv_ops.pv_irq_ops.restore_fl =
+			__PV_IS_CALLEE_SAVE(xen_restore_fl_direct);
+		pv_ops.pv_irq_ops.irq_disable =
+			__PV_IS_CALLEE_SAVE(xen_irq_disable_direct);
+		pv_ops.pv_irq_ops.irq_enable =
+			__PV_IS_CALLEE_SAVE(xen_irq_enable_direct);
+		pv_ops.pv_mmu_ops.read_cr2 = xen_read_cr2_direct;
 	}
 }
 
@@ -1177,14 +1181,14 @@ static void __init xen_boot_params_init_edd(void)
  */
 static void xen_setup_gdt(int cpu)
 {
-	pv_cpu_ops.write_gdt_entry = xen_write_gdt_entry_boot;
-	pv_cpu_ops.load_gdt = xen_load_gdt_boot;
+	pv_ops.pv_cpu_ops.write_gdt_entry = xen_write_gdt_entry_boot;
+	pv_ops.pv_cpu_ops.load_gdt = xen_load_gdt_boot;
 
 	setup_stack_canary_segment(0);
 	switch_to_new_gdt(0);
 
-	pv_cpu_ops.write_gdt_entry = xen_write_gdt_entry;
-	pv_cpu_ops.load_gdt = xen_load_gdt;
+	pv_ops.pv_cpu_ops.write_gdt_entry = xen_write_gdt_entry;
+	pv_ops.pv_cpu_ops.load_gdt = xen_load_gdt;
 }
 
 static void __init xen_dom0_set_legacy_features(void)
@@ -1209,8 +1213,8 @@ asmlinkage __visible void __init xen_start_kernel(void)
 
 	/* Install Xen paravirt ops */
 	pv_info = xen_info;
-	pv_init_ops.patch = paravirt_patch_default;
-	pv_cpu_ops = xen_cpu_ops;
+	pv_ops.pv_init_ops.patch = paravirt_patch_default;
+	pv_ops.pv_cpu_ops = xen_cpu_ops;
 	xen_init_irq_ops();
 
 	/*
@@ -1274,8 +1278,10 @@ asmlinkage __visible void __init xen_start_kernel(void)
 #endif
 
 	if (xen_feature(XENFEAT_mmu_pt_update_preserve_ad)) {
-		pv_mmu_ops.ptep_modify_prot_start = xen_ptep_modify_prot_start;
-		pv_mmu_ops.ptep_modify_prot_commit = xen_ptep_modify_prot_commit;
+		pv_ops.pv_mmu_ops.ptep_modify_prot_start =
+			xen_ptep_modify_prot_start;
+		pv_ops.pv_mmu_ops.ptep_modify_prot_commit =
+			xen_ptep_modify_prot_commit;
 	}
 
 	machine_ops = xen_machine_ops;
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index 7515a19fd324..2df69ffc33d6 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -128,6 +128,6 @@ static const struct pv_irq_ops xen_irq_ops __initconst = {
 
 void __init xen_init_irq_ops(void)
 {
-	pv_irq_ops = xen_irq_ops;
+	pv_ops.pv_irq_ops = xen_irq_ops;
 	x86_init.irqs.intr_init = xen_init_IRQ;
 }
diff --git a/arch/x86/xen/mmu_hvm.c b/arch/x86/xen/mmu_hvm.c
index dd2ad82eee80..5ef3ba3e748f 100644
--- a/arch/x86/xen/mmu_hvm.c
+++ b/arch/x86/xen/mmu_hvm.c
@@ -73,7 +73,7 @@ static int is_pagetable_dying_supported(void)
 void __init xen_hvm_init_mmu_ops(void)
 {
 	if (is_pagetable_dying_supported())
-		pv_mmu_ops.exit_mmap = xen_hvm_exit_mmap;
+		pv_ops.pv_mmu_ops.exit_mmap = xen_hvm_exit_mmap;
 #ifdef CONFIG_PROC_VMCORE
 	WARN_ON(register_oldmem_pfn_is_ram(&xen_oldmem_pfn_is_ram));
 #endif
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index b7ec689320c7..9f46c67787bc 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2215,7 +2215,7 @@ static void __init xen_write_cr3_init(unsigned long cr3)
 	set_page_prot(initial_page_table, PAGE_KERNEL);
 	set_page_prot(initial_kernel_pmd, PAGE_KERNEL);
 
-	pv_mmu_ops.write_cr3 = &xen_write_cr3;
+	pv_ops.pv_mmu_ops.write_cr3 = &xen_write_cr3;
 }
 
 /*
@@ -2364,27 +2364,27 @@ static void xen_set_fixmap(unsigned idx, phys_addr_t phys, pgprot_t prot)
 
 static void __init xen_post_allocator_init(void)
 {
-	pv_mmu_ops.set_pte = xen_set_pte;
-	pv_mmu_ops.set_pmd = xen_set_pmd;
-	pv_mmu_ops.set_pud = xen_set_pud;
+	pv_ops.pv_mmu_ops.set_pte = xen_set_pte;
+	pv_ops.pv_mmu_ops.set_pmd = xen_set_pmd;
+	pv_ops.pv_mmu_ops.set_pud = xen_set_pud;
 #ifdef CONFIG_X86_64
-	pv_mmu_ops.set_p4d = xen_set_p4d;
+	pv_ops.pv_mmu_ops.set_p4d = xen_set_p4d;
 #endif
 
 	/* This will work as long as patching hasn't happened yet
 	   (which it hasn't) */
-	pv_mmu_ops.alloc_pte = xen_alloc_pte;
-	pv_mmu_ops.alloc_pmd = xen_alloc_pmd;
-	pv_mmu_ops.release_pte = xen_release_pte;
-	pv_mmu_ops.release_pmd = xen_release_pmd;
+	pv_ops.pv_mmu_ops.alloc_pte = xen_alloc_pte;
+	pv_ops.pv_mmu_ops.alloc_pmd = xen_alloc_pmd;
+	pv_ops.pv_mmu_ops.release_pte = xen_release_pte;
+	pv_ops.pv_mmu_ops.release_pmd = xen_release_pmd;
 #ifdef CONFIG_X86_64
-	pv_mmu_ops.alloc_pud = xen_alloc_pud;
-	pv_mmu_ops.release_pud = xen_release_pud;
+	pv_ops.pv_mmu_ops.alloc_pud = xen_alloc_pud;
+	pv_ops.pv_mmu_ops.release_pud = xen_release_pud;
 #endif
-	pv_mmu_ops.make_pte = PV_CALLEE_SAVE(xen_make_pte);
+	pv_ops.pv_mmu_ops.make_pte = PV_CALLEE_SAVE(xen_make_pte);
 
 #ifdef CONFIG_X86_64
-	pv_mmu_ops.write_cr3 = &xen_write_cr3;
+	pv_ops.pv_mmu_ops.write_cr3 = &xen_write_cr3;
 #endif
 }
 
@@ -2471,7 +2471,7 @@ void __init xen_init_mmu_ops(void)
 	x86_init.paging.pagetable_init = xen_pagetable_init;
 	x86_init.hyper.init_after_bootmem = xen_after_bootmem;
 
-	pv_mmu_ops = xen_mmu_ops;
+	pv_ops.pv_mmu_ops = xen_mmu_ops;
 
 	memset(dummy_mapping, 0xff, PAGE_SIZE);
 }
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index cd97a62394e7..53b213af8c26 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -137,11 +137,13 @@ void __init xen_init_spinlocks(void)
 	printk(KERN_DEBUG "xen: PV spinlocks enabled\n");
 
 	__pv_init_lock_hash();
-	pv_lock_ops.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
-	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
-	pv_lock_ops.wait = xen_qlock_wait;
-	pv_lock_ops.kick = xen_qlock_kick;
-	pv_lock_ops.vcpu_is_preempted = PV_CALLEE_SAVE(xen_vcpu_stolen);
+	pv_ops.pv_lock_ops.queued_spin_lock_slowpath =
+		__pv_queued_spin_lock_slowpath;
+	pv_ops.pv_lock_ops.queued_spin_unlock =
+		PV_CALLEE_SAVE(__pv_queued_spin_unlock);
+	pv_ops.pv_lock_ops.wait = xen_qlock_wait;
+	pv_ops.pv_lock_ops.kick = xen_qlock_kick;
+	pv_ops.pv_lock_ops.vcpu_is_preempted = PV_CALLEE_SAVE(xen_vcpu_stolen);
 }
 
 static __init int xen_parse_nopvspin(char *arg)
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index e0f1bcf01d63..66311c3e90b0 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -505,7 +505,7 @@ static void __init xen_time_init(void)
 
 void __ref xen_init_time_ops(void)
 {
-	pv_time_ops = xen_time_ops;
+	pv_ops.pv_time_ops = xen_time_ops;
 
 	x86_init.timers.timer_init = xen_time_init;
 	x86_init.timers.setup_percpu_clockev = x86_init_noop;
@@ -547,7 +547,7 @@ void __init xen_hvm_init_time_ops(void)
 		return;
 	}
 
-	pv_time_ops = xen_time_ops;
+	pv_ops.pv_time_ops = xen_time_ops;
 	x86_init.timers.setup_percpu_clockev = xen_time_init;
 	x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;
 
diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index 3e741cd1409c..994fb1ae64b3 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -175,7 +175,7 @@ void __init xen_time_setup_guest(void)
 	xen_runstate_remote = !HYPERVISOR_vm_assist(VMASST_CMD_enable,
 					VMASST_TYPE_runstate_update_flag);
 
-	pv_time_ops.steal_clock = xen_steal_clock;
+	pv_ops.pv_time_ops.steal_clock = xen_steal_clock;
 
 	static_key_slow_inc(&paravirt_steal_enabled);
 	if (xen_runstate_remote)
-- 
2.13.7

