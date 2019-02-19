Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9309DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EBC20818
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XQc7367t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfBSKeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:34:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55586 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbfBSKdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ny/EJ5kQ9AxbXrrJC6i+uZEQstUYIWoSCsf99o3ZhwQ=; b=XQc7367tYJJkSbabjx+ZF1U0cv
        peTZuL3axIxoSsTGaiDBPx3VdE8jITPGn2wk16gxQa5/nu4re3CSzzrR9xqfmdu7nF4ySVJl3ABKW
        TTtBD/tTkY97Lz0dkVRS5U9atHausiyvtnJ1lp8+Zb8tg6mhcaI8sIghrCsuhfCNi9vBd+DI1J/RB
        DBbFwNeen+HZPk3OYgZ1bs5Xr7Bu9zrGYKoPrzsYMptffNKKXP0U1VK8CxEHji9o7sXQbl+4JlfUm
        qmsYGWNUy5UsX9E62bTRmiS1ieX+OPkGunA6PV1vSX6UtrG8+yF6JF4J8KjfKhthl1pzg0evDd69A
        giWBvglQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gw2hp-0000dz-9Q; Tue, 19 Feb 2019 10:32:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 80335285205A4; Tue, 19 Feb 2019 11:32:48 +0100 (CET)
Message-Id: <20190219103233.869262181@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 19 Feb 2019 11:32:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Subject: [PATCH v6 17/18] asm-generic/tlb: Remove tlb_flush_mmu_free()
References: <20190219103148.192029670@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the comment notes; it is a potentially dangerous operation. Just
use tlb_flush_mmu(), that will skip the (double) TLB invalidate if
it really isn't needed anyway.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h |   10 +++-------
 mm/memory.c               |    2 +-
 mm/mmu_gather.c           |    2 +-
 3 files changed, 5 insertions(+), 9 deletions(-)

--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -67,16 +67,13 @@
  *    call before __tlb_remove_page*() to set the current page-size; implies a
  *    possible tlb_flush_mmu() call.
  *
- *  - tlb_flush_mmu() / tlb_flush_mmu_tlbonly() / tlb_flush_mmu_free()
+ *  - tlb_flush_mmu() / tlb_flush_mmu_tlbonly()
  *
  *    tlb_flush_mmu_tlbonly() - does the TLB invalidate (and resets
  *                              related state, like the range)
  *
- *    tlb_flush_mmu_free() - frees the queued pages; make absolutely
- *			     sure no additional tlb_remove_page()
- *			     calls happen between _tlbonly() and this.
- *
- *    tlb_flush_mmu() - the above two calls.
+ *    tlb_flush_mmu() - in addition to the above TLB invalidate, also frees
+ *			whatever pages are still batched.
  *
  *  - mmu_gather::fullmm
  *
@@ -274,7 +271,6 @@ void arch_tlb_gather_mmu(struct mmu_gath
 void tlb_flush_mmu(struct mmu_gather *tlb);
 void arch_tlb_finish_mmu(struct mmu_gather *tlb,
 			 unsigned long start, unsigned long end, bool force);
-void tlb_flush_mmu_free(struct mmu_gather *tlb);
 
 static inline void __tlb_adjust_range(struct mmu_gather *tlb,
 				      unsigned long address,
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1155,7 +1155,7 @@ static unsigned long zap_pte_range(struc
 	 */
 	if (force_flush) {
 		force_flush = 0;
-		tlb_flush_mmu_free(tlb);
+		tlb_flush_mmu(tlb);
 		if (addr != end)
 			goto again;
 	}
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -91,7 +91,7 @@ bool __tlb_remove_page_size(struct mmu_g
 
 #endif /* HAVE_MMU_GATHER_NO_GATHER */
 
-void tlb_flush_mmu_free(struct mmu_gather *tlb)
+static void tlb_flush_mmu_free(struct mmu_gather *tlb)
 {
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 	tlb_table_flush(tlb);


