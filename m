Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15268C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03FA214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pi8oySiw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfA2E5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:57:53 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39404 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfA2E5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:57:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id y8so16188271wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 20:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ApaWmXxCOUpMHFzKH4UJpFJJLIlZacYoSUov6fCItbE=;
        b=Pi8oySiwrxSw+U2E/uf7rNEBCB48Zun38AmHkp+cirwAt/dohdRzgc2BhyS+p8yyOb
         PoaOQrBBqTAzY7ZKxwJbxOKYk603CH4+hi3q3pWpX0qhltsPaQab3qt6VNF3jT2Y9g7J
         X9WDPQigzIF6bmN+2tdKdqf01L5K+Rou/RbqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ApaWmXxCOUpMHFzKH4UJpFJJLIlZacYoSUov6fCItbE=;
        b=XL4MbrD8gXRrHe9nR7EjzG1A53ai40lmDDrzgANovjOmemV9gFikEfpx+6posu3oH1
         ebkfYtjzBGOHXku0mHfLeLDSxVksz5PE357/fR2Lc86IGg9T8hlWWrOzxsXoGHsgV0X2
         0JEOpFSxQ5oKiCDMu1CbNPGfLeg1pgeMTTSji4UV4gj3Blx/vOJye0GRXP/F6Ng0TYgr
         MlPKU9UcPdqBjgyte5sRqu92DVwSkHZrmcSa8r9jDuOC0VuMT9Ls/P1nVC3cHJ3+1+wW
         JhH811r+x+UZj+Pn8wrxa3rr12PC/S+QqJ0oXkZ+d1lDsSQKeEHpU6jxBSWucea1REyn
         ePpA==
X-Gm-Message-State: AJcUukcuBT2pnWV9OnGTvkneGq2b9oM3xK/WT5gM0HNNm0hg6mH/Xkqd
        5qJzGln3uid0Pwzhszku+6bHgmQZFD0=
X-Google-Smtp-Source: ALg8bN5UEBiiXSXtpHp8EndQm+0o8Ed6sp27vUhbZ75S3341/Gr23r5AiU/HoCcNVVnjmH4Z3xXhXA==
X-Received: by 2002:a1c:6657:: with SMTP id a84mr18288519wmc.23.1548737871433;
        Mon, 28 Jan 2019 20:57:51 -0800 (PST)
Received: from localhost ([49.248.171.30])
        by smtp.gmail.com with ESMTPSA id p10sm3929437wmd.14.2019.01.28.20.57.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 20:57:50 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Anson Huang <anson.huang@nxp.com>,
        Bastian Stender <bst@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org
Subject: [PATCH v5 4/9] cpufreq: imx6q: Use auto-registration of thermal cooling device
Date:   Tue, 29 Jan 2019 10:25:10 +0530
Message-Id: <37b9d8c8b580152246d988629ab52f58314f698c.1548737236.git.amit.kucheria@linaro.org>
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 9fedf627e000..ca955713e070 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -9,7 +9,6 @@
 #include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
-#include <linux/cpu_cooling.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
@@ -52,7 +51,6 @@ static struct clk_bulk_data clks[] = {
 };
 
 static struct device *cpu_dev;
-static struct thermal_cooling_device *cdev;
 static bool free_opp;
 static struct cpufreq_frequency_table *freq_table;
 static unsigned int max_freq;
@@ -193,16 +191,6 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 	return 0;
 }
 
-static void imx6q_cpufreq_ready(struct cpufreq_policy *policy)
-{
-	cdev = of_cpufreq_cooling_register(policy);
-
-	if (!cdev)
-		dev_err(cpu_dev,
-			"running cpufreq without cooling device: %ld\n",
-			PTR_ERR(cdev));
-}
-
 static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 {
 	int ret;
@@ -214,22 +202,14 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
-static int imx6q_cpufreq_exit(struct cpufreq_policy *policy)
-{
-	cpufreq_cooling_unregister(cdev);
-
-	return 0;
-}
-
 static struct cpufreq_driver imx6q_cpufreq_driver = {
-	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		 CPUFREQ_IS_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = imx6q_set_target,
 	.get = cpufreq_generic_get,
 	.init = imx6q_cpufreq_init,
-	.exit = imx6q_cpufreq_exit,
 	.name = "imx6q-cpufreq",
-	.ready = imx6q_cpufreq_ready,
 	.attr = cpufreq_generic_attr,
 	.suspend = cpufreq_generic_suspend,
 };
-- 
2.17.1

