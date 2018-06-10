Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id stukHBHCHFtQdwAAmS7hNA
	; Sun, 10 Jun 2018 06:16:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 408BF60795; Sun, 10 Jun 2018 06:16:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 78B936074D;
	Sun, 10 Jun 2018 06:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 78B936074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753788AbeFJGQS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 02:16:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35759 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753755AbeFJGQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 02:16:16 -0400
Received: from [217.76.163.81] (helo=nanos.fritz.box)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fRteA-0007lL-8w; Sun, 10 Jun 2018 08:16:14 +0200
Date: Sun, 10 Jun 2018 08:16:13 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86 updates for 4.18
Message-ID: <alpine.DEB.2.21.1806100759411.1606@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

A pile of x86 updates and fixes:

 - Fix the (late) fallout from the vector management rework causing hlist
   corruption and irq descriptor reference leaks caused by a missing sanity
   check.

   The straight forward fix triggered another long standing issue to
   surface. The pre rework code hid the issue due to being way slower, but
   now the chance that user space sees an EBUSY error return when updating
   irq affinities is way higher, though quite a bunch of userspace tools do
   not handle it properly despite the fact that EBUSY could be returned for
   at least 10 years. It turned out that the EBUSY return can be avoided
   completely by utilizing the existing delayed affinity update mechanism
   for irq remapped scenarios as well. That's a bit more error handling in
   the kernel, but avoids fruitless fingerpointing discussions with tool
   developers.

 - Decouple PHYSICAL_MASK from AMD SME as its going to be required for the
   upcoming Intel memory encryption support as well.

 - Handle legacy device ACPI detection properly for newer platforms

 - Fix the wrong argument ordering in the vector allocation tracepoint

 - Simplify the IDT setup code for the APIC=n case

 - Use the proper string helpers in the MTRR code

 - Remove a stale unused VDSO source file

 - Convert the microcode update lock to a raw spinlock as its used in
   atomic context.

Thanks,

	tglx

------------------>
Andy Shevchenko (2):
      x86/mtrr: Convert to use match_string() helper
      x86/mtrr: Convert to use strncpy_from_user() helper

Arnd Bergmann (1):
      x86: Mark native_set_p4d() as __always_inline

Dou Liyang (2):
      x86/idt: Simplify the idt_setup_apic_and_irq_gates()
      x86/vector: Fix the args of vector_alloc tracepoint

Jann Horn (1):
      x86/vdso: Remove unused file

Kirill A. Shutemov (1):
      x86/mm: Decouple dynamic __PHYSICAL_MASK from AMD SME

Rajneesh Bhardwaj (1):
      x86/i8237: Register device based on FADT legacy boot flag

Scott Wood (1):
      x86/microcode: Make the late update update_lock a raw lock for RT

Thomas Gleixner (9):
      x86/apic/vector: Prevent hlist corruption and leaks
      genirq/generic_pending: Do not lose pending affinity update
      genirq/migration: Avoid out of line call if pending is not set
      x86/apic: Provide apic_ack_irq()
      irq_remapping: Use apic_ack_irq()
      x86/ioapic: Use apic_ack_irq()
      x86/platform/uv: Use apic_ack_irq()
      genirq/affinity: Defer affinity setting if irq chip is busy
      x86/apic/vector: Print APIC control bits in debugfs

Tony Luck (1):
      x86/intel_rdt: Enable CMT and MBM on new Skylake stepping

