Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40FEC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48792168D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48792168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732859AbeHNRmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:42:18 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62495 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732667AbeHNRmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:42:17 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41qbGt66j0z9tvSv;
        Tue, 14 Aug 2018 16:54:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id tN8h2zH9-D3Q; Tue, 14 Aug 2018 16:54:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41qbGt5SCYz9tvSn;
        Tue, 14 Aug 2018 16:54:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 237048B7D6;
        Tue, 14 Aug 2018 16:54:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id J-FTnz0e7On9; Tue, 14 Aug 2018 16:54:47 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D2DB78B7D4;
        Tue, 14 Aug 2018 16:54:46 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A943171288; Tue, 14 Aug 2018 14:54:46 +0000 (UTC)
Message-Id: <4aaca2d27429e6bdadc340fd3b96e7c350c4b2f4.1534258290.git.christophe.leroy@c-s.fr>
In-Reply-To: <2f96bf1a8df1091c642de099ed07c34b5ab9b90a.1534258290.git.christophe.leroy@c-s.fr>
References: <2f96bf1a8df1091c642de099ed07c34b5ab9b90a.1534258290.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 3/4] powerpc/mm: fix a warning when a cache is common to
 PGD and hugepages
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 14 Aug 2018 14:54:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While implementing TLB miss HW assistance on the 8xx, the following
warning was encountered:

[  423.732965] WARNING: CPU: 0 PID: 345 at mm/slub.c:2412 ___slab_alloc.constprop.30+0x26c/0x46c
[  423.733033] CPU: 0 PID: 345 Comm: mmap Not tainted 4.18.0-rc8-00664-g2dfff9121c55 #671
[  423.733075] NIP:  c0108f90 LR: c0109ad0 CTR: 00000004
[  423.733121] REGS: c455bba0 TRAP: 0700   Not tainted  (4.18.0-rc8-00664-g2dfff9121c55)
[  423.733147] MSR:  00021032 <ME,IR,DR,RI>  CR: 24224848  XER: 20000000
[  423.733319]
[  423.733319] GPR00: c0109ad0 c455bc50 c4521910 c60053c0 007080c0 c0011b34 c7fa41e0 c455be30
[  423.733319] GPR08: 00000001 c00103a0 c7fa41e0 c49afcc4 24282842 10018840 c079b37c 00000040
[  423.733319] GPR16: 73f00000 00210d00 00000000 00000001 c455a000 00000100 00000200 c455a000
[  423.733319] GPR24: c60053c0 c0011b34 007080c0 c455a000 c455a000 c7fa41e0 00000000 00009032
[  423.734190] NIP [c0108f90] ___slab_alloc.constprop.30+0x26c/0x46c
[  423.734257] LR [c0109ad0] kmem_cache_alloc+0x210/0x23c
[  423.734283] Call Trace:
[  423.734326] [c455bc50] [00000100] 0x100 (unreliable)
[  423.734430] [c455bcc0] [c0109ad0] kmem_cache_alloc+0x210/0x23c
[  423.734543] [c455bcf0] [c0011b34] huge_pte_alloc+0xc0/0x1dc
[  423.734633] [c455bd20] [c01044dc] hugetlb_fault+0x408/0x48c
[  423.734720] [c455bdb0] [c0104b20] follow_hugetlb_page+0x14c/0x44c
[  423.734826] [c455be10] [c00e8e54] __get_user_pages+0x1c4/0x3dc
[  423.734919] [c455be80] [c00e9924] __mm_populate+0xac/0x140
[  423.735020] [c455bec0] [c00db14c] vm_mmap_pgoff+0xb4/0xb8
[  423.735127] [c455bf00] [c00f27c0] ksys_mmap_pgoff+0xcc/0x1fc
[  423.735222] [c455bf40] [c000e0f8] ret_from_syscall+0x0/0x38
[  423.735271] Instruction dump:
[  423.735321] 7cbf482e 38fd0008 7fa6eb78 7fc4f378 4bfff5dd 7fe3fb78 4bfffe24 81370010
[  423.735536] 71280004 41a2ff88 4840c571 4bffff80 <0fe00000> 4bfffeb8 81340010 712a0004
[  423.735757] ---[ end trace e9b222919a470790 ]---

This warning occurs when calling kmem_cache_zalloc() on a
cache having a constructor.

In this case it happens because PGD cache and 512k hugepte cache are
the same size (4k). While a cache with constructor is created for
the PGD, hugepages create cache without constructor and uses
kmem_cache_zalloc(). As both expect a cache with the same size,
the hugepages reuse the cache created for PGD, hence the conflict.

In order to avoid this conflict, this patch:
- modifies pgtable_cache_add() so that a zeroising constructor is
added for any cache size.
- replaces calls to kmem_cache_zalloc() by kmem_cache_alloc()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/pgtable.h |  2 +-
 arch/powerpc/mm/hugetlbpage.c      |  6 ++---
 arch/powerpc/mm/init-common.c      | 46 ++++++++++++++++++++++++++------------
 3 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 14c79a7dc855..1e6265dc6697 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -72,7 +72,7 @@ extern int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 /* can we use this in kvm */
 unsigned long vmalloc_to_phys(void *vmalloc_addr);
 
