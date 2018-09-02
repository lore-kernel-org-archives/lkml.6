Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB09C43143
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F369C20837
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F369C20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeIBOC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:02:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:58897 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727186AbeIBOC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:02:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2018 02:47:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,319,1531810800"; 
   d="scan'208";a="69718305"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.52])
  by orsmga007.jf.intel.com with ESMTP; 02 Sep 2018 02:47:47 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ricardo.neri@intel.com, matt@codeblueprint.co.uk,
        Sai Praneeth <sai.praneeth.prakhya@intel.com>,
        Lee Chun-Yi <jlee@suse.com>, Al Stone <astone@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH V2 6/6] x86/efi: Introduce EFI_WARN_ON_ILLEGAL_ACCESS
Date:   Sun,  2 Sep 2018 02:46:34 -0700
Message-Id: <1535881594-25469-7-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535881594-25469-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1535881594-25469-1-git-send-email-sai.praneeth.prakhya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

There may exist some buggy UEFI firmware implementations that might
access efi regions other than EFI_RUNTIME_SERVICES_<CODE/DATA> even
after the kernel has assumed control of the platform. This violates UEFI
specification.

If selected, this debug option will print a warning message if the UEFI
firmware tries to access any memory region which it shouldn't. Along
with the warning, the efi page fault handler will also try to
fixup/recover from the page fault triggered by the firmware so that the
machine doesn't hang.

To support this feature, two changes should be made to the existing efi
subsystem
1. Map EFI_BOOT_SERVICES_<CODE/DATA> regions only when
   EFI_WARN_ON_ILLEGAL_ACCESS is disabled
    Presently, the kernel maps EFI_BOOT_SERVICES_<CODE/DATA> regions as
    a workaround for buggy firmware that accesses them even when they
    shouldn't. With EFI_WARN_ON_ILLEGAL_ACCESS enabled (and hence efi
    page fault handler) kernel can now detect and handle such accesses
    dynamically. Hence, rather than safely mapping
    EFI_BOOT_SERVICES_<CODE/DATA> regions *all* the time, map them on
    demand.

2. If EFI_WARN_ON_ILLEGAL_ACCESS is enabled don't call
   efi_free_boot_services()
    Presently, during early boot phase EFI_BOOT_SERVICES_<CODE/DATA>
    regions are marked as reserved by kernel
    (see efi_reserve_boot_services()) and are freed before entering
    runtime (see efi_free_boot_services()). But, while dynamically
    fixing page faults caused by the firmware, efi page fault handler
    assumes that EFI_BOOT_SERVICES_<CODE/DATA> regions are still intact.
    Hence, to make this assumption true, don't call
    efi_free_boot_services() if EFI_WARN_ON_ILLEGAL_ACCESS is enabled.

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
---
 arch/x86/Kconfig               | 21 +++++++++++++++++++++
 arch/x86/platform/efi/efi.c    |  4 ++++
 arch/x86/platform/efi/quirks.c |  3 +++
 3 files changed, 28 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f1dbb4ee19d7..0fb1309d510d 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1957,6 +1957,27 @@ config EFI_MIXED
 
 	   If unsure, say N.
 
+config EFI_WARN_ON_ILLEGAL_ACCESS
+	bool "Warn about illegal memory accesses by firmware" if EXPERT
+	depends on EFI
+	help
+	  Enable this debug feature so that the kernel can detect illegal
+	  memory accesses by firmware and issue a warning. Also,
+	  1. If the illegally accessed region is EFI_BOOT_SERVICES_<CODE/DATA>,
+	     the kernel fixes it up by mapping the requested region.
+	  2. If the illegally accessed region is any other region (Eg:
+	     EFI_CONVENTIONAL_MEMORY or EFI_LOADER_<CODE/DATA>), then the
+	     kernel freezes efi_rts_wq and schedules a new process. Also, it
+	     disables EFI Runtime Services, so that it will never again call
+	     buggy firmware.
+	  3. If the access is to any other efi region like above but if the
+	     buggy efi runtime service is efi_reset_system(), then the
+	     platform is rebooted through BIOS.
+	  Please see the UEFI specification for details on the expectations
+	  of memory usage.
+
+	  If unsure, say N.
+
 config SECCOMP
 	def_bool y
 	prompt "Enable seccomp to safely compute untrusted bytecode"
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 7d18b7ed5d41..77fbcb798f4e 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -768,9 +768,13 @@ static bool should_map_region(efi_memory_desc_t *md)
 	/*
 	 * Map boot services regions as a workaround for buggy
 	 * firmware that accesses them even when they shouldn't.
+	 * (only if CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS is disabled)
 	 *
 	 * See efi_{reserve,free}_boot_services().
 	 */
+	if (IS_ENABLED(CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS))
+		return false;
+
 	if (md->type == EFI_BOOT_SERVICES_CODE ||
 	    md->type == EFI_BOOT_SERVICES_DATA)
 		return true;
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index e38e823382ba..60cb7a8d5371 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -377,6 +377,9 @@ void __init efi_free_boot_services(void)
 	int num_entries = 0;
 	void *new, *new_md;
 
+	if (IS_ENABLED(CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS))
+		return;
+
 	for_each_efi_memory_desc(md) {
 		unsigned long long start = md->phys_addr;
 		unsigned long long size = md->num_pages << EFI_PAGE_SHIFT;
-- 
2.7.4

