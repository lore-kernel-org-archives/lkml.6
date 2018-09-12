Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B3FC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1888820833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1888820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbeILVEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:04:16 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:41708 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbeILVEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:04:16 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 429RKh5DTNz9ttS5;
        Wed, 12 Sep 2018 17:59:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Q4an7fNBZyjP; Wed, 12 Sep 2018 17:59:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 429RKh4Pf2z9ttRt;
        Wed, 12 Sep 2018 17:59:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D15938B86F;
        Wed, 12 Sep 2018 17:59:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UaJq9qQK2wyb; Wed, 12 Sep 2018 17:59:03 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5B18D8B858;
        Wed, 12 Sep 2018 17:59:03 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DFFDF71913; Wed, 12 Sep 2018 15:59:02 +0000 (UTC)
Message-Id: <0c68d8973a7bc88840a08df5707dd7c8c7116650.1536692743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1536692743.git.christophe.leroy@c-s.fr>
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 24/24] powerpc/book3s64: Avoid multiple endian conversion
 in pte helpers
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
Date:   Wed, 12 Sep 2018 15:59:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the same spirit as already done in pte query helpers,
this patch changes pte setting helpers to perform endian
conversions on the constants rather than on the pte value.

In the meantime, it changes pte_access_permitted() to use
pte helpers for the same reason.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 71 +++++++++++++---------------
 1 file changed, 32 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 6799bc02cb22..7e29bda0944e 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -506,12 +506,12 @@ static inline bool pte_soft_dirty(pte_t pte)
 
 static inline pte_t pte_mksoft_dirty(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_SOFT_DIRTY);
+	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_SOFT_DIRTY));
 }
 
 static inline pte_t pte_clear_soft_dirty(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~_PAGE_SOFT_DIRTY);
+	return __pte_raw(pte_raw(pte) & cpu_to_be64(~_PAGE_SOFT_DIRTY));
 }
 #endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
 
@@ -532,7 +532,7 @@ static inline pte_t pte_mk_savedwrite(pte_t pte)
 	 */
 	VM_BUG_ON((pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_RWX | _PAGE_PRIVILEGED)) !=
 		  cpu_to_be64(_PAGE_PRESENT | _PAGE_PRIVILEGED));
-	return __pte(pte_val(pte) & ~_PAGE_PRIVILEGED);
+	return __pte_raw(pte_raw(pte) & cpu_to_be64(~_PAGE_PRIVILEGED));
 }
 
 #define pte_clear_savedwrite pte_clear_savedwrite
@@ -542,14 +542,14 @@ static inline pte_t pte_clear_savedwrite(pte_t pte)
 	 * Used by KSM subsystem to make a protnone pte readonly.
 	 */
 	VM_BUG_ON(!pte_protnone(pte));
-	return __pte(pte_val(pte) | _PAGE_PRIVILEGED);
+	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_PRIVILEGED));
 }
 #else
 #define pte_clear_savedwrite pte_clear_savedwrite
 static inline pte_t pte_clear_savedwrite(pte_t pte)
 {
 	VM_WARN_ON(1);
-	return __pte(pte_val(pte) & ~_PAGE_WRITE);
+	return __pte_raw(pte_raw(pte) & cpu_to_be64(~_PAGE_WRITE));
 }
 #endif /* CONFIG_NUMA_BALANCING */
 
@@ -573,25 +573,22 @@ static inline bool arch_pte_access_permitted(u64 pte, bool write, bool execute)
 }
 #endif /* CONFIG_PPC_MEM_KEYS */
 
+static inline bool pte_user(pte_t pte)
+{
+	return !(pte_raw(pte) & cpu_to_be64(_PAGE_PRIVILEGED));
+}
+
 #define pte_access_permitted pte_access_permitted
 static inline bool pte_access_permitted(pte_t pte, bool write)
 {
-	unsigned long pteval = pte_val(pte);
-	/* Also check for pte_user */
-	unsigned long clear_pte_bits = _PAGE_PRIVILEGED;
 	/*
 	 * _PAGE_READ is needed for any access and will be
 	 * cleared for PROT_NONE
 	 */
-	unsigned long need_pte_bits = _PAGE_PRESENT | _PAGE_READ;
-
-	if (write)
-		need_pte_bits |= _PAGE_WRITE;
-
-	if ((pteval & need_pte_bits) != need_pte_bits)
+	if (!pte_present(pte) || !pte_user(pte) || !pte_read(pte))
 		return false;
 
-	if ((pteval & clear_pte_bits) == clear_pte_bits)
+	if (write && !pte_write(pte))
 		return false;
 
 	return arch_pte_access_permitted(pte_val(pte), write, 0);
@@ -620,32 +617,32 @@ static inline pte_t pte_wrprotect(pte_t pte)
 {
 	if (unlikely(pte_savedwrite(pte)))
 		return pte_clear_savedwrite(pte);
-	return __pte(pte_val(pte) & ~_PAGE_WRITE);
+	return __pte_raw(pte_raw(pte) & cpu_to_be64(~_PAGE_WRITE));
 }
 
 static inline pte_t pte_exprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~_PAGE_EXEC);
