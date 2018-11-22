Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C54C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5600220824
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Jb7U4Vgc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5600220824
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405786AbeKWDaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 22:30:21 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:39554 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404359AbeKWDaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 22:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1542905409; x=1574441409;
  h=from:to:cc:subject:date:message-id;
  bh=uR6OTfqyfPgXr8jCjIYnLfUKlOkELfypdLaRrHbGp7k=;
  b=Jb7U4Vgc2aOiFq1mQt1RwVEePPj5cMccmPF0CKdBLnGH0EFZE7dLTBzI
   lQnCT5ahkSYRUSxiaxSVcvtClGYWOp2tIOEFE/UA+N4OPo5zTX7DDc221
   kGYfCkiCJIrrd3q2KTnQ5ueWRztCefH3zleoRWeTKfmZJbdHxyn0obgxC
   Y=;
X-IronPort-AV: E=Sophos;i="5.56,253,1539648000"; 
   d="scan'208";a="771919559"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Nov 2018 16:50:08 +0000
Received: from u54ee758033e858cfa736.ant.amazon.com (pdx2-ws-svc-lb17-vlan3.amazon.com [10.247.140.70])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id wAMGo1Kw110559
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 22 Nov 2018 16:50:03 GMT
Received: from u54ee758033e858cfa736.ant.amazon.com (localhost [127.0.0.1])
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Debian-3) with ESMTP id wAMGo0iD008119;
        Thu, 22 Nov 2018 17:50:00 +0100
Received: (from jsteckli@localhost)
        by u54ee758033e858cfa736.ant.amazon.com (8.15.2/8.15.2/Submit) id wAMGnx9l008117;
        Thu, 22 Nov 2018 17:49:59 +0100
From:   Julian Stecklina <jsteckli@amazon.de>
To:     kernel-hardening@lists.openwall.com
Cc:     Julian Stecklina <jsteckli@amazon.de>,
        Liran Alon <liran.alon@oracle.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Jonathan Adams <jwadams@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RFC RESEND PATCH 4/6] x86/speculation, mm: add process local virtual memory region
Date:   Thu, 22 Nov 2018 17:49:37 +0100
Message-Id: <717f82f41dd541512edb0eb60afde8983377340d.1542905228.git.jsteckli@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542905228.git.jsteckli@amazon.de>
References: <cover.1542905228.git.jsteckli@amazon.de>
In-Reply-To: <cover.1542905228.git.jsteckli@amazon.de>
References: <cover.1542905228.git.jsteckli@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux kernel has a global address space that is the same for any
kernel code. This address space becomes a liability in a world with
processor information leak vulnerabilities, such as L1TF. With the right
cache load gadget, an attacker-controlled hyperthread pair can leak
arbitrary data via L1TF. The upstream Linux kernel currently suggests
disabling hyperthread, but this comes with a large performance hit for a
wide range of workloads.

An alternative mitigation is to not make certain data in the kernel
globally visible, but only when the kernel executes in the context of
the process where this data belongs to.

This patch adds the initial plumbing for allocating process-local
memory. By grabbing one entry in the PML4 of each set of page tables and
start treating it as process-local memory. We currently only support 2MB
of process-local allocations, but this is an arbitrary limitation and
can be lifted by working on the page table allocation code.

While memory is used for process-local allocations, it is unmapped from
the linear mapping of physical memory.

The code has some limitations that are spelled out in
arch/x86/mm/proclocal.c.

Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
---
 arch/x86/Kconfig                        |   1 +
 arch/x86/include/asm/pgtable_64_types.h |   6 +
 arch/x86/include/asm/proclocal.h        |  44 ++++
 arch/x86/mm/Makefile                    |   2 +
 arch/x86/mm/dump_pagetables.c           |   3 +
 arch/x86/mm/fault.c                     |  14 ++
 arch/x86/mm/proclocal.c                 | 269 ++++++++++++++++++++++++
 include/linux/mm_types.h                |   7 +
 security/Kconfig                        |  16 ++
 9 files changed, 362 insertions(+)
 create mode 100644 arch/x86/include/asm/proclocal.h
 create mode 100644 arch/x86/mm/proclocal.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..f701e68482a5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -32,6 +32,7 @@ config X86_64
 	select SWIOTLB
 	select X86_DEV_DMA_OPS
 	select ARCH_HAS_SYSCALL_WRAPPER
