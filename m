Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEA1C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E8F20989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQXJLEAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfA2E62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:58:28 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53288 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfA2E61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:58:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so16324591wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 20:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=l5jEfutaw0gwpPVDHGUPHj5GB9c2BDmfuxGAmeH9M7o=;
        b=dQXJLEAixZwDW8vnfsMujaz38Qi7FLMZzL8bgTPloe3dBBSIUcTbx42U1Iv/a9UhAO
         pfoo7bikilHw9yjxNLQpLVnSusJkqlaGiuapK19uUyJ5oEUuSgj3MkihYfY4xspaNMsR
         xdgJRQvr+8agBrmQWAaPOtY5uaua6LxsenkTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=l5jEfutaw0gwpPVDHGUPHj5GB9c2BDmfuxGAmeH9M7o=;
        b=S+lXK5UVBqeAeoBxOJwfkjeEHlsrMobzOhZOWtj8qkUlKsnigFjPaxqT+9nPaB4vWk
         NvqVIkjmfmHBUt06TMbdmIxPwrNLxAfgkdlubbGahBZ27I8QJhmCEmECG7OysHlaONKp
         j90j7gH9XP65bs4YUMctBhOjQnvQDEQGomXezF55KaY4ekMhv+mKa0K8uqRjqaBq+FND
         oWJRFK3yB/KTbXDkzDcMqRUsnxSrzM8XYdSIsjPdEClxhLoT2GxkyOIBDkimgOh5Ek/0
         X5/i5SAu+Y9MSAc9/1m3yc0iox6xjtCrwuJHwm6OYEVEgKN16hWNd21DxqC4q39wbkGh
         vTsg==
X-Gm-Message-State: AJcUukf8AW1dUn9/bhfanAdoJjxpK9NnNywt/FWVxsZdGY46M9L+Cst9
        atWFiN+dyG9aZJnkfuVuv/9fumdsXQA=
X-Google-Smtp-Source: AHgI3IaAYjS8LolkXBov5RTxAIwY1VhQUzpwri1+MXSjw7e581QTNVwM95h/Vlkfo3OnUFJUaGg45w==
X-Received: by 2002:a1c:f518:: with SMTP id t24mr4101747wmh.26.1548737904717;
        Mon, 28 Jan 2019 20:58:24 -0800 (PST)
Received: from localhost ([49.248.171.30])
        by smtp.gmail.com with ESMTPSA id n127sm1727856wmd.20.2019.01.28.20.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 20:58:23 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 7/9] cpufreq: qoriq: Use auto-registration of thermal cooling device
Date:   Tue, 29 Jan 2019 10:25:13 +0530
Message-Id: <3c0f9702f2d68f684b16c4ab5dbb3222d64127e7.1548737236.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the CPUFREQ_IS_COOLING_DEV flag to allow cpufreq core to
automatically register as a thermal cooling device.

This allows removal of boiler plate code from the driver.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpufreq/qoriq-cpufreq.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 3d773f64b4df..4295e5476264 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -13,7 +13,6 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/cpufreq.h>
-#include <linux/cpu_cooling.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -31,7 +30,6 @@
 struct cpu_data {
 	struct clk **pclk;
 	struct cpufreq_frequency_table *table;
-	struct thermal_cooling_device *cdev;
 };
 
 /*
@@ -239,7 +237,6 @@ static int qoriq_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 {
 	struct cpu_data *data = policy->driver_data;
 
-	cpufreq_cooling_unregister(data->cdev);
 	kfree(data->pclk);
 	kfree(data->table);
 	kfree(data);
@@ -258,23 +255,15 @@ static int qoriq_cpufreq_target(struct cpufreq_policy *policy,
 	return clk_set_parent(policy->clk, parent);
 }
 
-
-static void qoriq_cpufreq_ready(struct cpufreq_policy *policy)
-{
-	struct cpu_data *cpud = policy->driver_data;
-
-	cpud->cdev = of_cpufreq_cooling_register(policy);
-}
-
 static struct cpufreq_driver qoriq_cpufreq_driver = {
 	.name		= "qoriq_cpufreq",
-	.flags		= CPUFREQ_CONST_LOOPS,
+	.flags		= CPUFREQ_CONST_LOOPS |
+			  CPUFREQ_IS_COOLING_DEV,
 	.init		= qoriq_cpufreq_cpu_init,
 	.exit		= qoriq_cpufreq_cpu_exit,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= qoriq_cpufreq_target,
 	.get		= cpufreq_generic_get,
-	.ready		= qoriq_cpufreq_ready,
 	.attr		= cpufreq_generic_attr,
 };
 
-- 
2.17.1

