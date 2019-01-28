Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7582C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89052148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUk3Secd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfA1Gqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:46:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40556 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfA1Gqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:46:32 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so16698777wrt.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 22:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xA//1FlkdsXmsx5auTFeNL+jjZLqfN7vDldrYpONvm4=;
        b=HUk3SecdrvnJ83/Xwlvn4vLndaLEzSF546horDbu3kzayiHpAMhQUxQh8YokSO51GK
         7zRXduNluXbueiKMdet2oOnFHJiqcONC2veU8IZoqsZG7m7eRyINj69EzaVuRX15m966
         RP07Bw3PXe9tjtUejQGr/ESceHxIkDJ78SA38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xA//1FlkdsXmsx5auTFeNL+jjZLqfN7vDldrYpONvm4=;
        b=Jiz/5aahfvorb03mBto4sbg8jrs34wtcs2VVI112RZu/tOJ9PTYe+upE7lHgb+L/qn
         onaw1j6Ej6nQg77IlH8kiINnw04b26SLvWDodDbo86ZO8VvgSxAeKNzQRWmawC1b/SD+
         2MNePuRg/TWgvYnxi+8HNRqND8lReKIGBfVxal8IP33sY1Dfr0UU+T4xbCbqx5yXxFEr
         MsDRE5c1XuCxfE5xaaIhXvY7/9gkj54SWKwreFogFMOOfYH1U/AMXXkv2p5cspyAi8IQ
         BI3vp/GLvuIpBNudN6V7AejCaxYRSqjvMAfo/YLGsn72Dl8Vop9aN2LhfYb7SQT0X/t6
         EvZA==
X-Gm-Message-State: AHQUAuYVYE88pWTEXQlBgrSpBnuGXK8/1nhA8Kx4zX74jMngKafGLOYT
        ot31hpL7cVH1tr+kUi9bOGnSB7zIzp4=
X-Google-Smtp-Source: AHgI3IZW+2kBArB+s9SO6B1BpdG+Vt1j/1Dnfp7JT6pEHjRi2XQV0E9VRiDSM4zsTrDgFjSbzOP2sg==
X-Received: by 2002:adf:f401:: with SMTP id g1mr15063951wro.103.1548657990362;
        Sun, 27 Jan 2019 22:46:30 -0800 (PST)
Received: from localhost ([49.248.191.44])
        by smtp.gmail.com with ESMTPSA id 67sm185539371wra.37.2019.01.27.22.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 22:46:29 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v4 8/9] cpufreq: scmi: Use auto-registration of thermal cooling device
Date:   Mon, 28 Jan 2019 12:11:33 +0530
Message-Id: <81d81c0016fb275728b7b604020c22d8f53991b1.1548654899.git.amit.kucheria@linaro.org>
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

