Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3562AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A3121567
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 13:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A3121567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeHXRJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 13:09:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57450 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbeHXRJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 13:09:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54BE3ED1;
        Fri, 24 Aug 2018 06:34:35 -0700 (PDT)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18EF93F675;
        Fri, 24 Aug 2018 06:34:30 -0700 (PDT)
Date:   Fri, 24 Aug 2018 14:34:27 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, riel@surriel.com, jannh@google.com,
        ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arch@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH 2/2] mm: mmu_notifier fix for tlb_end_vma (build
 failures)
Message-ID: <20180824133427.GC11868@brain-police>
References: <20180823084709.19717-1-npiggin@gmail.com>
 <20180823084709.19717-3-npiggin@gmail.com>
 <20180824130722.GA31409@roeck-us.net>
 <20180824131026.GB11868@brain-police>
 <20180824132419.GA9983@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180824132419.GA9983@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 06:24:19AM -0700, Guenter Roeck wrote:
> On Fri, Aug 24, 2018 at 02:10:27PM +0100, Will Deacon wrote:
> > On Fri, Aug 24, 2018 at 06:07:22AM -0700, Guenter Roeck wrote:
> > > On Thu, Aug 23, 2018 at 06:47:09PM +1000, Nicholas Piggin wrote:
> > > > The generic tlb_end_vma does not call invalidate_range mmu notifier,
> > > > and it resets resets the mmu_gather range, which means the notifier
> > > > won't be called on part of the range in case of an unmap that spans
> > > > multiple vmas.
> > > > 
> > > > ARM64 seems to be the only arch I could see that has notifiers and
> > > > uses the generic tlb_end_vma. I have not actually tested it.
> > > > 
> > > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > > Acked-by: Will Deacon <will.deacon@arm.com>
> > > 
> > > This patch breaks riscv builds in mainline.
> > 
> > Looks very similar to the breakage we hit on arm64. diff below should fix
> > it.
> > 
> 
> Unfortunately it doesn't.
> 
> In file included from ./arch/riscv/include/asm/pgtable.h:26:0,
>                  from ./include/linux/memremap.h:7,
>                  from ./include/linux/mm.h:27,
>                  from arch/riscv/mm/fault.c:23:
> ./arch/riscv/include/asm/tlb.h: In function ‘tlb_flush’:
> ./arch/riscv/include/asm/tlb.h:19:18: error: dereferencing pointer to incomplete type ‘struct mmu_gather’
>   flush_tlb_mm(tlb->mm);
>                   ^

Sorry, I was a bit quick of the mark there. You'll need a forward
declaration for the paramater type. Here it is with a commit message,
although still untested because I haven't got round to setting up a riscv
toolchain yet.

Will

--->8

From adb9be33d68320edcda80d540a97a647792894d2 Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Fri, 24 Aug 2018 14:33:48 +0100
Subject: [PATCH] riscv: tlb: Provide definition of tlb_flush() before
 including tlb.h

As of commit fd1102f0aade ("mm: mmu_notifier fix for tlb_end_vma"),
asm-generic/tlb.h now calls tlb_flush() from a static inline function,
so we need to make sure that it's declared before #including the
asm-generic header in the arch header.

Since tlb_flush() is a one-liner for riscv, we can define it before
including asm-generic/tlb.h as long as we provide a forward declaration
of struct mmu_gather.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/riscv/include/asm/tlb.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
index c229509288ea..a3d1380ad970 100644
--- a/arch/riscv/include/asm/tlb.h
+++ b/arch/riscv/include/asm/tlb.h
@@ -14,11 +14,13 @@
 #ifndef _ASM_RISCV_TLB_H
 #define _ASM_RISCV_TLB_H
 
-#include <asm-generic/tlb.h>
+struct mmu_gather;
 
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	flush_tlb_mm(tlb->mm);
 }
 
+#include <asm-generic/tlb.h>
+
 #endif /* _ASM_RISCV_TLB_H */
-- 
2.7.4

