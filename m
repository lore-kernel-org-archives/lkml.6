Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE22C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3E620843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:59:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B3E620843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbeICTTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:19:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeICTTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:19:34 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w83EwoQE3340193
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 3 Sep 2018 07:58:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w83EwoCI3340190;
        Mon, 3 Sep 2018 07:58:50 -0700
Date:   Mon, 3 Sep 2018 07:58:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-5c83511bdb9832c86be20fb86b783356e2f58062@git.kernel.org>
Cc:     jgross@suse.com, tglx@linutronix.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, jgross@suse.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180828074026.820-9-jgross@suse.com>
References: <20180828074026.820-9-jgross@suse.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/paravirt] x86/paravirt: Use a single ops structure
Git-Commit-ID: 5c83511bdb9832c86be20fb86b783356e2f58062
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5c83511bdb9832c86be20fb86b783356e2f58062
Gitweb:     https://git.kernel.org/tip/5c83511bdb9832c86be20fb86b783356e2f58062
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Tue, 28 Aug 2018 09:40:19 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 3 Sep 2018 16:50:35 +0200

x86/paravirt: Use a single ops structure

Instead of using six globally visible paravirt ops structures combine
them in a single structure, keeping the original structures as
sub-structures.

This avoids the need to assemble struct paravirt_patch_template at
runtime on the stack each time apply_paravirt() is being called (i.e.
when loading a module).

[ tglx: Made the struct and the initializer tabular for readability sake ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org
Cc: virtualization@lists.linux-foundation.org
Cc: akataria@vmware.com
Cc: rusty@rustcorp.com.au
Cc: boris.ostrovsky@oracle.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20180828074026.820-9-jgross@suse.com

---
 arch/arm/include/asm/paravirt.h       |   9 +-
 arch/arm/kernel/paravirt.c            |   4 +-
 arch/arm64/include/asm/paravirt.h     |   9 +-
 arch/arm64/kernel/paravirt.c          |   4 +-
 arch/x86/hyperv/mmu.c                 |   4 +-
 arch/x86/include/asm/paravirt.h       | 275 +++++++++++++++-----------------
 arch/x86/include/asm/paravirt_types.h |  25 ++-
 arch/x86/kernel/alternative.c         |   2 +-
 arch/x86/kernel/asm-offsets.c         |  12 +-
 arch/x86/kernel/asm-offsets_64.c      |   7 +-
 arch/x86/kernel/cpu/common.c          |   2 +-
 arch/x86/kernel/cpu/vmware.c          |   4 +-
 arch/x86/kernel/kvm.c                 |  19 +--
 arch/x86/kernel/kvmclock.c            |   4 +-
 arch/x86/kernel/paravirt-spinlocks.c  |  15 +-
 arch/x86/kernel/paravirt.c            | 290 +++++++++++++++++-----------------
 arch/x86/kernel/paravirt_patch_32.c   |  48 +++---
 arch/x86/kernel/paravirt_patch_64.c   |  56 +++----
 arch/x86/kernel/tsc.c                 |   2 +-
 arch/x86/kernel/vsmp_64.c             |  18 +--
 arch/x86/xen/enlighten_pv.c           |  31 ++--
 arch/x86/xen/irq.c                    |   2 +-
 arch/x86/xen/mmu_hvm.c                |   2 +-
 arch/x86/xen/mmu_pv.c                 |  28 ++--
 arch/x86/xen/spinlock.c               |  11 +-
 arch/x86/xen/time.c                   |   4 +-
 drivers/xen/time.c                    |   2 +-
 27 files changed, 431 insertions(+), 458 deletions(-)

diff --git a/arch/arm/include/asm/paravirt.h b/arch/arm/include/asm/paravirt.h
index d51e5cd31d01..cdbf02d9c1d4 100644
--- a/arch/arm/include/asm/paravirt.h
+++ b/arch/arm/include/asm/paravirt.h
@@ -10,11 +10,16 @@ extern struct static_key paravirt_steal_rq_enabled;
 struct pv_time_ops {
 	unsigned long long (*steal_clock)(int cpu);
 };
-extern struct pv_time_ops pv_time_ops;
+
+struct paravirt_patch_template {
+	struct pv_time_ops time;
+};
+
+extern struct paravirt_patch_template pv_ops;
 
 static inline u64 paravirt_steal_clock(int cpu)
 {
-	return pv_time_ops.steal_clock(cpu);
+	return pv_ops.time.steal_clock(cpu);
 }
 #endif
 
diff --git a/arch/arm/kernel/paravirt.c b/arch/arm/kernel/paravirt.c
index 53f371ed4568..75c158b0353f 100644
--- a/arch/arm/kernel/paravirt.c
+++ b/arch/arm/kernel/paravirt.c
@@ -21,5 +21,5 @@
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
-struct pv_time_ops pv_time_ops;
-EXPORT_SYMBOL_GPL(pv_time_ops);
+struct paravirt_patch_template pv_ops;
+EXPORT_SYMBOL_GPL(pv_ops);
diff --git a/arch/arm64/include/asm/paravirt.h b/arch/arm64/include/asm/paravirt.h
index bb5dcea42003..799d9dd6f7cc 100644
--- a/arch/arm64/include/asm/paravirt.h
+++ b/arch/arm64/include/asm/paravirt.h
@@ -10,11 +10,16 @@ extern struct static_key paravirt_steal_rq_enabled;
 struct pv_time_ops {
 	unsigned long long (*steal_clock)(int cpu);
 };
-extern struct pv_time_ops pv_time_ops;
+
+struct paravirt_patch_template {
+	struct pv_time_ops time;
+};
+
+extern struct paravirt_patch_template pv_ops;
 
 static inline u64 paravirt_steal_clock(int cpu)
 {
-	return pv_time_ops.steal_clock(cpu);
+	return pv_ops.time.steal_clock(cpu);
 }
 #endif
 
diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
index 53f371ed4568..75c158b0353f 100644
--- a/arch/arm64/kernel/paravirt.c
+++ b/arch/arm64/kernel/paravirt.c
@@ -21,5 +21,5 @@
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
 
-struct pv_time_ops pv_time_ops;
-EXPORT_SYMBOL_GPL(pv_time_ops);
+struct paravirt_patch_template pv_ops;
+EXPORT_SYMBOL_GPL(pv_ops);
diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index ef5f29f913d7..e65d7fe6489f 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -231,6 +231,6 @@ void hyperv_setup_mmu_ops(void)
 		return;
 
 	pr_info("Using hypercall for remote TLB flush\n");
-	pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others;
-	pv_mmu_ops.tlb_remove_table = tlb_remove_table;
+	pv_ops.mmu.flush_tlb_others = hyperv_flush_tlb_others;
+	pv_ops.mmu.tlb_remove_table = tlb_remove_table;
 }
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index e1364cb40ce5..a9189b81c7dd 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -19,14 +19,14 @@
 
 static inline void load_sp0(unsigned long sp0)
 {
-	PVOP_VCALL1(pv_cpu_ops.load_sp0, sp0);
+	PVOP_VCALL1(cpu.load_sp0, sp0);
 }
 
 /* The paravirtualized CPUID instruction. */
 static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
 			   unsigned int *ecx, unsigned int *edx)
 {
-	PVOP_VCALL4(pv_cpu_ops.cpuid, eax, ebx, ecx, edx);
+	PVOP_VCALL4(cpu.cpuid, eax, ebx, ecx, edx);
 }
 
 /*
@@ -34,98 +34,98 @@ static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
  */
 static inline unsigned long paravirt_get_debugreg(int reg)
 {
-	return PVOP_CALL1(unsigned long, pv_cpu_ops.get_debugreg, reg);
+	return PVOP_CALL1(unsigned long, cpu.get_debugreg, reg);
 }
 #define get_debugreg(var, reg) var = paravirt_get_debugreg(reg)
 static inline void set_debugreg(unsigned long val, int reg)
 {
-	PVOP_VCALL2(pv_cpu_ops.set_debugreg, reg, val);
+	PVOP_VCALL2(cpu.set_debugreg, reg, val);
 }
 
 static inline unsigned long read_cr0(void)
 {
-	return PVOP_CALL0(unsigned long, pv_cpu_ops.read_cr0);
+	return PVOP_CALL0(unsigned long, cpu.read_cr0);
 }
 
 static inline void write_cr0(unsigned long x)
 {
-	PVOP_VCALL1(pv_cpu_ops.write_cr0, x);
+	PVOP_VCALL1(cpu.write_cr0, x);
 }
 
 static inline unsigned long read_cr2(void)
 {
-	return PVOP_CALL0(unsigned long, pv_mmu_ops.read_cr2);
+	return PVOP_CALL0(unsigned long, mmu.read_cr2);
 }
 
 static inline void write_cr2(unsigned long x)
 {
-	PVOP_VCALL1(pv_mmu_ops.write_cr2, x);
+	PVOP_VCALL1(mmu.write_cr2, x);
 }
 
 static inline unsigned long __read_cr3(void)
 {
-	return PVOP_CALL0(unsigned long, pv_mmu_ops.read_cr3);
+	return PVOP_CALL0(unsigned long, mmu.read_cr3);
 }
 
 static inline void write_cr3(unsigned long x)
 {
-	PVOP_VCALL1(pv_mmu_ops.write_cr3, x);
+	PVOP_VCALL1(mmu.write_cr3, x);
 }
 
 static inline void __write_cr4(unsigned long x)
 {
-	PVOP_VCALL1(pv_cpu_ops.write_cr4, x);
+	PVOP_VCALL1(cpu.write_cr4, x);
 }
 
 #ifdef CONFIG_X86_64
 static inline unsigned long read_cr8(void)
 {
-	return PVOP_CALL0(unsigned long, pv_cpu_ops.read_cr8);
+	return PVOP_CALL0(unsigned long, cpu.read_cr8);
 }
 
 static inline void write_cr8(unsigned long x)
 {
-	PVOP_VCALL1(pv_cpu_ops.write_cr8, x);
+	PVOP_VCALL1(cpu.write_cr8, x);
 }
 #endif
 
 static inline void arch_safe_halt(void)
 {
-	PVOP_VCALL0(pv_irq_ops.safe_halt);
+	PVOP_VCALL0(irq.safe_halt);
 }
 
 static inline void halt(void)
 {
-	PVOP_VCALL0(pv_irq_ops.halt);
+	PVOP_VCALL0(irq.halt);
 }
 
 static inline void wbinvd(void)
 {
-	PVOP_VCALL0(pv_cpu_ops.wbinvd);
+	PVOP_VCALL0(cpu.wbinvd);
 }
 
 #define get_kernel_rpl()  (pv_info.kernel_rpl)
 
 static inline u64 paravirt_read_msr(unsigned msr)
 {
-	return PVOP_CALL1(u64, pv_cpu_ops.read_msr, msr);
+	return PVOP_CALL1(u64, cpu.read_msr, msr);
 }
 
 static inline void paravirt_write_msr(unsigned msr,
 				      unsigned low, unsigned high)
 {
-	PVOP_VCALL3(pv_cpu_ops.write_msr, msr, low, high);
+	PVOP_VCALL3(cpu.write_msr, msr, low, high);
 }
 
 static inline u64 paravirt_read_msr_safe(unsigned msr, int *err)
 {
-	return PVOP_CALL2(u64, pv_cpu_ops.read_msr_safe, msr, err);
+	return PVOP_CALL2(u64, cpu.read_msr_safe, msr, err);
 }
 
 static inline int paravirt_write_msr_safe(unsigned msr,
 					  unsigned low, unsigned high)
 {
-	return PVOP_CALL3(int, pv_cpu_ops.write_msr_safe, msr, low, high);
+	return PVOP_CALL3(int, cpu.write_msr_safe, msr, low, high);
 }
 
 #define rdmsr(msr, val1, val2)			\
