Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81073C46462
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B24821104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6m0EYyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B24821104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731110AbeK3Ex6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:53:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40732 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731082AbeK3Ex4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:53:56 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18-v6so2524281lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3t2vyFxKLnIeRsykykXv6/9Q0Qsu6Nz8v2F0owXov5U=;
        b=E6m0EYylUq2Ibxx2zDTr+getdoAXAblt6NGSV5xnZi+anl5A9e/0htj8QZMpMF512l
         AiV1KScgBl/lv5TQptuE8nTGJrfWqH+rbUj9OP94f7ViYYpIkOCdbPfmx5cVlgvm0xTc
         KI2xBQgpTUrEt020geOSiKICiHi1PKWxfnZGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3t2vyFxKLnIeRsykykXv6/9Q0Qsu6Nz8v2F0owXov5U=;
        b=htDPgovkAXNGHRtbV0MjtEIAPjt+pTcAlqIs21S3ts7DlRs9WeYhKR6MQmbC/BguGM
         Tlj+mYV4gV1w20PDaS+LutVI9KYN2a2bmDhELMtfhucCNqLh9kextIgNgvGocsWzUq0W
         JVbnRs0twYN3rp3LJ8gviHHSdG4krOrcacn2rcWckWMcJyTrg+THCEZPFlarzOTT06fd
         vfqAwm39LaV7s2ZTCNd2oJwp7YF+AbhH04AZHvZSHJKI5CbdO+qUQ1kUZl5bLp8Ax5sA
         WwozhOMC+BPhKA7CqZSuFJQEgeBEx9brx0DjF9ZRgRUVjkejDQcYDnWrXZVrLuw8Mtz7
         iHlw==
X-Gm-Message-State: AA+aEWYhQQyRSZrnBMGPP1dYwiONZUwEyrj/WJWoiLVVCE1+7IvPjR9W
        LypE8sGKeUlMGB7ej03OEVLfNQ==
X-Google-Smtp-Source: AFSGD/UWoMttAcw7++cNF/9mzFJwLwWDB8IZ1w4ykCERuAaM1HAR5F/wdmCVK3YlklPIHBfdzF9PKg==
X-Received: by 2002:a2e:1551:: with SMTP id 17-v6mr1736107ljv.68.1543513665097;
        Thu, 29 Nov 2018 09:47:45 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:47:44 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 21/27] drivers: firmware: psci: Add a helper to attach a CPU to its PM domain
Date:   Thu, 29 Nov 2018 18:46:54 +0100
Message-Id: <20181129174700.16585-22-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new PSCI DT helper function, psci_dt_attach_cpu(), which takes
a CPU number as an in-parameter and attaches the CPU's struct device to its
corresponding PM domain. Additionally, the helper prepares the CPU to be
power managed via runtime PM, which is the last step needed to enable the
interaction with the PM domain through the runtime PM callbacks.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- New patch: Replaces "PM / Domains: Add helper functions to
	  attach/detach CPUs to/from genpd".

---
 drivers/firmware/psci/psci.h           |  1 +
 drivers/firmware/psci/psci_pm_domain.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
index 05af462cc96e..fbc9980dee69 100644
--- a/drivers/firmware/psci/psci.h
+++ b/drivers/firmware/psci/psci.h
@@ -15,6 +15,7 @@ int psci_dt_parse_state_node(struct device_node *np, u32 *state);
 int psci_dt_init_pm_domains(struct device_node *np);
 int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
 			struct device_node *cpu_node, u32 *psci_states);
+int psci_dt_attach_cpu(int cpu);
 #else
 static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
 #endif
diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
index 6c9d6a644c7f..b0fa7da8a0ce 100644
--- a/drivers/firmware/psci/psci_pm_domain.c
+++ b/drivers/firmware/psci/psci_pm_domain.c
@@ -12,8 +12,10 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 
@@ -367,4 +369,21 @@ int psci_dt_pm_domains_parse_states(struct cpuidle_driver *drv,
 
 	return 0;
 }
+
+int psci_dt_attach_cpu(int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+	int ret;
+
+	ret = dev_pm_domain_attach(dev, true);
+	if (ret)
+		return ret;
+
+	pm_runtime_irq_safe(dev);
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+}
 #endif
-- 
2.17.1

