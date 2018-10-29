Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF09C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F60B2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F60B2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbeJ3DAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 23:00:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34211 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeJ3DAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 23:00:36 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9TIAR0h1642856
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 29 Oct 2018 11:10:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9TIARc21642850;
        Mon, 29 Oct 2018 11:10:27 -0700
Date:   Mon, 29 Oct 2018 11:10:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-f77084d96355f5fba8e2c1fb3a51a393b1570de7@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        peterz@infradead.org, tglx@linutronix.de, luto@kernel.org,
        bp@alien8.de, hpa@zytor.com, bigeasy@linutronix.de,
        mingo@kernel.org
Reply-To: bp@alien8.de, luto@kernel.org, hpa@zytor.com,
          bigeasy@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org,
          dave.hansen@linux.intel.com, tglx@linutronix.de
In-Reply-To: <20181017103432.zgv46nlu3hc7k4rq@linutronix.de>
References: <20181017103432.zgv46nlu3hc7k4rq@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/mm/pat: Disable preemption around
 __flush_tlb_all()
Git-Commit-ID: f77084d96355f5fba8e2c1fb3a51a393b1570de7
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

Commit-ID:  f77084d96355f5fba8e2c1fb3a51a393b1570de7
Gitweb:     https://git.kernel.org/tip/f77084d96355f5fba8e2c1fb3a51a393b1570de7
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 17 Oct 2018 12:34:32 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Oct 2018 19:04:31 +0100

x86/mm/pat: Disable preemption around __flush_tlb_all()

The WARN_ON_ONCE(__read_cr3() != build_cr3()) in switch_mm_irqs_off()
triggers every once in a while during a snapshotted system upgrade.

The warning triggers since commit decab0888e6e ("x86/mm: Remove
preempt_disable/enable() from __native_flush_tlb()"). The callchain is:

  get_page_from_freelist() -> post_alloc_hook() -> __kernel_map_pages()

with CONFIG_DEBUG_PAGEALLOC enabled.

Disable preemption during CR3 reset / __flush_tlb_all() and add a comment
why preemption has to be disabled so it won't be removed accidentaly.

Add another preemptible() check in __flush_tlb_all() to catch callers with
enabled preemption when PGE is enabled, because PGE enabled does not
trigger the warning in __native_flush_tlb(). Suggested by Andy Lutomirski.

Fixes: decab0888e6e ("x86/mm: Remove preempt_disable/enable() from __native_flush_tlb()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20181017103432.zgv46nlu3hc7k4rq@linutronix.de
---
 arch/x86/include/asm/tlbflush.h | 6 ++++++
 arch/x86/mm/pageattr.c          | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 323a313947e0..d760611cfc35 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -453,6 +453,12 @@ static inline void __native_flush_tlb_one_user(unsigned long addr)
  */
 static inline void __flush_tlb_all(void)
 {
+	/*
+	 * This is to catch users with enabled preemption and the PGE feature
+	 * and don't trigger the warning in __native_flush_tlb().
+	 */
+	VM_WARN_ON_ONCE(preemptible());
+
 	if (boot_cpu_has(X86_FEATURE_PGE)) {
 		__flush_tlb_global();
 	} else {
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 62bb30b4bd2a..a1004dec98ea 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2309,9 +2309,13 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 
 	/*
 	 * We should perform an IPI and flush all tlbs,
-	 * but that can deadlock->flush only current cpu:
+	 * but that can deadlock->flush only current cpu.
+	 * Preemption needs to be disabled around __flush_tlb_all() due to
+	 * CR3 reload in __native_flush_tlb().
 	 */
+	preempt_disable();
 	__flush_tlb_all();
+	preempt_enable();
 
 	arch_flush_lazy_mmu_mode();
 }
