Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE8CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577C920856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577C920856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389543AbeGWNsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:48:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389530AbeGWNr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:47:59 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0993ACBF;
        Mon, 23 Jul 2018 12:46:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 085/107] x86/cpufeatures: Disentangle SSBD enumeration
Date:   Mon, 23 Jul 2018 14:42:19 +0200
Message-Id: <20180723122417.742344302@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 52817587e706686fcdb27f14c1b000c92f266c96 upstream

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
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/cpufeatures.h |    6 ++++--
 arch/x86/kernel/cpu/amd.c          |    7 +------
 arch/x86/kernel/cpu/bugs.c         |   10 +++++-----
 arch/x86/kernel/cpu/common.c       |    3 +++
 arch/x86/kernel/cpu/intel.c        |    1 +
 arch/x86/kernel/process.c          |    2 +-
 6 files changed, 15 insertions(+), 14 deletions(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -200,6 +200,7 @@
 #define X86_FEATURE_RETPOLINE_AMD ( 7*32+30) /* "" AMD Retpoline mitigation for Spectre variant 2 */
 
 #define X86_FEATURE_MSR_SPEC_CTRL ( 7*32+16) /* "" MSR SPEC_CTRL is implemented */
+#define X86_FEATURE_SSBD	( 7*32+17) /* Speculative Store Bypass Disable */
 
 /* Because the ALTERNATIVE scheme is for members of the X86_FEATURE club... */
 #define X86_FEATURE_KAISER	( 7*32+31) /* CONFIG_PAGE_TABLE_ISOLATION w/o nokaiser */
@@ -207,7 +208,8 @@
 #define X86_FEATURE_USE_IBPB	( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled*/
 #define X86_FEATURE_USE_IBRS_FW	( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
-#define X86_FEATURE_AMD_SSBD	( 7*32+24) /* "" AMD SSBD implementation */
+#define X86_FEATURE_LS_CFG_SSBD	( 7*32+24) /* "" AMD SSBD implementation */
+
 #define X86_FEATURE_IBRS	( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB	( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP	( 7*32+27) /* Single Thread Indirect Branch Predictors */
@@ -306,7 +308,7 @@
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
-#define X86_FEATURE_SSBD		(18*32+31) /* Speculative Store Bypass Disable */
+#define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* "" Speculative Store Bypass Disable */
 
 /*
  * BUG word(s)
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -535,8 +535,8 @@ static void bsp_init_amd(struct cpuinfo_
 		 * avoid RMW. If that faults, do not enable SSBD.
 		 */
 		if (!rdmsrl_safe(MSR_AMD64_LS_CFG, &x86_amd_ls_cfg_base)) {
+			setup_force_cpu_cap(X86_FEATURE_LS_CFG_SSBD);
 			setup_force_cpu_cap(X86_FEATURE_SSBD);
-			setup_force_cpu_cap(X86_FEATURE_AMD_SSBD);
 			x86_amd_ls_cfg_ssbd_mask = 1ULL << bit;
 		}
 	}
@@ -815,11 +815,6 @@ static void init_amd(struct cpuinfo_x86
 	/* AMD CPUs don't reset SS attributes on SYSRET, Xen does. */
 	if (!cpu_has(c, X86_FEATURE_XENPV))
 		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
-
-	if (boot_cpu_has(X86_FEATURE_AMD_SSBD)) {
-		set_cpu_cap(c, X86_FEATURE_SSBD);
-		set_cpu_cap(c, X86_FEATURE_AMD_SSBD);
-	}
 }
 
 #ifdef CONFIG_X86_32
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -157,8 +157,8 @@ void x86_spec_ctrl_set_guest(u64 guest_s
 	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		return;
 
-	/* Intel controls SSB in MSR_SPEC_CTRL */
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
+	/* SSBD controlled in MSR_SPEC_CTRL */
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
 		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 
 	if (host != guest_spec_ctrl)
@@ -174,8 +174,8 @@ void x86_spec_ctrl_restore_host(u64 gues
 	if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		return;
 
-	/* Intel controls SSB in MSR_SPEC_CTRL */
-	if (static_cpu_has(X86_FEATURE_SPEC_CTRL))
+	/* SSBD controlled in MSR_SPEC_CTRL */
+	if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
 		host |= ssbd_tif_to_spec_ctrl(current_thread_info()->flags);
 
 	if (host != guest_spec_ctrl)
@@ -187,7 +187,7 @@ static void x86_amd_ssb_disable(void)
 {
 	u64 msrval = x86_amd_ls_cfg_base | x86_amd_ls_cfg_ssbd_mask;
 
-	if (boot_cpu_has(X86_FEATURE_AMD_SSBD))
+	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD))
 		wrmsrl(MSR_AMD64_LS_CFG, msrval);
 }
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -693,6 +693,9 @@ static void init_speculation_control(str
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
@@ -121,6 +121,7 @@ static void early_init_intel(struct cpui
 		setup_clear_cpu_cap(X86_FEATURE_MSR_SPEC_CTRL);
 		setup_clear_cpu_cap(X86_FEATURE_INTEL_STIBP);
 		setup_clear_cpu_cap(X86_FEATURE_SSBD);
+		setup_clear_cpu_cap(X86_FEATURE_SPEC_CTRL_SSBD);
 	}
 
 	/*
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -203,7 +203,7 @@ static __always_inline void __speculativ
 {
 	u64 msr;
 
-	if (static_cpu_has(X86_FEATURE_AMD_SSBD)) {
+	if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD)) {
 		msr = x86_amd_ls_cfg_base | ssbd_tif_to_amd_ls_cfg(tifn);
 		wrmsrl(MSR_AMD64_LS_CFG, msr);
 	} else {


