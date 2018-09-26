Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07C7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8B1208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8B1208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeIZKJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 06:09:57 -0400
Received: from shelob.surriel.com ([96.67.55.147]:49994 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeIZKJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 06:09:55 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g50yN-0006sG-Pl; Tue, 25 Sep 2018 23:58:47 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kernel-team@fb.com, will.deacon@arm.com,
        songliubraving@fb.com, mingo@kernel.org, luto@kernel.org,
        hpa@zytor.com, npiggin@gmail.com, Rik van Riel <riel@surriel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de
Subject: [PATCH 1/7] x86/mm/tlb: Always use lazy TLB mode
Date:   Tue, 25 Sep 2018 23:58:38 -0400
Message-Id: <20180926035844.1420-2-riel@surriel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926035844.1420-1-riel@surriel.com>
References: <20180926035844.1420-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that CPUs in lazy TLB mode no longer receive TLB shootdown IPIs, except
at page table freeing time, and idle CPUs will no longer get shootdown IPIs
for things like mprotect and madvise, we can always use lazy TLB mode.

Tested-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: efault@gmx.de
Cc: kernel-team@fb.com
Cc: luto@kernel.org
Link: http://lkml.kernel.org/r/20180716190337.26133-7-riel@surriel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
(cherry picked from commit 95b0e6357d3e4e05349668940d7ff8f3b7e7e11e)
---
 arch/x86/include/asm/tlbflush.h | 16 ----------------
 arch/x86/mm/tlb.c               | 15 +--------------
 2 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 671f65309ce7..d6c0cd9e9591 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -148,22 +148,6 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
 #define __flush_tlb_one_user(addr) __native_flush_tlb_one_user(addr)
 #endif
 
-static inline bool tlb_defer_switch_to_init_mm(void)
-{
-	/*
-	 * If we have PCID, then switching to init_mm is reasonably
-	 * fast.  If we don't have PCID, then switching to init_mm is
-	 * quite slow, so we try to defer it in the hopes that we can
-	 * avoid it entirely.  The latter approach runs the risk of
-	 * receiving otherwise unnecessary IPIs.
-	 *
-	 * This choice is just a heuristic.  The tlb code can handle this
-	 * function returning true or false regardless of whether we have
-	 * PCID.
-	 */
-	return !static_cpu_has(X86_FEATURE_PCID);
-}
-
 struct tlb_context {
 	u64 ctx_id;
 	u64 tlb_gen;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 6aa195796dec..54a5870190a6 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -368,20 +368,7 @@ void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == &init_mm)
 		return;
 
-	if (tlb_defer_switch_to_init_mm()) {
-		/*
-		 * There's a significant optimization that may be possible
-		 * here.  We have accurate enough TLB flush tracking that we
-		 * don't need to maintain coherence of TLB per se when we're
-		 * lazy.  We do, however, need to maintain coherence of
-		 * paging-structure caches.  We could, in principle, leave our
-		 * old mm loaded and only switch to init_mm when
-		 * tlb_remove_page() happens.
-		 */
-		this_cpu_write(cpu_tlbstate.is_lazy, true);
-	} else {
-		switch_mm(NULL, &init_mm, NULL);
-	}
+	this_cpu_write(cpu_tlbstate.is_lazy, true);
 }
 
 /*
-- 
2.17.1

