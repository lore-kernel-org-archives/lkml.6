Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDAAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDEA206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GhCgDGmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfANQlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:41:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40344 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfANQld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:41:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so23664097wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7flkZLLLMPKnUBob6lG91eyXS2wXjEuVdEl94VSGgUQ=;
        b=GhCgDGmoxDg7HLCQuCUtdj6BGUGMiGm5sk3l9jWvy+y8Mc2yxEL+d+M3bBXCNa78zO
         luP05FxIo8xnoRlQJS+BkC2BXYKe2AA9O009LfOeUL7Is7DXlTqHb4WdG6v5KVeF2BZ8
         m/+hefIMzreCIs8TcyXF96EszozO+1m1yRRow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7flkZLLLMPKnUBob6lG91eyXS2wXjEuVdEl94VSGgUQ=;
        b=dGE9Jbkrz+NBvooKYlmn0JmaddVqv53Bq+a7ECdtiPfAxe/A52u6lJ/Vzg12POGiLu
         bHebSbs2YAQX2884urIcS9DCcezIHiLafk6zVzbEuP+IDRBE9OVMkvzfdCqiK6WledYm
         L0o2XmkNv84fT90n3FE2pvjK+/wPFjvMPMGv9+XXEYRRHNYrCRBnpk3xubd3bdJvGJHQ
         XTLLzjGaTmsj4sGWicTmAlO55KkUnHtEyLh5BiIU4HhvGenwo0EcEmi53Mzy9ZAmyrkR
         1NOT8gj7z6v/rLj/dCC2DKiOmguu2hw9JTH1EB9ebWwoYSwevZboIFxVJWP+4dJW4XlV
         G8gA==
X-Gm-Message-State: AJcUukeaoMR2nAnyRSVhycso/VIDztL1Tmi/NoMwnqE3RCRbXdgJh11b
        2tSzWiCF7WjhdBoJOjw9/ylJVIWqTcOuJg==
X-Google-Smtp-Source: ALg8bN6tdUhNWa9qvTytYjNZfEiVRNMZt3QrKlkrvKiPNsq45lioeS8omQc23kqYIJk08u9yE6WdoA==
X-Received: by 2002:adf:e5c4:: with SMTP id a4mr24073413wrn.157.1547484091561;
        Mon, 14 Jan 2019 08:41:31 -0800 (PST)
Received: from localhost ([49.248.190.171])
        by smtp.gmail.com with ESMTPSA id 143sm56483488wml.14.2019.01.14.08.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:41:30 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawn.guo@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v1 06/10] cpufreq: cpufreq-dt: Use auto-registration of thermal cooling device
Date:   Mon, 14 Jan 2019 22:04:58 +0530
Message-Id: <9ff853ce75cc1f64f106a239891f55be96a28db4.1547481320.git.amit.kucheria@linaro.org>
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
 drivers/cpufreq/cpufreq-dt.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index e58bfcb1169e..2a4c4ea7980b 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -13,7 +13,6 @@
 
 #include <linux/clk.h>
 #include <linux/cpu.h>
-#include <linux/cpu_cooling.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/err.h>
@@ -30,7 +29,6 @@
 struct private_data {
 	struct opp_table *opp_table;
 	struct device *cpu_dev;
-	struct thermal_cooling_device *cdev;
 	const char *reg_name;
 	bool have_static_opps;
 };
@@ -301,7 +299,6 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct private_data *priv = policy->driver_data;
 
-	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	if (priv->have_static_opps)
 		dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
@@ -314,21 +311,14 @@ static int cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void cpufreq_ready(struct cpufreq_policy *policy)
-{
-	struct private_data *priv = policy->driver_data;
-
-	priv->cdev = of_cpufreq_cooling_register(policy);
-}
-
 static struct cpufreq_driver dt_cpufreq_driver = {
-	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		 CPUFREQ_AUTO_REGISTER_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = set_target,
 	.get = cpufreq_generic_get,
 	.init = cpufreq_init,
 	.exit = cpufreq_exit,
-	.ready = cpufreq_ready,
 	.name = "cpufreq-dt",
 	.attr = cpufreq_dt_attr,
 	.suspend = cpufreq_generic_suspend,
-- 
2.17.1