+	select ARCH_SUPPORTS_PROCLOCAL
 
 #
 # Arch settings
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 04edd2d58211..6c4912a85cef 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -138,6 +138,12 @@ extern unsigned int ptrs_per_p4d;
 
 #define VMALLOC_END		(VMALLOC_START + (VMALLOC_SIZE_TB << 40) - 1)
 
+#ifdef CONFIG_PROCLOCAL
+/* TODO: Make this generic instead of hardcoded */
+#define PROCLOCAL_START		_AC(0xffffeb0000000000, UL)
+#define PROCLOCAL_END		_AC(0xffffebffffffffff, UL)
+#endif
+
 #define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
 /* The module sections ends with the start of the fixmap */
 #define MODULES_END		_AC(0xffffffffff000000, UL)
diff --git a/arch/x86/include/asm/proclocal.h b/arch/x86/include/asm/proclocal.h
new file mode 100644
index 000000000000..d322ddc42152
--- /dev/null
+++ b/arch/x86/include/asm/proclocal.h
@@ -0,0 +1,44 @@
+#ifndef _ASM_X86_PROCLOCAL_H
+#define _ASM_X86_PROCLOCAL_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_PROCLOCAL
+
+struct mm_struct;
+
+struct proclocal {
+	void *alloc;
+	struct mm_struct *mm;
+	int order;
+};
+
+int kalloc_proclocal(struct proclocal *pl, size_t len);
+void kfree_proclocal(struct proclocal *pl);
+
+#else  /* !CONFIG_PROCLOCAL */
+
+#include <linux/slab.h>
+
+struct proclocal {
+	void *alloc;
+};
+
+static inline int kalloc_proclocal(struct proclocal *pl, size_t len)
+{
+	pl->alloc = kzalloc(len, GFP_KERNEL);
+
+	return -!pl->alloc;
+}
+
+static inline void kfree_proclocal(struct proclocal *pl)
+{
+	kfree(pl->alloc);
+	pl->alloc = NULL;
+}
+
+#endif
+
+#define proclocal_get(pl, type) ((type *)(pl)->alloc)
+
+#endif	/* _ASM_X86_PROCLOCAL_H */
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 4b101dd6e52f..94f99494544a 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -53,3 +53,5 @@ obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_boot.o
+
+obj-$(CONFIG_PROCLOCAL)		+= proclocal.o
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index a12afff146d1..64976db507f6 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -59,6 +59,7 @@ enum address_markers_idx {
 #endif
 	VMALLOC_START_NR,
 	VMEMMAP_START_NR,
+	PROCLOCAL_START_NR,
 #ifdef CONFIG_KASAN
 	KASAN_SHADOW_START_NR,
 	KASAN_SHADOW_END_NR,
@@ -86,6 +87,7 @@ static struct addr_marker address_markers[] = {
 	[LOW_KERNEL_NR]		= { 0UL,		"Low Kernel Mapping" },
 	[VMALLOC_START_NR]	= { 0UL,		"vmalloc() Area" },
 	[VMEMMAP_START_NR]	= { 0UL,		"Vmemmap" },
+	[PROCLOCAL_START_NR]    = { 0UL,                "Process local" },
 #ifdef CONFIG_KASAN
 	/*
 	 * These fields get initialized with the (dynamic)
@@ -606,6 +608,7 @@ static int __init pt_dump_init(void)
 	address_markers[KASAN_SHADOW_START_NR].start_address = KASAN_SHADOW_START;
 	address_markers[KASAN_SHADOW_END_NR].start_address = KASAN_SHADOW_END;
 #endif
+	address_markers[PROCLOCAL_START_NR].start_address = PROCLOCAL_START;
 #endif
 #ifdef CONFIG_X86_32
 	address_markers[VMALLOC_START_NR].start_address = VMALLOC_START;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 47bebfe6efa7..0590eed9941b 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1185,6 +1185,15 @@ static int fault_in_kernel_space(unsigned long address)
 	return address >= TASK_SIZE_MAX;
 }
 
+static int fault_in_process_local(unsigned long address)
+{
+#ifdef CONFIG_PROCLOCAL
+	return address >= PROCLOCAL_START && address <= PROCLOCAL_END;
+#else
+	return false;
+#endif
+}
+
 static inline bool smap_violation(int error_code, struct pt_regs *regs)
 {
 	if (!IS_ENABLED(CONFIG_X86_SMAP))
@@ -1240,6 +1249,11 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	 * protection error (error_code & 9) == 0.
 	 */
 	if (unlikely(fault_in_kernel_space(address))) {
+
+		if (unlikely(fault_in_process_local(address))) {
+			BUG();
+		}
+
 		if (!(error_code & (X86_PF_RSVD | X86_PF_USER | X86_PF_PROT))) {
 			if (vmalloc_fault(address) >= 0)
 				return;
diff --git a/arch/x86/mm/proclocal.c b/arch/x86/mm/proclocal.c
new file mode 100644
index 000000000000..5b382796a5bf
--- /dev/null
+++ b/arch/x86/mm/proclocal.c
@@ -0,0 +1,269 @@
+#include <linux/bitmap.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/sched/mm.h>
+
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
+#include <asm/tlb.h>
+
+#include <asm/proclocal.h>
+
+/*
+ * The code in this file implements process-local mappings in the Linux kernel
+ * address space. This memory is only usable in the process context. With memory
+ * not globally visible in the kernel, it cannot easily be prefetched and leaked
+ * via L1TF.
+ *
+ * We claim one PGD entry for this purpose, but currently use a single page
+ * table for actual mappings. Metainformation is stored in mm_struct, including
+ * the bitmap to keep track of unused address space.
+ *
+ * Issues:
+ *
+ * - Is holding the write part of mmap_sem the right kind of synchronization?
+ * - Should this code move out of x86?
+ */
+
+#define PRL_DBG(...) do { } while (0);
+//#define PRL_DBG(msg, ...) pr_debug("%s: " msg, __func__, __VA_ARGS__)
+
+/* We only maintain a single page table for now. */
+#define MAX_PROCLOCAL_PAGES 512
+
+/*
+ * Initialize process-local kernel mappings by creating the relevant page
+ * tables.
+ */
+static int proclocal_init_page_tables(struct mm_struct *mm)
+{
+	pgd_t *pgd = pgd_offset(mm, PROCLOCAL_START);
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	PRL_DBG("pgd=%lx %lx\n", (unsigned long)pgd, pgd_val(*pgd));
+
+	BUG_ON(pgd_val(*pgd));
+
+	p4d = p4d_alloc(mm, pgd, PROCLOCAL_START);
+	if (!p4d)
+		goto fail;
+
+	pud = pud_alloc(mm, p4d, PROCLOCAL_START);
+	if (!pud)
+		goto free_p4d;
+
+	pmd = pmd_alloc(mm, pud, PROCLOCAL_START);
+	if (!pmd)
+		goto free_pud;
+
+	pte = pte_alloc_map(mm, pmd, PROCLOCAL_START);
+	if (!pte)
+		goto free_pmd;
+
+	return 0;
+free_pmd:
+	pmd_free(mm, pmd);
+free_pud:
+	pud_free(mm, pud);
+free_p4d:
+	p4d_free(mm, p4d);
+fail:
+	return -1;
+}
+
+/*
+ * Cleanup page table structures previously allocated with
+ * proclocal_init_page_tables.
+ */
+static void proclocal_cleanup_page_tables(struct mm_struct *mm)
+{
+	struct mmu_gather tlb;
+	unsigned long start = PROCLOCAL_START;
+	unsigned long end = PROCLOCAL_END + 1; /* exclusive */
+
+	tlb_gather_mmu(&tlb, mm, start, end);
+	free_pgd_range(&tlb, start, end, start, end);
+	tlb_finish_mmu(&tlb, start, end);
+}
+
+static int proclocal_init(struct mm_struct *mm)
+{
+	int rc;
+
+	rc = proclocal_init_page_tables(mm);
+	if (rc)
+		goto fail;
+
+	mm->proclocal_bitmap = bitmap_zalloc(MAX_PROCLOCAL_PAGES, GFP_KERNEL);
+	if (!mm->proclocal_bitmap) {
+		goto free_page_tables;
+	}
+
+	BUG_ON(mm->proclocal_in_use_pages != 0);
+
+	return 0;
+
+free_page_tables:
+	proclocal_cleanup_page_tables(mm);
+fail:
+	return -1;
+}
+
+static void proclocal_cleanup(struct mm_struct *mm)
+{
+	BUG_ON(mm->proclocal_in_use_pages != 0);
+
+	proclocal_cleanup_page_tables(mm);
+	bitmap_free(mm->proclocal_bitmap);
+}
+
+static pte_t *pte_lookup(struct mm_struct *mm, unsigned long vaddr)
+{
+	pgd_t *pgd = pgd_offset(mm, vaddr);
+	p4d_t *p4d = p4d_offset(pgd, vaddr);
+	pud_t *pud = pud_offset(p4d, vaddr);
+	pmd_t *pmd = pmd_offset(pud, vaddr);
+
+	return pte_offset_map(pmd, vaddr);
+}
+
+static int proclocal_map(struct mm_struct *mm, unsigned long vaddr)
+{
+	struct page *page;
+	pte_t *pte = pte_lookup(mm, vaddr);
+
+	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	if (!page)
+		goto fail;
+
+	PRL_DBG("allocated %p\n", page);
+	set_pte(pte, mk_pte(page, kmap_prot));
+
+	/*
+	 * Remove mapping from direct mapping. This also flushes the TLB.
+	 */
+	__kernel_map_pages(page, 1, false);
+
+	return 0;
+fail:
+	return 1;
+}
+
+static int proclocal_unmap(struct mm_struct *mm, unsigned long vaddr)
+{
+	pte_t *ptep = pte_lookup(mm, vaddr);
+	pte_t pte = ptep_get_and_clear(mm, vaddr, ptep);
+	struct page *page = pfn_to_page(pte_pfn(pte));
+
+	/* Restore direct mapping and flush TLB. */
+	__kernel_map_pages(page, 1, true);
+
+	PRL_DBG("freeing %p\n", page);
+	__free_pages(page, 0);
+
+	return 0;
+}
+
+int kalloc_proclocal(struct proclocal *pl, size_t len)
+{
+	struct mm_struct *mm = current->mm;
+	size_t nr_pages = round_up(len, PAGE_SIZE) / PAGE_SIZE;
+	int order, free_page_off;
+	unsigned long vaddr;
+	size_t i;
+	
+	PRL_DBG("%s: mm=%lx len=%zu -> nr_pages=%zu\n",
+		(unsigned long)mm, len, nr_pages);
+
+	might_sleep();
+	BUG_ON(!mm);
+
+	if (len == 0)
+		goto fail;
+
+	down_write(&mm->mmap_sem);
+
+	if (mm->proclocal_in_use_pages == 0 && proclocal_init(mm))
+		goto fail_unlock;
+
+	order = get_count_order(nr_pages);
+	nr_pages = 1U << order;
+
+	free_page_off = bitmap_find_free_region(mm->proclocal_bitmap, MAX_PROCLOCAL_PAGES, order);
+	if (free_page_off < 0) {
+		goto fail_unlock;
+	}
+
+	vaddr = PROCLOCAL_START + free_page_off * PAGE_SIZE;
+
+	for (i = 0; i < nr_pages; i++) {
+		if (proclocal_map(mm, vaddr + i*PAGE_SIZE)) {
+			/* TODO Cleanup */
+			BUG();
+		}
+	}
+
+	up_write(&mm->mmap_sem);
+
+	mm->proclocal_in_use_pages += nr_pages;
+
+	pl->alloc = (void *)vaddr;
+	pl->order = order;
+	pl->mm = mm;
+
+	/* Keep the mm_struct around as long as there are mappings in it. */
+	mmgrab(mm);
+
+	return 0;
+fail_unlock:
+	up_write(&mm->mmap_sem);
+fail:
+	return -1;
+}
+EXPORT_SYMBOL_GPL(kalloc_proclocal);
+
+void kfree_proclocal(struct proclocal *pl)
+{
+	unsigned long vaddr = (unsigned long)pl->alloc;
+	size_t nr_pages = 1U << pl->order;
+	size_t i;
+
+	PRL_DBG("vaddr=%lx mm=%lx nr_pages=%zu\n",
+		vaddr, (unsigned long)pl->mm, nr_pages);
+
+	BUG_ON(!vaddr);
+	BUG_ON(!pl->mm);
+
+	BUG_ON(vaddr < PROCLOCAL_START);
+	BUG_ON(vaddr + nr_pages*PAGE_SIZE >= PROCLOCAL_END);
+
+	might_sleep();
+
+	/*
+	 * TODO mm_users may already be 0 here. Is it still safe to take the
+	 * mmap_sem?
+	 */
+	down_write(&pl->mm->mmap_sem);
+
+	for (i = 0; i < nr_pages; i++) {
+		if (proclocal_unmap(pl->mm, vaddr + i*PAGE_SIZE)) {
+			/* TODO Cleanup */
+			BUG();
+		}
+	}
+
+	bitmap_release_region(pl->mm->proclocal_bitmap,
+			      (vaddr - PROCLOCAL_START) >> PAGE_SHIFT, pl->order);
+	pl->mm->proclocal_in_use_pages -= nr_pages;
+
+	if (pl->mm->proclocal_in_use_pages == 0) {
+		proclocal_cleanup(pl->mm);
+	}
+
+	up_write(&pl->mm->mmap_sem);
+	mmdrop(pl->mm);
+}
+EXPORT_SYMBOL_GPL(kfree_proclocal);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5ed8f6292a53..ca92328cd442 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -491,6 +491,13 @@ struct mm_struct {
 		/* HMM needs to track a few things per mm */
 		struct hmm *hmm;
 #endif
+
+#ifdef CONFIG_PROCLOCAL
+		/* Number of pages still in use */
+		size_t proclocal_in_use_pages;
+
+		unsigned long *proclocal_bitmap;
+#endif
 	} __randomize_layout;
 
 	/*
diff --git a/security/Kconfig b/security/Kconfig
index d9aa521b5206..db8149a083e1 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -6,6 +6,22 @@ menu "Security options"
 
 source security/keys/Kconfig
 
+config ARCH_SUPPORTS_PROCLOCAL
+	bool
+
+config PROCLOCAL
+	bool "Support process-local allocations in the kernel"
+	depends on ARCH_SUPPORTS_PROCLOCAL
+	default n
+	help
+	  This feature allows subsystems in the kernel to allocate memory that
+	  is only visible in the context of a specific process. This hardens the
+	  kernel against information leak vulnerabilities.
+
+	  There is a slight performance impact when this option is enabled.
+
+	  If you are unsure how to answer this question, answer N.
+
 config SECURITY_DMESG_RESTRICT
 	bool "Restrict unprivileged access to the kernel syslog"
 	default n
-- 
2.17.1