Varsha Rao (1):
      x86/platform/uv: Remove extra parentheses


 arch/x86/Kconfig                         |  4 +++
 arch/x86/boot/compressed/kaslr_64.c      |  5 ++++
 arch/x86/include/asm/apic.h              |  2 ++
 arch/x86/include/asm/page_types.h        |  8 +++++-
 arch/x86/include/asm/pgtable_64.h        |  4 +--
 arch/x86/include/asm/trace/irq_vectors.h |  2 +-
 arch/x86/include/asm/x86_init.h          |  1 +
 arch/x86/kernel/apic/io_apic.c           |  2 +-
 arch/x86/kernel/apic/vector.c            | 45 +++++++++++++++++++++-----------
 arch/x86/kernel/cpu/intel_rdt.c          |  2 ++
 arch/x86/kernel/cpu/microcode/core.c     |  6 ++---
 arch/x86/kernel/cpu/mtrr/if.c            | 33 +++++++++--------------
 arch/x86/kernel/i8237.c                  | 25 ++++++++++++++++++
 arch/x86/kernel/idt.c                    |  7 ++---
 arch/x86/kernel/platform-quirks.c        |  7 ++++-
 arch/x86/mm/mem_encrypt_identity.c       |  3 +++
 arch/x86/mm/pgtable.c                    |  5 ++++
 arch/x86/platform/uv/tlb_uv.c            |  2 +-
 arch/x86/platform/uv/uv_irq.c            |  7 +----
 drivers/iommu/amd_iommu.c                |  2 +-
 drivers/iommu/intel_irq_remapping.c      |  2 +-
 drivers/iommu/irq_remapping.c            |  5 ----
 drivers/iommu/irq_remapping.h            |  2 --
 include/linux/irq.h                      |  7 ++++-
 kernel/irq/manage.c                      | 37 ++++++++++++++++++++++++--
 kernel/irq/migration.c                   | 31 ++++++++++++++--------
 26 files changed, 176 insertions(+), 80 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c07f492b871a..43a8fc476296 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -337,6 +337,9 @@ config ARCH_SUPPORTS_UPROBES
 config FIX_EARLYCON_MEM
 	def_bool y
 
+config DYNAMIC_PHYSICAL_MASK
+	bool
+
 config PGTABLE_LEVELS
 	int
 	default 5 if X86_5LEVEL
@@ -1508,6 +1511,7 @@ config ARCH_HAS_MEM_ENCRYPT
 config AMD_MEM_ENCRYPT
 	bool "AMD Secure Memory Encryption (SME) support"
 	depends on X86_64 && CPU_SUP_AMD
+	select DYNAMIC_PHYSICAL_MASK
 	---help---
 	  Say yes to enable support for the encryption of system memory.
 	  This requires an AMD processor that supports Secure Memory
diff --git a/arch/x86/boot/compressed/kaslr_64.c b/arch/x86/boot/compressed/kaslr_64.c
index 522d11431433..748456c365f4 100644
--- a/arch/x86/boot/compressed/kaslr_64.c
+++ b/arch/x86/boot/compressed/kaslr_64.c
@@ -69,6 +69,8 @@ static struct alloc_pgt_data pgt_data;
 /* The top level page table entry pointer. */
 static unsigned long top_level_pgt;
 
+phys_addr_t physical_mask = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
+
 /*
  * Mapping information structure passed to kernel_ident_mapping_init().
  * Due to relocation, pointers must be assigned at run time not build time.
@@ -81,6 +83,9 @@ void initialize_identity_maps(void)
 	/* If running as an SEV guest, the encryption mask is required. */
 	set_sev_encryption_mask();
 
+	/* Exclude the encryption mask from __PHYSICAL_MASK */
+	physical_mask &= ~sme_me_mask;
+
 	/* Init mapping_info with run-time function/buffer pointers. */
 	mapping_info.alloc_pgt_page = alloc_pgt_page;
 	mapping_info.context = &pgt_data;
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 08acd954f00e..74a9e06b6cfd 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -436,6 +436,8 @@ static inline void apic_set_eoi_write(void (*eoi_write)(u32 reg, u32 v)) {}
 
 #endif /* CONFIG_X86_LOCAL_APIC */
 