@@ -172,7 +172,7 @@ static inline int rdmsrl_safe(unsigned msr, unsigned long long *p)
 
 static inline unsigned long long paravirt_sched_clock(void)
 {
-	return PVOP_CALL0(unsigned long long, pv_time_ops.sched_clock);
+	return PVOP_CALL0(unsigned long long, time.sched_clock);
 }
 
 struct static_key;
@@ -181,12 +181,12 @@ extern struct static_key paravirt_steal_rq_enabled;
 
 static inline u64 paravirt_steal_clock(int cpu)
 {
-	return PVOP_CALL1(u64, pv_time_ops.steal_clock, cpu);
+	return PVOP_CALL1(u64, time.steal_clock, cpu);
 }
 
 static inline unsigned long long paravirt_read_pmc(int counter)
 {
-	return PVOP_CALL1(u64, pv_cpu_ops.read_pmc, counter);
+	return PVOP_CALL1(u64, cpu.read_pmc, counter);
 }
 
 #define rdpmc(counter, low, high)		\
@@ -200,166 +200,166 @@ do {						\
 
 static inline void paravirt_alloc_ldt(struct desc_struct *ldt, unsigned entries)
 {
-	PVOP_VCALL2(pv_cpu_ops.alloc_ldt, ldt, entries);
+	PVOP_VCALL2(cpu.alloc_ldt, ldt, entries);
 }
 
 static inline void paravirt_free_ldt(struct desc_struct *ldt, unsigned entries)
 {
-	PVOP_VCALL2(pv_cpu_ops.free_ldt, ldt, entries);
+	PVOP_VCALL2(cpu.free_ldt, ldt, entries);
 }
 
 static inline void load_TR_desc(void)
 {
-	PVOP_VCALL0(pv_cpu_ops.load_tr_desc);
+	PVOP_VCALL0(cpu.load_tr_desc);
 }
 static inline void load_gdt(const struct desc_ptr *dtr)
 {
-	PVOP_VCALL1(pv_cpu_ops.load_gdt, dtr);
+	PVOP_VCALL1(cpu.load_gdt, dtr);
 }
 static inline void load_idt(const struct desc_ptr *dtr)
 {
-	PVOP_VCALL1(pv_cpu_ops.load_idt, dtr);
+	PVOP_VCALL1(cpu.load_idt, dtr);
 }
 static inline void set_ldt(const void *addr, unsigned entries)
 {
-	PVOP_VCALL2(pv_cpu_ops.set_ldt, addr, entries);
+	PVOP_VCALL2(cpu.set_ldt, addr, entries);
 }
 static inline unsigned long paravirt_store_tr(void)
 {
-	return PVOP_CALL0(unsigned long, pv_cpu_ops.store_tr);
+	return PVOP_CALL0(unsigned long, cpu.store_tr);
 }
 #define store_tr(tr)	((tr) = paravirt_store_tr())
 static inline void load_TLS(struct thread_struct *t, unsigned cpu)
 {
-	PVOP_VCALL2(pv_cpu_ops.load_tls, t, cpu);
+	PVOP_VCALL2(cpu.load_tls, t, cpu);
 }
 
 #ifdef CONFIG_X86_64
 static inline void load_gs_index(unsigned int gs)
 {
-	PVOP_VCALL1(pv_cpu_ops.load_gs_index, gs);
+	PVOP_VCALL1(cpu.load_gs_index, gs);
 }
 #endif
 
 static inline void write_ldt_entry(struct desc_struct *dt, int entry,
 				   const void *desc)
 {
-	PVOP_VCALL3(pv_cpu_ops.write_ldt_entry, dt, entry, desc);
+	PVOP_VCALL3(cpu.write_ldt_entry, dt, entry, desc);
 }
 
 static inline void write_gdt_entry(struct desc_struct *dt, int entry,
 				   void *desc, int type)
 {
-	PVOP_VCALL4(pv_cpu_ops.write_gdt_entry, dt, entry, desc, type);
+	PVOP_VCALL4(cpu.write_gdt_entry, dt, entry, desc, type);
 }
 
 static inline void write_idt_entry(gate_desc *dt, int entry, const gate_desc *g)
 {
-	PVOP_VCALL3(pv_cpu_ops.write_idt_entry, dt, entry, g);
+	PVOP_VCALL3(cpu.write_idt_entry, dt, entry, g);
 }
 static inline void set_iopl_mask(unsigned mask)
 {
-	PVOP_VCALL1(pv_cpu_ops.set_iopl_mask, mask);
+	PVOP_VCALL1(cpu.set_iopl_mask, mask);
 }
 
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void)
 {
-	pv_cpu_ops.io_delay();
+	pv_ops.cpu.io_delay();
 #ifdef REALLY_SLOW_IO
-	pv_cpu_ops.io_delay();
-	pv_cpu_ops.io_delay();
-	pv_cpu_ops.io_delay();
+	pv_ops.cpu.io_delay();
+	pv_ops.cpu.io_delay();
+	pv_ops.cpu.io_delay();
 #endif
 }
 
 static inline void paravirt_activate_mm(struct mm_struct *prev,
 					struct mm_struct *next)
 {
-	PVOP_VCALL2(pv_mmu_ops.activate_mm, prev, next);
+	PVOP_VCALL2(mmu.activate_mm, prev, next);
 }
 
 static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
 					  struct mm_struct *mm)
 {
-	PVOP_VCALL2(pv_mmu_ops.dup_mmap, oldmm, mm);
+	PVOP_VCALL2(mmu.dup_mmap, oldmm, mm);
 }
 
 static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 {
-	PVOP_VCALL1(pv_mmu_ops.exit_mmap, mm);
+	PVOP_VCALL1(mmu.exit_mmap, mm);
 }
 
 static inline void __flush_tlb(void)
 {
-	PVOP_VCALL0(pv_mmu_ops.flush_tlb_user);
+	PVOP_VCALL0(mmu.flush_tlb_user);
 }
 static inline void __flush_tlb_global(void)
 {
-	PVOP_VCALL0(pv_mmu_ops.flush_tlb_kernel);
+	PVOP_VCALL0(mmu.flush_tlb_kernel);
 }
 static inline void __flush_tlb_one_user(unsigned long addr)
 {
-	PVOP_VCALL1(pv_mmu_ops.flush_tlb_one_user, addr);
+	PVOP_VCALL1(mmu.flush_tlb_one_user, addr);
 }
 
 static inline void flush_tlb_others(const struct cpumask *cpumask,
 				    const struct flush_tlb_info *info)
 {
-	PVOP_VCALL2(pv_mmu_ops.flush_tlb_others, cpumask, info);
+	PVOP_VCALL2(mmu.flush_tlb_others, cpumask, info);
 }
 
 static inline void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
-	PVOP_VCALL2(pv_mmu_ops.tlb_remove_table, tlb, table);
+	PVOP_VCALL2(mmu.tlb_remove_table, tlb, table);
 }
 
 static inline int paravirt_pgd_alloc(struct mm_struct *mm)
 {
-	return PVOP_CALL1(int, pv_mmu_ops.pgd_alloc, mm);
+	return PVOP_CALL1(int, mmu.pgd_alloc, mm);
 }
 
 static inline void paravirt_pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	PVOP_VCALL2(pv_mmu_ops.pgd_free, mm, pgd);
