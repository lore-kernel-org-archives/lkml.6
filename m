Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591B7C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 20:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A8120866
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 20:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A8120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeKEF2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 00:28:09 -0500
Received: from mga04.intel.com ([192.55.52.120]:16985 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725745AbeKEF2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 00:28:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 12:11:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,465,1534834800"; 
   d="scan'208";a="97569934"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga003.jf.intel.com with ESMTP; 04 Nov 2018 12:11:55 -0800
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH V3 0/3] Unmap EFI boot services code/data regions after boot.
Date:   Sun,  4 Nov 2018 12:10:16 -0800
Message-Id: <20181104201019.26142-1-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ing x86 folks because this patch set touches x86/mm which I am no expert of.

Ideally, after kernel assumes control of the platform, firmware shouldn't access
EFI boot services code/data regions. But, it's noticed that this is not so true
in many x86 platforms. Hence, during boot, kernel reserves EFI boot services
code/data regions [1] and maps [2] them to efi_pgd so that call to
set_virtual_address_map() doesn't fail. After returning from
set_virtual_address_map(), kernel frees the reserved regions [3] but they still
remain mapped.

This means that any code that's running in efi_pgd address space (e.g: any EFI
runtime service) would still be able to access EFI boot services code/data
regions but the contents of these regions would have long been over written by
someone else as they are freed by efi_free_boot_services(). So, it's important
to unmap these regions. After unmapping EFI boot services code/data regions, any
illegal access by buggy firmware to these regions would result in page fault
which will be handled by efi specific fault handler.

Unmapping EFI boot services code/data regions will result in clearing
PAGE_PRESENT bit and it shouldn't bother L1TF cases because it's already handled
by protnone_mask() at arch/x86/include/asm/pgtable-invert.h.

[1] Please see efi_reserve_boot_services()
[2] Please see efi_map_region() -> __map_region() -> kernel_map_pages_in_pgd()
[3] Please see efi_free_boot_services()

Testing the patch set:
----------------------
1. Download buggy firmware (which accesses boot regions even after kernel has
booted) from here [1].
2. Without the patch set, you shouldn't see any kernel warning/error messages
(i.e. kernel allows accesses to EFI boot services code/data regions even after
call to set_virtual_address_map()).
3. With the patch set, you should see a kernel warning about buggy firmware,
efi_rts_wq beeing freezed and disabling runtime services forever.

Please note that this patch will change kernel's existing behavior for some EFI
runtime services but I think it's OK because kernel should have never allowed
those accesses in the first place.

Also please note that this patch set needs lot of real time trashing as I just
tested it out with OVMF.

Note:
-----
Patch set based on "next" branch in efi tree.

Changes from V2 -> V3:
----------------------
1. Expliclty set pfn to 0 in kernel_unmap_pages_in_pgd().
2. Add __init modifier to kernel_<map/unmap>_pages_in_pgd().
3. Warn if kernel_<map/unmap>_pages_in_pgd() are called after smp_init().
4. Split efi_unmap_pages() into a separate patch.

Changes from V1 -> V2:
----------------------
1. Rewrite the cpa initializer in a more readable fashion.
2. Don't use cpa->pfn while unmapping, as it's not useful.
3. Unmap regions before freeing them up.
4. Fix spelling nits.

Sai Praneeth (3):
  x86/mm/pageattr: Introduce helper function to unmap EFI boot services
  x86/efi: Unmap EFI boot services code/data regions from efi_pgd
  x86/efi: Move efi_<reserve/free>_boot_services() to arch/x86

 arch/x86/include/asm/efi.h           |  2 ++
 arch/x86/include/asm/pgtable_types.h |  8 ++++++--
 arch/x86/mm/pageattr.c               | 40 ++++++++++++++++++++++++++++++++++--
 arch/x86/platform/efi/efi.c          |  2 ++
 arch/x86/platform/efi/quirks.c       | 25 ++++++++++++++++++++++
 include/linux/efi.h                  |  3 ---
 init/main.c                          |  4 ----
 7 files changed, 73 insertions(+), 11 deletions(-)

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

-- 
2.7.4

