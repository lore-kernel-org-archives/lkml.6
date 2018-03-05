Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELuDOjnESx3zqKQZTzSKd+BSmzWMEcnM81HQjigT77ub72V/fnCeuhv2LcOm+0ej9KKjz7tP
ARC-Seal: i=1; a=rsa-sha256; t=1520245577; cv=none;
        d=google.com; s=arc-20160816;
        b=siRVIZ4GIvFdoNIvpN67XOg6b855xISg4fu4wOuQMyVvNGxBDbVMuCypuPFmPi2i15
         cyefiO/dL3508tM+fvVH1wSD+qitn1QNx9DDP6tJpkJiGpO6R/8VTDo6DneVnyFovCdn
         xcaeeAJuSW6XCOpSptmAlwaSyXEeZXKreRCPAHo6AwPlN+CpmDHoj0XfeTnqcH/fsJ+E
         7a+UquUTVTqaHWmmBNpM7nLCbnvN8eiuaFqrbReVq3lfQ6BFC6dK/6jyahpvr/PIoiwH
         7PgafyuSE7wK2s5rsaW5JFLP0Jdll8fi3ag9E4qvgfTbENGmCiNcRajXpsJe5Zh7pksY
         PVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=vGtwEtmHlJEHWHJ5MOcJ6tilXxZjkLHR0q81fXNzmc4=;
        b=LpvfG3Mo4nRncN9JmiSLY1rEHYpUoO/Oh/PdRMlYV4dKTm0Gg67WAyF4ezpegTbYcJ
         GnV4lEw+vMbsKGtDj7TW06nJKlwjZvlkohmZG64RFQLi/XRC+seBpjs4/Cs/VLazQ7YX
         cbRNExOp6lj0Wg2pwd8XvMXMRaP4BZf7NVSldSACeWOwnoWpKy5iTsPTHOxck7iTuqRy
         N4gkPb7Wq+7JXeYbgcCpmGCJFa9bOamjAMKqRLVIruhC4+8VcdAO9yqzDlxGW/3ytZw5
         CitNisVQrzDMPgLu+sO+E+YLcqDqJ6VUkx+8Px9oDGUMvlANHhQVVgZsQnA9w6BA5wR2
         qPUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=OdPuL4oG;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=OdPuL4oG;
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
Subject: [PATCH 20/34] x86/pgtable: Move two more functions from pgtable_64.h to pgtable.h
Date: Mon,  5 Mar 2018 11:25:49 +0100
Message-Id: <1520245563-8444-21-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093026808146762?=
X-GMAIL-MSGID: =?utf-8?q?1594093026808146762?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

These two functions are required for PTI on 32 bit:

	* pgdp_maps_userspace()
	* pgd_large()

Also re-implement pgdp_maps_userspace() so that it will work
on 64 and 32 bit kernels.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable-2level_types.h |  3 +++
 arch/x86/include/asm/pgtable-3level_types.h |  1 +
 arch/x86/include/asm/pgtable.h              | 16 ++++++++++++++++
 arch/x86/include/asm/pgtable_64.h           | 15 ---------------
 arch/x86/include/asm/pgtable_64_types.h     |  2 ++
 5 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-2level_types.h b/arch/x86/include/asm/pgtable-2level_types.h
index f982ef8..6deb6cd 100644
--- a/arch/x86/include/asm/pgtable-2level_types.h
+++ b/arch/x86/include/asm/pgtable-2level_types.h
@@ -35,4 +35,7 @@ typedef union {
 
 #define PTRS_PER_PTE	1024
 
+/* This covers all VMSPLIT_* and VMSPLIT_*_OPT variants */
+#define PGD_KERNEL_START	(CONFIG_PAGE_OFFSET >> PGDIR_SHIFT)
+
 #endif /* _ASM_X86_PGTABLE_2LEVEL_DEFS_H */
diff --git a/arch/x86/include/asm/pgtable-3level_types.h b/arch/x86/include/asm/pgtable-3level_types.h
index ed8a200..925ac1b 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -45,5 +45,6 @@ typedef union {
  */
 #define PTRS_PER_PTE	512
 
+#define PGD_KERNEL_START	(CONFIG_PAGE_OFFSET >> PGDIR_SHIFT)
 
 #endif /* _ASM_X86_PGTABLE_3LEVEL_DEFS_H */
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 1e900c1..981e49a 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1132,6 +1132,22 @@ static inline int pud_write(pud_t pud)
 	return pud_flags(pud) & _PAGE_RW;
 }
 
+/*
+ * Page table pages are page-aligned.  The lower half of the top
+ * level is used for userspace and the top half for the kernel.
+ *
+ * Returns true for parts of the PGD that map userspace and
+ * false for the parts that map the kernel.
+ */
+static inline bool pgdp_maps_userspace(void *__ptr)
+{
+	unsigned long ptr = (unsigned long)__ptr;
+
+	return (((ptr & ~PAGE_MASK) / sizeof(pgd_t)) < PGD_KERNEL_START);
+}
+
+static inline int pgd_large(pgd_t pgd) { return 0; }
+
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 /*
  * All top-level PAGE_TABLE_ISOLATION page tables are order-1 pages
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 4cbf517..e11b925 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -131,20 +131,6 @@ static inline pud_t native_pudp_get_and_clear(pud_t *xp)
 #endif
 }
 
-/*
- * Page table pages are page-aligned.  The lower half of the top
- * level is used for userspace and the top half for the kernel.
- *
- * Returns true for parts of the PGD that map userspace and
- * false for the parts that map the kernel.
- */
-static inline bool pgdp_maps_userspace(void *__ptr)
-{
-	unsigned long ptr = (unsigned long)__ptr;
-
-	return (ptr & ~PAGE_MASK) < (PAGE_SIZE / 2);
-}
-
 static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 #if defined(CONFIG_PAGE_TABLE_ISOLATION) && !defined(CONFIG_X86_5LEVEL)
@@ -187,7 +173,6 @@ extern void sync_global_pgds(unsigned long start, unsigned long end);
 /*
  * Level 4 access.
  */
-static inline int pgd_large(pgd_t pgd) { return 0; }
 #define mk_kernel_pgd(address) __pgd((address) | _KERNPG_TABLE)
 
 /* PUD - Level3 access */
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 6b8f73d..e57003a 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -124,4 +124,6 @@ typedef struct { pteval_t pte; } pte_t;
 
 #define EARLY_DYNAMIC_PAGE_TABLES	64
 
+#define PGD_KERNEL_START	((PAGE_SIZE / 2) / sizeof(pgd_t))
+
 #endif /* _ASM_X86_PGTABLE_64_DEFS_H */
-- 
2.7.4
