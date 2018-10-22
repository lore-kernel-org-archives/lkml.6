Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D0EECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958362083E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958362083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJVJxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 05:53:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:63581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbeJVJxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 05:53:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2018 18:36:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,410,1534834800"; 
   d="scan'208";a="97296416"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga002.fm.intel.com with ESMTP; 21 Oct 2018 18:36:48 -0700
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
Subject: [PATCH 0/2] Unmap efi boot services code/data regions after boot.
Date:   Sun, 21 Oct 2018 18:35:43 -0700
Message-Id: <1540172145-17134-1-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ing x86 folks because this patch touches x86/mm which I am no expert of.

[Copied from Patch 1]
Ideally, after kernel assumes control of the platform firmware shouldn't
access EFI Boot Services Code/Data regions. But, it's noticed that this
is not so true in many x86 platforms. Hence, during boot, kernel
reserves efi boot services code/data regions [1] and maps [2] them to
efi_pgd so that call to set_virtual_address_map() doesn't fail. After
returning from set_virtual_address_map(), kernel frees the reserved
regions [3] but they still remain mapped.

This means that any code that's running in efi_pgd address space (e.g:
any efi runtime service) would still be able to access efi boot services
code/data regions but the contents of these regions would have long been
over written by someone else as they are freed by efi_free_boot_services().
So, it's important to unmap these regions. After unmapping boot services
code/data regions, any illegal access by buggy firmware to these regions
would result in page fault which will be handled by efi specific fault
handler.

[1] Please see efi_reserve_boot_services()
[2] Please see efi_map_region() -> __map_region()
[3] Please see efi_free_boot_services()

Testing the patch set:
----------------------
1. Download buggy firmware (which accesses boot regions even after kernel has
booted) from here [1].
2. Without the patch set, you shouldn't see any kernel warning/error
messages (i.e. kernel allows accesses to efi boot services code/data
regions even after call to set_virtual_address_map()).
3. With the patch set, you should see a kernel warning about buggy
firmware, efi_rts_wq beeing freezed and disabling runtime services forever.

Please note that this patch will change kernel's existing behavior for
some efi runtime services but I think it's OK because kernel should have
never allowed those accesses in the first place.

Also please note that this patch set needs lot of real time trashing as
I just tested it out with OVMF.

Note:
-----
Patch set based on "next" branch in efi tree.

[1] https://drive.google.com/drive/folders/1VozKTms92ifyVHAT0ZDQe55ZYL1UE5wt

Sai Praneeth (2):
  x86/efi: Unmap efi boot services code/data regions from efi_pgd
  x86/efi: Move efi_<reserve/free>_boot_services() to arch/x86

 arch/x86/include/asm/efi.h           |  2 ++
 arch/x86/include/asm/pgtable_types.h |  2 ++
 arch/x86/mm/pageattr.c               | 21 +++++++++++++++++++++
 arch/x86/platform/efi/efi.c          |  2 ++
 arch/x86/platform/efi/quirks.c       | 26 ++++++++++++++++++++++++++
 include/linux/efi.h                  |  3 ---
 init/main.c                          |  4 ----
 7 files changed, 53 insertions(+), 7 deletions(-)

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

