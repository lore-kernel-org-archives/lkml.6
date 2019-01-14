Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7ADC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82F8206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUR5lnVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfANQml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:42:41 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34244 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfANQmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:42:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so23757778wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=T0qbmuuRPxDVtPya/S7z9HnIzaHUQLSLFndkXz9dAlg=;
        b=hUR5lnVQxUsyQqZ4Em0vpOTZK9O9zFAw0JABe/OkS6Qpz/WFaSndphU2Parq875aPr
         gs1kgLl0WEYPvYB/8xZBtnZqUkSqFKvjMuXBwn05KtYpaLI30C5Nt2ytaQk+t4kIOCi0
         f9tgxnuO7EZX7EmA1UgdESuBqgvbuMFcq86HA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=T0qbmuuRPxDVtPya/S7z9HnIzaHUQLSLFndkXz9dAlg=;
        b=ngXYkRtK2rb9whFgzfk/m/KfW7FNPoTsKe4VVrPpUl4j6SpBKmVX7f8uRibdyNHLg1
         zJUAnkZF5cY5peBXOh5VQ6njMejbV7EwwfrSErkHXJlzj/uP4RxHdKr6EFr7Gvx1cSux
         5qcLRuBPbZ4RJbE6ICXfO5L9QxoQtlW6asYqbNI1zs1xO1L/+aih03E9rP1Fj4QAYi5N
         sDBhJpLntr7Zgu5dmQW7f9frJIOlVj+duF8reHdRk0dhLZ2bvjX8YnCmw0+xLT1G0UzL
         2oV+e1OAlvglDqtlo6dZf0sWxF8UA1Xq5u/eIYOVbBwqz83USbuBd3VwN9/l4fpdFKPk
         bZcQ==
X-Gm-Message-State: AJcUukfx3p8wQP3ZoSrHzIJAao8dG10dZEfJZlri8+IcrlQ933VPGIBt
        rV/mgcU5s1TlrkLWZDQAHB6EaydNZhZGVA==
X-Google-Smtp-Source: ALg8bN7iW2a2Fjmj8hVmmP5eU+CkDRcUKqCSAcmaYJMu1QV5cM1QOHajlDjxNaPhbQCt1v86C/Qufg==
X-Received: by 2002:adf:92a4:: with SMTP id 33mr24707627wrn.11.1547484158818;
        Mon, 14 Jan 2019 08:42:38 -0800 (PST)
Received: from localhost ([49.248.190.171])
        by smtp.gmail.com with ESMTPSA id h17sm70359262wrt.59.2019.01.14.08.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:42:38 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tang Yuantian <yuantian.tang@freescale.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 08/10] cpufreq: qoriq: Use auto-registration of thermal cooling device
Date:   Mon, 14 Jan 2019 22:05:00 +0530
Message-Id: <f2cd6d85b701af0b373193efdbc4452c73033166.1547481320.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
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

