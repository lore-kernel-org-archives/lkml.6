Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87A8C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91ED820989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OIQOgBgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfA2E7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:59:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50441 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfA2E7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:59:10 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so16342773wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 20:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vcvqDibFD4J+UsvLzl4IPLt3+45i56JFsvwQyIv7Ies=;
        b=OIQOgBgIYGQMD5MsHLsxxua0J6GIoPteH87r+Nqm3iXi33wmq5/SA3xu6C8XWZeUE8
         5BEPB+ixLyvmyN1VSzTniLJcAQ+MjLrbckzu2gqa6qKrt5+DdT5GzOYGwqFuuE/b8D9+
         9tSK6SeE3Z0bHjhe2bBP4bRqYLweIzNozPMnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vcvqDibFD4J+UsvLzl4IPLt3+45i56JFsvwQyIv7Ies=;
        b=iRXNJI71yruw3CfMnrtYYD0Ho0qUo6NieIH5lhR4KVSDJrVgE34CON7fD1d5ddQkgT
         6pbhDQbmUHrH7PrvOyKxKDv7O1YtYAauWgXc2vA2g9m3gOLBMwP0dXBoLyS7p74/eHch
         fRUnS8Ltk35Qm2ApjVOrT6aer6BAz2ioyDy90qIqUhmJHssXGfX/XUr0wJvxZ+QWz20H
         n43pJTIyXRsIDDAa65Oc7m5cvLX6BI++PPHWmTtb+t223OvgRU6fda/fShO9cvW5z4IE
         wqqwl5Ii1sHYXNSJ5wueMlLU7tlVTNMvnJxs7yxXwvAN9mIx6mKylWFhF1YLfkiwu+vW
         2cyQ==
X-Gm-Message-State: AJcUukdOD3eD7YxEbgvrE637pQRkV17FZFmSaenjD0jA2DngQAZsfqVK
        1UJLmuvcCBZL9FTzzp2TcmTnDv+MP8Y=
X-Google-Smtp-Source: ALg8bN6bI6kCxC4BqxUEiUgTYI6W6CiLIOnshiFU+e/0Ybp+o8c7bUzIrCsxiftfkgC9xU9EH8URjQ==
X-Received: by 2002:a1c:7dd6:: with SMTP id y205mr7116773wmc.121.1548737948077;
        Mon, 28 Jan 2019 20:59:08 -0800 (PST)
Received: from localhost ([49.248.171.30])
        by smtp.gmail.com with ESMTPSA id n127sm1733195wmd.20.2019.01.28.20.59.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 20:59:07 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: [PATCH v5 9/9] cpufreq: scpi: Use auto-registration of thermal cooling device
Date:   Tue, 29 Jan 2019 10:25:15 +0530
Message-Id: <082a9bae988061ea5465f7cdb4b0c61b4230cd59.1548737236.git.amit.kucheria@linaro.org>
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
 drivers/cpufreq/scpi-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 99449738faa4..1db2f6927e13 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -22,7 +22,6 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
-#include <linux/cpu_cooling.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
@@ -34,7 +33,6 @@
 struct scpi_data {
 	struct clk *clk;
 	struct device *cpu_dev;
-	struct thermal_cooling_device *cdev;
 };
 
 static struct scpi_ops *scpi_ops;
@@ -186,7 +184,6 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct scpi_data *priv = policy->driver_data;
 
-	cpufreq_cooling_unregister(priv->cdev);
 	clk_put(priv->clk);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
 	kfree(priv);
@@ -195,23 +192,16 @@ static int scpi_cpufreq_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void scpi_cpufreq_ready(struct cpufreq_policy *policy)
-{
-	struct scpi_data *priv = policy->driver_data;
-
-	priv->cdev = of_cpufreq_cooling_register(policy);
-}
-
 static struct cpufreq_driver scpi_cpufreq_driver = {
 	.name	= "scpi-cpufreq",
 	.flags	= CPUFREQ_STICKY | CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
-		  CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+		  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+		  CPUFREQ_IS_COOLING_DEV,
 	.verify	= cpufreq_generic_frequency_table_verify,
 	.attr	= cpufreq_generic_attr,
 	.get	= scpi_cpufreq_get_rate,
 	.init	= scpi_cpufreq_init,
 	.exit	= scpi_cpufreq_exit,
-	.ready	= scpi_cpufreq_ready,
 	.target_index	= scpi_cpufreq_set_target,
 };
 
-- 
2.17.1

