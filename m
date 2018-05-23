Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754662AbeEWQBO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:01:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56074 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeEWQBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:01:11 -0400
X-Google-Smtp-Source: AB8JxZqsjtzO2uNZ6qoC0zTwoAHbxm4numfMJT8x/R2rTmY43trx5BJsWjd/p2Ee+k3pRacFYFWDPw==
From: Dmitry Osipenko <digetx@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] cpufreq: tegra20: Constify rate value of the intermediate clk
Date: Wed, 23 May 2018 19:00:19 +0300
Message-Id: <20180523160020.15291-1-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PLL_P is known to be always running at 216MHz, hence there is no need to
query its rate.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 05f57dcd5215..3ad6bded6efc 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -24,6 +24,8 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
+#define PLL_P_FREQ	216000
+
 static struct cpufreq_frequency_table freq_table[] = {
 	{ .frequency = 216000 },
 	{ .frequency = 312000 },
@@ -48,18 +50,15 @@ struct tegra20_cpufreq {
 static unsigned int tegra_get_intermediate(struct cpufreq_policy *policy,
 					   unsigned int index)
 {
-	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
-	unsigned int ifreq = clk_get_rate(cpufreq->pll_p_clk) / 1000;
-
 	/*
 	 * Don't switch to intermediate freq if:
 	 * - we are already at it, i.e. policy->cur == ifreq
 	 * - index corresponds to ifreq
 	 */
-	if (freq_table[index].frequency == ifreq || policy->cur == ifreq)
+	if (index == 0 || policy->cur == PLL_P_FREQ)
 		return 0;
 
-	return ifreq;
+	return PLL_P_FREQ;
 }
 
 static int tegra_target_intermediate(struct cpufreq_policy *policy,
@@ -93,14 +92,13 @@ static int tegra_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct tegra20_cpufreq *cpufreq = cpufreq_get_driver_data();
 	unsigned long rate = freq_table[index].frequency;
-	unsigned int ifreq = clk_get_rate(cpufreq->pll_p_clk) / 1000;
 	int ret;
 
 	/*
 	 * target freq == pll_p, don't need to take extra reference to pll_x_clk
 	 * as it isn't used anymore.
 	 */
-	if (rate == ifreq)
+	if (index == 0)
 		return clk_set_parent(cpufreq->cpu_clk, cpufreq->pll_p_clk);
 
 	ret = clk_set_rate(cpufreq->pll_x_clk, rate * 1000);
-- 
2.17.0
