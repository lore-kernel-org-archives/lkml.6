Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752536AbeERUIj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:08:39 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34352 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752259AbeERUH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:07:29 -0400
X-Google-Smtp-Source: AB8JxZojt8BbEQNiBZRPSVq4ZDp/l6qxK0van0X/OwMozbpCjgvHfvnLWQzTv9461J9BkfKKi63Urg==
From: Dmitry Osipenko <digetx@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v2 09/11] cpufreq: tegra20: Check if this is Tegra20 machine
Date: Fri, 18 May 2018 23:06:40 +0300
Message-Id: <20180518200642.24815-10-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518200642.24815-1-digetx@gmail.com>
References: <20180518200642.24815-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't even try to request the clocks during of module initialization on
non-Tegra20 machines (this is the case for a multi-platform kernel) for
consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 36075aee2ff2..7b425ebe81e7 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/types.h>
 
 static struct cpufreq_frequency_table freq_table[] = {
@@ -158,6 +159,9 @@ static int __init tegra_cpufreq_init(void)
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
