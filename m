Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6F1C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFC92077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 22:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AFC92077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeIEClQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:41:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:33782 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbeIEClQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:41:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 15:14:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,330,1531810800"; 
   d="scan'208";a="70343589"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.52])
  by orsmga007.jf.intel.com with ESMTP; 04 Sep 2018 15:14:08 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     ricardo.neri@intel.com, matt@codeblueprint.co.uk,
        Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH V3 0/5] Add efi page fault handler to detect and recover
Date:   Tue,  4 Sep 2018 15:12:24 -0700
Message-Id: <1536099149-12564-1-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

There may exist some buggy UEFI firmware implementations that access efi
memory regions other than EFI_RUNTIME_SERVICES_<CODE/DATA> even after
the kernel has assumed control of the platform. This violates UEFI
specification. Hence, provide a debug config option which when enabled
detects and recovers from page faults caused by buggy firmware.

The above said illegal accesses trigger page fault in ring 0 because
firmware executes at ring 0 and if unhandled it hangs the kernel.
Provide an efi specific page fault handler to:
1. Avoid panics/hangs caused by buggy firmware.
2. Shout loud that the firmware is buggy and hence is not a kernel bug.

Upon detetcing that the illegally accessed region is any region other
than EFI_RUNTIME_SERVICES_<CODE/DATA>, the efi page fault handler will
check if the access is by efi_reset_system().
1. If so, then the efi page fault handler will reboot the machine
   through BIOS and not through efi_reset_system().
2. If not, then the efi page fault handler will freeze efi_rts_wq and
   schedules a new process.

This issue was reported by Al Stone when he saw that reboot via EFI hangs
the machine. Upon debugging, I found that it's efi_reset_system() that's
touching memory regions which it shouldn't. To reproduce the same
behavior, I have hacked OVMF and made efi_reset_system() buggy. Along
with efi_reset_system(), I have also modified get_next_high_mono_count()
and set_virtual_address_map(). They illegally access both boot time and
other efi regions.

Testing the patch set:
----------------------
1. Download buggy firmware from here [1].
2. Run a qemu instance with this buggy BIOS and boot mainline kernel.
Add reboot=efi to the kernel command line arguments and after the kernel
is up and running, type "reboot". The kernel should hang while rebooting.
3. With the same setup, boot kernel after applying patches and the
reboot should work fine. Also please notice warning/error messages
printed by kernel.

Changes from RFC to V1:
-----------------------
1. Drop "long jump" technique of dealing with illegal access and instead
   use scheduling away from efi_rts_wq.

Changes from V1 to V2:
----------------------
1. Shortened config name to CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS from
   CONFIG_EFI_WARN_ON_ILLEGAL_ACCESSES.
2. Made the config option available only to expert users.
3. efi_free_boot_services() should be called only when
   CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS is not enabled. Previously, this
   was part of init/main.c file. As it is an architecture agnostic code,
   moved the change to arch/x86/platform/efi/quirks.c file.

Changes from V2 to V3:
----------------------
1. Drop treating illegal access to EFI_BOOT_SERVICES_<CODE/DATA> regions
   separatley from illegal accesses to other regions like
   EFI_CONVENTIONAL_MEMORY or EFI_LOADER_<CODE/DATA>.
   In previous versions, illegal access to EFI_BOOT_SERVICES_<CODE/DATA>
   regions were handled by mapping requested region to efi_pgd but from
   V3 they are handled similar to illegal access to other regions i.e by
   freezing efi_rts_wq and scheduling new process.
2. Change __efi_init_fixup attribute to __efi_init.

Note:
-----
Patch set based on "next" branch in efi tree.

[1] https://drive.google.com/drive/folders/1VozKTms92ifyVHAT0ZDQe55ZYL1UE5wt

Sai Praneeth (5):
  efi: Make efi_rts_work accessible to efi page fault handler
  efi: Introduce __efi_init attribute
  x86/efi: Permanently save the EFI_MEMORY_MAP passed by the firmware
  x86/efi: Add efi page fault handler to recover from the page faults   
     caused by firmware
  x86/efi: Introduce EFI_WARN_ON_ILLEGAL_ACCESS

 arch/x86/Kconfig                        |  17 +++
 arch/x86/include/asm/efi.h              |  11 ++
 arch/x86/mm/fault.c                     |   9 ++
 arch/x86/platform/efi/efi.c             |   2 +
 arch/x86/platform/efi/quirks.c          | 188 ++++++++++++++++++++++++++++++++
 drivers/firmware/efi/efi.c              |   4 +-
 drivers/firmware/efi/runtime-wrappers.c |  60 +++-------
 include/linux/efi.h                     |  51 ++++++++-
 8 files changed, 295 insertions(+), 47 deletions(-)

Suggested-by: Matt Fleming <matt@codeblueprint.co.uk>
Based-on-code-from: Ricardo Neri <ricardo.neri@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Al Stone <astone@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

-- 
2.7.4

