Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5912DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7732082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7732082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeH3USn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:18:43 -0400
Received: from foss.arm.com ([217.140.101.70]:44906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbeH3USn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:18:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28EED1C01;
        Thu, 30 Aug 2018 09:15:50 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EEE783F738;
        Thu, 30 Aug 2018 09:15:49 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id D8F4B1AE3A8C; Thu, 30 Aug 2018 17:16:01 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, benh@au1.ibm.com,
        torvalds@linux-foundation.org, npiggin@gmail.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 12/12] arm64: tlb: Rewrite stale comment in asm/tlbflush.h
Date:   Thu, 30 Aug 2018 17:15:46 +0100
Message-Id: <1535645747-9823-13-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Z asked me to justify the barrier usage in asm/tlbflush.h, but
actually that whole block comment needs to be rewritten.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 80 +++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index c98ed8871030..c3c0387aee18 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -70,43 +70,73 @@
 	})
 
 /*
- *	TLB Management
- *	==============
+ *	TLB Invalidation
+ *	================
  *
- *	The TLB specific code is expected to perform whatever tests it needs
- *	to determine if it should invalidate the TLB for each call.  Start
- *	addresses are inclusive and end addresses are exclusive; it is safe to
- *	round these addresses down.
+ * 	This header file implements the low-level TLB invalidation routines
+ *	(sometimes referred to as "flushing" in the kernel) for arm64.
  *
- *	flush_tlb_all()
+ *	Every invalidation operation uses the following template:
+ *
+ *	DSB ISHST	// Ensure prior page-table updates have completed
+ *	TLBI ...	// Invalidate the TLB
+ *	DSB ISH		// Ensure the TLB invalidation has completed
+ *      if (invalidated kernel mappings)
+ *		ISB	// Discard any instructions fetched from the old mapping
+ *
+ *
+ *	The following functions form part of the "core" TLB invalidation API,
+ *	as documented in Documentation/core-api/cachetlb.rst:
  *
- *		Invalidate the entire TLB.
+ *	flush_tlb_all()
+ *		Invalidate the entire TLB (kernel + user) on all CPUs
  *
  *	flush_tlb_mm(mm)
+ *		Invalidate an entire user address space on all CPUs.
+ *		The 'mm' argument identifies the ASID to invalidate.
+ *
+ *	flush_tlb_range(vma, start, end)
+ *		Invalidate the virtual-address range '[start, end)' on all
+ *		CPUs for the user address space corresponding to 'vma->mm'.
+ *		Note that this operation also invalidates any walk-cache
+ *		entries associated with translations for the specified address
+ *		range.
+ *
+ *	flush_tlb_kernel_range(start, end)
+ *		Same as flush_tlb_range(..., start, end), but applies to
+ * 		kernel mappings rather than a particular user address space.
+ *		Whilst not explicitly documented, this function is used when
+ *		unmapping pages from vmalloc/io space.
+ *
+ *	flush_tlb_page(vma, addr)
+ *		Invalidate a single user mapping for address 'addr' in the
+ *		address space corresponding to 'vma->mm'.  Note that this
+ *		operation only invalidates a single, last-level page-table
+ *		entry and therefore does not affect any walk-caches.
  *
- *		Invalidate all TLB entries in a particular address space.
- *		- mm	- mm_struct describing address space
  *
- *	flush_tlb_range(mm,start,end)
+ *	Next, we have some undocumented invalidation routines that you probably
+ *	don't want to call unless you know what you're doing:
  *
- *		Invalidate a range of TLB entries in the specified address
- *		space.
- *		- mm	- mm_struct describing address space
- *		- start - start address (may not be aligned)
- *		- end	- end address (exclusive, may not be aligned)
+ *	local_flush_tlb_all()
+ *		Same as flush_tlb_all(), but only applies to the calling CPU.
  *
- *	flush_tlb_page(vaddr,vma)
+ *	__flush_tlb_kernel_pgtable(addr)
+ *		Invalidate a single kernel mapping for address 'addr' on all
+ *		CPUs, ensuring that any walk-cache entries associated with the
+ *		translation are also invalidated.
  *
- *		Invalidate the specified page in the specified address range.
- *		- vaddr - virtual address (may not be aligned)
- *		- vma	- vma_struct describing address range
+ *	__flush_tlb_range(vma, start, end, stride, last_level)
+ *		Invalidate the virtual-address range '[start, end)' on all
+ *		CPUs for the user address space corresponding to 'vma->mm'.
+ *		The invalidation operations are issued at a granularity
+ *		determined by 'stride' and only affect any walk-cache entries
+ *		if 'last_level' is equal to false.
  *
- *	flush_kern_tlb_page(kaddr)
  *
- *		Invalidate the TLB entry for the specified page.  The address
- *		will be in the kernels virtual memory space.  Current uses
- *		only require the D-TLB to be invalidated.
- *		- kaddr - Kernel virtual memory address
+ *	Finally, take a look at asm/tlb.h to see how tlb_flush() is implemented
+ *	on top of these routines, since that is our interface to the mmu_gather
+ *	API as used by munmap() and friends.
  */
 static inline void local_flush_tlb_all(void)
 {
-- 
2.1.4

