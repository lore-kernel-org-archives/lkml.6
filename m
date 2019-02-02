Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD4EC282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 05:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0312086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 05:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfBBFVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 00:21:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:23419 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfBBFVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 00:21:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Feb 2019 21:21:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,551,1539673200"; 
   d="scan'208";a="271934500"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga004.jf.intel.com with ESMTP; 01 Feb 2019 21:21:20 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Michael Chan" <michael.chan@broadcom.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Ricardo Neri" <ricardo.neri@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 08/10] x86/setcpuid: Add kernel option setcpuid
Date:   Fri,  1 Feb 2019 21:14:49 -0800
Message-Id: <1549084491-57808-9-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
References: <1549084491-57808-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms, a feature (e.g. #AC for split lock) may not be
enumerated by CPUID or non architectural way in IA32_CORE_CAPABILITY.
To enable the feature on the platforms, a new kernel option setcpuid
is added.

The feature is defined in cpufeatures.h. The kernel option setcpuid
takes either feature bit or cpu cap flag corresponding to the feature.
The format of the option:
setcpuid=<feature bit>
setcpuid=<feature capability flag>

Check cpufeatures.h for valid feature bit numbers and check capflags.c
or /proc/cpuinfo for valid feature capability flags.

Enabling multiple features are supported.

Please note kernel may malfunction if some features are enabled by
the option.

This option behaves like existing kernel option clearcpuid.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 15 +++++++++
 arch/x86/include/asm/cpufeature.h               |  1 +
 arch/x86/kernel/cpu/cpuid-deps.c                | 42 +++++++++++++++++++------
 arch/x86/kernel/fpu/init.c                      |  4 +++
 4 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 13bf223c7739..5de364078c69 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4083,6 +4083,21 @@
 			incurs a small amount of overhead in the scheduler
 			but is useful for debugging and performance tuning.
 
+	setcpuid=BITNUM | FLAG [X86]
+			Enable CPUID feature X for the kernel. See
+			arch/x86/include/asm/cpufeatures.h for the valid bit
+			numbers or /proc/cpuinfo for the valid CPU flags.
+			Multiple options can be used to enable a few features.
+			Note the Linux specific bits are not necessarily
+			stable over kernel options, but the vendor specific
+			ones should be.
+			Also note that user programs calling CPUID directly
+			or using the feature without checking anything
+			may still disable it.
+			Also note the kernel might malfunction if you enable
+			some critical bits.
+			Please refer to clearcpuid for disabling CPUID feature.
+
 	skew_tick=	[KNL] Offset the periodic timer tick per cpu to mitigate
 			xtime_lock contention on larger systems, and/or RCU lock
 			contention on all systems with CONFIG_MAXSMP set.
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 6792088525e3..6b580687f261 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -131,6 +131,7 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 #define set_cpu_cap(c, bit)	set_bit(bit, (unsigned long *)((c)->x86_capability))
 
 extern void setup_clear_cpu_cap(unsigned int bit);
+void setup_set_cpu_cap(unsigned int bit);
 extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 bool find_cpu_cap(char *cap_flag, unsigned int *pfeature);
 
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 19bfab0858ac..ae534b5d0b4d 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -62,25 +62,39 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{}
 };
 
-static inline void clear_feature(struct cpuinfo_x86 *c, unsigned int feature)
+static inline void
+setup_feature(struct cpuinfo_x86 *c, unsigned int feature, bool enable)
 {
 	/*
 	 * Note: This could use the non atomic __*_bit() variants, but the
 	 * rest of the cpufeature code uses atomics as well, so keep it for
 	 * consistency. Cleanup all of it separately.
 	 */
-	if (!c) {
-		clear_cpu_cap(&boot_cpu_data, feature);
-		set_bit(feature, (unsigned long *)cpu_caps_cleared);
+	if (enable) {
+		/* Set the feature */
+		if (!c) {
+			set_cpu_cap(&boot_cpu_data, feature);
+			clear_bit(feature, (unsigned long *)cpu_caps_cleared);
+			setup_force_cpu_cap(feature);
+		} else {
+			set_bit(feature, (unsigned long *)c->x86_capability);
+		}
 	} else {
-		clear_bit(feature, (unsigned long *)c->x86_capability);
+		/* Clear the feature */
+		if (!c) {
+			clear_cpu_cap(&boot_cpu_data, feature);
+			set_bit(feature, (unsigned long *)cpu_caps_cleared);
+		} else {
+			clear_bit(feature, (unsigned long *)c->x86_capability);
+		}
 	}
 }
 
 /* Take the capabilities and the BUG bits into account */
 #define MAX_FEATURE_BITS ((NCAPINTS + NBUGINTS) * sizeof(u32) * 8)
 
-static void do_clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int feature)
+static void
+do_setup_cpu_cap(struct cpuinfo_x86 *c, unsigned int feature, bool enable)
 {
 	DECLARE_BITMAP(disable, MAX_FEATURE_BITS);
 	const struct cpuid_dep *d;
@@ -89,7 +103,7 @@ static void do_clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int feature)
 	if (WARN_ON(feature >= MAX_FEATURE_BITS))
 		return;
 
-	clear_feature(c, feature);
+	setup_feature(c, feature, enable);
 
 	/* Collect all features to disable, handling dependencies */
 	memset(disable, 0, sizeof(disable));
@@ -105,19 +119,27 @@ static void do_clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int feature)
 				continue;
 
 			changed = true;
-			clear_feature(c, d->feature);
+			setup_feature(c, d->feature, enable);
 		}
 	} while (changed);
 }
 
 void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int feature)
 {
-	do_clear_cpu_cap(c, feature);
+	/* Disable the feature. */
+	do_setup_cpu_cap(c, feature, false);
 }
 
 void setup_clear_cpu_cap(unsigned int feature)
 {
-	do_clear_cpu_cap(NULL, feature);
+	/* Disable the feature. */
+	do_setup_cpu_cap(NULL, feature, false);
+}
+
+void setup_set_cpu_cap(unsigned int feature)
+{
+	/* Enable the feature. */
+	do_setup_cpu_cap(NULL, feature, true);
 }
 
 /**
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index a9a67645a607..cb1e2f8129a5 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -251,6 +251,9 @@ static void __init setup_cpuid_option(char *setup_cpuid_option)
 
 	if (!strcmp(setup_cpuid_option, "clearcpuid"))
 		setup_cpu_cap = setup_clear_cpu_cap;
+	else if (!strcmp(setup_cpuid_option, "setcpuid"))
+		setup_cpu_cap = setup_set_cpu_cap;
+	else
 		return;
 
 	/* Find each option in boot_command_line and clear specified cpu cap. */
@@ -293,6 +296,7 @@ static void __init fpu__init_parse_early_param(void)
 		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
 
 	setup_cpuid_option("clearcpuid");
+	setup_cpuid_option("setcpuid");
 }
 
 /*
-- 
2.7.4

