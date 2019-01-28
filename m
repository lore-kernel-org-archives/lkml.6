Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9E8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385B72148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WaHCrlaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfA1Gog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:44:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53488 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfA1Gog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:44:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so12680607wmb.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 22:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=AMCeOi6x/Wbey9b/NaGjqvsuxi1tHtv0yD2YjLVBzzg=;
        b=WaHCrlaGNbIsQJL0PrjX/7IJwbxZdCo2c8Mn+7HRrFaoXNP38bwLNLaVldVR4W82KY
         jreY6JsHG3DN5l1yGSxfK+sur+J+dPFd6Amt15bQLyktwFianXBJq6qqMQRL/Trx7eei
         CgYnHmXSfl1pJut+G8OW/CqBrNXUv+88MVvu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=AMCeOi6x/Wbey9b/NaGjqvsuxi1tHtv0yD2YjLVBzzg=;
        b=pmUsVdGDacjURQWSL0mVxN/Wo07l+HZYtm3MAy4mg/qhi9dZfNCWZhALLisX2Qhis6
         h/3Ah9CeTN3EhDlswiddh2EHcr4N16BwQ8g08SauA8tAJcXeKxIqWyNfoLWCFpZzAlFj
         9jadS6S8k7gmO987iIl1E9cOJ35cgopJHc+DGsKCrSistAS0LZmu7hCrzOSY+nXARZZl
         93avYdBOowfgEp6V3eDndKvYTWvH7KVm4vkjXz3ICDtPBBO+TvYj9WtLOT13FAUOnesM
         Ajs+KNjGIPBcyKzNMW3qW2mDcgivBsGippYpVuFHU3DOg3ie6EpxzlDSfFyFzYMnK2oa
         4MJQ==
X-Gm-Message-State: AJcUukdXMCdhrGvrNl9zt0KbpNuHDVtF8yFFyNAsZRUiYr6nFib/XGID
        FTwHqUNdt1eXghLIe+6w0MzlQF5+1AU=
X-Google-Smtp-Source: ALg8bN5Wvjx1F+naYZJm/iwOdzuhg0HggwipHSLNru++54o302CYiDCc10iccuEjPJ616/m52h3HMw==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr15097321wmd.63.1548657872657;
        Sun, 27 Jan 2019 22:44:32 -0800 (PST)
Received: from localhost ([49.248.191.44])
        by smtp.gmail.com with ESMTPSA id h13sm95586448wrp.61.2019.01.27.22.44.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 22:44:32 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tao Wang <kevin.wangtao@hisilicon.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org
Subject: [PATCH v4 2/9] cpufreq: Auto-register the driver as a thermal cooling device if asked
Date:   Mon, 28 Jan 2019 12:11:27 +0530
Message-Id: <f6f09e5af6fe78fc27cbdc53a8dc688c6b4124b7.1548654899.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548654899.git.amit.kucheria@linaro.org>
References: <cover.1548654899.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548654899.git.amit.kucheria@linaro.org>
References: <cover.1548654899.git.amit.kucheria@linaro.org>
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
 drivers/cpufreq/cpufreq.c | 9 +++++++++
 include/linux/cpufreq.h   | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e35a886e00bc..29ed78b0b77b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -19,6 +19,7 @@
 
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpu_cooling.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/init.h>
@@ -1318,6 +1319,9 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
+	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV)
+		policy->cdev = of_cpufreq_cooling_register(policy);
+
 	pr_debug("initialization complete\n");
 
 	return 0;
@@ -1405,6 +1409,11 @@ static int cpufreq_offline(unsigned int cpu)
 		goto unlock;
 	}
 
+	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
+		cpufreq_cooling_unregister(policy->cdev);
+		policy->cdev = NULL;
+	}
+
 	if (cpufreq_driver->stop_cpu)
 		cpufreq_driver->stop_cpu(policy);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index bd7fbd6a4478..55ca61a64fc2 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -151,6 +151,9 @@ struct cpufreq_policy {
 
 	/* For cpufreq driver's internal use */
 	void			*driver_data;
+
+	/* Pointer to the cooling device if used for thermal mitigation */
+	struct thermal_cooling_device *cdev;
 };
 
 /* Only for ACPI */
@@ -386,6 +389,12 @@ struct cpufreq_driver {
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
 
-- 
2.17.1

