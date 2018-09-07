Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37689C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2EC20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB2EC20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbeIHC0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:26:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56894 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbeIHC0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:26:22 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E0C26BBF;
        Fri,  7 Sep 2018 21:43:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Miller <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, stable@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3.18 17/29] mm/tlb: Remove tlb_remove_table() non-concurrent condition
Date:   Fri,  7 Sep 2018 23:10:38 +0200
Message-Id: <20180907210910.759447458@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210909.523240901@linuxfoundation.org>
References: <20180907210909.523240901@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit a6f572084fbee8b30f91465f4a085d7a90901c57 upstream.

Will noted that only checking mm_users is incorrect; we should also
check mm_count in order to cover CPUs that have a lazy reference to
this mm (and could do speculative TLB operations).

If removing this turns out to be a performance issue, we can
re-instate a more complete check, but in tlb_table_flush() eliding the
call_rcu_sched().

Fixes: 267239116987 ("mm, powerpc: move the RCU page-table freeing into generic code")
Reported-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rik van Riel <riel@surriel.com>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Miller <davem@davemloft.net>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/memory.c |    9 ---------
 1 file changed, 9 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -359,15 +359,6 @@ void tlb_remove_table(struct mmu_gather
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


