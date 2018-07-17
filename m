Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3360FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBDB20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBDB20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbeGQKIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:08:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43603 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbeGQKIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:08:18 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9aCx21463667
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:36:13 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9aCes1463664;
        Tue, 17 Jul 2018 02:36:12 -0700
Date:   Tue, 17 Jul 2018 02:36:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rik van Riel <tipbot@zytor.com>
Message-ID: <tip-95b0e6357d3e4e05349668940d7ff8f3b7e7e11e@git.kernel.org>
Cc:     mingo@kernel.org, riel@surriel.com, tglx@linutronix.de,
        dave.hansen@intel.com, hpa@zytor.com, songliubraving@fb.com,
        peterz@infradead.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, riel@surriel.com,
          dave.hansen@intel.com, hpa@zytor.com, peterz@infradead.org,
          songliubraving@fb.com, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org
In-Reply-To: <20180716190337.26133-7-riel@surriel.com>
References: <20180716190337.26133-7-riel@surriel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/tlb: Always use lazy TLB mode
Git-Commit-ID: 95b0e6357d3e4e05349668940d7ff8f3b7e7e11e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  95b0e6357d3e4e05349668940d7ff8f3b7e7e11e
Gitweb:     https://git.kernel.org/tip/95b0e6357d3e4e05349668940d7ff8f3b7e7e11e
Author:     Rik van Riel <riel@surriel.com>
AuthorDate: Mon, 16 Jul 2018 15:03:36 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Jul 2018 09:35:34 +0200

x86/mm/tlb: Always use lazy TLB mode

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
---
 arch/x86/include/asm/tlbflush.h | 16 ----------------
 arch/x86/mm/tlb.c               | 15 +--------------
 2 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 3aa3204b5dc0..511bf5fae8b8 100644
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
index e4156e37aa71..493559cae2d5 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -379,20 +379,7 @@ void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
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
