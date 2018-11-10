Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03954C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE39820840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 00:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE39820840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeKJKAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 05:00:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:45754 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbeKJKAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 05:00:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2018 16:17:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,485,1534834800"; 
   d="scan'208";a="88150343"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga007.jf.intel.com with ESMTP; 09 Nov 2018 16:17:36 -0800
Subject: [PATCH] x86/mm/pat: Fix missing preemption disable for
 __native_flush_tlb()
From:   Dan Williams <dan.j.williams@intel.com>
To:     tglx@linutronix.de
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 09 Nov 2018 16:05:47 -0800
Message-ID: <154180834787.2060925.7738215365584115230.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f77084d96355 "x86/mm/pat: Disable preemption around
__flush_tlb_all()" addressed a case where __flush_tlb_all() is called
without preemption being disabled. It also left a warning to catch other
cases where preemption is not disabled. That warning triggers for the
memory hotplug path which is also used for persistent memory enabling:

 WARNING: CPU: 35 PID: 911 at ./arch/x86/include/asm/tlbflush.h:460
 RIP: 0010:__flush_tlb_all+0x1b/0x3a
 [..]
 Call Trace:
  phys_pud_init+0x29c/0x2bb
  kernel_physical_mapping_init+0xfc/0x219
  init_memory_mapping+0x1a5/0x3b0
  arch_add_memory+0x2c/0x50
  devm_memremap_pages+0x3aa/0x610
  pmem_attach_disk+0x585/0x700 [nd_pmem]

Rather than audit all __flush_tlb_all() callers to add preemption, just
do it internally to __flush_tlb_all().

Fixes: f77084d96355 ("x86/mm/pat: Disable preemption around __flush_tlb_all()")
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/tlbflush.h |    8 ++++----
 arch/x86/mm/pageattr.c          |    6 +-----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index d760611cfc35..049e0aca0fb5 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -454,11 +454,10 @@ static inline void __native_flush_tlb_one_user(unsigned long addr)
 static inline void __flush_tlb_all(void)
 {
 	/*
-	 * This is to catch users with enabled preemption and the PGE feature
-	 * and don't trigger the warning in __native_flush_tlb().
+	 *  Preemption needs to be disabled around __flush_tlb* calls
+	 *  due to CR3 reload in __native_flush_tlb().
 	 */
-	VM_WARN_ON_ONCE(preemptible());
-
+	preempt_disable();
 	if (boot_cpu_has(X86_FEATURE_PGE)) {
 		__flush_tlb_global();
 	} else {
@@ -467,6 +466,7 @@ static inline void __flush_tlb_all(void)
 		 */
 		__flush_tlb();
 	}
+	preempt_enable();
 }
 
 /*
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index db7a10082238..f799076e3d57 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2309,13 +2309,9 @@ void __kernel_map_pages(struct page *page, int numpages, int enable)
 
 	/*
 	 * We should perform an IPI and flush all tlbs,
-	 * but that can deadlock->flush only current cpu.
-	 * Preemption needs to be disabled around __flush_tlb_all() due to
-	 * CR3 reload in __native_flush_tlb().
+	 * but that can deadlock->flush only current cpu:
 	 */
-	preempt_disable();
 	__flush_tlb_all();
-	preempt_enable();
 
 	arch_flush_lazy_mmu_mode();
 }

