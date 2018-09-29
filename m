Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BADC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D72C2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D72C2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeI3ESW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:22 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51546 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726670AbeI3ESV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:21 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N60-0000H1-Hj; Sat, 29 Sep 2018 22:48:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006pY-C7; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ingo Molnar" <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Borislav Petkov" <bp@suse.de>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.331723245@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 009/131] x86/bugs/intel: Set proper CPU features and
 setup RDS
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

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 772439717dbf703b39990be58d8d4e3e4ad0598a upstream.

Intel CPUs expose methods to:

 - Detect whether RDS capability is available via CPUID.7.0.EDX[31],

 - The SPEC_CTRL MSR(0x48), bit 2 set to enable RDS.

 - MSR_IA32_ARCH_CAPABILITIES, Bit(4) no need to enable RRS.

With that in mind if spec_store_bypass_disable=[auto,on] is selected set at
boot-time the SPEC_CTRL MSR to enable RDS if the platform requires it.

Note that this does not fix the KVM case where the SPEC_CTRL is exposed to
guests which can muck with it, see patch titled :
 KVM/SVM/VMX/x86/spectre_v2: Support the combination of guest and host IBRS.

And for the firmware (IBRS to be set), see patch titled:
 x86/spectre_v2: Read SPEC_CTRL MSR during boot and re-use reserved bits

[ tglx: Distangled it from the intel implementation and kept the call order ]

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/uapi/asm/msr-index.h |  6 ++++++
 arch/x86/kernel/cpu/bugs.c            | 30 +++++++++++++++++++++++++--
 arch/x86/kernel/cpu/common.c          | 10 +++++----
 arch/x86/kernel/cpu/cpu.h             |  3 +++
 arch/x86/kernel/cpu/intel.c           |  1 +
 5 files changed, 44 insertions(+), 6 deletions(-)

--- a/arch/x86/include/uapi/asm/msr-index.h
+++ b/arch/x86/include/uapi/asm/msr-index.h
@@ -35,6 +35,7 @@
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
+#define SPEC_CTRL_RDS			(1 << 2)   /* Reduced Data Speculation */
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			(1 << 0)   /* Indirect Branch Prediction Barrier */
@@ -57,6 +58,11 @@
 #define MSR_IA32_ARCH_CAPABILITIES	0x0000010a
 #define ARCH_CAP_RDCL_NO		(1 << 0)   /* Not susceptible to Meltdown */
 #define ARCH_CAP_IBRS_ALL		(1 << 1)   /* Enhanced IBRS support */
+#define ARCH_CAP_RDS_NO			(1 << 4)   /*
+						    * Not susceptible to Speculative Store Bypass
+						    * attack, so no Reduced Data Speculation control
+						    * required.
+						    */
 
 #define MSR_IA32_BBL_CR_CTL		0x00000119
 #define MSR_IA32_BBL_CR_CTL3		0x0000011e
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -179,7 +179,7 @@ static enum spectre_v2_mitigation spectr
 
 void x86_spec_ctrl_set(u64 val)
 {
-	if (val & ~SPEC_CTRL_IBRS)
+	if (val & ~(SPEC_CTRL_IBRS | SPEC_CTRL_RDS))
 		WARN_ONCE(1, "SPEC_CTRL MSR value 0x%16llx is unknown.\n", val);
 	else
 		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base | val);
@@ -482,8 +482,28 @@ static enum ssb_mitigation_cmd __init __
 		break;
 	}
 
-	if (mode != SPEC_STORE_BYPASS_NONE)
+	/*
+	 * We have three CPU feature flags that are in play here:
+	 *  - X86_BUG_SPEC_STORE_BYPASS - CPU is susceptible.
+	 *  - X86_FEATURE_RDS - CPU is able to turn off speculative store bypass
+	 *  - X86_FEATURE_SPEC_STORE_BYPASS_DISABLE - engage the mitigation
+	 */
+	if (mode != SPEC_STORE_BYPASS_NONE) {
 		setup_force_cpu_cap(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE);
+		/*
+		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD uses
+		 * a completely different MSR and bit dependent on family.
+		 */
+		switch (boot_cpu_data.x86_vendor) {
+		case X86_VENDOR_INTEL:
+			x86_spec_ctrl_base |= SPEC_CTRL_RDS;
+			x86_spec_ctrl_set(SPEC_CTRL_RDS);
+			break;
+		case X86_VENDOR_AMD:
+			break;
+		}
+	}
+
 	return mode;
 }
 
@@ -497,6 +517,12 @@ static void ssb_select_mitigation()
 
 #undef pr_fmt
 
+void x86_spec_ctrl_setup_ap(void)
+{
+	if (boot_cpu_has(X86_FEATURE_IBRS))
+		x86_spec_ctrl_set(x86_spec_ctrl_base & (SPEC_CTRL_IBRS | SPEC_CTRL_RDS));
+}
+
 #ifdef CONFIG_SYSFS
 
 ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -827,7 +827,11 @@ static void __init cpu_set_bug_bits(stru
 {
 	u64 ia32_cap = 0;
 
-	if (!x86_match_cpu(cpu_no_spec_store_bypass))
+	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
+		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
+
+	if (!x86_match_cpu(cpu_no_spec_store_bypass) &&
+	   !(ia32_cap & ARCH_CAP_RDS_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
 	if (x86_match_cpu(cpu_no_speculation))
@@ -839,9 +843,6 @@ static void __init cpu_set_bug_bits(stru
 	if (x86_match_cpu(cpu_no_meltdown))
 		return;
 
-	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
-		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
-
 	/* Rogue Data Cache Load? No! */
 	if (ia32_cap & ARCH_CAP_RDCL_NO)
 		return;
@@ -1175,6 +1176,7 @@ void identify_secondary_cpu(struct cpuin
 	enable_sep_cpu();
 #endif
 	mtrr_ap_init();
+	x86_spec_ctrl_setup_ap();
 }
 
 struct msr_range {
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -45,4 +45,7 @@ extern const struct cpu_dev *const __x86
 
 extern void get_cpu_cap(struct cpuinfo_x86 *c);
 extern void cpu_detect_cache_sizes(struct cpuinfo_x86 *c);
+ 
+extern void x86_spec_ctrl_setup_ap(void);
+
 #endif /* ARCH_X86_CPU_H */
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -120,6 +120,7 @@ static void early_init_intel(struct cpui
 		setup_clear_cpu_cap(X86_FEATURE_STIBP);
 		setup_clear_cpu_cap(X86_FEATURE_SPEC_CTRL);
 		setup_clear_cpu_cap(X86_FEATURE_INTEL_STIBP);
+		setup_clear_cpu_cap(X86_FEATURE_RDS);
 	}
 
 	/*

