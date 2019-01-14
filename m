Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE748C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFFC206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fhy70gTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfANQnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:43:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45117 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfANQnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:43:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id t6so23603812wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=mDodrn+SCjmkCblcpvbM4z/vNhnHCT5BvbpgksmUkgc=;
        b=Fhy70gTL0OMX9xMLnahPm61C2gyyRa/Xm4VRechtSjnkGyMbcPSkmfRt3cnQNNqQQ7
         8fc921xreoiDTRnUNG8vNvQGRtCba0fQmxktSO/vqXw2OhKGxHwXekV7VUmqX6pZRXgW
         A7SLloAtz9L09a9i5Yvv0XYBV2Ma17qDbQuVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=mDodrn+SCjmkCblcpvbM4z/vNhnHCT5BvbpgksmUkgc=;
        b=CJnpraGP0I7mSxorw8h+mziPxDYL/eHcNo4csx49OFVqkNkaJ5ywBuaTVGA7nI/tvn
         IF2XSPm9vYXImQfk8DOA9KPqz7X5JJk4d9stjWgTY20Z4U7k5Vb832KjB795Ok4Dk8zl
         oa/eNf8cCSx2zCudFY5yy1SCF/Dsro9Wu/XqyaEo34BqLrNHZumPSpXj/aNQmaTjQLyI
         p9RRDeCx9uc1ilyRIOqjfPt73PKi3xWyAZcX84dwFRoqJW3OYu3OUtOA5ogIeht7UbbD
         CA9MREIRbvKX8RgAkCe3cHA5aSypTUEiA5twximl0PPJjAyReSq/oj3o4ORlxbEhCyRk
         qP+w==
X-Gm-Message-State: AJcUukeBvyMmEAzPaY3ihtkZfuQ2Gf99SzuNi5icJZn6PReE06OO/Rip
        1vKFtorOglDis1qhL64G0bX2UhI6WsoLNg==
X-Google-Smtp-Source: ALg8bN6zHe/OsxMKKheKzh7ajANwFUVMRdZ/FaxbB5Jsbc3WBwdpnCitCEDI+OI3cXEFT2xKrPhDtw==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr23989728wrs.86.1547484192218;
        Mon, 14 Jan 2019 08:43:12 -0800 (PST)
Received: from localhost ([49.248.190.171])
        by smtp.gmail.com with ESMTPSA id s132sm12237023wmf.28.2019.01.14.08.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:43:11 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v1 09/10] cpufreq: scmi: Use auto-registration of thermal cooling device
Date:   Mon, 14 Jan 2019 22:05:01 +0530
Message-Id: <b39e20c223b108acbc144672c0d95a56e0587661.1547481320.git.amit.kucheria@linaro.org>
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
 drivers/cpufreq/scmi-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 50b1551ba894..f062a84a1175 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -11,7 +11,6 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
-#include <linux/cpu_cooling.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/pm_opp.h>
@@ -22,7 +21,6 @@
 struct scmi_data {
 	int domain_id;
 	struct device *cpu_dev;
-	struct thermal_cooling_device *cdev;
 };
 
 static const struct scmi_handle *handle;
@@ -185,7 +183,6 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct scmi_data *priv = policy->driver_data;
 
-	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	kfree(priv);
 	dev_pm_opp_cpumask_remove_table(policy->related_cpus);
@@ -193,17 +190,11 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void scmi_cpufreq_ready(struct cpufreq_policy *policy)
-{
-	struct scmi_data *priv = policy->driver_data;
-
-	priv->cdev = of_cpufreq_cooling_register(policy);
-}
-
 static struct cpufreq_driver scmi_cpufreq_driver = {
 	.name	= "scmi",
 	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
-		  CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		  CPUFREQ_AUTO_REGISTER_COOLING_DEV,
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.target_index	= scmi_cpufreq_set_target,
@@ -211,7 +202,6 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.get	= scmi_cpufreq_get_rate,
 	.init	= scmi_cpufreq_init,
 	.exit	= scmi_cpufreq_exit,
-	.ready	= scmi_cpufreq_ready,
 };
 
 static int scmi_cpufreq_probe(struct scmi_device *sdev)
-- 
2.17.1

