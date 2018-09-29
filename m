Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66864C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6CE2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:48:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6CE2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbeI3ESj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52021 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728767AbeI3ESf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:35 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6E-0000H7-SK; Sat, 29 Sep 2018 22:48:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5w-0006ra-8e; Sat, 29 Sep 2018 22:48:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Borislav Petkov" <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "David Woodhouse" <dwmw@amazon.co.uk>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.627348666@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 034/131] x86/cpufeatures: Disentangle MSR_SPEC_CTRL
 enumeration from IBRS
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 7eb8956a7fec3c1f0abc2a5517dada99ccc8a961 upstream.

The availability of the SPEC_CTRL MSR is enumerated by a CPUID bit on
Intel and implied by IBRS or STIBP support on AMD. That's just confusing
and in case an AMD CPU has IBRS not supported because the underlying
problem has been fixed but has another bit valid in the SPEC_CTRL MSR,
the thing falls apart.

Add a synthetic feature bit X86_FEATURE_MSR_SPEC_CTRL to denote the
availability on both Intel and AMD.

While at it replace the boot_cpu_has() checks with static_cpu_has() where
possible. This prevents late microcode loading from exposing SPEC_CTRL, but
late loading is already very limited as it does not reevaluate the
mitigation options and other bits and pieces. Having static_cpu_has() is
the simplest and least fragile solution.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - Use the next available bit number in CPU feature word 7
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/cpufeature.h |  1 +
 arch/x86/kernel/cpu/bugs.c        | 18 +++++++++++-------
 arch/x86/kernel/cpu/common.c      |  9 +++++++--
 arch/x86/kernel/cpu/intel.c       |  1 +
 4 files changed, 20 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -196,6 +196,7 @@
 #define X86_FEATURE_IBRS	(7*32+16) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB	(7*32+17) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP	(7*32+18) /* Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_MSR_SPEC_CTRL (7*32+19) /* "" MSR SPEC_CTRL is implemented */
 
 #define X86_FEATURE_RETPOLINE	(7*32+29) /* "" Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_AMD (7*32+30) /* "" AMD Retpoline mitigation for Spectre variant 2 */
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -121,7 +121,7 @@ void __init check_bugs(void)
 	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
 	 * init code as it is not enumerated and depends on the family.
 	 */
-	if (boot_cpu_has(X86_FEATURE_IBRS))
+	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 
 	/* Select the proper spectre mitigation before patching alternatives */
@@ -206,7 +206,7 @@ u64 x86_spec_ctrl_get_default(void)
 {
 	u64 msrval = x86_spec_ctrl_base;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
 		msrval |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 	return msrval;
 }
@@ -216,10 +216,12 @@ void x86_spec_ctrl_set_guest(u64 guest_s
 {
 	u64 host = x86_spec_ctrl_base;
 
-	if (!boot_cpu_has(X86_FEATURE_IBRS))
+	/* Is MSR_SPEC_CTRL implemented ? */
+	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		return;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+	/* Intel controls SSB in MSR_SPEC_CTRL */
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
 		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 
 	if (host != guest_spec_ctrl)
@@ -231,10 +233,12 @@ void x86_spec_ctrl_restore_host(u64 gues
 {
 	u64 host = x86_spec_ctrl_base;
 
-	if (!boot_cpu_has(X86_FEATURE_IBRS))
+	/* Is MSR_SPEC_CTRL implemented ? */
+	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		return;
 
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+	/* Intel controls SSB in MSR_SPEC_CTRL */
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
 		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 
 	if (host != guest_spec_ctrl)
@@ -668,7 +672,7 @@ int arch_prctl_spec_ctrl_get(struct task
 
 void x86_spec_ctrl_setup_ap(void)
 {
-	if (boot_cpu_has(X86_FEATURE_IBRS))
+	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		x86_spec_ctrl_set(x86_spec_ctrl_base & ~x86_spec_ctrl_mask);
 
 	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -694,19 +694,24 @@ static void init_speculation_control(str
 	if (cpu_has(c, X86_FEATURE_SPEC_CTRL)) {
 		set_cpu_cap(c, X86_FEATURE_IBRS);
 		set_cpu_cap(c, X86_FEATURE_IBPB);
+		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
 	}
 
 	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))
 		set_cpu_cap(c, X86_FEATURE_STIBP);
 
-	if (cpu_has(c, X86_FEATURE_AMD_IBRS))
+	if (cpu_has(c, X86_FEATURE_AMD_IBRS)) {
 		set_cpu_cap(c, X86_FEATURE_IBRS);
+		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
+	}
 
 	if (cpu_has(c, X86_FEATURE_AMD_IBPB))
 		set_cpu_cap(c, X86_FEATURE_IBPB);
 
-	if (cpu_has(c, X86_FEATURE_AMD_STIBP))
+	if (cpu_has(c, X86_FEATURE_AMD_STIBP)) {
 		set_cpu_cap(c, X86_FEATURE_STIBP);
+		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
+	}
 }
 
 void get_cpu_cap(struct cpuinfo_x86 *c)
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -119,6 +119,7 @@ static void early_init_intel(struct cpui
 		setup_clear_cpu_cap(X86_FEATURE_IBPB);
 		setup_clear_cpu_cap(X86_FEATURE_STIBP);
 		setup_clear_cpu_cap(X86_FEATURE_SPEC_CTRL);
+		setup_clear_cpu_cap(X86_FEATURE_MSR_SPEC_CTRL);
 		setup_clear_cpu_cap(X86_FEATURE_INTEL_STIBP);
 		setup_clear_cpu_cap(X86_FEATURE_SSBD);
 	}

