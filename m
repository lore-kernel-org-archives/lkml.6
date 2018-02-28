Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934843AbeB1U60 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 15:58:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:65339 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934698AbeB1U6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 15:58:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="scan'208";a="24042539"
From: Rajvi Jingar <rajvi.jingar@intel.com>
To: rajvi.jingar@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, christopher.s.hall@intel.com
Subject: [PATCH] x86/tsc: Always Running Timer (ART) nanoseconds clocksource
Date: Wed, 28 Feb 2018 03:54:45 -0800
Message-Id: <1519818885-5480-1-git-send-email-rajvi.jingar@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some clock distribution mechanisms (e.g. PCIe-PTM) require time to be
distributed in units of nanoseconds. In order to cross-timestamp local
device time across domains the local device timestamp needs to be
correlated with TSC.

On systems that support ART, a CPUID leaf (0x15) returns parameter
Nominal Core Crystal Clock Frequency such that:

ART_value (in ticks) = (cryst_freq * ART.ns) / 1e9

Add a special case for Goldmont-based platform (which returns cryst_freq 0)
to manually set the frequency to 19.2MHz.

Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/include/asm/tsc.h         |  1 +
 arch/x86/kernel/tsc.c              | 35 +++++++++++++++++++++++++++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 0dfe4d3..32d295c 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -108,6 +108,7 @@
 #define X86_FEATURE_EXTD_APICID		( 3*32+26) /* Extended APICID (8 bits) */
 #define X86_FEATURE_AMD_DCM		( 3*32+27) /* AMD multi-node processor */
 #define X86_FEATURE_APERFMPERF		( 3*32+28) /* P-State hardware coordination feedback capability (APERF/MPERF MSRs) */
+#define X86_FEATURE_ART_NS		( 3*32+29) /* Always running timer (ART) in nanoseconds */
 #define X86_FEATURE_NONSTOP_TSC_S3	( 3*32+30) /* TSC doesn't stop in S3 state */
 #define X86_FEATURE_TSC_KNOWN_FREQ	( 3*32+31) /* TSC has known frequency */
 
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index cf5d53c..2701d22 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -31,6 +31,7 @@ static inline cycles_t get_cycles(void)
 }
 
 extern struct system_counterval_t convert_art_to_tsc(u64 art);
+extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
 
 extern void tsc_early_delay_calibrate(void);
 extern void tsc_init(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index fb43027..7b57751 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -49,6 +49,7 @@ int tsc_clocksource_reliable;
 
 static u32 art_to_tsc_numerator;
 static u32 art_to_tsc_denominator;
+static u32 art_to_tsc_hz;
 static u64 art_to_tsc_offset;
 struct clocksource *art_related_clocksource;
 
@@ -976,7 +977,7 @@ core_initcall(cpufreq_register_tsc_scaling);
  */
 static void __init detect_art(void)
 {
-	unsigned int unused[2];
+	unsigned int unused;
 
 	if (boot_cpu_data.cpuid_level < ART_CPUID_LEAF)
 		return;
@@ -992,7 +993,7 @@ static void __init detect_art(void)
 		return;
 
 	cpuid(ART_CPUID_LEAF, &art_to_tsc_denominator,
-	      &art_to_tsc_numerator, unused, unused+1);
+	      &art_to_tsc_numerator, &art_to_tsc_hz, &unused);
 
 	if (art_to_tsc_denominator < ART_MIN_DENOMINATOR)
 		return;
@@ -1001,6 +1002,15 @@ static void __init detect_art(void)
 
 	/* Make this sticky over multiple CPU init calls */
 	setup_force_cpu_cap(X86_FEATURE_ART);
+
+	if (art_to_tsc_hz == 0) {
+		if (boot_cpu_data.x86_model == INTEL_FAM6_ATOM_GOLDMONT)
+			art_to_tsc_hz = 19200000;
+		else
+			return;
+	}
+
+	setup_force_cpu_cap(X86_FEATURE_ART_NS);
 }
 
 
@@ -1179,6 +1189,27 @@ struct system_counterval_t convert_art_to_tsc(u64 art)
 }
 EXPORT_SYMBOL(convert_art_to_tsc);
 
+#define ART_NS_QUANTITY	1000000000
+
+/*
+ * Convert ART ns to TSC given numerator/denominator found in detect_art()
+ */
+struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
+{
+	u64 tmp, rem, res, art;
+
+	rem = do_div(art_ns, ART_NS_QUANTITY);
+
+	res = art_ns * art_to_tsc_hz;
+	tmp = rem * art_to_tsc_hz;
+
+	do_div(tmp, ART_NS_QUANTITY);
+	art = res + tmp;
+
+	return convert_art_to_tsc(art);
+}
+EXPORT_SYMBOL(convert_art_ns_to_tsc);
+
 static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**
-- 
2.7.4
