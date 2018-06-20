Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2E6C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1568C20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pd+AU57/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1568C20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeFTR2F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:28:05 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36812 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754519AbeFTRWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:22:49 -0400
Received: by mail-lf0-f67.google.com with SMTP id n24-v6so485982lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LFPzDs1JucyTyUU9q3YaT4OD/JzXpPsipsDpCqXWAns=;
        b=Pd+AU57/ZbU9iVlM9eRTAuOn9GTqB6ot50bON6VCr0QtZEowyR6sePRKbj4JPhWgzu
         mTOhEKCczfF/p3cFIkRwIpRAdYi31j2ESbGBOYI7oXPX/eWp4DodDrcwp4lYr8MK2T8y
         mgxz3z+CuQXdsccOPAKsbsuwrNIXRQjLEj4F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LFPzDs1JucyTyUU9q3YaT4OD/JzXpPsipsDpCqXWAns=;
        b=GS86ZgdJaAU3I44WzuKCSOPgfseZRhc+KSjtJMklZ317exbnTgTVaEx6RB+fHkRVBy
         7E45JPTff23D6iu8WjN6WMJj+xFh3xHwbvVFw7NJZT2UzEix1V3rW6TBfeVGVOckb9SV
         JOobP4/McBC3sCwqvUOzOt4MDMCcScyKQ/xss+2JljIfV6CBrAxphfiQPqKDBPsqnxhd
         YYbnxKCH18qtBOw4P+SrOwYcKSRzknUQeLSWFLJf/q1IfIcNJIgfe4mqvNhKqt/Zodpk
         dfE0Wi+B7b0K77uJj7m70YI2g1fuGNin5h7EvY1VvjxAF5TihPNWObKClg+v0yOLsywP
         OztQ==
X-Gm-Message-State: APt69E1tnqiEigtP77+ip+OfrCBpmSo3jg9RibI607ZJjwhzutqyL5r5
        0L6yxgQbGa2G3pBWpGfFlSVCiw==
X-Google-Smtp-Source: ADUXVKIXzbzMOEIVwbTkD347j4lM5kxIzlrYLKIeVYq/rh6c3durBgY/IosyfyDugqxJq+GurWA87w==
X-Received: by 2002:a2e:c52:: with SMTP id o18-v6mr14820774ljd.72.1529515367664;
        Wed, 20 Jun 2018 10:22:47 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:22:46 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v8 07/26] PM / Domains: Add genpd governor for CPUs
Date:   Wed, 20 Jun 2018 19:22:07 +0200
Message-Id: <20180620172226.15012-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it's now perfectly possible that a PM domain managed by genpd contains
devices belonging to CPUs, we should start to take into account the
residency values for the idle states during the state selection process.
The residency value specifies the minimum duration of time, the CPU or a
group of CPUs, needs to spend in an idle state to not waste energy entering
it.

To deal with this, let's add a new genpd governor, pm_domain_cpu_gov, that
may be used for a PM domain that have CPU devices attached or if the CPUs
are attached through subdomains.

The new governor computes the minimum expected idle duration time for the
online CPUs being attached to the PM domain and its subdomains. Then in the
state selection process, trying the deepest state first, it verifies that
the idle duration time satisfies the state's residency value.

It should be noted that, when computing the minimum expected idle duration
time, we use the information from tick_nohz_get_next_wakeup(), to find the
next wakeup for the related CPUs. Future wise, this may deserve to be
improved, as there are more reasons to why a CPU may be woken up from idle.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain_governor.c | 58 ++++++++++++++++++++++++++++
 include/linux/pm_domain.h            |  2 +
 2 files changed, 60 insertions(+)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 99896fbf18e4..1aad55719537 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -10,6 +10,9 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/hrtimer.h>
+#include <linux/cpumask.h>
+#include <linux/ktime.h>
+#include <linux/tick.h>
 
 static int dev_update_qos_constraint(struct device *dev, void *data)
 {
@@ -245,6 +248,56 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
 	return false;
 }
 
+static bool cpu_power_down_ok(struct dev_pm_domain *pd)
+{
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	ktime_t domain_wakeup, cpu_wakeup;
+	s64 idle_duration_ns;
+	int cpu, i;
+
+	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
+		return true;
+
+	/*
+	 * Find the next wakeup for any of the online CPUs within the PM domain
+	 * and its subdomains. Note, we only need the genpd->cpus, as it already
+	 * contains a mask of all CPUs from subdomains.
+	 */
+	domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
+	for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
+		cpu_wakeup = tick_nohz_get_next_wakeup(cpu);
+		if (ktime_before(cpu_wakeup, domain_wakeup))
+			domain_wakeup = cpu_wakeup;
+	}
+
+	/* The minimum idle duration is from now - until the next wakeup. */
+	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, ktime_get()));
+
+	/*
+	 * Find the deepest idle state that has its residency value satisfied
+	 * and by also taking into account the power off latency for the state.
+	 * Start at the deepest supported state.
+	 */
+	i = genpd->state_count - 1;
+	do {
+		if (!genpd->states[i].residency_ns)
+			break;
+
+		/* Check idle_duration_ns >= 0 to compare signed/unsigned. */
+		if (idle_duration_ns >= 0 && idle_duration_ns >=
+		    (genpd->states[i].residency_ns +
+		     genpd->states[i].power_off_latency_ns))
+			break;
+		i--;
+	} while (i >= 0);
+
+	if (i < 0)
+		return false;
+
+	genpd->state_idx = i;
+	return true;
+}
+
 struct dev_power_governor simple_qos_governor = {
 	.suspend_ok = default_suspend_ok,
 	.power_down_ok = default_power_down_ok,
@@ -257,3 +310,8 @@ struct dev_power_governor pm_domain_always_on_gov = {
 	.power_down_ok = always_on_power_down_ok,
 	.suspend_ok = default_suspend_ok,
 };
+
+struct dev_power_governor pm_domain_cpu_gov = {
+	.suspend_ok = NULL,
+	.power_down_ok = cpu_power_down_ok,
+};
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 2c09cf80b285..97901c833108 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -160,6 +160,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
+extern struct dev_power_governor pm_domain_cpu_gov;
 #else
 
 static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
@@ -203,6 +204,7 @@ static inline int dev_pm_genpd_set_performance_state(struct device *dev,
 
 #define simple_qos_governor		(*(struct dev_power_governor *)(NULL))
 #define pm_domain_always_on_gov		(*(struct dev_power_governor *)(NULL))
+#define pm_domain_cpu_gov		(*(struct dev_power_governor *)(NULL))
 #endif
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_SLEEP
-- 
2.17.1

