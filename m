Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeBPTeh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:34:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:17845 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752024AbeBPTef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:34:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="18472146"
From: Ashok Raj <ashok.raj@intel.com>
To: bp@suse.de
Cc: ashok.raj@intel.com, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/microcode/intel: Check microcode revision before updating sibling threads
Date: Fri, 16 Feb 2018 11:34:29 -0800
Message-Id: <1518809669-3651-1-git-send-email-ashok.raj@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After updating microcode on one of the threads in the core, the
thread sibling automatically gets the update since the microcode
resources are shared. Check the ucode revision on the cpu before
performing a ucode update.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
---
 arch/x86/kernel/cpu/microcode/intel.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 09b95a7..036d1db 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -776,7 +776,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 {
 	struct microcode_intel *mc;
 	struct ucode_cpu_info *uci;
-	struct cpuinfo_x86 *c;
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	static int prev_rev;
 	u32 rev;
 
@@ -793,6 +793,18 @@ static enum ucode_state apply_microcode_intel(int cpu)
 			return UCODE_NFOUND;
 	}
 
+	rev = intel_get_microcode_revision();
+	/*
+	 * Its possible the microcode got udpated
+	 * because its sibling update was done earlier.
+	 * Skip the udpate in that case.
+	 */
+	if (rev >= mc->hdr.rev) {
+		uci->cpu_sig.rev = rev;
+		c->microcode = rev;
+		return UCODE_OK;
+	}
+
 	/* write microcode via MSR 0x79 */
 	wrmsrl(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
 
@@ -813,8 +825,6 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		prev_rev = rev;
 	}
 
-	c = &cpu_data(cpu);
-
 	uci->cpu_sig.rev = rev;
 	c->microcode = rev;
 
-- 
2.7.4
