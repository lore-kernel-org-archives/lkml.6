Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3927AC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 04:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFC421C36
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 04:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFC421C36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeHIGyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 02:54:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:55053 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbeHIGyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 02:54:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 21:31:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,213,1531810800"; 
   d="scan'208";a="61024005"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.52])
  by fmsmga007.fm.intel.com with ESMTP; 08 Aug 2018 21:31:44 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ricardo.ner@intel.com, matt@codeblueprint.co.uk,
        Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Lee Chun-Yi <jlee@suse.com>, Al Stone <astone@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH V1 0/6] Add efi page fault handler to fix/recover from
Date:   Wed,  8 Aug 2018 21:31:11 -0700
Message-Id: <1533789077-16156-1-git-send-email-sai.praneeth.prakhya@intel.com>
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
detects and fixes/recovers from page faults caused by buggy firmware.

The above said illegal accesses trigger page fault in ring 0 because
firmware executes at ring 0 and if unhandled it hangs the kernel. We
provide an efi specific page fault handler to:
1. Avoid panics/hangs caused by buggy firmware.
2. Shout loud that the firmware is buggy and hence is not a kernel bug.

Depending on the illegally accessed efi region, the efi page fault
handler handles illegal accesses differently.
1. If the illegally accessed region is EFI_BOOT_SERVICES_<CODE/DATA>,
   the efi page fault handler fixes it up by mapping the requested
   region.
2. If any other region (Eg: EFI_CONVENTIONAL_MEMORY or
   EFI_LOADER_<CODE/DATA>), then the efi page fault handler freezes
   efi_rts_wq and schedules a new process.
3. If the access is to any other efi region like above but if the efi
   runtime service is efi_reset_system(), then the efi page fault
   handler will reboot the machine through BIOS.

Illegal accesses to EFI_BOOT_SERVICES_<CODE/DATA> and to other regions
are dealt differently in efi page fault handler because, *generally*
EFI_BOOT_SERVICES_<CODE/DATA> regions are smaller in size relative to
other efi regions and hence could be reserved and can be dynamically
mapped. But other EFI regions like EFI_CONVENTIONAL_MEMORY and
EFI_LOADER_<CODE/DATA> cannot be reserved as they are very huge in size
and reserving them will make the kernel un-bootable.

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

Note:
-----
Patch set based on "next" branch in efi tree.

[1] https://drive.google.com/drive/folders/1VozKTms92ifyVHAT0ZDQe55ZYL1UE5wt

Sai Praneeth (6):
  efi: Make efi_rts_work accessible to efi page fault handler
  x86/efi: Remove __init attribute from memory mapping functions
  x86/efi: Permanently save the EFI_MEMORY_MAP passed by the firmware
  x86/efi: Add efi page fault handler to fixup/recover from page faults 
       caused by firmware
  x86/mm: If in_atomic(), allocate pages without sleeping
  x86/efi: Introduce EFI_WARN_ON_ILLEGAL_ACCESSES

 arch/x86/Kconfig                        |  21 ++++
 arch/x86/include/asm/efi.h              |  24 +++-
 arch/x86/mm/fault.c                     |   9 ++
 arch/x86/mm/pageattr.c                  |  16 ++-
 arch/x86/platform/efi/efi.c             |  10 +-
 arch/x86/platform/efi/efi_32.c          |   2 +-
 arch/x86/platform/efi/efi_64.c          |   9 +-
 arch/x86/platform/efi/quirks.c          | 201 ++++++++++++++++++++++++++++++++
 drivers/firmware/efi/efi.c              |   6 +-
 drivers/firmware/efi/runtime-wrappers.c |  60 +++-------
 include/linux/efi.h                     |  53 ++++++++-
 init/main.c                             |   3 +-
 12 files changed, 350 insertions(+), 64 deletions(-)

Suggested-by: Matt Fleming <matt@codeblueprint.co.uk>
Based-on-code-from: Ricardo Neri <ricardo.neri@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Lee Chun-Yi <jlee@suse.com>
Cc: Al Stone <astone@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

-- 
2.7.4

