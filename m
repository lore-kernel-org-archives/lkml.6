Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2432DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F312148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ce0p9qg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfA1GpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:45:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35053 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfA1GpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:45:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so16728237wrb.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 22:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7flkZLLLMPKnUBob6lG91eyXS2wXjEuVdEl94VSGgUQ=;
        b=ce0p9qg1PNF/g2Mzt+MI/kYGEL51eAZQwxB7uptGywv/lzmD2j+/Xk6ndBMpNS4KLb
         BgeMs0xQ+O4I+rcGxJFGp/XhLxsOMO8EMccGK+zR497LstD56+kGZnGFeW48qV5hawtT
         AldDvDhXXBySYabj4WViQD7SKKWHLBn7vR/GA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7flkZLLLMPKnUBob6lG91eyXS2wXjEuVdEl94VSGgUQ=;
        b=TbSU3uO3q46i0gANY/yib2XXd3ygEHjmdQ5d2Y0DXC7H5+Kumr38y6G28+nLaNGPYY
         X42H3x6Ku2SipE74UCFeuNqkGlTHtrqE+K0+RzjCTiwxlePdjjyKHoSd5oNnXjZiBCJ9
         C/ioS4eDTkA6jyszxY+AlKJrAUD2iznwYt5qPjU3D2+eInSkMJYIax+goSCg9qYZyA95
         xw3aMqhl5x65q8X38Ue2NAT0exBaD8KNAIWzWb0Dgk9YXM+JA8th/p1dNGw7pfQqvmgx
         CUgyFOQRqX5pqjjwez+Q9BBZuWAP4E2ON/qLT6ns6hKF3cFW/cjgJhRfBhNy93FaOChg
         Ae5Q==
X-Gm-Message-State: AJcUukftvf4k7nFPbTmtQo3kEivwKUAMIdfqcb5N9sRgDwQOgTvxsyDH
        V0Y/mmL7P3ZzqNmYvFidVicox0MNz5U=
X-Google-Smtp-Source: ALg8bN4hRvGsVB7OwydVzAo5DowYVFPT39mqtlIt6zVrf4HWTF1biOHwA+6CIhPHaohhuXy1wvjOOw==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr21262511wrx.302.1548657922646;
        Sun, 27 Jan 2019 22:45:22 -0800 (PST)
Received: from localhost ([49.248.191.44])
        by smtp.gmail.com with ESMTPSA id q12sm44198894wmf.2.2019.01.27.22.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 22:45:22 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 5/9] cpufreq: cpufreq-dt: Use auto-registration of thermal cooling device
Date:   Mon, 28 Jan 2019 12:11:30 +0530
Message-Id: <cb7296e38ec506b008e65ecf5f80ccb356f67fb8.1548654899.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548654899.git.amit.kucheria@linaro.org>
References: <cover.1548654899.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548654899.git.amit.kucheria@linaro.org>
References: <cover.1548654899.git.amit.kucheria@linaro.org>
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

