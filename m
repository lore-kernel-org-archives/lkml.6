Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAF5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0F48206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vn/oqcY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfANQmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:42:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38278 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfANQmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:42:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id m22so223917wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=QV55M5UT9ckgy/+9mgu7lB9S5ppe7rLYbFWvyS23/Cg=;
        b=Vn/oqcY/P63zY8ZUM+xRQ9jA/yok6Av41I0Nbd/XBcMYaybRLswoqC+bZ7zFthiL99
         AD8roHRXIq4z/jltTQDQy+bZ3SYq2XsqBoRpBPDqUlr3MrNNQ8pHTqOE2xiKwhPFJy1I
         +jhPvzj5X/ykiwTALhSNyEO8GSfyjhARHv/Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=QV55M5UT9ckgy/+9mgu7lB9S5ppe7rLYbFWvyS23/Cg=;
        b=a1/k6EvspoWCF3SGmVOE2w3aRkuJfFeZpJV3VLz1P43Hozw5GRqM9BEk6DO6MpqU/d
         ZeBT/PoH0UvJNSAdSu8Tw1JqovYyff7ltcyKDyGdUQgf6rLz1HUUaqENiqk1DpGpyLjt
         SIIVaeAa0gIq4v3wv21tqMzy0jv7GwrlN2bqCnwMlX2NDup6FAIZMDvGbQUEqtor+STG
         IJA/Z1F74gnr077sv8eVoiWx0zpHHOAcnglZmBV4oTuyqCya3oEfvlDJ2ddRT/4oAbaB
         GGFbYEho0mCBN39QzXoiIhci/asGZKnDmYXmzpz90XeYT+3uPgcV9/bH+otphcAkAZbE
         oCjQ==
X-Gm-Message-State: AJcUukexaepN2P+EiQmj8WvGPzuP/5D27gMCgiRC2Z1bGftQDdwUl48I
        xXPAbisQft3RZQM6gf8PDzvZwbKNe/jyhQ==
X-Google-Smtp-Source: ALg8bN7mqoKQiOsb2WAqJ6DGUQ8jr6Te4CeoL5mDym674Xao19ig/KGBq4YHGSzRMedmhyjopdmoEQ==
X-Received: by 2002:a1c:2007:: with SMTP id g7mr12266919wmg.79.1547484124495;
        Mon, 14 Jan 2019 08:42:04 -0800 (PST)
Received: from localhost ([49.248.190.171])
        by smtp.gmail.com with ESMTPSA id k3sm110603159wrm.7.2019.01.14.08.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:42:03 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v1 07/10] cpufreq: mediatek: Use auto-registration of thermal cooling device
Date:   Mon, 14 Jan 2019 22:04:59 +0530
Message-Id: <a9e1ac5a60b5c99be1f90df822c5b02c4ab7fa13.1547481320.git.amit.kucheria@linaro.org>
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
 drivers/cpufreq/mediatek-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index eb8920d39818..9a937f4c63e7 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -14,7 +14,6 @@
 
 #include <linux/clk.h>
 #include <linux/cpu.h>
-#include <linux/cpu_cooling.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
 #include <linux/module.h>
@@ -48,7 +47,6 @@ struct mtk_cpu_dvfs_info {
 	struct regulator *sram_reg;
 	struct clk *cpu_clk;
 	struct clk *inter_clk;
-	struct thermal_cooling_device *cdev;
 	struct list_head list_head;
 	int intermediate_voltage;
 	bool need_voltage_tracking;
@@ -307,13 +305,6 @@ static int mtk_cpufreq_set_target(struct cpufreq_policy *policy,
 
 #define DYNAMIC_POWER "dynamic-power-coefficient"
 
-static void mtk_cpufreq_ready(struct cpufreq_policy *policy)
-{
-	struct mtk_cpu_dvfs_info *info = policy->driver_data;
-
-	info->cdev = of_cpufreq_cooling_register(policy);
-}
-
 static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
 {
 	struct device *cpu_dev;
@@ -472,7 +463,6 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct mtk_cpu_dvfs_info *info = policy->driver_data;
 
-	cpufreq_cooling_unregister(info->cdev);
 	dev_pm_opp_free_cpufreq_table(info->cpu_dev, &policy->freq_table);
 
 	return 0;
@@ -480,13 +470,13 @@ static int mtk_cpufreq_exit(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver mtk_cpufreq_driver = {
 	.flags = CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
+		 CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+		 CPUFREQ_AUTO_REGISTER_COOLING_DEV,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = mtk_cpufreq_set_target,
 	.get = cpufreq_generic_get,
 	.init = mtk_cpufreq_init,
 	.exit = mtk_cpufreq_exit,
-	.ready = mtk_cpufreq_ready,
 	.name = "mtk-cpufreq",
 	.attr = cpufreq_generic_attr,
 };
-- 
2.17.1

