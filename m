Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0B8C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEA720837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEA720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeHaVhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:37:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:46766 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbeHaVhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:37:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Aug 2018 10:28:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,312,1531810800"; 
   d="scan'208";a="229258889"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga004.jf.intel.com with ESMTP; 31 Aug 2018 10:28:52 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     mgorman@techsingularity.net, currojerez@riseup.net,
        ggherdovich@suse.cz, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        eero.t.tamminen@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] cpufreq: intel_pstate: Optimize IO boost in non HWP mode
Date:   Fri, 31 Aug 2018 10:28:51 -0700
Message-Id: <20180831172851.79812-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The io_boost mechanism, when scheduler update util callback indicates wake
from IO was intended for short term boost to improve disk IO performance.
But once i915 graphics driver changed to io-schedule_timeout() from
schedule_timeout() during waiting for response from GPU, this caused
constant IO boost, causing intel_pstate to constantly boost to turbo.
This has bad side effect on TDP limited Atom platforms. The following two
links shows the boost and frequency plot for GPU Test called
triangle_benchmark.
https://bugzilla.kernel.org/attachment.cgi?id=278091
https://bugzilla.kernel.org/attachment.cgi?id=278093
This type of behavior was observed with many graphics tests and regular
use of such platforms with graphical interface.

The fix in this patch is to optimize the io boost by:
- Limit the maximum boost to base frequency on TDP limited Atom platforms
and max limit as 1 core turbo for the rest of the non-HWP platforms (same
as the current algorithm).
- Multilevel gradual boost: Start with increment = half of max boost and
increase to max on the subsequent IO wakes.
- Once max is reached and subsequent IO wakes don't cause boost for TDP
limited Atom platforms, with assumption that the target CPU already built
up enough load to run at higher P-state and the use of average frequency
in the current algorithm will also help not to reduce drastically. For
other platforms this is not limited similar to the current algorithm.

With this fix the resultant plots show the reduced average frequency and
also causes upto 10% improvement in some graphics tests on Atom (Broxton)
platform.
https://bugzilla.kernel.org/attachment.cgi?id=278095
https://bugzilla.kernel.org/attachment.cgi?id=278097

As per testing Eero Tamminen, the results are comparable to the patchset
https://patchwork.kernel.org/patch/10312259/
But he has to watch results for several days to check trend.

Since here boost is getting limited to turbo and non turbo, we need some
ways to adjust the fractions corresponding to max non turbo as well. It
is much easier to use the actual P-state limits for boost instead of
fractions. So here P-state io boost limit is applied on top of the
P-state limit calculated via current algorithm by removing current
io_wait boost calculation using fractions.

Since we prefer to use common algorithm for all processor platforms, this
change was tested on other client and sever platforms as well. All results
were within the margin of errors. Results:
https://bugzilla.kernel.org/attachment.cgi?id=278149

To identify TDP limited platforms a new callback boost_limited() is
added, which will set a per cpudata field called iowait_boost_limited to
1. Currently this is set for Atom platforms only.

