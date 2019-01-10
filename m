Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4D1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDCB2173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="esoDudYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfAJAB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:01:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35942 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbfAJABY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:01:24 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so9465528wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=PI9R955mUdxl9wa+5VxK6ncJI/NHFyvZwL7fY0NRhzM=;
        b=esoDudYYCO44v0DxqBUshEhDqpTRIzcw4JL/wu5ynj7Qfp3tSrwtEcdG6JBmCvY3JH
         K0oyxh/OO7NysHSsQhKVRI46Tz3XtGLc5ojoTiGRZSv4E1Yhxh6S0icVMw2I1QnoVIam
         T59rYFPVhXYqko3aJvEQpGKjmsWehCpuN1cm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=PI9R955mUdxl9wa+5VxK6ncJI/NHFyvZwL7fY0NRhzM=;
        b=JZnU+aGHhGNfUFXEanp0Cc0XKoDbI1Pnngm4ZSrPvQEpajjdtxMA8H8/5QKkfQVxgt
         BKZmle2HbaNcSi036yDpCuRSh3/BCVFypv5kMIyI+2Th32bISpJL/RlOj/Ivig2cBnt4
         1a+ii27U5cOBTKhQG6zaidTAoeJMYpODAg6j7YI0SUBb9l+tq25f5q2IUxK7O9IeoMBq
         bh3EH8W3LNRQjfViIRgSPL5Jnoz15SVyykEwd/PmUlJTYUEHD+WVOk44pBfMX7eUVvOF
         u+twKUWqvnP+wBvdYtIKegg9wkyQoxrENue//V+AX5JF8/vS/Cng2KyiEfsJfjipbQ4s
         pxuw==
X-Gm-Message-State: AJcUukda8l2iQDbGOFhF0lGfb1uMjzTfb9c8/9cErlw/i4ega98cEU9W
        /7kZ9yiNwXw8JnmMgcjWIUBEbZ1MfFg=
X-Google-Smtp-Source: ALg8bN5YgYl9J2Wc3EhEGkkAT18VbmVlAbTNNhZEcKVZ8Ac2a8B8ec69BE+Fkz4yl4lRVBHhFWhoEA==
X-Received: by 2002:adf:d1d2:: with SMTP id m18mr7129620wri.138.1547078482542;
        Wed, 09 Jan 2019 16:01:22 -0800 (PST)
Received: from localhost ([49.248.171.190])
        by smtp.gmail.com with ESMTPSA id o64sm12316497wmo.47.2019.01.09.16.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 16:01:21 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org (open list:THERMAL/CPU_COOLING)
Subject: [PATCH v1 3/7] cpu_cooling: Add generic driver ready callback
Date:   Thu, 10 Jan 2019 05:30:52 +0530
Message-Id: <9cccfabf22ccae92dfd31175b57baab3206eac0d.1547078153.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All cpufreq drivers do similar things to register as a cooling device.
Provide a generic call back so we can get rid of duplicated code in the
drivers.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Suggested-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/thermal/cpu_cooling.c | 18 ++++++++++++++++++
 include/linux/cpu_cooling.h   |  9 +++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index dfd23245f778..5154ffc12332 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -694,6 +694,7 @@ __cpufreq_cooling_register(struct device_node *np,
 
 	cpufreq_cdev->clipped_freq = cpufreq_cdev->freq_table[0].frequency;
 	cpufreq_cdev->cdev = cdev;
+	policy->cooldev = cdev;
 
 	mutex_lock(&cooling_list_lock);
 	/* Register the notifier for first cpufreq cooling device */
@@ -785,6 +786,23 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 }
 EXPORT_SYMBOL_GPL(of_cpufreq_cooling_register);
 
+/**
+ * generic_cpufreq_ready - generic driver callback to register a thermal_cooling_device
+ * @policy: cpufreq policy
+ */
+void generic_cpufreq_ready(struct cpufreq_policy *policy)
+{
+	struct thermal_cooling_device **cdev = &policy->cooldev;
+
+	*cdev = of_cpufreq_cooling_register(policy);
+	if (IS_ERR(*cdev)) {
+		pr_err("Failed to register cpufreq cooling device for CPU%d: %ld\n",
+		       policy->cpu, PTR_ERR(cdev));
+		cdev = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(generic_cpufreq_ready);
+
 /**
  * cpufreq_cooling_unregister - function to remove cpufreq cooling device.
  * @cdev: thermal cooling device pointer.
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index de0dafb9399d..d7815bb2967a 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -65,12 +65,21 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
  */
 struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct cpufreq_policy *policy);
+
+/**
+ * generic_cpufreq_ready - generic driver callback to register a thermal_cooling_device
+ * @policy: cpufreq policy
+ */
+void generic_cpufreq_ready(struct cpufreq_policy *policy);
 #else
 static inline struct thermal_cooling_device *
 of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
 	return NULL;
 }
+
+void generic_cpufreq_ready(struct cpufreq_policy *policy) {}
+
 #endif /* defined(CONFIG_THERMAL_OF) && defined(CONFIG_CPU_THERMAL) */
 
 #endif /* __CPU_COOLING_H__ */
-- 
2.17.1

