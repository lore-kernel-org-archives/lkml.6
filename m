Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419FEECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 14:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE41E20883
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 14:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE41E20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbeIPTyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 15:54:03 -0400
Received: from mga11.intel.com ([192.55.52.93]:38763 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbeIPTyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 15:54:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2018 07:30:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,381,1531810800"; 
   d="scan'208";a="83971591"
Received: from shbuild888.sh.intel.com (HELO localhost) ([10.239.146.239])
  by orsmga003.jf.intel.com with ESMTP; 16 Sep 2018 07:30:51 -0700
Date:   Sun, 16 Sep 2018 22:35:49 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@elte.hu>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86, mm: Reserver some memory for bootmem allocator for
 NO_BOOTMEM
Message-ID: <20180916143549.zmnlcviyn67fbxwh@shbuild888>
References: <alpine.DEB.2.21.1808311328260.2208@nanos.tec.linutronix.de>
 <20180831133659.pkmscqpudjnkujbg@shbuild888>
 <20180907081716.bxw3hmcl6w7gqvax@shbuild888>
 <alpine.DEB.2.21.1809071250240.1402@nanos.tec.linutronix.de>
 <20180910093938.ka732apzy3d3a5ip@shbuild888>
 <alpine.DEB.2.21.1809101147500.1402@nanos.tec.linutronix.de>
 <20180911061413.redy4oxia3hqifkh@shbuild888>
 <alpine.DEB.2.21.1809151226130.1650@nanos.tec.linutronix.de>
 <20180915164731.3zrdxijuwkgdi25p@shbuild888>
 <alpine.DEB.2.21.1809151923270.1650@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809151923270.1650@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 07:28:03PM +0200, Thomas Gleixner wrote:
> On Sun, 16 Sep 2018, Feng Tang wrote:
> > I have tried to change some header files incluing fixmap.h/apicdef.h/
> > vsyscall.h, and most of the .c files compile fine now, but I can not
> > use the "__end_of_permanent_fixed_addresses" in head_64.S as it is a 
> > enum type, and could not be recognized by assembly code.
> 
> Hrmm. I did not think about the enum. So we have two possibilities:
> 
> 1) Have some preprocessing which provides the info for the assembler
> 
> 2) Use a constant for the number of PMDs which is defined in a header and
>    then compile time checked against the size of the fixmap in a C-file.

As there is no fixmap.c, I put the chck into __native_set_fixmap temply,
please review, thanks

- Feng

diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index e203169931c7..ffaa0fa31044 100644
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
index f773d5e6c8cc..d6820d4c6e47 100644
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
index 15ebc2fc166e..985eaff70792 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -24,6 +24,7 @@
 #include "../entry/calling.h"
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
+#include <asm/fixmap.h>
 
 #ifdef CONFIG_PARAVIRT
 #include <asm/asm-offsets.h>
@@ -445,13 +446,19 @@ NEXT_PAGE(level2_kernel_pgt)
 		KERNEL_IMAGE_SIZE/PMD_SIZE)
 
 NEXT_PAGE(level2_fixmap_pgt)
-	.fill	506,8,0
-	.quad	level1_fixmap_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
-	/* 8MB reserved for vsyscalls + a 2MB hole = 4 + 1 entries */
-	.fill	5,8,0
+	.fill	(512 - 4 - FIXMAP_PMD_NUM),8,0
+	pgtno = 0
+	.rept (FIXMAP_PMD_NUM)
+	.quad level1_fixmap_pgt + (pgtno << PAGE_SHIFT) - __START_KERNEL_map  + _PAGE_TABLE_NOENC
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
index e848a4811785..a927f5f39bee 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -637,6 +637,16 @@ void __native_set_fixmap(enum fixed_addresses idx, pte_t pte)
 {
 	unsigned long address = __fix_to_virt(idx);
 
+#ifdef CONFIG_X86_64
+       /*
+        * In arch/x86/kernel/head_64.S, the static page table has
+	* been setup for fixmap. Add a sanity compiling check
+	* whether fixmap space has exceeded the capacity.
+        */
+       BUILD_BUG_ON((__end_of_permanent_fixed_addresses + 511)/512
+                       > FIXMAP_PMD_NUM);
+#endif
+
 	if (idx >= __end_of_fixed_addresses) {
 		BUG();
 		return;
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index 45b700ac5fe7..b0aa2364a3c6 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1953,7 +1953,10 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
 	set_page_prot(level2_ident_pgt, PAGE_KERNEL_RO);
 	set_page_prot(level2_kernel_pgt, PAGE_KERNEL_RO);
 	set_page_prot(level2_fixmap_pgt, PAGE_KERNEL_RO);
-	set_page_prot(level1_fixmap_pgt, PAGE_KERNEL_RO);
+
+	for (i = 0; i < FIXMAP_PMD_NUM; i++)
+		set_page_prot(level1_fixmap_pgt + i * 512,
+				PAGE_KERNEL_RO);
 
 	/* Pin down new L4 */
 	pin_pagetable_pfn(MMUEXT_PIN_L4_TABLE,

> 
> #1 would be preferred, but for a quick fix #2 is okay as well.
> 
> Thanks,
> 
> 	tglx
> 
