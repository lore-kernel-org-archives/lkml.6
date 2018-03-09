Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751008AbeCICQs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:16:48 -0500
Received: from mga02.intel.com ([134.134.136.20]:11779 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750918AbeCICQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:16:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,443,1515484800";
   d="scan'208";a="23704410"
From: kan.liang@linux.intel.com
To: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com,
        vincent.weaver@maine.edu, jolsa@redhat.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/4] x86/perf/intel: Support PEBS on fixed counters
Date: Thu,  8 Mar 2018 18:15:40 -0800
Message-Id: <20180309021542.11374-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180309021542.11374-1-kan.liang@linux.intel.com>
References: <20180309021542.11374-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The Extended PEBS feature supports PEBS on fixed-function performance
counters as well as all four general purpose counters.

It has to change the order of PEBS and fixed counter enabling to make
sure PEBS is enabled for the fixed counters.
The change of the order doesn't impact the behavior of current code on
other platforms which don't support extended PEBS.
Because there is no dependency among those enable/disable functions.

Don't enable IRQ generation (0x8) for MSR_ARCH_PERFMON_FIXED_CTR_CTRL.
The PEBS ucode will handle the interrupt generation.

Based-on-code-from: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a6a70ba5da85..ef47a418d819 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2041,15 +2041,15 @@ static void intel_pmu_disable_event(struct perf_event *event)
 	cpuc->intel_ctrl_host_mask &= ~(1ull << hwc->idx);
 	cpuc->intel_cp_status &= ~(1ull << hwc->idx);
 
+	if (unlikely(event->attr.precise_ip))
+		intel_pmu_pebs_disable(event);
+
 	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
 		intel_pmu_disable_fixed(hwc);
 		return;
 	}
 
 	x86_pmu_disable_event(event);
-
-	if (unlikely(event->attr.precise_ip))
-		intel_pmu_pebs_disable(event);
 }
 
 static void intel_pmu_del_event(struct perf_event *event)
@@ -2068,17 +2068,21 @@ static void intel_pmu_read_event(struct perf_event *event)
 		x86_perf_event_update(event);
 }
 
-static void intel_pmu_enable_fixed(struct hw_perf_event *hwc)
+static void intel_pmu_enable_fixed(struct perf_event *event)
 {
+	struct hw_perf_event *hwc = &event->hw;
 	int idx = hwc->idx - INTEL_PMC_IDX_FIXED;
 	u64 ctrl_val, bits, mask;
 
 	/*
-	 * Enable IRQ generation (0x8),
+	 * Enable IRQ generation (0x8), if not PEBS,
 	 * and enable ring-3 counting (0x2) and ring-0 counting (0x1)
 	 * if requested:
 	 */
-	bits = 0x8ULL;
+	if (event->attr.precise_ip)
+		bits = 0;
+	else
+		bits = 0x8ULL;
 	if (hwc->config & ARCH_PERFMON_EVENTSEL_USR)
 		bits |= 0x2;
 	if (hwc->config & ARCH_PERFMON_EVENTSEL_OS)
@@ -2120,14 +2124,14 @@ static void intel_pmu_enable_event(struct perf_event *event)
 	if (unlikely(event_is_checkpointed(event)))
 		cpuc->intel_cp_status |= (1ull << hwc->idx);
 
+	if (unlikely(event->attr.precise_ip))
+		intel_pmu_pebs_enable(event);
+
 	if (unlikely(hwc->config_base == MSR_ARCH_PERFMON_FIXED_CTR_CTRL)) {
-		intel_pmu_enable_fixed(hwc);
+		intel_pmu_enable_fixed(event);
 		return;
 	}
 
-	if (unlikely(event->attr.precise_ip))
-		intel_pmu_pebs_enable(event);
-
 	__x86_pmu_enable_event(hwc, ARCH_PERFMON_EVENTSEL_ENABLE);
 }
 
-- 
2.14.3
