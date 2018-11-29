Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18ED5C46466
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C768B21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UPPBOHan"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C768B21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbeK3EyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:54:05 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41866 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731138AbeK3EyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:54:04 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so2097897lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8XcXgSMicdNFExYNvXv93BQqc4PUMWszq8Q+N0PwQJQ=;
        b=UPPBOHaniBcnAzLge02a1Ved7MDAgwg3PT63fbQBxmWP6r7IUNmB9wBF+cpdUregbU
         YNpOhRm0kjRcXF6xnbJ01Ca2Erys97CKhH7FfDfbIj5YdHlt1zhk9sD+G18xFUEPnTeG
         o/6qnFNHOkaoXtqDBngZxRNXPyWTOoR/EGa+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8XcXgSMicdNFExYNvXv93BQqc4PUMWszq8Q+N0PwQJQ=;
        b=tNbJ+9un/JDcFWkSZbOgj7OvDShq9bYNVKg8xLXh3MhjKLUMI48IKPpJb3AYUpym5q
         pejBTqxdAyo2F2q8uxjrTroimoiJNCKwDtcNTvWPljz8DVEDPeFpcCHqdFKSOjZw/JEe
         EjKuQsJUufNneCZzOsgmJvrbpkco1mQEmabUIjv7C56VI/KuvPHcXEDnik0Ni8XoMuIb
         GXh629iQooJ1AF33sEMt59ext43RVohD5bQzW0EF6ANc9aA2eNd7fxgOL19zqJukh3Ae
         PhHlddDsD/+FQxnuHMNnA6sxTRbZShv6kAHwfusiyzIo8QJrapdRRDm4lYNxFU2Ea7I5
         grHQ==
X-Gm-Message-State: AA+aEWYjX4HVVgSmAN44JeMpI+4OL5TDkNEl9e04HtXa0s8U58NZrBwU
        YvL1bHVyTYMy5Ucb3OijJjnrzA==
X-Google-Smtp-Source: AFSGD/Vv4orDwR+nTAJgZv7KcoNBHuFUfJ1RXoB3WL0hhWGM6CeGAm1v2qYblWtvCG+N9/GJet3jBw==
X-Received: by 2002:a19:2d16:: with SMTP id k22mr1586183lfj.12.1543513671100;
        Thu, 29 Nov 2018 09:47:51 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:47:50 -0800 (PST)
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
Subject: [PATCH v10 24/27] drivers: firmware: psci: Support CPU hotplug for the hierarchical model
Date:   Thu, 29 Nov 2018 18:46:57 +0100
Message-Id: <20181129174700.16585-25-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the hierarchical CPU topology is used and when a CPU has been put
offline (hotplug), that same CPU prevents its PM domain and thus also
potential master PM domains, from being powered off. This is because genpd
observes the CPU's struct device to remain being active from a runtime PM
point of view.

To deal with this, let's decrease the runtime PM usage count by calling
pm_runtime_put_sync_suspend() of the CPU's struct device when putting it
offline. Consequentially, we must then increase the runtime PM usage for
the CPU, while putting it online again.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- Make it work when the hierarchical CPU topology is used, which may be
	  used both for OSI and PC mode.
	- Rework the code to prevent "BUG: sleeping function called from
	  invalid context".
---
 drivers/firmware/psci/psci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index b03bccce0a5d..f62c4963eb62 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -15,6 +15,7 @@
 
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/errno.h>
 #include <linux/linkage.h>
@@ -199,9 +200,20 @@ static int psci_cpu_suspend(u32 state, unsigned long entry_point)
 
 static int psci_cpu_off(u32 state)
 {
+	struct device *dev;
 	int err;
 	u32 fn;
 
+	/*
+	 * When the hierarchical CPU topology is used, decrease the runtime PM
+	 * usage count for the current CPU, as to allow other parts in the
+	 * topology to enter low power states.
+	 */
+	if (psci_dt_topology) {
+		dev = get_cpu_device(smp_processor_id());
+		pm_runtime_put_sync_suspend(dev);
+	}
+
 	fn = psci_function_id[PSCI_FN_CPU_OFF];
 	err = invoke_psci_fn(fn, state, 0, 0);
 	return psci_to_linux_errno(err);
@@ -209,6 +221,7 @@ static int psci_cpu_off(u32 state)
 
 static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
 {
+	struct device *dev;
 	int err;
 	u32 fn;
 
@@ -216,6 +229,13 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
 	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
 	/* Clear the domain state to start fresh. */
 	psci_set_domain_state(0);
+
+	/* Increase runtime PM usage count if the hierarchical CPU toplogy. */
+	if (!err && psci_dt_topology) {
+		dev = get_cpu_device(cpuid);
+		pm_runtime_get_sync(dev);
+	}
+
 	return psci_to_linux_errno(err);
 }
 
-- 
2.17.1

