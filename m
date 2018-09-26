Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A068C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE73C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rE0laMPd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE73C214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbeIZSIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:08:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbeIZSIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:08:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aaiTxqjuwEt1CjB6UBF0EKgCYMTbvgoKK5cB1HwCicU=; b=rE0laMPdZ+lJPFMsKUkkSf4cKT
        H5hNfTI1XW2vLuEVOK1kFsZpSiglLfxlJzl91+T/0H6I4VcwCELGeft8J/rLMxcwqcHMTYYFrUrFl
        RKtw+vgmNL+g5SrDgLw6QUxFMtxdh/7x96mJZcZadAGgV6T7Wyn2WTduILBUeSCjtmGSczlsW6ryq
        WI7zt+0btuCFpi6xxhrZeozLcc03hdA6bMXHGmwDHw7uN9V9XxQzBhXHh7YlcWZX96OngwiCwonKc
        8tH4m7q0+FzssudKZSB5wVGSuQC1sDB36QHs2GL2RE6wMTMIIg2lruIMsdI2qXrSj+eq6iEPAZoXN
        LT9VsY4w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g58Oc-000610-Kf; Wed, 26 Sep 2018 11:54:42 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9281F206F1810; Wed, 26 Sep 2018 13:54:04 +0200 (CEST)
Message-ID: <20180926114800.875099964@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 26 Sep 2018 13:36:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Subject: [PATCH 07/18] asm-generic/tlb: Invert HAVE_RCU_TABLE_INVALIDATE
References: <20180926113623.863696043@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make issuing a TLB invalidate for page-table pages the normal case.

The reason is twofold:

 - too many invalidates is safer than too few,
 - most architectures use the linux page-tables natively
   and would thus require this.

Make it an opt-out, instead of an opt-in.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/Kconfig              |    2 +-
 arch/arm64/Kconfig        |    1 -
 arch/powerpc/Kconfig      |    1 +
 arch/sparc/Kconfig        |    1 +
 arch/x86/Kconfig          |    1 -
 include/asm-generic/tlb.h |    9 +++++----
 mm/mmu_gather.c           |    2 +-
 7 files changed, 9 insertions(+), 8 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -362,7 +362,7 @@ config HAVE_ARCH_JUMP_LABEL
 config HAVE_RCU_TABLE_FREE
 	bool
 
-config HAVE_RCU_TABLE_INVALIDATE
+config HAVE_RCU_TABLE_NO_INVALIDATE
 	bool
 
 config HAVE_MMU_GATHER_PAGE_SIZE
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -142,7 +142,6 @@ config ARM64
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RCU_TABLE_FREE
-	select HAVE_RCU_TABLE_INVALIDATE
 	select HAVE_RSEQ
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -216,6 +216,7 @@ config PPC
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE		if SMP
+	select HAVE_RCU_TABLE_NO_INVALIDATE	if HAVE_RCU_TABLE_FREE
 	select HAVE_MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC64 && CPU_LITTLE_ENDIAN
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -64,6 +64,7 @@ config SPARC64
 	select HAVE_KRETPROBES
 	select HAVE_KPROBES
 	select HAVE_RCU_TABLE_FREE if SMP
+	select HAVE_RCU_TABLE_NO_INVALIDATE if HAVE_RCU_TABLE_FREE
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
 	select HAVE_DYNAMIC_FTRACE
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -181,7 +181,6 @@ config X86
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_RCU_TABLE_FREE		if PARAVIRT
-	select HAVE_RCU_TABLE_INVALIDATE	if HAVE_RCU_TABLE_FREE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if X86_64 && (UNWINDER_FRAME_POINTER || UNWINDER_ORC) && STACK_VALIDATION
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -127,11 +127,12 @@
  *  When used, an architecture is expected to provide __tlb_remove_table()
  *  which does the actual freeing of these pages.
  *
- *  HAVE_RCU_TABLE_INVALIDATE
+ *  HAVE_RCU_TABLE_NO_INVALIDATE
  *
- *  This makes HAVE_RCU_TABLE_FREE call tlb_flush_mmu_tlbonly() before freeing
- *  the page-table pages. Required if you use HAVE_RCU_TABLE_FREE and your
- *  architecture uses the Linux page-tables natively.
+ *  This makes HAVE_RCU_TABLE_FREE avoid calling tlb_flush_mmu_tlbonly() before
+ *  freeing the page-table pages. This can be avoided if you use
+ *  HAVE_RCU_TABLE_FREE and your architecture does _NOT_ use the Linux
+ *  page-tables natively.
  *
  */
 #define HAVE_GENERIC_MMU_GATHER
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -157,7 +157,7 @@ bool __tlb_remove_page_size(struct mmu_g
  */
 static inline void tlb_table_invalidate(struct mmu_gather *tlb)
 {
-#ifdef CONFIG_HAVE_RCU_TABLE_INVALIDATE
+#ifndef CONFIG_HAVE_RCU_TABLE_NO_INVALIDATE
 	/*
 	 * Invalidate page-table caches used by hardware walkers. Then we still
 	 * need to RCU-sched wait while freeing the pages because software


