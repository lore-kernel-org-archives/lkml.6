Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7573C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6ABA206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oe5N8JYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfANQiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:38:52 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43486 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfANQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:38:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so23641718wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=UIVW5Jk3h063m2TjLZyvAJQQxY5HQB8LVsVnZkvA3R0=;
        b=Oe5N8JYAdaTMIzIXzxENuBPAAkXsaAkTXY1hQM2DXCEDtSRB8YPdZc1Z6ShWxktov2
         ZR5kbfQP/Z5P2bFF+aECvR2FeAwTLxJfYGTN/b23rj/w3DzC6/CfVhH0RYRf86/RHvla
         9LLdaJmiWToZ9s6mCd3GqK4FUZa4FppMCTyPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=UIVW5Jk3h063m2TjLZyvAJQQxY5HQB8LVsVnZkvA3R0=;
        b=mFUjFK8Ryx9czmDxE0hyIoXz82TkinqrEZcBy83GfmE4X5V3bBtMy6ODLvYyEI3DIq
         7Zl9Ast0GHrdBwB1TWgUZT6Ye6hBne93QJD49OPDBbACFfgDq1fmjzINxljxXZpG9UPK
         yBeG/JoXH/HjshGzLwfyDWN/skpxSpwplZvtleHS8oQyonvhQstivYnWg+pt5b45sDo9
         hMhSsErGR6/fQbXrMYuXPEZU4gC4GhXGnqwWLxMFEgAxV90HlpY4g3T5ePFAMbezr1FD
         ZFK990TSMGae1UMLblzzjlYnLSPAZrfPfYNwHrDcoiO/HrHmz7og9KgbjooIacU22wS9
         axAQ==
X-Gm-Message-State: AJcUukebIrdGuN+gRnFISeAlKnMmJly12NZrpUOHmKrN6SoPoWU2MXpy
        fMeW+HUMbeyEQp6o4lfFzLvmDkoZpTanfw==
X-Google-Smtp-Source: ALg8bN5TJFhAq3WiiJC8MtbBDfqOB9t6XjcizM8ql0ft53jmW5lFv8c5QszGSfnasDSXogvq3rEOzg==
X-Received: by 2002:adf:cc91:: with SMTP id p17mr25446735wrj.118.1547483928892;
        Mon, 14 Jan 2019 08:38:48 -0800 (PST)
Received: from localhost ([49.248.190.171])
        by smtp.gmail.com with ESMTPSA id e9sm60948525wro.16.2019.01.14.08.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:38:48 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Anson Huang <anson.huang@nxp.com>, linux-pm@vger.kernel.org
Subject: [PATCH v1 05/10] cpufreq: imx6q: Use auto-registration of thermal cooling device
Date:   Mon, 14 Jan 2019 22:04:57 +0530
Message-Id: <49e531e140f299127ae6c0bc905b993b97c269e2.1547481320.git.amit.kucheria@linaro.org>
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
 drivers/cpufreq/imx6q-cpufreq.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 9fedf627e000..ffb00291f48e 100644
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
@@ -216,20 +204,18 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 
 static int imx6q_cpufreq_exit(struct cpufreq_policy *policy)
 {
-	cpufreq_cooling_unregister(cdev);
-
 	return 0;
 }
 
 static struct cpufreq_driver imx6q_cpufreq_driver = {
-	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+	.flags = CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		 CPUFREQ_AUTO_REGISTER_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = imx6q_set_target,
 	.get = cpufreq_generic_get,
 	.init = imx6q_cpufreq_init,
 	.exit = imx6q_cpufreq_exit,
 	.name = "imx6q-cpufreq",
-	.ready = imx6q_cpufreq_ready,
 	.attr = cpufreq_generic_attr,
 	.suspend = cpufreq_generic_suspend,
 };
-- 
2.17.1

