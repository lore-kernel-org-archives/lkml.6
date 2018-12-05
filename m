Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0CAC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2BD20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD2BD20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbeLESHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:07:44 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37635 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeLESHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:07:44 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wB5I7KIT1375733
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 5 Dec 2018 10:07:20 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wB5I7K7i1375730;
        Wed, 5 Dec 2018 10:07:20 -0800
Date:   Wed, 5 Dec 2018 10:07:20 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-ba6f508d0ec4adb09f0a939af6d5e19cdfa8667d@git.kernel.org>
Cc:     dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, torvalds@linux-foundation.org,
        stable@vger.kernel.org, mingo@kernel.org, bp@alien8.de,
        luto@kernel.org, bigeasy@linutronix.de, peterz@infradead.org,
        riel@surriel.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, hpa@zytor.com
Reply-To: riel@surriel.com, tglx@linutronix.de,
          kirill.shutemov@linux.intel.com, hpa@zytor.com,
          bigeasy@linutronix.de, peterz@infradead.org,
          stable@vger.kernel.org, mingo@kernel.org, bp@alien8.de,
          luto@kernel.org, dave.hansen@linux.intel.com,
          linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
          torvalds@linux-foundation.org
In-Reply-To: <154395944713.32119.15611079023837132638.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154395944713.32119.15611079023837132638.stgit@dwillia2-desk3.amr.corp.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm: Drop usage of __flush_tlb_all() in
 kernel_physical_mapping_init()
Git-Commit-ID: ba6f508d0ec4adb09f0a939af6d5e19cdfa8667d
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

Commit-ID:  ba6f508d0ec4adb09f0a939af6d5e19cdfa8667d
Gitweb:     https://git.kernel.org/tip/ba6f508d0ec4adb09f0a939af6d5e19cdfa8667d
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Tue, 4 Dec 2018 13:37:27 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 5 Dec 2018 09:03:07 +0100

x86/mm: Drop usage of __flush_tlb_all() in kernel_physical_mapping_init()

Commit:

  f77084d96355 "x86/mm/pat: Disable preemption around __flush_tlb_all()"

addressed a case where __flush_tlb_all() is called without preemption
being disabled. It also left a warning to catch other cases where
preemption is not disabled.

That warning triggers for the memory hotplug path which is also used for
persistent memory enabling:

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
invalidating existing PTE entries, but not initial population [2]. Drop
the usage of __flush_tlb_all() in phys_{p4d,pud,pmd}_init() on the
expectation that this path is only ever populating empty entries for the
linear map. Note, at linear map teardown time there is a call to the
all-cpu flush_tlb_all() to invalidate the removed mappings.

[1]: https://lkml.kernel.org/r/9DFD717D-857D-493D-A606-B635D72BAC21@amacapital.net
[2]: https://lkml.kernel.org/r/749919a4-cdb1-48a3-adb4-adb81a5fa0b5@intel.com

[ mingo: Minor readability edits. ]

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Reported-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: <stable@vger.kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@intel.com
Fixes: f77084d96355 ("x86/mm/pat: Disable preemption around __flush_tlb_all()")
Link: http://lkml.kernel.org/r/154395944713.32119.15611079023837132638.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/init_64.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 3e25ac2793ef..484c1b92f078 100644
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
 		pud_populate_safe(&init_mm, pud, pmd);
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
 		p4d_populate_safe(&init_mm, p4d, pud);
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
 
