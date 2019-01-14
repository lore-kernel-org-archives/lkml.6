Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C29C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E5F20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KAd62fxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfANKVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:21:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43680 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfANKVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:21:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so22138460wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=BQcigTwmLx6wtNJkbza+fNndqo6R5swIJwwOJw4wxh8=;
        b=KAd62fxQUgm/bVgOmDp0tmRdPoWBzID9XmJsxzsC2JFZ9SX6MqJWIDvc4/SeJBQCpW
         SbqHlojaHVqFxQtORtMCHZM1W70Tw0wKJYdJ8vUud0iVkiHw+86Qtkip9OWXRfy+hFjG
         /ZuzduBHyvGE512CYtsrGQX3jvjPawx7+9L8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=BQcigTwmLx6wtNJkbza+fNndqo6R5swIJwwOJw4wxh8=;
        b=X7WTKwBRM/eN2LojnT1mA59pV1lXCNWAQanTT3Uz6eLRloUBAjorhhsVe5Wy9F3rLi
         Fljf4Cmatwwgn3dQVlKQEyYts+LWU5da4pMCp0TP+Fht+Nzwvaz6y0T0TbBZCzFTxgHJ
         kaeahApzZSgFbd62gb1H/4E6nb03GE/FD6PGk0ck6os6CGXagyix4VikZ1j4Zksw4zjw
         iaJUUmx25vOcwXQc/ypSjbIwmOhXw+kmSdc9uGmrA1mbvmOM43fiGI56IByDz74o5Enn
         hInP89x5vzedAQnXHKq3LFbOsOjev63XEy+Dt4mDN0dAqtwkjzpOOpOfRBiVgA4dfDOc
         PjRw==
X-Gm-Message-State: AJcUukfhnAMVFsZZSoctrWIe25UCZ5y7E2ZFRIA87aQjaigx1W3CZNyk
        DBM4el/Uyb2MRbQ1q6kfeYOTaRj52yU=
X-Google-Smtp-Source: ALg8bN69Go2+pxt6FFFKDw+cPKMZ1Vvb4sVEz9b8dF3kodNwhQepsPc/0+exXf4o9bUxL/qLbXYbxw==
X-Received: by 2002:adf:97d1:: with SMTP id t17mr23797843wrb.283.1547461303153;
        Mon, 14 Jan 2019 02:21:43 -0800 (PST)
Received: from localhost ([49.248.81.155])
        by smtp.gmail.com with ESMTPSA id f130sm26226842wme.41.2019.01.14.02.21.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 02:21:42 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY DRIVERS)
Subject: [PATCH v2 4/9] cpufreq: Add a flag to auto-register a cooling device
Date:   Mon, 14 Jan 2019 15:51:06 +0530
Message-Id: <e195496f42375259f1b202eae39d20a56725f4a7.1547458732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
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
 drivers/cpufreq/cpufreq.c | 13 +++++++++++++
 include/linux/cpufreq.h   |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6f23ebb395f1..7faebfc61e60 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -30,6 +30,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/tick.h>
 #include <trace/events/power.h>
+#include <linux/cpu_cooling.h>
 
 static LIST_HEAD(cpufreq_policy_list);
 
@@ -1318,6 +1319,12 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
+	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
+		struct thermal_cooling_device **cdev = &policy->cooldev;
+
+		*cdev = of_cpufreq_cooling_register(policy);
+	}
+
 	pr_debug("initialization complete\n");
 
 	return 0;
@@ -1411,6 +1418,12 @@ static int cpufreq_offline(unsigned int cpu)
 	if (has_target())
 		cpufreq_exit_governor(policy);
 
+	if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
+		struct thermal_cooling_device **cdev = &policy->cooldev;
+
+		cpufreq_cooling_unregister(*cdev);
+	}
+
 	/*
 	 * Perform the ->exit() even during light-weight tear-down,
 	 * since this is a core component, and is essential for the
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 9fbc1d996967..0c51d5ce7350 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -388,6 +388,12 @@ struct cpufreq_driver {
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

