Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeEQSDw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:03:52 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45733 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeEQSBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:01:18 -0400
X-Google-Smtp-Source: AB8JxZqYoSLRGmnARJdsctGoZUu3PsfyR3Du1In5kefJd4Z/xxzkcZrcmaISY08j1t5/ihX7AefJyA==
From: Dmitry Osipenko <digetx@gmail.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v1 04/11] cpufreq: tegra20: Release clocks properly
Date: Thu, 17 May 2018 21:00:49 +0300
Message-Id: <20180517180056.13336-5-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517180056.13336-1-digetx@gmail.com>
References: <20180517180056.13336-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly put requested clocks in the module init/exit code.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index 693f9067ba8a..69f033d297e1 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -165,24 +165,45 @@ static struct cpufreq_driver tegra_cpufreq_driver = {
 
 static int __init tegra_cpufreq_init(void)
 {
+	int err;
+
 	cpu_clk = clk_get_sys(NULL, "cclk");
 	if (IS_ERR(cpu_clk))
 		return PTR_ERR(cpu_clk);
 
 	pll_x_clk = clk_get_sys(NULL, "pll_x");
-	if (IS_ERR(pll_x_clk))
-		return PTR_ERR(pll_x_clk);
+	if (IS_ERR(pll_x_clk)) {
+		err = PTR_ERR(pll_x_clk);
+		goto put_cpu;
+	}
 
 	pll_p_clk = clk_get_sys(NULL, "pll_p");
-	if (IS_ERR(pll_p_clk))
-		return PTR_ERR(pll_p_clk);
+	if (IS_ERR(pll_p_clk)) {
+		err = PTR_ERR(pll_p_clk);
+		goto put_pll_x;
+	}
+
+	err = cpufreq_register_driver(&tegra_cpufreq_driver);
+	if (err)
+		goto put_pll_p;
+
+	return 0;
+
+put_pll_p:
+	clk_put(pll_p_clk);
+put_pll_x:
+	clk_put(pll_x_clk);
+put_cpu:
+	clk_put(cpu_clk);
 
-	return cpufreq_register_driver(&tegra_cpufreq_driver);
+	return err;
 }
 
 static void __exit tegra_cpufreq_exit(void)
 {
 	cpufreq_unregister_driver(&tegra_cpufreq_driver);
+	clk_put(pll_p_clk);
+	clk_put(pll_x_clk);
 	clk_put(cpu_clk);
 }
 
-- 
2.17.0
