Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD23ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6B12075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="MQeYqHm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6B12075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbeGRKSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:18:45 -0400
Received: from 8bytes.org ([81.169.241.247]:54154 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731770AbeGRKSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:18:44 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CCCB030A3; Wed, 18 Jul 2018 11:41:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531906886; bh=Qt4WJIUNKjNS+KFm8L8zxdc5EMEUEsXHmc/2ItzWZCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQeYqHm6YtGx7nzeUBUiB6cEIv8PdHmmUFC5m06ryB1d8b3mP7OCRwCBEOI4HXsAj
         RkKoDFDW3FiZiV+6pPMZKOM6oCzIjZdZdueyFXzjoE9UX7SwDu/lrgUB2wA7Q4OT1B
         nTDc3F2hI73J6RQ8FHDf7BRj4uV8POZZW9i/Ol3R+lkA1PCmhm91DXewIHnyxZPlgV
         z3aVI/GDoir4v+nkl58fXo17J21spXFyPrQRSz1k8BBuIEUGZ9OWex7aczyhAJrC+Y
         IEwwRigo76Hjc46pJSco2QrdAoSZtqbQJWHSmVnZRATeXyXRdyR+skAdiTA+Y3cv5d
         YPO9w7AX2IHtg==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, joro@8bytes.org
Subject: [PATCH 32/39] x86/pgtable/pae: Use separate kernel PMDs for user page-table
Date:   Wed, 18 Jul 2018 11:41:09 +0200
Message-Id: <1531906876-13451-33-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531906876-13451-1-git-send-email-joro@8bytes.org>
References: <1531906876-13451-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

We need separate kernel PMDs in the user page-table when PTI
is enabled to map the per-process LDT for user-space.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/pgtable.c | 100 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 81 insertions(+), 19 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index db6fb77..8e4e63d 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -182,6 +182,14 @@ static void pgd_dtor(pgd_t *pgd)
  */
 #define PREALLOCATED_PMDS	UNSHARED_PTRS_PER_PGD
 
+/*
+ * We allocate separate PMDs for the kernel part of the user page-table
+ * when PTI is enabled. We need them to map the per-process LDT into the
+ * user-space page-table.
+ */
+#define PREALLOCATED_USER_PMDS	 (static_cpu_has(X86_FEATURE_PTI) ? \
+					KERNEL_PGD_PTRS : 0)
+
 void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
 {
 	paravirt_alloc_pmd(mm, __pa(pmd) >> PAGE_SHIFT);
@@ -202,14 +210,14 @@ void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
 
 /* No need to prepopulate any pagetable entries in non-PAE modes. */
 #define PREALLOCATED_PMDS	0
-
+#define PREALLOCATED_USER_PMDS	 0
 #endif	/* CONFIG_X86_PAE */
 
-static void free_pmds(struct mm_struct *mm, pmd_t *pmds[])
+static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 {
 	int i;
 
-	for(i = 0; i < PREALLOCATED_PMDS; i++)
+	for (i = 0; i < count; i++)
 		if (pmds[i]) {
 			pgtable_pmd_page_dtor(virt_to_page(pmds[i]));
 			free_page((unsigned long)pmds[i]);
@@ -217,7 +225,7 @@ static void free_pmds(struct mm_struct *mm, pmd_t *pmds[])
 		}
 }
 
-static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[])
+static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 {
 	int i;
 	bool failed = false;
@@ -226,7 +234,7 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[])
 	if (mm == &init_mm)
 		gfp &= ~__GFP_ACCOUNT;
 
-	for(i = 0; i < PREALLOCATED_PMDS; i++) {
+	for (i = 0; i < count; i++) {
 		pmd_t *pmd = (pmd_t *)__get_free_page(gfp);
 		if (!pmd)
 			failed = true;
@@ -241,7 +249,7 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[])
 	}
 
 	if (failed) {
-		free_pmds(mm, pmds);
+		free_pmds(mm, pmds, count);
 		return -ENOMEM;
 	}
 
@@ -254,23 +262,38 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[])
  * preallocate which never got a corresponding vma will need to be
  * freed manually.
  */
