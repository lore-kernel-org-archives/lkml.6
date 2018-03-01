Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032884AbeCARGd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:06:33 -0500
Received: from mga04.intel.com ([192.55.52.120]:12270 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032742AbeCARGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:06:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,408,1515484800";
   d="scan'208";a="208132155"
From: kan.liang@linux.intel.com
To: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com, Kan Liang <kan.liang@intel.com>
Subject: [PATCH 1/4] perf/x86/intel: Add Tremont CPU PMU support
Date: Thu,  1 Mar 2018 12:05:57 -0500
Message-Id: <1519923967-3433-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.4.11
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

Add perf core PMU support for Intel Tremont CPU cores:
 - The init code is based on Goldmont plus.
 - There is a new cache event list, based on the Goldmont plus cache
   event list.
 - PDIR on fixed counter 0
 - new topdown events
 -  OFFCORE_RESPONSE mask updates
 - Adaptive PEBS? (no code change)

Signed-off-by: Kan Liang <kan.liang@intel.com>
---
 arch/x86/events/intel/core.c        | 163 ++++++++++++++++++++++++++++++++++++
 arch/x86/events/intel/ds.c          |   7 ++
 arch/x86/events/perf_event.h        |   2 +
 arch/x86/include/asm/intel-family.h |   1 +
 4 files changed, 173 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3cc035e..7e25cf2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -1875,6 +1875,140 @@ static __initconst const u64 glp_hw_cache_extra_regs
 	},
 };
 
+EVENT_ATTR_STR(topdown-fe-bound,	td_fe_bound_tnt,	"event=0x71,umask=0x0");
+EVENT_ATTR_STR(topdown-retiring,	td_retiring_tnt,	"event=0x72,umask=0x0");
+EVENT_ATTR_STR(topdown-bad-spec,	td_bad_spec_tnt,	"event=0x73,umask=0x0");
+EVENT_ATTR_STR(topdown-be-bound,	td_be_bound_tnt,	"event=0x74,umask=0x0");
+
+static struct attribute *tnt_events_attrs[] = {
+	EVENT_PTR(td_fe_bound_tnt),
+	EVENT_PTR(td_retiring_tnt),
+	EVENT_PTR(td_bad_spec_tnt),
+	EVENT_PTR(td_be_bound_tnt),
+	NULL
+};
+
+static __initconst const u64 tnt_hw_cache_event_ids
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[C(L1D)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= 0x81d0,	/* MEM_UOPS_RETIRED.ALL_LOADS */
+			[C(RESULT_MISS)]	= 0x0,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= 0x82d0,	/* MEM_UOPS_RETIRED.ALL_STORES */
+			[C(RESULT_MISS)]	= 0x0,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= 0x0,
+			[C(RESULT_MISS)]	= 0x0,
+		},
+	},
+	[C(L1I)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= 0x0380,	/* ICACHE.ACCESSES */
+			[C(RESULT_MISS)]	= 0x0280,	/* ICACHE.MISSES */
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= -1,
+			[C(RESULT_MISS)]	= -1,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= 0x0,
+			[C(RESULT_MISS)]	= 0x0,
+		},
+	},
+	[C(LL)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= 0x1b7,	/* OFFCORE_RESPONSE */
+			[C(RESULT_MISS)]	= 0x1b7,	/* OFFCORE_RESPONSE */
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= 0x1b7,	/* OFFCORE_RESPONSE */
+			[C(RESULT_MISS)]	= 0x1b7,	/* OFFCORE_RESPONSE */
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= 0x0,
+			[C(RESULT_MISS)]	= 0x0,
+		},
+	},
+	[C(DTLB)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= 0x81d0,	/* MEM_UOPS_RETIRED.ALL_LOADS */
+			[C(RESULT_MISS)]	= 0xe08,	/* DTLB_LOAD_MISSES.WALK_COMPLETED */
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= 0x82d0,	/* MEM_UOPS_RETIRED.ALL_STORES */
+			[C(RESULT_MISS)]	= 0xe49,	/* DTLB_STORE_MISSES.WALK_COMPLETED */
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= 0x0,
+			[C(RESULT_MISS)]	= 0x0,
+		},
+	},
+	[C(ITLB)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= 0x0,
+			[C(RESULT_MISS)]	= 0x0481,	/* ITLB.MISS */
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= -1,
+			[C(RESULT_MISS)]	= -1,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= -1,
+			[C(RESULT_MISS)]	= -1,
+		},
+	},
+	[C(BPU)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= 0x00c4,	/* BR_INST_RETIRED.ALL_BRANCHES */
+			[C(RESULT_MISS)]	= 0x00c5,	/* BR_MISP_RETIRED.ALL_BRANCHES */
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= -1,
+			[C(RESULT_MISS)]	= -1,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= -1,
+			[C(RESULT_MISS)]	= -1,
+		},
+	},
+};
+
+static __initconst const u64 tnt_hw_cache_extra_regs
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[C(LL)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= GLM_DEMAND_READ|
+						  GLM_LLC_ACCESS,
+			[C(RESULT_MISS)]	= GLM_DEMAND_READ|
+						  GLM_LLC_MISS,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= GLM_DEMAND_WRITE|
+						  GLM_LLC_ACCESS,
+			[C(RESULT_MISS)]	= GLM_DEMAND_WRITE|
+						  GLM_LLC_MISS,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= 0x0,
+			[C(RESULT_MISS)]	= 0x0,
+		},
+	},
+};
+
+static struct extra_reg intel_tnt_extra_regs[] __read_mostly = {
+	/* must define OFFCORE_RSP_X first, see intel_fixup_er() */
+	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0xffffff9fffull, RSP_0),
+	INTEL_UEVENT_EXTRA_REG(0x02b7, MSR_OFFCORE_RSP_1, 0xffffff9fffull, RSP_1),
+	EVENT_EXTRA_END
+};
+
 #define KNL_OT_L2_HITE		BIT_ULL(19) /* Other Tile L2 Hit */
 #define KNL_OT_L2_HITF		BIT_ULL(20) /* Other Tile L2 Hit */
 #define KNL_MCDRAM_LOCAL	BIT_ULL(21)
