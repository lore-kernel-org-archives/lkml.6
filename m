Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B58C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA71420989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 05:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7FnZhOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfA3FXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 00:23:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51439 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfA3FXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 00:23:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so20254860wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 21:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KYtdcEevpvsnz88eyRbC1DhXZ6geGX3oBRAEz2mkjYw=;
        b=R7FnZhOVZwEEd353wxUYyscVFniL5IleRoug3w/Qw/A0MwHJxGcXxM6+jMiYk+C8we
         6ldcORE0fEtyeiAbkJU3+IgydQg2chw29bTSbUzGtqWC1N9EelBy6A1quIY9Ysyprv3n
         i7hQYE+kQTQLnA9iNGidqcF6zggweUkJtaaCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KYtdcEevpvsnz88eyRbC1DhXZ6geGX3oBRAEz2mkjYw=;
        b=I55HqAuXV04BtAQkFDW07RghMxOMwMTiPEBrpMbfe32JVHHvtEkUR3GAYcwRzVxqNl
         GzyHpS/7ZT4yYqi5EzQBD8lDKVLaVC+OqU9yOwdy2FgZRByvYrCWVbDWOxgM1XWw0MnT
         3b9Pr9nTQRgygF0TaHXc3wEa1VHffTHNxKRunpVrMR/ihXZvN+oCAPP21rhRU8ILTPCQ
         lNq4OnYVZ8qIxHkxNV2QDLAJJ6+dyZRIHcpgD+4GW6ZKeGNjbkshCG/GFp2DT7S0rry1
         +7prLVnLCEn2qML3bTRrxaIQLSCSqNzvDAK69gVKqiEI0l6OUsU+kJfIxxdX8XgHl3Yj
         r9fQ==
X-Gm-Message-State: AJcUukc8iUG3kuOrEBi8TayXx6GpdFYWVOPc3w7Njcjjq3rRGQbTlRYn
        3+coiZuqwrtye0wOzBMTcmE9jRhKzSo=
X-Google-Smtp-Source: ALg8bN7QgaKnNKHvJps8+D7M7w/s6ekFpo2c6uZ6jKo97a5LxgriUrzZE7NJmUWp/Y2K42M8zA2foA==
X-Received: by 2002:a1c:d082:: with SMTP id h124mr22282008wmg.21.1548825779050;
        Tue, 29 Jan 2019 21:22:59 -0800 (PST)
Received: from localhost ([49.248.191.175])
        by smtp.gmail.com with ESMTPSA id t18sm855135wmd.40.2019.01.29.21.22.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 21:22:58 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: Auto-register the driver as a thermal cooling device if asked
Date:   Wed, 30 Jan 2019 10:52:01 +0530
Message-Id: <fdff26d908c5338df44574085701ed93a64af079.1548825443.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJZ5v0iwq15mwoa-LBN07fgNNurtBGodG6urgfnvMbGWj8vyAw@mail.gmail.com>
References: <CAJZ5v0iwq15mwoa-LBN07fgNNurtBGodG6urgfnvMbGWj8vyAw@mail.gmail.com>
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 11 +++++++++++
 include/linux/cpufreq.h   |  9 +++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a8fa684f5f90..cae730264bc0 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -19,6 +19,7 @@
 
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpu_cooling.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/init.h>
@@ -1316,6 +1317,10 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
+	if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
+	    cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
+		policy->cdev = of_cpufreq_cooling_register(policy);
+
 	pr_debug("initialization complete\n");
 
 	return 0;
@@ -1403,6 +1408,12 @@ static int cpufreq_offline(unsigned int cpu)
 		goto unlock;
 	}
 
+	if (IS_ENABLED(CONFIG_CPU_THERMAL) &&
+	    cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
+		cpufreq_cooling_unregister(policy->cdev);
+		policy->cdev = NULL;
+	}
+
 	if (cpufreq_driver->stop_cpu)
 		cpufreq_driver->stop_cpu(policy);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index bd7fbd6a4478..6078eb07a7e4 100644
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
+#define CPUFREQ_IS_COOLING_DEV			BIT(7)
+
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
 
-- 
2.17.1

