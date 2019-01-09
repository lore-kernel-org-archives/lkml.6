Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300B3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0002F20883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbfAIKmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:42:44 -0500
Received: from foss.arm.com ([217.140.101.70]:40634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbfAIKmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:42:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19300A78;
        Wed,  9 Jan 2019 02:42:43 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BCC33F70D;
        Wed,  9 Jan 2019 02:42:41 -0800 (PST)
From:   Quentin Perret <quentin.perret@arm.com>
To:     sudeep.holla@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        qais.yousef@arm.com, quentin.perret@arm.com
Subject: [PATCH] cpufreq: scmi: Fix frequency invariance in slow path
Date:   Wed,  9 Jan 2019 10:42:36 +0000
Message-Id: <20190109104236.6532-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scmi-cpufreq driver calls the arch_set_freq_scale() callback on
frequency changes to provide scale-invariant load-tracking signals to
the scheduler. However, in the slow path, it does so while specifying
the current and max frequencies in different units, hence resulting in a
broken freq_scale factor.

Fix this by passing all frequencies in KHz, as stored in the CPUFreq
frequency table.

Fixes: 99d6bdf33877 ("cpufreq: add support for CPU DVFS based on SCMI
message protocol")
Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 50b1551ba894..3f0693439486 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -52,9 +52,9 @@ scmi_cpufreq_set_target(struct cpufreq_policy *policy, unsigned int index)
 	int ret;
 	struct scmi_data *priv = policy->driver_data;
 	struct scmi_perf_ops *perf_ops = handle->perf_ops;
-	u64 freq = policy->freq_table[index].frequency * 1000;
+	u64 freq = policy->freq_table[index].frequency;
 
-	ret = perf_ops->freq_set(handle, priv->domain_id, freq, false);
+	ret = perf_ops->freq_set(handle, priv->domain_id, freq * 1000, false);
 	if (!ret)
 		arch_set_freq_scale(policy->related_cpus, freq,
 				    policy->cpuinfo.max_freq);
-- 
2.20.1

