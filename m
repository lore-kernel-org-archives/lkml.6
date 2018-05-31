Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750972AbeEaWVz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 18:21:55 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:31843 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbeEaWVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 18:21:49 -0400
From: Suman Anna <s-anna@ti.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Viresh Kumar <viresh.kumar@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>,
        <linux-pm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Suman Anna <s-anna@ti.com>,
        Zumeng Chen <zumeng.chen@gmail.com>
Subject: [PATCH v3 2/2] cpufreq: ti-cpufreq: Use devres managed API in probe()
Date: Thu, 31 May 2018 17:21:44 -0500
Message-ID: <20180531222144.26739-3-s-anna@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531222144.26739-1-s-anna@ti.com>
References: <20180531222144.26739-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ti_cpufreq_probe() function uses regular kzalloc to allocate
the ti_cpufreq_data structure and kfree for freeing this memory
on failures. Simplify this code by using the devres managed
API.

Cc: Zumeng Chen <zumeng.chen@gmail.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/ti-cpufreq.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 896caba5dfe5..3f0e2a14895a 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -217,7 +217,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	if (!match)
 		return -ENODEV;
 
-	opp_data = kzalloc(sizeof(*opp_data), GFP_KERNEL);
+	opp_data = devm_kzalloc(&pdev->dev, sizeof(*opp_data), GFP_KERNEL);
 	if (!opp_data)
 		return -ENOMEM;
 
@@ -226,8 +226,7 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	opp_data->cpu_dev = get_cpu_device(0);
 	if (!opp_data->cpu_dev) {
 		pr_err("%s: Failed to get device for CPU0\n", __func__);
-		ret = -ENODEV;
-		goto free_opp_data;
+		return -ENODEV;
 	}
 
 	opp_data->opp_node = dev_pm_opp_of_get_opp_desc_node(opp_data->cpu_dev);
@@ -285,8 +284,6 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 
 fail_put_node:
 	of_node_put(opp_data->opp_node);
-free_opp_data:
-	kfree(opp_data);
 
 	return ret;
 }
-- 
2.17.0
