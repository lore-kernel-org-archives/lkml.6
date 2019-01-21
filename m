Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93ACC3712F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688F321841
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfAUVnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:43:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:12712 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfAUVnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:43:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 13:43:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,504,1539673200"; 
   d="scan'208";a="129583688"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2019 13:43:29 -0800
From:   kan.liang@linux.intel.com
To:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, peterz@infradead.org, mingo@redhat.com
Cc:     ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 2/5] perf/x86/kvm: Avoid unnecessary work in guest filtering
Date:   Mon, 21 Jan 2019 13:42:28 -0800
Message-Id: <1548106951-4811-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
References: <1548106951-4811-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

KVM added a workaround for PEBS events leaking into guests with
commit 26a4f3c08de4 ("perf/x86: disable PEBS on a guest entry.")
This uses the VT entry/exit list to add an extra disable of the
PEBS_ENABLE MSR.

Intel also added a fix for this issue to microcode updates on
Haswell/Broadwell/Skylake.

It turns out using the MSR entry/exit list makes VM exits
significantly slower. The list is only needed for disabling
PEBS, because the GLOBAL_CTRL change gets optimized by
KVM into changing the VMCS.

Check for the microcode updates that have the microcode
fix for leaking PEBS, and disable the extra entry/exit list
entry for PEBS_ENABLE. In addition we always clear the
GLOBAL_CTRL for the PEBS counter while running in the guest,
which is enough to make them never fire at the wrong
side of the host/guest transition.

The overhead for VM exits with the filtering active with the patch is
reduced from 8% to 4%.

The microcode patch has already been merged into future platforms.
This patch is one-off thing. The quirks is used here.

For other old platforms which doesn't have microcode patch and quirks,
extra disable of the PEBS_ENABLE MSR is still required.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V5:
- The microcode patch has already been merged into future platforms.
  So this patch is actually one-off things. The quirks is still used in
  the patch.
  Rename pebs_isolated to pebs_no_isolation. The default value is 0. So
  we don't need to worry about the future platforms. However, we have to
  set pebs_no_isolation = 1 for other old platforms which doesn't have
  microcode patch and quirks.
  Also update the commit message accordingly.
- Remove "We" in commit messages
- Add my SOB
- Align isolation_ucodes vertically
- Remove intel_check_isolation() from SNB check.

 arch/x86/events/intel/core.c | 85 ++++++++++++++++++++++++++++++++++++++------
 arch/x86/events/perf_event.h | 15 ++++----
 2 files changed, 83 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 40e12cf..13baff5 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -18,6 +18,7 @@
 #include <asm/hardirq.h>
 #include <asm/intel-family.h>
 #include <asm/apic.h>
+#include <asm/cpu_device_id.h>
 
 #include "../perf_event.h"
 
@@ -3206,16 +3207,27 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr)
 	arr[0].msr = MSR_CORE_PERF_GLOBAL_CTRL;
 	arr[0].host = x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_guest_mask;
 	arr[0].guest = x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_host_mask;
-	/*
-	 * If PMU counter has PEBS enabled it is not enough to disable counter
-	 * on a guest entry since PEBS memory write can overshoot guest entry
-	 * and corrupt guest memory. Disabling PEBS solves the problem.
-	 */
-	arr[1].msr = MSR_IA32_PEBS_ENABLE;
-	arr[1].host = cpuc->pebs_enabled;
-	arr[1].guest = 0;
+	if (x86_pmu.flags & PMU_FL_PEBS_ALL)
+		arr[0].guest &= ~cpuc->pebs_enabled;
+	else
+		arr[0].guest &= ~(cpuc->pebs_enabled & PEBS_COUNTER_MASK);
+	*nr = 1;
+
+	if (x86_pmu.pebs_no_isolation) {
+		/*
+		 * If PMU counter has PEBS enabled it is not enough to
+		 * disable counter on a guest entry since PEBS memory
+		 * write can overshoot guest entry and corrupt guest
+		 * memory. Disabling PEBS solves the problem.
+		 *
+		 * Don't do this if the CPU already enforces it.
+		 */
+		arr[1].msr = MSR_IA32_PEBS_ENABLE;
+		arr[1].host = cpuc->pebs_enabled;
+		arr[1].guest = 0;
+		*nr = 2;
+	}
 
-	*nr = 2;
 	return arr;
 }
 
@@ -3733,6 +3745,41 @@ static __init void intel_clovertown_quirk(void)
 	x86_pmu.pebs_constraints = NULL;
 }
 
+static const struct x86_cpu_desc isolation_ucodes[] = {
+	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_CORE,		 3, 0x0000001f),
+	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_ULT,		 1, 0x0000001e),
+	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_GT3E,		 1, 0x00000015),
+	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 2, 0x00000037),
+	INTEL_CPU_DESC(INTEL_FAM6_HASWELL_X,		 4, 0x0000000a),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_CORE,	 4, 0x00000023),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_GT3E,	 1, 0x00000014),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 2, 0x00000010),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 3, 0x07000009),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 4, 0x0f000009),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_XEON_D,	 5, 0x0e000002),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_X,		 2, 0x0b000014),
+	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
+	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),
+	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_MOBILE,	 3, 0x0000007c),
+	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_DESKTOP,	 3, 0x0000007c),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	 9, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	 9, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	10, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	11, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	12, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	10, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	11, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	12, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_DESKTOP,	13, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_CANNONLAKE_MOBILE,	 3, 0x00000000),
+	{}
+};
+
+static void intel_check_isolation(void)
+{
+	x86_pmu.pebs_no_isolation = !x86_cpu_has_min_microcode_rev(isolation_ucodes);
+}
+
 static int intel_snb_pebs_broken(int cpu)
 {
 	u32 rev = UINT_MAX; /* default to broken for unknown models */
@@ -3838,6 +3885,12 @@ static __init void intel_sandybridge_quirk(void)
 	cpus_read_unlock();
 }
 
