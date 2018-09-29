Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC7DC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420BC20880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 420BC20880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbeI3E0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:26:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51702 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728346AbeI3ES0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:26 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N66-0000H2-4v; Sat, 29 Sep 2018 22:48:22 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006wp-N6; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Guenter Roeck" <linux@roeck-us.net>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "David Woodhouse" <dwmw@amazon.co.uk>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.675668404@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 099/131] x86/speculation/l1tf: Add sysfs reporting
 for l1tf
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

From: Andi Kleen <ak@linux.intel.com>

commit 17dbca119312b4e8173d4e25ff64262119fcef38 upstream.

L1TF core kernel workarounds are cheap and normally always enabled, However
they still should be reported in sysfs if the system is vulnerable or
mitigated. Add the necessary CPU feature/bug bits.

- Extend the existing checks for Meltdowns to determine if the system is
  vulnerable. All CPUs which are not vulnerable to Meltdown are also not
  vulnerable to L1TF

- Check for 32bit non PAE and emit a warning as there is no practical way
  for mitigation due to the limited physical address bits

- If the system has more than MAX_PA/2 physical memory the invert page
  workarounds don't protect the system against the L1TF attack anymore,
  because an inverted physical address will also point to valid
  memory. Print a warning in this case and report that the system is
  vulnerable.

Add a function which returns the PFN limit for the L1TF mitigation, which
will be used in follow up patches for sanity and range checks.

[ tglx: Renamed the CPU feature bit to L1TF_PTEINV ]
[ dwmw2: Backport to 4.9 (cpufeatures.h, E820) ]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - Assign the next available bits from feature word 7 and bug word 0
 - CONFIG_PGTABLE_LEVELS is not defined; use other config symbols in the
   condition
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/cpufeature.h |  3 ++-
 arch/x86/include/asm/processor.h  |  5 ++++
 arch/x86/kernel/cpu/bugs.c        | 40 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/common.c      | 20 +++++++++++++++
 drivers/base/cpu.c                |  8 ++++++
 include/linux/cpu.h               |  2 ++
 6 files changed, 77 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -199,6 +199,7 @@
 #define X86_FEATURE_MSR_SPEC_CTRL (7*32+19) /* "" MSR SPEC_CTRL is implemented */
 #define X86_FEATURE_SSBD	(7*32+20) /* Speculative Store Bypass Disable */
 #define X86_FEATURE_ZEN		(7*32+21) /* "" CPU is AMD family 0x17 (Zen) */
+#define X86_FEATURE_L1TF_PTEINV	(7*32+22) /* "" L1TF workaround PTE inversion */
 
 #define X86_FEATURE_RETPOLINE	(7*32+29) /* "" Generic Retpoline mitigation for Spectre variant 2 */
 #define X86_FEATURE_RETPOLINE_AMD (7*32+30) /* "" AMD Retpoline mitigation for Spectre variant 2 */
@@ -271,6 +272,7 @@
 #define X86_BUG_SPECTRE_V1	X86_BUG(6) /* CPU is affected by Spectre variant 1 attack with conditional branches */
 #define X86_BUG_SPECTRE_V2	X86_BUG(7) /* CPU is affected by Spectre variant 2 attack with indirect branches */
 #define X86_BUG_SPEC_STORE_BYPASS X86_BUG(8) /* CPU is affected by speculative store bypass attack */
+#define X86_BUG_L1TF		X86_BUG(9) /* CPU is affected by L1 Terminal Fault */
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -165,6 +165,11 @@ extern const struct seq_operations cpuin
 extern void cpu_detect(struct cpuinfo_x86 *c);
 extern void fpu_detect(struct cpuinfo_x86 *c);
 
+static inline unsigned long l1tf_pfn_limit(void)
+{
+	return BIT(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT) - 1;
+}
+
 extern void early_cpu_init(void);
 extern void identify_boot_cpu(void);
 extern void identify_secondary_cpu(struct cpuinfo_x86 *);
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -26,9 +26,11 @@
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
 #include <asm/intel-family.h>
+#include <asm/e820.h>
 
 static void __init spectre_v2_select_mitigation(void);
 static void __init ssb_select_mitigation(void);
