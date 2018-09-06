Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE47AC4321E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B285A20857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 23:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B285A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeIGEGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 00:06:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:24972 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeIGEGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 00:06:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2018 16:28:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,339,1531810800"; 
   d="scan'208";a="68154895"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.52])
  by fmsmga007.fm.intel.com with ESMTP; 06 Sep 2018 16:28:51 -0700
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
Subject: [PATCH V4 3/3] x86/efi: Introduce EFI_PAGE_FAULT_HANDLER
Date:   Thu,  6 Sep 2018 16:27:48 -0700
Message-Id: <1536276468-28499-4-git-send-email-sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536276468-28499-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1536276468-28499-1-git-send-email-sai.praneeth.prakhya@intel.com>
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
with the warning, the efi page fault handler will also try to recover
from the page fault triggered by the firmware so that the machine
doesn't hang.

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
---
 arch/x86/Kconfig | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f1dbb4ee19d7..cc840710ae3e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1957,6 +1957,24 @@ config EFI_MIXED
 
 	   If unsure, say N.
 
+config EFI_PAGE_FAULT_HANDLER
+	bool "EFI page fault handler support" if EXPERT
+	depends on EFI
+	help
+	  Enable this debug feature so that the kernel can recover from page
+	  faults caused by buggy firmware. Also,
+	  1. If the page fault is caused by efi_reset_system(), then the
+	     platform is rebooted through BIOS.
+	  2. If the page fault is caused by any other efi runtime service,
+	     then the kernel freezes efi_rts_wq (work queue that runs efi
+	     runtime services) and schedules a new process. Also, it disables
+	     EFI Runtime Services, so that it will never again call buggy
+	     firmware.
+	  Please see the UEFI specification for details on the expectations
+	  of memory usage.
+
+	  If unsure, say N.
+
 config SECCOMP
 	def_bool y
 	prompt "Enable seccomp to safely compute untrusted bytecode"
-- 
2.7.4

