Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbeBVJzK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 04:55:10 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:34143 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752644AbeBVJzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 04:55:07 -0500
X-Google-Smtp-Source: AH8x225kAJKbaqfZ2BAf0hlcnR16O/SA1aTfVJYwBG9ajWu4oFwuT9ngbmCSKnzZYZwQ9pNGskGrgQ==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: tegra186: Break after initialization is done for policy->cpu
Date: Thu, 22 Feb 2018 15:24:57 +0530
Message-Id: <77d470741dab32c2076a35253b9c0c2f0136583b.1519293292.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two clusters (2 + 4 CPUs) on this platform and a separate
cpufreq policy is available for each of the CPUs. The loop in
tegra186_cpufreq_init() tries to find the structure for the right CPU
and finish initialization. But it is missing a `break` statement at the
end, which forces it to restart the loop even when the CPU already
matched and initialization is done.

Fix that by adding the missing `break` statement.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/tegra186-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index fe7875311d62..771df649ceb9 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -79,6 +79,7 @@ static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
 		policy->driver_data =
 			data->regs + info->offset + EDVD_CORE_VOLT_FREQ(core);
 		cpufreq_table_validate_and_show(policy, cluster->table);
+		break;
 	}
 
 	policy->cpuinfo.transition_latency = 300 * 1000;
-- 
2.15.0.194.g9af6a3dea062
