Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C79ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748312133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 22:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 748312133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeISDsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 23:48:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59251 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeISDsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 23:48:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8IMD4Hb937144
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Sep 2018 15:13:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8IMD42E937141;
        Tue, 18 Sep 2018 15:13:04 -0700
Date:   Tue, 18 Sep 2018 15:13:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Feng Tang <tipbot@zytor.com>
Message-ID: <tip-31217900acbaf66249b8befd06c975aa897b4deb@git.kernel.org>
Cc:     dave.hansen@intel.com, peterz@infradead.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, feng.tang@intel.com,
        mhocko@kernel.org, ak@linux.intel.com, hpa@linux.intel.com,
        linux-kernel@vger.kernel.org, yinghai@kernel.org
Reply-To: dave.hansen@intel.com, mingo@kernel.org, tglx@linutronix.de,
          peterz@infradead.org, mhocko@kernel.org, ak@linux.intel.com,
          feng.tang@intel.com, hpa@zytor.com, yinghai@kernel.org,
          linux-kernel@vger.kernel.org, hpa@linux.intel.com
In-Reply-To: <20180917091423.16069-1-feng.tang@intel.com>
References: <20180917091423.16069-1-feng.tang@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm: Expand static page table for fixmap space
Git-Commit-ID: 31217900acbaf66249b8befd06c975aa897b4deb
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

Commit-ID:  31217900acbaf66249b8befd06c975aa897b4deb
Gitweb:     https://git.kernel.org/tip/31217900acbaf66249b8befd06c975aa897b4deb
Author:     Feng Tang <feng.tang@intel.com>
AuthorDate: Mon, 17 Sep 2018 17:14:23 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 19 Sep 2018 00:09:10 +0200

x86/mm: Expand static page table for fixmap space

We met a kernel panic when enabling earlycon, which is due to the fixmap
address of earlycon is not statically setup.

Currently the static fixmap setup in head_64.S only covers 2M virtual
address space, while it acutually could be in 4M space with different
kernel configurations.

So increase the static space to 4M for now by defining FIXMAP_PMD_NUM to 2,
and add a build time check to ensure that the fixmap is covered by the
intial static page tables.

[ tglx: s/PTRS_PER_PMD/PTRS_PER_PTE/ and add the missing brackets ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com> (Xen parts)
Cc: H Peter Anvin <hpa@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/20180917091423.16069-1-feng.tang@intel.com

---
 arch/x86/include/asm/fixmap.h     |  8 ++++++++
 arch/x86/include/asm/pgtable_64.h |  3 ++-
 arch/x86/kernel/head_64.S         | 16 ++++++++++++----
 arch/x86/mm/pgtable.c             |  9 +++++++++
 arch/x86/xen/mmu_pv.c             |  8 ++++++--
 5 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index e203169931c7..01e8da740293 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -14,6 +14,14 @@
 #ifndef _ASM_X86_FIXMAP_H
 #define _ASM_X86_FIXMAP_H
 
+/*
+ * Exposed to assembly code for setting up initial page tables. Cannot be
+ * calculated in assembly code (fixmap entries are an enum), but is sanity
+ * checked in the actual fixmap C code to make sure that the fixmap is
+ * covered fully.
+ */
+#define FIXMAP_PMD_NUM	2
+
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
 #include <asm/acpi.h>
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index ce2b59047cb8..9c85b54bf03c 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -14,6 +14,7 @@
 #include <asm/processor.h>
 #include <linux/bitops.h>
 #include <linux/threads.h>
+#include <asm/fixmap.h>
 
 extern p4d_t level4_kernel_pgt[512];
 extern p4d_t level4_ident_pgt[512];
@@ -22,7 +23,7 @@ extern pud_t level3_ident_pgt[512];
 extern pmd_t level2_kernel_pgt[512];
 extern pmd_t level2_fixmap_pgt[512];
 extern pmd_t level2_ident_pgt[512];
-extern pte_t level1_fixmap_pgt[512];
+extern pte_t level1_fixmap_pgt[512 * FIXMAP_PMD_NUM];
 extern pgd_t init_top_pgt[];
 
 #define swapper_pg_dir init_top_pgt
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 15ebc2fc166e..a3618cf04cf6 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -24,6 +24,7 @@
 #include "../entry/calling.h"
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
+#include <asm/fixmap.h>
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/asm-offsets.h>
@@ -445,13 +446,20 @@ NEXT_PAGE(level2_kernel_pgt)
 		KERNEL_IMAGE_SIZE/PMD_SIZE)
 
 NEXT_PAGE(level2_fixmap_pgt)
-	.fill	506,8,0
-	.quad	level1_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
-	/* 8MB reserved for vsyscalls + a 2MB hole = 4 + 1 entries */
-	.fill	5,8,0
+	.fill	(512 - 4 - FIXMAP_PMD_NUM),8,0
+	pgtno = 0
+	.rept (FIXMAP_PMD_NUM)
+	.quad level1_fixmap_pgt + (pgtno << PAGE_SHIFT) - __START_KERNEL_map \
+		+ _PAGE_TABLE_NOENC;
+	pgtno = pgtno + 1
+	.endr
+	/* 6 MB reserved space + a 2MB hole */
+	.fill	4,8,0
 
 NEXT_PAGE(level1_fixmap_pgt)
+	.rept (FIXMAP_PMD_NUM)
 	.fill	512,8,0
+	.endr
 
 #undef PMDS
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ae394552fb94..089e78c4effd 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -637,6 +637,15 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte)
 {
 	unsigned long address = __fix_to_virt(idx);
 
+#ifdef CONFIG_X86_64
+       /*
+	* Ensure that the static initial page tables are covering the
+	* fixmap completely.
+	*/
+	BUILD_BUG_ON(__end_of_permanent_fixed_addresses >
+		     (FIXMAP_PMD_NUM * PTRS_PER_PTE));
+#endif
+
 	if (idx >= __end_of_fixed_addresses) {
 		BUG();
 		return;
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 2fe5c9b1816b..dd461c0167ef 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1907,7 +1907,7 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
 	/* L3_k[511] -> level2_fixmap_pgt */
 	convert_pfn_mfn(level3_kernel_pgt);
 
-	/* L3_k[511][506] -> level1_fixmap_pgt */
+	/* L3_k[511][508-FIXMAP_PMD_NUM ... 507] -> level1_fixmap_pgt */
 	convert_pfn_mfn(level2_fixmap_pgt);
 
 	/* We get [511][511] and have Xen's version of level2_kernel_pgt */
@@ -1952,7 +1952,11 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
 	set_page_prot(level2_ident_pgt, PAGE_KERNEL_RO);
 	set_page_prot(level2_kernel_pgt, PAGE_KERNEL_RO);
 	set_page_prot(level2_fixmap_pgt, PAGE_KERNEL_RO);
-	set_page_prot(level1_fixmap_pgt, PAGE_KERNEL_RO);
+
+	for (i = 0; i < FIXMAP_PMD_NUM; i++) {
+		set_page_prot(level1_fixmap_pgt + i * PTRS_PER_PTE,
+			      PAGE_KERNEL_RO);
+	}
 
 	/* Pin down new L4 */
 	pin_pagetable_pfn(MMUEXT_PIN_L4_TABLE,
