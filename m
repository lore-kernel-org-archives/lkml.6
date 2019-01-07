Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AEEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704A72173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfAGWfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:35:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:34117 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbfAGWfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:35:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 14:35:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="124985856"
Received: from otc-lr-04.jf.intel.com ([10.54.39.135])
  by orsmga001.jf.intel.com with ESMTP; 07 Jan 2019 14:35:07 -0800
From:   kan.liang@linux.intel.com
To:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bp@alien8.de, peterz@infradead.org, mingo@redhat.com
Cc:     ak@linux.intel.com, eranian@google.com
Subject: [PATCH V5 2/4] perf/x86/kvm: Avoid unnecessary work in guest filtering
Date:   Mon,  7 Jan 2019 14:34:23 -0800
Message-Id: <1546900465-5121-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546900465-5121-1-git-send-email-kan.liang@linux.intel.com>
References: <1546900465-5121-1-git-send-email-kan.liang@linux.intel.com>
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

We see significantly reduced overhead for VM exits with the
filtering active with the patch from 8% to 4%.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---

Changes since V4:
- Use new name x86_cpu_has_min_microcode_rev() and INTEL_CHECK_UCODE

 arch/x86/events/intel/core.c | 80 +++++++++++++++++++++++++++++++++++++++-----
 arch/x86/events/perf_event.h |  3 +-
 2 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ecc3e34..587d83e 100644
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
+	if (!x86_pmu.pebs_isolated) {
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
 
@@ -3733,6 +3745,45 @@ static __init void intel_clovertown_quirk(void)
 	x86_pmu.pebs_constraints = NULL;
 }
 
+static const struct x86_cpu_check isolation_ucodes[] = {
+	INTEL_CHECK_UCODE(INTEL_FAM6_HASWELL_CORE,	 3, 0x0000001f),
+	INTEL_CHECK_UCODE(INTEL_FAM6_HASWELL_ULT,	 1, 0x0000001e),
+	INTEL_CHECK_UCODE(INTEL_FAM6_HASWELL_GT3E,	 1, 0x00000015),
+	INTEL_CHECK_UCODE(INTEL_FAM6_HASWELL_X,		 2, 0x00000037),
+	INTEL_CHECK_UCODE(INTEL_FAM6_HASWELL_X,		 4, 0x0000000a),
+	INTEL_CHECK_UCODE(INTEL_FAM6_BROADWELL_CORE,	 4, 0x00000023),
+	INTEL_CHECK_UCODE(INTEL_FAM6_BROADWELL_GT3E,	 1, 0x00000014),
+	INTEL_CHECK_UCODE(INTEL_FAM6_BROADWELL_XEON_D,	 2, 0x00000010),
+	INTEL_CHECK_UCODE(INTEL_FAM6_BROADWELL_XEON_D,	 3, 0x07000009),
+	INTEL_CHECK_UCODE(INTEL_FAM6_BROADWELL_XEON_D,	 4, 0x0f000009),
+	INTEL_CHECK_UCODE(INTEL_FAM6_BROADWELL_XEON_D,	 5, 0x0e000002),
+	INTEL_CHECK_UCODE(INTEL_FAM6_BROADWELL_X,	 2, 0x0b000014),
+	INTEL_CHECK_UCODE(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
+	INTEL_CHECK_UCODE(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),
+	INTEL_CHECK_UCODE(INTEL_FAM6_SKYLAKE_MOBILE,	 3, 0x0000007c),
+	INTEL_CHECK_UCODE(INTEL_FAM6_SKYLAKE_DESKTOP,	 3, 0x0000007c),
+	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_DESKTOP,	 9, 0x0000004e),
+	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_MOBILE,	 9, 0x0000004e),
+	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_MOBILE,     10, 0x0000004e),
+	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_MOBILE,     11, 0x0000004e),
+	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_MOBILE,     12, 0x0000004e),
+	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_DESKTOP,    10, 0x0000004e),
+	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_DESKTOP,    11, 0x0000004e),
+	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_DESKTOP,    12, 0x0000004e),
+	INTEL_CHECK_UCODE(INTEL_FAM6_KABYLAKE_DESKTOP,    13, 0x0000004e),
+	INTEL_CHECK_UCODE(INTEL_FAM6_CANNONLAKE_MOBILE,    3, 0x00000000),
+	{}
+};
+
+static void intel_check_isolation(void)
+{
+	if (!x86_cpu_has_min_microcode_rev(isolation_ucodes)) {
+		x86_pmu.pebs_isolated = 0;
+		return;
+	}
+	x86_pmu.pebs_isolated = 1;
+}
+
 static int intel_snb_pebs_broken(int cpu)
 {
 	u32 rev = UINT_MAX; /* default to broken for unknown models */
@@ -3757,6 +3808,8 @@ static void intel_snb_check_microcode(void)
 	int pebs_broken = 0;
 	int cpu;
 
+	intel_check_isolation();
+
 	for_each_online_cpu(cpu) {
 		if ((pebs_broken = intel_snb_pebs_broken(cpu)))
 			break;
@@ -3838,6 +3891,12 @@ static __init void intel_sandybridge_quirk(void)
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
@@ -4424,6 +4483,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_HASWELL_X:
 	case INTEL_FAM6_HASWELL_ULT:
 	case INTEL_FAM6_HASWELL_GT3E:
+		x86_add_quirk(intel_isolation_quirk);
 		x86_add_quirk(intel_ht_bug);
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, hsw_hw_cache_event_ids, sizeof(hw_cache_event_ids));
@@ -4456,6 +4516,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_BROADWELL_XEON_D:
 	case INTEL_FAM6_BROADWELL_GT3E:
 	case INTEL_FAM6_BROADWELL_X:
+		x86_add_quirk(intel_isolation_quirk);
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, hsw_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, hsw_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
@@ -4518,6 +4579,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_SKYLAKE_X:
 	case INTEL_FAM6_KABYLAKE_MOBILE:
 	case INTEL_FAM6_KABYLAKE_DESKTOP:
+		x86_add_quirk(intel_isolation_quirk);
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 78d7b70..c2d5a51 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -607,7 +607,8 @@ struct x86_pmu {
 			pebs_active	:1,
 			pebs_broken	:1,
 			pebs_prec_dist	:1,
-			pebs_no_tlb	:1;
+			pebs_no_tlb	:1,
+			pebs_isolated   :1;
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	void		(*drain_pebs)(struct pt_regs *regs);
-- 
2.7.4

