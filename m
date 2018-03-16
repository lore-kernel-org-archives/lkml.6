Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELsEcOwBUaHNapd78U7saelXGAjcGf8OAShY+9oyIrOoZiP1g7QOiLuVUYA++aVBGnTIfVEf
ARC-Seal: i=1; a=rsa-sha256; t=1521228607; cv=none;
        d=google.com; s=arc-20160816;
        b=HjYLJMEVPFFDWRF7AM1MCB0OnXXTtPHDJ+hzozXmviI41d/67IS3SS/WhDCWXsUIDK
         Iz8t+53nVLPTj4BsYNPo4PQ3TbfQ+fczSVhyq4GMHckhH2w1dLkxC4XpIkDn4IiP6kq3
         St+nwGCWQE7qKyG9SsZTQJ1q8pTaqcDz4gYlrq54ubGfG8gz/r4qg6q1jc3lY5iPeqG6
         7WYWK1tqzBhkH6uuv58cFAaRkxW43qHiDMjYcm/wsn5jH2PUogfnoGxjvcZ6XuKg7KpK
         Oo9I/vdw3HVgxMmToZLqptMkCzDSZo9cG88Eofk9wgssU6Rc8kyhjn0IGVnGER+8bKwi
         DOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=vGtwEtmHlJEHWHJ5MOcJ6tilXxZjkLHR0q81fXNzmc4=;
        b=aNvH6Lefd6xsdrCqwHf1I2vbeU9qm7kcMqdUOEf1VAY1jOtH5Mv5OKU3tY2Lj2ISsK
         KvhR2qfZr/nRS5oc5y0ASdRCngbhyWY4gbf5eye2Bi5Zc2PRWI1tj303+sw2+zWlIUpl
         aLyzB69YH8emi/8fkeq82CbXeiUan+sXd3zX6psHRyvDXSsibM88d3qaQeZOChTyhqeE
         rIkJZs4MDRcflkexouK749raVEE8CLRbqNkvWheNkK4cXGdUX5Q/VKNuA0bIRvLT0FuL
         YHhsHKTpZWeMwlP3oe1aqlBP88zf5drxZK0R9ZEe65DBl3tWCqjW2pZ1J/5bVLH1MBqM
         smrQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=kUs4m/hr;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=kUs4m/hr;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
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
Subject: [PATCH 20/35] x86/pgtable: Move two more functions from pgtable_64.h to pgtable.h
Date: Fri, 16 Mar 2018 20:29:38 +0100
Message-Id: <1521228593-3820-21-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123808384015867?=
X-GMAIL-MSGID: =?utf-8?q?1595123808384015867?=
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
