Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086E8C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C940F2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c9XfQHXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfAYHEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:04:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40428 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbfAYHEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:04:21 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so6555121edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 23:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lmDIKADatw1oUeQ5UHUMSZddpdBoEMSbYiY1RQRpnEA=;
        b=c9XfQHXKTJjH9D8+A9yWRU0POrNIBML8yy4f3PPCCfnJpwyfoCXm+jquPMXGhj78uP
         v3QMXI6KhuZb5C1BK6jeNEPlGnHiYGwAZUc/Oet7u0C3OjNstLEQ0B6NnDxAPvN9TzNh
         bVB81EaHQT+ngBa2Tn9F3YVPUF3LOVVXKHEvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lmDIKADatw1oUeQ5UHUMSZddpdBoEMSbYiY1RQRpnEA=;
        b=MF1MiS3PGI4vr4Wa/OfeOWDkTkffLKvQjCBlBdxfr7Nren4mx8O3wqmblKDlMCuMDV
         ZBxJ4bls4pU7OPAVCP8PEQNHICioWGBluiq8lF5YOZf6u/mvLkL/2EGkUON9lc4EmcES
         kfYGgMhx+ItZATUTxQM7ZiR+rmpLWF+g5S6fBfV3gjZ5Jpsi7G28E9cf6PioTRyfxMRf
         Roo3d3DDlybAI4c9oNfWcVfzmK8ebddyhOEwZ5lxhIrRvKGAT49fr/OwBcEECZvc3mVc
         4xJcQNQTc6D5ugC0g52+iMIJphC9ZHT8AclmYRtsOcChWpq5TTS01/xbNrGBhoXh9Ksm
         79MA==
X-Gm-Message-State: AJcUukexcWwLtgTk8OIMrCoXVSnzr6v+I4HAhyg17bppo32D6KUZ4nVK
        7PGBB2u22Bb3KTJoAdlkEh2pC35k9FE=
X-Google-Smtp-Source: ALg8bN7iPl88pvKHtZoqcZiLt/406TypDrvj6REJZ/Hbw2n5j69b2EFHMQr7yQhhLfGYchfwNWc8zQ==
X-Received: by 2002:a50:b667:: with SMTP id c36mr9996768ede.190.1548399859489;
        Thu, 24 Jan 2019 23:04:19 -0800 (PST)
Received: from localhost ([49.248.181.51])
        by smtp.gmail.com with ESMTPSA id 49sm11802931edz.59.2019.01.24.23.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 23:04:18 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCHv3 9/9] cpufreq: scpi: Use auto-registration of thermal cooling device
Date:   Fri, 25 Jan 2019 12:32:29 +0530
Message-Id: <94d264be0f980396cf4d2b94ba31e55ef1bc304b.1548398851.git.amit.kucheria@linaro.org>
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
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 99449738faa4..82420e8e5f0d 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -22,7 +22,6 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
-#include <linux/cpu_cooling.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
@@ -34,7 +33,6 @@
 struct scpi_data {
 	struct clk *clk;
 	struct device *cpu_dev;
-	struct thermal_cooling_device *cdev;
 };
 
 static struct scpi_ops *scpi_ops;
@@ -186,7 +184,6 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct scpi_data *priv = policy->driver_data;
 
-	cpufreq_cooling_unregister(priv->cdev);
 	clk_put(priv->clk);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	kfree(priv);
@@ -195,23 +192,16 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void scpi_cpufreq_ready(struct cpufreq_policy *policy)
-{
-	struct scpi_data *priv = policy->driver_data;
-
-	priv->cdev = of_cpufreq_cooling_register(policy);
-}
-
 static struct cpufreq_driver scpi_cpufreq_driver = {
 	.name	= "scpi-cpufreq",
 	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
-		  CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		  CPUFREQ_AUTO_REGISTER_COOLING_DEV,
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.get	= scpi_cpufreq_get_rate,
 	.init	= scpi_cpufreq_init,
 	.exit	= scpi_cpufreq_exit,
-	.ready	= scpi_cpufreq_ready,
 	.target_index	= scpi_cpufreq_set_target,
 };
 
-- 
2.17.1

