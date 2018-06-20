Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAA6C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD2920836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNMEG9yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD2920836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933135AbeFTRZ2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:25:28 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38634 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754597AbeFTRXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:23:09 -0400
Received: by mail-lf0-f65.google.com with SMTP id i83-v6so481177lfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5c12PoaPayFjQRFBN/FJeDZsu2cQBeSb29KIyIwynIE=;
        b=fNMEG9yxB1x3uNbnRxEi56bcFRcCmaoR6Yq8DZbX198JH13Yvc6OshNhATfGUoTPNU
         rcWDutQB8eDtpnXaKF98ag5WBNOEsuCTzbjaoF4Rn+S+MT+4uK6tpg6VCjYphHSCl5qt
         I4mu1VwZAJ6u0lwrfKG5OGZ2hRzl+Ce0CWEVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5c12PoaPayFjQRFBN/FJeDZsu2cQBeSb29KIyIwynIE=;
        b=nQ3qeGM352GY7jM+KlYYXtRUvlopVHTizVZiCQbQzqnyHMjhj1zFrWTEv4G/bZp54m
         99RgE9ydWxWrDNY4Dj39ONlszdVmc7wVvZdi3pxsgu4z3slstiwnQggy8P7AFgprlOU3
         AFehnFQi64+aabu9b5rNdt3r9FY/9sokouuINLLjn8gi1TXqgJXo3SNIioG+hwbUEiV9
         y1XjUSU5PPDxlSyBGYfBGBYnSyTrrkwcSPDl5kW/2zZnJsR7Sa0+ouLYwKQD9A2N3ubt
         6SoIhMvFZHqjox77u+qi+wR7NsECmCC99i2TXSe/oWz142V9LzFb9yTifhBdpkr1HOgP
         jyXQ==
X-Gm-Message-State: APt69E1Yrd1Hjj0F9DWOJ9uDmOfa7839u3hEWk8NzpuJ8JKFD5snAGXO
        Ym+yXRJ/rNiQWWs+ul+SsJQgPQ==
X-Google-Smtp-Source: ADUXVKLXnbEUhvdJrQNRK3z6KOMETfpBUAn8KW5mZVmF80413yeBds/6zQjy2v73Bo8Bct0QemdGUQ==
X-Received: by 2002:a2e:3613:: with SMTP id d19-v6mr14809658lja.31.1529515388105;
        Wed, 20 Jun 2018 10:23:08 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.23.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:23:07 -0700 (PDT)
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
Subject: [PATCH v8 18/26] drivers: firmware: psci: Announce support for OS initiated suspend mode
Date:   Wed, 20 Jun 2018 19:22:18 +0200
Message-Id: <20180620172226.15012-19-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
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
 drivers/firmware/psci/psci.c | 21 ++++++++++++++++++++-
 include/uapi/linux/psci.h    |  5 +++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 38881007584e..e8f4f8444ff1 100644
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
@@ -658,10 +663,24 @@ static int __init psci_0_1_init(struct device_node *np)
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

