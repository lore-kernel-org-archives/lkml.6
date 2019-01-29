Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43A0C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4B220989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKkw+bx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfA2E6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:58:49 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55771 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfA2E6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:58:48 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so16187619wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 20:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=q0Sq1ojzps17WKcX9i43B6VWlGzaqFa3Y99XQ3cE3s0=;
        b=SKkw+bx9M7a1C7KFz6NtETyB1HBgVDEedtQCAyZlJS20Esw+cYWkadE9BRpxg7FN9v
         fSTti4bcAemIotQ72wCEHy/4Ibs01qFlFne/uFQ0/dWsQ3O4hVXI40wKT9tQNZu7s0Q9
         KZKZeWQZxlWlQ/LA/VRqGQ5c2PSEfdY4+SLDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=q0Sq1ojzps17WKcX9i43B6VWlGzaqFa3Y99XQ3cE3s0=;
        b=eIg+PiS7MnnWWTo5J6Tegg9+X+pXzkOMgSRPvdZrG7U/qW6VCW1NMen0goTmIvhrfA
         kPGeKQBieZM4bvrn3CroRe8E5dtsz8jD50R10Nb333RsEshHWoy0P8856OsI36LNMpSI
         caj6jClmTOPyIROrdj/uZKSgzk346GUyrjIFvADhJA428cRsh1K0k9DIUB/UacIpcN0L
         EtdA2rBYwg/t2i4wEQeUbukgjqUdI5BsDWDI8z0jKOiGU7e2ta2n/3dngkjOy/nyEg+C
         TD/JwzjwMsP1s8SSNuoAcry9zha+iJjeREG1q8V1RWjQDQj4SzxsXZAFkvPrSY38PXNx
         V+Ng==
X-Gm-Message-State: AJcUukdJbrAgQqhHYeBfUlx5/Ra/jnzmFOx7w3fMWMYRk5oxpp2R2Z8Z
        a8iPNLzfg32qYVLvj+YzXJk4WcVpVDQ=
X-Google-Smtp-Source: ALg8bN7lQ4NZxXpPYYyKI5DUU25o6+aZkafyPjktEveuyTl9Mfybi/gfZyuPTCpUrUcuUKYg9snh3w==
X-Received: by 2002:a1c:2314:: with SMTP id j20mr19221835wmj.142.1548737926560;
        Mon, 28 Jan 2019 20:58:46 -0800 (PST)
Received: from localhost ([49.248.171.30])
        by smtp.gmail.com with ESMTPSA id 125sm1908131wmm.26.2019.01.28.20.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 20:58:46 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v5 8/9] cpufreq: scmi: Use auto-registration of thermal cooling device
Date:   Tue, 29 Jan 2019 10:25:14 +0530
Message-Id: <a96487a516184166eadb18020b23de273100b442.1548737236.git.amit.kucheria@linaro.org>
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
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpufreq/scmi-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 242c3370544e..66b633b48eb1 100644
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
+		  CPUFREQ_IS_COOLING_DEV,
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

