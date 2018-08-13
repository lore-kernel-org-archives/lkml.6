Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3646FC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D29A621745
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29A621745
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbeHMQJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:09:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:51692 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728370AbeHMQJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:09:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41pxNW6b0pz9tvRK;
        Mon, 13 Aug 2018 15:27:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 66j03tZi-H6G; Mon, 13 Aug 2018 15:27:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41pxNW5hfcz9tvRJ;
        Mon, 13 Aug 2018 15:27:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0DCD88B7A7;
        Mon, 13 Aug 2018 15:27:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FDjt_U27idmt; Mon, 13 Aug 2018 15:27:23 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.4])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C8DA38B752;
        Mon, 13 Aug 2018 15:27:23 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C6E427125F; Mon, 13 Aug 2018 13:27:23 +0000 (UTC)
Message-Id: <1cbc8dba537393edbb6384b67cbb123431ba6a32.1534166756.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/3] powerpc/mm: fix a warning when a cache is common to PGD
 and hugepages
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 13 Aug 2018 13:27:23 +0000 (UTC)
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

As the constructors only aim at zeroing the allocated memory, this
patch fixes this issue by removing the constructors and using
kmem_cache_zalloc() instead.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h |  2 +-
 arch/powerpc/include/asm/book3s/64/pgalloc.h |  4 ++--
 arch/powerpc/include/asm/nohash/32/pgalloc.h |  2 +-
 arch/powerpc/include/asm/nohash/64/pgalloc.h |  6 +++---
 arch/powerpc/mm/init-common.c                | 21 +++------------------
 5 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 82e44b1a00ae..4c23cc1ae7a1 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -32,7 +32,7 @@ extern struct kmem_cache *pgtable_cache[];
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
+	return kmem_cache_zalloc(PGT_CACHE(PGD_INDEX_SIZE),
 			pgtable_gfp_flags(mm, GFP_KERNEL));
 }
 
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index 76234a14b97d..074359cd632a 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -81,7 +81,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	if (radix_enabled())
 		return radix__pgd_alloc(mm);
 
-	pgd = kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
+	pgd = kmem_cache_zalloc(PGT_CACHE(PGD_INDEX_SIZE),
 			       pgtable_gfp_flags(mm, GFP_KERNEL));
 	/*
 	 * Don't scan the PGD for pointers, it contains references to PUDs but
@@ -120,7 +120,7 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
 	pud_t *pud;
 
-	pud = kmem_cache_alloc(PGT_CACHE(PUD_CACHE_INDEX),
+	pud = kmem_cache_zalloc(PGT_CACHE(PUD_CACHE_INDEX),
 			       pgtable_gfp_flags(mm, GFP_KERNEL));
 	/*
 	 * Tell kmemleak to ignore the PUD, that means don't scan it for
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 8825953c225b..766cf0c90d19 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -32,7 +32,7 @@ extern struct kmem_cache *pgtable_cache[];
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
+	return kmem_cache_zalloc(PGT_CACHE(PGD_INDEX_SIZE),
 			pgtable_gfp_flags(mm, GFP_KERNEL));
 }
 
diff --git a/arch/powerpc/include/asm/nohash/64/pgalloc.h b/arch/powerpc/include/asm/nohash/64/pgalloc.h
index e2d62d033708..54ee5ac02d81 100644
--- a/arch/powerpc/include/asm/nohash/64/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/64/pgalloc.h
@@ -43,7 +43,7 @@ extern struct kmem_cache *pgtable_cache[];
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
+	return kmem_cache_zalloc(PGT_CACHE(PGD_INDEX_SIZE),
 			pgtable_gfp_flags(mm, GFP_KERNEL));
 }
 
@@ -56,7 +56,7 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(PGT_CACHE(PUD_INDEX_SIZE),
+	return kmem_cache_zalloc(PGT_CACHE(PUD_INDEX_SIZE),
 			pgtable_gfp_flags(mm, GFP_KERNEL));
 }
 
@@ -86,7 +86,7 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return kmem_cache_alloc(PGT_CACHE(PMD_CACHE_INDEX),
+	return kmem_cache_zalloc(PGT_CACHE(PMD_CACHE_INDEX),
 			pgtable_gfp_flags(mm, GFP_KERNEL));
 }
 
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 2b656e67f2ea..2ae15ff8f76f 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -25,21 +25,6 @@
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 
-static void pgd_ctor(void *addr)
-{
-	memset(addr, 0, PGD_TABLE_SIZE);
-}
-
-static void pud_ctor(void *addr)
-{
-	memset(addr, 0, PUD_TABLE_SIZE);
-}
-
-static void pmd_ctor(void *addr)
-{
-	memset(addr, 0, PMD_TABLE_SIZE);
-}
-
 struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE];
 EXPORT_SYMBOL_GPL(pgtable_cache);	/* used by kvm_hv module */
 
@@ -91,15 +76,15 @@ EXPORT_SYMBOL_GPL(pgtable_cache_add);	/* used by kvm_hv module */
 
 void pgtable_cache_init(void)
 {
-	pgtable_cache_add(PGD_INDEX_SIZE, pgd_ctor);
+	pgtable_cache_add(PGD_INDEX_SIZE, NULL);
 
 	if (PMD_CACHE_INDEX && !PGT_CACHE(PMD_CACHE_INDEX))
-		pgtable_cache_add(PMD_CACHE_INDEX, pmd_ctor);
+		pgtable_cache_add(PMD_CACHE_INDEX, NULL);
 	/*
 	 * In all current configs, when the PUD index exists it's the
 	 * same size as either the pgd or pmd index except with THP enabled
 	 * on book3s 64
 	 */
 	if (PUD_CACHE_INDEX && !PGT_CACHE(PUD_CACHE_INDEX))
-		pgtable_cache_add(PUD_CACHE_INDEX, pud_ctor);
+		pgtable_cache_add(PUD_CACHE_INDEX, NULL);
 }
-- 
2.13.3

