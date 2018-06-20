Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60ADAC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255A82083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255A82083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754968AbeFTT5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:57:24 -0400
Received: from shelob.surriel.com ([96.67.55.147]:52056 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754811AbeFTT5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:57:07 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fVjDr-0002g7-Bi; Wed, 20 Jun 2018 15:56:55 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     86@vger.kernel.org, luto@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, dave.hansen@linux.intel.com, efault@gmx.de,
        songliubraving@fb.com, kernel-team@fb.com,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 3/7] x86,tlb: change tlbstate.is_lazy to tlbstate.state
Date:   Wed, 20 Jun 2018 15:56:48 -0400
Message-Id: <20180620195652.27251-4-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180620195652.27251-1-riel@surriel.com>
References: <20180620195652.27251-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the tlbstate.is_lazy boolean with a tlbstate.state int,
so more states can be expressed. This is a preparation for the
next patch.

Signed-off-by: Rik van Riel <riel@surriel.com>
Tested-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/include/asm/tlbflush.h | 11 +++++++----
 arch/x86/mm/tlb.c               | 10 +++++-----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 3aa3204b5dc0..88a4d6b87ff7 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -169,6 +169,9 @@ struct tlb_context {
 	u64 tlb_gen;
 };
 
+#define TLBSTATE_OK	0
+#define TLBSTATE_LAZY	1
+
 struct tlb_state {
 	/*
 	 * cpu_tlbstate.loaded_mm should match CR3 whenever interrupts
@@ -186,18 +189,18 @@ struct tlb_state {
 	 * We can be in one of several states:
 	 *
 	 *  - Actively using an mm.  Our CPU's bit will be set in
-	 *    mm_cpumask(loaded_mm) and is_lazy == false;
+	 *    mm_cpumask(loaded_mm) and state == TLBSTATE_OK
 	 *
 	 *  - Not using a real mm.  loaded_mm == &init_mm.  Our CPU's bit
-	 *    will not be set in mm_cpumask(&init_mm) and is_lazy == false.
+	 *    will not be set in mm_cpumask(&init_mm) and state == TLBSTATE_OK
 	 *
 	 *  - Lazily using a real mm.  loaded_mm != &init_mm, our bit
-	 *    is set in mm_cpumask(loaded_mm), but is_lazy == true.
+	 *    is set in mm_cpumask(loaded_mm), but state == TLBSTATE_LAZY.
 	 *    We're heuristically guessing that the CR3 load we
 	 *    skipped more than makes up for the overhead added by
 	 *    lazy mode.
 	 */
-	bool is_lazy;
+	int state;
 
 	/*
 	 * If set we changed the page tables in such a way that we
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 61773b07ed54..e063e623e52c 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -136,7 +136,7 @@ void leave_mm(int cpu)
 		return;
 
 	/* Warn if we're not lazy. */
-	WARN_ON(!this_cpu_read(cpu_tlbstate.is_lazy));
+	WARN_ON((this_cpu_read(cpu_tlbstate.state) == TLBSTATE_OK));
 
 	switch_mm(NULL, &init_mm, NULL);
 }
@@ -227,7 +227,7 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		__flush_tlb_all();
 	}
 #endif
-	this_cpu_write(cpu_tlbstate.is_lazy, false);
+	this_cpu_write(cpu_tlbstate.state, TLBSTATE_OK);
 
 	/*
 	 * The membarrier system call requires a full memory barrier and
@@ -364,7 +364,7 @@ void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 		 * old mm loaded and only switch to init_mm when
 		 * tlb_remove_page() happens.
 		 */
-		this_cpu_write(cpu_tlbstate.is_lazy, true);
+		this_cpu_write(cpu_tlbstate.state, TLBSTATE_LAZY);
 	} else {
 		switch_mm(NULL, &init_mm, NULL);
 	}
@@ -448,7 +448,7 @@ static void flush_tlb_func_common(const struct flush_tlb_info *f,
 	VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].ctx_id) !=
 		   loaded_mm->context.ctx_id);
 
-	if (this_cpu_read(cpu_tlbstate.is_lazy)) {
+	if (this_cpu_read(cpu_tlbstate.state) != TLBSTATE_OK) {
 		/*
 		 * We're in lazy mode.  We need to at least flush our
 		 * paging-structure cache to avoid speculatively reading
@@ -651,7 +651,7 @@ void tlb_flush_remove_tables_local(void *arg)
 	struct mm_struct *mm = arg;
 
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == mm &&
-			this_cpu_read(cpu_tlbstate.is_lazy))
+			this_cpu_read(cpu_tlbstate.state) != TLBSTATE_OK)
 		/*
 		 * We're in lazy mode.  We need to at least flush our
 		 * paging-structure cache to avoid speculatively reading
-- 
2.14.4

