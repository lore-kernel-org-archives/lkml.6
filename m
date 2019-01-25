Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6A3C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8062184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GBHMSNqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfAYHDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:03:22 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40616 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbfAYHDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:03:21 -0500
Received: by mail-yb1-f195.google.com with SMTP id i6so3446108ybo.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 23:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7flkZLLLMPKnUBob6lG91eyXS2wXjEuVdEl94VSGgUQ=;
        b=GBHMSNqA6ShHtjwmgPgitPzf3OS+onfrjvdFO2ocI8NldpG5NHv7o7TsP0RMdkA1mw
         0M5HfBlXeVCCP38rpGx92Snjzug5Xc1Org8gvRrfsICCbg8pTG5GaU6A1mT8gmJG1GRF
         ItEe9bb6dImdTacqjh5d1XyxEy7BWoe+qRgHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7flkZLLLMPKnUBob6lG91eyXS2wXjEuVdEl94VSGgUQ=;
        b=VCTPTsb3hhXVJcYVfhWRWca60qeRvuX3PhtST2TYIGD95T4x6L1aGVh2L93keit7QY
         Y51z+uJiLjoutf1MFtDvmr+GAFS8KpSmhgdDUrVkcJG4d4mjVIaWWOlr6+BbyVJz4tbk
         V9B2IuB1+IN+YTKsIodHtmeizyKuzFzJjFhqoPV57OsNkgICd79Q+ZEWzIPYVYJ7B9Z1
         wIcUAagKRBLuQUKpyDxL8/lFXLbsFdtyk3RPb9qZnaq6ReVhM0LGR3HTbAB6xIREVMZB
         xFLO585SAk61CiN1nO6MZxwHCHA36lhHuUR6VzdzCDIRjryJVY5mg1AdLkwFwC6+wQNS
         jN7A==
X-Gm-Message-State: AJcUukcVT7RpU6xXAdMcDTovI7dY6KGL9ho2wg7uqhLVqjoajKXtM/3N
        cSX94IwJQ52Y4Lw28m7Cs1GPnGz+mrA=
X-Google-Smtp-Source: ALg8bN7smLkrBfL5tg7/2J4LQOvWaS0hSwXs2+jVzMUNcl+KGbLFaf04Amy8esobpr50ociKN/+v+Q==
X-Received: by 2002:a25:37ce:: with SMTP id e197mr9589228yba.63.1548399799997;
        Thu, 24 Jan 2019 23:03:19 -0800 (PST)
Received: from localhost ([49.248.181.51])
        by smtp.gmail.com with ESMTPSA id y187sm8940007ywf.50.2019.01.24.23.03.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 23:03:19 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCHv3 5/9] cpufreq: cpufreq-dt: Use auto-registration of thermal cooling device
Date:   Fri, 25 Jan 2019 12:32:25 +0530
Message-Id: <be2caa368363662814a208330522fe5d83958937.1548398851.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548398851.git.amit.kucheria@linaro.org>
References: <cover.1548398851.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548398851.git.amit.kucheria@linaro.org>
References: <cover.1548398851.git.amit.kucheria@linaro.org>
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

