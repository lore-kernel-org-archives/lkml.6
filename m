Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DD9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F7D2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k1aesh8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfBSKdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:33:20 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55608 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbfBSKdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FNsWh74kzV1TOR4F01eM2Vp8b7v4O6aBxyOGm5+4Sns=; b=k1aesh8Pj5v0Ave60ICG3GY5PJ
        sLSCyE3xHGmhRGtKKa6xwJqaxZ3TNb8KqMDsGKVNP8KXIc+FVyAy+4deOeek8KW0Y2Pn9xNsKJkez
        NjnlH5i+DltZRlRzM7BWsS/9tYXqGXGlzIpxxLEANM3A9OMFNHsC/v4eBdw0nLNSPEV/Cf/ae1luF
        Z4WCjenzQEli/gJIE483INy66ze8RVZaiMRxYSrDdy8GZDHM+fgEuR5qQk7kx2JDhtwgtFZ5e6agE
        VcItGXWZhh8YrEGZa+eCVmblGHYey3mtxlqv5yQJfg5++6RmW/XijzRABUWNpv9HBwJcaIa0C4oGJ
        aWZXKbPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gw2hm-0000dX-01; Tue, 19 Feb 2019 10:32:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4E1CD285202C5; Tue, 19 Feb 2019 11:32:48 +0100 (CET)
Message-Id: <20190219103233.030444300@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 19 Feb 2019 11:31:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com,
        David Miller <davem@davemloft.net>,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCH v6 03/18] asm-generic/tlb: Provide generic VIPT cache flush
