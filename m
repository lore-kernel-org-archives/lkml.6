Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C73C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4341A21473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732430AbfA3RFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:05:34 -0500
Received: from foss.arm.com ([217.140.101.70]:58146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732413AbfA3RFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:05:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7310B1682;
        Wed, 30 Jan 2019 09:05:33 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82D803F589;
        Wed, 30 Jan 2019 09:05:31 -0800 (PST)
From:   Quentin Perret <quentin.perret@arm.com>
To:     viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        nm@ti.com, sboyd@kernel.org, mka@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com,
        quentin.perret@arm.com
Subject: [PATCH v2 5/5] cpufreq: scmi: Register an Energy Model
Date:   Wed, 30 Jan 2019 17:05:06 +0000
Message-Id: <20190130170506.20450-6-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130170506.20450-1-quentin.perret@arm.com>
References: <20190130170506.20450-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Model (EM) framework provides an API to register the active
power of CPUs. Call this API from the scmi-cpufreq driver by using the
power costs obtained from firmware. This is done to ensure interested
subsystems (the task scheduler, for example) can make use of the EM
when available.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 39 +++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 242c3370544e..0d87e1433296 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -12,6 +12,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_cooling.h>
+#include <linux/energy_model.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/pm_opp.h>
@@ -103,13 +104,42 @@ scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 	return 0;
 }
 
+static int __maybe_unused
+scmi_get_cpu_power(unsigned long *power, unsigned long *KHz, int cpu)
+{
+	struct device *cpu_dev = get_cpu_device(cpu);
+	unsigned long Hz;
+	int ret, domain;
+
+	if (!cpu_dev) {
+		pr_err("failed to get cpu%d device\n", cpu);
+		return -ENODEV;
+	}
+
+	domain = handle->perf_ops->device_domain_id(cpu_dev);
+	if (domain < 0)
+		return domain;
+
+	/* Get the power cost of the performance domain. */
+	Hz = *KHz * 1000;
+	ret = handle->perf_ops->est_power_get(handle, domain, &Hz, power);
+	if (ret)
+		return ret;
+
+	/* The EM framework specifies the frequency in KHz. */
+	*KHz = Hz / 1000;
+
+	return 0;
+}
+
 static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 {
-	int ret;
+	int ret, nr_opp;
 	unsigned int latency;
 	struct device *cpu_dev;
 	struct scmi_data *priv;
 	struct cpufreq_frequency_table *freq_table;
+	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
 
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
@@ -136,8 +166,8 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
-	ret = dev_pm_opp_get_opp_count(cpu_dev);
-	if (ret <= 0) {
+	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
+	if (nr_opp <= 0) {
 		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
 		ret = -EPROBE_DEFER;
 		goto out_free_opp;
@@ -171,6 +201,9 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = latency;
 
 	policy->fast_switch_possible = true;
+
+	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
+
 	return 0;
 
 out_free_priv:
-- 
2.20.1

