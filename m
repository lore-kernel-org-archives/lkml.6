Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F39C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366CF206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 09:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SAPuWZxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366CF206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeIMOje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 10:39:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54774 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727996AbeIMOje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 10:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8SZF02odPbsQ4xvgQWyvxT1sx9U/BZ3+F6zLfQjUdFU=; b=SAPuWZxE8US/drkjmCPvaY4SGz
        nDXhcIA2qU091yXD2HQ6jmZmqbtLzEzwgv3TKWnrdjAXDWslYqEEL29XCWq4L8cNkqCAN6+UimrBO
        6Fmz5ogiDd5vP8ioRckIwaZqqQvwPYpy+CZzHdMWLq46QtZNQTxNpnUM9KpySkVDP262Sr0i/Y5ry
        eVPw37h2qjzRFNYSfsuz1q7zwfSj4h1suU3WAiVMISnL5/5ELIubpha14EgaFxpB7DJSewcqt12YY
        //ymUPpSR8g3Ib2EG3PN7Tpyk5J6pO2BL6L7XcQZKJtsasiqIHT7+lURbn8QdsEN1FWYxNXUG68n0
        RkJNUCdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g0Nw0-0000yn-SG; Thu, 13 Sep 2018 09:29:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4738020587E51; Thu, 13 Sep 2018 11:29:10 +0200 (CEST)
Message-ID: <20180913092812.071989585@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 13 Sep 2018 11:21:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com,
        David Miller <davem@davemloft.net>,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [RFC][PATCH 04/11] asm-generic/tlb: Provide generic VIPT cache flush
References: <20180913092110.817204997@infradead.org>
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

Cc: Will Deacon <will.deacon@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: David Miller <davem@davemloft.net>
Cc: Guan Xuetao <gxt@pku.edu.cn>
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


