Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6D3C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD232170A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="YSEYQnF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD232170A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388846AbeHGMiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:38:16 -0400
Received: from 8bytes.org ([81.169.241.247]:60944 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388767AbeHGMiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:38:15 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C6F4F301; Tue,  7 Aug 2018 12:24:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1533637473; bh=yH8pfODF7JiPfNr3+5cXoh3BC/3nmtRH4rF1Of9Df6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSEYQnF1NEY3V04R9RQEy3euU+xgfCZJGx8eGq+F/UDYU82g2DAbNojf/CZxCz+jc
         4IPBLIIYB33fWa14hJ2WhR87I2vpCsWIiP+oGaxOYiXMh0n7DtgnYMMY/usEtchbZu
         Rg+9YDxY/m/jIzkNYIFqrl82RY72tuwRGNBywKFlRR1fEq6WUfccfffXR8mfMgteGT
         KVO3OLq7caJSxVeBMOTV8nf9PUW9iQLEL7Y42CYxWJfigMdJzyG1tj2jeL7zooluqF
         pbq6yPq0qrHDnRBB0Exdxe4jy+Qo4+rL4ttio3EOXfQ0Km0cDSi02t3Dm3oNF07+dL
         JNNUvIh+lu9MA==
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
Subject: [PATCH 3/3] x86/mm/pti: Clone kernel-image on PTE level for 32 bit
Date:   Tue,  7 Aug 2018 12:24:31 +0200
Message-Id: <1533637471-30953-4-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533637471-30953-1-git-send-email-joro@8bytes.org>
References: <1533637471-30953-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

On 32 bit the kernel sections are not huge-page aligned.
When we clone them on PMD-level we unevitably map some areas
that are normal kernel memory and may contain secrets to
user-space. To prevent that we need to clone the
kernel-image on PTE-level for 32 bit.

Also make the page-table cloning clode more general so that
it can handle PMD and PTE level cloning. This can be
generalized further in the future to also handle clones on
the P4D-level.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/pti.c | 140 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 99 insertions(+), 41 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 5164c98..1dc5c68 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -54,6 +54,16 @@
 #define __GFP_NOTRACK	0
 #endif
 
+/*
+ * Define the page-table levels we clone for user-space on 32
+ * and 64 bit.
+ */
+#ifdef CONFIG_X86_64
+#define	PTI_LEVEL_KERNEL_IMAGE	PTI_CLONE_PMD
+#else
+#define	PTI_LEVEL_KERNEL_IMAGE	PTI_CLONE_PTE
+#endif
+
 static void __init pti_print_if_insecure(const char *reason)
 {
 	if (boot_cpu_has_bug(X86_BUG_CPU_MELTDOWN))
@@ -228,7 +238,6 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
 	return pmd_offset(pud, address);
 }
 
-#ifdef CONFIG_X86_VSYSCALL_EMULATION
 /*
  * Walk the shadow copy of the page tables (optionally) trying to allocate
  * page table pages on the way down.  Does not support large pages.
@@ -270,6 +279,7 @@ static __init pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 	return pte;
 }
 
+#ifdef CONFIG_X86_VSYSCALL_EMULATION
 static void __init pti_setup_vsyscall(void)
 {
 	pte_t *pte, *target_pte;
@@ -290,8 +300,14 @@ static void __init pti_setup_vsyscall(void)
 static void __init pti_setup_vsyscall(void) { }
 #endif
 
+enum pti_clone_level {
+	PTI_CLONE_PMD,
+	PTI_CLONE_PTE,
+};
+
 static void
-pti_clone_pmds(unsigned long start, unsigned long end)
+pti_clone_pgtable(unsigned long start, unsigned long end,
+		  enum pti_clone_level level)
 {
 	unsigned long addr;
 
@@ -299,7 +315,8 @@ pti_clone_pmds(unsigned long start, unsigned long end)
 	 * Clone the populated PMDs which cover start to end. These PMD areas
 	 * can have holes.
 	 */
-	for (addr = start; addr < end; addr += PMD_SIZE) {
+	for (addr = start; addr < end;) {
+		pte_t *pte, *target_pte;
 		pmd_t *pmd, *target_pmd;
 		pgd_t *pgd;
 		p4d_t *p4d;
@@ -315,44 +332,84 @@ pti_clone_pmds(unsigned long start, unsigned long end)
 		p4d = p4d_offset(pgd, addr);
 		if (WARN_ON(p4d_none(*p4d)))
 			return;
+
 		pud = pud_offset(p4d, addr);
-		if (pud_none(*pud))
+		if (pud_none(*pud)) {
+			addr += PUD_SIZE;
 			continue;
+		}
+
 		pmd = pmd_offset(pud, addr);
-		if (pmd_none(*pmd))
+		if (pmd_none(*pmd)) {
+			addr += PMD_SIZE;
 			continue;
+		}
 
-		target_pmd = pti_user_pagetable_walk_pmd(addr);
-		if (WARN_ON(!target_pmd))
-			return;
-
-		/*
-		 * Only clone present PMDs.  This ensures only setting
-		 * _PAGE_GLOBAL on present PMDs.  This should only be
-		 * called on well-known addresses anyway, so a non-
-		 * present PMD would be a surprise.
-		 */
-		if (WARN_ON(!(pmd_flags(*pmd) & _PAGE_PRESENT)))
-			return;
-
-		/*
-		 * Setting 'target_pmd' below creates a mapping in both
-		 * the user and kernel page tables.  It is effectively
-		 * global, so set it as global in both copies.  Note:
-		 * the X86_FEATURE_PGE check is not _required_ because
-		 * the CPU ignores _PAGE_GLOBAL when PGE is not
-		 * supported.  The check keeps consistentency with
-		 * code that only set this bit when supported.
-		 */
-		if (boot_cpu_has(X86_FEATURE_PGE))
-			*pmd = pmd_set_flags(*pmd, _PAGE_GLOBAL);
-
-		/*
-		 * Copy the PMD.  That is, the kernelmode and usermode
-		 * tables will share the last-level page tables of this
-		 * address range
-		 */
-		*target_pmd = *pmd;
+		if (pmd_large(*pmd) || level == PTI_CLONE_PMD) {
+			target_pmd = pti_user_pagetable_walk_pmd(addr);
+			if (WARN_ON(!target_pmd))
+				return;
+
+			/*
+			 * Only clone present PMDs.  This ensures only setting
+			 * _PAGE_GLOBAL on present PMDs.  This should only be
+			 * called on well-known addresses anyway, so a non-
+			 * present PMD would be a surprise.
+			 */
+			if (WARN_ON(!(pmd_flags(*pmd) & _PAGE_PRESENT)))
+				return;
+
+			/*
+			 * Setting 'target_pmd' below creates a mapping in both
+			 * the user and kernel page tables.  It is effectively
+			 * global, so set it as global in both copies.  Note:
+			 * the X86_FEATURE_PGE check is not _required_ because
+			 * the CPU ignores _PAGE_GLOBAL when PGE is not
+			 * supported.  The check keeps consistentency with
+			 * code that only set this bit when supported.
+			 */
+			if (boot_cpu_has(X86_FEATURE_PGE))
+				*pmd = pmd_set_flags(*pmd, _PAGE_GLOBAL);
+
+			/*
+			 * Copy the PMD.  That is, the kernelmode and usermode
+			 * tables will share the last-level page tables of this
+			 * address range
+			 */
+			*target_pmd = *pmd;
+
+			addr += PMD_SIZE;
+
+		} else if (level == PTI_CLONE_PTE) {
+
+			/* Walk the page-table down to the pte level */
+			pte = pte_offset_kernel(pmd, addr);
+			if (pte_none(*pte)) {
+				addr += PAGE_SIZE;
+				continue;
+			}
+
+			/* Only clone present PTEs */
+			if (WARN_ON(!(pte_flags(*pte) & _PAGE_PRESENT)))
+				return;
+
+			/* Allocate PTE in the user page-table */
+			target_pte = pti_user_pagetable_walk_pte(addr);
+			if (WARN_ON(!target_pte))
+				return;
+
+			/* Set GLOBAL bit in both PTEs */
+			if (boot_cpu_has(X86_FEATURE_PGE))
+				*pte = pte_set_flags(*pte, _PAGE_GLOBAL);
+
+			/* Clone the PTE */
+			*target_pte = *pte;
+
+			addr += PAGE_SIZE;
+
+		} else {
+			BUG();
+		}
 	}
 }
 
@@ -398,7 +455,7 @@ static void __init pti_clone_user_shared(void)
 	start = CPU_ENTRY_AREA_BASE;
 	end   = start + (PAGE_SIZE * CPU_ENTRY_AREA_PAGES);
 
-	pti_clone_pmds(start, end);
+	pti_clone_pgtable(start, end, PTI_CLONE_PMD);
 }
 #endif /* CONFIG_X86_64 */
 
@@ -417,8 +474,9 @@ static void __init pti_setup_espfix64(void)
  */
 static void pti_clone_entry_text(void)
 {
-	pti_clone_pmds((unsigned long) __entry_text_start,
-		       (unsigned long) __irqentry_text_end);
+	pti_clone_pgtable((unsigned long) __entry_text_start,
+			  (unsigned long) __irqentry_text_end,
+			  PTI_CLONE_PMD);
 }
 
 /*
@@ -500,10 +558,10 @@ static void pti_clone_kernel_text(void)
 	 * pti_set_kernel_image_nonglobal() did to clear the
 	 * global bit.
 	 */
-	pti_clone_pmds(start, end_clone);
+	pti_clone_pgtable(start, end_clone, PTI_LEVEL_KERNEL_IMAGE);
 
 	/*
-	 * pti_clone_pmds() will set the global bit in any PMDs
+	 * pti_clone_pgtable() will set the global bit in any PMDs
 	 * that it clones, but we also need to get any PTEs in
 	 * the last level for areas that are not huge-page-aligned.
 	 */
-- 
2.7.4

