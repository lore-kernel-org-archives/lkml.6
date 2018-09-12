Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A09C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B5720833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B5720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeILVDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:03:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:57076 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbeILVDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:03:51 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 429RKC6HHcz9ttRs;
        Wed, 12 Sep 2018 17:58:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id AfYiTCM2hv4W; Wed, 12 Sep 2018 17:58:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 429RKC5klcz9ttBm;
        Wed, 12 Sep 2018 17:58:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BCA3C8B858;
        Wed, 12 Sep 2018 17:58:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xn0qgg9pOhcl; Wed, 12 Sep 2018 17:58:39 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AA7F38B873;
        Wed, 12 Sep 2018 17:58:38 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 695C971913; Wed, 12 Sep 2018 15:58:38 +0000 (UTC)
Message-Id: <13f63620e6d21a07b48c85719793f4f0e88c894f.1536692743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1536692743.git.christophe.leroy@c-s.fr>
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 12/24] powerpc/mm: use pte helpers in generic code
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Geoff Levand <geoff@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kumar Gala <galak@kernel.crashing.org>,
        Li Yang <leoyang.li@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Date:   Wed, 12 Sep 2018 15:58:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of platform specific _PAGE_XXXX in powerpc common code and
use helpers instead.

mm/dump_linuxpagetables.c will be handled separately

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h |  9 +++------
 arch/powerpc/include/asm/nohash/32/pgtable.h | 12 ++++++++----
 arch/powerpc/include/asm/nohash/pgtable.h    |  3 +--
 arch/powerpc/mm/pgtable.c                    | 19 ++++++-------------
 arch/powerpc/mm/pgtable_32.c                 | 15 ++++++++-------
 arch/powerpc/mm/pgtable_64.c                 | 14 +++++++-------
 arch/powerpc/xmon/xmon.c                     | 12 +++++++-----
 7 files changed, 40 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 24ed0f45d92f..d4f2f396af70 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -326,17 +326,14 @@ static inline bool pte_ci(pte_t pte)
 #define pte_access_permitted pte_access_permitted
 static inline bool pte_access_permitted(pte_t pte, bool write)
 {
-	unsigned long pteval = pte_val(pte);
 	/*
 	 * A read-only access is controlled by _PAGE_USER bit.
 	 * We have _PAGE_READ set for WRITE and EXECUTE
 	 */
-	unsigned long need_pte_bits = _PAGE_PRESENT | _PAGE_USER;
-
-	if (write)
-		need_pte_bits |= _PAGE_WRITE;
+	if (!pte_present(pte) || !pte_user(pte) || !pte_read(pte))
+		return false;
 
-	if ((pteval & need_pte_bits) != need_pte_bits)
+	if (write && !pte_write(pte))
 		return false;
 
 	return true;
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 6fecfd7854f5..a4156da4a7a4 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -277,7 +277,10 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
 {
-	pte_update(ptep, (_PAGE_RW | _PAGE_HWWRITE), _PAGE_RO);
+	unsigned long clr = ~pte_val(pte_wrprotect(__pte(~0)));
+	unsigned long set = pte_val(pte_wrprotect(__pte(0)));
+
+	pte_update(ptep, clr, set);
 }
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
@@ -291,9 +294,10 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 					   unsigned long address,
 					   int psize)
 {
-	unsigned long set = pte_val(entry) &
-		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
-	unsigned long clr = ~pte_val(entry) & (_PAGE_RO | _PAGE_NA);
+	pte_t pte_set = pte_mkyoung(pte_mkdirty(pte_mkwrite(pte_mkexec(__pte(0)))));
+	pte_t pte_clr = pte_mkyoung(pte_mkdirty(pte_mkwrite(pte_mkexec(__pte(~0)))));
+	unsigned long set = pte_val(entry) & pte_val(pte_set);
+	unsigned long clr = ~pte_val(entry) & ~pte_val(pte_clr);
 
 	pte_update(ptep, clr, set);
 
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index f87cf446b01d..92def7088054 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -32,8 +32,7 @@ static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PA
  */
 static inline int pte_protnone(pte_t pte)
 {
-	return (pte_val(pte) &
-		(_PAGE_PRESENT | _PAGE_USER)) == _PAGE_PRESENT;
+	return pte_present(pte) && !pte_user(pte);
 }
 
 static inline int pmd_protnone(pmd_t pmd)
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 4f788f3762a9..8558f01ed5c8 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -44,20 +44,13 @@ static inline int is_exec_fault(void)
 static inline int pte_looks_normal(pte_t pte)
 {
 
-#if defined(CONFIG_PPC_BOOK3S_64)
-	if ((pte_val(pte) & (_PAGE_PRESENT | _PAGE_SPECIAL)) == _PAGE_PRESENT) {
+	if (pte_present(pte) && !pte_special(pte)) {
 		if (pte_ci(pte))
 			return 0;
 		if (pte_user(pte))
 			return 1;
 	}
 	return 0;
-#else
-	return (pte_val(pte) &
-		(_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE | _PAGE_USER |
-		 _PAGE_PRIVILEGED)) ==
-		(_PAGE_PRESENT | _PAGE_USER);
-#endif
 }
 
 static struct page *maybe_pte_to_page(pte_t pte)
@@ -117,7 +110,7 @@ static pte_t set_pte_filter(pte_t pte)
 	struct page *pg;
 
 	/* No exec permission in the first place, move on */
-	if (!(pte_val(pte) & _PAGE_EXEC) || !pte_looks_normal(pte))
+	if (!pte_exec(pte) || !pte_looks_normal(pte))
 		return pte;
 
 	/* If you set _PAGE_EXEC on weird pages you're on your own */
@@ -137,7 +130,7 @@ static pte_t set_pte_filter(pte_t pte)
 	}
 
 	/* Else, we filter out _PAGE_EXEC */
-	return __pte(pte_val(pte) & ~_PAGE_EXEC);
+	return pte_exprotect(pte);
 }
 
 static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