Tested-by: Eero Tamminen <eero.t.tamminen@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 112 +++++++++++++++++++++++++++------
 1 file changed, 92 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1f2ce2f57842..15d9d5483d85 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -195,7 +195,11 @@ struct global_params {
  * @policy:		CPUFreq policy value
  * @update_util:	CPUFreq utility callback information
  * @update_util_set:	CPUFreq utility callback is set
- * @iowait_boost:	iowait-related boost fraction
+ * @iowait_boost:	iowait-related boost P-state
+ * @iowait_boost_active: iowait boost processing is active
+ * @iowait_boost_max:	Max boost P-state to apply
+ * @iowait_boost_increment: increment to last boost P-state
+ * @owait_boost_limited: If set give up boost, once reach max boost state
  * @last_update:	Time of the last update.
  * @pstate:		Stores P state limits for this CPU
  * @vid:		Stores VID limits for this CPU
@@ -254,6 +258,10 @@ struct cpudata {
 	bool valid_pss_table;
 #endif
 	unsigned int iowait_boost;
+	unsigned int iowait_boost_active;
+	int iowait_boost_max;
+	int iowait_boost_increment;
+	int iowait_boost_limited;
 	s16 epp_powersave;
 	s16 epp_policy;
 	s16 epp_default;
@@ -276,6 +284,7 @@ static struct cpudata **all_cpu_data;
  * @get_scaling:	Callback to get frequency scaling factor
  * @get_val:		Callback to convert P state to actual MSR write value
  * @get_vid:		Callback to get VID data for Atom platforms
+ * @boost_limited:	Callback to get max boost P-state, when applicable
  *
  * Core and Atom CPU models have different way to get P State limits. This
  * structure is used to store those callbacks.
@@ -289,6 +298,7 @@ struct pstate_funcs {
 	int (*get_aperf_mperf_shift)(void);
 	u64 (*get_val)(struct cpudata*, int pstate);
 	void (*get_vid)(struct cpudata *);
+	void (*boost_limited)(struct cpudata *cpudata);
 };
 
 static struct pstate_funcs pstate_funcs __read_mostly;
@@ -1251,6 +1261,11 @@ static void atom_get_vid(struct cpudata *cpudata)
 	cpudata->vid.turbo = value & 0x7f;
 }
 
+static void atom_client_boost_limited(struct cpudata *cpudata)
+{
+	cpudata->iowait_boost_limited = 1;
+}
+
 static int core_get_min_pstate(void)
 {
 	u64 value;
@@ -1441,6 +1456,19 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
 		pstate_funcs.get_vid(cpu);
 
 	intel_pstate_set_min_pstate(cpu);
+
+	if (pstate_funcs.boost_limited)
+		pstate_funcs.boost_limited(cpu);
+
+	if (cpu->iowait_boost_limited)
+		cpu->iowait_boost_max = cpu->pstate.max_pstate;
+	else
+		cpu->iowait_boost_max = cpu->pstate.turbo_pstate;
+
+	cpu->iowait_boost_increment = (cpu->iowait_boost_max - cpu->pstate.min_pstate) >> 1;
+	pr_debug("iowait_boost_limited: %d max_limit: %d increment %d\n",
+		 cpu->iowait_boost_limited, cpu->iowait_boost_max,
+		 cpu->iowait_boost_increment);
 }
 
 /*
@@ -1616,18 +1644,12 @@ static inline int32_t get_avg_pstate(struct cpudata *cpu)
 static inline int32_t get_target_pstate(struct cpudata *cpu)
 {
 	struct sample *sample = &cpu->sample;
-	int32_t busy_frac, boost;
+	int32_t busy_frac;
 	int target, avg_pstate;
 
 	busy_frac = div_fp(sample->mperf << cpu->aperf_mperf_shift,
 			   sample->tsc);
 
-	boost = cpu->iowait_boost;
-	cpu->iowait_boost >>= 1;
-
-	if (busy_frac < boost)
-		busy_frac = boost;
-
 	sample->busy_scaled = busy_frac * 100;
 
 	target = global.no_turbo || global.turbo_disabled ?
@@ -1670,6 +1692,27 @@ static void intel_pstate_update_pstate(struct cpudata *cpu, int pstate)
 	wrmsrl(MSR_IA32_PERF_CTL, pstate_funcs.get_val(cpu, pstate));
 }
 
+static int intel_pstate_adjust_for_io(struct cpudata *cpu, int target_pstate)
+{
+	if (!cpu->iowait_boost_active)
+		return target_pstate;
+
+	cpu->iowait_boost_active = 0;
+
+	if (!cpu->iowait_boost)
+		cpu->iowait_boost = cpu->pstate.min_pstate;
+
+	cpu->iowait_boost += cpu->iowait_boost_increment;
+
+	if (cpu->iowait_boost > cpu->iowait_boost_max)
+		cpu->iowait_boost = cpu->iowait_boost_max;
+
+	if (cpu->iowait_boost > target_pstate)
+		return cpu->iowait_boost;
+
+	return target_pstate;
+}
+
 static void intel_pstate_adjust_pstate(struct cpudata *cpu)
 {
 	int from = cpu->pstate.current_pstate;
@@ -1679,6 +1722,7 @@ static void intel_pstate_adjust_pstate(struct cpudata *cpu)
 	update_turbo_state();
 
 	target_pstate = get_target_pstate(cpu);
+	target_pstate = intel_pstate_adjust_for_io(cpu, target_pstate);
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
 	trace_cpu_frequency(target_pstate * cpu->pstate.scaling, cpu->cpu);
 	intel_pstate_update_pstate(cpu, target_pstate);
@@ -1692,7 +1736,7 @@ static void intel_pstate_adjust_pstate(struct cpudata *cpu)
 		sample->aperf,
 		sample->tsc,
 		get_avg_frequency(cpu),
-		fp_toint(cpu->iowait_boost * 100));
+		cpu->iowait_boost);
 }
 
 static void intel_pstate_update_util(struct update_util_data *data, u64 time,
@@ -1701,27 +1745,42 @@ static void intel_pstate_update_util(struct update_util_data *data, u64 time,
 	struct cpudata *cpu = container_of(data, struct cpudata, update_util);
 	u64 delta_ns;
 
+	cpu->sched_flags |= flags;
+
 	/* Don't allow remote callbacks */
 	if (smp_processor_id() != cpu->cpu)
 		return;
 
-	if (flags & SCHED_CPUFREQ_IOWAIT) {
-		cpu->iowait_boost = int_tofp(1);
-		cpu->last_update = time;
+	if (cpu->sched_flags & SCHED_CPUFREQ_IOWAIT) {
+		cpu->sched_flags &= ~SCHED_CPUFREQ_IOWAIT;
+
+		if (cpu->iowait_boost_limited && cpu->iowait_boost >= cpu->iowait_boost_max)
+			goto skip_ioboost;
+
 		/*
-		 * The last time the busy was 100% so P-state was max anyway
-		 * so avoid overhead of computation.
+		 * Set iowait_boost flag and update time. Since IO WAIT flag
+		 * is set all the time, we can't just conclude that there is
+		 * some IO bound activity is scheduled on this CPU with just
+		 * one occurrence. If we receive at least two in two
+		 * consecutive ticks, then we treat as a boost trigger.
 		 */
-		if (fp_toint(cpu->sample.busy_scaled) == 100)
-			return;
+		if (cpu->iowait_boost || time_before64(time, cpu->last_io_update + 2 * TICK_NSEC)) {
+			cpu->iowait_boost_active = 1;
+			cpu->last_io_update = time;
+			cpu->last_update = time;
+			goto set_pstate;
+		}
 
-		goto set_pstate;
+		cpu->last_io_update = time;
 	} else if (cpu->iowait_boost) {
 		/* Clear iowait_boost if the CPU may have been idle. */
 		delta_ns = time - cpu->last_update;
-		if (delta_ns > TICK_NSEC)
+		if (delta_ns > TICK_NSEC) {
+			cpu->iowait_boost_active = 0;
 			cpu->iowait_boost = 0;
+		}
 	}
+skip_ioboost:
 	cpu->last_update = time;
 	delta_ns = time - cpu->sample.time;
 	if ((s64)delta_ns < INTEL_PSTATE_SAMPLING_INTERVAL)
@@ -1749,6 +1808,7 @@ static const struct pstate_funcs silvermont_funcs = {
 	.get_val = atom_get_val,
 	.get_scaling = silvermont_get_scaling,
 	.get_vid = atom_get_vid,
+	.boost_limited = atom_client_boost_limited,
 };
 
 static const struct pstate_funcs airmont_funcs = {
@@ -1759,6 +1819,7 @@ static const struct pstate_funcs airmont_funcs = {
 	.get_val = atom_get_val,
 	.get_scaling = airmont_get_scaling,
 	.get_vid = atom_get_vid,
+	.boost_limited = atom_client_boost_limited,
 };
 
 static const struct pstate_funcs knl_funcs = {
@@ -1771,6 +1832,16 @@ static const struct pstate_funcs knl_funcs = {
 	.get_val = core_get_val,
 };
 
+static struct pstate_funcs atom_core_funcs = {
+	.get_max = core_get_max_pstate,
+	.get_max_physical = core_get_max_pstate_physical,
+	.get_min = core_get_min_pstate,
+	.get_turbo = core_get_turbo_pstate,
+	.get_scaling = core_get_scaling,
+	.get_val = core_get_val,
+	.boost_limited = atom_client_boost_limited,
+};
+
 #define ICPU(model, policy) \
 	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_APERFMPERF,\
 			(unsigned long)&policy }
@@ -1794,8 +1865,8 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	core_funcs),
 	ICPU(INTEL_FAM6_XEON_PHI_KNL,		knl_funcs),
 	ICPU(INTEL_FAM6_XEON_PHI_KNM,		knl_funcs),
-	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		core_funcs),
-	ICPU(INTEL_FAM6_ATOM_GEMINI_LAKE,       core_funcs),
+	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		atom_core_funcs),
+	ICPU(INTEL_FAM6_ATOM_GEMINI_LAKE,	atom_core_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE_X,		core_funcs),
 #ifdef INTEL_FAM6_ICELAKE_X
 	ICPU(INTEL_FAM6_ICELAKE_X,		core_funcs),
@@ -2390,6 +2461,7 @@ static void __init copy_cpu_funcs(struct pstate_funcs *funcs)
 	pstate_funcs.get_val   = funcs->get_val;
 	pstate_funcs.get_vid   = funcs->get_vid;
 	pstate_funcs.get_aperf_mperf_shift = funcs->get_aperf_mperf_shift;
+	pstate_funcs.boost_limited = funcs->boost_limited;
 }
 
 #ifdef CONFIG_ACPI
-- 
2.17.1

