Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0388DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E2F208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Bb3URnkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E2F208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbeGKLeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:34:07 -0400
Received: from 8bytes.org ([81.169.241.247]:37734 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732848AbeGKLeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:34:06 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9150A8F0; Wed, 11 Jul 2018 13:30:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531308603; bh=qgF5TKSPeKfV3RwP/ojIqp2J5p8p9GJpm4hHUAmlDu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bb3URnkkw9JQ2tP1+/YViZpAV7Q01sRogYqTUg8+VALBqZRqAU9LRdl0odFQvTBtd
         ulCMCrP3rKbtfwi88MWf6Z6+Cvx0leJXVLELnx76ERbakQuDBywPdHX8wtpz5AXLkI
         eULwXjulew3pcSfA/08zEW3q/IbmiPu2umXjwLNtxYMV+7fuwz5ZsTwb0qw29R/QQe
         BxikUCcPp0wB7IBtb/wMg+OpgAmPgjrFZ6feMGAVNb0K1r9A5b00krSoPYGR24Pekr
         u2tekUqlX58VkIR7hZoWa/hz/JB/ug24MJpK1VUFHNH1mjvUvo4afmHIIscw6A/SKn
         Znr/7z1Nc1FwA==
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
Subject: [PATCH 20/39] x86/pgtable: Move two more functions from pgtable_64.h to pgtable.h
Date:   Wed, 11 Jul 2018 13:29:27 +0200
Message-Id: <1531308586-29340-21-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531308586-29340-1-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 arch/x86/include/asm/pgtable.h              | 15 ++++++++++++
 arch/x86/include/asm/pgtable_32.h           |  2 --
 arch/x86/include/asm/pgtable_64.h           | 36 -----------------------------
 arch/x86/include/asm/pgtable_64_types.h     |  2 ++
 6 files changed, 21 insertions(+), 38 deletions(-)

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
index 78038e0..858358a 100644
--- a/arch/x86/include/asm/pgtable-3level_types.h
+++ b/arch/x86/include/asm/pgtable-3level_types.h
@@ -46,5 +46,6 @@ typedef union {
 #define PTRS_PER_PTE	512
 
 #define MAX_POSSIBLE_PHYSMEM_BITS	36
+#define PGD_KERNEL_START	(CONFIG_PAGE_OFFSET >> PGDIR_SHIFT)
 
 #endif /* _ASM_X86_PGTABLE_3LEVEL_DEFS_H */
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index cc117161..e39088cb 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1177,6 +1177,21 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 	}
 }
 #endif
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
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 /*
diff --git a/arch/x86/include/asm/pgtable_32.h b/arch/x86/include/asm/pgtable_32.h
index 88a056b..b3ec519 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -34,8 +34,6 @@ static inline void check_pgt_cache(void) { }
 void paging_init(void);
 void sync_initial_page_table(void);
 
-static inline int pgd_large(pgd_t pgd) { return 0; }
-
 /*
  * Define this if things work differently on an i386 and an i486:
  * it will (on an i486) warn about kernel memory accesses that are
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 4adba19..acb6970 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -132,41 +132,6 @@ static inline pud_t native_pudp_get_and_clear(pud_t *xp)
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
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-pgd_t __pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd);
-
-/*
- * Take a PGD location (pgdp) and a pgd value that needs to be set there.
- * Populates the user and returns the resulting PGD that must be set in
- * the kernel copy of the page tables.
- */
-static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
-{
-	if (!static_cpu_has(X86_FEATURE_PTI))
-		return pgd;
-	return __pti_set_user_pgtbl(pgdp, pgd);
-}
-#else
-static inline pgd_t pti_set_user_pgtbl(pgd_t *pgdp, pgd_t pgd)
-{
-	return pgd;
-}
-#endif
-
 static inline void native_set_p4d(p4d_t *p4dp, p4d_t p4d)
 {
 	pgd_t pgd;
@@ -206,7 +171,6 @@ extern void sync_global_pgds(unsigned long start, unsigned long end);
 /*
  * Level 4 access.
  */
-static inline int pgd_large(pgd_t pgd) { return 0; }
 #define mk_kernel_pgd(address) __pgd((address) | _KERNPG_TABLE)
 
 /* PUD - Level3 access */
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 054765a..066e0ab 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -153,4 +153,6 @@ extern unsigned int ptrs_per_p4d;
 
 #define EARLY_DYNAMIC_PAGE_TABLES	64
 
+#define PGD_KERNEL_START	((PAGE_SIZE / 2) / sizeof(pgd_t))
+
 #endif /* _ASM_X86_PGTABLE_64_DEFS_H */
-- 
2.7.4

