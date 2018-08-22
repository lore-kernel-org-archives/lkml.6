Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9119FC43615
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5462148C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p8G9EifM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5462148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbeHVTLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:11:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51392 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbeHVTLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gBeaEcB0CRaE9iudyXRMqxnJyX6OHIKa2QWqyXhblwA=; b=p8G9EifMms1fnFzIqWxv4jM6D0
        0B4AEcLzmWE82yYl6NkQstHOzRaDl6nz148SfhDGz2POBDPUnTAsFeykKD15z9nlHnl3UPh4STzDz
        /IvBYWeIjwOLR2oH53h0kGxmGAFj5Xa6jRNvfNOaqqrhI0br6H3XbCckmWOd7dxwjWxwuDcmmhWEX
        xSDrnlqpqemTVvJNSZGc21VZjQXWL55S+9DTWiL53eJUr/FgkOZEWzcgTw0PiO35IB+YVmYf7RbFL
        bv68dVEqmevxLaN2YagmWBfXpkVAK6PL+iC9Ja20Ms1U52qXQvkSpjJt7XmBbzcr4KeSi3zBf2xks
        zJsIiR3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsVKN-0000WU-K1; Wed, 22 Aug 2018 15:45:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C627D2024D726; Wed, 22 Aug 2018 17:45:44 +0200 (CEST)
Message-ID: <20180822154046.877071284@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Aug 2018 17:30:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org
Cc:     peterz@infradead.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, will.deacon@arm.com, riel@surriel.com,
        jannh@google.com, ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 4/4] x86/mm: Only use tlb_remove_table() for paravirt
References: <20180822153012.173508681@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we don't use paravirt; don't play unnecessary and complicated games
to free page-tables.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                      |    2 +-
 arch/x86/hyperv/mmu.c                 |    2 ++
 arch/x86/include/asm/paravirt.h       |    5 +++++
 arch/x86/include/asm/paravirt_types.h |    3 +++
 arch/x86/include/asm/tlbflush.h       |    3 +++
 arch/x86/kernel/kvm.c                 |    5 ++++-
 arch/x86/kernel/paravirt.c            |    2 ++
 arch/x86/mm/pgtable.c                 |    8 ++++----
 arch/x86/xen/mmu_pv.c                 |    1 +
 9 files changed, 25 insertions(+), 6 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -179,7 +179,7 @@ config X86
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_RCU_TABLE_FREE
+	select HAVE_RCU_TABLE_FREE		if PARAVIRT
 	select HAVE_RCU_TABLE_INVALIDATE	if HAVE_RCU_TABLE_FREE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -9,6 +9,7 @@
 #include <asm/mshyperv.h>
 #include <asm/msr.h>
 #include <asm/tlbflush.h>
+#include <asm/tlb.h>
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/hyperv.h>
@@ -231,4 +232,5 @@ void hyperv_setup_mmu_ops(void)
 
 	pr_info("Using hypercall for remote TLB flush\n");
 	pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others;
+	pv_mmu_ops.tlb_remove_table = tlb_remove_table;
 }
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -309,6 +309,11 @@ static inline void flush_tlb_others(cons
 	PVOP_VCALL2(pv_mmu_ops.flush_tlb_others, cpumask, info);
 }
 
