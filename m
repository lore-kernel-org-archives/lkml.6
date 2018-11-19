Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A4DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B416420851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B416420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbeKTJ45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:56:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:13278 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728349AbeKTJ45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:56:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 15:30:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,254,1539673200"; 
   d="scan'208";a="93340530"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga008.jf.intel.com with ESMTP; 19 Nov 2018 15:30:53 -0800
Subject: [PATCH] x86/mm: Drop usage of __flush_tlb_all() in
 kernel_physical_mapping_init()
From:   Dan Williams <dan.j.williams@intel.com>
To:     tglx@linutronix.de
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, stable@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Date:   Mon, 19 Nov 2018 15:19:04 -0800
Message-ID: <154266954452.2939184.974606608701109493.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Andy wondered why a path that can sleep was using __flush_tlb_all() [1]
and Dave confirmed the expectation for TLB flush is for modifying /
invalidating existing pte entries, but not initial population [2]. Drop
the usage of __flush_tlb_all() in phys_{p4d,pud,pmd}_init() on the
expectation that this path is only ever populating empty entries for the
linear map. Note, at linear map teardown time there is a call to the
all-cpu flush_tlb_all() to invalidate the removed mappings.

[1]: https://lore.kernel.org/patchwork/patch/1009434/#1193941
[2]: https://lore.kernel.org/patchwork/patch/1009434/#1194540

Fixes: f77084d96355 ("x86/mm/pat: Disable preemption around __flush_tlb_all()")
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: <stable@vger.kernel.org>
Reported-by: Andy Lutomirski <luto@kernel.org>
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/init_64.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 5fab264948c2..de95db8ac52f 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -584,7 +584,6 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 							   paddr_end,
 							   page_size_mask,
 							   prot);
-				__flush_tlb_all();
 				continue;
 			}
 			/*
@@ -627,7 +626,6 @@ phys_pud_init(pud_t *pud_page, unsigned long paddr, unsigned long paddr_end,
 		pud_populate(&init_mm, pud, pmd);
 		spin_unlock(&init_mm.page_table_lock);
 	}
-	__flush_tlb_all();
 
 	update_page_count(PG_LEVEL_1G, pages);
 
@@ -668,7 +666,6 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 			paddr_last = phys_pud_init(pud, paddr,
 					paddr_end,
 					page_size_mask);
-			__flush_tlb_all();
 			continue;
 		}
 
@@ -680,7 +677,6 @@ phys_p4d_init(p4d_t *p4d_page, unsigned long paddr, unsigned long paddr_end,
 		p4d_populate(&init_mm, p4d, pud);
 		spin_unlock(&init_mm.page_table_lock);
 	}
-	__flush_tlb_all();
 
 	return paddr_last;
 }
@@ -733,8 +729,6 @@ kernel_physical_mapping_init(unsigned long paddr_start,
 	if (pgd_changed)
 		sync_global_pgds(vaddr_start, vaddr_end - 1);
 
-	__flush_tlb_all();
-
 	return paddr_last;
 }
 

