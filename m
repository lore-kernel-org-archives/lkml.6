Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0D8C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCED2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEk3eDfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfAYHDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:03:17 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34511 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfAYHDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:03:15 -0500
Received: by mail-yw1-f65.google.com with SMTP id g75so3536375ywb.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 23:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1aBBJ84u3ymAhFuzjAtS5nCyk99H9ZXfxJBF/z7RCfY=;
        b=NEk3eDfdH6RfX9hchExtslZ+BOkSbowcM9TqUZKf4LXiHXO2GBftEUFiMmgVxLfEX/
         B53QG/F66Ki43J/CZy0q6Xy/7ZT9UuuCZIFF3G0BowFvb43DtZgFu42ENX11ThPZSR/8
         YQ4wpc9xVwYCgAfaB02CgPrlW4/5xJsB1cLAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1aBBJ84u3ymAhFuzjAtS5nCyk99H9ZXfxJBF/z7RCfY=;
        b=LeAYR6/unktxFYYLTmIss5BSNovkp4Vd9gWEw9V7nO0QXl4Pc8klpKMqwLjyQRpXpJ
         kjtt9qsvQys+47HfdArbk/R+xTsV0S+WPTbP52KozZmq26hi+5M1+ShJ44A+9pp+e1cz
         wwrWTJXKCVh99OdFXOVBry1RxoSaeaheYxWToGHFo0h6P/wSwRut9XbiL66rfH3KaVsN
         aGuj0uwL/NELPN76rKgjUMI04D8PpmYx1nuv/HKurhniCeu6NaQRizz+DmAy5oJNMe0b
         ODWQzRfRz6GtVbZjur0HOnkePCGGGwxp7vtYMqSpyJwrmVaj/S/D1vmdeWh1n4u6Jejy
         tTSw==
X-Gm-Message-State: AJcUukcjrRWIUnWZAhAI3hAUmbV1MQkhXUnHRQY2Kh/Ipz69RrZB3aGq
        Xq3hrhvEPSi9VRozIIYOr/rpfhLsXyA=
X-Google-Smtp-Source: ALg8bN7SQpPN3qRyfnQMpYo7u9MZ1yRFj6a+v0yBQGMXwe2bPxaOaDhs5aPD/S6L2LlRPRRz3kAjdw==
X-Received: by 2002:a0d:f7c1:: with SMTP id h184mr9695278ywf.473.1548399794630;
        Thu, 24 Jan 2019 23:03:14 -0800 (PST)
Received: from localhost ([49.248.181.51])
        by smtp.gmail.com with ESMTPSA id i128sm10340153ywb.82.2019.01.24.23.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 23:03:14 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCHv3 4/9] cpufreq: imx6q: Use auto-registration of thermal cooling device
Date:   Fri, 25 Jan 2019 12:32:24 +0530
Message-Id: <e650f3a7a79803173cafc28716a205e87025007c.1548398851.git.amit.kucheria@linaro.org>
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

