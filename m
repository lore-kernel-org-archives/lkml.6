Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE898C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 18:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31E520857
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 18:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B31E520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeIBWcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 18:32:47 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:59708 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727055AbeIBWcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 18:32:46 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Sun, 2 Sep 2018 11:16:06 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id A75C140260;
        Sun,  2 Sep 2018 11:16:08 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        <x86@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Nadav Amit <namit@vmware.com>, Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86: use WRITE_ONCE() when setting PTEs
Date:   Sun, 2 Sep 2018 11:14:50 -0700
Message-ID: <20180902181451.80520-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When page-table entries are set, the compiler might optimize their
assignment by using multiple instructions to set the PTE. This might
turn into a security hazard if the user somehow manages to use the
interim PTE. L1TF does not make our lives easier, making even an interim
non-present PTE a security hazard.

Using WRITE_ONCE() to set PTEs and friends should prevent this potential
security hazard.

I skimmed the differences in the binary with and without this patch. The
differences are (obviously) greater when CONFIG_PARAVIRT=n as more
code optimizations are possible. For better and worse, the impact on the
binary with this patch is pretty small. Skimming the code did not cause
anything to jump out as a security hazard, but it seems that at least
move_soft_dirty_pte() caused set_pte_at() to use multiple writes.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>

---

rfc->v1:
* Fixed more instances of PTE settings
---
 arch/x86/include/asm/pgtable.h    |  2 +-
 arch/x86/include/asm/pgtable_64.h | 20 ++++++++++----------
 arch/x86/mm/pgtable.c             |  8 ++++----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 3de9a1fb7a9a..0e3b5917fcef 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1198,7 +1198,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 		return xchg(pmdp, pmd);
 	} else {
 		pmd_t old = *pmdp;
-		*pmdp = pmd;
+		WRITE_ONCE(*pmdp, pmd);
 		return old;
 	}
 }
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index f773d5e6c8cc..ce2b59047cb8 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -55,15 +55,15 @@ struct mm_struct;
 void set_pte_vaddr_p4d(p4d_t *p4d_page, unsigned long vaddr, pte_t new_pte);
 void set_pte_vaddr_pud(pud_t *pud_page, unsigned long vaddr, pte_t new_pte);
 
-static inline void native_pte_clear(struct mm_struct *mm, unsigned long addr,
-				    pte_t *ptep)
+static inline void native_set_pte(pte_t *ptep, pte_t pte)
 {
-	*ptep = native_make_pte(0);
+	WRITE_ONCE(*ptep, pte);
 }
 
-static inline void native_set_pte(pte_t *ptep, pte_t pte)
+static inline void native_pte_clear(struct mm_struct *mm, unsigned long addr,
+				    pte_t *ptep)
 {
-	*ptep = pte;
+	native_set_pte(ptep, native_make_pte(0));
 }
 
 static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
@@ -73,7 +73,7 @@ static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
 
 static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
-	*pmdp = pmd;
+	WRITE_ONCE(*pmdp, pmd);
 }
 
 static inline void native_pmd_clear(pmd_t *pmd)
@@ -109,7 +109,7 @@ static inline pmd_t native_pmdp_get_and_clear(pmd_t *xp)
 
 static inline void native_set_pud(pud_t *pudp, pud_t pud)
 {
-	*pudp = pud;
+	WRITE_ONCE(*pudp, pud);
 }
 
 static inline void native_pud_clear(pud_t *pud)
@@ -137,13 +137,13 @@ static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 	pgd_t pgd;
 
 	if (pgtable_l5_enabled() || !IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION)) {
-		*p4dp = p4d;
+		WRITE_ONCE(*p4dp, p4d);
 		return;
 	}
 
 	pgd = native_make_pgd(native_p4d_val(p4d));
 	pgd = pti_set_user_pgtbl((pgd_t *)p4dp, pgd);
-	*p4dp = native_make_p4d(native_pgd_val(pgd));
+	WRITE_ONCE(*p4dp, native_make_p4d(native_pgd_val(pgd)));
 }
 
 static inline void native_p4d_clear(p4d_t *p4d)
@@ -153,7 +153,7 @@ static inline void native_p4d_clear(p4d_t *p4d)
 
 static inline void native_set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-	*pgdp = pti_set_user_pgtbl(pgdp, pgd);
+	WRITE_ONCE(*pgdp, pti_set_user_pgtbl(pgdp, pgd));
 }
 
 static inline void native_pgd_clear(pgd_t *pgd)
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index e848a4811785..ae394552fb94 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -269,7 +269,7 @@ static void mop_up_one_pmd(struct mm_struct *mm, pgd_t *pgdp)
 	if (pgd_val(pgd) != 0) {
 		pmd_t *pmd = (pmd_t *)pgd_page_vaddr(pgd);
 
-		*pgdp = native_make_pgd(0);
+		pgd_clear(pgdp);
 
 		paravirt_release_pmd(pgd_val(pgd) >> PAGE_SHIFT);
 		pmd_free(mm, pmd);
@@ -494,7 +494,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 	int changed = !pte_same(*ptep, entry);
 
 	if (changed && dirty)
-		*ptep = entry;
+		set_pte(ptep, entry);
 
 	return changed;
 }
@@ -509,7 +509,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma,
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
 	if (changed && dirty) {
-		*pmdp = entry;
+		set_pmd(pmdp, entry);
 		/*
 		 * We had a write-protection fault here and changed the pmd
 		 * to to more permissive. No need to flush the TLB for that,
@@ -529,7 +529,7 @@ int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 	VM_BUG_ON(address & ~HPAGE_PUD_MASK);
 
 	if (changed && dirty) {
-		*pudp = entry;
+		set_pud(pudp, entry);
 		/*
 		 * We had a write-protection fault here and changed the pud
 		 * to to more permissive. No need to flush the TLB for that,
-- 
2.17.1

