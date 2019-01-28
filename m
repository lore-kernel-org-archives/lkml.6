Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E33C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 382C52147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388610AbfA1Q4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:56:13 -0500
Received: from foss.arm.com ([217.140.101.70]:49886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732904AbfA1Qzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:55:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BFF7EBD;
        Mon, 28 Jan 2019 08:55:42 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6EE323F59C;
        Mon, 28 Jan 2019 08:55:39 -0800 (PST)
From:   Quentin Perret <quentin.perret@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, sudeep.holla@arm.com,
        liviu.dudau@arm.com, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nm@ti.com, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        dietmar.eggemann@arm.com, mka@chromium.org, quentin.perret@arm.com
Subject: [PATCH 4/7] cpufreq: arm_big_little: Register an Energy Model
Date:   Mon, 28 Jan 2019 16:55:19 +0000
Message-Id: <20190128165522.31749-5-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128165522.31749-1-quentin.perret@arm.com>
References: <20190128165522.31749-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

Now that PM_OPP provides a helper function to estimate the power
consumed by CPUs, make sure to try and register an Energy Model (EM)
from the arm_big_little CPUFreq driver, hence ensuring interested
subsystems (the task scheduler, for example) can make use of that
information when available.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/cpufreq/arm_big_little.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index cf62a1f64dd7..803d41c629c3 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -24,6 +24,7 @@
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_cooling.h>
+#include <linux/energy_model.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -456,6 +457,7 @@ static int get_cluster_clk_and_freq_table(struct device *cpu_dev,
 /* Per-CPU initialization */
 static int bL_cpufreq_init(struct cpufreq_policy *policy)
 {
+	struct em_data_callback em_cb = EM_DATA_CB(of_dev_pm_opp_get_cpu_power);
 	u32 cur_cluster = cpu_to_cluster(policy->cpu);
 	struct device *cpu_dev;
 	int ret;
@@ -487,6 +489,14 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency =
 				arm_bL_ops->get_transition_latency(cpu_dev);
 
+	ret = dev_pm_opp_get_opp_count(cpu_dev);
+	if (ret <= 0) {
+		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
+		return -EPROBE_DEFER;
+	}
+
+	em_register_perf_domain(policy->cpus, ret, &em_cb);
+
 	if (is_bL_switching_enabled())
 		per_cpu(cpu_last_req_freq, policy->cpu) = clk_get_cpu_rate(policy->cpu);
 
-- 
2.20.1

