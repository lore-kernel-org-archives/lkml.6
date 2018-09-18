Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E4DECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004FE214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004FE214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbeIRWa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:30:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11053 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730598AbeIRWaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:30:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42F8LH3kwPz9ttKk;
        Tue, 18 Sep 2018 18:57:27 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Bu4BgWB1Jtsu; Tue, 18 Sep 2018 18:57:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42F8LH3CqYz9ttKj;
        Tue, 18 Sep 2018 18:57:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 68AA58B80C;
        Tue, 18 Sep 2018 18:57:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id jz7qoRumve0I; Tue, 18 Sep 2018 18:57:27 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A32D8B7F9;
        Tue, 18 Sep 2018 18:57:27 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D1CB57192E; Tue, 18 Sep 2018 16:57:26 +0000 (UTC)
Message-Id: <5e3275d5666938fabbae53d0ecd506f9b6e04019.1537288312.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537288312.git.christophe.leroy@c-s.fr>
References: <cover.1537288312.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 12/20] powerpc/mm: inline pte_alloc_one() and
 pte_alloc_one_kernel() in PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Sep 2018 16:57:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As in PPC64, inline pte_alloc_one() and pte_alloc_one_kernel()
in PPC32. This will allow to switch nohash/32 to pte_fragment
without impacting hash/32.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 22 ++++++++++++++++++++--
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 22 ++++++++++++++++++++--
 arch/powerpc/mm/pgtable_32.c                 | 21 ---------------------
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 96138ab3ddd6..701748132442 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -79,8 +79,26 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 #define pmd_pgtable(pmd) pmd_page(pmd)
 #endif
 
-extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
-extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+{
+	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+}
+
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	struct page *ptepage;
+
+	gfp_t flags = GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT;
+
+	ptepage = alloc_pages(flags, 0);
+	if (!ptepage)
+		return NULL;
+	if (!pgtable_page_ctor(ptepage)) {
+		__free_page(ptepage);
+		return NULL;
+	}
+	return ptepage;
+}
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index 6fbbb90043c0..f3fec9052f31 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -80,8 +80,26 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 #define pmd_pgtable(pmd) pmd_page(pmd)
 #endif
 
-extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
-extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+{
+	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+}
+
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	struct page *ptepage;
+
+	gfp_t flags = GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT;
+
+	ptepage = alloc_pages(flags, 0);
+	if (!ptepage)
+		return NULL;
+	if (!pgtable_page_ctor(ptepage)) {
+		__free_page(ptepage);
+		return NULL;
+	}
+	return ptepage;
+}
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 6c8a07624773..7900b613e6e5 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -43,27 +43,6 @@ EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
 extern char etext[], _stext[], _sinittext[], _einittext[];
 
-pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
-{
-	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-}
-
-pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
-{
-	struct page *ptepage;
-
-	gfp_t flags = GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT;
-
-	ptepage = alloc_pages(flags, 0);
-	if (!ptepage)
-		return NULL;
-	if (!pgtable_page_ctor(ptepage)) {
-		__free_page(ptepage);
-		return NULL;
-	}
-	return ptepage;
-}
-
 void __iomem *
 ioremap(phys_addr_t addr, unsigned long size)
 {
-- 
2.13.3