+extern void apic_ack_irq(struct irq_data *data);
+
 static inline void ack_APIC_irq(void)
 {
 	/*
diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
index 1e53560a84bb..c85e15010f48 100644
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -17,7 +17,6 @@
 #define PUD_PAGE_SIZE		(_AC(1, UL) << PUD_SHIFT)
 #define PUD_PAGE_MASK		(~(PUD_PAGE_SIZE-1))
 
-#define __PHYSICAL_MASK		((phys_addr_t)(__sme_clr((1ULL << __PHYSICAL_MASK_SHIFT) - 1)))
 #define __VIRTUAL_MASK		((1UL << __VIRTUAL_MASK_SHIFT) - 1)
 
 /* Cast *PAGE_MASK to a signed type so that it is sign-extended if
@@ -55,6 +54,13 @@
 
 #ifndef __ASSEMBLY__
 
+#ifdef CONFIG_DYNAMIC_PHYSICAL_MASK
+extern phys_addr_t physical_mask;
+#define __PHYSICAL_MASK		physical_mask
+#else
+#define __PHYSICAL_MASK		((phys_addr_t)((1ULL << __PHYSICAL_MASK_SHIFT) - 1))
+#endif
+
 extern int devmem_is_allowed(unsigned long pagenr);
 
 extern unsigned long max_low_pfn_mapped;
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 877bc27718ae..c750112cb416 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -216,7 +216,7 @@ static inline pgd_t pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
 }
 #endif
 
-static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
+static __always_inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	pgd_t pgd;
 
@@ -230,7 +230,7 @@ static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 	*p4dp = native_make_p4d(native_pgd_val(pgd));
 }
 
-static inline void native_p4d_clear(p4d_t *p4d)
+static __always_inline void native_p4d_clear(p4d_t *p4d)
 {
 	native_set_p4d(p4d, native_make_p4d(0));
 }
diff --git a/arch/x86/include/asm/trace/irq_vectors.h b/arch/x86/include/asm/trace/irq_vectors.h
index 22647a642e98..0af81b590a0c 100644
--- a/arch/x86/include/asm/trace/irq_vectors.h
+++ b/arch/x86/include/asm/trace/irq_vectors.h
@@ -236,7 +236,7 @@ TRACE_EVENT(vector_alloc,
 	TP_PROTO(unsigned int irq, unsigned int vector, bool reserved,
 		 int ret),
 
-	TP_ARGS(irq, vector, ret, reserved),
+	TP_ARGS(irq, vector, reserved, ret),
 
 	TP_STRUCT__entry(
 		__field(	unsigned int,	irq		)
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index ce8b4da07e35..db98e3ab3295 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -301,5 +301,6 @@ extern struct x86_apic_ops x86_apic_ops;
 extern void x86_early_init_platform_quirks(void);
 extern void x86_init_noop(void);
 extern void x86_init_uint_noop(unsigned int unused);
+extern bool x86_pnpbios_disabled(void);
 
 #endif
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 7553819c74c3..3982f79d2377 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -1851,7 +1851,7 @@ static void ioapic_ir_ack_level(struct irq_data *irq_data)
 	 * intr-remapping table entry. Hence for the io-apic
 	 * EOI we use the pin number.
 	 */
-	ack_APIC_irq();
+	apic_ack_irq(irq_data);
 	eoi_ioapic_pin(data->entry.vector, data);
 }
 
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index bb6f7a2148d7..35aaee4fc028 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -235,6 +235,15 @@ static int allocate_vector(struct irq_data *irqd, const struct cpumask *dest)
 	if (vector && cpu_online(cpu) && cpumask_test_cpu(cpu, dest))
 		return 0;
 
+	/*
+	 * Careful here. @apicd might either have move_in_progress set or
+	 * be enqueued for cleanup. Assigning a new vector would either
+	 * leave a stale vector on some CPU around or in case of a pending
+	 * cleanup corrupt the hlist.
+	 */
+	if (apicd->move_in_progress || !hlist_unhashed(&apicd->clist))
+		return -EBUSY;
+
 	vector = irq_matrix_alloc(vector_matrix, dest, resvd, &cpu);
 	if (vector > 0)
 		apic_update_vector(irqd, vector, cpu);