+static inline void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
+{
+	PVOP_VCALL2(pv_mmu_ops.tlb_remove_table, tlb, table);
+}
+
 static inline int paravirt_pgd_alloc(struct mm_struct *mm)
 {
 	return PVOP_CALL1(int, pv_mmu_ops.pgd_alloc, mm);
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -54,6 +54,7 @@ struct desc_struct;
 struct task_struct;
 struct cpumask;
 struct flush_tlb_info;
+struct mmu_gather;
 
 /*
  * Wrapper type for pointers to code which uses the non-standard
@@ -222,6 +223,8 @@ struct pv_mmu_ops {
 	void (*flush_tlb_others)(const struct cpumask *cpus,
 				 const struct flush_tlb_info *info);
 
+	void (*tlb_remove_table)(struct mmu_gather *tlb, void *table);
+
 	/* Hooks for allocating and freeing a pagetable top-level */
 	int  (*pgd_alloc)(struct mm_struct *mm);
 	void (*pgd_free)(struct mm_struct *mm, pgd_t *pgd);
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -552,6 +552,9 @@ extern void arch_tlbbatch_flush(struct a
 #ifndef CONFIG_PARAVIRT
 #define flush_tlb_others(mask, info)	\
 	native_flush_tlb_others(mask, info)
+
+#define paravirt_tlb_remove_table(tlb, page) \
+	tlb_remove_page(tlb, (void *)(page))
 #endif
 
 #endif /* _ASM_X86_TLBFLUSH_H */
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -45,6 +45,7 @@
 #include <asm/apic.h>
 #include <asm/apicdef.h>
 #include <asm/hypervisor.h>
+#include <asm/tlb.h>
 
 static int kvmapf = 1;
 
@@ -636,8 +637,10 @@ static void __init kvm_guest_init(void)
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
 	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
-	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME))
+	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
 		pv_mmu_ops.flush_tlb_others = kvm_flush_tlb_others;
+		pv_mmu_ops.tlb_remove_table = tlb_remove_table;
+	}
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
 		apic_set_eoi_write(kvm_guest_apic_eoi_write);
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -41,6 +41,7 @@
 #include <asm/tlbflush.h>
 #include <asm/timer.h>
 #include <asm/special_insns.h>
+#include <asm/tlb.h>
 
 /*
  * nop stub, which must not clobber anything *including the stack* to
@@ -409,6 +410,7 @@ struct pv_mmu_ops pv_mmu_ops __ro_after_
 	.flush_tlb_kernel = native_flush_tlb_global,
 	.flush_tlb_one_user = native_flush_tlb_one_user,
 	.flush_tlb_others = native_flush_tlb_others,
+	.tlb_remove_table = (void (*)(struct mmu_gather *, void *))tlb_remove_page,
 
 	.pgd_alloc = __paravirt_pgd_alloc,
 	.pgd_free = paravirt_nop,
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -63,7 +63,7 @@ void ___pte_free_tlb(struct mmu_gather *
 {
 	pgtable_page_dtor(pte);
 	paravirt_release_pte(page_to_pfn(pte));
-	tlb_remove_table(tlb, pte);
+	paravirt_tlb_remove_table(tlb, pte);
 }
 
 #if CONFIG_PGTABLE_LEVELS > 2
@@ -79,21 +79,21 @@ void ___pmd_free_tlb(struct mmu_gather *
 	tlb->need_flush_all = 1;
 #endif
 	pgtable_pmd_page_dtor(page);
-	tlb_remove_table(tlb, page);
+	paravirt_tlb_remove_table(tlb, page);
 }
 
 #if CONFIG_PGTABLE_LEVELS > 3
 void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 {
 	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
-	tlb_remove_table(tlb, virt_to_page(pud));
+	paravirt_tlb_remove_table(tlb, virt_to_page(pud));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
-	tlb_remove_table(tlb, virt_to_page(p4d));
+	paravirt_tlb_remove_table(tlb, virt_to_page(p4d));
 }
 #endif	/* CONFIG_PGTABLE_LEVELS > 4 */
 #endif	/* CONFIG_PGTABLE_LEVELS > 3 */
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2397,6 +2397,7 @@ static const struct pv_mmu_ops xen_mmu_o
 	.flush_tlb_kernel = xen_flush_tlb,
 	.flush_tlb_one_user = xen_flush_tlb_one_user,
 	.flush_tlb_others = xen_flush_tlb_others,
+	.tlb_remove_table = tlb_remove_table,
 
 	.pgd_alloc = xen_pgd_alloc,
 	.pgd_free = xen_pgd_free,


