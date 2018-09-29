Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7FCC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A512087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A512087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeI3EVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:21:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52035 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728762AbeI3ESf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:35 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6E-0000HA-TR; Sat, 29 Sep 2018 22:48:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5w-0006rz-Dd; Sat, 29 Sep 2018 22:48:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David Woodhouse" <dwmw@amazon.co.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Borislav Petkov" <bp@suse.de>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.261794817@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 039/131] x86/speculation: Add virtualized speculative
 store bypass disable support
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

From: Tom Lendacky <thomas.lendacky@amd.com>

commit 11fb0683493b2da112cd64c9dada221b52463bf7 upstream.

Some AMD processors only support a non-architectural means of enabling
speculative store bypass disable (SSBD).  To allow a simplified view of
this to a guest, an architectural definition has been created through a new
CPUID bit, 0x80000008_EBX[25], and a new MSR, 0xc001011f.  With this, a
hypervisor can virtualize the existence of this definition and provide an
architectural method for using SSBD to a guest.

Add the new CPUID feature, the new MSR and update the existing SSBD
support to use this MSR when present.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - This CPUID word is feature word 11
 - Adjust filenames, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/cpufeature.h     |  1 +
 arch/x86/include/uapi/asm/msr-index.h |  2 ++
 arch/x86/kernel/cpu/bugs.c            |  4 +++-
 arch/x86/kernel/process.c             | 13 ++++++++++++-
 4 files changed, 18 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -255,6 +255,7 @@
 #define X86_FEATURE_AMD_IBPB		(11*32+12) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS		(11*32+14) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP		(11*32+15) /* Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_VIRT_SSBD		(11*32+25) /* Virtualized Speculative Store Bypass Disable */
 
 /*
  * BUG word(s)
--- a/arch/x86/include/uapi/asm/msr-index.h
+++ b/arch/x86/include/uapi/asm/msr-index.h
@@ -225,6 +225,8 @@
 #define MSR_AMD64_IBSBRTARGET		0xc001103b
 #define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
 
+#define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
+
 /* Fam 16h MSRs */
 #define MSR_F16H_L2I_PERF_CTL		0xc0010230
 #define MSR_F16H_L2I_PERF_CTR		0xc0010231
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -266,7 +266,9 @@ static void x86_amd_ssb_disable(void)
 {
 	u64 msrval = x86_amd_ls_cfg_base | x86_amd_ls_cfg_ssbd_mask;
 
-	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD))
+	if (boot_cpu_has(X86_FEATURE_VIRT_SSBD))
+		wrmsrl(MSR_AMD64_VIRT_SPEC_CTRL, SPEC_CTRL_SSBD);
+	else if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD))
 		wrmsrl(MSR_AMD64_LS_CFG, msrval);
 }
 
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -326,6 +326,15 @@ static __always_inline void amd_set_core
 }
 #endif
 
+static __always_inline void amd_set_ssb_virt_state(unsigned long tifn)
+{
+	/*
+	 * SSBD has the same definition in SPEC_CTRL and VIRT_SPEC_CTRL,
+	 * so ssbd_tif_to_spec_ctrl() just works.
+	 */
+	wrmsrl(MSR_AMD64_VIRT_SPEC_CTRL, ssbd_tif_to_spec_ctrl(tifn));
+}
+
 static __always_inline void intel_set_ssb_state(unsigned long tifn)
 {
 	u64 msr = x86_spec_ctrl_base | ssbd_tif_to_spec_ctrl(tifn);
@@ -335,7 +344,9 @@ static __always_inline void intel_set_ss
 
 static __always_inline void __speculative_store_bypass_update(unsigned long tifn)
 {
-	if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
+	if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
+		amd_set_ssb_virt_state(tifn);
+	else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
 		amd_set_core_ssb_state(tifn);
 	else
 		intel_set_ssb_state(tifn);

