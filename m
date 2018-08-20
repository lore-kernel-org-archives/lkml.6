Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD92C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03F72098B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03F72098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbeHTNA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 09:00:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35184 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbeHTNA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 09:00:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62CD780D;
        Mon, 20 Aug 2018 02:45:34 -0700 (PDT)
Received: from queper01-lin.local (queper01-lin.emea.arm.com [10.4.13.27])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B5F93F2EA;
        Mon, 20 Aug 2018 02:45:30 -0700 (PDT)
From:   Quentin Perret <quentin.perret@arm.com>
To:     peterz@infradead.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, mingo@redhat.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, patrick.bellasi@arm.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        thara.gopinath@linaro.org, viresh.kumar@linaro.org,
        tkjos@google.com, joel@joelfernandes.org, smuckle@google.com,
        adharmap@codeaurora.org, skannan@codeaurora.org,
        pkondeti@codeaurora.org, juri.lelli@redhat.com,
        edubezval@gmail.com, srinivas.pandruvada@linux.intel.com,
        currojerez@riseup.net, javi.merino@kernel.org,
        quentin.perret@arm.com
Subject: [PATCH v6 14/14] OPTIONAL: cpufreq: dt: Register an Energy Model
Date:   Mon, 20 Aug 2018 10:44:20 +0100
Message-Id: <20180820094420.26590-15-quentin.perret@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180820094420.26590-1-quentin.perret@arm.com>
References: <20180820094420.26590-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*******************************************************************
* This patch illustrates the usage of the newly introduced Energy *
* Model framework and isn't supposed to be merged as-is.          *
*******************************************************************

The Energy Model framework provides an API to register the active power
of CPUs. Call this API from the cpufreq-dt driver with an estimation
of the power as P = C * V^2 * f with C, V, and f respectively the
capacitance of the CPU and the voltage and frequency of the OPP.

The CPU capacitance is read from the "dynamic-power-coefficient" DT
binding (originally introduced for thermal/IPA), and the voltage and
frequency values from PM_OPP.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/cpufreq/cpufreq-dt.c | 45 +++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 0a9ebf00be46..fd5903091631 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -16,6 +16,7 @@
 #include <linux/cpu_cooling.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
+#include <linux/energy_model.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -149,8 +150,47 @@ static int resources_available(void)
 	return 0;
 }
 
+static int of_est_power(unsigned long *mW, unsigned long *KHz, int cpu)
+{
+	unsigned long mV, Hz, MHz;
+	struct device *cpu_dev;
+	struct dev_pm_opp *opp;
+	struct device_node *np;
+	u32 cap;
+	u64 tmp;
+
+	cpu_dev = get_cpu_device(cpu);
+	if (!cpu_dev)
+		return -ENODEV;
+
+	np = of_node_get(cpu_dev->of_node);
+	if (!np)
+		return -EINVAL;
+
+	if (of_property_read_u32(np, "dynamic-power-coefficient", &cap))
+		return -EINVAL;
+
+	Hz = *KHz * 1000;
+	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &Hz);
+	if (IS_ERR(opp))
+		return -EINVAL;
+
+	mV = dev_pm_opp_get_voltage(opp) / 1000;
+	dev_pm_opp_put(opp);
+
+	MHz = Hz / 1000000;
+	tmp = (u64)cap * mV * mV * MHz;
+	do_div(tmp, 1000000000);
+
+	*mW = (unsigned long)tmp;
+	*KHz = Hz / 1000;
+
+	return 0;
+}
+
 static int cpufreq_init(struct cpufreq_policy *policy)
 {
+	struct em_data_callback em_cb = EM_DATA_CB(of_est_power);
 	struct cpufreq_frequency_table *freq_table;
 	struct opp_table *opp_table = NULL;
 	struct private_data *priv;
@@ -159,7 +199,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	unsigned int transition_latency;
 	bool fallback = false;
 	const char *name;
-	int ret;
+	int ret, nr_opp;
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -226,6 +266,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		ret = -EPROBE_DEFER;
 		goto out_free_opp;
 	}
+	nr_opp = ret;
 
 	if (fallback) {
 		cpumask_setall(policy->cpus);
@@ -278,6 +319,8 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = transition_latency;
 	policy->dvfs_possible_from_any_cpu = true;
 
+	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
+
 	return 0;
 
 out_free_cpufreq_table:
-- 
2.17.1

