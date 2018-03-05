Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELvbvOjSSWIIHvYaFuZWNB3wwi2nMDUZtKLbzhFBzTzw8B8MKahZIp51DPDj8Jbg7n23zWLw
ARC-Seal: i=1; a=rsa-sha256; t=1520245585; cv=none;
        d=google.com; s=arc-20160816;
        b=abyYwEwEVQTarCl8eBrCvbdFE1yqr9tmBdDYgzLFtGzSraAKt+R3N6MHS5Kvk4MxOh
         Hiu1GXgS8QmsfOE1JsaLWisf2Iqq2fg1KE0QqUZKrlSdZw27s+8NfTawVLD/r0frtxns
         KvatV2+TZe190Ukuzv7JRIPSHSvkRjQ1mTk48L3YpbNagv3mnvg+Su7qpwD2YLCAzWUN
         7P8kur+vJmMQVgFL3s7z5s4x0w06suYicda5dtdiXaa1YgJJDsO15/oB451b46khsPCp
         QKamKabZMpvkmYC1b+KBHF4j3n08e1c+JKd+t/mQT3ngzd1MNW7+nlQ98F+ChCc5hMbw
         BRGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=igYQ/x+Bee3t5LU4V9asteXT8ZgIi1BJyc7+25PZsZk=;
        b=bNTumWRBKj6ApS98RP3e9ywjvQwtpaxH+HjUv+TAgdVtfz3luU8a62yQVeiRiH1eNE
         yRt0D0gOPUCehVx8c6Omc+gU3LkniPV7csrNHFO/XuaJvHHh96mp3c81l/9SSkHaSEbk
         o9CT9mp3W8euK1f+hJFRIgd8OAikBMsBsyMggj87Y+x2SBC/KHpIX27DuJSnHJOpQQvC
         FER1dzGm1HBE/QfdDncvFkGXzxVnWAe/7bo2tL6xnJdL6vcbnPtzZ85dDZls1oc4dW2O
         kXEcpi2mgjtBSe8oPWrVwZkowo4ArTBI99Lyp3jGmuaKiGjQVFkrx0IJUmj7A/hvJFmY
         pKow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=WOD7gNaz;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=WOD7gNaz;
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
Subject: [PATCH 31/34] x86/ldt: Split out sanity check in map_ldt_struct()
Date: Mon,  5 Mar 2018 11:26:00 +0100
Message-Id: <1520245563-8444-32-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093035462900422?=
X-GMAIL-MSGID: =?utf-8?q?1594093035462900422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

This splits out the mapping sanity check and the actual
mapping of the LDT to user-space from the map_ldt_struct()
function in a way so that it is re-usable for PAE paging.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/ldt.c | 82 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 58 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/ldt.c b/arch/x86/kernel/ldt.c
index f3c2fbf..8ab7df9 100644
--- a/arch/x86/kernel/ldt.c
+++ b/arch/x86/kernel/ldt.c
@@ -100,6 +100,49 @@ static struct ldt_struct *alloc_ldt_struct(unsigned int num_entries)
 	return new_ldt;
 }
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+
+static void do_sanity_check(struct mm_struct *mm,
+			    bool had_kernel_mapping,
+			    bool had_user_mapping)
+{
+	if (mm->context.ldt) {
+		/*
+		 * We already had an LDT.  The top-level entry should already
+		 * have been allocated and synchronized with the usermode
+		 * tables.
+		 */
+		WARN_ON(!had_kernel_mapping);
+		if (static_cpu_has(X86_FEATURE_PTI))
+			WARN_ON(!had_user_mapping);
+	} else {
+		/*
+		 * This is the first time we're mapping an LDT for this process.
+		 * Sync the pgd to the usermode tables.
+		 */
+		WARN_ON(had_kernel_mapping);
+		if (static_cpu_has(X86_FEATURE_PTI))
+			WARN_ON(had_user_mapping);
+	}
+}
+
+static void map_ldt_struct_to_user(struct mm_struct *mm)
+{
+	pgd_t *pgd = pgd_offset(mm, LDT_BASE_ADDR);
+
+	if (static_cpu_has(X86_FEATURE_PTI) && !mm->context.ldt)
+		set_pgd(kernel_to_user_pgdp(pgd), *pgd);
+}
+
+static void sanity_check_ldt_mapping(struct mm_struct *mm)
+{
+	pgd_t *pgd = pgd_offset(mm, LDT_BASE_ADDR);
+	bool had_kernel = (pgd->pgd != 0);
+	bool had_user   = (kernel_to_user_pgdp(pgd)->pgd != 0);
+
+	do_sanity_check(mm, had_kernel, had_user);
+}
+
 /*
  * If PTI is enabled, this maps the LDT into the kernelmode and
  * usermode tables for the given mm.
@@ -115,9 +158,8 @@ static struct ldt_struct *alloc_ldt_struct(unsigned int num_entries)
 static int
 map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 {
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-	bool is_vmalloc, had_top_level_entry;
 	unsigned long va;
+	bool is_vmalloc;
 	spinlock_t *ptl;
 	pgd_t *pgd;
 	int i;
@@ -131,13 +173,15 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 	 */
 	WARN_ON(ldt->slot != -1);
 
+	/* Check if the current mappings are sane */
+	sanity_check_ldt_mapping(mm);
+
 	/*
 	 * Did we already have the top level entry allocated?  We can't
 	 * use pgd_none() for this because it doens't do anything on
 	 * 4-level page table kernels.
 	 */
 	pgd = pgd_offset(mm, LDT_BASE_ADDR);
-	had_top_level_entry = (pgd->pgd != 0);
 
 	is_vmalloc = is_vmalloc_addr(ldt->entries);
 
@@ -168,35 +212,25 @@ map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
 		pte_unmap_unlock(ptep, ptl);
 	}
 
-	if (mm->context.ldt) {
-		/*
-		 * We already had an LDT.  The top-level entry should already
-		 * have been allocated and synchronized with the usermode
-		 * tables.
-		 */
-		WARN_ON(!had_top_level_entry);
-		if (static_cpu_has(X86_FEATURE_PTI))
-			WARN_ON(!kernel_to_user_pgdp(pgd)->pgd);
-	} else {
-		/*
-		 * This is the first time we're mapping an LDT for this process.
-		 * Sync the pgd to the usermode tables.
-		 */
-		WARN_ON(had_top_level_entry);
-		if (static_cpu_has(X86_FEATURE_PTI)) {
-			WARN_ON(kernel_to_user_pgdp(pgd)->pgd);
-			set_pgd(kernel_to_user_pgdp(pgd), *pgd);
-		}
-	}
+	/* Propagate LDT mapping to the user page-table */
+	map_ldt_struct_to_user(mm);
 
 	va = (unsigned long)ldt_slot_va(slot);
 	flush_tlb_mm_range(mm, va, va + LDT_SLOT_STRIDE, 0);
 
 	ldt->slot = slot;
-#endif
 	return 0;
 }
 
+#else /* !CONFIG_PAGE_TABLE_ISOLATION */
+
+static int
+map_ldt_struct(struct mm_struct *mm, struct ldt_struct *ldt, int slot)
+{
+	return 0;
+}
+#endif /* CONFIG_PAGE_TABLE_ISOLATION */
+
 static void free_ldt_pgtables(struct mm_struct *mm)
 {
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
-- 
2.7.4
