Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0A3C282DB
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AA92184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbfA3RFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:05:34 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58128 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732386AbfA3RFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:05:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 458B01650;
        Wed, 30 Jan 2019 09:05:31 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55A133F589;
        Wed, 30 Jan 2019 09:05:29 -0800 (PST)
From:   Quentin Perret <quentin.perret@arm.com>
To:     viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        nm@ti.com, sboyd@kernel.org, mka@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com,
        quentin.perret@arm.com
Subject: [PATCH v2 4/5] cpufreq: arm_big_little: Register an Energy Model
Date:   Wed, 30 Jan 2019 17:05:05 +0000
Message-Id: <20190130170506.20450-5-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130170506.20450-1-quentin.perret@arm.com>
References: <20190130170506.20450-1-quentin.perret@arm.com>
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
 drivers/cpufreq/arm_big_little.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index cf62a1f64dd7..18b05bcb2614 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -487,6 +487,14 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency =
 				arm_bL_ops->get_transition_latency(cpu_dev);
 
+	ret = dev_pm_opp_get_opp_count(cpu_dev);
+	if (ret <= 0) {
+		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
+		return -EPROBE_DEFER;
+	}
+
+	dev_pm_opp_of_register_em(policy->cpus, ret);
+
 	if (is_bL_switching_enabled())
 		per_cpu(cpu_last_req_freq, policy->cpu) = clk_get_cpu_rate(policy->cpu);
 
-- 
2.20.1

