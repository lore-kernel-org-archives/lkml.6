Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754593AbeENPfx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:35:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:23615 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754575AbeENPfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:35:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,400,1520924400";
   d="scan'208";a="39184119"
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rjw@rjwysocki.net, doug.smythies@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dsmythies@telus.net,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH V6] cpufreq: intel_pstate: allow trace in passive mode
Date: Mon, 14 May 2018 08:35:49 -0700
Message-Id: <20180514153549.33292-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Smythies <doug.smythies@gmail.com>

Allow use of the trace_pstate_sample trace function
when the intel_pstate driver is in passive mode.
Since the core_busy and scaled_busy fields are not
used, and it might be desirable to know which path
through the driver was used, either intel_cpufreq_target
or intel_cpufreq_fast_switch, re-task the core_busy
field as a flag indicator.

The user can then use the intel_pstate_tracer.py utility
to summarize and plot the trace.

Note: The core_busy feild still goes by that name
in include/trace/events/power.h and within the
intel_pstate_tracer.py script and csv file headers,
but it is graphed as "performance", and called
core_avg_perf now in the intel_pstate driver.

Sometimes, in passive mode, the driver is not called for
many tens or even hundreds of seconds. The user
needs to understand, and not be confused by, this limitation.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---

V6:
    Just added new line after return

V5: Changes as per Rafael J. Wysocki feedback.
    See: https://lkml.org/lkml/2018/1/7/270

V4: Only execute the trace specific overhead code if trace
    is enabled. Suggested by Srinivas Pandruvada.

V3: Move largely duplicate code to a subroutine.
    Suggested by Rafael J. Wysocki.

V2: prepare for resend. Rebase to current kernel, 4.15-rc3.

 drivers/cpufreq/intel_pstate.c | 46 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 17e566afbb41..08960a55eb27 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1939,13 +1939,51 @@ static int intel_cpufreq_verify_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
+/* Use of trace in passive mode:
+ *
+ * In passive mode the trace core_busy field (also known as the
+ * performance field, and lablelled as such on the graphs; also known as
+ * core_avg_perf) is not needed and so is re-assigned to indicate if the
+ * driver call was via the normal or fast switch path. Various graphs
+ * output from the intel_pstate_tracer.py utility that include core_busy
+ * (or performance or core_avg_perf) have a fixed y-axis from 0 to 100%,
+ * so we use 10 to indicate the the normal path through the driver, and
+ * 90 to indicate the fast switch path through the driver.
+ * The scaled_busy field is not used, and is set to 0.
+ */
+
+#define	INTEL_PSTATE_TRACE_TARGET 10
+#define	INTEL_PSTATE_TRACE_FAST_SWITCH 90
+
+static void intel_cpufreq_trace(struct cpudata *cpu, unsigned int trace_type, int old_pstate)
+{
+	struct sample *sample;
+
+	if (!trace_pstate_sample_enabled())
+		return;
+
+	if (!intel_pstate_sample(cpu, ktime_get()))
+		return;
+
+	sample = &cpu->sample;
+	trace_pstate_sample(trace_type,
+		0,
+		old_pstate,
+		cpu->pstate.current_pstate,
+		sample->mperf,
+		sample->aperf,
+		sample->tsc,
+		get_avg_frequency(cpu),
+		fp_toint(cpu->iowait_boost * 100));
+}
+
 static int intel_cpufreq_target(struct cpufreq_policy *policy,
 				unsigned int target_freq,
 				unsigned int relation)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
 	struct cpufreq_freqs freqs;
-	int target_pstate;
+	int target_pstate, old_pstate;
 
 	update_turbo_state();
 
@@ -1965,12 +2003,14 @@ static int intel_cpufreq_target(struct cpufreq_policy *policy,
 		break;
 	}
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
+	old_pstate = cpu->pstate.current_pstate;
 	if (target_pstate != cpu->pstate.current_pstate) {
 		cpu->pstate.current_pstate = target_pstate;
 		wrmsrl_on_cpu(policy->cpu, MSR_IA32_PERF_CTL,
 			      pstate_funcs.get_val(cpu, target_pstate));
 	}
 	freqs.new = target_pstate * cpu->pstate.scaling;
+	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_TARGET, old_pstate);
 	cpufreq_freq_transition_end(policy, &freqs, false);
 
 	return 0;
@@ -1980,13 +2020,15 @@ static unsigned int intel_cpufreq_fast_switch(struct cpufreq_policy *policy,
 					      unsigned int target_freq)
 {
 	struct cpudata *cpu = all_cpu_data[policy->cpu];
-	int target_pstate;
+	int target_pstate, old_pstate;
 
 	update_turbo_state();
 
 	target_pstate = DIV_ROUND_UP(target_freq, cpu->pstate.scaling);
 	target_pstate = intel_pstate_prepare_request(cpu, target_pstate);
+	old_pstate = cpu->pstate.current_pstate;
 	intel_pstate_update_pstate(cpu, target_pstate);
+	intel_cpufreq_trace(cpu, INTEL_PSTATE_TRACE_FAST_SWITCH, old_pstate);
 	return target_pstate * cpu->pstate.scaling;
 }
 
-- 
2.13.6