@@ -579,8 +588,7 @@ static int x86_vector_alloc_irqs(struct irq_domain *domain, unsigned int virq,
 static void x86_vector_debug_show(struct seq_file *m, struct irq_domain *d,
 				  struct irq_data *irqd, int ind)
 {
-	unsigned int cpu, vector, prev_cpu, prev_vector;
-	struct apic_chip_data *apicd;
+	struct apic_chip_data apicd;
 	unsigned long flags;
 	int irq;
 
@@ -596,24 +604,26 @@ static void x86_vector_debug_show(struct seq_file *m, struct irq_domain *d,
 		return;
 	}
 
-	apicd = irqd->chip_data;
-	if (!apicd) {
+	if (!irqd->chip_data) {
 		seq_printf(m, "%*sVector: Not assigned\n", ind, "");
 		return;
 	}
 
 	raw_spin_lock_irqsave(&vector_lock, flags);
-	cpu = apicd->cpu;
-	vector = apicd->vector;
-	prev_cpu = apicd->prev_cpu;
-	prev_vector = apicd->prev_vector;
+	memcpy(&apicd, irqd->chip_data, sizeof(apicd));
 	raw_spin_unlock_irqrestore(&vector_lock, flags);
-	seq_printf(m, "%*sVector: %5u\n", ind, "", vector);
-	seq_printf(m, "%*sTarget: %5u\n", ind, "", cpu);
-	if (prev_vector) {
-		seq_printf(m, "%*sPrevious vector: %5u\n", ind, "", prev_vector);
-		seq_printf(m, "%*sPrevious target: %5u\n", ind, "", prev_cpu);
+
+	seq_printf(m, "%*sVector: %5u\n", ind, "", apicd.vector);
+	seq_printf(m, "%*sTarget: %5u\n", ind, "", apicd.cpu);
+	if (apicd.prev_vector) {
+		seq_printf(m, "%*sPrevious vector: %5u\n", ind, "", apicd.prev_vector);
+		seq_printf(m, "%*sPrevious target: %5u\n", ind, "", apicd.prev_cpu);
 	}
+	seq_printf(m, "%*smove_in_progress: %u\n", ind, "", apicd.move_in_progress ? 1 : 0);
+	seq_printf(m, "%*sis_managed:       %u\n", ind, "", apicd.is_managed ? 1 : 0);
+	seq_printf(m, "%*scan_reserve:      %u\n", ind, "", apicd.can_reserve ? 1 : 0);
+	seq_printf(m, "%*shas_reserved:     %u\n", ind, "", apicd.has_reserved ? 1 : 0);
+	seq_printf(m, "%*scleanup_pending:  %u\n", ind, "", !hlist_unhashed(&apicd.clist));
 }
 #endif
 
@@ -800,13 +810,18 @@ static int apic_retrigger_irq(struct irq_data *irqd)
 	return 1;
 }
 
-void apic_ack_edge(struct irq_data *irqd)
+void apic_ack_irq(struct irq_data *irqd)
 {
-	irq_complete_move(irqd_cfg(irqd));
 	irq_move_irq(irqd);
 	ack_APIC_irq();
 }
 
+void apic_ack_edge(struct irq_data *irqd)
+{
+	irq_complete_move(irqd_cfg(irqd));
+	apic_ack_irq(irqd);
+}
+
 static struct irq_chip lapic_controller = {
 	.name			= "APIC",
 	.irq_ack		= apic_ack_edge,
diff --git a/arch/x86/kernel/cpu/intel_rdt.c b/arch/x86/kernel/cpu/intel_rdt.c
index 589b948e6e01..316a8875bd90 100644
--- a/arch/x86/kernel/cpu/intel_rdt.c
+++ b/arch/x86/kernel/cpu/intel_rdt.c
@@ -821,6 +821,8 @@ static __init void rdt_quirks(void)
 	case INTEL_FAM6_SKYLAKE_X:
 		if (boot_cpu_data.x86_stepping <= 4)
 			set_rdt_options("!cmt,!mbmtotal,!mbmlocal,!l3cat");
+		else
+			set_rdt_options("!l3cat");
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 77e201301528..08286269fd24 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -70,7 +70,7 @@ static DEFINE_MUTEX(microcode_mutex);
 /*
  * Serialize late loading so that CPUs get updated one-by-one.
  */
-static DEFINE_SPINLOCK(update_lock);
+static DEFINE_RAW_SPINLOCK(update_lock);
 
 struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
 
@@ -560,9 +560,9 @@ static int __reload_late(void *info)
 	if (__wait_for_cpus(&late_cpus_in, NSEC_PER_SEC))
 		return -1;
 
-	spin_lock(&update_lock);
+	raw_spin_lock(&update_lock);
 	apply_microcode_local(&err);
-	spin_unlock(&update_lock);
+	raw_spin_unlock(&update_lock);
 
 	/* siblings return UCODE_OK because their engine got updated already */
 	if (err > UCODE_NFOUND) {
diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 558444b23923..c610f47373e4 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -106,17 +106,9 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 
 	memset(line, 0, LINE_SIZE);
 
-	length = len;
-	length--;
-
-	if (length > LINE_SIZE - 1)
-		length = LINE_SIZE - 1;
-
+	length = strncpy_from_user(line, buf, LINE_SIZE - 1);
 	if (length < 0)
-		return -EINVAL;
-
-	if (copy_from_user(line, buf, length))
-		return -EFAULT;
+		return length;
 
 	linelen = strlen(line);
 	ptr = line + linelen - 1;
@@ -149,17 +141,16 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 		return -EINVAL;
 	ptr = skip_spaces(ptr + 5);
 
-	for (i = 0; i < MTRR_NUM_TYPES; ++i) {
-		if (strcmp(ptr, mtrr_strings[i]))
-			continue;
-		base >>= PAGE_SHIFT;
-		size >>= PAGE_SHIFT;
-		err = mtrr_add_page((unsigned long)base, (unsigned long)size, i, true);
-		if (err < 0)
-			return err;
-		return len;
-	}
-	return -EINVAL;
+	i = match_string(mtrr_strings, MTRR_NUM_TYPES, ptr);
+	if (i < 0)
+		return i;
+
+	base >>= PAGE_SHIFT;
+	size >>= PAGE_SHIFT;
+	err = mtrr_add_page((unsigned long)base, (unsigned long)size, i, true);
+	if (err < 0)
+		return err;
+	return len;
 }
 
 static long
diff --git a/arch/x86/kernel/i8237.c b/arch/x86/kernel/i8237.c
index 8eeaa81de066..0a3e70fd00d6 100644
--- a/arch/x86/kernel/i8237.c
+++ b/arch/x86/kernel/i8237.c
@@ -9,10 +9,12 @@
  * your option) any later version.
  */
 
+#include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/syscore_ops.h>
 
 #include <asm/dma.h>
+#include <asm/x86_init.h>
 
 /*
  * This module just handles suspend/resume issues with the
@@ -49,6 +51,29 @@ static struct syscore_ops i8237_syscore_ops = {
 
 static int __init i8237A_init_ops(void)
 {
+	/*
+	 * From SKL PCH onwards, the legacy DMA device is removed in which the
+	 * I/O ports (81h-83h, 87h, 89h-8Bh, 8Fh) related to it are removed
+	 * as well. All removed ports must return 0xff for a inb() request.
+	 *
+	 * Note: DMA_PAGE_2 (port 0x81) should not be checked for detecting
+	 * the presence of DMA device since it may be used by BIOS to decode
+	 * LPC traffic for POST codes. Original LPC only decodes one byte of
+	 * port 0x80 but some BIOS may choose to enhance PCH LPC port 0x8x
+	 * decoding.
+	 */
+	if (dma_inb(DMA_PAGE_0) == 0xFF)
+		return -ENODEV;
+
+	/*
+	 * It is not required to load this driver as newer SoC may not
+	 * support 8237 DMA or bus mastering from LPC. Platform firmware
+	 * must announce the support for such legacy devices via
+	 * ACPI_FADT_LEGACY_DEVICES field in FADT table.
+	 */
+	if (x86_pnpbios_disabled() && dmi_get_bios_year() >= 2017)
+		return -ENODEV;
+
 	register_syscore_ops(&i8237_syscore_ops);
 	return 0;
 }
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 2c3a1b4294eb..74383a3780dc 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -317,15 +317,12 @@ void __init idt_setup_apic_and_irq_gates(void)
 		set_intr_gate(i, entry);
 	}
 
