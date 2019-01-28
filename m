Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB1CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C272148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DW4K/5zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfA1Gpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:45:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53573 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfA1Gpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:45:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so12683156wmb.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 22:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=T0qbmuuRPxDVtPya/S7z9HnIzaHUQLSLFndkXz9dAlg=;
        b=DW4K/5zlEo6p1xfdiXC+ynAc8dp2Dfyn0kNB0kyOtEt+Uk9Fl/LFxWlhD5JVjyaY/x
         V78KHr0qkFAKLjVIzFRlNNeDM7u5RrqTzPeOxlIH0wioS0vBNt1nBMoJZy2ERknd5h+w
         O38eisMJ4t7VOtaxL09vlB/KIgOCGPLDer9aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=T0qbmuuRPxDVtPya/S7z9HnIzaHUQLSLFndkXz9dAlg=;
        b=NqzbU0mbsffbtHQ3JhXacv3y91u44RB+o68NNUtBLO3zPrIm03sFfSRtpLkkFm0uYw
         tRU2qor6pYk0I1TgTz1RbGz5zCpylXzWpng81YsdhZozP+uqPCL9RRPJ/RDwT820W7sr
         JG5/ju5YV7oeD8EFxeOcHyS+FN+VB3KNksTCxRegNqVzbER1RL9nKo8p0Uk2jZc4HVMJ
         jGnTW9A+/y1JU/VZrZfS5skyJoII9dnXF5GlHM2qryhy1JJ3jNug4hd+tpWXjFj1SlaV
         K1iqjuPGBUR3AGbOj2bb7sIjggu+KUKL9JYJX/0WRplK5jRAvDOl6kufgDpMh35FaAnZ
         DfMg==
X-Gm-Message-State: AJcUukdGpSIq+2SkDDhFOZi6osuZqnr5cOLNpbP4U9v7sM4Et6PIDuIS
        ol25njKU2acGJCzacP5fEuzZHURnyvc=
X-Google-Smtp-Source: ALg8bN7PuY29IrzZlJCKeMKfosA84RU1hevR1plRqWI35EXyy7zG9AdByO9Mr59OwoBMlA+tje7Tlg==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr262294wmg.22.1548657948489;
        Sun, 27 Jan 2019 22:45:48 -0800 (PST)
Received: from localhost ([49.248.191.44])
        by smtp.gmail.com with ESMTPSA id w10sm7927176wmb.1.2019.01.27.22.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 22:45:47 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Markus Elfring <elfring@users.sourceforge.net>,
        linux-pm@vger.kernel.org
Subject: [PATCH v4 7/9] cpufreq: qoriq: Use auto-registration of thermal cooling device
Date:   Mon, 28 Jan 2019 12:11:32 +0530
Message-Id: <f33f279a20f9125ffbec96bfbf1aa9153baebab8.1548654899.git.amit.kucheria@linaro.org>
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
 drivers/cpufreq/qoriq-cpufreq.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 3d773f64b4df..b206e6cb55f0 100644
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
+			  CPUFREQ_AUTO_REGISTER_COOLING_DEV,
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

