Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932090AbeB1KaZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 05:30:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37160 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752475AbeB1K3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 05:29:19 -0500
From: Borislav Petkov <bp@alien8.de>
To: X86 ML <x86@kernel.org>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] x86/microcode/intel: Look into the patch cache first
Date: Wed, 28 Feb 2018 11:28:44 +0100
Message-Id: <20180228102846.13447-6-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180228102846.13447-1-bp@alien8.de>
References: <20180228102846.13447-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The cache might contain a newer patch - look in there first.

A follow-on change will make sure newest patches are loaded into the
cache of microcode patches.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/intel.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index e2864bc2d575..2aded9db1d42 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -791,9 +791,9 @@ static int collect_cpu_info(int cpu_num, struct cpu_signature *csig)
 
 static enum ucode_state apply_microcode_intel(int cpu)
 {
-	struct microcode_intel *mc;
-	struct ucode_cpu_info *uci;
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
+	struct microcode_intel *mc;
 	static int prev_rev;
 	u32 rev;
 
@@ -801,11 +801,10 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	if (WARN_ON(raw_smp_processor_id() != cpu))
 		return UCODE_ERROR;
 
-	uci = ucode_cpu_info + cpu;
-	mc = uci->mc;
+	/* Look for a newer patch in our cache: */
+	mc = find_patch(uci);
 	if (!mc) {
-		/* Look for a newer patch in our cache: */
-		mc = find_patch(uci);
+		mc = uci->mc;
 		if (!mc)
 			return UCODE_NFOUND;
 	}
-- 
2.13.0
