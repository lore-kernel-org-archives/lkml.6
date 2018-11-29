Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D75C46463
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A772145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YsyItLbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A772145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbeK3EyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:54:00 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43758 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731109AbeK3Ex7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:53:59 -0500
Received: by mail-lj1-f195.google.com with SMTP id 83-v6so2519736ljf.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RFaG8cXFhArmCpS6rP1BJYuJ7tPHpHBulh3EEudBMoM=;
        b=YsyItLbVHbH3tNLzCiQMEYnmNZdjcvUx83pMpRN5YHP4Kjmhe6ZXEntFzFIP+AgDbr
         qJwxSlvke/NW59tkmG9joPEpjGPElE19RUBmi1WUnO9dFz/sBAqaNSjy1xznLW4+AKe/
         4lyBldpmHWjI+AbKgVIYPcICKOGDXesumiTy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RFaG8cXFhArmCpS6rP1BJYuJ7tPHpHBulh3EEudBMoM=;
        b=ipXi5JO1yFMty67vP9VhJE0KU86Pq2wg8B8koO3/SXRfvjTY/IOrbBwUZdE3qj272P
         kSSI0e/ahMLFZQAKd1e93w/kBG7eWD6VusoZcInqGrEwtSG5cGthCKKgB82nphifeTmy
         rpS3mbsGj7SlMt+mVoIuOMKCVK5kxsQBT+6ZGUyLzAl4Bm7cWJt9qZBqQ+5erkF6XEog
         E+WWPt4widD0avBCFkEngNMZ7y48J6srH9BH9T86KhvcxB3EYUNCWKfi7uJaDWVmnhXV
         IVBwCntmsyt8ALl2LkOWib/eRZhrBc3VEYOtV/L65x/7OMEJ7TH0O+azdULxbaASX71a
         ksOw==
X-Gm-Message-State: AA+aEWYUSkDlZk3EgW8Op/tIMRPRsTq8hZurOUg6B19TZ1peCls55Mki
        kH897qXA2GbVx9hvcDKSW6QD1Q==
X-Google-Smtp-Source: AFSGD/WVodyz08Ry3gytrKNYSqfpWR2+qsmxRgCgsjxMAmnxCpSQnymL3the+lKJOkCI1ZjncfMR9g==
X-Received: by 2002:a2e:e02:: with SMTP id 2-v6mr1536589ljo.10.1543513666911;
        Thu, 29 Nov 2018 09:47:46 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:47:46 -0800 (PST)
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
Subject: [PATCH v10 22/27] drivers: firmware: psci: Attach the CPU's device to its PM domain
Date:   Thu, 29 Nov 2018 18:46:55 +0100
Message-Id: <20181129174700.16585-23-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to allow the CPU to be power managed through a potential PM domain
and the corresponding topology, it needs to be attached to it. For that
reason, check if the PM domain data structures have been initiated for PSCI
and if so, let's try to attach the CPU device to its PM domain.

However, before attaching the CPU to its PM domain, we need to check
whether the PSCI firmware supports OS initiated mode or not. If that isn't
the case, we rely solely on the cpuidle framework to deal with the idle
state selection, which means we need to parse DT and convert the
hierarchical described domain idle states into regular cpuidle states,
hence let's do that.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- Attach CPU devices to their PM domains, regardless of OSI mode or PC
	  mode.
	- For PC mode, convert domain idle states to generic cpuidle states
	  to let the cpuidle driver manage them.

---
 drivers/firmware/psci/psci.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 5b481e91ccab..94cd0431b004 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -327,7 +327,7 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 	u32 *psci_states;
 	struct device_node *state_node;
 
-	psci_states = kcalloc(num_state_nodes, sizeof(*psci_states),
+	psci_states = kcalloc(CPUIDLE_STATE_MAX, sizeof(*psci_states),
 			GFP_KERNEL);
 	if (!psci_states)
 		return -ENOMEM;
@@ -351,6 +351,26 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		goto free_mem;
 	}
 
+	/*
+	 * If the hierarchical CPU topology is used, let's attach the CPU device
+	 * to its corresponding PM domain. If OSI mode isn't supported, pick up
+	 * the additional cpuidle states, from the domain idle states described
+	 * in the hierarchical DT layout, as to enable the cpuidle driver to
+	 * manage them.
+	 */
+	if (psci_dt_topology) {
+		if (!psci_has_osi_support()) {
+			ret = psci_dt_pm_domains_parse_states(drv, cpu_node,
+							      psci_states);
+			if (ret)
+				goto free_mem;
+		}
+
+		ret = psci_dt_attach_cpu(cpu);
+		if (ret)
+			goto free_mem;
+	}
+
 	/* Idle states parsed correctly, initialize per-cpu pointer */
 	per_cpu(psci_power_state, cpu) = psci_states;
 	return 0;
-- 
2.17.1

