Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA183ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E372098A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 07:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E372098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeIQM4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:56:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:4051 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbeIQM4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:56:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 00:29:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,384,1531810800"; 
   d="scan'208";a="74877863"
Received: from shbuild888.sh.intel.com ([10.239.146.239])
  by orsmga006.jf.intel.com with ESMTP; 17 Sep 2018 00:29:50 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        H Peter Anvin <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH] x86/mm: Expand static page table for fixmap space
Date:   Mon, 17 Sep 2018 15:34:49 +0800
Message-Id: <20180917073449.20693-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We met a kernel panic when enabling earlycon, which is due to
the fixmap address of earlycon is not statically setup.

Currently the static fixmap setup in head_64.S only covers 2M
virtual address space, while it acutually could be in 4M space
with different kernel configurations.

So increase the static space to 4M for now by defining FIXMAP_PMD_NUM
to 2, and add a build time check for future possible overflow so that
the macro could be increased accordingly.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/include/asm/fixmap.h     |  3 +++
 arch/x86/include/asm/pgtable_64.h |  3 ++-
 arch/x86/kernel/head_64.S         | 16 ++++++++++++----
 arch/x86/mm/pgtable.c             | 10 ++++++++++
 arch/x86/xen/mmu_pv.c             |  4 +++-
 5 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index e203169..ffaa0fa 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -14,6 +14,9 @@
 #ifndef _ASM_X86_FIXMAP_H
 #define _ASM_X86_FIXMAP_H
 
+/* Put here to be accessble for assembly code like head_64.S */
+#define FIXMAP_PMD_NUM	2
+
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
 #include <asm/acpi.h>
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index ce2b590..9c85b54 100644
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
index 15ebc2f..a3618cf 100644
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
index ae39455..a4052b1 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -637,6 +637,16 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte)
 {
 	unsigned long address = __fix_to_virt(idx);
 
+#ifdef CONFIG_X86_64
+       /*
+	* In arch/x86/kernel/head_64.S, the static page table has
+	* been setup for fixmap. Add a sanity compiling check
+	* whether fixmap space has exceeded the capacity.
+	*/
+	BUILD_BUG_ON(__end_of_permanent_fixed_addresses
+			> (FIXMAP_PMD_NUM * PTRS_PER_PMD));
+#endif
+
 	if (idx >= __end_of_fixed_addresses) {
 		BUG();
 		return;
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 2fe5c9b..19077f9 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1952,7 +1952,9 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
 	set_page_prot(level2_ident_pgt, PAGE_KERNEL_RO);
 	set_page_prot(level2_kernel_pgt, PAGE_KERNEL_RO);
 	set_page_prot(level2_fixmap_pgt, PAGE_KERNEL_RO);
-	set_page_prot(level1_fixmap_pgt, PAGE_KERNEL_RO);
+
+	for (i = 0; i < FIXMAP_PMD_NUM; i++)
+		set_page_prot(level1_fixmap_pgt + i * 512, PAGE_KERNEL_RO);
 
 	/* Pin down new L4 */
 	pin_pagetable_pfn(MMUEXT_PIN_L4_TABLE,
-- 
2.7.4

