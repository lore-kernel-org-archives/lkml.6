Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752406AbeENSzK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:55:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:45332 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752013AbeENSwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:52:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="39244644"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "Alan Cox" <alan@linux.intel.com>
Cc: "x86" <x86@kernel.org>, "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 08/15] x86/split_lock: Set split lock during EFI runtime service
Date: Mon, 14 May 2018 11:52:18 -0700
Message-Id: <1526323945-211107-9-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If kernel enables #AC for split locked accesses, EFI runtime service may
hit #AC exception, treat it as fatal fault, and cause system hang.

To avoid debugging potential buggy EFI runtime service code in BIOS,
restore to BIOS split lock setting before entering EFI runtime service
and restore to kernel split lock setting after exiting EFI runtime service.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/include/asm/efi.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index cec5fae23eb3..6dcd0717a3cf 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -8,6 +8,7 @@
 #include <asm/tlb.h>
 #include <asm/nospec-branch.h>
 #include <asm/mmu_context.h>
+#include <asm/cpu.h>
 
 /*
  * We map the EFI regions needed for runtime services non-contiguously,
@@ -41,12 +42,14 @@ extern asmlinkage unsigned long efi_call_phys(void *, ...);
 #define arch_efi_call_virt_setup()					\
 ({									\
 	kernel_fpu_begin();						\
+	restore_split_lock_ac_bios(NULL);				\
 	firmware_restrict_branch_speculation_start();			\
 })
 
 #define arch_efi_call_virt_teardown()					\
 ({									\
 	firmware_restrict_branch_speculation_end();			\
+	restore_split_lock_ac_kernel(NULL);				\
 	kernel_fpu_end();						\
 })
 
@@ -84,6 +87,7 @@ struct efi_scratch {
 	efi_sync_low_kernel_mappings();					\
 	preempt_disable();						\
 	__kernel_fpu_begin();						\
+	restore_split_lock_ac_bios(NULL);				\
 	firmware_restrict_branch_speculation_start();			\
 									\
 	if (!efi_enabled(EFI_OLD_MEMMAP))				\
@@ -99,6 +103,7 @@ struct efi_scratch {
 		efi_switch_mm(efi_scratch.prev_mm);			\
 									\
 	firmware_restrict_branch_speculation_end();			\
+	restore_split_lock_ac_kernel(NULL);				\
 	__kernel_fpu_end();						\
 	preempt_enable();						\
 })
-- 
2.5.0
