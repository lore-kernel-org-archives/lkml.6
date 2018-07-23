Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AD0ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819A020880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819A020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388795AbeGWNvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:51:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51698 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388217AbeGWNsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:04 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1E300C94;
        Mon, 23 Jul 2018 12:46:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 090/107] x86/speculation: Add virtualized speculative store bypass disable support
Date:   Mon, 23 Jul 2018 14:42:24 +0200
Message-Id: <20180723122418.000920675@linuxfoundation.org>
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

From: Tom Lendacky <thomas.lendacky@amd.com>

commit 11fb0683493b2da112cd64c9dada221b52463bf7 upstream

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
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/cpufeatures.h |    1 +
 arch/x86/include/asm/msr-index.h   |    2 ++
 arch/x86/kernel/cpu/bugs.c         |    4 +++-
 arch/x86/kernel/process.c          |   13 ++++++++++++-
 4 files changed, 18 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -269,6 +269,7 @@
 #define X86_FEATURE_AMD_IBPB	(13*32+12) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS	(13*32+14) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_AMD_STIBP	(13*32+15) /* Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_VIRT_SSBD	(13*32+25) /* Virtualized Speculative Store Bypass Disable */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (eax), word 14 */
 #define X86_FEATURE_DTHERM	(14*32+ 0) /* Digital Thermal Sensor */
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -328,6 +328,8 @@
 #define MSR_AMD64_IBSOPDATA4		0xc001103d
 #define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
 
+#define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
+
 /* Fam 16h MSRs */
 #define MSR_F16H_L2I_PERF_CTL		0xc0010230
 #define MSR_F16H_L2I_PERF_CTR		0xc0010231
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -203,7 +203,9 @@ static void x86_amd_ssb_disable(void)
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
@@ -308,6 +308,15 @@ static __always_inline void amd_set_core
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
@@ -317,7 +326,9 @@ static __always_inline void intel_set_ss
 
 static __always_inline void __speculative_store_bypass_update(unsigned long tifn)
 {
-	if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
+	if (static_cpu_has(X86_FEATURE_VIRT_SSBD))
+		amd_set_ssb_virt_state(tifn);
+	else if (static_cpu_has(X86_FEATURE_LS_CFG_SSBD))
 		amd_set_core_ssb_state(tifn);
 	else
 		intel_set_ssb_state(tifn);


