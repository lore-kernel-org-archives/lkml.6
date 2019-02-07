Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2751EC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000B52080A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBGLwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:52:20 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:54686 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfBGLwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:52:19 -0500
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id a22a582ef8510497; Thu, 7 Feb 2019 12:52:16 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH v2] cpufreq: intel_pstate: Rework iowait boosting to be less aggressive
Date:   Thu, 07 Feb 2019 12:51:04 +0100
Message-ID: <16144228.tcT5YVROcV@aspire.rjw.lan>
In-Reply-To: <2038590.kmssd2ZIyd@aspire.rjw.lan>
References: <2038590.kmssd2ZIyd@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The current iowait boosting mechanism in intel_pstate_update_util()
is quite aggressive, as it goes to the maximum P-state right away,
and may cause excessive amounts of energy to be used, which is not
desirable and arguably isn't necessary too.

Follow commit a5a0809bc58e ("cpufreq: schedutil: Make iowait boost
more energy efficient") that reworked the analogous iowait boost
mechanism in the schedutil governor and make the iowait boosting
in intel_pstate_update_util() work along the same lines.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2:
  * Follow the Doug's suggestion and drop the immediate jump to
    max P-state if boost is max.  The code is simpler this way and
    the perf impact should not be noticeable on average.

---
 drivers/cpufreq/intel_pstate.c |   36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

Index: linux-pm/drivers/cpufreq/intel_pstate.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/intel_pstate.c
+++ linux-pm/drivers/cpufreq/intel_pstate.c
@@ -50,6 +50,8 @@
 #define int_tofp(X) ((int64_t)(X) << FRAC_BITS)
 #define fp_toint(X) ((X) >> FRAC_BITS)
 
+#define ONE_EIGHTH_FP ((int64_t)1 << (FRAC_BITS - 3))
+
 #define EXT_BITS 6
 #define EXT_FRAC_BITS (EXT_BITS + FRAC_BITS)
 #define fp_ext_toint(X) ((X) >> EXT_FRAC_BITS)
@@ -1679,17 +1681,14 @@ static inline int32_t get_avg_pstate(str
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
+	if (busy_frac < cpu->iowait_boost)
+		busy_frac = cpu->iowait_boost;
 
 	sample->busy_scaled = busy_frac * 100;
 
@@ -1768,29 +1767,30 @@ static void intel_pstate_update_util(str
 	if (smp_processor_id() != cpu->cpu)
 		return;
 
+	delta_ns = time - cpu->last_update;
 	if (flags & SCHED_CPUFREQ_IOWAIT) {
-		cpu->iowait_boost = int_tofp(1);
-		cpu->last_update = time;
-		/*
-		 * The last time the busy was 100% so P-state was max anyway
-		 * so avoid overhead of computation.
-		 */
-		if (fp_toint(cpu->sample.busy_scaled) == 100)
-			return;
-
-		goto set_pstate;
+		/* Start over if the CPU may have been idle. */
+		if (delta_ns > TICK_NSEC) {
+			cpu->iowait_boost = ONE_EIGHTH_FP;
+		} else if (cpu->iowait_boost) {
+			cpu->iowait_boost <<= 1;
+			if (cpu->iowait_boost > int_tofp(1))
+				cpu->iowait_boost = int_tofp(1);
+		} else {
+			cpu->iowait_boost = ONE_EIGHTH_FP;
+		}
 	} else if (cpu->iowait_boost) {
 		/* Clear iowait_boost if the CPU may have been idle. */
-		delta_ns = time - cpu->last_update;
 		if (delta_ns > TICK_NSEC)
 			cpu->iowait_boost = 0;
+		else
+			cpu->iowait_boost >>= 1;
 	}
 	cpu->last_update = time;
 	delta_ns = time - cpu->sample.time;
 	if ((s64)delta_ns < INTEL_PSTATE_SAMPLING_INTERVAL)
 		return;
 
-set_pstate:
 	if (intel_pstate_sample(cpu, time))
 		intel_pstate_adjust_pstate(cpu);
 }

