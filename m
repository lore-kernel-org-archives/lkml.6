Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DFDC2F43D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A744520870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ddUlkaot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbfAUPpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:45:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41320 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730373AbfAUPpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:45:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so23878102wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7flkZLLLMPKnUBob6lG91eyXS2wXjEuVdEl94VSGgUQ=;
        b=ddUlkaotAvscldn0MmLEbEqHzkIGbCFbOPH+e2rnlqcruhdW78Lor2TPKnbHQkyTMZ
         GvAoYrLpzH9BGIynmLGPgbNMQ3oIaybxfU/wKVh1MVqSxQikPDj56p7/33QBn04ERiuZ
         RKVCit96wOBni6MRofqJHa13XkmdI0W5wYLog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7flkZLLLMPKnUBob6lG91eyXS2wXjEuVdEl94VSGgUQ=;
        b=TngJURtsHUss5NffX+ZzmyPOmUBVRwGMspwGzKCa8Q1l2SzN7+JvGS3/dUVZsy09Yi
         LUQM8vfcwWQgX9u5/dUy9wDi+bs8jl+IbUMsjl2UmSdB9w2p6HfOGCrubTC5jsoVFvxb
         sby0FScU8w4M0qvVMw5NVkR3/ofeDK5Yl1b4tr2NaGklrXPs8cMxG6vY4KPj2o6MaTCL
         h6JbMswBMx4qe5soQ/YXbVfViqCGDXIgRHbOmOjozTxZXfH0HLN5laHAqqJiat5HPiYt
         faWUZlw6vDead3AWJwDbe0APSjucfWH5seNUWTl7jTg+v4UsmFu/HU6r4lbdMIIakH0l
         Ltag==
X-Gm-Message-State: AJcUukdlKjYUMRayG973SdJxdNorHr0izadol+DDthRoroT5TiU54afq
        j2+H8NiJBPxmkEq4rEuQVGBPag+J93M=
X-Google-Smtp-Source: ALg8bN4Hqwc3XE4c95Xg9JTIbv1vNlkbldwJN6Fbw9AVnuuQViv1bD2rOJeVVWAc3yEWnygXMXHHiA==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr29546048wrx.298.1548085498604;
        Mon, 21 Jan 2019 07:44:58 -0800 (PST)
Received: from localhost ([49.248.61.1])
        by smtp.gmail.com with ESMTPSA id t199sm35306565wmt.1.2019.01.21.07.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:44:58 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 5/9] cpufreq: cpufreq-dt: Use auto-registration of thermal cooling device
Date:   Mon, 21 Jan 2019 21:10:30 +0530
Message-Id: <c52c0ba5dac58f4cec64effa9ef0a86b3d60c151.1548084260.git.amit.kucheria@linaro.org>
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
 drivers/cpufreq/cpufreq-dt.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index e58bfcb1169e..2a4c4ea7980b 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -13,7 +13,6 @@
 
 #include <linux/clk.h>
 #include <linux/cpu.h>
-#include <linux/cpu_cooling.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/err.h>
@@ -30,7 +29,6 @@
 struct private_data {
 	struct opp_table *opp_table;
 	struct device *cpu_dev;
-	struct thermal_cooling_device *cdev;
 	const char *reg_name;
 	bool have_static_opps;
 };
@@ -301,7 +299,6 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct private_data *priv = policy->driver_data;
 
-	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	if (priv->have_static_opps)
 		dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
@@ -314,21 +311,14 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void cpufreq_ready(struct cpufreq_policy *policy)
-{
-	struct private_data *priv = policy->driver_data;
-
-	priv->cdev = of_cpufreq_cooling_register(policy);
-}
-
 static struct cpufreq_driver dt_cpufreq_driver = {
-	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		 CPUFREQ_AUTO_REGISTER_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = set_target,
 	.get = cpufreq_generic_get,
 	.init = cpufreq_init,
 	.exit = cpufreq_exit,
-	.ready = cpufreq_ready,
 	.name = "cpufreq-dt",
 	.attr = cpufreq_dt_attr,
 	.suspend = cpufreq_generic_suspend,
-- 
2.17.1

