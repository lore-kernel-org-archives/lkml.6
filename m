Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F15C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD15B2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7dXm3ea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfA1GpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:45:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33153 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfA1GpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:45:14 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so9626144wmh.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 22:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1aBBJ84u3ymAhFuzjAtS5nCyk99H9ZXfxJBF/z7RCfY=;
        b=O7dXm3eaXx+urbyXs+leF9FdeXesCvpiSRQYtQssVK5y81eDev8ECLB6fEhz3TVkpO
         1dLIFdEmDcMPqHZ7NWGdvSV/c4dqHkysgoHIbfpafxi9Wse6czBAMQ1AA6v5s/uCpG5F
         L5izdCEmQBNXGUIDzg5EmQR74IvSLLdxnWUBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1aBBJ84u3ymAhFuzjAtS5nCyk99H9ZXfxJBF/z7RCfY=;
        b=lROh0w6noeEuvB6jXhPo3ipF9iF8exhGo5KvtQ79ENMR1mirvJ3NS9c6IeX+0NRq1m
         NBs3AwKaQjB7cav2lkCzTz1jQGuvBrvskzgO60X2uL/Fa8tI6BpPLgYteC87cwoW7tRq
         TbCOv/+AQHbzHqhvfs1XYz7DvqPcBbmYEBU41W8YwMWytY++7cYL8TvnNZ0evoYACz05
         Y62VThpYZEqkczARSycDOkKy5Js2lxXL0C3n/4jeXgHwStPm+ftaSsiVi/dlj3cDlhsD
         vN9HZpfvCa+Rzn5jkpCCEVakNrXimUo+QnMYZZGm5n+M43WFs16t4dtE9V9ufET/BCbN
         M3uw==
X-Gm-Message-State: AJcUukefTfpNFAgYDwyKOh6abXoNOJ6r2p4IwuaXWNKKHWyx2ElN+6wl
        +piyP2w8VJqdyHV9xuylZWx2GoRX7sc=
X-Google-Smtp-Source: ALg8bN6Rk9uAR3PTJE+xTGwAp2q84/kgNNljze1NkwijNGOiZX7xZwrhozT3CR010HYpiJz85TZpEQ==
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr16048252wmu.52.1548657912682;
        Sun, 27 Jan 2019 22:45:12 -0800 (PST)
Received: from localhost ([49.248.191.44])
        by smtp.gmail.com with ESMTPSA id c15sm52708620wml.27.2019.01.27.22.45.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 22:45:12 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Bastian Stender <bst@pengutronix.de>, linux-pm@vger.kernel.org
Subject: [PATCH v4 4/9] cpufreq: imx6q: Use auto-registration of thermal cooling device
Date:   Mon, 28 Jan 2019 12:11:29 +0530
Message-Id: <6e8ab1213d82b6de5294c0f579a24150aafaf558.1548654899.git.amit.kucheria@linaro.org>
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
---
 drivers/cpufreq/imx6q-cpufreq.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 9fedf627e000..9935df234fa1 100644
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
+		 CPUFREQ_AUTO_REGISTER_COOLING_DEV,
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

