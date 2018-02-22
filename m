Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeBVGdg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 01:33:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:55370 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752399AbeBVGde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 01:33:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="31891775"
From: Ashok Raj <ashok.raj@intel.com>
To: bp@suse.de
Cc: Ashok Raj <ashok.raj@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: [v2 1/3] x86/microcode/intel: Check microcode revision before updating sibling threads
Date: Wed, 21 Feb 2018 22:33:23 -0800
Message-Id: <1519281205-58951-2-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519281205-58951-1-git-send-email-ashok.raj@intel.com>
References: <1519281205-58951-1-git-send-email-ashok.raj@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After updating microcode on one of the threads in the core, the
thread sibling automatically gets the update since the microcode
resources are shared. Check the ucode revision on the CPU before
performing a ucode update.

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

Updates:
v2: Address Boris's to cleanup apply_microcode_intel
v3: Fixups per Ingo: Spell Checks
---
 arch/x86/kernel/cpu/microcode/intel.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 09b95a7..137c9f5 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -589,6 +589,18 @@ static int apply_microcode_early(struct ucode_cpu_info *uci, bool early)
 	if (!mc)
 		return 0;
 
+	rev = intel_get_microcode_revision();
+
+	/*
+	 * Its possible the microcode got updated
+	 * because its sibling update was done earlier.
+	 * Skip the update in that case.
+	 */
+	if (rev >= mc->hdr.rev) {
+		uci->cpu_sig.rev = rev;
+		return UCODE_OK;
+	}
+
 	/* write microcode via MSR 0x79 */
 	native_wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -776,7 +788,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 {
 	struct microcode_intel *mc;
 	struct ucode_cpu_info *uci;
-	struct cpuinfo_x86 *c;
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	static int prev_rev;
 	u32 rev;
 
@@ -793,6 +805,18 @@ static enum ucode_state apply_microcode_intel(int cpu)
 			return UCODE_NFOUND;
 	}
 
+	rev = intel_get_microcode_revision();
+	/*
+	 * Its possible the microcode got updated
+	 * because its sibling update was done earlier.
+	 * Skip the update in that case.
+	 */
+	if (rev >= mc->hdr.rev) {
+		uci->cpu_sig.rev = rev;
+		c->microcode = rev;
+		return UCODE_OK;
+	}
+
 	/* write microcode via MSR 0x79 */
 	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -813,8 +837,6 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		prev_rev = rev;
 	}
 
-	c = &cpu_data(cpu);
-
 	uci->cpu_sig.rev = rev;
 	c->microcode = rev;
 
-- 
2.7.4
