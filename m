Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99179C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564072145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564072145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbeIYAlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:41:49 -0400
Received: from shelob.surriel.com ([96.67.55.147]:36380 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbeIYAls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:41:48 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g4VkD-0002qj-Ni; Mon, 24 Sep 2018 14:38:05 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kernel-team@fb.com, songliubraving@fb.com,
        mingo@kernel.org, will.deacon@arm.com, hpa@zytor.com,
        luto@kernel.org, npiggin@gmail.com,
        Rik van Riel <riel@surriel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, efault@gmx.de
Subject: [PATCH 1/7] x86/mm/tlb: Always use lazy TLB mode
Date:   Mon, 24 Sep 2018 14:37:53 -0400
Message-Id: <20180924183759.23955-2-riel@surriel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180924183759.23955-1-riel@surriel.com>
References: <20180924183759.23955-1-riel@surriel.com>
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
index ad6629537af5..82898cd3d933 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -143,22 +143,6 @@ static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
 #define __flush_tlb_single(addr) __native_flush_tlb_single(addr)
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
index 063433ff67bf..d19f424073d9 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -309,20 +309,7 @@ void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
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

