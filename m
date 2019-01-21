Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BED5C2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D057D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aa1WM//w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730487AbfAUPpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:45:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38070 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730457AbfAUPpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:45:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id m22so11310796wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=T0qbmuuRPxDVtPya/S7z9HnIzaHUQLSLFndkXz9dAlg=;
        b=aa1WM//wBsKs9dqORTa7wBVQcRD4lPDGGwYTXHzgbzFvML2quBZsRMMuo53RsRAM7e
         DiiUzMoO3bspcol3RGnucuMb6t6TwiXWcuWil28ria+MDGNnKBx/gSJ646n2h6FTcFdD
         2je3WG+tkpjMfbQt6bnWmcQgL7zT+j/XbcSsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=T0qbmuuRPxDVtPya/S7z9HnIzaHUQLSLFndkXz9dAlg=;
        b=frr8hLtiyNSc1u+0pGjKiJmMkg/9Ldhr/XfEcndkBur2sAIOJiDSWN8TXAOdfB6Biw
         WSbcgBjRzM5WF/yYVqjnOWzierlt/RJX5f6fuDzXI/EXO1ZJ6fXM5kztgoKQH1uceB2D
         ufq+AmWLKT9mgH/kMTVlvLDPyfIppohak/rzmtCmb6eTM3bP4WtDG8RE3uUB+B/AAIgr
         3oaPxAGqgEBl3IWavkpme0nJMCWAL4vmd2xBbELP8FFgk3HXKRXtDXaK8Wa56oeiMZex
         Z0A5287ngZ0K5jqqTCoNOlBo3gN4gqwkSCqS7ZXVnQa4MiMGSplldMlHRGpEwxJ2Vd3K
         CLXA==
X-Gm-Message-State: AJcUukcGip2yEZf1lI+wGntF0VyCLi0qm7WHVBnTc0Ds+m6WBpIow0Hn
        6e5xxQpf5iqikLKmGDlo0p0sUwr8y7U=
X-Google-Smtp-Source: ALg8bN5P48cDJjMRerOQyQk5HIhb9YaBIsRRdEJCEnmgrT3OZRldN3mYQXgjGdrFigSKwW7N5qJYLg==
X-Received: by 2002:a1c:87cc:: with SMTP id j195mr24943011wmd.2.1548085531754;
        Mon, 21 Jan 2019 07:45:31 -0800 (PST)
Received: from localhost ([49.248.61.1])
        by smtp.gmail.com with ESMTPSA id l14sm191132944wrp.55.2019.01.21.07.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:45:31 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Markus Elfring <elfring@users.sourceforge.net>,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 7/9] cpufreq: qoriq: Use auto-registration of thermal cooling device
Date:   Mon, 21 Jan 2019 21:10:32 +0530
Message-Id: <1c0f7a96c926e313569e0baf10d6d730f7ee1b23.1548084260.git.amit.kucheria@linaro.org>
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

