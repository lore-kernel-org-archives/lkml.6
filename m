Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF93C41538
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782DD21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HC6R7vkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782DD21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbeK3Exr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:53:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33102 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730941AbeK3Exq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:53:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so2548698ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RtdXqoS3gVAQPCLor+MB+aJuhRHlqOlmuJfNLhUnBd0=;
        b=HC6R7vkBxIVeReHiAW/l7VN+GiG5KttIpTe0k0AqV1hXefU42ypirVgAKNl6NVij5H
         txPNau3G5O/NCT/MuPS2rUKWtErXXmXXxcxlO5t0f/UEPJlhLfvbS7G+VZYr4xUJL7tJ
         ay4ymuPR6i7iB28pio0Hym1SmYgxxpasGofW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RtdXqoS3gVAQPCLor+MB+aJuhRHlqOlmuJfNLhUnBd0=;
        b=E0ONDlymoU6czMHtIHAKf8sjf2A373Ze1nr6HW4Xe+DbrVsggvq+j2sidkd5DEDa9G
         Mo4Q0I0SZao7+ygRreV2eRDDdnngb6UY937GZmYXm00cE0AEmJZDJ8P6YztYMAliz6FO
         vUIa691XhRjYiGht/p+8+NaNlZfb++zoXksxRJ/9+Tt3/0Jun4QhT4HyEEsaLINK+q0Q
         Dnptbq7QgDl+4KyzeSnsRNhO/kJzIJQFAr2XwEe5UrPENHsajcW7S/LuO2jZoJeg6Gqj
         eigly/0KjIHh9p+F5pjNK+bbwKu3VBsRkQY9bNhtBQRPSaOlCWmDXDBCchWlW0oOF1eT
         9jfA==
X-Gm-Message-State: AA+aEWaNjQRpBwOCNcoDYcU5yXSsbj3zhT5diJqD701J6AdQ1N7GJsrC
        47wf/F2b5KophNKY9uKu7q2eEg==
X-Google-Smtp-Source: AFSGD/UoOMLd8KL9ke7+41ey3VhAhq3w0txzumISXYpr0GGW8iXSuRUe08J7o+7bUUEIF8A7rc1LPA==
X-Received: by 2002:a2e:1241:: with SMTP id t62-v6mr1548248lje.171.1543513654558;
        Thu, 29 Nov 2018 09:47:34 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:47:33 -0800 (PST)
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
Subject: [PATCH v10 15/27] drivers: firmware: psci: Announce support for OS initiated suspend mode
Date:   Thu, 29 Nov 2018 18:46:48 +0100
Message-Id: <20181129174700.16585-16-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PSCI firmware v1.0+, supports two different modes for CPU_SUSPEND. The
Platform Coordinated mode, which is the default and mandatory mode, while
support for the OS initiated mode is optional.

This change introduces initial support for the OS initiated mode, in way
that it adds the related PSCI bits from the spec and prints a message in
the log to inform whether the mode is supported by the PSCI FW.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- None.

---
 drivers/firmware/psci/psci.c | 21 ++++++++++++++++++++-
 include/uapi/linux/psci.h    |  5 +++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 6bfa47cbd174..4f0cbc95e41b 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -95,6 +95,11 @@ static inline bool psci_has_ext_power_state(void)
 				PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
 }
 
+static inline bool psci_has_osi_support(void)
+{
+	return psci_cpu_suspend_feature & PSCI_1_0_OS_INITIATED;
+}
+
 static inline bool psci_power_state_loses_context(u32 state)
 {
 	const u32 mask = psci_has_ext_power_state() ?
@@ -659,10 +664,24 @@ static int __init psci_0_1_init(struct device_node *np)
 	return 0;
 }
 
+static int __init psci_1_0_init(struct device_node *np)
+{
+	int err;
+
+	err = psci_0_2_init(np);
+	if (err)
+		return err;
+
+	if (psci_has_osi_support())
+		pr_info("OSI mode supported.\n");
+
+	return 0;
+}
+
 static const struct of_device_id psci_of_match[] __initconst = {
 	{ .compatible = "arm,psci",	.data = psci_0_1_init},
 	{ .compatible = "arm,psci-0.2",	.data = psci_0_2_init},
-	{ .compatible = "arm,psci-1.0",	.data = psci_0_2_init},
+	{ .compatible = "arm,psci-1.0",	.data = psci_1_0_init},
 	{},
 };
 
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index b3bcabe380da..581f72085c33 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -49,6 +49,7 @@
 
 #define PSCI_1_0_FN_PSCI_FEATURES		PSCI_0_2_FN(10)
 #define PSCI_1_0_FN_SYSTEM_SUSPEND		PSCI_0_2_FN(14)
+#define PSCI_1_0_FN_SET_SUSPEND_MODE		PSCI_0_2_FN(15)
 
 #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
 
@@ -97,6 +98,10 @@
 #define PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK	\
 			(0x1 << PSCI_1_0_FEATURES_CPU_SUSPEND_PF_SHIFT)
 
+#define PSCI_1_0_OS_INITIATED			BIT(0)
+#define PSCI_1_0_SUSPEND_MODE_PC		0
+#define PSCI_1_0_SUSPEND_MODE_OSI		1
+
 /* PSCI return values (inclusive of all PSCI versions) */
 #define PSCI_RET_SUCCESS			0
 #define PSCI_RET_NOT_SUPPORTED			-1
-- 
2.17.1

