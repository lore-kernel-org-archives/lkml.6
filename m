Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBA0C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB64520661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB64520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeLIV6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:58:21 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36200 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726746AbeLIVzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:39 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW730-0002iY-J6; Sun, 09 Dec 2018 21:55:35 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72h-0003YT-AB; Sun, 09 Dec 2018 21:55:15 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Nadav Amit" <namit@vmware.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Sean Christopherson" <sean.j.christopherson@intel.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "Andy Lutomirski" <luto@kernel.org>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.685418412@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 226/328] x86/mm: Use WRITE_ONCE() when setting PTEs
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nadav Amit <namit@vmware.com>

commit 9bc4f28af75a91aea0ae383f50b0a430c4509303 upstream.

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

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20180902181451.80520-1-namit@vmware.com
[bwh: Backported to 3.16:
 - Use ACCESS_ONCE() instead of WRITE_ONCE()
 - Drop changes in pmdp_establish(), native_set_p4d(), pudp_set_access_flags()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -44,15 +44,15 @@ struct mm_struct;
 void set_pte_vaddr_pud(pud_t *pud_page, unsigned long vaddr, pte_t new_pte);
 
 
-static inline void native_pte_clear(struct mm_struct *mm, unsigned long addr,
-				    pte_t *ptep)
+static inline void native_set_pte(pte_t *ptep, pte_t pte)
 {
-	*ptep = native_make_pte(0);
+	ACCESS_ONCE(*ptep) = pte;
 }
 
-static inline void native_set_pte(pte_t *ptep, pte_t pte)
+static inline void native_pte_clear(struct mm_struct *mm, unsigned long addr,
+				    pte_t *ptep)
 {
-	*ptep = pte;
+	native_set_pte(ptep, native_make_pte(0));
 }
 
 static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
@@ -62,7 +62,7 @@ static inline void native_set_pte_atomic
 
 static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
-	*pmdp = pmd;
+	ACCESS_ONCE(*pmdp) = pmd;
 }
 
 static inline void native_pmd_clear(pmd_t *pmd)
@@ -98,7 +98,7 @@ static inline pmd_t native_pmdp_get_and_
 
 static inline void native_set_pud(pud_t *pudp, pud_t pud)
 {
-	*pudp = pud;
+	ACCESS_ONCE(*pudp) = pud;
 }
 
 static inline void native_pud_clear(pud_t *pud)
@@ -131,7 +131,7 @@ static inline pgd_t *native_get_shadow_p
 
 static inline void native_set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-	*pgdp = kaiser_set_shadow_pgd(pgdp, pgd);
+	ACCESS_ONCE(*pgdp) = kaiser_set_shadow_pgd(pgdp, pgd);
 }
 
 static inline void native_pgd_clear(pgd_t *pgd)
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -242,7 +242,7 @@ static void pgd_mop_up_pmds(struct mm_st
 		if (pgd_val(pgd) != 0) {
 			pmd_t *pmd = (pmd_t *)pgd_page_vaddr(pgd);
 
-			pgdp[i] = native_make_pgd(0);
+			pgd_clear(&pgdp[i]);
 
 			paravirt_release_pmd(pgd_val(pgd) >> PAGE_SHIFT);
 			pmd_free(mm, pmd);
@@ -352,7 +352,7 @@ int ptep_set_access_flags(struct vm_area
 	int changed = !pte_same(*ptep, entry);
 
 	if (changed && dirty) {
-		*ptep = entry;
+		set_pte(ptep, entry);
 		pte_update_defer(vma->vm_mm, address, ptep);
 	}
 
@@ -369,7 +369,7 @@ int pmdp_set_access_flags(struct vm_area
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
 
 	if (changed && dirty) {
-		*pmdp = entry;
+		set_pmd(pmdp, entry);
 		pmd_update_defer(vma->vm_mm, address, pmdp);
 		/*
 		 * We had a write-protection fault here and changed the pmd

