Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD99C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D37214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SKVl8yeC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D37214FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbeIZSHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:07:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46480 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728223AbeIZSHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AJ/FeihIS/WiUtEfjDbg6CRgoMVGPUxLj7TmPmBEqU8=; b=SKVl8yeCprFBC/uN3i/cyFvKUt
        XarrrRHP42O9ay5qHsxYQofUAs52UA+0BleMRp8+GLZGETe9OzGhwyQZFpwmvN7lzPo1MPwRlXymn
        b2ulcMeUrOrgQuvVRx6d9EdloryH+etBGbag9jzzgIa9zYN0fJ1Qm7/fzhTUkhmSlUMkic4Z9ZHoC
        5IHV4ALZh3gEgZiGYCbI4DjzL1MkP726VsTRPJqJjbHbzZfIjPnpZHrh6SGaQRZYcDw+Tqh/gEpDG
        YgQlMeOfYyv3gHf2FOp3u4DhunMmij1kOW3caAbqNTuV5PiEOXhcAoWGrW4By3KZPn+QkYKIa9pri
        oR4mCrlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g58Oy-0007Up-23; Wed, 26 Sep 2018 11:55:04 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C1B02206F1836; Wed, 26 Sep 2018 13:54:04 +0200 (CEST)
Message-ID: <20180926114801.417460864@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 26 Sep 2018 13:36:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux@armlinux.org.uk, heiko.carstens@de.ibm.com, riel@surriel.com
Subject: [PATCH 17/18] asm-generic/tlb: Remove tlb_flush_mmu_free()
References: <20180926113623.863696043@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the comment notes; it is a potentially dangerous operation. Just
use tlb_flush_mmu(), that will skip the (double) TLB invalidate if
it really isn't needed anyway.

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