@@ -150,7 +143,7 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
 	 * if necessary. Also if _PAGE_EXEC is already set, same deal,
 	 * we just bail out
 	 */
-	if (dirty || (pte_val(pte) & _PAGE_EXEC) || !is_exec_fault())
+	if (dirty || pte_exec(pte) || !is_exec_fault())
 		return pte;
 
 #ifdef CONFIG_DEBUG_VM
@@ -176,7 +169,7 @@ static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
 	set_bit(PG_arch_1, &pg->flags);
 
  bail:
-	return __pte(pte_val(pte) | _PAGE_EXEC);
+	return pte_mkexec(pte);
 }
 
 #endif /* CONFIG_PPC_BOOK3S */
@@ -195,7 +188,7 @@ void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 	VM_WARN_ON(pte_present(*ptep) && !pte_protnone(*ptep));
 
 	/* Add the pte bit when trying to set a pte */
-	pte = __pte(pte_val(pte) | _PAGE_PTE);
+	pte = pte_mkpte(pte);
 
 	/* Note: mm->context.id might not yet have been assigned as
 	 * this context might not have been activated yet when this
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 01f348938328..5877f5aa8f5d 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -112,15 +112,17 @@ EXPORT_SYMBOL(ioremap_coherent);
 void __iomem *
 ioremap_prot(phys_addr_t addr, unsigned long size, unsigned long flags)
 {
+	pte_t pte = __pte(flags);
+
 	/* writeable implies dirty for kernel addresses */
-	if ((flags & (_PAGE_RW | _PAGE_RO)) != _PAGE_RO)
-		flags |= _PAGE_DIRTY | _PAGE_HWWRITE;
+	if (pte_write(pte))
+		pte = pte_mkdirty(pte);
 
 	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
-	flags &= ~(_PAGE_USER | _PAGE_EXEC);
-	flags |= _PAGE_PRIVILEGED;
+	pte = pte_exprotect(pte);
+	pte = pte_mkprivileged(pte);
 
-	return __ioremap_caller(addr, size, __pgprot(flags), __builtin_return_address(0));
+	return __ioremap_caller(addr, size, pte_pgprot(pte), __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap_prot);
 
@@ -235,8 +237,7 @@ int map_kernel_page(unsigned long va, phys_addr_t pa, pgprot_t prot)
 		/* The PTE should never be already set nor present in the
 		 * hash table
 		 */
-		BUG_ON((pte_val(*pg) & (_PAGE_PRESENT | _PAGE_HASHPTE)) &&
-		       pgprot_val(prot));
+		BUG_ON((pte_present(*pg) | pte_hashpte(*pg)) && pgprot_val(prot));
 		set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT, prot));
 	}
 	smp_wmb();
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 5c889445bee9..a7569358522c 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -230,23 +230,23 @@ void __iomem *ioremap_coherent(phys_addr_t addr, unsigned long size)
 void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 			     unsigned long flags)
 {
+	pte_t pte = __pte(flags);
 	void *caller = __builtin_return_address(0);
 
 	/* writeable implies dirty for kernel addresses */
-	if (flags & _PAGE_WRITE)
-		flags |= _PAGE_DIRTY;
+	if (pte_write(pte))
+		pte = pte_mkdirty(pte);
 
 	/* we don't want to let _PAGE_EXEC leak out */
-	flags &= ~_PAGE_EXEC;
+	pte = pte_exprotect(pte);
 	/*
 	 * Force kernel mapping.
 	 */
-	flags &= ~_PAGE_USER;
-	flags |= _PAGE_PRIVILEGED;
+	pte = pte_mkprivileged(pte);
 
 	if (ppc_md.ioremap)
-		return ppc_md.ioremap(addr, size, __pgprot(flags), caller);
-	return __ioremap_caller(addr, size, __pgprot(flags), caller);
+		return ppc_md.ioremap(addr, size, pte_pgprot(pte), caller);
+	return __ioremap_caller(addr, size, pte_pgprot(pte), caller);
 }
 
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 4264aedc7775..f65f2f38c441 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2988,15 +2988,17 @@ static void show_task(struct task_struct *tsk)
 #ifdef CONFIG_PPC_BOOK3S_64
 void format_pte(void *ptep, unsigned long pte)
 {
+	pte_t entry = __pte(pte);
+
 	printf("ptep @ 0x%016lx = 0x%016lx\n", (unsigned long)ptep, pte);
 	printf("Maps physical address = 0x%016lx\n", pte & PTE_RPN_MASK);
 
 	printf("Flags = %s%s%s%s%s\n",
-	       (pte & _PAGE_ACCESSED) ? "Accessed " : "",
-	       (pte & _PAGE_DIRTY)    ? "Dirty " : "",
-	       (pte & _PAGE_READ)     ? "Read " : "",
-	       (pte & _PAGE_WRITE)    ? "Write " : "",
-	       (pte & _PAGE_EXEC)     ? "Exec " : "");
+	       pte_young(entry) ? "Accessed " : "",
+	       pte_dirty(entry) ? "Dirty " : "",
+	       pte_read(entry)  ? "Read " : "",
+	       pte_write(entry) ? "Write " : "",
+	       pte_exec(entry)  ? "Exec " : "");
 }
 
 static void show_pte(unsigned long addr)
-- 
2.13.3