+	PVOP_VCALL2(mmu.pgd_free, mm, pgd);
 }
 
 static inline void paravirt_alloc_pte(struct mm_struct *mm, unsigned long pfn)
 {
-	PVOP_VCALL2(pv_mmu_ops.alloc_pte, mm, pfn);
+	PVOP_VCALL2(mmu.alloc_pte, mm, pfn);
 }
 static inline void paravirt_release_pte(unsigned long pfn)
 {
-	PVOP_VCALL1(pv_mmu_ops.release_pte, pfn);
+	PVOP_VCALL1(mmu.release_pte, pfn);
 }
 
 static inline void paravirt_alloc_pmd(struct mm_struct *mm, unsigned long pfn)
 {
-	PVOP_VCALL2(pv_mmu_ops.alloc_pmd, mm, pfn);
+	PVOP_VCALL2(mmu.alloc_pmd, mm, pfn);
 }
 
 static inline void paravirt_release_pmd(unsigned long pfn)
 {
-	PVOP_VCALL1(pv_mmu_ops.release_pmd, pfn);
+	PVOP_VCALL1(mmu.release_pmd, pfn);
 }
 
 static inline void paravirt_alloc_pud(struct mm_struct *mm, unsigned long pfn)
 {
-	PVOP_VCALL2(pv_mmu_ops.alloc_pud, mm, pfn);
+	PVOP_VCALL2(mmu.alloc_pud, mm, pfn);
 }
 static inline void paravirt_release_pud(unsigned long pfn)
 {
-	PVOP_VCALL1(pv_mmu_ops.release_pud, pfn);
+	PVOP_VCALL1(mmu.release_pud, pfn);
 }
 
 static inline void paravirt_alloc_p4d(struct mm_struct *mm, unsigned long pfn)
 {
-	PVOP_VCALL2(pv_mmu_ops.alloc_p4d, mm, pfn);
+	PVOP_VCALL2(mmu.alloc_p4d, mm, pfn);
 }
 
 static inline void paravirt_release_p4d(unsigned long pfn)
 {
-	PVOP_VCALL1(pv_mmu_ops.release_p4d, pfn);
+	PVOP_VCALL1(mmu.release_p4d, pfn);
 }
 
 static inline pte_t __pte(pteval_t val)
@@ -367,13 +367,9 @@ static inline pte_t __pte(pteval_t val)
 	pteval_t ret;
 
 	if (sizeof(pteval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pteval_t,
-				   pv_mmu_ops.make_pte,
-				   val, (u64)val >> 32);
+		ret = PVOP_CALLEE2(pteval_t, mmu.make_pte, val, (u64)val >> 32);
 	else
-		ret = PVOP_CALLEE1(pteval_t,
-				   pv_mmu_ops.make_pte,
-				   val);
+		ret = PVOP_CALLEE1(pteval_t, mmu.make_pte, val);
 
 	return (pte_t) { .pte = ret };
 }
@@ -383,11 +379,10 @@ static inline pteval_t pte_val(pte_t pte)
 	pteval_t ret;
 
 	if (sizeof(pteval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pteval_t, pv_mmu_ops.pte_val,
+		ret = PVOP_CALLEE2(pteval_t, mmu.pte_val,
 				   pte.pte, (u64)pte.pte >> 32);
 	else
-		ret = PVOP_CALLEE1(pteval_t, pv_mmu_ops.pte_val,
-				   pte.pte);
+		ret = PVOP_CALLEE1(pteval_t, mmu.pte_val, pte.pte);
 
 	return ret;
 }
@@ -397,11 +392,9 @@ static inline pgd_t __pgd(pgdval_t val)
 	pgdval_t ret;
 
 	if (sizeof(pgdval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pgdval_t, pv_mmu_ops.make_pgd,
-				   val, (u64)val >> 32);
+		ret = PVOP_CALLEE2(pgdval_t, mmu.make_pgd, val, (u64)val >> 32);
 	else
-		ret = PVOP_CALLEE1(pgdval_t, pv_mmu_ops.make_pgd,
-				   val);
+		ret = PVOP_CALLEE1(pgdval_t, mmu.make_pgd, val);
 
 	return (pgd_t) { ret };
 }
@@ -411,11 +404,10 @@ static inline pgdval_t pgd_val(pgd_t pgd)
 	pgdval_t ret;
 
 	if (sizeof(pgdval_t) > sizeof(long))
-		ret =  PVOP_CALLEE2(pgdval_t, pv_mmu_ops.pgd_val,
+		ret =  PVOP_CALLEE2(pgdval_t, mmu.pgd_val,
 				    pgd.pgd, (u64)pgd.pgd >> 32);
 	else
-		ret =  PVOP_CALLEE1(pgdval_t, pv_mmu_ops.pgd_val,
-				    pgd.pgd);
+		ret =  PVOP_CALLEE1(pgdval_t, mmu.pgd_val, pgd.pgd);
 
 	return ret;
 }
@@ -426,8 +418,7 @@ static inline pte_t ptep_modify_prot_start(struct mm_struct *mm, unsigned long a
 {
 	pteval_t ret;
 
-	ret = PVOP_CALL3(pteval_t, pv_mmu_ops.ptep_modify_prot_start,
-			 mm, addr, ptep);
+	ret = PVOP_CALL3(pteval_t, mmu.ptep_modify_prot_start, mm, addr, ptep);
 
 	return (pte_t) { .pte = ret };
 }
@@ -437,20 +428,18 @@ static inline void ptep_modify_prot_commit(struct mm_struct *mm, unsigned long a
 {
 	if (sizeof(pteval_t) > sizeof(long))
 		/* 5 arg words */
-		pv_mmu_ops.ptep_modify_prot_commit(mm, addr, ptep, pte);
+		pv_ops.mmu.ptep_modify_prot_commit(mm, addr, ptep, pte);
 	else
-		PVOP_VCALL4(pv_mmu_ops.ptep_modify_prot_commit,
+		PVOP_VCALL4(mmu.ptep_modify_prot_commit,
 			    mm, addr, ptep, pte.pte);
 }
 
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
 	if (sizeof(pteval_t) > sizeof(long))
-		PVOP_VCALL3(pv_mmu_ops.set_pte, ptep,
-			    pte.pte, (u64)pte.pte >> 32);
+		PVOP_VCALL3(mmu.set_pte, ptep, pte.pte, (u64)pte.pte >> 32);
 	else
-		PVOP_VCALL2(pv_mmu_ops.set_pte, ptep,
-			    pte.pte);
+		PVOP_VCALL2(mmu.set_pte, ptep, pte.pte);
 }
 
 static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
@@ -458,9 +447,9 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 {
 	if (sizeof(pteval_t) > sizeof(long))
 		/* 5 arg words */
-		pv_mmu_ops.set_pte_at(mm, addr, ptep, pte);
+		pv_ops.mmu.set_pte_at(mm, addr, ptep, pte);
 	else
-		PVOP_VCALL4(pv_mmu_ops.set_pte_at, mm, addr, ptep, pte.pte);
+		PVOP_VCALL4(mmu.set_pte_at, mm, addr, ptep, pte.pte);
 }
 
 static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
@@ -468,9 +457,9 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 	pmdval_t val = native_pmd_val(pmd);
 
 	if (sizeof(pmdval_t) > sizeof(long))
-		PVOP_VCALL3(pv_mmu_ops.set_pmd, pmdp, val, (u64)val >> 32);
+		PVOP_VCALL3(mmu.set_pmd, pmdp, val, (u64)val >> 32);
 	else
-		PVOP_VCALL2(pv_mmu_ops.set_pmd, pmdp, val);
+		PVOP_VCALL2(mmu.set_pmd, pmdp, val);
 }
 
 #if CONFIG_PGTABLE_LEVELS >= 3
@@ -479,11 +468,9 @@ static inline pmd_t __pmd(pmdval_t val)
 	pmdval_t ret;
 
 	if (sizeof(pmdval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pmdval_t, pv_mmu_ops.make_pmd,
-				   val, (u64)val >> 32);
+		ret = PVOP_CALLEE2(pmdval_t, mmu.make_pmd, val, (u64)val >> 32);
 	else
-		ret = PVOP_CALLEE1(pmdval_t, pv_mmu_ops.make_pmd,
-				   val);
+		ret = PVOP_CALLEE1(pmdval_t, mmu.make_pmd, val);
 
 	return (pmd_t) { ret };
 }
@@ -493,11 +480,10 @@ static inline pmdval_t pmd_val(pmd_t pmd)
 	pmdval_t ret;
 
 	if (sizeof(pmdval_t) > sizeof(long))
-		ret =  PVOP_CALLEE2(pmdval_t, pv_mmu_ops.pmd_val,
+		ret =  PVOP_CALLEE2(pmdval_t, mmu.pmd_val,
 				    pmd.pmd, (u64)pmd.pmd >> 32);
 	else
-		ret =  PVOP_CALLEE1(pmdval_t, pv_mmu_ops.pmd_val,
-				    pmd.pmd);
+		ret =  PVOP_CALLEE1(pmdval_t, mmu.pmd_val, pmd.pmd);
 
 	return ret;
 }
@@ -507,11 +493,9 @@ static inline void set_pud(pud_t *pudp, pud_t pud)
 	pudval_t val = native_pud_val(pud);
 
 	if (sizeof(pudval_t) > sizeof(long))
-		PVOP_VCALL3(pv_mmu_ops.set_pud, pudp,
-			    val, (u64)val >> 32);
+		PVOP_VCALL3(mmu.set_pud, pudp, val, (u64)val >> 32);
 	else
-		PVOP_VCALL2(pv_mmu_ops.set_pud, pudp,
-			    val);
+		PVOP_VCALL2(mmu.set_pud, pudp, val);
 }
 #if CONFIG_PGTABLE_LEVELS >= 4
 static inline pud_t __pud(pudval_t val)
@@ -519,11 +503,9 @@ static inline pud_t __pud(pudval_t val)
 	pudval_t ret;
 
 	if (sizeof(pudval_t) > sizeof(long))
-		ret = PVOP_CALLEE2(pudval_t, pv_mmu_ops.make_pud,
-				   val, (u64)val >> 32);
+		ret = PVOP_CALLEE2(pudval_t, mmu.make_pud, val, (u64)val >> 32);
 	else
-		ret = PVOP_CALLEE1(pudval_t, pv_mmu_ops.make_pud,
-				   val);
+		ret = PVOP_CALLEE1(pudval_t, mmu.make_pud, val);
 
 	return (pud_t) { ret };
 }
