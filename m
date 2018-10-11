Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4ACDC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D2E21470
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEkAhVKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D2E21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbeJKXLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:11:18 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB5C20652;
        Thu, 11 Oct 2018 15:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272613;
        bh=TdRQ/mLCS+LiKIrCuM+2+uVhHDSXed36P0mYxOwFH9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vEkAhVKvZkLkK6zfVXuGp5dI17JM74Jdyy2bl6fdIrttgdfqoZxu/QdtPHBonLdcO
         vWwiFQXt/U6dHPZhTMpM77lvXmG+Zr0RlLKJiJVEwYFhaDIIlcdEOQnUGrpvzRWNkT
         JUPUX+aK2+IIn6JlZjSRjLfnU04YiUP28CJbSvHE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        H Peter Anvin <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirsky <luto@kernel.org>
Subject: [PATCH 4.9 23/35] x86/mm: Expand static page table for fixmap space
Date:   Thu, 11 Oct 2018 17:35:25 +0200
Message-Id: <20181011152521.098965859@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152520.174949126@linuxfoundation.org>
References: <20181011152520.174949126@linuxfoundation.org>
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

From: Feng Tang <feng.tang@intel.com>

commit 05ab1d8a4b36ee912b7087c6da127439ed0a903e upstream.

We met a kernel panic when enabling earlycon, which is due to the fixmap
address of earlycon is not statically setup.

Currently the static fixmap setup in head_64.S only covers 2M virtual
address space, while it actually could be in 4M space with different
kernel configurations, e.g. when VSYSCALL emulation is disabled.

So increase the static space to 4M for now by defining FIXMAP_PMD_NUM to 2,
and add a build time check to ensure that the fixmap is covered by the
initial static page tables.

Fixes: 1ad83c858c7d ("x86_64,vsyscall: Make vsyscall emulation configurable")
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: kernel test robot <rong.a.chen@intel.com>
Reviewed-by: Juergen Gross <jgross@suse.com> (Xen parts)
Cc: H Peter Anvin <hpa@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180920025828.23699-1-feng.tang@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/fixmap.h     |   10 ++++++++++
 arch/x86/include/asm/pgtable_64.h |    3 ++-
 arch/x86/kernel/head_64.S         |   16 ++++++++++++----
 arch/x86/mm/pgtable.c             |    9 +++++++++
 arch/x86/xen/mmu.c                |    8 ++++++--
 5 files changed, 39 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -14,6 +14,16 @@
 #ifndef _ASM_X86_FIXMAP_H
 #define _ASM_X86_FIXMAP_H
 
+/*
+ * Exposed to assembly code for setting up initial page tables. Cannot be
+ * calculated in assembly code (fixmap entries are an enum), but is sanity
+ * checked in the actual fixmap C code to make sure that the fixmap is
+ * covered fully.
+ */
+#define FIXMAP_PMD_NUM	2
+/* fixmap starts downwards from the 507th entry in level2_fixmap_pgt */
+#define FIXMAP_PMD_TOP	507
+
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
 #include <asm/acpi.h>
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -13,13 +13,14 @@
 #include <asm/processor.h>
 #include <linux/bitops.h>
 #include <linux/threads.h>
+#include <asm/fixmap.h>
 
 extern pud_t level3_kernel_pgt[512];
 extern pud_t level3_ident_pgt[512];
 extern pmd_t level2_kernel_pgt[512];
 extern pmd_t level2_fixmap_pgt[512];
 extern pmd_t level2_ident_pgt[512];
-extern pte_t level1_fixmap_pgt[512];
+extern pte_t level1_fixmap_pgt[512 * FIXMAP_PMD_NUM];
 extern pgd_t init_level4_pgt[];
 
 #define swapper_pg_dir init_level4_pgt
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -23,6 +23,7 @@
 #include "../entry/calling.h"
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
+#include <asm/fixmap.h>
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/asm-offsets.h>
@@ -493,13 +494,20 @@ NEXT_PAGE(level2_kernel_pgt)
 		KERNEL_IMAGE_SIZE/PMD_SIZE)
 
 NEXT_PAGE(level2_fixmap_pgt)
-	.fill	506,8,0
-	.quad	level1_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE
-	/* 8MB reserved for vsyscalls + a 2MB hole = 4 + 1 entries */
-	.fill	5,8,0
+	.fill	(512 - 4 - FIXMAP_PMD_NUM),8,0
+	pgtno = 0
+	.rept (FIXMAP_PMD_NUM)
+	.quad level1_fixmap_pgt + (pgtno << PAGE_SHIFT) - __START_KERNEL_map \
+		+ _PAGE_TABLE;
+	pgtno = pgtno + 1
+	.endr
+	/* 6 MB reserved space + a 2MB hole */
+	.fill	4,8,0
 
 NEXT_PAGE(level1_fixmap_pgt)
+	.rept (FIXMAP_PMD_NUM)
 	.fill	512,8,0
+	.endr
 
 #undef PMDS
 
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -536,6 +536,15 @@ void __native_set_fixmap(enum fixed_addr
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
--- a/arch/x86/xen/mmu.c
+++ b/arch/x86/xen/mmu.c
@@ -1936,7 +1936,7 @@ void __init xen_setup_kernel_pagetable(p
 		 * L3_k[511] -> level2_fixmap_pgt */
 		convert_pfn_mfn(level3_kernel_pgt);
 
-		/* L3_k[511][506] -> level1_fixmap_pgt */
+		/* L3_k[511][508-FIXMAP_PMD_NUM ... 507] -> level1_fixmap_pgt */
 		convert_pfn_mfn(level2_fixmap_pgt);
 	}
 	/* We get [511][511] and have Xen's version of level2_kernel_pgt */
@@ -1970,7 +1970,11 @@ void __init xen_setup_kernel_pagetable(p
 		set_page_prot(level2_ident_pgt, PAGE_KERNEL_RO);
 		set_page_prot(level2_kernel_pgt, PAGE_KERNEL_RO);
 		set_page_prot(level2_fixmap_pgt, PAGE_KERNEL_RO);
-		set_page_prot(level1_fixmap_pgt, PAGE_KERNEL_RO);
+
+		for (i = 0; i < FIXMAP_PMD_NUM; i++) {
+			set_page_prot(level1_fixmap_pgt + i * PTRS_PER_PTE,
+				      PAGE_KERNEL_RO);
+		}
 
 		/* Pin down new L4 */
 		pin_pagetable_pfn(MMUEXT_PIN_L4_TABLE,


