Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64918C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEC72401D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 05:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEC72401D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753388AbeGEF1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 01:27:49 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:60518 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750904AbeGEF1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:27:47 -0400
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id 2D37C3A6821;
        Thu,  5 Jul 2018 07:13:14 +0200 (CEST)
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E6775240007;
        Thu,  5 Jul 2018 05:13:02 +0000 (UTC)
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
Subject: [PATCH v2 01/11] hugetlb: Harmonize hugetlb.h arch specific defines with pgtable.h
Date:   Thu,  5 Jul 2018 05:12:32 +0000
Message-Id: <20180705051242.694-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180705050323.301-1-alex@ghiti.fr>
References: <20180705050323.301-1-alex@ghiti.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm-generic/hugetlb.h proposes generic implementations of hugetlb
related functions: use __HAVE_ARCH_HUGE* defines in order to make arch
specific implementations of hugetlb functions consistent with pgtable.h
scheme.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/arm64/include/asm/hugetlb.h | 2 +-
 include/asm-generic/hugetlb.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index e73f68569624..3fcf14663dfa 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -81,9 +81,9 @@ extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
 				    unsigned long addr, pte_t *ptep);
 extern void huge_ptep_clear_flush(struct vm_area_struct *vma,
 				  unsigned long addr, pte_t *ptep);
+#define __HAVE_ARCH_HUGE_PTE_CLEAR
 extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, unsigned long sz);
-#define huge_pte_clear huge_pte_clear
 extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
 				 pte_t *ptep, pte_t pte, unsigned long sz);
 #define set_huge_swap_pte_at set_huge_swap_pte_at
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 9d0cde8ab716..3da7cff52360 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -32,7 +32,7 @@ static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
 	return pte_modify(pte, newprot);
 }
 
-#ifndef huge_pte_clear
+#ifndef __HAVE_ARCH_HUGE_PTE_CLEAR
 static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 		    pte_t *ptep, unsigned long sz)
 {
-- 
2.16.2

