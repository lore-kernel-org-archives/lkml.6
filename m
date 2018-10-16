Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92352C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD442098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 20:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD442098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeJQERx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:17:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58828 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeJQERw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 00:17:52 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gCVuR-0006PK-Rl; Tue, 16 Oct 2018 22:25:44 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/3] x86/mm/pat: Disable preemption around __flush_tlb_all()
Date:   Tue, 16 Oct 2018 22:25:23 +0200
Message-Id: <20181016202525.29437-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016202525.29437-1-bigeasy@linutronix.de>
References: <20181016202525.29437-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Disable preemption during CR3 reset / __flush_tlb_all().

Fixes: decab0888e6e ("x86/mm: Remove preempt_disable/enable() from __native_flush_tlb()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/mm/pageattr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 51a5a69ecac9f..fe6b21f0a6631 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2088,7 +2088,9 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 	 * We should perform an IPI and flush all tlbs,
 	 * but that can deadlock->flush only current cpu:
 	 */
+	preempt_disable();
 	__flush_tlb_all();
+	preempt_enable();
 
 	arch_flush_lazy_mmu_mode();
 }
-- 
2.19.1