+	return __pte_raw(pte_raw(pte) & cpu_to_be64(~_PAGE_EXEC));
 }
 
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~_PAGE_DIRTY);
+	return __pte_raw(pte_raw(pte) & cpu_to_be64(~_PAGE_DIRTY));
 }
 
 static inline pte_t pte_mkold(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~_PAGE_ACCESSED);
+	return __pte_raw(pte_raw(pte) & cpu_to_be64(~_PAGE_ACCESSED));
 }
 
 static inline pte_t pte_mkexec(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_EXEC);
+	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_EXEC));
 }
 
 static inline pte_t pte_mkpte(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_PTE);
+	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_PTE));
 }
 
 static inline pte_t pte_mkwrite(pte_t pte)
@@ -653,22 +650,22 @@ static inline pte_t pte_mkwrite(pte_t pte)
 	/*
 	 * write implies read, hence set both
 	 */
-	return __pte(pte_val(pte) | _PAGE_RW);
+	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_RW));
 }
 
 static inline pte_t pte_mkdirty(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_DIRTY | _PAGE_SOFT_DIRTY);
+	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_DIRTY | _PAGE_SOFT_DIRTY));
 }
 
 static inline pte_t pte_mkyoung(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_ACCESSED);
+	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_ACCESSED));
 }
 
 static inline pte_t pte_mkspecial(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_SPECIAL);
+	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_SPECIAL));
 }
 
 static inline pte_t pte_mkhuge(pte_t pte)
@@ -678,17 +675,17 @@ static inline pte_t pte_mkhuge(pte_t pte)
 
 static inline pte_t pte_mkdevmap(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_SPECIAL|_PAGE_DEVMAP);
+	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_SPECIAL | _PAGE_DEVMAP));
 }
 
 static inline pte_t pte_mkprivileged(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_PRIVILEGED);
+	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_PRIVILEGED));
 }
 
 static inline pte_t pte_mkuser(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~_PAGE_PRIVILEGED);
+	return __pte_raw(pte_raw(pte) & cpu_to_be64(~_PAGE_PRIVILEGED));
 }
 
 /*
@@ -707,12 +704,8 @@ static inline int pte_devmap(pte_t pte)
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
 	/* FIXME!! check whether this need to be a conditional */
-	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
-}
-
-static inline bool pte_user(pte_t pte)
-{
-	return !(pte_raw(pte) & cpu_to_be64(_PAGE_PRIVILEGED));
+	return __pte_raw((pte_raw(pte) & cpu_to_be64(_PAGE_CHG_MASK)) |
+			 cpu_to_be64(pgprot_val(newprot)));
 }
 
 /* Encode and de-code a swap entry */
@@ -753,7 +746,7 @@ static inline bool pte_user(pte_t pte)
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
 {
-	return __pte(pte_val(pte) | _PAGE_SWP_SOFT_DIRTY);
+	return __pte_raw(pte_raw(pte) | cpu_to_be64(_PAGE_SWP_SOFT_DIRTY));
 }
 
 static inline bool pte_swp_soft_dirty(pte_t pte)
@@ -763,7 +756,7 @@ static inline bool pte_swp_soft_dirty(pte_t pte)
 
 static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~_PAGE_SWP_SOFT_DIRTY);
+	return __pte_raw(pte_raw(pte) & cpu_to_be64(~_PAGE_SWP_SOFT_DIRTY));
 }
 #endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
 
@@ -852,10 +845,10 @@ static inline pgprot_t pgprot_writecombine(pgprot_t prot)
  */
 static inline bool pte_ci(pte_t pte)
 {
-	unsigned long pte_v = pte_val(pte);
+	unsigned long pte_v = pte_raw(pte);
 
-	if (((pte_v & _PAGE_CACHE_CTL) == _PAGE_TOLERANT) ||
-	    ((pte_v & _PAGE_CACHE_CTL) == _PAGE_NON_IDEMPOTENT))
+	if (((pte_v & cpu_to_be64(_PAGE_CACHE_CTL)) == cpu_to_be64(_PAGE_TOLERANT)) ||
+	    ((pte_v & cpu_to_be64(_PAGE_CACHE_CTL)) == cpu_to_be64(_PAGE_NON_IDEMPOTENT)))
 		return true;
 	return false;
 }
-- 
2.13.3

