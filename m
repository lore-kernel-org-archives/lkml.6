Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BF8C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B213F252A8
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B213F252A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030730AbeGAQdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:33:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35278 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030381AbeGAQc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:32:58 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1C1AEACC;
        Sun,  1 Jul 2018 16:32:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 085/157] cpufreq: intel_pstate: Fix scaling max/min limits with Turbo 3.0
Date:   Sun,  1 Jul 2018 18:22:37 +0200
Message-Id: <20180701160856.832022953@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

commit ff7c9917143b3a6cf2fa61212a32d67cf259bf9c upstream.

When scaling max/min settings are changed, internally they are converted
to a ratio using the max turbo 1 core turbo frequency. This works fine
when 1 core max is same irrespective of the core. But under Turbo 3.0,
this will not be the case. For example:
Core 0: max turbo pstate: 43 (4.3GHz)
Core 1: max turbo pstate: 45 (4.5GHz)
In this case 1 core turbo ratio will be maximum of all, so it will be
45 (4.5GHz). Suppose scaling max is set to 4GHz (ratio 40) for all cores
,then on core one it will be
 = max_state * policy->max / max_freq;
 = 43 * (4000000/4500000) = 38 (3.8GHz)
 = 38
which is 200MHz less than the desired.
On core2, it will be correctly set to ratio 40 (4GHz). Same holds true
for scaling min frequency limit. So this requires usage of correct turbo
max frequency for core one, which in this case is 4.3GHz. So we need to
adjust per CPU cpu->pstate.turbo_freq using the maximum HWP ratio of that
core.

This change uses the HWP capability of a core to adjust max turbo
frequency. But since Broadwell HWP doesn't use ratios in the HWP
capabilities, we have to use legacy max 1 core turbo ratio. This is not
a problem as the HWP capabilities don't differ among cores in Broadwell.
We need to check for non Broadwell CPU model for applying this change,
though.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: 4.6+ <stable@vger.kernel.org> # 4.6+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/cpufreq/intel_pstate.c |   27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -285,6 +285,7 @@ struct pstate_funcs {
 static struct pstate_funcs pstate_funcs __read_mostly;
 
 static int hwp_active __read_mostly;
+static int hwp_mode_bdw __read_mostly;
 static bool per_cpu_limits __read_mostly;
 
 static struct cpufreq_driver *intel_pstate_driver __read_mostly;
@@ -1371,7 +1372,15 @@ static void intel_pstate_get_cpu_pstates
 	cpu->pstate.turbo_pstate = pstate_funcs.get_turbo();
 	cpu->pstate.scaling = pstate_funcs.get_scaling();
 	cpu->pstate.max_freq = cpu->pstate.max_pstate * cpu->pstate.scaling;
-	cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
+
+	if (hwp_active && !hwp_mode_bdw) {
+		unsigned int phy_max, current_max;
+
+		intel_pstate_get_hwp_max(cpu->cpu, &phy_max, &current_max);
+		cpu->pstate.turbo_freq = phy_max * cpu->pstate.scaling;
+	} else {
+		cpu->pstate.turbo_freq = cpu->pstate.turbo_pstate * cpu->pstate.scaling;
+	}
 
 	if (pstate_funcs.get_aperf_mperf_shift)
 		cpu->aperf_mperf_shift = pstate_funcs.get_aperf_mperf_shift();
@@ -2261,28 +2270,36 @@ static inline bool intel_pstate_has_acpi
 static inline void intel_pstate_request_control_from_smm(void) {}
 #endif /* CONFIG_ACPI */
 
+#define INTEL_PSTATE_HWP_BROADWELL	0x01
+
+#define ICPU_HWP(model, hwp_mode) \
+	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_HWP, hwp_mode }
+
 static const struct x86_cpu_id hwp_support_ids[] __initconst = {
-	{ X86_VENDOR_INTEL, 6, X86_MODEL_ANY, X86_FEATURE_HWP },
+	ICPU_HWP(INTEL_FAM6_BROADWELL_X, INTEL_PSTATE_HWP_BROADWELL),
+	ICPU_HWP(INTEL_FAM6_BROADWELL_XEON_D, INTEL_PSTATE_HWP_BROADWELL),
+	ICPU_HWP(X86_MODEL_ANY, 0),
 	{}
 };
 
 static int __init intel_pstate_init(void)
 {
+	const struct x86_cpu_id *id;
 	int rc;
 
 	if (no_load)
 		return -ENODEV;
 
-	if (x86_match_cpu(hwp_support_ids)) {
+	id = x86_match_cpu(hwp_support_ids);
+	if (id) {
 		copy_cpu_funcs(&core_funcs);
 		if (!no_hwp) {
 			hwp_active++;
+			hwp_mode_bdw = id->driver_data;
 			intel_pstate.attr = hwp_cpufreq_attrs;
 			goto hwp_cpu_matched;
 		}
 	} else {
-		const struct x86_cpu_id *id;
-
 		id = x86_match_cpu(intel_pstate_cpu_ids);
 		if (!id)
 			return -ENODEV;


