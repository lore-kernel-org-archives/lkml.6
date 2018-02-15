Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426135AbeBOQha (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:37:30 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:37394 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1426074AbeBOQgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:36:18 -0500
From: Nadav Amit <namit@vmware.com>
To: Ingo Molnar <mingo@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, Willy Tarreau <w@1wt.eu>,
        Nadav Amit <nadav.amit@gmail.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH RFC v2 2/6] x86: Save pti_disable for each mm_context
Date: Thu, 15 Feb 2018 08:35:58 -0800
Message-ID: <20180215163602.61162-3-namit@vmware.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180215163602.61162-1-namit@vmware.com>
References: <20180215163602.61162-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save for each mm->context whether page-table isolation should be
disabled. In order not to make intrusive changes, the information is
saved in the PGD page metadata.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/include/asm/mmu.h | 3 +++
 arch/x86/include/asm/pti.h | 9 +++++++++
 arch/x86/mm/pgtable.c      | 4 +++-
 arch/x86/mm/pti.c          | 9 +++++++--
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5ff3e8af2c20..fb8db4a09d8a 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -36,6 +36,9 @@ typedef struct {
 	/* True if mm supports a task running in 32 bit compatibility mode. */
 	unsigned short ia32_compat;
 #endif
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	unsigned short pti_disable;
+#endif
 
 	struct mutex lock;
 	void __user *vdso;			/* vdso base address */
diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index 0b5ef05b2d2d..96a5fbfedf7a 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -4,9 +4,18 @@
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
+static inline unsigned short mm_pti_disable(struct mm_struct *mm)
+{
+	if (mm == NULL)
+		return 0;
+
+	return mm->context.pti_disable;
+}
+
 extern void pti_init(void);
 extern void pti_check_boottime_disable(void);
 #else
+static inline unsigned short mm_pti_disable(struct mm_struct *mm) { return 0; }
 static inline void pti_check_boottime_disable(void) { }
 #endif
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 004abf9ebf12..ef0394a97adb 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -139,7 +139,9 @@ static void pgd_ctor(struct mm_struct *mm, pgd_t *pgd)
 	if (!SHARED_KERNEL_PMD) {
 		pgd_set_mm(pgd, mm);
 		pgd_list_add(pgd);
-	}
+	} else if (IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION) &&
+		   static_cpu_has(X86_FEATURE_PTI))
+		pgd_set_mm(pgd, mm);
 }
 
 static void pgd_dtor(pgd_t *pgd)
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index ce38f165489b..a973a291a34d 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -134,10 +134,15 @@ pgd_t __pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
 	 *     may execute from it
 	 *  - we don't have NX support
 	 *  - we're clearing the PGD (i.e. the new pgd is not present).
+	 *  - PTI is disabled.
 	 */
 	if ((pgd.pgd & (_PAGE_USER|_PAGE_PRESENT)) == (_PAGE_USER|_PAGE_PRESENT) &&
-	    (__supported_pte_mask & _PAGE_NX))
-		pgd.pgd |= _PAGE_NX;
+	    (__supported_pte_mask & _PAGE_NX)) {
+		struct mm_struct *mm = pgd_page_get_mm(virt_to_page(pgdp));
+
+		if (!mm_pti_disable(mm))
+			pgd.pgd |= _PAGE_NX;
+	}
 
 	/* return the copy of the PGD we want the kernel to use: */
 	return pgd;
-- 
2.14.1
