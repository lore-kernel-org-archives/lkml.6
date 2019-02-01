Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECAFC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86892086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfBAJbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:31:19 -0500
Received: from foss.arm.com ([217.140.101.70]:56802 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfBAJbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:31:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3C7715BF;
        Fri,  1 Feb 2019 01:31:14 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E37B33F71E;
        Fri,  1 Feb 2019 01:31:12 -0800 (PST)
From:   Quentin Perret <quentin.perret@arm.com>
To:     viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        nm@ti.com, sboyd@kernel.org, mka@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com,
        quentin.perret@arm.com
Subject: [PATCH v3 3/5] cpufreq: scpi: Register an Energy Model
Date:   Fri,  1 Feb 2019 09:30:59 +0000
Message-Id: <20190201093101.31869-4-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201093101.31869-1-quentin.perret@arm.com>
References: <20190201093101.31869-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that PM_OPP provides a helper function to estimate the power
consumed by CPUs, make sure to try and register an Energy Model (EM)
from scpi-cpufreq, hence ensuring interested subsystems (the task
scheduler, for example) can make use of that information when available.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 99449738faa4..8e77a67a8d8c 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -98,7 +98,7 @@ scpi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 
 static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 {
-	int ret;
+	int ret, nr_opp;
 	unsigned int latency;
 	struct device *cpu_dev;
 	struct scpi_data *priv;
@@ -129,8 +129,8 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
-	ret = dev_pm_opp_get_opp_count(cpu_dev);
-	if (ret <= 0) {
+	nr_opp = dev_pm_opp_get_opp_count(cpu_dev);
+	if (nr_opp <= 0) {
 		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
 		ret = -EPROBE_DEFER;
 		goto out_free_opp;
@@ -170,6 +170,9 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = latency;
 
 	policy->fast_switch_possible = false;
+
+	dev_pm_opp_of_register_em(policy->cpus, nr_opp);
+
 	return 0;
 
 out_free_cpufreq_table:
-- 
2.20.1

