Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2393DC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A7420867
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 00:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A7420867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbeLAL6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:58:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:65493 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbeLAL6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 06:58:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 16:47:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,300,1539673200"; 
   d="scan'208";a="105861767"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga003.jf.intel.com with ESMTP; 30 Nov 2018 16:47:33 -0800
Subject: [PATCH v2 0/5] x86/mm: Drop usage of __flush_tlb_all() in
 kernel_physical_mapping_init()
From:   Dan Williams <dan.j.williams@intel.com>
To:     tglx@linutronix.de
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, stable@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 30 Nov 2018 16:35:06 -0800
Message-ID: <154362450646.2367148.16448130381211111341.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1 [1]:
* Introduce _safe versions of the set_pte family of helpers (Dave)
* Fix the validation check to accept rewriting the same entry (Peter)
* Fix up the email reference links in the changelogs (Peter)

[1]: https://lkml.org/lkml/2018/11/20/300

---

>From patch 5:

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

Additionally, Dave wanted some runtime assurances that
kernel_physical_mapping_init() is only populating and not changing
existing page table entries. Patches 1 - 4 are implementing a new
set_pte() family of helpers for that purpose.

Patch 5 is tagged for -stable because the false positive warning is now
showing up on 4.19-stable kernels. Patches 1 - 4 are not tagged for
-stable, but if the sanity checking is needed please mark them as such.

The hang that was observed while developing the sanity checking
implementation was resolved by Peter's suggestion to not trigger when
the same pte value is being rewritten.

---

Dan Williams (5):
      generic/pgtable: Make {pmd,pud}_same() unconditionally available
      generic/pgtable: Introduce {p4d,pgd}_same()
      generic/pgtable: Introduce set_pte_safe()
      x86/mm: Validate kernel_physical_mapping_init() pte population
      x86/mm: Drop usage of __flush_tlb_all() in kernel_physical_mapping_init()


 arch/x86/include/asm/pgalloc.h           |   27 +++++++++++++++
 arch/x86/mm/init_64.c                    |   30 +++++++----------
 include/asm-generic/5level-fixup.h       |    1 +
 include/asm-generic/pgtable-nop4d-hack.h |    1 +
 include/asm-generic/pgtable-nop4d.h      |    1 +
 include/asm-generic/pgtable-nopud.h      |    1 +
 include/asm-generic/pgtable.h            |   53 +++++++++++++++++++++++++-----
 7 files changed, 87 insertions(+), 27 deletions(-)
