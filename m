Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D50E206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cD1FRQJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfANQgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:36:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37083 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfANQgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:36:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so23655459wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=raje0KyJSfgQ1XlDTxNcMYQ5pbNyRq5aHVfsy61nUJY=;
        b=cD1FRQJ9YR5b0pY9h+iFZO5Qu66uT5l+f3/g0UlwezD4Nm21Mr0qEp89AKa8ZCsduo
         qnnMSZQEbjrf82PDdkpbDOvX+VURzTsa8nMTXJtSDk/ojD90Y2odKyIyd6wES5/N9zki
         qXNFRjl+o64wM5WEZ+3BYizUFbMV/ZZ056DnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=raje0KyJSfgQ1XlDTxNcMYQ5pbNyRq5aHVfsy61nUJY=;
        b=JXsa0SWmWVLbc3V4zoJXObKr7I2EDi9k8B04UqlxVcyknX5PNxmbiwJVyiABEob4ZC
         QRrX4KQ164fUUZ5i29ryyPGJl8LgBLGhQ+IT1+F64E0I7lEfVzMkws2bSre+xN+auDdY
         vXr56Zjua62GEH4S0ttZvqUqDt1aaUiQpIY4niCVspSHdH4I5E3mdaFHHWy5uTPC2Otv
         LrHVUKNLtfxQzBttAUpVyDgiJw6ENpStOTCtxbonrYnslI5CrOAsbHSYa7hNPY2gF6va
         UWHYqnO/kTlHP6Y9hN7q/AUwVLfJpPdr7il80Kyg3wKM2hOgCqOl9lshZKBYuMuXpCqM
         2Jew==
X-Gm-Message-State: AJcUukePfGr88Q0gZfJnXUTxnhi9fwkdyASSkhihq+8Hzdi01cD8VW/q
        4NM60Py5tqkYGPvZUZvReF5PBLm6ISsknw==
X-Google-Smtp-Source: ALg8bN4lij1dpdGV7bwphfErzCs7iI99p85Y4s5ruLqiJVtfgpNIKpU8D8YgvrCWFZckl9PQBDdsHQ==
X-Received: by 2002:adf:f091:: with SMTP id n17mr22754144wro.292.1547483791612;
        Mon, 14 Jan 2019 08:36:31 -0800 (PST)
Received: from localhost ([49.248.190.171])
        by smtp.gmail.com with ESMTPSA id o82sm26166937wmo.29.2019.01.14.08.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:36:30 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 02/10] cpufreq: Add a flag to auto-register a cooling device
Date:   Mon, 14 Jan 2019 22:04:54 +0530
Message-Id: <c1e460c49ad2f16b15ace909514a770c9753d1b1.1547481320.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All cpufreq drivers do similar things to register as a cooling device.
Provide a cpufreq driver flag so drivers can just ask the cpufreq core
to register the cooling device on their behalf. This allows us to get
rid of duplicated code in the drivers.

Suggested-by: Stephen Boyd <swboyd@chromium.org>
Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 17 +++++++++++++++++
 include/linux/cpufreq.h   |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6f23ebb395f1..cd6e750d3d82 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -30,6 +30,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/tick.h>
 #include <trace/events/power.h>
+#include <linux/cpu_cooling.h>
 
 static LIST_HEAD(cpufreq_policy_list);
 
@@ -1318,6 +1319,14 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
+#ifdef CONFIG_CPU_THERMAL
+	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
+		struct thermal_cooling_device **cdev = &policy->cooldev;
+
+		*cdev = of_cpufreq_cooling_register(policy);
+	}
+#endif
+
 	pr_debug("initialization complete\n");
 
 	return 0;
@@ -1411,6 +1420,14 @@ static int cpufreq_offline(unsigned int cpu)
 	if (has_target())
 		cpufreq_exit_governor(policy);
 
+#ifdef CONFIG_CPU_THERMAL
+	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
+		struct thermal_cooling_device **cdev = &policy->cooldev;
+
+		cpufreq_cooling_unregister(*cdev);
+	}
+#endif
+
 	/*
 	 * Perform the ->exit() even during light-weight tear-down,
 	 * since this is a core component, and is essential for the
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 7d0cf54125fa..70ad02088825 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -390,6 +390,12 @@ struct cpufreq_driver {
  */
 #define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING (1 << 6)
 
+/*
+ * Set by drivers that want the core to automatically register the cpufreq
+ * driver as a thermal cooling device
+ */
+#define CPUFREQ_AUTO_REGISTER_COOLING_DEV (1 << 7)
+
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
-- 
2.17.1

