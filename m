Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DDAC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B14D2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B14D2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755015AbeFTT53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:57:29 -0400
Received: from shelob.surriel.com ([96.67.55.147]:52018 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754769AbeFTT5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:57:07 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fVjDr-0002g7-G2; Wed, 20 Jun 2018 15:56:55 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     86@vger.kernel.org, luto@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, dave.hansen@linux.intel.com, efault@gmx.de,
        songliubraving@fb.com, kernel-team@fb.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 7/7] x86,idle: do not leave mm in idle state
Date:   Wed, 20 Jun 2018 15:56:52 -0400
Message-Id: <20180620195652.27251-8-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180620195652.27251-1-riel@surriel.com>
References: <20180620195652.27251-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not call leave_mm when going into a cstate. Now that mprotect and
madvise no longer send IPIs for TLB shootdowns to idle CPUs, there is
no real reason to disable lazy TLB mode in idle states.

This seems to help performance on Broadwell systems. Haswell performance
numbers are inconclusive.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/include/asm/mmu.h |  2 --
 arch/x86/mm/tlb.c          | 26 +-------------------------
 drivers/idle/intel_idle.c  |  7 -------
 3 files changed, 1 insertion(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5ff3e8af2c20..096ee9340685 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -61,6 +61,4 @@ typedef struct {
 		.ctx_id = 1,						\
 	}
 
-void leave_mm(int cpu);
-
 #endif /* _ASM_X86_MMU_H */
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 26b3aeef6266..b861084e59d1 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -121,28 +121,6 @@ static void load_new_mm_cr3(pgd_t *pgdir, u16 new_asid, bool need_flush)
 	write_cr3(new_mm_cr3);
 }
 
-void leave_mm(int cpu)
-{
-	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
-
-	/*
-	 * It's plausible that we're in lazy TLB mode while our mm is init_mm.
-	 * If so, our callers still expect us to flush the TLB, but there
-	 * aren't any user TLB entries in init_mm to worry about.
-	 *
-	 * This needs to happen before any other sanity checks due to
-	 * intel_idle's shenanigans.
-	 */
-	if (loaded_mm == &init_mm)
-		return;
-
-	/* Warn if we're not lazy. */
-	WARN_ON((this_cpu_read(cpu_tlbstate.state) == TLBSTATE_OK));
-
-	switch_mm(NULL, &init_mm, NULL);
-}
-EXPORT_SYMBOL_GPL(leave_mm);
-
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	       struct task_struct *tsk)
 {
@@ -194,8 +172,6 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	 * from lazy TLB mode to normal mode if active_mm isn't changing.
 	 * When this happens, we don't assume that CR3 (and hence
 	 * cpu_tlbstate.loaded_mm) matches next.
-	 *
-	 * NB: leave_mm() calls us with prev == NULL and tsk == NULL.
 	 */
 
 	/* We don't want flush_tlb_func_* to run concurrently with us. */
@@ -205,7 +181,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	/*
 	 * Verify that CR3 is what we think it is.  This will catch
 	 * hypothetical buggy code that directly switches to swapper_pg_dir
-	 * without going through leave_mm() / switch_mm_irqs_off() or that
+	 * without going through switch_mm_irqs_off() or that
 	 * does something like write_cr3(read_cr3_pa()).
 	 *
 	 * Only do this check if CONFIG_DEBUG_VM=y because __read_cr3()
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index b2ccce5fb071..d3727aa34836 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -916,13 +916,6 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
 	bool uninitialized_var(tick);
 	int cpu = smp_processor_id();
 
-	/*
-	 * leave_mm() to avoid costly and often unnecessary wakeups
-	 * for flushing the user TLB's associated with the active mm.
-	 */
-	if (state->flags & CPUIDLE_FLAG_TLB_FLUSHED)
-		leave_mm(cpu);
-
 	if (!static_cpu_has(X86_FEATURE_ARAT)) {
 		cstate = (((eax) >> MWAIT_SUBSTATE_SIZE) &
 				MWAIT_CSTATE_MASK) + 1;
-- 
2.14.4

