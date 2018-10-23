Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD10C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEA220671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 19:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFEA220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeJXETG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:19:06 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:32996 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeJXETG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:19:06 -0400
Received: from light.dominikbrodowski.net (isilmar.linta [10.0.0.1])
        by isilmar-4.linta.de (Postfix) with ESMTPS id 87B06200928;
        Tue, 23 Oct 2018 19:54:13 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 1B866210EF; Tue, 23 Oct 2018 21:54:04 +0200 (CEST)
Date:   Tue, 23 Oct 2018 21:54:04 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-pm@vger.kernel.org, lenb@kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] cpufreq: intel_pstate: Fix compilation for !CONFIG_ACPI
Message-ID: <20181023195403.GA3094@light.dominikbrodowski.net>
References: <20181023185429.GA6756@light.dominikbrodowski.net>
 <e8e018e267434cabc2b8db434a3576c082ab3fff.camel@linux.intel.com>
 <20181023193405.pxfl4vyazt7rtc3x@isilmar-4.linta.de>
 <b95b247b5dd85b0839a9fa6167fd1682578fb92b.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b95b247b5dd85b0839a9fa6167fd1682578fb92b.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While at it, add a few comments which config options #ifdef
and #else statements refer to.

Fixes: 86d333a8cc7f ("cpufreq: intel_pstate: Add base_frequency attribute")
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 49c0abf2d48f..9578312e43f2 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -386,16 +386,11 @@ static int intel_pstate_get_cppc_guranteed(int cpu)
 	return cppc_perf.guaranteed_perf;
 }
 
-#else
+#else /* CONFIG_ACPI_CPPC_LIB */
 static void intel_pstate_set_itmt_prio(int cpu)
 {
 }
-
-static int intel_pstate_get_cppc_guranteed(int cpu)
-{
-	return -ENOTSUPP;
-}
-#endif
+#endif /* CONFIG_ACPI_CPPC_LIB */
 
 static void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 {
@@ -477,7 +472,7 @@ static void intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
 
 	acpi_processor_unregister_performance(policy->cpu);
 }
-#else
+#else /* CONFIG_ACPI */
 static inline void intel_pstate_init_acpi_perf_limits(struct cpufreq_policy *policy)
 {
 }
@@ -490,7 +485,14 @@ static inline bool intel_pstate_acpi_pm_profile_server(void)
 {
 	return false;
 }
-#endif
+#endif /* CONFIG_ACPI */
+
+#ifndef CONFIG_ACPI_CPPC_LIB
+static int intel_pstate_get_cppc_guranteed(int cpu)
+{
+	return -ENOTSUPP;
+}
+#endif /* CONFIG_ACPI_CPPC_LIB */
 
 static inline void update_turbo_state(void)
 {