-	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
 #ifdef CONFIG_X86_LOCAL_APIC
+	for_each_clear_bit_from(i, system_vectors, NR_VECTORS) {
 		set_bit(i, system_vectors);
 		set_intr_gate(i, spurious_interrupt);
-#else
-		entry = irq_entries_start + 8 * (i - FIRST_EXTERNAL_VECTOR);
-		set_intr_gate(i, entry);
-#endif
 	}
+#endif
 }
 
 /**
diff --git a/arch/x86/kernel/platform-quirks.c b/arch/x86/kernel/platform-quirks.c
index 235fe6008ac8..b348a672f71d 100644
--- a/arch/x86/kernel/platform-quirks.c
+++ b/arch/x86/kernel/platform-quirks.c
@@ -33,9 +33,14 @@ void __init x86_early_init_platform_quirks(void)
 		x86_platform.set_legacy_features();
 }
 
+bool __init x86_pnpbios_disabled(void)
+{
+	return x86_platform.legacy.devices.pnpbios == 0;
+}
+
 #if defined(CONFIG_PNPBIOS)
 bool __init arch_pnpbios_disabled(void)
 {
-	return x86_platform.legacy.devices.pnpbios == 0;
+	return x86_pnpbios_disabled();
 }
 #endif
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 1b2197d13832..7ae36868aed2 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -527,6 +527,7 @@ void __init sme_enable(struct boot_params *bp)
 		/* SEV state cannot be controlled by a command line option */
 		sme_me_mask = me_mask;
 		sev_enabled = true;
