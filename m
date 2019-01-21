Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990D3C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662B320870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jo0rQgiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfAUPop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:44:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41288 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbfAUPop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:44:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id x10so23877164wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1aBBJ84u3ymAhFuzjAtS5nCyk99H9ZXfxJBF/z7RCfY=;
        b=Jo0rQgiA6XZhFFylUgmrP6E6Xzgb15dXRRevqTQJAUItH22QqT2xFJqIko6H3r1KqM
         zue+H7wGt+G2EkE7X96HcEWFrB+xXcJwXI0vAFtpmmIJM+ZrM7yCAMY7ekTTHxJwXvXf
         6puWowuqDKRpwPEsuadb/Ann553jVHZ6f8RtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1aBBJ84u3ymAhFuzjAtS5nCyk99H9ZXfxJBF/z7RCfY=;
        b=IAjXNT8+SU1Y7nCDYWP4R73ch9pvKdMErEYvCNg4lcH91cx5Hp5aMWCiAI+qOv2Mou
         n53X/NXvlNzUG153SlRcR9wguY0cfaNO/1iN/K+Aa7aA32uUaN8v0ZL3kaBzwxa9/izm
         VWt2/MFAFgdRdNc2xUKKS09GgfjXR6M5DSZ17PYKZISuR3wOhQJEaRrxQK2PswAjZ6zv
         Cu+NdfxVX5ZoN4CaReviBE01u+vvKITm580jK5w69cMiBqWbaJxJDjtzv3rztYWHXFPG
         GxMJFQt9E8dYa1ttY9jk3zCT4Ztv57WqXEf2eWSmvgPKcPC63lwfxtt9m5Yvc4kY5dnW
         163g==
X-Gm-Message-State: AJcUukfhIl2iHGnhpbUbRqErDegdq35zbGUFnH4rODC48gg/9IKGPQDn
        kkdB+LNhW/5qIksbB6PQ0NWEP8J5a5c=
X-Google-Smtp-Source: ALg8bN43OJDVkvNCRAP9uY4mvsbL0uXV7YqsdbtclfqiVtW8XnQaKZa+CsPCAEBiKzuCBP8RAI1gVw==
X-Received: by 2002:adf:a78a:: with SMTP id j10mr29041502wrc.191.1548085483480;
        Mon, 21 Jan 2019 07:44:43 -0800 (PST)
Received: from localhost ([49.248.61.1])
        by smtp.gmail.com with ESMTPSA id v6sm76280857wro.57.2019.01.21.07.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:44:42 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        Bastian Stender <bst@pengutronix.de>, linux-pm@vger.kernel.org
Subject: [PATCH v2 4/9] cpufreq: imx6q: Use auto-registration of thermal cooling device
Date:   Mon, 21 Jan 2019 21:10:29 +0530
Message-Id: <d1cbd481b9eda5aa76c91fe707a97d8a7a380cf3.1548084260.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548084260.git.amit.kucheria@linaro.org>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548084260.git.amit.kucheria@linaro.org>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow cpufreq core to
automatically register as a thermal cooling device.

This allows removal of boiler plate code from the driver.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 9fedf627e000..9935df234fa1 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -9,7 +9,6 @@
 #include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
-#include <linux/cpu_cooling.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
@@ -52,7 +51,6 @@ static struct clk_bulk_data clks[] = {
 };
 
 static struct device *cpu_dev;
-static struct thermal_cooling_device *cdev;
 static bool free_opp;
 static struct cpufreq_frequency_table *freq_table;
 static unsigned int max_freq;
@@ -193,16 +191,6 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 	return 0;
 }
 
-static void imx6q_cpufreq_ready(struct cpufreq_policy *policy)
-{
-	cdev = of_cpufreq_cooling_register(policy);
-
-	if (!cdev)
-		dev_err(cpu_dev,
-			"running cpufreq without cooling device: %ld\n",
-			PTR_ERR(cdev));
-}
-
 static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret;
@@ -214,22 +202,14 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
-static int imx6q_cpufreq_exit(struct cpufreq_policy *policy)
-{
-	cpufreq_cooling_unregister(cdev);
-
-	return 0;
-}
-
 static struct cpufreq_driver imx6q_cpufreq_driver = {
-	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		 CPUFREQ_AUTO_REGISTER_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = imx6q_set_target,
 	.get = cpufreq_generic_get,
 	.init = imx6q_cpufreq_init,
-	.exit = imx6q_cpufreq_exit,
 	.name = "imx6q-cpufreq",
-	.ready = imx6q_cpufreq_ready,
 	.attr = cpufreq_generic_attr,
 	.suspend = cpufreq_generic_suspend,
 };
-- 
2.17.1

