Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033646AbeCARz2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:55:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:56439 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033576AbeCARz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:55:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,408,1515484800";
   d="scan'208";a="179148958"
From: kan.liang@linux.intel.com
To: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel: Fix: Use u64 for limit_period
Date: Thu,  1 Mar 2018 12:54:54 -0500
Message-Id: <1519926894-3520-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The large fixed period could be truncated on Broadwell.
For example, perf record -e cycles -c 10000000000.
The fixed period is 0x2540BE400. But the period which finally applied is
0x540BE400.

Because the limit_period is unsigned, which is 32bit. The higher 32bit
of the period will be truncated.

The issue is introduced since 'commit 294fe0f52a44 ("perf/x86/intel: Add
INST_RETIRED.ALL workarounds")

Although the 'left' is s64, the value of 'left' must be positive when
calling limit_period.
bdw_limit_period() only modify the lowest 6 bits. It doesn't touch the
higher 32bit.
So it's safe to use u64 to replace the unsigned.

Fixes: 294fe0f52a44 ("perf/x86/intel: Add INST_RETIRED.ALL workarounds")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 +-
 arch/x86/events/perf_event.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 916b6e6..8e722e4 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3222,7 +3222,7 @@ glp_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
  * Therefore the effective (average) period matches the requested period,
  * despite coarser hardware granularity.
  */
-static unsigned bdw_limit_period(struct perf_event *event, unsigned left)
+static u64 bdw_limit_period(struct perf_event *event, u64 left)
 {
 	if ((event->hw.config & INTEL_ARCH_EVENT_MASK) ==
 			X86_CONFIG(.event=0xc0, .umask=0x01)) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index b5352f1..810013d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -561,7 +561,7 @@ struct x86_pmu {
 	struct x86_pmu_quirk *quirks;
 	int		perfctr_second_write;
 	bool		late_ack;
-	unsigned	(*limit_period)(struct perf_event *event, unsigned l);
+	u64		(*limit_period)(struct perf_event *event, u64 l);
 
 	/*
 	 * sysfs attrs
-- 
2.4.11
