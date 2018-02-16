Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeBPSrE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:47:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:42870 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbeBPSrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:47:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,520,1511856000";
   d="scan'208";a="204831562"
From: Ashok Raj <ashok.raj@intel.com>
To: bp@suse.de
Cc: ashok.raj@intel.com, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/microcode: Check microcode revision before updating sibling threads
Date: Fri, 16 Feb 2018 10:46:48 -0800
Message-Id: <1518806808-4074-1-git-send-email-ashok.raj@intel.com>
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
 arch/x86/kernel/cpu/microcode/intel.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 09b95a7..5802c2f 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -786,11 +786,21 @@ static enum ucode_state apply_microcode_intel(int cpu)
 
 	uci = ucode_cpu_info + cpu;
 	mc = uci->mc;
+
 	if (!mc) {
 		/* Look for a newer patch in our cache: */
 		mc = find_patch(uci);
 		if (!mc)
 			return UCODE_NFOUND;
+	} else {
+		rev = intel_get_microcode_revision();
+		/*
+		 * Its possible the microcode got udpated
+		 * because its sibling update was done earlier.
+		 * Skip the udpate in that case.
+		 */
+		if (rev == mc->hdr.rev)
+			goto done;
 	}
 
 	/* write microcode via MSR 0x79 */
@@ -813,6 +823,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 		prev_rev = rev;
 	}
 
+done:
 	c = &cpu_data(cpu);
 
 	uci->cpu_sig.rev = rev;
-- 
2.7.4
