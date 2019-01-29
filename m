Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E674C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5857020989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dugmhw/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfA2E5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:57:07 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38501 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfA2E5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:57:05 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so20484458wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 20:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sZDXlqnH1fj24jYunxEgKg9iTnvnCWnhkKzCRQGaUNw=;
        b=dugmhw/6jrlx3hZh1S8+lDNGcaaJeEyKdpTAzYFvj8MdrXX4cbJ3LjAFvmxbXv8uZ8
         g9U5qD6kTDf3N4N6p8Hcs7tc3njH1J/2iEOUb0orpv05Rh3NApFy5MlBQ4Ob/0CSEke6
         l+D7RrxUcRxzO3v8QXFelqrncmWReP2gkECOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sZDXlqnH1fj24jYunxEgKg9iTnvnCWnhkKzCRQGaUNw=;
        b=kdLlTNuw7J20H9jXZ+Fkz5/eIRN/3VBLBVMhDNXolEaTKuxUo/AGsXdGAN/sNa5Rnt
         JmJ6jspKGAfCdES9K0q4pSMEIdN8VJsdsFthbB2oeJpViw3HLPLQZOFzvubiFx84rJKT
         J9NiZtytcM9hWeuEpbNrK/jsWvjWdheoZfLnvsD73X5LTY2VPsCMmUWEhE/3fBBkyT1y
         GOxCxs6U7osHqOwb0ceET2+VWAlX/P4SHod6YxW+HH/ECZHwfhlHPoZSdbse9NKI/M82
         rG5B3KjhaXU3D/9SDmkItqhObDEnMEjyJoQY9eYt5gmVZ7Rs8GDzHXmJwhzf09WMz0a0
         lRoA==
X-Gm-Message-State: AJcUukfPh4i4RA333PrYuYKHVjkE3RPVZKV4rtjEE+YwYRS/8PE3vYzp
        7iKMVesP3cPRKUiF9Np+M5nclKeeZrI=
X-Google-Smtp-Source: ALg8bN6rADYXi8OMLUCoGILKf6XcipnreE8/8jl+8XUgRm1fLCTN9DegTfzFWe4xzgRJoN4xSZ852w==
X-Received: by 2002:adf:db01:: with SMTP id s1mr23650280wri.214.1548737823567;
        Mon, 28 Jan 2019 20:57:03 -0800 (PST)
Received: from localhost ([49.248.171.30])
        by smtp.gmail.com with ESMTPSA id 127sm2512264wmm.45.2019.01.28.20.57.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 20:57:03 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org
Subject: [PATCH v5 2/9] cpufreq: Auto-register the driver as a thermal cooling device if asked
Date:   Tue, 29 Jan 2019 10:25:08 +0530
Message-Id: <6077cb33d7e078bb0e85776bad99fdb476f16d0c.1548737236.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
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
 drivers/cpufreq/cpufreq.c | 13 +++++++++++++
 include/linux/cpufreq.h   |  9 +++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e35a886e00bc..0f9b50d3ee91 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -19,6 +19,7 @@
 
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
+#include <linux/cpu_cooling.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/init.h>
@@ -1318,6 +1319,11 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
+#if IS_ENABLED(CONFIG_CPU_THERMAL)
+	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV)
+		policy->cdev = of_cpufreq_cooling_register(policy);
+#endif
+
 	pr_debug("initialization complete\n");
 
 	return 0;
@@ -1405,6 +1411,13 @@ static int cpufreq_offline(unsigned int cpu)
 		goto unlock;
 	}
 
+#if IS_ENABLED(CONFIG_CPU_THERMAL)
+	if (cpufreq_driver->flags & CPUFREQ_IS_COOLING_DEV) {
+		cpufreq_cooling_unregister(policy->cdev);
+		policy->cdev = NULL;
+	}
+#endif
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

