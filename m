Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93076ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C98D21528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 10:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C98D21528
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeJQS3k convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 14:29:40 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59937 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeJQS3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 14:29:39 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gCj9s-0005dg-DL; Wed, 17 Oct 2018 12:34:32 +0200
Date:   Wed, 17 Oct 2018 12:34:32 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 1/3 v2] x86/mm/pat: Disable preemption around
 __flush_tlb_all()
Message-ID: <20181017103432.zgv46nlu3hc7k4rq@linutronix.de>
References: <20181016202525.29437-1-bigeasy@linutronix.de>
 <20181016202525.29437-2-bigeasy@linutronix.de>
 <CALCETrWB2kH9d5ui5haY3aRTD9SAU=tcdkTMoAzJ5rhLh3mO3w@mail.gmail.com>
 <20181016213859.ldx34cab7ggm5nm5@linutronix.de>
 <CALCETrWf_RqcX7_R_0O0nZ9E8voTB4SE8WX=AP6mk2Uid1CxrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CALCETrWf_RqcX7_R_0O0nZ9E8voTB4SE8WX=AP6mk2Uid1CxrQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen the WARN_ON_ONCE(__read_cr3() != build_cr3()) in
switch_mm_irqs_off() every once in a while during a snapshotted system
upgrade.
I also saw the warning early during which was introduced in commit
decab0888e6e ("x86/mm: Remove preempt_disable/enable() from
__native_flush_tlb()"). The callchain is

  get_page_from_freelist() -> post_alloc_hook() -> __kernel_map_pages()

with CONFIG_DEBUG_PAGEALLOC enabled.

Turns out, once I disable preemption around __flush_tlb_all() both
warnings do not appear.

Disable preemption during CR3 reset / __flush_tlb_all() and add a
comment why preemption is disabled.
Add another preemptible() check in __flush_tlb_all() so we catch users
with enabled preemption and with the PGE which would not trigger the
warning in __native_flush_tlb() (suggested by Andy Lutomirski).

Fixes: decab0888e6e ("x86/mm: Remove preempt_disable/enable() from __native_flush_tlb()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2:
	- Add a comment before disabling preemption explaining why this
	  is done.
	- Add a preemption check to __flush_tlb_all().

 arch/x86/include/asm/tlbflush.h | 6 ++++++
 arch/x86/mm/pageattr.c          | 6 +++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 58ce5288878e8..0e2130d8d6b12 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -469,6 +469,12 @@ static inline void __native_flush_tlb_one_user(unsigned long addr)
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
index 51a5a69ecac9f..e2d4b25c7aa44 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2086,9 +2086,13 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 
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
-- 
2.19.1

