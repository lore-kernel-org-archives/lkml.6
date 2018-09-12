Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AADEECDFC1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050A820833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050A820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbeILVDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:03:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:37626 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbeILVDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:03:46 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 429RK81Yz4z9ttRr;
        Wed, 12 Sep 2018 17:58:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bvOq5wKLRcAz; Wed, 12 Sep 2018 17:58:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 429RK811tDz9ttBm;
        Wed, 12 Sep 2018 17:58:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D528B8B858;
        Wed, 12 Sep 2018 17:58:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7vdQ5jmtVEqX; Wed, 12 Sep 2018 17:58:35 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8C0D88B874;
        Wed, 12 Sep 2018 17:58:34 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4F08671913; Wed, 12 Sep 2018 15:58:34 +0000 (UTC)
Message-Id: <17146789b06ae4c33fb694a6bc45b4413b1a3c01.1536692743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1536692743.git.christophe.leroy@c-s.fr>
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 10/24] powerpc/mm: add pte helpers to query and change pte
 flags
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
Date:   Wed, 12 Sep 2018 15:58:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to avoid using generic _PAGE_XXX flags in powerpc
core functions, define helpers for all needed flags:
- pte_mkuser() and pte_mkprivileged() to set/unset and/or
unset/set _PAGE_USER and/or _PAGE_PRIVILEGED
- pte_hashpte() to check if _PAGE_HASHPTE is set.
- pte_ci() check if cache is inhibited (already existing on book3s/64)
- pte_exprotect() to protect against execution
- pte_exec() and pte_mkexec() to query and set page execution
- pte_mkpte() to set _PAGE_PTE flag.

On book3s/32 there is no exec protection, so pte_mkexec() and
pte_exprotect() are nops and pte_exec() returns always true.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 36 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 30 +++++++++++++++++++++++
 arch/powerpc/include/asm/nohash/32/pgtable.h |  5 ++++
 arch/powerpc/include/asm/nohash/64/pgtable.h |  5 ++++
 arch/powerpc/include/asm/nohash/pgtable.h    | 23 ++++++++++++++++++
 5 files changed, 99 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 3127cc529aa1..24ed0f45d92f 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -301,6 +301,7 @@ static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DIRTY);
 static inline int pte_young(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_ACCESSED); }
 static inline int pte_special(pte_t pte)	{ return !!(pte_val(pte) & _PAGE_SPECIAL); }
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
+static inline bool pte_exec(pte_t pte)		{ return true; }
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
 static inline int pte_present(pte_t pte)
@@ -308,6 +309,16 @@ static inline int pte_present(pte_t pte)
 	return pte_val(pte) & _PAGE_PRESENT;
 }
 
+static inline bool pte_hashpte(pte_t pte)
+{
+	return !!(pte_val(pte) & _PAGE_HASHPTE);
+}
+
+static inline bool pte_ci(pte_t pte)
+{
+	return !!(pte_val(pte) & _PAGE_NO_CACHE);
+}
+
 /*
  * We only find page table entry in the last level
  * Hence no need for other accessors
@@ -354,6 +365,11 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_RW);
 }
 
+static inline pte_t pte_exprotect(pte_t pte)
+{
+	return pte;
+}
+
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~_PAGE_DIRTY);
@@ -364,6 +380,16 @@ static inline pte_t pte_mkold(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
 }
 
+static inline pte_t pte_mkexec(pte_t pte)
+{
+	return pte;
+}
+
+static inline pte_t pte_mkpte(pte_t pte)
+{
+	return pte;
+}
+
 static inline pte_t pte_mkwrite(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_RW);
@@ -389,6 +415,16 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return pte;
 }
 
+static inline pte_t pte_mkprivileged(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_USER);
+}
+
+static inline pte_t pte_mkuser(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_USER);
+}
+
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 91999cd2deb9..56eddd79ab7d 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -519,6 +519,11 @@ static inline int pte_special(pte_t pte)
 	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_SPECIAL));
 }
 
+static inline bool pte_exec(pte_t pte)
+{
+	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_EXEC));
+}
+
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
@@ -646,6 +651,11 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_WRITE);
 }
 
+static inline pte_t pte_exprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_EXEC);
+}
+
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~_PAGE_DIRTY);
@@ -656,6 +666,16 @@ static inline pte_t pte_mkold(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
 }
 
+static inline pte_t pte_mkexec(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_EXEC);
+}
+
+static inline pte_t pte_mkpte(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_PTE);
+}
+
 static inline pte_t pte_mkwrite(pte_t pte)
 {
 	/*
@@ -689,6 +709,16 @@ static inline pte_t pte_mkdevmap(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_SPECIAL|_PAGE_DEVMAP);
 }
 
+static inline pte_t pte_mkprivileged(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_PRIVILEGED);
+}
+
+static inline pte_t pte_mkuser(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_PRIVILEGED);
+}
+
 /*
  * This is potentially called with a pmd as the argument, in which case it's not
  * safe to check _PAGE_DEVMAP unless we also confirm that _PAGE_PTE is set.
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 4373f8c44b6d..6fecfd7854f5 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -164,6 +164,11 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return __pte(ptev);
 }
 
+static inline pte_t pte_mkexec(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_EXEC);
+}
+
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
 #define	pmd_present(pmd)	(pmd_val(pmd) & _PMD_PRESENT_MASK)
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 72dac522aa66..b7d65d4b61be 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -114,6 +114,11 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_RW);
 }
 
+static inline pte_t pte_mkexec(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_EXEC);
+}
+
 #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
 #define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index c746e9e784cd..f87cf446b01d 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -19,6 +19,9 @@ static inline int pte_read(pte_t pte)		{ return 1; }
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) & _PAGE_DIRTY; }
 static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL; }
 static inline int pte_none(pte_t pte)		{ return (pte_val(pte) & ~_PTE_NONE_MASK) == 0; }
+static inline bool pte_hashpte(pte_t pte)	{ return false; }
+static inline bool pte_ci(pte_t pte)		{ return pte_val(pte) & _PAGE_NO_CACHE; }
+static inline bool pte_exec(pte_t pte)		{ return pte_val(pte) & _PAGE_EXEC; }
 static inline pgprot_t pte_pgprot(pte_t pte)	{ return __pgprot(pte_val(pte) & PAGE_PROT_BITS); }
 
 #ifdef CONFIG_NUMA_BALANCING
@@ -77,6 +80,11 @@ static inline unsigned long pte_pfn(pte_t pte)	{
 	return pte_val(pte) >> PTE_RPN_SHIFT; }
 
 /* Generic modifiers for PTE bits */
+static inline pte_t pte_exprotect(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_EXEC);
+}
+
 static inline pte_t pte_mkclean(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~(_PAGE_DIRTY | _PAGE_HWWRITE));
@@ -87,6 +95,11 @@ static inline pte_t pte_mkold(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
 }
 
+static inline pte_t pte_mkpte(pte_t pte)
+{
+	return pte;
+}
+
 static inline pte_t pte_mkspecial(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_SPECIAL);
@@ -97,6 +110,16 @@ static inline pte_t pte_mkhuge(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_HUGE);
 }
 
+static inline pte_t pte_mkprivileged(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~_PAGE_USER) | _PAGE_PRIVILEGED);
+}
+
+static inline pte_t pte_mkuser(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~_PAGE_PRIVILEGED) | _PAGE_USER);
+}
+
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
-- 
2.13.3

