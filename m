Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B290CC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D21E20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D21E20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754930AbeFTT5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:57:23 -0400
Received: from shelob.surriel.com ([96.67.55.147]:52058 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754818AbeFTT5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:57:07 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fVjDr-0002g7-Ey; Wed, 20 Jun 2018 15:56:55 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     86@vger.kernel.org, luto@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, dave.hansen@linux.intel.com, efault@gmx.de,
        songliubraving@fb.com, kernel-team@fb.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 6/7] x86,mm: always use lazy TLB mode
Date:   Wed, 20 Jun 2018 15:56:51 -0400
Message-Id: <20180620195652.27251-7-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180620195652.27251-1-riel@surriel.com>
References: <20180620195652.27251-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that CPUs in lazy TLB mode no longer receive TLB shootdown IPIs, except
at page table freeing time, and idle CPUs will no longer get shootdown IPIs
for things like mprotect and madvise, we can always use lazy TLB mode.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/include/asm/tlbflush.h | 16 ----------------
 arch/x86/mm/tlb.c               | 15 +--------------
 2 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 0a8bdd6084de..d59c247afc14 100644
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
index 40b00055c883..26b3aeef6266 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -378,20 +378,7 @@ void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
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
-		this_cpu_write(cpu_tlbstate.state, TLBSTATE_LAZY);
-	} else {
-		switch_mm(NULL, &init_mm, NULL);
-	}
+	this_cpu_write(cpu_tlbstate.state, TLBSTATE_LAZY);
 }
 
 /*
-- 
2.14.4