References: <20190219103148.192029670@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The one obvious thing SH and ARM want is a sensible default for
tlb_start_vma(). (also: https://lkml.org/lkml/2004/1/15/6 )

Avoid all VIPT architectures providing their own tlb_start_vma()
implementation and rely on architectures to provide a no-op
flush_cache_range() when it is not relevant.

The below makes tlb_start_vma() default to flush_cache_range(), which
should be right and sufficient. The only exceptions that I found where
(oddly):

  - m68k-mmu
  - sparc64
  - unicore

Those architectures appear to have flush_cache_range(), but their
current tlb_start_vma() does not call it.

Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: David Miller <davem@davemloft.net>
Cc: Guan Xuetao <gxt@pku.edu.cn>
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arc/include/asm/tlb.h      |    9 ---------
 arch/mips/include/asm/tlb.h     |    9 ---------
 arch/nds32/include/asm/tlb.h    |    6 ------
 arch/nios2/include/asm/tlb.h    |   10 ----------
 arch/parisc/include/asm/tlb.h   |    5 -----
 arch/sparc/include/asm/tlb_32.h |    5 -----
 arch/xtensa/include/asm/tlb.h   |    9 ---------
 include/asm-generic/tlb.h       |   19 +++++++++++--------
 8 files changed, 11 insertions(+), 61 deletions(-)

--- a/arch/arc/include/asm/tlb.h
+++ b/arch/arc/include/asm/tlb.h
@@ -23,15 +23,6 @@ do {						\
  *
  * Note, read http://lkml.org/lkml/2004/1/15/6
  */
-#ifndef CONFIG_ARC_CACHE_VIPT_ALIASING
-#define tlb_start_vma(tlb, vma)
-#else
-#define tlb_start_vma(tlb, vma)						\
-do {									\
-	if (!tlb->fullmm)						\
-		flush_cache_range(vma, vma->vm_start, vma->vm_end);	\
-} while(0)
-#endif
 
 #define tlb_end_vma(tlb, vma)						\
 do {									\
--- a/arch/mips/include/asm/tlb.h
+++ b/arch/mips/include/asm/tlb.h
@@ -5,15 +5,6 @@
 #include <asm/cpu-features.h>
 #include <asm/mipsregs.h>
 
-/*
- * MIPS doesn't need any special per-pte or per-vma handling, except
- * we need to flush cache for area to be unmapped.
- */
-#define tlb_start_vma(tlb, vma)					\
-	do {							\
-		if (!tlb->fullmm)				\
-			flush_cache_range(vma, vma->vm_start, vma->vm_end); \
-	}  while (0)
 #define tlb_end_vma(tlb, vma) do { } while (0)
 #define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
 
--- a/arch/nds32/include/asm/tlb.h
+++ b/arch/nds32/include/asm/tlb.h
@@ -4,12 +4,6 @@
 #ifndef __ASMNDS32_TLB_H
 #define __ASMNDS32_TLB_H
 
-#define tlb_start_vma(tlb,vma)						\
-	do {								\
-		if (!tlb->fullmm)					\
-			flush_cache_range(vma, vma->vm_start, vma->vm_end); \
-	} while (0)
-
 #define tlb_end_vma(tlb,vma)				\
 	do { 						\
 		if(!tlb->fullmm)			\
--- a/arch/nios2/include/asm/tlb.h
+++ b/arch/nios2/include/asm/tlb.h
@@ -15,16 +15,6 @@
 
 extern void set_mmu_pid(unsigned long pid);
 
-/*
- * NiosII doesn't need any special per-pte or per-vma handling, except
- * we need to flush cache for the area to be unmapped.
- */
-#define tlb_start_vma(tlb, vma)					\
-	do {							\
-		if (!tlb->fullmm)				\
-			flush_cache_range(vma, vma->vm_start, vma->vm_end); \
-	}  while (0)
-
 #define tlb_end_vma(tlb, vma)	do { } while (0)
 #define __tlb_remove_tlb_entry(tlb, ptep, address)	do { } while (0)
 
--- a/arch/parisc/include/asm/tlb.h
+++ b/arch/parisc/include/asm/tlb.h
@@ -7,11 +7,6 @@ do {	if ((tlb)->fullmm)		\
 		flush_tlb_mm((tlb)->mm);\
 } while (0)
 
-#define tlb_start_vma(tlb, vma) \
-do {	if (!(tlb)->fullmm)	\
-		flush_cache_range(vma, vma->vm_start, vma->vm_end); \
-} while (0)
-
 #define tlb_end_vma(tlb, vma)	\
 do {	if (!(tlb)->fullmm)	\
 		flush_tlb_range(vma, vma->vm_start, vma->vm_end); \
--- a/arch/sparc/include/asm/tlb_32.h
+++ b/arch/sparc/include/asm/tlb_32.h
@@ -2,11 +2,6 @@
 #ifndef _SPARC_TLB_H
 #define _SPARC_TLB_H
 
-#define tlb_start_vma(tlb, vma) \
-do {								\
-	flush_cache_range(vma, vma->vm_start, vma->vm_end);	\
-} while (0)
-
 #define tlb_end_vma(tlb, vma) \
 do {								\
 	flush_tlb_range(vma, vma->vm_start, vma->vm_end);	\
--- a/arch/xtensa/include/asm/tlb.h
+++ b/arch/xtensa/include/asm/tlb.h
@@ -16,19 +16,10 @@
 
 #if (DCACHE_WAY_SIZE <= PAGE_SIZE)
 
-/* Note, read http://lkml.org/lkml/2004/1/15/6 */
-
-# define tlb_start_vma(tlb,vma)			do { } while (0)
 # define tlb_end_vma(tlb,vma)			do { } while (0)
 
 #else
 
-# define tlb_start_vma(tlb, vma)					      \
-	do {								      \
-		if (!tlb->fullmm)					      \
-			flush_cache_range(vma, vma->vm_start, vma->vm_end);   \
-	} while(0)
-
 # define tlb_end_vma(tlb, vma)						      \
 	do {								      \
 		if (!tlb->fullmm)					      \
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -19,6 +19,7 @@
 #include <linux/swap.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
+#include <asm/cacheflush.h>
 
 #ifdef CONFIG_MMU
 
@@ -351,17 +352,19 @@ static inline unsigned long tlb_get_unma
  * the vmas are adjusted to only cover the region to be torn down.
  */
 #ifndef tlb_start_vma
-#define tlb_start_vma(tlb, vma) do { } while (0)
+#define tlb_start_vma(tlb, vma)						\
+do {									\
+	if (!tlb->fullmm)						\
+		flush_cache_range(vma, vma->vm_start, vma->vm_end);	\
+} while (0)
 #endif
 
-#define __tlb_end_vma(tlb, vma)					\
-	do {							\
-		if (!tlb->fullmm)				\
-			tlb_flush_mmu_tlbonly(tlb);		\
-	} while (0)
-
 #ifndef tlb_end_vma
-#define tlb_end_vma	__tlb_end_vma
+#define tlb_end_vma(tlb, vma)						\
+do {									\
+	if (!tlb->fullmm)						\
+		tlb_flush_mmu_tlbonly(tlb);				\
+} while (0)
 #endif
 
 #ifndef __tlb_remove_tlb_entry