+static void __init l1tf_select_mitigation(void);
 
 /*
  * Our boot-time value of the SPEC_CTRL MSR. We read it once so that any
@@ -138,6 +140,8 @@ void __init check_bugs(void)
 	 */
 	ssb_select_mitigation();
 
+	l1tf_select_mitigation();
+
 #ifdef CONFIG_X86_32
 	/*
 	 * Check whether we are able to run this kernel safely on SMP.
@@ -266,6 +270,32 @@ static void x86_amd_ssb_disable(void)
 		wrmsrl(MSR_AMD64_LS_CFG, msrval);
 }
 
+static void __init l1tf_select_mitigation(void)
+{
+	u64 half_pa;
+
+	if (!boot_cpu_has_bug(X86_BUG_L1TF))
+		return;
+
+#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
+	pr_warn("Kernel not compiled for PAE. No mitigation for L1TF\n");
+	return;
+#endif
+
+	/*
+	 * This is extremely unlikely to happen because almost all
+	 * systems have far more MAX_PA/2 than RAM can be fit into
+	 * DIMM slots.
+	 */
+	half_pa = (u64)l1tf_pfn_limit() << PAGE_SHIFT;
+	if (e820_any_mapped(half_pa, ULLONG_MAX - half_pa, E820_RAM)) {
+		pr_warn("System has more than MAX_PA/2 memory. L1TF mitigation not effective.\n");
+		return;
+	}
+
+	setup_force_cpu_cap(X86_FEATURE_L1TF_PTEINV);
+}
+
 #ifdef RETPOLINE
 static bool spectre_v2_bad_module;
 
@@ -718,6 +748,11 @@ static ssize_t cpu_show_common(struct de
 	case X86_BUG_SPEC_STORE_BYPASS:
 		return sprintf(buf, "%s\n", ssb_strings[ssb_mode]);
 
+	case X86_BUG_L1TF:
+		if (boot_cpu_has(X86_FEATURE_L1TF_PTEINV))
+			return sprintf(buf, "Mitigation: Page Table Inversion\n");
+		break;
+
 	default:
 		break;
 	}
@@ -744,4 +779,9 @@ ssize_t cpu_show_spec_store_bypass(struc
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_SPEC_STORE_BYPASS);
 }
+
+ssize_t cpu_show_l1tf(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_L1TF);
+}
 #endif
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -842,6 +842,21 @@ static const __initconst struct x86_cpu_
 	{}
 };
 
+static const __initconst struct x86_cpu_id cpu_no_l1tf[] = {
+	/* in addition to cpu_no_speculation */
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT1	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_SILVERMONT2	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_AIRMONT		},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_MERRIFIELD	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_MOOREFIELD	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_GOLDMONT	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_DENVERTON	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_ATOM_GEMINI_LAKE	},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_XEON_PHI_KNL		},
+	{ X86_VENDOR_INTEL,	6,	INTEL_FAM6_XEON_PHI_KNM		},
+	{}
+};
+
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 ia32_cap = 0;
@@ -867,6 +882,11 @@ static void __init cpu_set_bug_bits(stru
 		return;
 
 	setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
+
+	if (x86_match_cpu(cpu_no_l1tf))
+		return;
+
+	setup_force_cpu_bug(X86_BUG_L1TF);
 }
 
 /*
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -444,16 +444,24 @@ ssize_t __weak cpu_show_spec_store_bypas
 	return sprintf(buf, "Not affected\n");
 }
 
+ssize_t __weak cpu_show_l1tf(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Not affected\n");
+}
+
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
 static DEVICE_ATTR(spectre_v2, 0444, cpu_show_spectre_v2, NULL);
 static DEVICE_ATTR(spec_store_bypass, 0444, cpu_show_spec_store_bypass, NULL);
+static DEVICE_ATTR(l1tf, 0444, cpu_show_l1tf, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
 	&dev_attr_spectre_v1.attr,
 	&dev_attr_spectre_v2.attr,
 	&dev_attr_spec_store_bypass.attr,
+	&dev_attr_l1tf.attr,
 	NULL
 };
 
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -47,6 +47,8 @@ extern ssize_t cpu_show_spectre_v2(struc
 				   struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_spec_store_bypass(struct device *dev,
 					  struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_l1tf(struct device *dev,
+			     struct device_attribute *attr, char *buf);
 
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *cpu);

