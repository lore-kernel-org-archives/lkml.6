Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BADBC2F441
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB6F21726
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="coDADYUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbfAUPrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:47:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53360 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730640AbfAUPqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:46:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so11247483wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lmDIKADatw1oUeQ5UHUMSZddpdBoEMSbYiY1RQRpnEA=;
        b=coDADYUvLFZRTbz5rB1pf5MJLNgJCkEzFO1jTwKFqWh1GA28dam5wmRCxancPw/Dp5
         GBdQkQrAkjKtJD2n5CdsmDgUylwyEBdk1BLAYCT9osd1UtM1DuYR0OzrrXAN9OAwQKBw
         MKy9m0aUUc1OTPR9tPiYejvzgnMQUEydRVX1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lmDIKADatw1oUeQ5UHUMSZddpdBoEMSbYiY1RQRpnEA=;
        b=dVKMrAMN6HzY+h5pHf49JIJAPIxEe8HoLkn0IzfuSSSitgqROq3pSJa+h8sfOjLugn
         KWKHiEKNoUtJJN6RTykYB0PBBdEC7ZF2hKARR3Lv5sj87Rt4Dro9MWVH/CgU8MDHY/SB
         jKtqiz/uS7DAHOTa94APy4IzPx7KdIJaHksXP6qok4xskZkSP3Ll6h7igF3syTvkG0mL
         vBu9oRx2i/MKDxpcGMemmEZG8A7+PlljHhOCr+VLOkcGJt06H4sRooTDcgb/excZj31J
         SAkO3ZsTlvpoUzcwiqkoPh6hgJulp7K+/zsFTAI9dyxO1k6i38MJIe/bs7KUlD6zompF
         T9NQ==
X-Gm-Message-State: AJcUukc0rm4ljLe/LBUDE3aN9sCvoefeIQ9uptzetHvIb+2x3lyEXYal
        +gcu+kerDVwBPlKU0H+z6+H+JrnWu1g=
X-Google-Smtp-Source: ALg8bN6KrMDLiPVFWulMBQxmdUdOwj5FwgY6rBQBghows4GKT0uTTyxiEruIFbnYJGQhzQfvpFkoKg==
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr25885532wmu.52.1548085575943;
        Mon, 21 Jan 2019 07:46:15 -0800 (PST)
Received: from localhost ([49.248.61.1])
        by smtp.gmail.com with ESMTPSA id a18sm115239503wrp.13.2019.01.21.07.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:46:15 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 9/9] cpufreq: scpi: Use auto-registration of thermal cooling device
Date:   Mon, 21 Jan 2019 21:10:34 +0530
Message-Id: <95506c9919bee528838016dd2c857ebb28e19152.1548084260.git.amit.kucheria@linaro.org>
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

