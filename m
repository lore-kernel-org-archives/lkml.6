Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeBXWR2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 17:17:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:23057 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751399AbeBXWR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 17:17:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,389,1515484800";
   d="scan'208";a="20564903"
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Zijlstra <peter.zijlstra@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH V1 0/3] Use efi_rts_workqueue to invoke EFI Runtime Services
Date: Sat, 24 Feb 2018 14:10:46 -0800
Message-Id: <1519510249-31447-1-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

This patch set is an outcome of the discussion at
https://lkml.org/lkml/2017/8/21/607

Presently, efi_runtime_services() are executed by firmware in process
context. To execute efi_runtime_service(), kernel switches the page
directory from swapper_pgd to efi_pgd. However, efi_pgd doesn't have any
user space mappings. A potential issue could be, for instance, an NMI
interrupt (like perf) trying to profile some user data while in efi_pgd.

A solution for this issue could be to use kthread to run
efi_runtime_service(). When a user/kernel thread requests to execute
efi_runtime_service(), kernel off-loads this work to kthread which in
turn uses efi_pgd. Anything that tries to touch user space addresses
while in kthread is terminally broken. This patch set adds support to
the efi subsystem to handle all calls to efi_runtime_services() using a
work queue (which in turn uses kthread).

Implementation summary:
-----------------------
1. When a user/kernel thread requests to execute efi_runtime_service(),
enqueue work to a work queue, efi_rts_workqueue.
2. The caller thread waits until the work is finished because it's
dependent on the return status of efi_runtime_service() and, in specific
cases, the arguments populated by efi_runtime_service(). Some
efi_runtime_services() takes a pointer to buffer as an argument and
fills up the buffer with requested data. For instance, efi_get_variable()
and efi_get_next_variable(). Hence, the caller process cannot just post
the work and get going, it has to wait for results from firmware.

Caveat: efi_rts_workqueue to run efi_runtime_services() shouldn't be used
while in atomic, because caller thread might sleep. Presently, pstore
code doesn't use efi_rts_workqueue.

Tested using LUV (Linux UEFI Validation) for x86_64 and x86_32. Builds
fine for arm and arm64. Will appreciate the effort if someone could test
the patches on ARM (although I was able to boot with LUV for ARM).
LUV: https://01.org/linux-uefi-validation

Thanks to Ricardo and Dan for initial reviews and suggestions. Please
feel free to pour in your comments and concerns.
Note: Patches are based on Linus's kernel v4.16-rc2

Sai Praneeth (3):
  x86/efi: Call efi_delete_dummy_variable() during efi subsystem    
    initialization
  efi: Introduce efi_rts_workqueue and necessary infrastructure to
    invoke     all efi_runtime_services()
  efi: Use efi_rts_workqueue to invoke EFI Runtime Services

 arch/x86/include/asm/efi.h              |   1 -
 arch/x86/platform/efi/efi.c             |   6 -
 drivers/firmware/efi/efi.c              |  18 +++
 drivers/firmware/efi/runtime-wrappers.c | 229 +++++++++++++++++++++++++++++---
 include/linux/efi.h                     |  26 ++++
 5 files changed, 253 insertions(+), 27 deletions(-)

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Cc: Lee, Chun-Yi <jlee@suse.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Ricardo Neri <ricardo.neri@intel.com>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Peter Zijlstra <peter.zijlstra@intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Dan Williams <dan.j.williams@intel.com>

-- 
2.1.4
