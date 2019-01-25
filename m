Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F803C282C6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40CE2184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2cWSkuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbfAYHDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:03:06 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45624 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbfAYHDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:03:06 -0500
Received: by mail-ed1-f67.google.com with SMTP id d39so6533565edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 23:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=y3EtZ9Zijh6g5b1BdvkqodqbkDXmOjJfZ/0yd7HhXeE=;
        b=N2cWSkuYkCEV0DFcML/0FcxMJLPso61+fkMzVT4Mqvd8kb07HlBv8CLzu9f9ruMTv5
         rSVlVyo2UkXWTulTswVoSQNxgTbRyTapa+rDEU5RX/XV+04+5n7JQYPprzmadmUKbI2M
         9fWlg7Z52z/ym4NaMQxg0kyDQFUH0twFyEWfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=y3EtZ9Zijh6g5b1BdvkqodqbkDXmOjJfZ/0yd7HhXeE=;
        b=TyigXdZv9Om6jMcToLC3LJt22scDiyidCxFjc+rH+jIPI54z8fg8lzEJKhgRc00ACi
         Hg6KneycELwvodAhqhugKif+p1FiHAU3icTOqWQC7dphnF2XZMO/w2qwMaIna22LEyRR
         9jApJxvl4CrUxPBL/tQpKf8GpbzdLSVDg/na71yqRhj1Hc8h1AaKOctNUl22Uxwmeqa9
         VQN2VESskc9XAyl0XR0HQvD/OMJocgNo6E9BuMBq5n81fHREl8UxNRfdFmDnJyg3iarU
         ux1EvB5CuqJ2gMZn6MFjHHduBnHmReMvyVYMowNO4xIkU16Qwszl4U+V2AsY6jYFAqml
         OVqA==
X-Gm-Message-State: AJcUukeMaBekOKAiu49QXY9gshhtq67BgvCEctzIBRLf/D+mrVeHPvAA
        osnBqlssDfgwAt3rUgtvhPl7y91vEGU=
X-Google-Smtp-Source: ALg8bN4sKteL+WrlNuVtIG46p+TIOxBSxKJQbKpCRz2eFHDbSQ06sY6Y2/E0i1xj2bJHoxwN2sKdmw==
X-Received: by 2002:a50:de88:: with SMTP id c8mr9572635edl.129.1548399783664;
        Thu, 24 Jan 2019 23:03:03 -0800 (PST)
Received: from localhost ([49.248.181.51])
        by smtp.gmail.com with ESMTPSA id h47sm11808656eda.8.2019.01.24.23.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 23:03:03 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCHv3 2/9] cpufreq: Auto-register the driver as a thermal cooling device if asked
Date:   Fri, 25 Jan 2019 12:32:22 +0530
Message-Id: <73e091e2d56d9fa6eb94feaed9fc2be30bf6da20.1548398851.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548398851.git.amit.kucheria@linaro.org>
References: <cover.1548398851.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548398851.git.amit.kucheria@linaro.org>
References: <cover.1548398851.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All cpufreq drivers do similar things to register as a cooling device.
Provide a cpufreq driver flag so drivers can just ask the cpufreq core
to register the cooling device on their behalf. This allows us to get
rid of duplicated code in the drivers.

In order to allow this, we add a struct thermal_cooling_device pointer
to struct cpufreq_policy so that drivers don't need to store it in a
private data structure.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/cpufreq/cpufreq.c |  6 ++++++
 include/linux/cpufreq.h   | 21 +++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e35a886e00bc..cf1be057caf4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1318,6 +1318,9 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
+	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV)
+		register_cooling_device(policy);
+
 	pr_debug("initialization complete\n");
 
 	return 0;
@@ -1405,6 +1408,9 @@ static int cpufreq_offline(unsigned int cpu)
 		goto unlock;
 	}
 
+	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV)
+		unregister_cooling_device(policy);
+
 	if (cpufreq_driver->stop_cpu)
 		cpufreq_driver->stop_cpu(policy);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index bd7fbd6a4478..c7eb59b8ce94 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -13,6 +13,7 @@
 
 #include <linux/clk.h>
 #include <linux/cpumask.h>
+#include <linux/cpu_cooling.h>
 #include <linux/completion.h>
 #include <linux/kobject.h>
 #include <linux/notifier.h>
@@ -151,6 +152,9 @@ struct cpufreq_policy {
 
 	/* For cpufreq driver's internal use */
 	void			*driver_data;
+
+	/* Pointer to the cooling device if used for thermal mitigation */
+	struct thermal_cooling_device *cdev;
 };
 
 /* Only for ACPI */
@@ -386,6 +390,12 @@ struct cpufreq_driver {
  */
 #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	BIT(6)
 
+/*
+ * Set by drivers that want the core to automatically register the cpufreq
+ * driver as a thermal cooling device.
+ */
+#define CPUFREQ_AUTO_REGISTER_COOLING_DEV	BIT(7)
+
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
@@ -415,6 +425,17 @@ cpufreq_verify_within_cpu_limits(struct cpufreq_policy *policy)
 			policy->cpuinfo.max_freq);
 }
 
+static inline void register_cooling_device(struct cpufreq_policy *policy)
+{
+	policy->cdev = of_cpufreq_cooling_register(policy);
+}
+
+static inline void unregister_cooling_device(struct cpufreq_policy *policy)
+{
+	cpufreq_cooling_unregister(policy->cdev);
+	policy->cdev = NULL;
+}
+
 #ifdef CONFIG_CPU_FREQ
 void cpufreq_suspend(void);
 void cpufreq_resume(void);
-- 
2.17.1

