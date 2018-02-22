Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752589AbeBVGeO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 01:34:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:55370 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752478AbeBVGde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 01:33:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="31891778"
From: Ashok Raj <ashok.raj@intel.com>
To: bp@suse.de
Cc: Ashok Raj <ashok.raj@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [v2 2/3] x86/microcode/intel: Perform a cache flush before ucode update.
Date: Wed, 21 Feb 2018 22:33:24 -0800
Message-Id: <1519281205-58951-3-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519281205-58951-1-git-send-email-ashok.raj@intel.com>
References: <1519281205-58951-1-git-send-email-ashok.raj@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microcode updates can be safer if the caches are clean.
Some of the issues around in certain Broadwell parts
can be addressed by doing a full cache flush.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Boris Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>
---
 arch/x86/kernel/cpu/microcode/intel.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 137c9f5..50e48c4 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -601,6 +601,13 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 		return UCODE_OK;
 	}
 
+	/*
+	 * Microcode updates can be safer if the caches are clean.
+	 * Some of the issues around in certain Broadwell parts
+	 * can be addressed by doing a full cache flush.
+	 */
+	native_wbinvd();
+
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -817,6 +824,13 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		return UCODE_OK;
 	}
 
+	/*
+	 * Microcode updates can be safer if the caches are clean.
+	 * Some of the issues around in certain Broadwell parts
+	 * can be addressed by doing a full cache flush.
+	 */
+	wbinvd();
+
 	/* write microcode via MSR 0x79 */
 	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
-- 
2.7.4
