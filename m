Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeDXT5p (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:57:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:56865 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbeDXT5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:57:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,324,1520924400";
   d="scan'208";a="36729881"
From: kan.liang@linux.intel.com
To: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc: acme@redhat.com, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Don't enable freeze-on-smi for PerfMon V1
Date: Tue, 24 Apr 2018 15:56:23 -0400
Message-Id: <1524599783-62181-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The SMM freeze feature was introduced since PerfMon V2. But the current
code unconditionally enables the feature for all platforms. It can
generate #GP exception, if the related FREEZE_WHILE_SMM bit is set for
the machine with PerfMon V1.

Checking the PerfMon version. Only enable the feature for PerfMon V2 and
later.

Fixes: 6089327f5424 ("perf/x86: Add sysfs entry to freeze counters on SMI")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4f2a5c7..08be8ed 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3346,7 +3346,8 @@ static void intel_pmu_cpu_starting(int cpu)
 
 	cpuc->lbr_sel = NULL;
 
-	flip_smm_bit(&x86_pmu.attr_freeze_on_smi);
+	if (x86_pmu.version > 1)
+		flip_smm_bit(&x86_pmu.attr_freeze_on_smi);
 
 	if (!cpuc->shared_regs)
 		return;
@@ -3509,6 +3510,8 @@ static __initconst const struct x86_pmu core_pmu = {
 	.cpu_dying		= intel_pmu_cpu_dying,
 };
 
+static struct attribute *intel_pmu_attrs[];
+
 static __initconst const struct x86_pmu intel_pmu = {
 	.name			= "Intel",
 	.handle_irq		= intel_pmu_handle_irq,
@@ -3540,6 +3543,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.format_attrs		= intel_arch3_formats_attr,
 	.events_sysfs_show	= intel_event_sysfs_show,
 
+	.attrs			= intel_pmu_attrs,
+
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
@@ -3918,8 +3923,6 @@ __init int intel_pmu_init(void)
 
 	x86_pmu.max_pebs_events		= min_t(unsigned, MAX_PEBS_EVENTS, x86_pmu.num_counters);
 
-
-	x86_pmu.attrs			= intel_pmu_attrs;
 	/*
 	 * Quirk: v2 perfmon does not report fixed-purpose events, so
 	 * assume at least 3 events, when not running in a hypervisor:
-- 
2.4.11
