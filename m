Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x2245DAHnfTxoEL2pUH7fAuDxDUenXDRUAfzaB5P2rNAsjQhKfhuufSHIeHSsXH7Jhlszb0uB
ARC-Seal: i=1; a=rsa-sha256; t=1518168366; cv=none;
        d=google.com; s=arc-20160816;
        b=oOIk9j2+cmvEXrQsaiPJaYb+++i+MTNFFdES91Wh5cvhgdPXT6eyQim/Cj/P8vP9Ko
         aggsCCdKPrWSrKQ5m6WKUgRJBgalaZTePAUbHzT+uTxP0L4PbbAZDLvNGOr4CwMMM5ci
         kppQ+DymcuNXJwCFYEgU3S2aqse4eeAGXow+iOzJz7irT1F2neKESc33PhIUbY0CYv29
         2w32Rxeb5pul4GxDIix8ER6a858UsGCao7X+ScaXfMORlfSnqM1+W5mhGuRCEBK9Oyn2
         tEGVPro7Z1biA9WYOdXTZlVWdylqdYfy25hTg2Rh3V841l4dp9lgWYPMq3XQQuSNJlzM
         tG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=kOeFMKXkH7neppHZYCDuThqU38nRGeLHl0Mw/ynSVtA=;
        b=w9j0WTiMEkGQzR9mc8sD0aYE38gdrS2uQAHwzXKCPgGo4k4/a6Kf2U5/uBngLsQNSk
         ng2FibNb5e65IZ3CI4Bc5XRjMcsqR/vXJq6AxExApLSkp5EPL36wtuxJCJFe5mWAwjbQ
         pyoZqKfLATaeVOgZ5rwqaepVAg5LHpG8hmwxLaHFR6zR/UGQWQ5f5M1oYoWrY0hOCFGo
         eGU6gf8ZiI7rJ78bffzcYRCTXg6j2KM7HhwHtaRDWMK15Jfz1Dt14LA3sjDleWPHTqpE
         JitSph+NPbS3kmQarc9soqeBgnZVmcRgDJtthLP5pW5TkFjDODLneDInVSOX3wKVfycS
         SwaA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=TJTLuSVK;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=TJTLuSVK;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at,
	hughd@google.com,
	keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 26/31] x86/pgtable/pae: Use separate kernel PMDs for user page-table
Date: Fri,  9 Feb 2018 10:25:35 +0100
Message-Id: <1518168340-9392-27-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914913044426927?=
X-GMAIL-MSGID: =?utf-8?q?1591914913044426927?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

We need separate kernel PMDs in the user page-table when PTI
is enabled to map the per-process LDT for user-space.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/pgtable.c | 100 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 81 insertions(+), 19 deletions(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index a81d42e..d95bc7b 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -177,6 +177,14 @@ static void pgd_dtor(pgd_t *pgd)
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
@@ -197,14 +205,14 @@ void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
 
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
+	for(i = 0; i < count; i++)
 		if (pmds[i]) {
 			pgtable_pmd_page_dtor(virt_to_page(pmds[i]));
 			free_page((unsigned long)pmds[i]);
@@ -212,7 +220,7 @@ static void free_pmds(struct mm_struct *mm, pmd_t *pmds[])
 		}
 }
 
-static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[])
+static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 {
 	int i;
 	bool failed = false;
@@ -221,7 +229,7 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[])
 	if (mm == &init_mm)
 		gfp &= ~__GFP_ACCOUNT;
 
-	for(i = 0; i < PREALLOCATED_PMDS; i++) {
+	for(i = 0; i < count; i++) {
 		pmd_t *pmd = (pmd_t *)__get_free_page(gfp);
 		if (!pmd)
 			failed = true;
@@ -236,7 +244,7 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[])
 	}
 
 	if (failed) {
-		free_pmds(mm, pmds);
+		free_pmds(mm, pmds, count);
 		return -ENOMEM;
 	}
 
@@ -249,23 +257,38 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[])
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
+	for(i = 0; i < PREALLOCATED_PMDS; i++)
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
@@ -291,6 +314,38 @@ static void pgd_prepopulate_pmd(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmds[])
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
@@ -371,6 +426,7 @@ static inline void _pgd_free(pgd_t *pgd)
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd;
+	pmd_t *u_pmds[PREALLOCATED_USER_PMDS];
 	pmd_t *pmds[PREALLOCATED_PMDS];
 
 	pgd = _pgd_alloc();
@@ -380,12 +436,15 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 
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
@@ -395,13 +454,16 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 
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
