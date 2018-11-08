Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08552C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC87420883
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zj/jYv4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC87420883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbeKIHol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:44:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:37774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730302AbeKIHok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:44:40 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4999420989;
        Thu,  8 Nov 2018 22:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714829;
        bh=vaY++PS1SOI3w0J/Jj9jFa1p9O0EGwRVnkHIFHqEjZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zj/jYv4K+2oXWC1FatRjceZZ+gwgvure3y6Ub/V61+D3FUmR6BIKbczYbdAv4qBNx
         tlMK1iq3VsToY1eiOFwAIar4CGB1I1SymIwI7wU66ywhznX24XT3pMZTfuUw0KAdou
         LCTQSi0pMzwFm1OSW+8eE6th1bQRU50hlTByXOEg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 153/171] Revert "x86/mm: Expand static page table for fixmap space"
Date:   Thu,  8 Nov 2018 13:52:03 -0800
Message-Id: <20181108215137.868071598@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit 3a8304b7ad2e291777e8499e39390145d932a2fd, which was
upstream commit 05ab1d8a4b36ee912b7087c6da127439ed0a903e.

Ben Hutchings writes:

This backport is incorrect.  The part that updated __startup_64() in
arch/x86/kernel/head64.c was dropped, presumably because that function
doesn't exist in 4.9.  However that seems to be an essential of the
fix.  In 4.9 the startup_64 routine in arch/x86/kernel/head_64.S would
need to be changed instead.

I also found that this introduces new boot-time warnings on some
systems if CONFIG_DEBUG_WX is enabled.

So, unless someone provides fixes for those issues, I think this should
be reverted for the 4.9 branch.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/fixmap.h     |   10 ----------
 arch/x86/include/asm/pgtable_64.h |    3 +--
 arch/x86/kernel/head_64.S         |   16 ++++------------
 arch/x86/mm/pgtable.c             |    9 ---------
 arch/x86/xen/mmu.c                |    8 ++------
 5 files changed, 7 insertions(+), 39 deletions(-)

--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -14,16 +14,6 @@
 #ifndef _ASM_X86_FIXMAP_H
 #define _ASM_X86_FIXMAP_H
 
-/*
- * Exposed to assembly code for setting up initial page tables. Cannot be
- * calculated in assembly code (fixmap entries are an enum), but is sanity
- * checked in the actual fixmap C code to make sure that the fixmap is
- * covered fully.
- */
-#define FIXMAP_PMD_NUM	2
-/* fixmap starts downwards from the 507th entry in level2_fixmap_pgt */
-#define FIXMAP_PMD_TOP	507
-
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
 #include <asm/acpi.h>
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -13,14 +13,13 @@
 #include <asm/processor.h>
 #include <linux/bitops.h>
 #include <linux/threads.h>
-#include <asm/fixmap.h>
 
 extern pud_t level3_kernel_pgt[512];
 extern pud_t level3_ident_pgt[512];
 extern pmd_t level2_kernel_pgt[512];
 extern pmd_t level2_fixmap_pgt[512];
 extern pmd_t level2_ident_pgt[512];
-extern pte_t level1_fixmap_pgt[512 * FIXMAP_PMD_NUM];
+extern pte_t level1_fixmap_pgt[512];
 extern pgd_t init_level4_pgt[];
 
 #define swapper_pg_dir init_level4_pgt
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -23,7 +23,6 @@
 #include "../entry/calling.h"
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
-#include <asm/fixmap.h>
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/asm-offsets.h>
@@ -494,20 +493,13 @@ NEXT_PAGE(level2_kernel_pgt)
 		KERNEL_IMAGE_SIZE/PMD_SIZE)
 
 NEXT_PAGE(level2_fixmap_pgt)
-	.fill	(512 - 4 - FIXMAP_PMD_NUM),8,0
-	pgtno = 0
-	.rept (FIXMAP_PMD_NUM)
-	.quad level1_fixmap_pgt + (pgtno << PAGE_SHIFT) - __START_KERNEL_map \
-		+ _PAGE_TABLE;
-	pgtno = pgtno + 1
-	.endr
-	/* 6 MB reserved space + a 2MB hole */
-	.fill	4,8,0
+	.fill	506,8,0
+	.quad	level1_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE
+	/* 8MB reserved for vsyscalls + a 2MB hole = 4 + 1 entries */
+	.fill	5,8,0
 
 NEXT_PAGE(level1_fixmap_pgt)
-	.rept (FIXMAP_PMD_NUM)
 	.fill	512,8,0
-	.endr
 
 #undef PMDS
 
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -536,15 +536,6 @@ void __native_set_fixmap(enum fixed_addr
 {
 	unsigned long address = __fix_to_virt(idx);
 
-#ifdef CONFIG_X86_64
-       /*
-	* Ensure that the static initial page tables are covering the
-	* fixmap completely.
-	*/
-	BUILD_BUG_ON(__end_of_permanent_fixed_addresses >
-		     (FIXMAP_PMD_NUM * PTRS_PER_PTE));
-#endif
-
 	if (idx >= __end_of_fixed_addresses) {
 		BUG();
 		return;
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -1936,7 +1936,7 @@ void __init xen_setup_kernel_pagetable(p
 		 * L3_k[511] -> level2_fixmap_pgt */
 		convert_pfn_mfn(level3_kernel_pgt);
 
-		/* L3_k[511][508-FIXMAP_PMD_NUM ... 507] -> level1_fixmap_pgt */
+		/* L3_k[511][506] -> level1_fixmap_pgt */
 		convert_pfn_mfn(level2_fixmap_pgt);
 	}
 	/* We get [511][511] and have Xen's version of level2_kernel_pgt */
@@ -1970,11 +1970,7 @@ void __init xen_setup_kernel_pagetable(p
 		set_page_prot(level2_ident_pgt, PAGE_KERNEL_RO);
 		set_page_prot(level2_kernel_pgt, PAGE_KERNEL_RO);
 		set_page_prot(level2_fixmap_pgt, PAGE_KERNEL_RO);
-
-		for (i = 0; i < FIXMAP_PMD_NUM; i++) {
-			set_page_prot(level1_fixmap_pgt + i * PTRS_PER_PTE,
-				      PAGE_KERNEL_RO);
-		}
+		set_page_prot(level1_fixmap_pgt, PAGE_KERNEL_RO);
 
 		/* Pin down new L4 */
 		pin_pagetable_pfn(MMUEXT_PIN_L4_TABLE,


