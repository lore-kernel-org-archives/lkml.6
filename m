Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674CAC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE3820651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865546;
	bh=ZFgYfEtqbvDy4Mc8K6VQgVrluXWZwTSSCzTWmrWEL5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZIcDYc1P9wO2g/xqZS5se08qkE8LVha/kXUc1e9MLUk2YNRYZ1+zIccPe6IEO5Qd9
	 nQ1foV8YiWX97OkqeGumOvEl/jX12hMt40WAwS5QmVTEF4MVUBnsyaGO5ETb9plhf1
	 akaM2C2CtmhH93mK2w4r52r8qoLSIKqlPNrWox20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfAGMwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:52:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbfAGMwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:52:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D30F20665;
        Mon,  7 Jan 2019 12:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865542;
        bh=ZFgYfEtqbvDy4Mc8K6VQgVrluXWZwTSSCzTWmrWEL5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HmVY2Qg3DqJ5hy8MO701TMOl5w0nYvnMhugs7AtngOQdXSF1GkklpU0eHEfCnzvwO
         Xt8LJX9YV50rIT6LdnvzRfbmNvRB5EFTOPWxfxWw+5QGw9f2ImEZyz+Upj9z5E+GMP
         uJq1FsUN9dhE14gIQzQUwVrYj3MA0rSj6ZtOXobs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, dave.hansen@intel.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.19 091/170] x86/mm: Drop usage of __flush_tlb_all() in kernel_physical_mapping_init()
Date:   Mon,  7 Jan 2019 13:31:58 +0100
Message-Id: <20190107104503.802806010@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit ba6f508d0ec4adb09f0a939af6d5e19cdfa8667d upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/init_64.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -585,7 +585,6 @@ phys_pud_init(pud_t *pud_page, unsigned
 							   paddr_end,
 							   page_size_mask,
 							   prot);
-				__flush_tlb_all();
 				continue;
 			}
 			/*
@@ -628,7 +627,6 @@ phys_pud_init(pud_t *pud_page, unsigned
 		pud_populate(&init_mm, pud, pmd);
 		spin_unlock(&init_mm.page_table_lock);
 	}
-	__flush_tlb_all();
 
 	update_page_count(PG_LEVEL_1G, pages);
 
@@ -669,7 +667,6 @@ phys_p4d_init(p4d_t *p4d_page, unsigned
 			paddr_last = phys_pud_init(pud, paddr,
 					paddr_end,
 					page_size_mask);
-			__flush_tlb_all();
 			continue;
 		}
 
@@ -681,7 +678,6 @@ phys_p4d_init(p4d_t *p4d_page, unsigned
 		p4d_populate(&init_mm, p4d, pud);
 		spin_unlock(&init_mm.page_table_lock);
 	}
-	__flush_tlb_all();
 
 	return paddr_last;
 }
@@ -734,8 +730,6 @@ kernel_physical_mapping_init(unsigned lo
 	if (pgd_changed)
 		sync_global_pgds(vaddr_start, vaddr_end - 1);
 
-	__flush_tlb_all();
-
 	return paddr_last;
 }
 


