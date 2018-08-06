Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD69C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846F6208B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 18:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 846F6208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387457AbeHFUOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:14:20 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:42965 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733004AbeHFUOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:14:20 -0400
X-Originating-IP: 79.86.19.127
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2999260010;
        Mon,  6 Aug 2018 18:04:00 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     linux-mm@kvack.org, mike.kravetz@oracle.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v6 06/11] hugetlb: Introduce generic version of huge_pte_none
Date:   Mon,  6 Aug 2018 17:57:06 +0000
Message-Id: <20180806175711.24438-7-alex@ghiti.fr>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180806175711.24438-1-alex@ghiti.fr>
References: <20180806175711.24438-1-alex@ghiti.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm, arm64, ia64, mips, parisc, powerpc, sh, sparc, x86 architectures
use the same version of huge_pte_none, so move this generic
implementation into asm-generic/hugetlb.h.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Tested-by: Helge Deller <deller@gmx.de> # parisc
Acked-by: Catalin Marinas <catalin.marinas@arm.com> # arm64
Acked-by: Paul Burton <paul.burton@mips.com> # MIPS parts
Reviewed-by: Luiz Capitulino <lcapitulino@redhat.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/arm/include/asm/hugetlb.h     | 5 -----
 arch/arm64/include/asm/hugetlb.h   | 5 -----
 arch/ia64/include/asm/hugetlb.h    | 5 -----
 arch/mips/include/asm/hugetlb.h    | 1 +
 arch/parisc/include/asm/hugetlb.h  | 5 -----
 arch/powerpc/include/asm/hugetlb.h | 5 -----
 arch/sh/include/asm/hugetlb.h      | 5 -----
 arch/sparc/include/asm/hugetlb.h   | 5 -----
 arch/x86/include/asm/hugetlb.h     | 5 -----
 include/asm-generic/hugetlb.h      | 7 +++++++
 10 files changed, 8 insertions(+), 40 deletions(-)

diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
index 537660891f9f..c821b550d6a4 100644
--- a/arch/arm/include/asm/hugetlb.h
+++ b/arch/arm/include/asm/hugetlb.h
@@ -44,11 +44,6 @@ static inline int prepare_hugepage_range(struct file *file,
 	return 0;
 }
 
-static inline int huge_pte_none(pte_t pte)
-{
-	return pte_none(pte);
-}
-
 static inline pte_t huge_pte_wrprotect(pte_t pte)
 {
 	return pte_wrprotect(pte);
diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 4c8dd488554d..49247c6f94db 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -42,11 +42,6 @@ static inline int prepare_hugepage_range(struct file *file,
 	return 0;
 }
 
-static inline int huge_pte_none(pte_t pte)
-{
-	return pte_none(pte);
-}
-
 static inline pte_t huge_pte_wrprotect(pte_t pte)
 {
 	return pte_wrprotect(pte);
diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
index 41b5f6adeee4..bf573500b3c4 100644
--- a/arch/ia64/include/asm/hugetlb.h
+++ b/arch/ia64/include/asm/hugetlb.h
@@ -26,11 +26,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 {
 }
 
-static inline int huge_pte_none(pte_t pte)
-{
-	return pte_none(pte);
-}
-
 static inline pte_t huge_pte_wrprotect(pte_t pte)
 {
 	return pte_wrprotect(pte);
diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
index 7df1f116a3cc..1c9c4531376c 100644
--- a/arch/mips/include/asm/hugetlb.h
+++ b/arch/mips/include/asm/hugetlb.h
@@ -55,6 +55,7 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 	flush_tlb_page(vma, addr & huge_page_mask(hstate_vma(vma)));
 }
 
+#define __HAVE_ARCH_HUGE_PTE_NONE
 static inline int huge_pte_none(pte_t pte)
 {
 	unsigned long val = pte_val(pte) & ~_PAGE_GLOBAL;
diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
index 9afff26747a1..c09d8c74553c 100644
--- a/arch/parisc/include/asm/hugetlb.h
+++ b/arch/parisc/include/asm/hugetlb.h
@@ -38,11 +38,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 {
 }
 
-static inline int huge_pte_none(pte_t pte)
-{
-	return pte_none(pte);
-}
-
 static inline pte_t huge_pte_wrprotect(pte_t pte)
 {
 	return pte_wrprotect(pte);
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 0b02856aa85b..3562d46585ba 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -152,11 +152,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 	flush_hugetlb_page(vma, addr);
 }
 
-static inline int huge_pte_none(pte_t pte)
-{
-	return pte_none(pte);
-}
-
 static inline pte_t huge_pte_wrprotect(pte_t pte)
 {
 	return pte_wrprotect(pte);
diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
index 9abf9c86b769..a9f8266f33cf 100644
--- a/arch/sh/include/asm/hugetlb.h
+++ b/arch/sh/include/asm/hugetlb.h
@@ -31,11 +31,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 {
 }
 
-static inline int huge_pte_none(pte_t pte)
-{
-	return pte_none(pte);
-}
-
 static inline pte_t huge_pte_wrprotect(pte_t pte)
 {
 	return pte_wrprotect(pte);
diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index 651a9593fcee..11115bbd712e 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -48,11 +48,6 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 {
 }
 
-static inline int huge_pte_none(pte_t pte)
-{
-	return pte_none(pte);
-}
-
 static inline pte_t huge_pte_wrprotect(pte_t pte)
 {
 	return pte_wrprotect(pte);
diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
index fd59673e7a0a..42d872054791 100644
--- a/arch/x86/include/asm/hugetlb.h
+++ b/arch/x86/include/asm/hugetlb.h
@@ -28,11 +28,6 @@ static inline int prepare_hugepage_range(struct file *file,
 	return 0;
 }
 
-static inline int huge_pte_none(pte_t pte)
-{
-	return pte_none(pte);
-}
-
 static inline pte_t huge_pte_wrprotect(pte_t pte)
 {
 	return pte_wrprotect(pte);
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index ffa63fd8388d..2fc3d68424e9 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -73,4 +73,11 @@ static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 }
 #endif
 
+#ifndef __HAVE_ARCH_HUGE_PTE_NONE
+static inline int huge_pte_none(pte_t pte)
+{
+	return pte_none(pte);
+}
+#endif
+
 #endif /* _ASM_GENERIC_HUGETLB_H */
-- 
2.16.2

