Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B67C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97692148C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 15:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AOQ8g0mF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97692148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbeHVTMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:12:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51442 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbeHVTMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=DtDo4cQQlYpJctQYVAg287e1LDGKHg+PXr5W1nBz53Q=; b=AOQ8g0mFgDBL61alQiOuAyiDxh
        qqZq25A0DVaTD3yaYdSTSnEDjNmpw0WdTTRf42Yi9IMBX8j/O8lpk+AayLo6D9dDe+iH5JhnxZ493
        n6VTifk+gF+9jwc27RckF1whb4ZVc+IeVJG8kM9iDdrgQm+ziYX/zSh/eevlYCzpJehiC0/bRWylx
        CijMfNi6t4TBllQhy81e3Q/O3jHPowDI55bNlkEQL3vX9BOVDqW0YR/7Q5fd5r+R7Sh1HL/pIxxjl
        9NDmWTQcaIu8MgUCci7y134gKJUW+NxpVCNo+KYqZdwHk88xq56AM1Fu6KzbbA3NBBZ8GGuwFTalr
        ZOjj6vsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsVKN-0000WT-Ig; Wed, 22 Aug 2018 15:45:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BD93D2024D723; Wed, 22 Aug 2018 17:45:44 +0200 (CEST)
Message-ID: <20180822154046.772017055@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Aug 2018 17:30:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org
Cc:     peterz@infradead.org, luto@kernel.org, x86@kernel.org,
        bp@alien8.de, will.deacon@arm.com, riel@surriel.com,
        jannh@google.com, ascannell@google.com, dave.hansen@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nicholas Piggin <npiggin@gmail.com>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/4] mm/tlb: Remove tlb_remove_table() non-concurrent condition
References: <20180822153012.173508681@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will noted that only checking mm_users is incorrect; we should also
check mm_count in order to cover CPUs that have a lazy reference to
this mm (and could do speculative TLB operations).

If removing this turns out to be a performance issue, we can
re-instate a more complete check, but in tlb_table_flush() eliding the
call_rcu_sched().

Cc: stable@kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Miller <davem@davemloft.net>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Fixes: 267239116987 ("mm, powerpc: move the RCU page-table freeing into generic code")
Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 mm/memory.c |    9 ---------
 1 file changed, 9 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -375,15 +375,6 @@ void tlb_remove_table(struct mmu_gather
 {
 	struct mmu_table_batch **batch = &tlb->batch;
 
-	/*
-	 * When there's less then two users of this mm there cannot be a
-	 * concurrent page-table walk.
-	 */
-	if (atomic_read(&tlb->mm->mm_users) < 2) {
-		__tlb_remove_table(table);
-		return;
-	}
-
 	if (*batch == NULL) {
 		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 		if (*batch == NULL) {


