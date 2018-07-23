Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A261ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D7B20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D7B20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389307AbeGWNrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:47:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388246AbeGWNro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:47:44 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B85FCCB0;
        Mon, 23 Jul 2018 12:45:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 060/107] x86/bugs/AMD: Add support to disable RDS on Fam[15, 16, 17]h if requested
Date:   Mon, 23 Jul 2018 14:41:54 +0200
Message-Id: <20180723122416.047823258@linuxfoundation.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

commit 764f3c21588a059cd783c6ba0734d4db2d72822d upstream

AMD does not need the Speculative Store Bypass mitigation to be enabled.

The parameters for this are already available and can be done via MSR
C001_1020. Each family uses a different bit in that MSR for this.

[ tglx: Expose the bit mask via a variable and move the actual MSR fiddling
  	into the bugs code as that's the right thing to do and also required
	to prepare for dynamic enable/disable ]

[ Srivatsa: Removed __ro_after_init for 4.4.y ]

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/cpufeatures.h   |    1 +
 arch/x86/include/asm/nospec-branch.h |    4 ++++
 arch/x86/kernel/cpu/amd.c            |   26 ++++++++++++++++++++++++++
 arch/x86/kernel/cpu/bugs.c           |   27 ++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/common.c         |    4 ++++
 5 files changed, 61 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -204,6 +204,7 @@
 #define X86_FEATURE_USE_IBPB	( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled*/
 #define X86_FEATURE_USE_IBRS_FW	( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
+#define X86_FEATURE_AMD_RDS	(7*32+24)  /* "" AMD RDS implementation */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW  ( 8*32+ 0) /* Intel TPR Shadow */
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -199,6 +199,10 @@ enum ssb_mitigation {
 	SPEC_STORE_BYPASS_DISABLE,
 };
 
+/* AMD specific Speculative Store Bypass MSR data */
+extern u64 x86_amd_ls_cfg_base;
+extern u64 x86_amd_ls_cfg_rds_mask;
+
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -9,6 +9,7 @@
 #include <asm/processor.h>
 #include <asm/apic.h>
 #include <asm/cpu.h>
+#include <asm/nospec-branch.h>
 #include <asm/smp.h>
 #include <asm/pci-direct.h>
 #include <asm/delay.h>
@@ -519,6 +520,26 @@ static void bsp_init_amd(struct cpuinfo_
 
 	if (cpu_has(c, X86_FEATURE_MWAITX))
 		use_mwaitx_delay();
+
+	if (c->x86 >= 0x15 && c->x86 <= 0x17) {
+		unsigned int bit;
+
+		switch (c->x86) {
+		case 0x15: bit = 54; break;
+		case 0x16: bit = 33; break;
+		case 0x17: bit = 10; break;
+		default: return;
+		}
+		/*
+		 * Try to cache the base value so further operations can
+		 * avoid RMW. If that faults, do not enable RDS.
+		 */
+		if (!rdmsrl_safe(MSR_AMD64_LS_CFG, &x86_amd_ls_cfg_base)) {
+			setup_force_cpu_cap(X86_FEATURE_RDS);
+			setup_force_cpu_cap(X86_FEATURE_AMD_RDS);
+			x86_amd_ls_cfg_rds_mask = 1ULL << bit;
+		}
+	}
 }
 
 static void early_init_amd(struct cpuinfo_x86 *c)
@@ -794,6 +815,11 @@ static void init_amd(struct cpuinfo_x86
 	/* AMD CPUs don't reset SS attributes on SYSRET, Xen does. */
 	if (!cpu_has(c, X86_FEATURE_XENPV))
 		set_cpu_bug(c, X86_BUG_SYSRET_SS_ATTRS);
+
+	if (boot_cpu_has(X86_FEATURE_AMD_RDS)) {
+		set_cpu_cap(c, X86_FEATURE_RDS);
+		set_cpu_cap(c, X86_FEATURE_AMD_RDS);
+	}
 }
 
 #ifdef CONFIG_X86_32
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -40,6 +40,13 @@ static u64 x86_spec_ctrl_base;
  */
 static u64 x86_spec_ctrl_mask = ~SPEC_CTRL_IBRS;
 
+/*
+ * AMD specific MSR info for Speculative Store Bypass control.
+ * x86_amd_ls_cfg_rds_mask is initialized in identify_boot_cpu().
+ */
+u64 x86_amd_ls_cfg_base;
+u64 x86_amd_ls_cfg_rds_mask;
+
 void __init check_bugs(void)
 {
 	identify_boot_cpu();
@@ -51,7 +58,8 @@ void __init check_bugs(void)
 
 	/*
 	 * Read the SPEC_CTRL MSR to account for reserved bits which may
-	 * have unknown values.
+	 * have unknown values. AMD64_LS_CFG MSR is cached in the early AMD
+	 * init code as it is not enumerated and depends on the family.
 	 */
 	if (boot_cpu_has(X86_FEATURE_IBRS))
 		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
@@ -153,6 +161,14 @@ void x86_spec_ctrl_restore_host(u64 gues
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_restore_host);
 
+static void x86_amd_rds_enable(void)
+{
+	u64 msrval = x86_amd_ls_cfg_base | x86_amd_ls_cfg_rds_mask;
+
+	if (boot_cpu_has(X86_FEATURE_AMD_RDS))
+		wrmsrl(MSR_AMD64_LS_CFG, msrval);
+}
+
 #ifdef RETPOLINE
 static bool spectre_v2_bad_module;
 
@@ -442,6 +458,11 @@ static enum ssb_mitigation_cmd __init __
 
 	switch (cmd) {
 	case SPEC_STORE_BYPASS_CMD_AUTO:
+		/*
+		 * AMD platforms by default don't need SSB mitigation.
+		 */
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+			break;
 	case SPEC_STORE_BYPASS_CMD_ON:
 		mode = SPEC_STORE_BYPASS_DISABLE;
 		break;
@@ -468,6 +489,7 @@ static enum ssb_mitigation_cmd __init __
 			x86_spec_ctrl_set(SPEC_CTRL_RDS);
 			break;
 		case X86_VENDOR_AMD:
+			x86_amd_rds_enable();
 			break;
 		}
 	}
@@ -489,6 +511,9 @@ void x86_spec_ctrl_setup_ap(void)
 {
 	if (boot_cpu_has(X86_FEATURE_IBRS))
 		x86_spec_ctrl_set(x86_spec_ctrl_base & ~x86_spec_ctrl_mask);
+
+	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
+		x86_amd_rds_enable();
 }
 
 #ifdef CONFIG_SYSFS
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -851,6 +851,10 @@ static const __initconst struct x86_cpu_
 	{ X86_VENDOR_CENTAUR,	5,					},
 	{ X86_VENDOR_INTEL,	5,					},
 	{ X86_VENDOR_NSC,	5,					},
+	{ X86_VENDOR_AMD,	0x12,					},
+	{ X86_VENDOR_AMD,	0x11,					},
+	{ X86_VENDOR_AMD,	0x10,					},
+	{ X86_VENDOR_AMD,	0xf,					},
 	{ X86_VENDOR_ANY,	4,					},
 	{}
 };


