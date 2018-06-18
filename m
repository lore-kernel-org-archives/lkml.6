Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30853C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE7622075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7622075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936386AbeFRThH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:37:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:23422 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935923AbeFRThF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:37:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 12:37:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,240,1526367600"; 
   d="scan'208";a="50313564"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.145])
  by orsmga008.jf.intel.com with ESMTP; 18 Jun 2018 12:37:04 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH V2] x86/efi: Free allocated memory if remap fails
Date:   Mon, 18 Jun 2018 12:36:54 -0700
Message-Id: <1529350614-15555-1-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

efi_memmap_alloc(), as the name suggests, allocates memory for a new efi
memory map. It's referenced from couple of places, namely,
efi_arch_mem_reserve() and efi_free_boot_services(). These callers,
after allocating memory, remap it for further use. As usual, a routine
check is performed to confirm successful remap. If the remap fails,
ideally, the allocated memory should be freed but presently we just
return without freeing it up. Hence, fix this bug by freeing up the
memory appropriately.

As efi_memmap_alloc() allocates memory depending on whether mm_init()
has already been invoked or not, similarly, while freeing use
memblock_free() to free memory allocated before invoking mm_init() and
__free_pages() to free memory allocated after invoking mm_init().

It's a fact that memremap() and early_memremap() might never fail and
this code might never get a chance to run but to maintain good kernel
programming semantics, we might need this patch.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Lee Chun-Yi <jlee@suse.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

I found this bug when working on a different patch set which uses
efi_memmap_alloc() and then noticed that I never freed the allocated
memory. I found it weird, in the sense that, memory is allocated but is
not freed (upon returning from an error). So, wasn't sure if that should
be treated as a bug or should I just leave it as is because everything
works fine even without this patch. Since the effort for the patch is
very minimal, I just went ahead and posted one, so that I could know
your thoughts on it.

Changes from V1 to V2:
----------------------
1. Fix the bug of freeing memory map that was just installed by correctly
    calling free_pages().
2. Call memblock_free() and __free_pages() directly from the appropriate
    places instead of efi_memmap_free().

Note: Patch based on Linus's mainline tree V4.18-rc1

 arch/x86/platform/efi/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 36c1f8b9f7e0..cfa93af97def 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -285,6 +285,7 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	new = early_memremap(new_phys, new_size);
 	if (!new) {
 		pr_err("Failed to map new boot services memmap\n");
+		memblock_free(new_phys, new_size);
 		return;
 	}
 
@@ -429,6 +430,7 @@ void __init efi_free_boot_services(void)
 	new = memremap(new_phys, new_size, MEMREMAP_WB);
 	if (!new) {
 		pr_err("Failed to map new EFI memmap\n");
+		__free_pages(pfn_to_page(PHYS_PFN(new_phys)), get_order(new_size));
 		return;
 	}
 
@@ -452,6 +454,7 @@ void __init efi_free_boot_services(void)
 
 	if (efi_memmap_install(new_phys, num_entries)) {
 		pr_err("Could not install new EFI memmap\n");
+		__free_pages(pfn_to_page(PHYS_PFN(new_phys)), get_order(new_size));
 		return;
 	}
 }
-- 
2.7.4