-void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
+void pgtable_cache_add(unsigned int shift);
 void pgtable_cache_init(void);
 
 #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_PPC32)
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 53b7a605c3a8..6cd90445b1f5 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -71,7 +71,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 		num_hugepd = 1;
 	}
 
-	new = kmem_cache_zalloc(cachep, pgtable_gfp_flags(mm, GFP_KERNEL));
+	new = kmem_cache_alloc(cachep, pgtable_gfp_flags(mm, GFP_KERNEL));
 
 	BUG_ON(pshift > HUGEPD_SHIFT_MASK);
 	BUG_ON((unsigned long)new & HUGEPD_SHIFT_MASK);
@@ -702,10 +702,10 @@ static int __init hugetlbpage_init(void)
 		 * use pgt cache for hugepd.
 		 */
 		if (pdshift > shift)
-			pgtable_cache_add(pdshift - shift, NULL);
+			pgtable_cache_add(pdshift - shift);
 #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_8xx)
 		else
-			pgtable_cache_add(PTE_T_ORDER, NULL);
+			pgtable_cache_add(PTE_T_ORDER);
 #endif
 	}
 
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 41190f2b60c2..b7ca03643d0b 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -25,19 +25,37 @@
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 
-static void pgd_ctor(void *addr)
-{
-	memset(addr, 0, PGD_TABLE_SIZE);
+#define CTOR(shift) static void ctor_##shift(void *addr) \
+{							\
+	memset(addr, 0, sizeof(void *) << (shift));	\
 }
 
-static void pud_ctor(void *addr)
-{
-	memset(addr, 0, PUD_TABLE_SIZE);
-}
+CTOR(0); CTOR(1); CTOR(2); CTOR(3); CTOR(4); CTOR(5); CTOR(6); CTOR(7);
+CTOR(8); CTOR(9); CTOR(10); CTOR(11); CTOR(12); CTOR(13); CTOR(14); CTOR(15);
 
-static void pmd_ctor(void *addr)
+static inline void (*ctor(int shift))(void *)
 {
-	memset(addr, 0, PMD_TABLE_SIZE);
+	BUILD_BUG_ON(MAX_PGTABLE_INDEX_SIZE != 15);
+
+	switch (shift) {
+	case 0: return ctor_0;
+	case 1: return ctor_1;
+	case 2: return ctor_2;
+	case 3: return ctor_3;
+	case 4: return ctor_4;
+	case 5: return ctor_5;
+	case 6: return ctor_6;
+	case 7: return ctor_7;
+	case 8: return ctor_8;
+	case 9: return ctor_9;
+	case 10: return ctor_10;
+	case 11: return ctor_11;
+	case 12: return ctor_12;
+	case 13: return ctor_13;
+	case 14: return ctor_14;
+	case 15: return ctor_15;
+	}
+	return NULL;
 }
 
 struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE + 1];
@@ -50,7 +68,7 @@ EXPORT_SYMBOL_GPL(pgtable_cache);	/* used by kvm_hv module */
  * everything else.  Caches created by this function are used for all
  * the higher level pagetables, and for hugepage pagetables.
  */
-void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
+void pgtable_cache_add(unsigned int shift)
 {
 	char *name;
 	unsigned long table_size = sizeof(void *) << shift;
@@ -78,7 +96,7 @@ void pgtable_cache_add(unsigned shift, void (*ctor)(void *))
 
 	align = max_t(unsigned long, align, minalign);
 	name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
-	new = kmem_cache_create(name, table_size, align, 0, ctor);
+	new = kmem_cache_create(name, table_size, align, 0, ctor(shift));
 	if (!new)
 		panic("Could not allocate pgtable cache for order %d", shift);
 
@@ -91,15 +109,15 @@ EXPORT_SYMBOL_GPL(pgtable_cache_add);	/* used by kvm_hv module */
 
 void pgtable_cache_init(void)
 {
-	pgtable_cache_add(PGD_INDEX_SIZE, pgd_ctor);
+	pgtable_cache_add(PGD_INDEX_SIZE);
 
 	if (PMD_CACHE_INDEX && !PGT_CACHE(PMD_CACHE_INDEX))
-		pgtable_cache_add(PMD_CACHE_INDEX, pmd_ctor);
+		pgtable_cache_add(PMD_CACHE_INDEX);
 	/*
 	 * In all current configs, when the PUD index exists it's the
 	 * same size as either the pgd or pmd index except with THP enabled
 	 * on book3s 64
 	 */
 	if (PUD_CACHE_INDEX && !PGT_CACHE(PUD_CACHE_INDEX))
-		pgtable_cache_add(PUD_CACHE_INDEX, pud_ctor);
+		pgtable_cache_add(PUD_CACHE_INDEX);
 }
-- 
2.13.3