+static void mop_up_one_pmd(struct mm_struct *mm, pgd_t *pgdp)
+{
+	pgd_t pgd = *pgdp;
+
+	if (pgd_val(pgd) != 0) {
+		pmd_t *pmd = (pmd_t *)pgd_page_vaddr(pgd);
+
+		*pgdp = native_make_pgd(0);
+
+		paravirt_release_pmd(pgd_val(pgd) >> PAGE_SHIFT);
+		pmd_free(mm, pmd);
+		mm_dec_nr_pmds(mm);
+	}
+}
+
 static void pgd_mop_up_pmds(struct mm_struct *mm, pgd_t *pgdp)
 {
 	int i;
 
-	for(i = 0; i < PREALLOCATED_PMDS; i++) {
-		pgd_t pgd = pgdp[i];
+	for (i = 0; i < PREALLOCATED_PMDS; i++)
+		mop_up_one_pmd(mm, &pgdp[i]);
 
-		if (pgd_val(pgd) != 0) {
-			pmd_t *pmd = (pmd_t *)pgd_page_vaddr(pgd);
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
 
-			pgdp[i] = native_make_pgd(0);
+	if (!static_cpu_has(X86_FEATURE_PTI))
+		return;
 
-			paravirt_release_pmd(pgd_val(pgd) >> PAGE_SHIFT);
-			pmd_free(mm, pmd);
-			mm_dec_nr_pmds(mm);
-		}
-	}
+	pgdp = kernel_to_user_pgdp(pgdp);
+
+	for (i = 0; i < PREALLOCATED_USER_PMDS; i++)
+		mop_up_one_pmd(mm, &pgdp[i + KERNEL_PGD_BOUNDARY]);
+#endif
 }
 
 static void pgd_prepopulate_pmd(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmds[])
@@ -296,6 +319,38 @@ static void pgd_prepopulate_pmd(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmds[])
 	}
 }
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+static void pgd_prepopulate_user_pmd(struct mm_struct *mm,
+				     pgd_t *k_pgd, pmd_t *pmds[])
+{
+	pgd_t *s_pgd = kernel_to_user_pgdp(swapper_pg_dir);
+	pgd_t *u_pgd = kernel_to_user_pgdp(k_pgd);
+	p4d_t *u_p4d;
+	pud_t *u_pud;
+	int i;
+
+	u_p4d = p4d_offset(u_pgd, 0);
+	u_pud = pud_offset(u_p4d, 0);
+
+	s_pgd += KERNEL_PGD_BOUNDARY;
+	u_pud += KERNEL_PGD_BOUNDARY;
+
+	for (i = 0; i < PREALLOCATED_USER_PMDS; i++, u_pud++, s_pgd++) {
+		pmd_t *pmd = pmds[i];
+
+		memcpy(pmd, (pmd_t *)pgd_page_vaddr(*s_pgd),
+		       sizeof(pmd_t) * PTRS_PER_PMD);
+
+		pud_populate(mm, u_pud, pmd);
+	}
+
+}
+#else
+static void pgd_prepopulate_user_pmd(struct mm_struct *mm,
+				     pgd_t *k_pgd, pmd_t *pmds[])
+{
+}
+#endif
 /*
  * Xen paravirt assumes pgd table should be in one page. 64 bit kernel also
  * assumes that pgd should be in one page.
@@ -376,6 +431,7 @@ static inline void _pgd_free(pgd_t *pgd)
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd;
+	pmd_t *u_pmds[PREALLOCATED_USER_PMDS];
 	pmd_t *pmds[PREALLOCATED_PMDS];
 
 	pgd = _pgd_alloc();
@@ -385,12 +441,15 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 
 	mm->pgd = pgd;
 
-	if (preallocate_pmds(mm, pmds) != 0)
+	if (preallocate_pmds(mm, pmds, PREALLOCATED_PMDS) != 0)
 		goto out_free_pgd;
 
-	if (paravirt_pgd_alloc(mm) != 0)
+	if (preallocate_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS) != 0)
 		goto out_free_pmds;
 
+	if (paravirt_pgd_alloc(mm) != 0)
+		goto out_free_user_pmds;
+
 	/*
 	 * Make sure that pre-populating the pmds is atomic with
 	 * respect to anything walking the pgd_list, so that they
@@ -400,13 +459,16 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 
 	pgd_ctor(mm, pgd);
 	pgd_prepopulate_pmd(mm, pgd, pmds);
+	pgd_prepopulate_user_pmd(mm, pgd, u_pmds);
 
 	spin_unlock(&pgd_lock);
 
 	return pgd;
 
+out_free_user_pmds:
+	free_pmds(mm, u_pmds, PREALLOCATED_USER_PMDS);
 out_free_pmds:
-	free_pmds(mm, pmds);
+	free_pmds(mm, pmds, PREALLOCATED_PMDS);
 out_free_pgd:
 	_pgd_free(pgd);
 out:
-- 
2.7.4

