Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F17C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E152077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E152077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeIERHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:07:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15790 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbeIERHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:07:06 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42539l5ktPz9tvSl;
        Wed,  5 Sep 2018 14:36:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5AF0ehUhShNW; Wed,  5 Sep 2018 14:36:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42539l5FGYz9tvSC;
        Wed,  5 Sep 2018 14:36:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D96E28B82B;
        Wed,  5 Sep 2018 14:36:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id U79OuZ0_bWSl; Wed,  5 Sep 2018 14:36:59 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A80DE8B762;
        Wed,  5 Sep 2018 14:36:59 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 96CB37159B; Wed,  5 Sep 2018 12:36:59 +0000 (UTC)
Message-Id: <256474e6e539263447dae1da9d373cedd8cb22de.1535913369.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1535913369.git.christophe.leroy@c-s.fr>
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 04/17] powerpc/mm: move some nohash pte helpers in
 nohash/[32:64]/pgtable.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  5 Sep 2018 12:36:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow their use in nohash/32/pgtable.h, we have to move the
following helpers in nohash/[32:64]/pgtable.h:
- pte_mkwrite()
- pte_mkdirty()
- pte_mkyoung()
- pte_wrprotect()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h | 28 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/nohash/64/pgtable.h | 20 ++++++++++++++++++++
 arch/powerpc/include/asm/nohash/pgtable.h    | 28 ----------------------------
 3 files changed, 48 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index a507a65b0866..3ee4ae5d28c3 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -136,6 +136,34 @@ extern int icache_44x_need_flush;
 #define pte_clear(mm, addr, ptep) \
 	do { pte_update(ptep, ~0, 0); } while (0)
 
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	pte_basic_t ptev;
+
+	ptev = pte_val(pte) & ~_PAGE_RO;
+	ptev |= _PAGE_RW;
+	return __pte(ptev);
+}
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_DIRTY);
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_ACCESSED);
+}
+
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	pte_basic_t ptev;
+
+	ptev = pte_val(pte) & ~(_PAGE_RW | _PAGE_HWWRITE);
+	ptev |= _PAGE_RO;
+	return __pte(ptev);
+}
+
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
 #define	pmd_present(pmd)	(pmd_val(pmd) & _PMD_PRESENT_MASK)
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 7cd6809f4d33..60d3bdd13ba1 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -94,6 +94,26 @@
 #ifndef __ASSEMBLY__
 /* pte_clear moved to later in this file */
 
+static inline pte_t pte_mkwrite(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_RW);
+}
+
+static inline pte_t pte_mkdirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_DIRTY);
+}
+
+static inline pte_t pte_mkyoung(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_ACCESSED);
+}
+
+static inline pte_t pte_wrprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_RW);
+}
+
 #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
 #define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 5b82e44c4231..c746e9e784cd 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -77,15 +77,6 @@ static inline unsigned long pte_pfn(pte_t pte)	{
 	return pte_val(pte) >> PTE_RPN_SHIFT; }
 
 /* Generic modifiers for PTE bits */
-static inline pte_t pte_wrprotect(pte_t pte)
-{
-	pte_basic_t ptev;
-
-	ptev = pte_val(pte) & ~(_PAGE_RW | _PAGE_HWWRITE);
-	ptev |= _PAGE_RO;
-	return __pte(ptev);
-}
-
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~(_PAGE_DIRTY | _PAGE_HWWRITE));
@@ -96,25 +87,6 @@ static inline pte_t pte_mkold(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
 }
 
-static inline pte_t pte_mkwrite(pte_t pte)
-{
-	pte_basic_t ptev;
-
-	ptev = pte_val(pte) & ~_PAGE_RO;
-	ptev |= _PAGE_RW;
-	return __pte(ptev);
-}
-
-static inline pte_t pte_mkdirty(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_DIRTY);
-}
-
-static inline pte_t pte_mkyoung(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_ACCESSED);
-}
-
 static inline pte_t pte_mkspecial(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_SPECIAL);
-- 
2.13.3

