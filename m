Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2623C282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A137D2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mfl4kUgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfAYHDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:03:33 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33091 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbfAYHDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:03:31 -0500
Received: by mail-yb1-f194.google.com with SMTP id m132so1724188ybf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 23:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=T0qbmuuRPxDVtPya/S7z9HnIzaHUQLSLFndkXz9dAlg=;
        b=Mfl4kUgk5Aal9odAJZaf5fVDL4LZALQC7ZfU1MBmIZrUrGFbkU/ZoVR/6wogyLJqT3
         nBXoxBHOUyRGxHsVUurXbrSQ8ExPyV3uzHl/p9AqV/3GBDONOntxw0HZOtNYbgx/s40b
         N4Em4TZXghHpuLI7Wvt/9ucEhVUfN7XsiTGl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=T0qbmuuRPxDVtPya/S7z9HnIzaHUQLSLFndkXz9dAlg=;
        b=gs0QazKNOz9dULDpszuSqiwjsIZ1EHHeNVxgHd3XFCu95R3HUdqq+avNhUIpXpOpC6
         DzwOBfCWrz+yKyN1mzf7yEUTFk9p/7ijV/a1rgx/YL1kt6cHA8OXKCEsPHAMnb5gpBEI
         fDrYzyXiR+/mNOB8ZFiziW0HyXTQmokEpdFbVoXFki5rOBOYR+lN5QyjLPUf8h29pWY9
         8c1duTCYQvUfzHgae5sGSgmWPCcCT+5gQX+F8pGlUkWwlyvWLqY//RBxzuOja0ZOv4ET
         5JLqcuaPxtgQttY5GYsQVDMw33WpjzufxjNfB/TYOZXOMfkdYBDRyThv+HZe+GjQf9+5
         F3mw==
X-Gm-Message-State: AJcUukcseg812uBTDJR5dc9x0IoR7PujyGQn9tfgYTAcwJQ2BLve47NP
        DJhDaPdVi2bkE5PVHKAlWmkLtION8+8=
X-Google-Smtp-Source: ALg8bN5M5UjsyEYDwvy9e65a+ZmDVVXzpSDBg/w8xCGn1nx+RQ6QbWiA3YZyJKbHCTygoRMz0Ei56A==
X-Received: by 2002:a25:d688:: with SMTP id n130mr8188972ybg.29.1548399810240;
        Thu, 24 Jan 2019 23:03:30 -0800 (PST)
Received: from localhost ([49.248.181.51])
        by smtp.gmail.com with ESMTPSA id w63sm8943697ywc.46.2019.01.24.23.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 23:03:29 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCHv3 7/9] cpufreq: qoriq: Use auto-registration of thermal cooling device
Date:   Fri, 25 Jan 2019 12:32:27 +0530
Message-Id: <1d18d89fe2fc3655d372a0ab25e1241df4f8dd99.1548398851.git.amit.kucheria@linaro.org>
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

