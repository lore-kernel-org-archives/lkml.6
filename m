Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx49Bx8aHA+jkd9v22FXs1av3i/L7klCVZ4JjHiCyfYnsvW+WkIxFxBez3S+zK3aLOwpWnh5t
ARC-Seal: i=1; a=rsa-sha256; t=1523892350; cv=none;
        d=google.com; s=arc-20160816;
        b=CLLseHwiTISBxrQcAXOFZFaEIyX+DFBwpyXfMmtkQeoV77rLrXv+EgU9VOI/Y3pzJT
         fyMCo63E/3c9rTSjIEHKr+bA3tbpnJitP0AclFFt8I6NSW+5SPWEeItgmAxIthpRpBYX
         5nWyXWzDtcbVZtup25ViVXarWv9MGksa1B8FD715ddkOUWuxXSXSc1lJDzKXI3ltYmL0
         +YX73BYgOcn6uUT3xqaZQEc0uYUQoDkqBgrkSVUBWDjYM1Rw7SROV4QQWbBI/aPld6dp
         LbqEgKRdeYwVnJXJU0xeEoHLFH3GbHcSEGYOt5lJXGc9pBKkjRoOHiYwQe99OTMFcKUM
         yY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=bUtTC/Dyg5FNIa6JGw1gxi9rGbbo2QORoEfBK8fKEY8=;
        b=z1N1Pellyyo1JcHkK4lM8sSWVoU72HGu48Ky3Z1ISdyc9aue162gjxTE0v7EdamI1o
         sySwmFav0kL3g066WsJ8p3FbLFuLSndaJpRU2pL6/lVH5zYw9uGp3DtBA/DD+dlir2BV
         /pUMJ/gYPcUYA6+GOPeADrALMGxxGxT2Ew5v8AGKvCuDiozJMNJOxgJTMBKdrmk9ftZk
         KruivUP1y2eYT/+7A+MSHJt72uDAVjYBBMsdu+EKqjwdalDT4XWn2Y7/xE4Qmx8KmMP+
         bawhqnGwjQdokAAQ0VylNT6/kx9Up4Z/pUrDdC0XJ9l5fqQP0uVjSw4GZlfwYmmY0SQ2
         jnKw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=pRKTBOTT;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=pRKTBOTT;
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
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 28/35] x86/pgtable/pae: Use separate kernel PMDs for user page-table
Date: Mon, 16 Apr 2018 17:25:16 +0200
Message-Id: <1523892323-14741-29-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916944848282957?=
X-GMAIL-MSGID: =?utf-8?q?1597916944848282957?=
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
index f4211d2..ae98d4c 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -178,6 +178,14 @@ static void pgd_dtor(pgd_t *pgd)
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
@@ -198,14 +206,14 @@ void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
 
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
@@ -213,7 +221,7 @@ static void free_pmds(struct mm_struct *mm, pmd_t *pmds[])
 		}
 }
 
-static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[])
+static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 {
 	int i;
 	bool failed = false;
@@ -222,7 +230,7 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[])
 	if (mm == &init_mm)
 		gfp &= ~__GFP_ACCOUNT;
 
-	for(i = 0; i < PREALLOCATED_PMDS; i++) {
+	for(i = 0; i < count; i++) {
 		pmd_t *pmd = (pmd_t *)__get_free_page(gfp);
 		if (!pmd)
 			failed = true;
@@ -237,7 +245,7 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[])
 	}
 
 	if (failed) {
-		free_pmds(mm, pmds);
+		free_pmds(mm, pmds, count);
 		return -ENOMEM;
 	}
 
@@ -250,23 +258,38 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[])
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
@@ -292,6 +315,38 @@ static void pgd_prepopulate_pmd(struct mm_struct *mm, pgd_t *pgd, pmd_t *pmds[])
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
@@ -372,6 +427,7 @@ static inline void _pgd_free(pgd_t *pgd)
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	pgd_t *pgd;
+	pmd_t *u_pmds[PREALLOCATED_USER_PMDS];
 	pmd_t *pmds[PREALLOCATED_PMDS];
 
 	pgd = _pgd_alloc();
@@ -381,12 +437,15 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 
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
@@ -396,13 +455,16 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 
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
