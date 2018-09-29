Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D454C64EAE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A84F2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A84F2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbeI3EVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:21:17 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52020 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728771AbeI3ESf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:35 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6E-0000H5-Nm; Sat, 29 Sep 2018 22:48:30 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5w-0006rf-9c; Sat, 29 Sep 2018 22:48:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Borislav Petkov" <bp@suse.de>,
        "David Woodhouse" <dwmw@amazon.co.uk>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.170725272@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 035/131] x86/cpufeatures: Disentangle SSBD enumeration
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

commit 52817587e706686fcdb27f14c1b000c92f266c96 upstream.

The SSBD enumeration is similarly to the other bits magically shared
between Intel and AMD though the mechanisms are different.

Make X86_FEATURE_SSBD synthetic and set it depending on the vendor specific
features or family dependent setup.

Change the Intel bit to X86_FEATURE_SPEC_CTRL_SSBD to denote that SSBD is
controlled via MSR_SPEC_CTRL and fix up the usage sites.

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
 arch/x86/include/asm/cpufeature.h |  5 +++--
 arch/x86/kernel/cpu/amd.c         |  7 +------
 arch/x86/kernel/cpu/bugs.c        | 10 +++++-----
 arch/x86/kernel/cpu/common.c      |  3 +++
 arch/x86/kernel/cpu/intel.c       |  1 +
 arch/x86/kernel/process.c         |  2 +-
 6 files changed, 14 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -192,11 +192,12 @@
 #define X86_FEATURE_USE_IBPB	(7*32+12) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW (7*32+13) /* "" Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE (7*32+14) /* "" Disable Speculative Store Bypass. */
-#define X86_FEATURE_AMD_SSBD	(7*32+15)  /* "" AMD SSBD implementation */
+#define X86_FEATURE_LS_CFG_SSBD	(7*32+15) /* "" AMD SSBD implementation */
 #define X86_FEATURE_IBRS	(7*32+16) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB	(7*32+17) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP	(7*32+18) /* Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_MSR_SPEC_CTRL (7*32+19) /* "" MSR SPEC_CTRL is implemented */
+#define X86_FEATURE_SSBD	(7*32+20) /* Speculative Store Bypass Disable */
 
 #define X86_FEATURE_RETPOLINE	(7*32+29) /* "" Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_AMD (7*32+30) /* "" AMD Retpoline mitigation for Spectre variant 2 */
@@ -247,7 +248,7 @@
 #define X86_FEATURE_SPEC_CTRL		(10*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(10*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(10*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
-#define X86_FEATURE_SSBD		(10*32+31) /* Speculative Store Bypass Disable */
+#define X86_FEATURE_SPEC_CTRL_SSBD	(10*32+31) /* "" Speculative Store Bypass Disable */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 11 */
 #define X86_FEATURE_AMD_IBPB		(11*32+12) /* Indirect Branch Prediction Barrier */
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -486,8 +486,8 @@ static void bsp_init_amd(struct cpuinfo_
 		 * avoid RMW. If that faults, do not enable SSBD.
 		 */
 		if (!rdmsrl_safe(MSR_AMD64_LS_CFG, &x86_amd_ls_cfg_base)) {
+			setup_force_cpu_cap(X86_FEATURE_LS_CFG_SSBD);
 			setup_force_cpu_cap(X86_FEATURE_SSBD);
-			setup_force_cpu_cap(X86_FEATURE_AMD_SSBD);
 			x86_amd_ls_cfg_ssbd_mask = 1ULL << bit;
 		}
 	}
@@ -801,11 +801,6 @@ static void init_amd(struct cpuinfo_x86
 		set_cpu_bug(c, X86_BUG_AMD_APIC_C1E);
 
 	rdmsr_safe(MSR_AMD64_PATCH_LEVEL, &c->microcode, &dummy);
-
-	if (boot_cpu_has(X86_FEATURE_AMD_SSBD)) {
-		set_cpu_cap(c, X86_FEATURE_SSBD);
-		set_cpu_cap(c, X86_FEATURE_AMD_SSBD);
-	}
 }
 
 #ifdef CONFIG_X86_32
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -220,8 +220,8 @@ void x86_spec_ctrl_set_guest(u64 guest_s
 	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		return;
 
-	/* Intel controls SSB in MSR_SPEC_CTRL */
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
+	/* SSBD controlled in MSR_SPEC_CTRL */
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
 		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 
 	if (host != guest_spec_ctrl)
@@ -237,8 +237,8 @@ void x86_spec_ctrl_restore_host(u64 gues
 	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		return;
 
-	/* Intel controls SSB in MSR_SPEC_CTRL */
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
+	/* SSBD controlled in MSR_SPEC_CTRL */
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
 		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 
 	if (host != guest_spec_ctrl)
@@ -250,7 +250,7 @@ static void x86_amd_ssb_disable(void)
 {
 	u64 msrval = x86_amd_ls_cfg_base | x86_amd_ls_cfg_ssbd_mask;
 
-	if (boot_cpu_has(X86_FEATURE_AMD_SSBD))
+	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD))
 		wrmsrl(MSR_AMD64_LS_CFG, msrval);
 }
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -700,6 +700,9 @@ static void init_speculation_control(str
 	if (cpu_has(c, X86_FEATURE_INTEL_STIBP))
 		set_cpu_cap(c, X86_FEATURE_STIBP);
 
+	if (cpu_has(c, X86_FEATURE_SPEC_CTRL_SSBD))
+		set_cpu_cap(c, X86_FEATURE_SSBD);
+
 	if (cpu_has(c, X86_FEATURE_AMD_IBRS)) {
 		set_cpu_cap(c, X86_FEATURE_IBRS);
 		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -122,6 +122,7 @@ static void early_init_intel(struct cpui
 		setup_clear_cpu_cap(X86_FEATURE_MSR_SPEC_CTRL);
 		setup_clear_cpu_cap(X86_FEATURE_INTEL_STIBP);
 		setup_clear_cpu_cap(X86_FEATURE_SSBD);
+		setup_clear_cpu_cap(X86_FEATURE_SPEC_CTRL_SSBD);
 	}
 
 	/*
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -221,7 +221,7 @@ static __always_inline void __speculativ
 {
 	u64 msr;
 
-	if (static_cpu_has(X86_FEATURE_AMD_SSBD)) {
+	if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD)) {
 		msr = x86_amd_ls_cfg_base | ssbd_tif_to_amd_ls_cfg(tifn);
 		wrmsrl(MSR_AMD64_LS_CFG, msr);
 	} else {

