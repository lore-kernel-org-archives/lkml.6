Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057DDC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FDD2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKCXamQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfAYHEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:04:12 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40417 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbfAYHEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:04:11 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so6554806edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 23:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xA//1FlkdsXmsx5auTFeNL+jjZLqfN7vDldrYpONvm4=;
        b=cKCXamQs27SFMCtXHsaEBtbiosOOItfG+tsJqXFmkDoPmAf2H+e73DJevygpbblnSt
         GFq4GplluPUoT3mbrGtJ1VHYGObCo8N/odzHXnGIQQ7Q5bx0BLnO7FMcKOk8Th/v5nbm
         3jWu22wKm/ypacS7C8rwvGblxK9vpItxXi+Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xA//1FlkdsXmsx5auTFeNL+jjZLqfN7vDldrYpONvm4=;
        b=fhRJesF8/rUqTT5z4PEy2gOAU9ngBKrcrFgFDryInko5Dl+QTOLV0w0MKlRULMN0md
         z3OyUXJo0p8EksM3IvS9siWOxyYI4+CqJOHEfQhlRnS1qj3zIRDfh1Q58MSvykRLJEEJ
         +dMfdiIiWZiK58g1/uHd9daahwdhVAENKecIAAkUQcr9q18JQd4TYx+aEkhNfh9KmdnH
         DzMA/+uRjbcu/n0dkIfbGlQB+OYC8dJSZS2SabNDDxr5IqrlMckHOsCW2qmgA4dWTqOR
         mjS80i9UQ1LqDWxSEdn/z5l7f36RjQVJHm2hAif5x+GOx8RgVzjzcy4ncgSyf6lrtfmJ
         xmmw==
X-Gm-Message-State: AJcUukcza0xfGcnn/cgdO+wboxN9HA/Guxh5F57+1FIWdnrRUEMsNSg5
        NNiLNnoPsrv8DaM0xXFil6zNOomS2pw=
X-Google-Smtp-Source: ALg8bN5ZtDmNkfTzzOMEjmFZrYiQoSLYPamIAqopCNrzFwl4kUeNo57OfKlGU10wQqiNeVegNL6NEg==
X-Received: by 2002:aa7:c55a:: with SMTP id s26mr9551675edr.132.1548399848614;
        Thu, 24 Jan 2019 23:04:08 -0800 (PST)
Received: from localhost ([49.248.181.51])
        by smtp.gmail.com with ESMTPSA id w56sm11734113edb.72.2019.01.24.23.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 23:04:08 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCHv3 8/9] cpufreq: scmi: Use auto-registration of thermal cooling device
Date:   Fri, 25 Jan 2019 12:32:28 +0530
Message-Id: <a58e42077a234bb898df23084173319dc1a1f58d.1548398851.git.amit.kucheria@linaro.org>
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
 drivers/cpufreq/scmi-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 242c3370544e..b19e9d129f8f 100644
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
 	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
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

