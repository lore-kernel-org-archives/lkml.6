Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4C9C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C8A2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C8A2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeILVDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:03:50 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63263 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbeILVDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:03:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 429RKB3w1cz9ttRv;
        Wed, 12 Sep 2018 17:58:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Hh4hPg9XHC_1; Wed, 12 Sep 2018 17:58:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 429RKB3Nntz9ttBm;
        Wed, 12 Sep 2018 17:58:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AC7038B875;
        Wed, 12 Sep 2018 17:58:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HTiUDjbN5ODP; Wed, 12 Sep 2018 17:58:38 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C53ED8B86F;
        Wed, 12 Sep 2018 17:58:36 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 54EFC71913; Wed, 12 Sep 2018 15:58:36 +0000 (UTC)
Message-Id: <4792a83ab79c6709d010ed4fec3b40242f46df33.1536692743.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1536692743.git.christophe.leroy@c-s.fr>
References: <cover.1536692743.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 11/24] powerpc/mm: don't use _PAGE_EXEC for calling
 hash_preload()
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
Date:   Wed, 12 Sep 2018 15:58:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'access' parameter of hash_preload() is either 0 or _PAGE_EXEC.
Among the two versions of hash_preload(), only the PPC64 one is
doing something with this 'access' parameter.

In order to remove the use of _PAGE_EXEC outside platform code,
'access' parameter is replaced by 'is_exec' which will be either
true of false, and the PPC64 version of hash_preload() creates
the access flag based on 'is_exec'.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/hash_utils_64.c | 3 ++-
 arch/powerpc/mm/mem.c           | 9 +++++----
 arch/powerpc/mm/mmu_decl.h      | 2 +-
 arch/powerpc/mm/pgtable_32.c    | 2 +-
 arch/powerpc/mm/ppc_mmu_32.c    | 2 +-
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index f23a89d8e4ce..b8ce0e8cc608 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1482,7 +1482,7 @@ static bool should_hash_preload(struct mm_struct *mm, unsigned long ea)
 #endif
 
 void hash_preload(struct mm_struct *mm, unsigned long ea,
-		  unsigned long access, unsigned long trap)
+		  bool is_exec, unsigned long trap)
 {
 	int hugepage_shift;
 	unsigned long vsid;
@@ -1490,6 +1490,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	pte_t *ptep;
 	unsigned long flags;
 	int rc, ssize, update_flags = 0;
+	unsigned long access = _PAGE_PRESENT | _PAGE_READ | (is_exec ? _PAGE_EXEC : 0);
 
 	BUG_ON(REGION_ID(ea) != USER_REGION_ID);
 
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 31bd9b53c358..0ba0cdb3f759 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -507,7 +507,8 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 	 * We don't need to worry about _PAGE_PRESENT here because we are
 	 * called with either mm->page_table_lock held or ptl lock held
 	 */
-	unsigned long access, trap;
+	unsigned long trap;
+	bool is_exec;
 
 	if (radix_enabled()) {
 		prefetch((void *)address);
@@ -529,16 +530,16 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 	trap = current->thread.regs ? TRAP(current->thread.regs) : 0UL;
 	switch (trap) {
 	case 0x300:
-		access = 0UL;
+		is_exec = false;
 		break;
 	case 0x400:
-		access = _PAGE_EXEC;
+		is_exec = true;
 		break;
 	default:
 		return;
 	}
 
-	hash_preload(vma->vm_mm, address, access, trap);
+	hash_preload(vma->vm_mm, address, is_exec, trap);
 #endif /* CONFIG_PPC_STD_MMU */
 #if (defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_PPC_FSL_BOOK3E)) \
 	&& defined(CONFIG_HUGETLB_PAGE)
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index e5d779eed181..dd7f9b951d25 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -82,7 +82,7 @@ static inline void _tlbivax_bcast(unsigned long address, unsigned int pid,
 #else /* CONFIG_PPC_MMU_NOHASH */
 
 extern void hash_preload(struct mm_struct *mm, unsigned long ea,
-			 unsigned long access, unsigned long trap);
+			 bool is_exec, unsigned long trap);
 
 
 extern void _tlbie(unsigned long address);
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 0bbc7b7d8a05..01f348938328 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -261,7 +261,7 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 		map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
 #ifdef CONFIG_PPC_STD_MMU_32
 		if (ktext)
-			hash_preload(&init_mm, v, 0, 0x300);
+			hash_preload(&init_mm, v, false, 0x300);
 #endif
 		v += PAGE_SIZE;
 		p += PAGE_SIZE;
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index bea6c544e38f..38a793bfca37 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -163,7 +163,7 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
  * Preload a translation in the hash table
  */
 void hash_preload(struct mm_struct *mm, unsigned long ea,
-		  unsigned long access, unsigned long trap)
+		  bool is_exec, unsigned long trap)
 {
 	pmd_t *pmd;
 
-- 
2.13.3