@@ -533,11 +515,10 @@ static inline pudval_t pud_val(pud_t pud)
 	pudval_t ret;
 
 	if (sizeof(pudval_t) > sizeof(long))
-		ret =  PVOP_CALLEE2(pudval_t, pv_mmu_ops.pud_val,
+		ret =  PVOP_CALLEE2(pudval_t, mmu.pud_val,
 				    pud.pud, (u64)pud.pud >> 32);
 	else
-		ret =  PVOP_CALLEE1(pudval_t, pv_mmu_ops.pud_val,
-				    pud.pud);
+		ret =  PVOP_CALLEE1(pudval_t, mmu.pud_val, pud.pud);
 
 	return ret;
 }
@@ -552,30 +533,28 @@ static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
 	p4dval_t val = native_p4d_val(p4d);
 
 	if (sizeof(p4dval_t) > sizeof(long))
-		PVOP_VCALL3(pv_mmu_ops.set_p4d, p4dp,
-			    val, (u64)val >> 32);
+		PVOP_VCALL3(mmu.set_p4d, p4dp, val, (u64)val >> 32);
 	else
-		PVOP_VCALL2(pv_mmu_ops.set_p4d, p4dp,
-			    val);
+		PVOP_VCALL2(mmu.set_p4d, p4dp, val);
 }
 
 #if CONFIG_PGTABLE_LEVELS >= 5
 
 static inline p4d_t __p4d(p4dval_t val)
 {
-	p4dval_t ret = PVOP_CALLEE1(p4dval_t, pv_mmu_ops.make_p4d, val);
+	p4dval_t ret = PVOP_CALLEE1(p4dval_t, mmu.make_p4d, val);
 
 	return (p4d_t) { ret };
 }
 
 static inline p4dval_t p4d_val(p4d_t p4d)
 {
-	return PVOP_CALLEE1(p4dval_t, pv_mmu_ops.p4d_val, p4d.p4d);
+	return PVOP_CALLEE1(p4dval_t, mmu.p4d_val, p4d.p4d);
 }
 
 static inline void __set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-	PVOP_VCALL2(pv_mmu_ops.set_pgd, pgdp, native_pgd_val(pgd));
+	PVOP_VCALL2(mmu.set_pgd, pgdp, native_pgd_val(pgd));
 }
 
 #define set_pgd(pgdp, pgdval) do {					\
@@ -606,19 +585,18 @@ static inline void p4d_clear(p4d_t *p4dp)
    64-bit pte atomically */
 static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
 {
-	PVOP_VCALL3(pv_mmu_ops.set_pte_atomic, ptep,
-		    pte.pte, pte.pte >> 32);
+	PVOP_VCALL3(mmu.set_pte_atomic, ptep, pte.pte, pte.pte >> 32);
 }
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr,
 			     pte_t *ptep)
 {
-	PVOP_VCALL3(pv_mmu_ops.pte_clear, mm, addr, ptep);
+	PVOP_VCALL3(mmu.pte_clear, mm, addr, ptep);
 }
 
 static inline void pmd_clear(pmd_t *pmdp)
 {
-	PVOP_VCALL1(pv_mmu_ops.pmd_clear, pmdp);
+	PVOP_VCALL1(mmu.pmd_clear, pmdp);
 }
 #else  /* !CONFIG_X86_PAE */
 static inline void set_pte_atomic(pte_t *ptep, pte_t pte)
@@ -641,34 +619,34 @@ static inline void pmd_clear(pmd_t *pmdp)
 #define  __HAVE_ARCH_START_CONTEXT_SWITCH
 static inline void arch_start_context_switch(struct task_struct *prev)
 {
-	PVOP_VCALL1(pv_cpu_ops.start_context_switch, prev);
+	PVOP_VCALL1(cpu.start_context_switch, prev);
 }
 
 static inline void arch_end_context_switch(struct task_struct *next)
 {
-	PVOP_VCALL1(pv_cpu_ops.end_context_switch, next);
+	PVOP_VCALL1(cpu.end_context_switch, next);
 }
 
 #define  __HAVE_ARCH_ENTER_LAZY_MMU_MODE
 static inline void arch_enter_lazy_mmu_mode(void)
 {
-	PVOP_VCALL0(pv_mmu_ops.lazy_mode.enter);
+	PVOP_VCALL0(mmu.lazy_mode.enter);
 }
 
 static inline void arch_leave_lazy_mmu_mode(void)
 {
-	PVOP_VCALL0(pv_mmu_ops.lazy_mode.leave);
+	PVOP_VCALL0(mmu.lazy_mode.leave);
 }
 
 static inline void arch_flush_lazy_mmu_mode(void)
 {
-	PVOP_VCALL0(pv_mmu_ops.lazy_mode.flush);
+	PVOP_VCALL0(mmu.lazy_mode.flush);
 }
 
 static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
 				phys_addr_t phys, pgprot_t flags)
 {
-	pv_mmu_ops.set_fixmap(idx, phys, flags);
+	pv_ops.mmu.set_fixmap(idx, phys, flags);
 }
 
 #if defined(CONFIG_SMP) && defined(CONFIG_PARAVIRT_SPINLOCKS)
@@ -676,29 +654,32 @@ static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
 static __always_inline void pv_queued_spin_lock_slowpath(struct qspinlock *lock,
 							u32 val)
 {
-	PVOP_VCALL2(pv_lock_ops.queued_spin_lock_slowpath, lock, val);
+	PVOP_VCALL2(lock.queued_spin_lock_slowpath, lock, val);
 }
 
 static __always_inline void pv_queued_spin_unlock(struct qspinlock *lock)
 {
-	PVOP_VCALLEE1(pv_lock_ops.queued_spin_unlock, lock);
+	PVOP_VCALLEE1(lock.queued_spin_unlock, lock);
 }
 
 static __always_inline void pv_wait(u8 *ptr, u8 val)
 {
-	PVOP_VCALL2(pv_lock_ops.wait, ptr, val);
+	PVOP_VCALL2(lock.wait, ptr, val);
 }
 
 static __always_inline void pv_kick(int cpu)
 {
-	PVOP_VCALL1(pv_lock_ops.kick, cpu);
+	PVOP_VCALL1(lock.kick, cpu);
 }
 
 static __always_inline bool pv_vcpu_is_preempted(long cpu)
 {
-	return PVOP_CALLEE1(bool, pv_lock_ops.vcpu_is_preempted, cpu);
+	return PVOP_CALLEE1(bool, lock.vcpu_is_preempted, cpu);
 }
 
+void __raw_callee_save___native_queued_spin_unlock(struct qspinlock *lock);
+bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
+
 #endif /* SMP && PARAVIRT_SPINLOCKS */
 
 #ifdef CONFIG_X86_32
@@ -780,22 +761,22 @@ static __always_inline bool pv_vcpu_is_preempted(long cpu)
 
 static inline notrace unsigned long arch_local_save_flags(void)
 {
-	return PVOP_CALLEE0(unsigned long, pv_irq_ops.save_fl);
+	return PVOP_CALLEE0(unsigned long, irq.save_fl);
 }
 
 static inline notrace void arch_local_irq_restore(unsigned long f)
 {
-	PVOP_VCALLEE1(pv_irq_ops.restore_fl, f);
+	PVOP_VCALLEE1(irq.restore_fl, f);
 }
 
 static inline notrace void arch_local_irq_disable(void)
 {
-	PVOP_VCALLEE0(pv_irq_ops.irq_disable);
+	PVOP_VCALLEE0(irq.irq_disable);
 }
 
 static inline notrace void arch_local_irq_enable(void)
 {
-	PVOP_VCALLEE0(pv_irq_ops.irq_enable);
+	PVOP_VCALLEE0(irq.irq_enable);
 }
 
 static inline notrace unsigned long arch_local_irq_save(void)
@@ -867,7 +848,7 @@ extern void default_banner(void);
 	COND_POP(set, CLBR_RCX, rcx);		\
 	COND_POP(set, CLBR_RAX, rax)
 
-#define PARA_PATCH(struct, off)        ((PARAVIRT_PATCH_##struct + (off)) / 8)
+#define PARA_PATCH(off)		((off) / 8)
 #define PARA_SITE(ptype, ops)	_PVSITE(ptype, ops, .quad, 8)
 #define PARA_INDIRECT(addr)	*addr(%rip)
 #else
@@ -882,35 +863,35 @@ extern void default_banner(void);
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
 
@@ -920,7 +901,7 @@ extern void default_banner(void);
  * inlined, or the swapgs instruction must be trapped and emulated.
  */
 #define SWAPGS_UNSAFE_STACK						\
