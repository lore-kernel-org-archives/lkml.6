Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx497ykIoX0p27PVwqYzPqifWII6+x6FKidrRGm2FNn70e8QEx4/dlN2I744wVm0ZQ5Rj975v
ARC-Seal: i=1; a=rsa-sha256; t=1523892355; cv=none;
        d=google.com; s=arc-20160816;
        b=KpMNpRR9tLyhSHMCO3qa36sQyXydqLwRzUmJsYFYi4re04KxoITpN9OjKaQFEJk2dL
         +ewWjG7IdzmX6U2F2V96JBwLkb1RuYmDlJXIc7G2nM412Pq/ipDMtlhHVNKBdj6rAfGd
         N2ND/1UTophbK91Ry9JIIX6O8fGILVrGmYipLcbJI3JG4kKBv6llmRb1FFtT5CnFn65c
         ihh5V3KET9QaJuIkfaseEGA5pSU4A0W6l9uxZEkEj4+f/NwmyEP2eu5lwoi93VmfKU8K
         DmWBbJXfyTHwLrq4FqbxGmoSlAFXUmlyD0KcKu40PqikFA15GPbivpefXVlaW8zIYsB/
         v4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=febjYxeIzBFOuqfa7xiKg7MddzR6QCsFMLk0zz0jsto=;
        b=o0CjbE+1D1wOMs/ReAOjLx0eFQl2tNUYJE1wEOg70FM+vJiFre5RoN0jBjUikiURM7
         w6BY4gtWoahYtXn5Hk6m4QqvNnI2hgjO21YD2iiPENZLYk2Ctd3mYxgkqKaBufJZBpDk
         sRXSEmnmxtts7gmIVoQehWQwaXkbLMoPMTILEfCznIOa46eFEbVUqKZdP9zur9BG/LUK
         3cRiCibmtQKMKfTOs21Ztjw4d5hkeAq6BmLZ8wmy/+R/LL46/8kWzqLznmkiWO7E+t8X
         MDc2Qu20xh90Jpa5k8w+4H64ZJNCB339JKKcuyYa+PQbPRtSj3jwar5aBUbV9bPaObTL
         sirw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=kGTZ1SOq;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=kGTZ1SOq;
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
Subject: [PATCH 32/35] x86/ldt: Enable LDT user-mapping for PAE
Date: Mon, 16 Apr 2018 17:25:20 +0200
Message-Id: <1523892323-14741-33-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916951151230081?=
X-GMAIL-MSGID: =?utf-8?q?1597916951151230081?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

This adds the needed special case for PAE to get the LDT
mapped into the user page-table when PTI is enabled. The big
difference to the other paging modes is that we don't have a
full top-level PGD entry available for the LDT, but only PMD
entry.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/mmu_context.h |  5 ----
 arch/x86/kernel/ldt.c              | 53 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 57e3785..28b2376 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -71,12 +71,7 @@ struct ldt_struct {
 
 static inline void *ldt_slot_va(int slot)
 {
-#ifdef CONFIG_X86_64
 	return (void *)(LDT_BASE_ADDR + LDT_SLOT_STRIDE * slot);
-#else
-	BUG();
-	return (void *)fix_to_virt(FIX_HOLE);
-#endif
 }
 
 /*
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index e68ce37..da80296 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -126,6 +126,57 @@ static void do_sanity_check(struct mm_struct *mm,
 	}
 }
 
+#ifdef CONFIG_X86_PAE
+
+static pmd_t *pgd_to_pmd_walk(pgd_t *pgd, unsigned long va)
+{
+	p4d_t *p4d;
+	pud_t *pud;
+
+	if (pgd->pgd == 0)
+		return NULL;
+
+	p4d = p4d_offset(pgd, va);
+	if (p4d_none(*p4d))
+		return NULL;
+
+	pud = pud_offset(p4d, va);
+	if (pud_none(*pud))
+		return NULL;
+
+	return pmd_offset(pud, va);
+}
+
+static void map_ldt_struct_to_user(struct mm_struct *mm)
+{
+	pgd_t *k_pgd = pgd_offset(mm, LDT_BASE_ADDR);
+	pgd_t *u_pgd = kernel_to_user_pgdp(k_pgd);
+	pmd_t *k_pmd, *u_pmd;
+
+	k_pmd = pgd_to_pmd_walk(k_pgd, LDT_BASE_ADDR);
+	u_pmd = pgd_to_pmd_walk(u_pgd, LDT_BASE_ADDR);
+
+	if (static_cpu_has(X86_FEATURE_PTI) && !mm->context.ldt)
+		set_pmd(u_pmd, *k_pmd);
+}
+
+static void sanity_check_ldt_mapping(struct mm_struct *mm)
+{
+	pgd_t *k_pgd = pgd_offset(mm, LDT_BASE_ADDR);
+	pgd_t *u_pgd = kernel_to_user_pgdp(k_pgd);
+	bool had_kernel, had_user;
+	pmd_t *k_pmd, *u_pmd;
+
+	k_pmd      = pgd_to_pmd_walk(k_pgd, LDT_BASE_ADDR);
+	u_pmd      = pgd_to_pmd_walk(u_pgd, LDT_BASE_ADDR);
+	had_kernel = (k_pmd->pmd != 0);
+	had_user   = (u_pmd->pmd != 0);
+
+	do_sanity_check(mm, had_kernel, had_user);
+}
+
+#else /* !CONFIG_X86_PAE */
+
 static void map_ldt_struct_to_user(struct mm_struct *mm)
 {
 	pgd_t *pgd = pgd_offset(mm, LDT_BASE_ADDR);
@@ -143,6 +194,8 @@ static void sanity_check_ldt_mapping(struct mm_struct *mm)
 	do_sanity_check(mm, had_kernel, had_user);
 }
 
+#endif /* CONFIG_X86_PAE */
+
 /*
  * If PTI is enabled, this maps the LDT into the kernelmode and
  * usermode tables for the given mm.
-- 
2.7.4
