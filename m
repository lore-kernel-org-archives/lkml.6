Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E246C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C3F214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C3F214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbeIRWbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:31:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:18814 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730745AbeIRWbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:31:08 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42F8LX0QSfz9ttRm;
        Tue, 18 Sep 2018 18:57:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id t9RCViiZIAsv; Tue, 18 Sep 2018 18:57:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42F8LW73glz9ttRZ;
        Tue, 18 Sep 2018 18:57:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E949F8B80B;
        Tue, 18 Sep 2018 18:57:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ulIQQ62vem9E; Tue, 18 Sep 2018 18:57:39 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C01E8B7F9;
        Tue, 18 Sep 2018 18:57:39 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 02B4F7192E; Tue, 18 Sep 2018 16:57:39 +0000 (UTC)
Message-Id: <2cbd51969f5fd6c176a51034e19a09494bcd45d0.1537288312.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537288312.git.christophe.leroy@c-s.fr>
References: <cover.1537288312.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 18/20] powerpc/mm: reintroduce 16K pages with HW assistance
 on 8xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Sep 2018 16:57:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this HW assistance implies some constraints on the
page table structure:
- Regardless of the main page size used (4k or 16k), the
level 1 table (PGD) contains 1024 entries and each PGD entry covers
a 4Mbytes area which is managed by a level 2 table (PTE) containing
also 1024 entries each describing a 4k page.
- 16k pages require 4 identifical entries in the L2 table
- 512k pages PTE have to be spread every 128 bytes in the L2 table
- 8M pages PTE are at the address pointed by the L1 entry and each
8M page require 2 identical entries in the PGD.

In order to use hardware assistance with 16K pages, this patch does
the following modifications:
- Make PGD size independent of the main page size
- In 16k pages mode, redefine pte_t as a struct with 4 elements,
and populate those 4 elements in __set_pte_at() and pte_update()
- Adapt the size of the hugepage tables.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                         |  2 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h | 19 ++++++++++++++++++-
 arch/powerpc/include/asm/nohash/pgtable.h    |  4 ++++
 arch/powerpc/include/asm/pgtable-types.h     |  4 ++++
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 33931804c46f..a80669209155 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -698,7 +698,7 @@ config PPC_4K_PAGES
 
 config PPC_16K_PAGES
 	bool "16k page size"
-	depends on 44x
+	depends on 44x || PPC_8xx
 
 config PPC_64K_PAGES
 	bool "64k page size"
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 73e2b1fbdb36..6f2b35af7a28 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -19,7 +19,14 @@ extern int icache_44x_need_flush;
 
 #endif /* __ASSEMBLY__ */
 
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
+#define PTE_INDEX_SIZE  (PTE_SHIFT - 2)
+#define PTE_FRAG_NR		4
+#define PTE_FRAG_SIZE_SHIFT	12
+#define PTE_FRAG_SIZE		(1UL << PTE_FRAG_SIZE_SHIFT)
+#else
 #define PTE_INDEX_SIZE	PTE_SHIFT
+#endif
 #define PMD_INDEX_SIZE	0
 #define PUD_INDEX_SIZE	0
 #define PGD_INDEX_SIZE	(32 - PGDIR_SHIFT)
@@ -48,7 +55,11 @@ extern int icache_44x_need_flush;
  * -Matt
  */
 /* PGDIR_SHIFT determines what a top-level page table entry can map */
+#ifdef CONFIG_PPC_8xx
+#define PGDIR_SHIFT	22
+#else
 #define PGDIR_SHIFT	(PAGE_SHIFT + PTE_INDEX_SIZE)
+#endif
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
@@ -229,7 +240,13 @@ static inline unsigned long pte_update(pte_t *p,
 	: "cc" );
 #else /* PTE_ATOMIC_UPDATES */
 	unsigned long old = pte_val(*p);
-	*p = __pte((old & ~clr) | set);
+	unsigned long new = (old & ~clr) | set;
+
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
+	p->pte = p->pte1 = p->pte2 = p->pte3 = new;
+#else
+	*p = __pte(new);
+#endif
 #endif /* !PTE_ATOMIC_UPDATES */
 
 #ifdef CONFIG_44x
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index aa968d87337b..883f69e6cdf7 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -204,7 +204,11 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	/* Anything else just stores the PTE normally. That covers all 64-bit
 	 * cases, and 32-bit non-hash with 32-bit PTEs.
 	 */
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
+	ptep->pte = ptep->pte1 = ptep->pte2 = ptep->pte3 = pte_val(pte);
+#else
 	*ptep = pte;
+#endif
 
 	/*
 	 * With hardware tablewalk, a sync is needed to ensure that
diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
index eccb30b38b47..3b0edf041b2e 100644
--- a/arch/powerpc/include/asm/pgtable-types.h
+++ b/arch/powerpc/include/asm/pgtable-types.h
@@ -3,7 +3,11 @@
 #define _ASM_POWERPC_PGTABLE_TYPES_H
 
 /* PTE level */
+#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
+typedef struct { pte_basic_t pte, pte1, pte2, pte3; } pte_t;
+#else
 typedef struct { pte_basic_t pte; } pte_t;
+#endif
 #define __pte(x)	((pte_t) { (x) })
 static inline pte_basic_t pte_val(pte_t x)
 {
-- 
2.13.3

