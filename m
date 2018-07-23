Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EA5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DE020685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DE020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389259AbeGWNrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:47:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51134 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388511AbeGWNrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:47:42 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 607B4CAF;
        Mon, 23 Jul 2018 12:45:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 058/107] x86/bugs/intel: Set proper CPU features and setup RDS
Date:   Mon, 23 Jul 2018 14:41:52 +0200
Message-Id: <20180723122415.894335213@linuxfoundation.org>
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

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 772439717dbf703b39990be58d8d4e3e4ad0598a upstream

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/msr-index.h |    6 ++++++
 arch/x86/kernel/cpu/bugs.c       |   30 ++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/common.c     |   10 ++++++----
 arch/x86/kernel/cpu/cpu.h        |    3 +++
 arch/x86/kernel/cpu/intel.c      |    1 +
 5 files changed, 44 insertions(+), 6 deletions(-)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -35,6 +35,7 @@
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
+#define SPEC_CTRL_RDS			(1 << 2)   /* Reduced Data Speculation */
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			(1 << 0)   /* Indirect Branch Prediction Barrier */
@@ -56,6 +57,11 @@
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
@@ -116,7 +116,7 @@ static enum spectre_v2_mitigation spectr
 
 void x86_spec_ctrl_set(u64 val)
 {
-	if (val & ~SPEC_CTRL_IBRS)
+	if (val & ~(SPEC_CTRL_IBRS | SPEC_CTRL_RDS))
 		WARN_ONCE(1, "SPEC_CTRL MSR value 0x%16llx is unknown.\n", val);
 	else
 		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base | val);
@@ -443,8 +443,28 @@ static enum ssb_mitigation_cmd __init __
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
 
@@ -458,6 +478,12 @@ static void ssb_select_mitigation()
 
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
@@ -859,7 +859,11 @@ static void __init cpu_set_bug_bits(stru
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
@@ -871,9 +875,6 @@ static void __init cpu_set_bug_bits(stru
 	if (x86_match_cpu(cpu_no_meltdown))
 		return;
 
-	if (cpu_has(c, X86_FEATURE_ARCH_CAPABILITIES))
-		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
-
 	/* Rogue Data Cache Load? No! */
 	if (ia32_cap & ARCH_CAP_RDCL_NO)
 		return;
@@ -1216,6 +1217,7 @@ void identify_secondary_cpu(struct cpuin
 	enable_sep_cpu();
 #endif
 	mtrr_ap_init();
+	x86_spec_ctrl_setup_ap();
 }
 
 struct msr_range {
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -46,4 +46,7 @@ extern const struct cpu_dev *const __x86
 
 extern void get_cpu_cap(struct cpuinfo_x86 *c);
 extern void cpu_detect_cache_sizes(struct cpuinfo_x86 *c);
+
+extern void x86_spec_ctrl_setup_ap(void);
+
 #endif /* ARCH_X86_CPU_H */
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -119,6 +119,7 @@ static void early_init_intel(struct cpui
 		setup_clear_cpu_cap(X86_FEATURE_STIBP);
 		setup_clear_cpu_cap(X86_FEATURE_SPEC_CTRL);
 		setup_clear_cpu_cap(X86_FEATURE_INTEL_STIBP);
+		setup_clear_cpu_cap(X86_FEATURE_RDS);
 	}
 
 	/*


