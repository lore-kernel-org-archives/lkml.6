Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbeCICQz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 21:16:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:11779 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751134AbeCICQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 21:16:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,443,1515484800";
   d="scan'208";a="23704423"
From: kan.liang@linux.intel.com
To: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com,
        vincent.weaver@maine.edu, jolsa@redhat.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/4] perf/x86/intel: Support Extended PEBS for Goldmont Plus
Date: Thu,  8 Mar 2018 18:15:42 -0800
Message-Id: <20180309021542.11374-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180309021542.11374-1-kan.liang@linux.intel.com>
References: <20180309021542.11374-1-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Enable the extended PEBS for Goldmont Plus.

There is no specific PEBS constrains for Goldmont Plus. Removing the
pebs_constraints for Goldmont Plus.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 2 +-
 arch/x86/events/intel/ds.c   | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 86149b87cce8..7d7c02ed714b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4069,7 +4069,6 @@ __init int intel_pmu_init(void)
 		intel_pmu_lbr_init_skl();
 
 		x86_pmu.event_constraints = intel_slm_event_constraints;
-		x86_pmu.pebs_constraints = intel_glp_pebs_event_constraints;
 		x86_pmu.extra_regs = intel_glm_extra_regs;
 		/*
 		 * It's recommended to use CPU_CLK_UNHALTED.CORE_P + NPEBS
@@ -4079,6 +4078,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.pebs_prec_dist = true;
 		x86_pmu.lbr_pt_coexist = true;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
+		x86_pmu.flags |= PMU_FL_PEBS_ALL;
 		x86_pmu.get_event_constraints = glp_get_event_constraints;
 		x86_pmu.cpu_events = glm_events_attrs;
 		/* Goldmont Plus has 4-wide pipeline */
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 48b31319e401..c1749bb77417 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -711,12 +711,6 @@ struct event_constraint intel_glm_pebs_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
-struct event_constraint intel_glp_pebs_event_constraints[] = {
-	/* Allow all events as PEBS with no flags */
-	INTEL_ALL_EVENT_CONSTRAINT(0, 0xf),
-	EVENT_CONSTRAINT_END
-};
-
 struct event_constraint intel_nehalem_pebs_event_constraints[] = {
 	INTEL_PLD_CONSTRAINT(0x100b, 0xf),      /* MEM_INST_RETIRED.* */
 	INTEL_FLAGS_EVENT_CONSTRAINT(0x0f, 0xf),    /* MEM_UNCORE_RETIRED.* */
-- 
2.14.3
