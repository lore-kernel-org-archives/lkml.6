Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeCFXwY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 18:52:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:26344 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754144AbeCFXwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 18:52:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,433,1515484800";
   d="scan'208";a="22497538"
From: Rajvi Jingar <rajvi.jingar@intel.com>
To: rajvi.jingar@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, christopher.s.hall@intel.com
Subject: [PATCH v2] x86/tsc: Convert ART in nanoseconds to TSC.
Date: Tue,  6 Mar 2018 08:47:29 -0800
Message-Id: <1520354849-32593-1-git-send-email-rajvi.jingar@intel.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device drivers use get_device_system_crosststamp() to produce precise
system/device cross-timestamps. The PHC clock and ALSA interfaces,
for example, make the cross-timestamps available to user applications.
On Intel platforms, get_device_system_crosststamp() requires a TSC
value derived from ART (Always Running Timer) to compute the monotonic
 raw and realtime system timestamps.

Starting with Intel Goldmont platforms, the PCIe root complex supports
the PTM time sync protocol. PTM requires all timestamps to be in units
of nanoseconds. The Intel root complex hardware propagates system time –
derived from ART - in units of nanoseconds performing the conversion
as follows:

ART_NS = ART * 1e9 / <crystal frequency>

When user software requests a cross-timestamp, the system timestamps
(generally read from device registers) must be converted to TSC by
the driver software as follows:

TSC = ART_NS * TSC_KHZ / 1e6

This is valid when CPU feature flag X86_FEATURE_TSC_KNOWN_FREQ is set
indicating the tsc_khz is derived from CPUID[15H]. Drivers should
check that this flag is set before conversion to TSC is attempted.

Changes from v1:

* use existing frequency hardcode for platforms where CPUID[15H].ECX == 0
(v1 added redundant hardcode just for the ART.ns conversion)

* use tsc_khz for TSC conversion, also requires driver to check
X86_FEATURE_TSC_KNOWN_FREQ (v1 used CPUID[15H].ECX value directly)

Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
Suggested-by: Christopher S. Hall <christopher.s.hall@intel.com>
---
 arch/x86/include/asm/tsc.h |  1 +
 arch/x86/kernel/tsc.c      | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

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
index fb43027..f07f3bd 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1179,6 +1179,24 @@ struct system_counterval_t convert_art_to_tsc(u64 art)
 }
 EXPORT_SYMBOL(convert_art_to_tsc);
 
+struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
+{
+	u64 tmp, res, rem;
+
+	rem = do_div(art_ns, USEC_PER_SEC);
+
+	res = art_ns * tsc_khz;
+	tmp = rem * tsc_khz;
+
+	do_div(tmp, USEC_PER_SEC);
+	res += tmp;
+
+	return (struct system_counterval_t) {.cs = art_related_clocksource,
+			.cycles = res};
+}
+EXPORT_SYMBOL(convert_art_ns_to_tsc);
+
+
 static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**
-- 
2.7.4
