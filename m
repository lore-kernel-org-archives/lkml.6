Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbeCICQl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:16:41 -0500
Received: from mga11.intel.com ([192.55.52.93]:50390 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750792AbeCICQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:16:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,443,1515484800";
   d="scan'208";a="23704383"
From: kan.liang@linux.intel.com
To: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com,
        vincent.weaver@maine.edu, jolsa@redhat.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/4] x86/perf/intel: Introduce PMU flag for Extended PEBS
Date: Thu,  8 Mar 2018 18:15:39 -0800
Message-Id: <20180309021542.11374-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The Extended PEBS feature, introduced in Goldmont Plus
microarchitecture, supports all events as "Extended PEBS".

Introduce flag PMU_FL_PEBS_ALL to indicate the platforms which support
extended PEBS.
To support all events, it needs to support all constraints for PEBS. To
avoid duplicating all the constraints in the PEBS table, making the PEBS
code search the normal constraints too.

Based-on-code-from: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/ds.c   | 7 +++++++
 arch/x86/events/perf_event.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 0366cd3159ca..4fa43f65835e 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -869,6 +869,13 @@ struct event_constraint *intel_pebs_constraints(struct perf_event *event)
 		}
 	}
 
+	/*
+	 * Extended PEBS support
+	 * Makes the PEBS code search the normal constraints.
+	 */
+	if (x86_pmu.flags & PMU_FL_PEBS_ALL)
+		return NULL;
+
 	return &emptyconstraint;
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index bb90184410ab..598892e001b5 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -668,6 +668,7 @@ do {									\
 #define PMU_FL_HAS_RSP_1	0x2 /* has 2 equivalent offcore_rsp regs   */
 #define PMU_FL_EXCL_CNTRS	0x4 /* has exclusive counter requirements  */
 #define PMU_FL_EXCL_ENABLED	0x8 /* exclusive counter active */
+#define PMU_FL_PEBS_ALL		0x10 /* all events are valid PEBS events */
 
 #define EVENT_VAR(_id)  event_attr_##_id
 #define EVENT_PTR(_id) &event_attr_##_id.attr.attr
-- 
2.14.3