-	PARA_SITE(PARA_PATCH(pv_cpu_ops, PV_CPU_swapgs), swapgs)
+	PARA_SITE(PARA_PATCH(PV_CPU_swapgs), swapgs)
 
 /*
  * Note: swapgs is very special, and in practise is either going to be
@@ -929,26 +910,26 @@ extern void default_banner(void);
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
index b2220536a7d4..cee91a337620 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -321,28 +321,23 @@ struct pv_lock_ops {
  * number for each function using the offset which we use to indicate
  * what to patch. */
 struct paravirt_patch_template {
-	struct pv_init_ops pv_init_ops;
-	struct pv_time_ops pv_time_ops;
-	struct pv_cpu_ops pv_cpu_ops;
-	struct pv_irq_ops pv_irq_ops;
-	struct pv_mmu_ops pv_mmu_ops;
-	struct pv_lock_ops pv_lock_ops;
+	struct pv_init_ops	init;
+	struct pv_time_ops	time;
+	struct pv_cpu_ops	cpu;
+	struct pv_irq_ops	irq;
+	struct pv_mmu_ops	mmu;
+	struct pv_lock_ops	lock;
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
 
@@ -503,9 +498,9 @@ int paravirt_disable_iospace(void);
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
index 9e755e1cfe92..22e4da4ae8b9 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -594,7 +594,7 @@ void __init_or_module apply_paravirt(struct paravirt_patch_site *start,
 		BUG_ON(p->len > MAX_PATCH_LEN);
 		/* prep the buffer with the original instructions */
 		memcpy(insnbuf, p->instr, p->len);
-		used = pv_init_ops.patch(p->instrtype, insnbuf,
+		used = pv_ops.init.patch(p->instrtype, insnbuf,
 					 (unsigned long)p->instr, p->len);
 
 		BUG_ON(used > p->len);
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 01de31db300d..46d14498e214 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -66,13 +66,11 @@ void common(void) {
 
 #ifdef CONFIG_PARAVIRT
 	BLANK();
-	OFFSET(PARAVIRT_PATCH_pv_cpu_ops, paravirt_patch_template, pv_cpu_ops);
-	OFFSET(PARAVIRT_PATCH_pv_irq_ops, paravirt_patch_template, pv_irq_ops);
-	OFFSET(PV_IRQ_irq_disable, pv_irq_ops, irq_disable);
-	OFFSET(PV_IRQ_irq_enable, pv_irq_ops, irq_enable);
-	OFFSET(PV_CPU_iret, pv_cpu_ops, iret);
-	OFFSET(PV_CPU_read_cr0, pv_cpu_ops, read_cr0);
-	OFFSET(PV_MMU_read_cr2, pv_mmu_ops, read_cr2);
+	OFFSET(PV_IRQ_irq_disable, paravirt_patch_template, irq.irq_disable);
+	OFFSET(PV_IRQ_irq_enable, paravirt_patch_template, irq.irq_enable);
+	OFFSET(PV_CPU_iret, paravirt_patch_template, cpu.iret);
+	OFFSET(PV_CPU_read_cr0, paravirt_patch_template, cpu.read_cr0);
+	OFFSET(PV_MMU_read_cr2, paravirt_patch_template, mmu.read_cr2);
 #endif
 
 #ifdef CONFIG_XEN
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index 3b9405e7ba2b..3384b03e717f 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -21,10 +21,11 @@ static char syscalls_ia32[] = {
 int main(void)
 {
 #ifdef CONFIG_PARAVIRT
-	OFFSET(PV_CPU_usergs_sysret64, pv_cpu_ops, usergs_sysret64);
-	OFFSET(PV_CPU_swapgs, pv_cpu_ops, swapgs);
+	OFFSET(PV_CPU_usergs_sysret64, paravirt_patch_template,
+	       cpu.usergs_sysret64);
+	OFFSET(PV_CPU_swapgs, paravirt_patch_template, cpu.swapgs);
 #ifdef CONFIG_DEBUG_ENTRY
-	OFFSET(PV_IRQ_save_fl, pv_irq_ops, save_fl);
+	OFFSET(PV_IRQ_save_fl, paravirt_patch_template, irq.save_fl);
 #endif
 	BLANK();
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 44c4ef3d989b..c4da9c23a96c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1243,7 +1243,7 @@ static void generic_identify(struct cpuinfo_x86 *c)
 # ifdef CONFIG_PARAVIRT
 	do {
 		extern void native_iret(void);
-		if (pv_cpu_ops.iret == native_iret)
+		if (pv_ops.cpu.iret == native_iret)
 			set_cpu_bug(c, X86_BUG_ESPFIX);
 	} while (0);
 # else
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 8e005329648b..d9ab49bed8af 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -97,14 +97,14 @@ static void __init vmware_sched_clock_setup(void)
 	d->cyc2ns_offset = mul_u64_u32_shr(tsc_now, d->cyc2ns_mul,
 					   d->cyc2ns_shift);
 
-	pv_time_ops.sched_clock = vmware_sched_clock;
+	pv_ops.time.sched_clock = vmware_sched_clock;
 	pr_info("using sched offset of %llu ns\n", d->cyc2ns_offset);
 }
 
 static void __init vmware_paravirt_ops_setup(void)
 {
 	pv_info.name = "VMware hypervisor";
-	pv_cpu_ops.io_delay = paravirt_nop;
+	pv_ops.cpu.io_delay = paravirt_nop;
 
 	if (vmware_tsc_khz && vmw_sched_clock)
 		vmware_sched_clock_setup();
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index d9b71924c23c..ba4bfb7f6a36 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -283,7 +283,7 @@ static void __init paravirt_ops_setup(void)
 	pv_info.name = "KVM";
 
 	if (kvm_para_has_feature(KVM_FEATURE_NOP_IO_DELAY))
-		pv_cpu_ops.io_delay = kvm_io_delay;
+		pv_ops.cpu.io_delay = kvm_io_delay;
 
 #ifdef CONFIG_X86_IO_APIC
 	no_timer_check = 1;
@@ -632,14 +632,14 @@ static void __init kvm_guest_init(void)
 
 	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
 		has_steal_clock = 1;
-		pv_time_ops.steal_clock = kvm_steal_clock;
+		pv_ops.time.steal_clock = kvm_steal_clock;
 	}
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
 	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
 	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
-		pv_mmu_ops.flush_tlb_others = kvm_flush_tlb_others;
-		pv_mmu_ops.tlb_remove_table = tlb_remove_table;
+		pv_ops.mmu.flush_tlb_others = kvm_flush_tlb_others;
+		pv_ops.mmu.tlb_remove_table = tlb_remove_table;
 	}
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
@@ -850,13 +850,14 @@ void __init kvm_spinlock_init(void)
 		return;
 
 	__pv_init_lock_hash();
-	pv_lock_ops.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
-	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
-	pv_lock_ops.wait = kvm_wait;
-	pv_lock_ops.kick = kvm_kick_cpu;
+	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
+	pv_ops.lock.queued_spin_unlock =
+		PV_CALLEE_SAVE(__pv_queued_spin_unlock);
+	pv_ops.lock.wait = kvm_wait;
+	pv_ops.lock.kick = kvm_kick_cpu;
 
 	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
-		pv_lock_ops.vcpu_is_preempted =
+		pv_ops.lock.vcpu_is_preempted =
 			PV_CALLEE_SAVE(__kvm_vcpu_is_preempted);
 	}
 }
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 1e6764648af3..a36b93a722a2 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -116,13 +116,13 @@ static u64 kvm_sched_clock_read(void)
 static inline void kvm_sched_clock_init(bool stable)
 {
 	if (!stable) {
-		pv_time_ops.sched_clock = kvm_clock_read;
+		pv_ops.time.sched_clock = kvm_clock_read;
 		clear_sched_clock_stable();
 		return;
 	}
 
 	kvm_sched_clock_offset = kvm_clock_read();
-	pv_time_ops.sched_clock = kvm_sched_clock_read;
+	pv_ops.time.sched_clock = kvm_sched_clock_read;
 
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 71f2d1125ec0..4f75d0cf6305 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -17,7 +17,7 @@ PV_CALLEE_SAVE_REGS_THUNK(__native_queued_spin_unlock);
 
 bool pv_is_native_spin_unlock(void)
 {
-	return pv_lock_ops.queued_spin_unlock.func ==
+	return pv_ops.lock.queued_spin_unlock.func ==
 		__raw_callee_save___native_queued_spin_unlock;
 }
 
@@ -29,17 +29,6 @@ PV_CALLEE_SAVE_REGS_THUNK(__native_vcpu_is_preempted);
 
 bool pv_is_native_vcpu_is_preempted(void)
 {
-	return pv_lock_ops.vcpu_is_preempted.func ==
+	return pv_ops.lock.vcpu_is_preempted.func ==
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
index 287d34513f6a..0ca0576c88ff 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -128,29 +128,14 @@ void __init native_pv_lock_init(void)
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
@@ -165,8 +150,8 @@ unsigned paravirt_patch_default(u8 type, void *insnbuf,
 	else if (opfunc == _paravirt_ident_64)
 		ret = paravirt_patch_ident_64(insnbuf, len);
 
-	else if (type == PARAVIRT_PATCH(pv_cpu_ops.iret) ||
-		 type == PARAVIRT_PATCH(pv_cpu_ops.usergs_sysret64))
+	else if (type == PARAVIRT_PATCH(cpu.iret) ||
+		 type == PARAVIRT_PATCH(cpu.usergs_sysret64))
 		/* If operation requires a jmp, then jmp */
 		ret = paravirt_patch_jmp(insnbuf, opfunc, addr, len);
 	else
@@ -316,77 +301,6 @@ struct pv_info pv_info = {
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
@@ -395,85 +309,163 @@ NOKPROBE_SYMBOL(native_load_idt);
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
-	.tlb_remove_table = (void (*)(struct mmu_gather *, void *))tlb_remove_page,
-
-	.pgd_alloc = __paravirt_pgd_alloc,
-	.pgd_free = paravirt_nop,
+struct paravirt_patch_template pv_ops = {
+	/* Init ops. */
+	.init.patch		= native_patch,
+
+	/* Time ops. */
+	.time.sched_clock	= native_sched_clock,
+	.time.steal_clock	= native_steal_clock,
+
+	/* Cpu ops. */
+	.cpu.cpuid		= native_cpuid,
+	.cpu.get_debugreg	= native_get_debugreg,
+	.cpu.set_debugreg	= native_set_debugreg,
+	.cpu.read_cr0		= native_read_cr0,
+	.cpu.write_cr0		= native_write_cr0,
+	.cpu.write_cr4		= native_write_cr4,
+#ifdef CONFIG_X86_64
+	.cpu.read_cr8		= native_read_cr8,
+	.cpu.write_cr8		= native_write_cr8,
+#endif
+	.cpu.wbinvd		= native_wbinvd,
+	.cpu.read_msr		= native_read_msr,
+	.cpu.write_msr		= native_write_msr,
+	.cpu.read_msr_safe	= native_read_msr_safe,
+	.cpu.write_msr_safe	= native_write_msr_safe,
+	.cpu.read_pmc		= native_read_pmc,
+	.cpu.load_tr_desc	= native_load_tr_desc,
+	.cpu.set_ldt		= native_set_ldt,
+	.cpu.load_gdt		= native_load_gdt,
+	.cpu.load_idt		= native_load_idt,
+	.cpu.store_tr		= native_store_tr,
+	.cpu.load_tls		= native_load_tls,
+#ifdef CONFIG_X86_64
+	.cpu.load_gs_index	= native_load_gs_index,
+#endif
+	.cpu.write_ldt_entry	= native_write_ldt_entry,
+	.cpu.write_gdt_entry	= native_write_gdt_entry,
+	.cpu.write_idt_entry	= native_write_idt_entry,
 
-	.alloc_pte = paravirt_nop,
-	.alloc_pmd = paravirt_nop,
-	.alloc_pud = paravirt_nop,
-	.alloc_p4d = paravirt_nop,
-	.release_pte = paravirt_nop,
-	.release_pmd = paravirt_nop,
-	.release_pud = paravirt_nop,
-	.release_p4d = paravirt_nop,
+	.cpu.alloc_ldt		= paravirt_nop,
+	.cpu.free_ldt		= paravirt_nop,
 
-	.set_pte = native_set_pte,
-	.set_pte_at = native_set_pte_at,
-	.set_pmd = native_set_pmd,
+	.cpu.load_sp0		= native_load_sp0,
 
-	.ptep_modify_prot_start = __ptep_modify_prot_start,
-	.ptep_modify_prot_commit = __ptep_modify_prot_commit,
+#ifdef CONFIG_X86_64
+	.cpu.usergs_sysret64	= native_usergs_sysret64,
+#endif
+	.cpu.iret		= native_iret,
+	.cpu.swapgs		= native_swapgs,
+
+	.cpu.set_iopl_mask	= native_set_iopl_mask,
+	.cpu.io_delay		= native_io_delay,
+
+	.cpu.start_context_switch	= paravirt_nop,
+	.cpu.end_context_switch		= paravirt_nop,
+
+	/* Irq ops. */
+	.irq.save_fl		= __PV_IS_CALLEE_SAVE(native_save_fl),
+	.irq.restore_fl		= __PV_IS_CALLEE_SAVE(native_restore_fl),
+	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(native_irq_disable),
+	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(native_irq_enable),
+	.irq.safe_halt		= native_safe_halt,
+	.irq.halt		= native_halt,
+
+	/* Mmu ops. */
+	.mmu.read_cr2		= native_read_cr2,
+	.mmu.write_cr2		= native_write_cr2,
+	.mmu.read_cr3		= __native_read_cr3,
+	.mmu.write_cr3		= native_write_cr3,
+
+	.mmu.flush_tlb_user	= native_flush_tlb,
+	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
+	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
+	.mmu.flush_tlb_others	= native_flush_tlb_others,
+	.mmu.tlb_remove_table	=
+			(void (*)(struct mmu_gather *, void *))tlb_remove_page,
+
+	.mmu.pgd_alloc		= __paravirt_pgd_alloc,
+	.mmu.pgd_free		= paravirt_nop,
+
+	.mmu.alloc_pte		= paravirt_nop,
+	.mmu.alloc_pmd		= paravirt_nop,
+	.mmu.alloc_pud		= paravirt_nop,
+	.mmu.alloc_p4d		= paravirt_nop,
+	.mmu.release_pte	= paravirt_nop,
+	.mmu.release_pmd	= paravirt_nop,
+	.mmu.release_pud	= paravirt_nop,
+	.mmu.release_p4d	= paravirt_nop,
+
+	.mmu.set_pte		= native_set_pte,
+	.mmu.set_pte_at		= native_set_pte_at,
+	.mmu.set_pmd		= native_set_pmd,
+
+	.mmu.ptep_modify_prot_start	= __ptep_modify_prot_start,
+	.mmu.ptep_modify_prot_commit	= __ptep_modify_prot_commit,
 
 #if CONFIG_PGTABLE_LEVELS >= 3
 #ifdef CONFIG_X86_PAE
-	.set_pte_atomic = native_set_pte_atomic,
-	.pte_clear = native_pte_clear,
-	.pmd_clear = native_pmd_clear,
+	.mmu.set_pte_atomic	= native_set_pte_atomic,
+	.mmu.pte_clear		= native_pte_clear,
+	.mmu.pmd_clear		= native_pmd_clear,
 #endif
-	.set_pud = native_set_pud,
+	.mmu.set_pud		= native_set_pud,
 
-	.pmd_val = PTE_IDENT,
-	.make_pmd = PTE_IDENT,
+	.mmu.pmd_val		= PTE_IDENT,
+	.mmu.make_pmd		= PTE_IDENT,
 
 #if CONFIG_PGTABLE_LEVELS >= 4
-	.pud_val = PTE_IDENT,
-	.make_pud = PTE_IDENT,
+	.mmu.pud_val		= PTE_IDENT,
+	.mmu.make_pud		= PTE_IDENT,
 
-	.set_p4d = native_set_p4d,
+	.mmu.set_p4d		= native_set_p4d,
 
 #if CONFIG_PGTABLE_LEVELS >= 5
-	.p4d_val = PTE_IDENT,
-	.make_p4d = PTE_IDENT,
+	.mmu.p4d_val		= PTE_IDENT,
+	.mmu.make_p4d		= PTE_IDENT,
 
-	.set_pgd = native_set_pgd,
+	.mmu.set_pgd		= native_set_pgd,
 #endif /* CONFIG_PGTABLE_LEVELS >= 5 */
 #endif /* CONFIG_PGTABLE_LEVELS >= 4 */
 #endif /* CONFIG_PGTABLE_LEVELS >= 3 */
 
-	.pte_val = PTE_IDENT,
-	.pgd_val = PTE_IDENT,
+	.mmu.pte_val		= PTE_IDENT,
+	.mmu.pgd_val		= PTE_IDENT,
 
-	.make_pte = PTE_IDENT,
-	.make_pgd = PTE_IDENT,
+	.mmu.make_pte		= PTE_IDENT,
+	.mmu.make_pgd		= PTE_IDENT,
 
-	.dup_mmap = paravirt_nop,
-	.exit_mmap = paravirt_nop,
-	.activate_mm = paravirt_nop,
+	.mmu.dup_mmap		= paravirt_nop,
+	.mmu.exit_mmap		= paravirt_nop,
+	.mmu.activate_mm	= paravirt_nop,
 
-	.lazy_mode = {
-		.enter = paravirt_nop,
-		.leave = paravirt_nop,
-		.flush = paravirt_nop,
+	.mmu.lazy_mode = {
+		.enter		= paravirt_nop,
+		.leave		= paravirt_nop,
+		.flush		= paravirt_nop,
 	},
 
-	.set_fixmap = native_set_fixmap,
+	.mmu.set_fixmap		= native_set_fixmap,
+
+#if defined(CONFIG_PARAVIRT_SPINLOCKS)
+	/* Lock ops. */
+#ifdef CONFIG_SMP
+	.lock.queued_spin_lock_slowpath	= native_queued_spin_lock_slowpath,
+	.lock.queued_spin_unlock	=
+				PV_CALLEE_SAVE(__native_queued_spin_unlock),
+	.lock.wait			= paravirt_nop,
+	.lock.kick			= paravirt_nop,
+	.lock.vcpu_is_preempted		=
+				PV_CALLEE_SAVE(__native_vcpu_is_preempted),
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
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index e5c3a438149e..026fa43e9261 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -1,18 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/paravirt.h>
 
-DEF_NATIVE(pv_irq_ops, irq_disable, "cli");
-DEF_NATIVE(pv_irq_ops, irq_enable, "sti");
-DEF_NATIVE(pv_irq_ops, restore_fl, "push %eax; popf");
-DEF_NATIVE(pv_irq_ops, save_fl, "pushf; pop %eax");
-DEF_NATIVE(pv_cpu_ops, iret, "iret");
-DEF_NATIVE(pv_mmu_ops, read_cr2, "mov %cr2, %eax");
-DEF_NATIVE(pv_mmu_ops, write_cr3, "mov %eax, %cr3");
-DEF_NATIVE(pv_mmu_ops, read_cr3, "mov %cr3, %eax");
+DEF_NATIVE(irq, irq_disable, "cli");
+DEF_NATIVE(irq, irq_enable, "sti");
+DEF_NATIVE(irq, restore_fl, "push %eax; popf");
+DEF_NATIVE(irq, save_fl, "pushf; pop %eax");
+DEF_NATIVE(cpu, iret, "iret");
+DEF_NATIVE(mmu, read_cr2, "mov %cr2, %eax");
+DEF_NATIVE(mmu, write_cr3, "mov %eax, %cr3");
+DEF_NATIVE(mmu, read_cr3, "mov %cr3, %eax");
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
-DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%eax)");
-DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "xor %eax, %eax");
+DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%eax)");
+DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
 #endif
 
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
@@ -41,27 +41,27 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 			end = end_##ops##_##x;			\
 			goto patch_site
 	switch (type) {
-		PATCH_SITE(pv_irq_ops, irq_disable);
-		PATCH_SITE(pv_irq_ops, irq_enable);
-		PATCH_SITE(pv_irq_ops, restore_fl);
-		PATCH_SITE(pv_irq_ops, save_fl);
-		PATCH_SITE(pv_cpu_ops, iret);
-		PATCH_SITE(pv_mmu_ops, read_cr2);
-		PATCH_SITE(pv_mmu_ops, read_cr3);
-		PATCH_SITE(pv_mmu_ops, write_cr3);
+		PATCH_SITE(irq, irq_disable);
+		PATCH_SITE(irq, irq_enable);
+		PATCH_SITE(irq, restore_fl);
+		PATCH_SITE(irq, save_fl);
+		PATCH_SITE(cpu, iret);
+		PATCH_SITE(mmu, read_cr2);
+		PATCH_SITE(mmu, read_cr3);
+		PATCH_SITE(mmu, write_cr3);
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
-		case PARAVIRT_PATCH(pv_lock_ops.queued_spin_unlock):
+		case PARAVIRT_PATCH(lock.queued_spin_unlock):
 			if (pv_is_native_spin_unlock()) {
-				start = start_pv_lock_ops_queued_spin_unlock;
-				end   = end_pv_lock_ops_queued_spin_unlock;
+				start = start_lock_queued_spin_unlock;
+				end   = end_lock_queued_spin_unlock;
 				goto patch_site;
 			}
 			goto patch_default;
 
-		case PARAVIRT_PATCH(pv_lock_ops.vcpu_is_preempted):
+		case PARAVIRT_PATCH(lock.vcpu_is_preempted):
 			if (pv_is_native_vcpu_is_preempted()) {
-				start = start_pv_lock_ops_vcpu_is_preempted;
-				end   = end_pv_lock_ops_vcpu_is_preempted;
+				start = start_lock_vcpu_is_preempted;
+				end   = end_lock_vcpu_is_preempted;
 				goto patch_site;
 			}
 			goto patch_default;
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index 835f1985a115..582e893728e8 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -3,24 +3,24 @@
 #include <asm/asm-offsets.h>
 #include <linux/stringify.h>
 
-DEF_NATIVE(pv_irq_ops, irq_disable, "cli");
-DEF_NATIVE(pv_irq_ops, irq_enable, "sti");
-DEF_NATIVE(pv_irq_ops, restore_fl, "pushq %rdi; popfq");
-DEF_NATIVE(pv_irq_ops, save_fl, "pushfq; popq %rax");
-DEF_NATIVE(pv_mmu_ops, read_cr2, "movq %cr2, %rax");
-DEF_NATIVE(pv_mmu_ops, read_cr3, "movq %cr3, %rax");
-DEF_NATIVE(pv_mmu_ops, write_cr3, "movq %rdi, %cr3");
-DEF_NATIVE(pv_cpu_ops, wbinvd, "wbinvd");
+DEF_NATIVE(irq, irq_disable, "cli");
+DEF_NATIVE(irq, irq_enable, "sti");
+DEF_NATIVE(irq, restore_fl, "pushq %rdi; popfq");
+DEF_NATIVE(irq, save_fl, "pushfq; popq %rax");
+DEF_NATIVE(mmu, read_cr2, "movq %cr2, %rax");
+DEF_NATIVE(mmu, read_cr3, "movq %cr3, %rax");
+DEF_NATIVE(mmu, write_cr3, "movq %rdi, %cr3");
+DEF_NATIVE(cpu, wbinvd, "wbinvd");
 
-DEF_NATIVE(pv_cpu_ops, usergs_sysret64, "swapgs; sysretq");
-DEF_NATIVE(pv_cpu_ops, swapgs, "swapgs");
+DEF_NATIVE(cpu, usergs_sysret64, "swapgs; sysretq");
+DEF_NATIVE(cpu, swapgs, "swapgs");
 
 DEF_NATIVE(, mov32, "mov %edi, %eax");
 DEF_NATIVE(, mov64, "mov %rdi, %rax");
 
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
-DEF_NATIVE(pv_lock_ops, queued_spin_unlock, "movb $0, (%rdi)");
-DEF_NATIVE(pv_lock_ops, vcpu_is_preempted, "xor %eax, %eax");
+DEF_NATIVE(lock, queued_spin_unlock, "movb $0, (%rdi)");
+DEF_NATIVE(lock, vcpu_is_preempted, "xor %eax, %eax");
 #endif
 
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
@@ -49,29 +49,29 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len)
 			end = end_##ops##_##x;			\
 			goto patch_site
 	switch(type) {
-		PATCH_SITE(pv_irq_ops, restore_fl);
-		PATCH_SITE(pv_irq_ops, save_fl);
-		PATCH_SITE(pv_irq_ops, irq_enable);
-		PATCH_SITE(pv_irq_ops, irq_disable);
-		PATCH_SITE(pv_cpu_ops, usergs_sysret64);
-		PATCH_SITE(pv_cpu_ops, swapgs);
-		PATCH_SITE(pv_mmu_ops, read_cr2);
-		PATCH_SITE(pv_mmu_ops, read_cr3);
-		PATCH_SITE(pv_mmu_ops, write_cr3);
-		PATCH_SITE(pv_cpu_ops, wbinvd);
+		PATCH_SITE(irq, restore_fl);
+		PATCH_SITE(irq, save_fl);
+		PATCH_SITE(irq, irq_enable);
+		PATCH_SITE(irq, irq_disable);
+		PATCH_SITE(cpu, usergs_sysret64);
+		PATCH_SITE(cpu, swapgs);
+		PATCH_SITE(mmu, read_cr2);
+		PATCH_SITE(mmu, read_cr3);
+		PATCH_SITE(mmu, write_cr3);
+		PATCH_SITE(cpu, wbinvd);
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
-		case PARAVIRT_PATCH(pv_lock_ops.queued_spin_unlock):
+		case PARAVIRT_PATCH(lock.queued_spin_unlock):
 			if (pv_is_native_spin_unlock()) {
-				start = start_pv_lock_ops_queued_spin_unlock;
-				end   = end_pv_lock_ops_queued_spin_unlock;
+				start = start_lock_queued_spin_unlock;
+				end   = end_lock_queued_spin_unlock;
 				goto patch_site;
 			}
 			goto patch_default;
 
-		case PARAVIRT_PATCH(pv_lock_ops.vcpu_is_preempted):
+		case PARAVIRT_PATCH(lock.vcpu_is_preempted):
 			if (pv_is_native_vcpu_is_preempted()) {
-				start = start_pv_lock_ops_vcpu_is_preempted;
-				end   = end_pv_lock_ops_vcpu_is_preempted;
+				start = start_lock_vcpu_is_preempted;
+				end   = end_lock_vcpu_is_preempted;
 				goto patch_site;
 			}
 			goto patch_default;
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 1463468ba9a0..9044aa5e2389 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -246,7 +246,7 @@ unsigned long long sched_clock(void)
 
 bool using_native_sched_clock(void)
 {
-	return pv_time_ops.sched_clock == native_sched_clock;
+	return pv_ops.time.sched_clock == native_sched_clock;
 }
 #else
 unsigned long long
diff --git a/arch/x86/kernel/vsmp_64.c b/arch/x86/kernel/vsmp_64.c
index f194e5e1e95c..789918d78697 100644
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -73,10 +73,10 @@ static unsigned __init vsmp_patch(u8 type, void *ibuf,
 				  unsigned long addr, unsigned len)
 {
 	switch (type) {
-	case PARAVIRT_PATCH(pv_irq_ops.irq_enable):
-	case PARAVIRT_PATCH(pv_irq_ops.irq_disable):
-	case PARAVIRT_PATCH(pv_irq_ops.save_fl):
-	case PARAVIRT_PATCH(pv_irq_ops.restore_fl):
+	case PARAVIRT_PATCH(irq.irq_enable):
+	case PARAVIRT_PATCH(irq.irq_disable):
+	case PARAVIRT_PATCH(irq.save_fl):
+	case PARAVIRT_PATCH(irq.restore_fl):
 		return paravirt_patch_default(type, ibuf, addr, len);
 	default:
 		return native_patch(type, ibuf, addr, len);
@@ -111,11 +111,11 @@ static void __init set_vsmp_pv_ops(void)
 
 	if (cap & ctl & (1 << 4)) {
 		/* Setup irq ops and turn on vSMP  IRQ fastpath handling */
-		pv_irq_ops.irq_disable = PV_CALLEE_SAVE(vsmp_irq_disable);
-		pv_irq_ops.irq_enable  = PV_CALLEE_SAVE(vsmp_irq_enable);
-		pv_irq_ops.save_fl  = PV_CALLEE_SAVE(vsmp_save_fl);
-		pv_irq_ops.restore_fl  = PV_CALLEE_SAVE(vsmp_restore_fl);
-		pv_init_ops.patch = vsmp_patch;
+		pv_ops.irq.irq_disable = PV_CALLEE_SAVE(vsmp_irq_disable);
+		pv_ops.irq.irq_enable = PV_CALLEE_SAVE(vsmp_irq_enable);
+		pv_ops.irq.save_fl = PV_CALLEE_SAVE(vsmp_save_fl);
+		pv_ops.irq.restore_fl = PV_CALLEE_SAVE(vsmp_restore_fl);
+		pv_ops.init.patch = vsmp_patch;
 		ctl &= ~(1 << 4);
 	}
 	writel(ctl, address + 4);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 52a7c3faee0c..ec7a4209f310 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -995,11 +995,14 @@ void __init xen_setup_vcpu_info_placement(void)
 	 * percpu area for all cpus, so make use of it.
 	 */
 	if (xen_have_vcpu_info_placement) {
-		pv_irq_ops.save_fl = __PV_IS_CALLEE_SAVE(xen_save_fl_direct);
-		pv_irq_ops.restore_fl = __PV_IS_CALLEE_SAVE(xen_restore_fl_direct);
-		pv_irq_ops.irq_disable = __PV_IS_CALLEE_SAVE(xen_irq_disable_direct);
-		pv_irq_ops.irq_enable = __PV_IS_CALLEE_SAVE(xen_irq_enable_direct);
-		pv_mmu_ops.read_cr2 = xen_read_cr2_direct;
+		pv_ops.irq.save_fl = __PV_IS_CALLEE_SAVE(xen_save_fl_direct);
+		pv_ops.irq.restore_fl =
+			__PV_IS_CALLEE_SAVE(xen_restore_fl_direct);
+		pv_ops.irq.irq_disable =
+			__PV_IS_CALLEE_SAVE(xen_irq_disable_direct);
+		pv_ops.irq.irq_enable =
+			__PV_IS_CALLEE_SAVE(xen_irq_enable_direct);
+		pv_ops.mmu.read_cr2 = xen_read_cr2_direct;
 	}
 }
 
@@ -1174,14 +1177,14 @@ static void __init xen_boot_params_init_edd(void)
  */
 static void __init xen_setup_gdt(int cpu)
 {
-	pv_cpu_ops.write_gdt_entry = xen_write_gdt_entry_boot;
-	pv_cpu_ops.load_gdt = xen_load_gdt_boot;
+	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry_boot;
+	pv_ops.cpu.load_gdt = xen_load_gdt_boot;
 
 	setup_stack_canary_segment(cpu);
 	switch_to_new_gdt(cpu);
 
-	pv_cpu_ops.write_gdt_entry = xen_write_gdt_entry;
-	pv_cpu_ops.load_gdt = xen_load_gdt;
+	pv_ops.cpu.write_gdt_entry = xen_write_gdt_entry;
+	pv_ops.cpu.load_gdt = xen_load_gdt;
 }
 
 static void __init xen_dom0_set_legacy_features(void)
@@ -1206,8 +1209,8 @@ asmlinkage __visible void __init xen_start_kernel(void)
 
 	/* Install Xen paravirt ops */
 	pv_info = xen_info;
-	pv_init_ops.patch = paravirt_patch_default;
-	pv_cpu_ops = xen_cpu_ops;
+	pv_ops.init.patch = paravirt_patch_default;
+	pv_ops.cpu = xen_cpu_ops;
 	xen_init_irq_ops();
 
 	/*
@@ -1276,8 +1279,10 @@ asmlinkage __visible void __init xen_start_kernel(void)
 #endif
 
 	if (xen_feature(XENFEAT_mmu_pt_update_preserve_ad)) {
-		pv_mmu_ops.ptep_modify_prot_start = xen_ptep_modify_prot_start;
-		pv_mmu_ops.ptep_modify_prot_commit = xen_ptep_modify_prot_commit;
+		pv_ops.mmu.ptep_modify_prot_start =
+			xen_ptep_modify_prot_start;
+		pv_ops.mmu.ptep_modify_prot_commit =
+			xen_ptep_modify_prot_commit;
 	}
 
 	machine_ops = xen_machine_ops;
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index 7515a19fd324..850c93f346c7 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -128,6 +128,6 @@ static const struct pv_irq_ops xen_irq_ops __initconst = {
 
 void __init xen_init_irq_ops(void)
 {
-	pv_irq_ops = xen_irq_ops;
+	pv_ops.irq = xen_irq_ops;
 	x86_init.irqs.intr_init = xen_init_IRQ;
 }
diff --git a/arch/x86/xen/mmu_hvm.c b/arch/x86/xen/mmu_hvm.c
index dd2ad82eee80..57409373750f 100644
--- a/arch/x86/xen/mmu_hvm.c
+++ b/arch/x86/xen/mmu_hvm.c
@@ -73,7 +73,7 @@ static int is_pagetable_dying_supported(void)
 void __init xen_hvm_init_mmu_ops(void)
 {
 	if (is_pagetable_dying_supported())
-		pv_mmu_ops.exit_mmap = xen_hvm_exit_mmap;
+		pv_ops.mmu.exit_mmap = xen_hvm_exit_mmap;
 #ifdef CONFIG_PROC_VMCORE
 	WARN_ON(register_oldmem_pfn_is_ram(&xen_oldmem_pfn_is_ram));
 #endif
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index b565c5038be1..bf30fa03582e 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2213,7 +2213,7 @@ static void __init xen_write_cr3_init(unsigned long cr3)
 	set_page_prot(initial_page_table, PAGE_KERNEL);
 	set_page_prot(initial_kernel_pmd, PAGE_KERNEL);
 
-	pv_mmu_ops.write_cr3 = &xen_write_cr3;
+	pv_ops.mmu.write_cr3 = &xen_write_cr3;
 }
 
 /*
@@ -2362,27 +2362,27 @@ static void xen_set_fixmap(unsigned idx, phys_addr_t phys, pgprot_t prot)
 
 static void __init xen_post_allocator_init(void)
 {
-	pv_mmu_ops.set_pte = xen_set_pte;
-	pv_mmu_ops.set_pmd = xen_set_pmd;
-	pv_mmu_ops.set_pud = xen_set_pud;
+	pv_ops.mmu.set_pte = xen_set_pte;
+	pv_ops.mmu.set_pmd = xen_set_pmd;
+	pv_ops.mmu.set_pud = xen_set_pud;
 #ifdef CONFIG_X86_64
-	pv_mmu_ops.set_p4d = xen_set_p4d;
+	pv_ops.mmu.set_p4d = xen_set_p4d;
 #endif
 
 	/* This will work as long as patching hasn't happened yet
 	   (which it hasn't) */
-	pv_mmu_ops.alloc_pte = xen_alloc_pte;
-	pv_mmu_ops.alloc_pmd = xen_alloc_pmd;
-	pv_mmu_ops.release_pte = xen_release_pte;
-	pv_mmu_ops.release_pmd = xen_release_pmd;
+	pv_ops.mmu.alloc_pte = xen_alloc_pte;
+	pv_ops.mmu.alloc_pmd = xen_alloc_pmd;
+	pv_ops.mmu.release_pte = xen_release_pte;
+	pv_ops.mmu.release_pmd = xen_release_pmd;
 #ifdef CONFIG_X86_64
-	pv_mmu_ops.alloc_pud = xen_alloc_pud;
-	pv_mmu_ops.release_pud = xen_release_pud;
+	pv_ops.mmu.alloc_pud = xen_alloc_pud;
+	pv_ops.mmu.release_pud = xen_release_pud;
 #endif
-	pv_mmu_ops.make_pte = PV_CALLEE_SAVE(xen_make_pte);
+	pv_ops.mmu.make_pte = PV_CALLEE_SAVE(xen_make_pte);
 
 #ifdef CONFIG_X86_64
-	pv_mmu_ops.write_cr3 = &xen_write_cr3;
+	pv_ops.mmu.write_cr3 = &xen_write_cr3;
 #endif
 }
 
@@ -2470,7 +2470,7 @@ void __init xen_init_mmu_ops(void)
 	x86_init.paging.pagetable_init = xen_pagetable_init;
 	x86_init.hyper.init_after_bootmem = xen_after_bootmem;
 
-	pv_mmu_ops = xen_mmu_ops;
+	pv_ops.mmu = xen_mmu_ops;
 
 	memset(dummy_mapping, 0xff, PAGE_SIZE);
 }
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 973f10e05211..23f6793af88a 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -141,11 +141,12 @@ void __init xen_init_spinlocks(void)
 	printk(KERN_DEBUG "xen: PV spinlocks enabled\n");
 
 	__pv_init_lock_hash();
-	pv_lock_ops.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
-	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
-	pv_lock_ops.wait = xen_qlock_wait;
-	pv_lock_ops.kick = xen_qlock_kick;
-	pv_lock_ops.vcpu_is_preempted = PV_CALLEE_SAVE(xen_vcpu_stolen);
+	pv_ops.lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
+	pv_ops.lock.queued_spin_unlock =
+		PV_CALLEE_SAVE(__pv_queued_spin_unlock);
+	pv_ops.lock.wait = xen_qlock_wait;
+	pv_ops.lock.kick = xen_qlock_kick;
+	pv_ops.lock.vcpu_is_preempted = PV_CALLEE_SAVE(xen_vcpu_stolen);
 }
 
 static __init int xen_parse_nopvspin(char *arg)
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index c84f1e039d84..72bf446c3fee 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -513,7 +513,7 @@ static void __init xen_time_init(void)
 void __init xen_init_time_ops(void)
 {
 	xen_sched_clock_offset = xen_clocksource_read();
-	pv_time_ops = xen_time_ops;
+	pv_ops.time = xen_time_ops;
 
 	x86_init.timers.timer_init = xen_time_init;
 	x86_init.timers.setup_percpu_clockev = x86_init_noop;
@@ -555,7 +555,7 @@ void __init xen_hvm_init_time_ops(void)
 	}
 
 	xen_sched_clock_offset = xen_clocksource_read();
-	pv_time_ops = xen_time_ops;
+	pv_ops.time = xen_time_ops;
 	x86_init.timers.setup_percpu_clockev = xen_time_init;
 	x86_cpuinit.setup_percpu_clockev = xen_hvm_setup_cpu_clockevents;
 
diff --git a/drivers/xen/time.c b/drivers/xen/time.c
index 3e741cd1409c..0968859c29d0 100644
--- a/drivers/xen/time.c
+++ b/drivers/xen/time.c
@@ -175,7 +175,7 @@ void __init xen_time_setup_guest(void)
 	xen_runstate_remote = !HYPERVISOR_vm_assist(VMASST_CMD_enable,
 					VMASST_TYPE_runstate_update_flag);
 
-	pv_time_ops.steal_clock = xen_steal_clock;
+	pv_ops.time.steal_clock = xen_steal_clock;
 
 	static_key_slow_inc(&paravirt_steal_enabled);
 	if (xen_runstate_remote)
