Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELuYatIuGlBx4WzXCJjWNDZ42o0ZWAgI5f+lrYE7zMe9Px20M8WmrH4TufTeFtBB6cMIv931
ARC-Seal: i=1; a=rsa-sha256; t=1521228614; cv=none;
        d=google.com; s=arc-20160816;
        b=i2ndL87DPLTJ4qXqM2O2XMTK2ag3DOeuLIag83mtRHzXW8nnL1/m+x6wHtzogr2iOp
         JzbICmxBHKCYv/jO4i9yPgbnVq5Dw+W8ryWUL+BkPxzB/+cLB1EUBfvbNFUZANLGLg5k
         orM/q7/DhXe+19jM7yARGUk+oLcGbpwD/kLSa52kXPxsd4Gn5tjdE8OxFCO8JInYtS8Y
         8uOz4PSrSYmDZ6pqpt8hNf9PsgKQjGNg3vV7q1+HL0/9gqk9ZoVOh6tsxi9PhLzBAedq
         9ubyKJbvX3eQEVkwZEGw3dEAv3bCYKx3UGbsEwKOv4mOnrPUZMjU0+nv5qLs0FKRyD3w
         IyHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=5GVwPDKsD+1K6vG3mdefs4/myzOy2uBlRsuw23QPAt0=;
        b=Ns+fQD7gkUIrK2WyLPqSdg/Hl8caS6MX6gCaezgJD0LPdv8TgOPXw9BTIG7ABwZGP/
         V+9Zi95yEzgotrt//3PNRvKkCk1VHyqOWHLV/6jLHQ/V1MT/+Yyh9LeRRFaPHf+YQ39R
         WjAzH7TIP+Hjh7L2qy1RdkoELUSYFDzRuRXb1pEBe4MwldIzHyS/0ckpQBYMDYmJ0aR9
         Eb7OS83/A4j7sqx7MDIAx/m+h16s7FWXYupx/mcoKuinms3HlPM0mPMpdzC8YFy/5mdq
         lGcqISC1XSICSYkTIuhu/M/8b4biGkqP9O39Mcwx2OWV92He60vkmA9I2bBSHfNunarG
         CsCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=R7XE3f72;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=R7XE3f72;
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
Subject: [PATCH 32/35] x86/ldt: Enable LDT user-mapping for PAE
Date: Fri, 16 Mar 2018 20:29:50 +0100
Message-Id: <1521228593-3820-33-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123815981424032?=
X-GMAIL-MSGID: =?utf-8?q?1595123815981424032?=
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
 arch/x86/include/asm/mmu_context.h |  4 ---
 arch/x86/kernel/ldt.c              | 53 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index c931b88..af96cfb 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -70,11 +70,7 @@ struct ldt_struct {
 
 static inline void *ldt_slot_va(int slot)
 {
-#ifdef CONFIG_X86_64
 	return (void *)(LDT_BASE_ADDR + LDT_SLOT_STRIDE * slot);
-#else
-	BUG();
-#endif
 }
 
 /*
diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index 8ab7df9..7787451 100644
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
