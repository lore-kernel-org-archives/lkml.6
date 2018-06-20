Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3656BC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E286320836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AnCYg2NX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E286320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933114AbeFTRYc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:24:32 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46828 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932760AbeFTRXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:23:17 -0400
Received: by mail-lf0-f68.google.com with SMTP id u5-v6so439036lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=obVnlFJdxsGUIrbcYFsNPcmvDAVODyR1tm0m+FESLs4=;
        b=AnCYg2NXxTXPOMS3NLdA54taBopJhCvN4sAF0xjh3TeRtV28/1UJ5iN37Mx8z8MtQ+
         Sd03v3uXI+8MfdqapNB1+BCvfPIiOAB9CYEYGOdXpOlm9d0aJUQE6uKIxBvvT3TqWJPX
         y9oI25toX9WaZ3/Z2AaDFlQONWJ5W8lKApHQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=obVnlFJdxsGUIrbcYFsNPcmvDAVODyR1tm0m+FESLs4=;
        b=WRd+CqCuCvYWdomi3OhcYI7641pjU6ro3i03bH8aN72Wb3deyytdVh2JpaFyXvhN9k
         c3l6AKes5KcWM7ut3eQYZuGZNAAFzklno7xR0weQIRiM4CppUDzcTkL/aus5L735JUZt
         gQB5DMXJuu7RaRVGo4kDUiYuWsBldckGck7zGniKZrYmV3ZZIa5LYGnEhjW5P6fKxC33
         /ssKPEOiIS1ynjQTUyF+DXLz2BwKxMgs3imiyvj0UWL1nuxQC65sCd0LRLXJnP9jz/pe
         Bz8VsOX0PKTIq2wVdRiAusBm5YFCURKdbOhQo72KbBaT8W3bNRuL2vVDD7F10jOiqN8L
         NgvQ==
X-Gm-Message-State: APt69E2ROB0KTQDAr4Orp0jB+XYDucVRsyaTHoLeVa36SdsbNmJQR8ck
        81ZhJNQRl0ZfoG0QDW9nGF/8ng==
X-Google-Smtp-Source: ADUXVKKP3XsV0AqKdjZqk5wC3TpY+18fzUVAsruGPiCBE3ius4Z6oJKYgOGVAhcSursIh5yCF97r/Q==
X-Received: by 2002:a2e:750d:: with SMTP id q13-v6mr14484271ljc.56.1529515395487;
        Wed, 20 Jun 2018 10:23:15 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:23:14 -0700 (PDT)
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
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 22/26] drivers: firmware: psci: Introduce psci_dt_topology_init()
Date:   Wed, 20 Jun 2018 19:22:22 +0200
Message-Id: <20180620172226.15012-23-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the hierarchical layout is used in DT, we want to initialize the
corresponding PM domain topology for the CPUs, by using the generic PM
domain (aka genpd) infrastructure.

At first glance, it may seem feasible to hook into the existing
psci_dt_init() function, although because it's called quite early in the
boot sequence, allocating the dynamic data structure for a genpd doesn't
work.

Therefore, let's export a new init function for PSCI,
psci_dt_topology_init(), which the ARM machine code should call from a
suitable initcall.

Succeeding to initialize the PM domain topology, which means at least one
instance of a genpd becomes created, allows us to continue to enable the
PSCI OS initiated mode for the platform. If everything turns out fine,
let's print a message in log to inform the user about the changed mode.

In case of any failures, we stick to the default PSCI Platform Coordinated
mode. Moreover, in case the kernel started from a kexec call, let's make
sure to explicitly default to this mode during boot, in case the previous
kernel changed the mode.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci/psci.c | 38 +++++++++++++++++++++++++++++++++++-
 include/linux/psci.h         |  2 ++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 463f78cda3be..80c286d83369 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -691,9 +691,14 @@ static int __init psci_1_0_init(struct device_node *np)
 	if (err)
 		return err;
 
-	if (psci_has_osi_support())
+	if (psci_has_osi_support()) {
 		pr_info("OSI mode supported.\n");
 
+		/* Make sure we default to PC mode. */
+		invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
+			       PSCI_1_0_SUSPEND_MODE_PC, 0, 0);
+	}
+
 	return 0;
 }
 
@@ -723,6 +728,37 @@ int __init psci_dt_init(void)
 	return ret;
 }
 
+int __init psci_dt_topology_init(void)
+{
+	struct device_node *np;
+	int ret;
+
+	if (!psci_has_osi_support())
+		return 0;
+
+	np = of_find_matching_node_and_match(NULL, psci_of_match, NULL);
+	if (!np)
+		return -ENODEV;
+
+	/* Initialize the CPU PM domains based on topology described in DT. */
+	ret = psci_dt_init_pm_domains(np);
+	if (ret <= 0)
+		goto out;
+
+	/* Enable OSI mode. */
+	ret = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
+			     PSCI_1_0_SUSPEND_MODE_OSI, 0, 0);
+	if (ret) {
+		pr_info("failed to enable OSI mode: %d\n", ret);
+		goto out;
+	}
+
+	pr_info("OSI mode enabled.\n");
+out:
+	of_node_put(np);
+	return ret;
+}
+
 #ifdef CONFIG_ACPI
 /*
  * We use PSCI 0.2+ when ACPI is deployed on ARM64 and it's
diff --git a/include/linux/psci.h b/include/linux/psci.h
index 8b1b3b5935ab..298a044407f0 100644
--- a/include/linux/psci.h
+++ b/include/linux/psci.h
@@ -53,8 +53,10 @@ extern struct psci_operations psci_ops;
 
 #if defined(CONFIG_ARM_PSCI_FW)
 int __init psci_dt_init(void);
+int __init psci_dt_topology_init(void);
 #else
 static inline int psci_dt_init(void) { return 0; }
+static inline int psci_dt_topology_init(void) { return 0; }
 #endif
 
 #if defined(CONFIG_ARM_PSCI_FW) && defined(CONFIG_ACPI)
-- 
2.17.1