+		physical_mask &= ~sme_me_mask;
 		return;
 	}
 
@@ -561,4 +562,6 @@ void __init sme_enable(struct boot_params *bp)
 		sme_me_mask = 0;
 	else
 		sme_me_mask = active_by_default ? me_mask : 0;
+
+	physical_mask &= ~sme_me_mask;
 }
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ffc8c13c50e4..3ca59cf7a7f9 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -8,6 +8,11 @@
 #include <asm/fixmap.h>
 #include <asm/mtrr.h>
 
+#ifdef CONFIG_DYNAMIC_PHYSICAL_MASK
+phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
+EXPORT_SYMBOL(physical_mask);
+#endif
+
 #define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_ZERO)
 
 #ifdef CONFIG_HIGHPTE
diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index b36caae0fb2f..b96d38288c60 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -615,7 +615,7 @@ static int uv2_3_wait_completion(struct bau_desc *bau_desc,
 
 	/* spin on the status MMR, waiting for it to go idle */
 	while (descriptor_stat != UV2H_DESC_IDLE) {
-		if ((descriptor_stat == UV2H_DESC_SOURCE_TIMEOUT)) {
+		if (descriptor_stat == UV2H_DESC_SOURCE_TIMEOUT) {
 			/*
 			 * A h/w bug on the destination side may
 			 * have prevented the message being marked
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index e4cb9f4cde8a..fc13cbbb2dce 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -47,11 +47,6 @@ static void uv_program_mmr(struct irq_cfg *cfg, struct uv_irq_2_mmr_pnode *info)
 
 static void uv_noop(struct irq_data *data) { }
 
-static void uv_ack_apic(struct irq_data *data)
-{
-	ack_APIC_irq();
-}
-
 static int
 uv_set_irq_affinity(struct irq_data *data, const struct cpumask *mask,
 		    bool force)
@@ -73,7 +68,7 @@ static struct irq_chip uv_irq_chip = {
 	.name			= "UV-CORE",
 	.irq_mask		= uv_noop,
 	.irq_unmask		= uv_noop,
-	.irq_eoi		= uv_ack_apic,
+	.irq_eoi		= apic_ack_irq,
 	.irq_set_affinity	= uv_set_irq_affinity,
 };
 
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 8fb8c737fffe..b0b30a568db7 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -4379,7 +4379,7 @@ static void ir_compose_msi_msg(struct irq_data *irq_data, struct msi_msg *msg)
 
 static struct irq_chip amd_ir_chip = {
 	.name			= "AMD-IR",
-	.irq_ack		= ir_ack_apic_edge,
+	.irq_ack		= apic_ack_irq,
 	.irq_set_affinity	= amd_ir_set_affinity,
 	.irq_set_vcpu_affinity	= amd_ir_set_vcpu_affinity,
 	.irq_compose_msi_msg	= ir_compose_msi_msg,
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
index 3062a154a9fb..967450bd421a 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel_irq_remapping.c
@@ -1223,7 +1223,7 @@ static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 
 static struct irq_chip intel_ir_chip = {
 	.name			= "INTEL-IR",
-	.irq_ack		= ir_ack_apic_edge,
+	.irq_ack		= apic_ack_irq,
 	.irq_set_affinity	= intel_ir_set_affinity,
 	.irq_compose_msi_msg	= intel_ir_compose_msi_msg,
 	.irq_set_vcpu_affinity	= intel_ir_set_vcpu_affinity,
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index 496deee3ae3a..7d0f3074d41d 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -156,11 +156,6 @@ void panic_if_irq_remap(const char *msg)
 		panic(msg);
 }
 
-void ir_ack_apic_edge(struct irq_data *data)
-{
-	ack_APIC_irq();
-}
-
 /**
  * irq_remapping_get_ir_irq_domain - Get the irqdomain associated with the IOMMU
  *				     device serving request @info
diff --git a/drivers/iommu/irq_remapping.h b/drivers/iommu/irq_remapping.h
index 039c7af7b190..0afef6e43be4 100644
--- a/drivers/iommu/irq_remapping.h
+++ b/drivers/iommu/irq_remapping.h
@@ -65,8 +65,6 @@ struct irq_remap_ops {
 extern struct irq_remap_ops intel_irq_remap_ops;
 extern struct irq_remap_ops amd_iommu_irq_ops;
 
-extern void ir_ack_apic_edge(struct irq_data *data);
-
 #else  /* CONFIG_IRQ_REMAP */
 
 #define irq_remapping_enabled 0
diff --git a/include/linux/irq.h b/include/linux/irq.h
index 65916a305f3d..4e66378f290b 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -551,7 +551,12 @@ extern int irq_affinity_online_cpu(unsigned int cpu);
 #endif
 
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_PENDING_IRQ)
-void irq_move_irq(struct irq_data *data);
+void __irq_move_irq(struct irq_data *data);
+static inline void irq_move_irq(struct irq_data *data)
+{
+	if (unlikely(irqd_is_setaffinity_pending(data)))
+		__irq_move_irq(data);
+}
 void irq_move_masked_irq(struct irq_data *data);
 void irq_force_complete_move(struct irq_desc *desc);
 #else
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e3336d904f64..facfecfc543c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -204,6 +204,39 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	return ret;
 }
 
+#ifdef CONFIG_GENERIC_PENDING_IRQ
+static inline int irq_set_affinity_pending(struct irq_data *data,
+					   const struct cpumask *dest)
+{
+	struct irq_desc *desc = irq_data_to_desc(data);
+
+	irqd_set_move_pending(data);
+	irq_copy_pending(desc, dest);
+	return 0;
+}
+#else
+static inline int irq_set_affinity_pending(struct irq_data *data,
+					   const struct cpumask *dest)
+{
+	return -EBUSY;
+}
+#endif
+
+static int irq_try_set_affinity(struct irq_data *data,
+				const struct cpumask *dest, bool force)
+{
+	int ret = irq_do_set_affinity(data, dest, force);
+
+	/*
+	 * In case that the underlying vector management is busy and the
+	 * architecture supports the generic pending mechanism then utilize
+	 * this to avoid returning an error to user space.
+	 */
+	if (ret == -EBUSY && !force)
+		ret = irq_set_affinity_pending(data, dest);
+	return ret;
+}
+
 int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 			    bool force)
 {
@@ -214,8 +247,8 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;
 
-	if (irq_can_move_pcntxt(data)) {
-		ret = irq_do_set_affinity(data, mask, force);
+	if (irq_can_move_pcntxt(data) && !irqd_is_setaffinity_pending(data)) {
+		ret = irq_try_set_affinity(data, mask, force);
 	} else {
 		irqd_set_move_pending(data);
 		irq_copy_pending(desc, mask);
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index 86ae0eb80b53..def48589ea48 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -38,17 +38,18 @@ bool irq_fixup_move_pending(struct irq_desc *desc, bool force_clear)
 void irq_move_masked_irq(struct irq_data *idata)
 {
 	struct irq_desc *desc = irq_data_to_desc(idata);
-	struct irq_chip *chip = desc->irq_data.chip;
+	struct irq_data *data = &desc->irq_data;
+	struct irq_chip *chip = data->chip;
 
-	if (likely(!irqd_is_setaffinity_pending(&desc->irq_data)))
+	if (likely(!irqd_is_setaffinity_pending(data)))
 		return;
 
-	irqd_clr_move_pending(&desc->irq_data);
+	irqd_clr_move_pending(data);
 
 	/*
 	 * Paranoia: cpu-local interrupts shouldn't be calling in here anyway.
 	 */
-	if (irqd_is_per_cpu(&desc->irq_data)) {
+	if (irqd_is_per_cpu(data)) {
 		WARN_ON(1);
 		return;
 	}
@@ -73,13 +74,24 @@ void irq_move_masked_irq(struct irq_data *idata)
 	 * For correct operation this depends on the caller
 	 * masking the irqs.
 	 */
-	if (cpumask_any_and(desc->pending_mask, cpu_online_mask) < nr_cpu_ids)
-		irq_do_set_affinity(&desc->irq_data, desc->pending_mask, false);
-
+	if (cpumask_any_and(desc->pending_mask, cpu_online_mask) < nr_cpu_ids) {
+		int ret;
+
+		ret = irq_do_set_affinity(data, desc->pending_mask, false);
+		/*
+		 * If the there is a cleanup pending in the underlying
+		 * vector management, reschedule the move for the next
+		 * interrupt. Leave desc->pending_mask intact.
+		 */
+		if (ret == -EBUSY) {
+			irqd_set_move_pending(data);
+			return;
+		}
+	}
 	cpumask_clear(desc->pending_mask);
 }
 
-void irq_move_irq(struct irq_data *idata)
+void __irq_move_irq(struct irq_data *idata)
 {
 	bool masked;
 
@@ -90,9 +102,6 @@ void irq_move_irq(struct irq_data *idata)
 	 */
 	idata = irq_desc_get_irq_data(irq_data_to_desc(idata));
 
-	if (likely(!irqd_is_setaffinity_pending(idata)))
-		return;
-
 	if (unlikely(irqd_irq_disabled(idata)))
 		return;
 
