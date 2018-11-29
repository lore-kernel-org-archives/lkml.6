Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E091C46464
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070E12146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKE3qxiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070E12146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbeK3EyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:54:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45499 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731113AbeK3EyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:54:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id s5-v6so2509300ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=00sBAXywF3WZULK8cp3GDi0TaSy7ngQJNGllHojB6lk=;
        b=dKE3qxiTNFTTGb5T+hiqrOqJFim4aiRChTUuNwS2xw3/dZuh9DAHSNXaDLW74AS3pg
         lqi8hr2A4WN5tItntkMx4nEIWt69NUtA+5ATJ2GbhiBDjsUni1YWaOPqKXDu+4lgVcZ6
         8HF0CsduMwAzz1Xj7pFRsv+e/Vp0FqO7xL5UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=00sBAXywF3WZULK8cp3GDi0TaSy7ngQJNGllHojB6lk=;
        b=KA23p/aEV/NrrZxwK38fdRMrt0RWS1qF+PR3cVtkQSyGHzye9O1j6DfqsRN5Z44A4p
         i0FcsJuZwdp5DqJAJH64Y26oAAqAp0pOwxkZIW0x/dtY1MDtX6+UAzuCey4rmN2caYRq
         kD11sAuvIGX1ENRKT538uQPmj8hftbfWuRcjMHRfoDtmgMQcwZkZJoYW7S6u9ipsn/vw
         TP7sKrD37Zs0T/SZcpvqXMPzGwaa7krVJueo/DX4d0kz0BUpn9AXPGgzwGXDoJOPGre3
         CYrCBViCCBV3gueMimJp7Xw5LeMF4T5dBw+0cwan4cV5YsONP1vMak/cIxjItf3XnylA
         H1sQ==
X-Gm-Message-State: AA+aEWZhO89QbNom0QPjUSThcz+GTEMHcVeam3ThHnZfPalZd76VWCeq
        IaQslS90Urtw/kQ3t4xJ9M7gEg==
X-Google-Smtp-Source: AFSGD/XFzpmZt9P+s57VsvnAF06eON+JaheyOilxYXLdRGfV6H6Nt3KWs6+j8OeMMOH0S0u5nu6hVw==
X-Received: by 2002:a2e:3509:: with SMTP id z9-v6mr1668038ljz.54.1543513669095;
        Thu, 29 Nov 2018 09:47:49 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:47:48 -0800 (PST)
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
Subject: [PATCH v10 23/27] drivers: firmware: psci: Manage runtime PM in the idle path for CPUs
Date:   Thu, 29 Nov 2018 18:46:56 +0100
Message-Id: <20181129174700.16585-24-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the hierarchical CPU topology layout is used in DT, let's allow the
CPU to be power managed through its PM domain and via runtime PM. In other
words, let's deploy runtime PM support to the PSCI driver during idle
management of the CPU.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- New patch: Replaces the earlier patch "kernel/cpu_pm: Manage runtime
	  PM in the idle path for CPUs". In the end it seemed like a better
	  idea to start with something specific to PSCI, rather than (ab?)using
	  the generic functions cpu_pm_enter|exit().
	- Do runtime PM get/put for the deepest idle state for the CPU.

---
 drivers/firmware/psci/psci.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 94cd0431b004..b03bccce0a5d 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -20,6 +20,7 @@
 #include <linux/linkage.h>
 #include <linux/of.h>
 #include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
 #include <linux/reboot.h>
@@ -319,6 +320,7 @@ int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 
 #ifdef CONFIG_CPU_IDLE
 static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+static DEFINE_PER_CPU_READ_MOSTLY(u32, psci_rpm_state_id);
 
 static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 			struct device_node *cpu_node, int cpu)
@@ -369,6 +371,9 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		ret = psci_dt_attach_cpu(cpu);
 		if (ret)
 			goto free_mem;
+
+		/* Store index of deepest state to later for runtime PM. */
+		per_cpu(psci_rpm_state_id, cpu) = drv->state_count - 1;
 	}
 
 	/* Idle states parsed correctly, initialize per-cpu pointer */
@@ -466,7 +471,9 @@ int psci_cpu_suspend_enter(unsigned long index)
 {
 	int ret;
 	u32 *state = __this_cpu_read(psci_power_state);
-	u32 composite_state = state[index - 1] | psci_get_domain_state();
+	u32 composite_state, rpm_state_id;
+	bool runtime_pm = false;
+	struct device *dev = NULL;
 
 	/*
 	 * idle state index 0 corresponds to wfi, should never be called
@@ -475,11 +482,29 @@ int psci_cpu_suspend_enter(unsigned long index)
 	if (WARN_ON_ONCE(!index))
 		return -EINVAL;
 
+	/*
+	 * Do runtime PM if we are using the hierarchical CPU toplogy, but only
+	 * when cpuidle have selected the deepest idle state for the CPU.
+	 */
+	if (psci_dt_topology) {
+		rpm_state_id = __this_cpu_read(psci_rpm_state_id);
+		runtime_pm = rpm_state_id == index;
+		if (runtime_pm) {
+			dev = get_cpu_device(smp_processor_id());
+			pm_runtime_put_sync_suspend(dev);
+		}
+	}
+
+	composite_state = state[index - 1] | psci_get_domain_state();
+
 	if (!psci_power_state_loses_context(composite_state))
 		ret = psci_ops.cpu_suspend(composite_state, 0);
 	else
 		ret = cpu_suspend(index, psci_suspend_finisher);
 
+	if (runtime_pm)
+		pm_runtime_get_sync(dev);
+
 	/* Clear the domain state to start fresh when back from idle. */
 	psci_set_domain_state(0);
 
-- 
2.17.1

