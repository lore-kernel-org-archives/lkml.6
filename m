Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64622C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339B320652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:32:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339B320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeJXA4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:56:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:46394 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbeJXA4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:56:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 09:32:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,416,1534834800"; 
   d="scan'208";a="274917759"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 23 Oct 2018 09:32:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 463D667; Tue, 23 Oct 2018 19:32:04 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org
Cc:     x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/2] x86/mm: Move LDT remap out of KASLR region on 5-level paging
Date:   Tue, 23 Oct 2018 19:31:56 +0300
Message-Id: <20181023163157.41441-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181023163157.41441-1-kirill.shutemov@linux.intel.com>
References: <20181023163157.41441-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5-level paging LDT remap area is placed in the middle of
KASLR randomization region and it can overlap with direct mapping,
vmalloc or vmap area.

Let's move LDT just before direct mapping which makes it safe for KASLR.
This also allows us to unify layout between 4- and 5-level paging.

We don't touch 4 pgd slot gap just before the direct mapping reserved
for a hypervisor, but move direct mapping by one slot instead.

The LDT mapping is per-mm, so we cannot move it into P4D page table next
to CPU_ENTRY_AREA without complicating PGD table allocation for 5-level
paging.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: f55f0501cbf6 ("x86/pti: Put the LDT in its own PGD if PTI is on")
---
 Documentation/x86/x86_64/mm.txt         |  8 ++++----
 arch/x86/include/asm/page_64_types.h    | 12 +++++++-----
 arch/x86/include/asm/pgtable_64_types.h |  4 +---
 arch/x86/xen/mmu_pv.c                   |  6 +++---
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/x86/x86_64/mm.txt b/Documentation/x86/x86_64/mm.txt
index 5432a96d31ff..463c48c26fb7 100644
--- a/Documentation/x86/x86_64/mm.txt
+++ b/Documentation/x86/x86_64/mm.txt
@@ -4,7 +4,8 @@ Virtual memory map with 4 level page tables:
 0000000000000000 - 00007fffffffffff (=47 bits) user space, different per mm
 hole caused by [47:63] sign extension
 ffff800000000000 - ffff87ffffffffff (=43 bits) guard hole, reserved for hypervisor
-ffff880000000000 - ffffc7ffffffffff (=64 TB) direct mapping of all phys. memory
+ffff888000000000 - ffff887fffffffff (=39 bits) LDT remap for PTI
+ffff888000000000 - ffffc87fffffffff (=64 TB) direct mapping of all phys. memory
 ffffc80000000000 - ffffc8ffffffffff (=40 bits) hole
 ffffc90000000000 - ffffe8ffffffffff (=45 bits) vmalloc/ioremap space
 ffffe90000000000 - ffffe9ffffffffff (=40 bits) hole
@@ -14,7 +15,6 @@ ffffec0000000000 - fffffbffffffffff (=44 bits) kasan shadow memory (16TB)
 ... unused hole ...
 				    vaddr_end for KASLR
 fffffe0000000000 - fffffe7fffffffff (=39 bits) cpu_entry_area mapping
-fffffe8000000000 - fffffeffffffffff (=39 bits) LDT remap for PTI
 ffffff0000000000 - ffffff7fffffffff (=39 bits) %esp fixup stacks
 ... unused hole ...
 ffffffef00000000 - fffffffeffffffff (=64 GB) EFI region mapping space
@@ -30,8 +30,8 @@ Virtual memory map with 5 level page tables:
 0000000000000000 - 00ffffffffffffff (=56 bits) user space, different per mm
 hole caused by [56:63] sign extension
 ff00000000000000 - ff0fffffffffffff (=52 bits) guard hole, reserved for hypervisor
-ff10000000000000 - ff8fffffffffffff (=55 bits) direct mapping of all phys. memory
-ff90000000000000 - ff9fffffffffffff (=52 bits) LDT remap for PTI
+ff10000000000000 - ff10ffffffffffff (=48 bits) LDT remap for PTI
+ff11000000000000 - ff90ffffffffffff (=55 bits) direct mapping of all phys. memory
 ffa0000000000000 - ffd1ffffffffffff (=54 bits) vmalloc/ioremap space (12800 TB)
 ffd2000000000000 - ffd3ffffffffffff (=49 bits) hole
 ffd4000000000000 - ffd5ffffffffffff (=49 bits) virtual memory map (512TB)
diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index 6afac386a434..b99d497e342d 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -33,12 +33,14 @@
 
 /*
  * Set __PAGE_OFFSET to the most negative possible address +
- * PGDIR_SIZE*16 (pgd slot 272).  The gap is to allow a space for a
- * hypervisor to fit.  Choosing 16 slots here is arbitrary, but it's
- * what Xen requires.
+ * PGDIR_SIZE*17 (pgd slot 273).
+ *
+ * The gap is to allow a space for LDT remap for PTI (1 pgd slot) and space for
+ * a hypervisor (16 slots). Choosing 16 slots for a hypervisor is arbitrary,
+ * but it's what Xen requires.
  */
-#define __PAGE_OFFSET_BASE_L5	_AC(0xff10000000000000, UL)
-#define __PAGE_OFFSET_BASE_L4	_AC(0xffff880000000000, UL)
+#define __PAGE_OFFSET_BASE_L5	_AC(0xff11000000000000, UL)
+#define __PAGE_OFFSET_BASE_L4	_AC(0xffff888000000000, UL)
 
 #ifdef CONFIG_DYNAMIC_MEMORY_LAYOUT
 #define __PAGE_OFFSET           page_offset_base
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 04edd2d58211..84bd9bdc1987 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -111,9 +111,7 @@ extern unsigned int ptrs_per_p4d;
  */
 #define MAXMEM			(1UL << MAX_PHYSMEM_BITS)
 
-#define LDT_PGD_ENTRY_L4	-3UL
-#define LDT_PGD_ENTRY_L5	-112UL
-#define LDT_PGD_ENTRY		(pgtable_l5_enabled() ? LDT_PGD_ENTRY_L5 : LDT_PGD_ENTRY_L4)
+#define LDT_PGD_ENTRY		-240UL
 #define LDT_BASE_ADDR		(LDT_PGD_ENTRY << PGDIR_SHIFT)
 #define LDT_END_ADDR		(LDT_BASE_ADDR + PGDIR_SIZE)
 
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index dd461c0167ef..2c84c6ad8b50 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -1897,7 +1897,7 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
 	init_top_pgt[0] = __pgd(0);
 
 	/* Pre-constructed entries are in pfn, so convert to mfn */
-	/* L4[272] -> level3_ident_pgt  */
+	/* L4[273] -> level3_ident_pgt  */
 	/* L4[511] -> level3_kernel_pgt */
 	convert_pfn_mfn(init_top_pgt);
 
@@ -1917,8 +1917,8 @@ void __init xen_setup_kernel_pagetable(pgd_t *pgd, unsigned long max_pfn)
 	addr[0] = (unsigned long)pgd;
 	addr[1] = (unsigned long)l3;
 	addr[2] = (unsigned long)l2;
-	/* Graft it onto L4[272][0]. Note that we creating an aliasing problem:
-	 * Both L4[272][0] and L4[511][510] have entries that point to the same
+	/* Graft it onto L4[273][0]. Note that we creating an aliasing problem:
+	 * Both L4[273][0] and L4[511][510] have entries that point to the same
 	 * L2 (PMD) tables. Meaning that if you modify it in __va space
 	 * it will be also modified in the __ka space! (But if you just
 	 * modify the PMD table to point to other PTE's or none, then you
-- 
2.19.1

