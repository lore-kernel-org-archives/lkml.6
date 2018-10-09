Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B719ECDE21
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E13E21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E13E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbeJIWPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:15:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39657 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJIWPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:15:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99Ew9g21080852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 07:58:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99Ew9qw1080849;
        Tue, 9 Oct 2018 07:58:09 -0700
Date:   Tue, 9 Oct 2018 07:58:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rik van Riel <tipbot@zytor.com>
Message-ID: <tip-5462bc3a9a3c38328bbbd276d51164c7cf21d6a8@git.kernel.org>
Cc:     songliubraving@fb.com, tglx@linutronix.de, peterz@infradead.org,
        dave.hansen@intel.com, torvalds@linux-foundation.org,
        riel@surriel.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          riel@surriel.com, torvalds@linux-foundation.org,
          dave.hansen@intel.com, peterz@infradead.org, tglx@linutronix.de,
          songliubraving@fb.com
In-Reply-To: <20180716190337.26133-7-riel@surriel.com>
References: <20180716190337.26133-7-riel@surriel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/tlb: Always use lazy TLB mode
Git-Commit-ID: 5462bc3a9a3c38328bbbd276d51164c7cf21d6a8
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

Commit-ID:  5462bc3a9a3c38328bbbd276d51164c7cf21d6a8
Gitweb:     https://git.kernel.org/tip/5462bc3a9a3c38328bbbd276d51164c7cf21d6a8
Author:     Rik van Riel <riel@surriel.com>
AuthorDate: Tue, 25 Sep 2018 23:58:38 -0400
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 9 Oct 2018 16:51:11 +0200

x86/mm/tlb: Always use lazy TLB mode

On most workloads, the number of context switches far exceeds the
number of TLB flushes sent. Optimizing the context switches, by always
using lazy TLB mode, speeds up those workloads.

This patch results in about a 1% reduction in CPU use on a two socket
Broadwell system running a memcache like workload.

Cc: npiggin@gmail.com
Cc: efault@gmx.de
Cc: will.deacon@arm.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-team@fb.com
Cc: hpa@zytor.com
Cc: luto@kernel.org
Tested-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
(cherry picked from commit 95b0e6357d3e4e05349668940d7ff8f3b7e7e11e)
Acked-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180716190337.26133-7-riel@surriel.com
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
