Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeEQSCa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:02:30 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40666 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeEQSBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:01:21 -0400
X-Google-Smtp-Source: AB8JxZqNvYRH4hLW+rGNxnp+aFjEnZ3lHESBCGX1hEySeDX9WoopyXiA03WqkGNrTd1P8XsPLizlQw==
From: Dmitry Osipenko <digetx@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v1 07/11] cpufreq: tegra20: Check if this is Tegra20 machine
Date: Thu, 17 May 2018 21:00:52 +0300
Message-Id: <20180517180056.13336-8-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517180056.13336-1-digetx@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't even try to request the clocks during of module initialization on
non-Tegra20 machines (this is the case for a multi-platform kernel) for
consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 147ae3e14f18..797c61c74b65 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/cpufreq.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 static struct cpufreq_frequency_table freq_table[] = {
 	{ .frequency = 216000 },
@@ -155,6 +156,9 @@ static int __init tegra_cpufreq_init(void)
 {
 	int err;
 
+	if (!of_machine_is_compatible("nvidia,tegra20"))
+		return -ENODEV;
+
 	cpu_clk = clk_get_sys(NULL, "cclk");
 	if (IS_ERR(cpu_clk))
 		return PTR_ERR(cpu_clk);
-- 
2.17.0