@@ -4292,6 +4426,35 @@ __init int intel_pmu_init(void)
 		name = "goldmont_plus";
 		break;
 
+	/*TODO: test Adaptive PEBS, no extra implementation needed */
+	case INTEL_FAM6_ATOM_JACOBSVILLE:
+		memcpy(hw_cache_event_ids, tnt_hw_cache_event_ids,
+		       sizeof(hw_cache_event_ids));
+		memcpy(hw_cache_extra_regs, tnt_hw_cache_extra_regs,
+		       sizeof(hw_cache_extra_regs));
+
+		intel_pmu_lbr_init_skl();
+
+		x86_pmu.event_constraints = intel_slm_event_constraints;
+		/*TODO: test PDIR fixed counter */
+		x86_pmu.pebs_constraints = intel_tnt_pebs_event_constraints;
+		/* TODO: OFFCORE_RESPONSE mask updates for 10nm convered IDI */
+		x86_pmu.extra_regs = intel_tnt_extra_regs;
+		/*
+		 * It's recommended to use CPU_CLK_UNHALTED.CORE_P + NPEBS
+		 * for precise cycles.
+		 */
+		x86_pmu.pebs_aliases = NULL;
+		x86_pmu.pebs_prec_dist = true;
+		x86_pmu.lbr_pt_coexist = true;
+		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
+		x86_pmu.get_event_constraints = glp_get_event_constraints;
+		/*TODO: implement topdown metrics, base metrics interface same as SNC */
+		x86_pmu.cpu_events = tnt_events_attrs;
+
+		pr_cont("Tremont events, ");
+		break;
+
 	case INTEL_FAM6_WESTMERE:
 	case INTEL_FAM6_WESTMERE_EP:
 	case INTEL_FAM6_WESTMERE_EX:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 988b879..3b95e5c6 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -674,6 +674,13 @@ struct event_constraint intel_glp_pebs_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+struct event_constraint intel_tnt_pebs_event_constraints[] = {
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x1c0, 0x100000000ULL),   /* INST_RETIRED.PREC_DIST */
+	/* Allow all events as PEBS with no flags */
+	INTEL_ALL_EVENT_CONSTRAINT(0, 0x1),
+	EVENT_CONSTRAINT_END
+};
+
 struct event_constraint intel_nehalem_pebs_event_constraints[] = {
 	INTEL_PLD_CONSTRAINT(0x100b, 0xf),      /* MEM_INST_RETIRED.* */
 	INTEL_FLAGS_EVENT_CONSTRAINT(0x0f, 0xf),    /* MEM_UNCORE_RETIRED.* */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 23e81e1..2713394 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1002,6 +1002,8 @@ extern struct event_constraint intel_glm_pebs_event_constraints[];
 
 extern struct event_constraint intel_glp_pebs_event_constraints[];
 
+extern struct event_constraint intel_tnt_pebs_event_constraints[];
+
 extern struct event_constraint intel_nehalem_pebs_event_constraints[];
 
 extern struct event_constraint intel_westmere_pebs_event_constraints[];
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index b4d37ffa..aa4c026 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -63,6 +63,7 @@
 #define INTEL_FAM6_ATOM_GOLDMONT	0x5C
 #define INTEL_FAM6_ATOM_DENVERTON	0x5F /* Goldmont Microserver */
 #define INTEL_FAM6_ATOM_GEMINI_LAKE	0x7A
+#define INTEL_FAM6_ATOM_JACOBSVILLE	0x86
 
 /* Xeon Phi */
 
-- 
2.4.3
