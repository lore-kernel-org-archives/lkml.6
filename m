Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181D0C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD8123DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD8123DEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753915AbeGELQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:16:01 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:35957 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753488AbeGELP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:15:58 -0400
X-Originating-IP: 79.86.19.127
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id D88F7C000D;
        Thu,  5 Jul 2018 11:15:45 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v4 07/11] hugetlb: Introduce generic version of huge_pte_wrprotect
Date:   Thu,  5 Jul 2018 11:07:12 +0000
Message-Id: <20180705110716.3919-8-alex@ghiti.fr>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180705110716.3919-1-alex@ghiti.fr>
References: <20180705110716.3919-1-alex@ghiti.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm, arm64, ia64, mips, parisc, powerpc, sh, sparc, x86
architectures use the same version of huge_pte_wrprotect, so move
this generic implementation into asm-generic/hugetlb.h.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/arm/include/asm/hugetlb.h     | 5 -----
 arch/arm64/include/asm/hugetlb.h   | 5 -----
 arch/ia64/include/asm/hugetlb.h    | 5 -----
 arch/mips/include/asm/hugetlb.h    | 5 -----
 arch/parisc/include/asm/hugetlb.h  | 5 -----
 arch/powerpc/include/asm/hugetlb.h | 5 -----
 arch/sh/include/asm/hugetlb.h      | 5 -----
 arch/sparc/include/asm/hugetlb.h   | 5 -----
 arch/x86/include/asm/hugetlb.h     | 5 -----
 include/asm-generic/hugetlb.h      | 7 +++++++
 10 files changed, 7 insertions(+), 45 deletions(-)

diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
index 3d2ce4dbc145..1e718a626ef9 100644
--- a/arch/arm/include/asm/hugetlb.h
+++ b/arch/arm/include/asm/hugetlb.h
@@ -43,11 +43,6 @@ static inline int prepare_hugepage_range(struct file *file,
 	return 0;
 }
 
-static inline pte_t huge_pte_wrprotect(pte_t pte)
-{
-	return pte_wrprotect(pte);
-}
-
 static inline void arch_clear_hugepage_flags(struct page *page)
 {
 	clear_bit(PG_dcache_clean, &page->flags);
diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 49247c6f94db..1fd64ebf0cd7 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -42,11 +42,6 @@ static inline int prepare_hugepage_range(struct file *file,
 	return 0;
 }
 
-static inline pte_t huge_pte_wrprotect(pte_t pte)
-{
-	return pte_wrprotect(pte);
-}
-
 static inline void arch_clear_hugepage_flags(struct page *page)
 {
 	clear_bit(PG_dcache_clean, &page->flags);
diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
index bf573500b3c4..82fe3d7a38d9 100644
--- a/arch/ia64/include/asm/hugetlb.h
+++ b/arch/ia64/include/asm/hugetlb.h
@@ -26,11 +26,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 {
 }
 
-static inline pte_t huge_pte_wrprotect(pte_t pte)
-{
-	return pte_wrprotect(pte);
-}
-
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
index 1c9c4531376c..b3d6bb53ee6e 100644
--- a/arch/mips/include/asm/hugetlb.h
+++ b/arch/mips/include/asm/hugetlb.h
@@ -62,11 +62,6 @@ static inline int huge_pte_none(pte_t pte)
 	return !val || (val == (unsigned long)invalid_pte_table);
 }
 
-static inline pte_t huge_pte_wrprotect(pte_t pte)
-{
-	return pte_wrprotect(pte);
-}
-
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
index c09d8c74553c..5a102d7251e4 100644
--- a/arch/parisc/include/asm/hugetlb.h
+++ b/arch/parisc/include/asm/hugetlb.h
@@ -38,11 +38,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 {
 }
 
-static inline pte_t huge_pte_wrprotect(pte_t pte)
-{
-	return pte_wrprotect(pte);
-}
-
 void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep);
 
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 3562d46585ba..7123599089c6 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -152,11 +152,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 	flush_hugetlb_page(vma, addr);
 }
 
-static inline pte_t huge_pte_wrprotect(pte_t pte)
-{
-	return pte_wrprotect(pte);
-}
-
 extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 				      unsigned long addr, pte_t *ptep,
 				      pte_t pte, int dirty);
diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
index a9f8266f33cf..54f65094efe6 100644
--- a/arch/sh/include/asm/hugetlb.h
+++ b/arch/sh/include/asm/hugetlb.h
@@ -31,11 +31,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 {
 }
 
-static inline pte_t huge_pte_wrprotect(pte_t pte)
-{
-	return pte_wrprotect(pte);
-}
-
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index 11115bbd712e..f661362376e0 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -48,11 +48,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 {
 }
 
-static inline pte_t huge_pte_wrprotect(pte_t pte)
-{
-	return pte_wrprotect(pte);
-}
-
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
index c5fdc53b6e41..19668672ab37 100644
--- a/arch/x86/include/asm/hugetlb.h
+++ b/arch/x86/include/asm/hugetlb.h
@@ -27,11 +27,6 @@ static inline int prepare_hugepage_range(struct file *file,
 	return 0;
 }
 
-static inline pte_t huge_pte_wrprotect(pte_t pte)
-{
-	return pte_wrprotect(pte);
-}
-
 static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 					   unsigned long addr, pte_t *ptep)
 {
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 2fc3d68424e9..cd9697672b79 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -80,4 +80,11 @@ static inline int huge_pte_none(pte_t pte)
 }
 #endif
 
+#ifndef __HAVE_ARCH_HUGE_PTE_WRPROTECT
+static inline pte_t huge_pte_wrprotect(pte_t pte)
+{
+	return pte_wrprotect(pte);
+}
+#endif
+
 #endif /* _ASM_GENERIC_HUGETLB_H */
-- 
2.16.2