+static __init void intel_isolation_quirk(void)
+{
+	x86_pmu.check_microcode = intel_check_isolation;
+	intel_check_isolation();
+}
+
 static const struct { int id; char *name; } intel_arch_events_map[] __initconst = {
 	{ PERF_COUNT_HW_CPU_CYCLES, "cpu cycles" },
 	{ PERF_COUNT_HW_INSTRUCTIONS, "instructions" },
@@ -4178,6 +4231,7 @@ __init int intel_pmu_init(void)
 
 		x86_pmu.event_constraints = intel_core2_event_constraints;
 		x86_pmu.pebs_constraints = intel_core2_pebs_event_constraints;
+		x86_pmu.pebs_no_isolation = 1;
 		pr_cont("Core2 events, ");
 		name = "core2";
 		break;
@@ -4209,6 +4263,7 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_nhm();
 		x86_add_quirk(intel_nehalem_quirk);
 		x86_pmu.pebs_no_tlb = 1;
+		x86_pmu.pebs_no_isolation = 1;
 		extra_attr = nhm_format_attr;
 
 		pr_cont("Nehalem events, ");
@@ -4228,6 +4283,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.event_constraints = intel_gen_event_constraints;
 		x86_pmu.pebs_constraints = intel_atom_pebs_event_constraints;
 		x86_pmu.pebs_aliases = intel_pebs_aliases_core2;
+		x86_pmu.pebs_no_isolation = 1;
 		pr_cont("Atom events, ");
 		name = "bonnell";
 		break;
@@ -4249,6 +4305,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.extra_regs = intel_slm_extra_regs;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.cpu_events = slm_events_attrs;
+		x86_pmu.pebs_no_isolation = 1;
 		extra_attr = slm_format_attr;
 		pr_cont("Silvermont events, ");
 		name = "silvermont";
@@ -4276,6 +4333,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.lbr_pt_coexist = true;
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.cpu_events = glm_events_attrs;
+		x86_pmu.pebs_no_isolation = 1;
 		extra_attr = slm_format_attr;
 		pr_cont("Goldmont events, ");
 		name = "goldmont";
@@ -4303,6 +4361,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_PEBS_ALL;
 		x86_pmu.get_event_constraints = glp_get_event_constraints;
 		x86_pmu.cpu_events = glm_events_attrs;
+		x86_pmu.pebs_no_isolation = 1;
 		/* Goldmont Plus has 4-wide pipeline */
 		event_attr_td_total_slots_scale_glm.event_str = "4";
 		extra_attr = slm_format_attr;
@@ -4336,6 +4395,7 @@ __init int intel_pmu_init(void)
 			X86_CONFIG(.event=0xb1, .umask=0x3f, .inv=1, .cmask=1);
 
 		intel_pmu_pebs_data_source_nhm();
+		x86_pmu.pebs_no_isolation = 1;
 		extra_attr = nhm_format_attr;
 		pr_cont("Westmere events, ");
 		name = "westmere";
@@ -4366,6 +4426,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
 
 		x86_pmu.cpu_events = snb_events_attrs;
+		x86_pmu.pebs_no_isolation = 1;
 		mem_attr = snb_mem_events_attrs;
 
 		/* UOPS_ISSUED.ANY,c=1,i=1 to count stall cycles */
@@ -4405,7 +4466,7 @@ __init int intel_pmu_init(void)
 		/* all extra regs are per-cpu when HT is on */
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
-
+		x86_pmu.pebs_no_isolation = 1;
 		x86_pmu.cpu_events = snb_events_attrs;
 		mem_attr = snb_mem_events_attrs;
 
@@ -4424,6 +4485,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_HASWELL_X:
 	case INTEL_FAM6_HASWELL_ULT:
 	case INTEL_FAM6_HASWELL_GT3E:
+		x86_add_quirk(intel_isolation_quirk);
 		x86_add_quirk(intel_ht_bug);
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, hsw_hw_cache_event_ids, sizeof(hw_cache_event_ids));
@@ -4456,6 +4518,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_BROADWELL_XEON_D:
 	case INTEL_FAM6_BROADWELL_GT3E:
 	case INTEL_FAM6_BROADWELL_X:
+		x86_add_quirk(intel_isolation_quirk);
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, hsw_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, hsw_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
@@ -4508,6 +4571,7 @@ __init int intel_pmu_init(void)
 		/* all extra regs are per-cpu when HT is on */
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
+		x86_pmu.pebs_no_isolation = 1;
 		extra_attr = slm_format_attr;
 		pr_cont("Knights Landing/Mill events, ");
 		name = "knights-landing";
@@ -4518,6 +4582,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_SKYLAKE_X:
 	case INTEL_FAM6_KABYLAKE_MOBILE:
 	case INTEL_FAM6_KABYLAKE_DESKTOP:
+		x86_add_quirk(intel_isolation_quirk);
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 78d7b70..dea716e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -601,13 +601,14 @@ struct x86_pmu {
 	/*
 	 * Intel DebugStore bits
 	 */
-	unsigned int	bts		:1,
-			bts_active	:1,
-			pebs		:1,
-			pebs_active	:1,
-			pebs_broken	:1,
-			pebs_prec_dist	:1,
-			pebs_no_tlb	:1;
+	unsigned int	bts			:1,
+			bts_active		:1,
+			pebs			:1,
+			pebs_active		:1,
+			pebs_broken		:1,
+			pebs_prec_dist		:1,
+			pebs_no_tlb		:1,
+			pebs_no_isolation	:1;
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	void		(*drain_pebs)(struct pt_regs *regs);
-- 
2.7.4

