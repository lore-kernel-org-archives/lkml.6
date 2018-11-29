Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B4AC41537
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CF8213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmLH+XoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91CF8213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731049AbeK3Exv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:53:51 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36260 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731015AbeK3Ext (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:53:49 -0500
Received: by mail-lf1-f68.google.com with SMTP id a16so2111019lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0f5FNvFNr+ywaXHgyrdJbA+WYJaJrfnYBdOhsBxudf4=;
        b=XmLH+XoAJtA/XlML6wE1maPOYx/UgMy3QdCOO/C9Bbgo4OSb13ZU3C9qDH+QoTZRxf
         Rke2l20UnNvvrcOTsXud9ZDQpFCo249MLeMQtK5qGGiMWjG0Ge1brJ8dElp8nTQNPGnp
         p/t3f3qeclrknlZT72MhdAwxwbHzyXVyPCRQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0f5FNvFNr+ywaXHgyrdJbA+WYJaJrfnYBdOhsBxudf4=;
        b=Z2IT4cltJk+npRbssfPu0vO4z9DZXIIamdc1eo7igrB6tiT4A5vqRrIFsLndCLPeWO
         9WezvJaFRKR6BTIC7IJGcNr+PHdPl9vgl06aQqsvOjLFDyrMueI5thhUx8u0We+Rp3J7
         p9S9Ezph/xbfSfv5SGKUsdxpOFIyCMaUHk2wEhLRCdL+AQIJNfoOFvhRn4yIfm89OWin
         s0EtwR4e+ADx2/xkbimeDZzmoIC0QeQTJ2fsZJLhJavJqAs6EfhuScb3EQLhs0g1x8f0
         pfnzEUg4Tq8rxMy3Y/Ye3mMEELex78idVdtivTCYVYBob69peekM+0z1mEFezn/J7o+a
         Vi3A==
X-Gm-Message-State: AA+aEWa1MT5j33UlsuT4X8MGg9nvoTdYF1qvaow9C4Ek81vAhvaogrzy
        VMExEyJj1qP9C7nw07Yy58L76wDKHMc=
X-Google-Smtp-Source: AFSGD/Wc/z4ksBJs3vHmhXh16mPBFgtQnbNX6FwOcO14wj444TX9p972mzxxNkllouBu8ScnYN8TbQ==
X-Received: by 2002:a19:8fce:: with SMTP id s75mr1590227lfk.151.1543513658259;
        Thu, 29 Nov 2018 09:47:38 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:47:37 -0800 (PST)
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
Subject: [PATCH v10 17/27] drivers: firmware: psci: Prepare to support PM domains
Date:   Thu, 29 Nov 2018 18:46:50 +0100
Message-Id: <20181129174700.16585-18-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following changes are about to implement support for PM domains to PSCI.
Those changes are mainly going to be implemented in a new separate file,
hence a couple of the internal PSCI functions needs to be shared to be
accessible. So, let's do that via adding new PSCI header file.

Moreover, the changes deploying support for PM domains, needs to be able to
switch the PSCI FW into the OS initiated mode. For that reason, let's add a
new function that deals with this and share it via the new PSCI header
file.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- New patch. Re-places the earlier patch: "drivers: firmware: psci:
	  Share a few internal PSCI functions".

---
 drivers/firmware/psci/psci.c | 28 +++++++++++++++++++++-------
 drivers/firmware/psci/psci.h | 14 ++++++++++++++
 2 files changed, 35 insertions(+), 7 deletions(-)
 create mode 100644 drivers/firmware/psci/psci.h

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 8dbcdecc2ae4..623591b541a4 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -34,6 +34,8 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 
+#include "psci.h"
+
 /*
  * While a 64-bit OS can make calls with SMC32 calling conventions, for some
  * calls it is necessary to use SMC64 to pass or return 64-bit values.
@@ -90,23 +92,35 @@ static u32 psci_function_id[PSCI_FN_MAX];
 static DEFINE_PER_CPU(u32, domain_state);
 static u32 psci_cpu_suspend_feature;
 
-static inline u32 psci_get_domain_state(void)
+u32 psci_get_domain_state(void)
 {
 	return __this_cpu_read(domain_state);
 }
 
-static inline void psci_set_domain_state(u32 state)
+void psci_set_domain_state(u32 state)
 {
 	__this_cpu_write(domain_state, state);
 }
 
+bool psci_set_osi_mode(void)
+{
+	int ret;
+
+	ret = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
+			PSCI_1_0_SUSPEND_MODE_OSI, 0, 0);
+	if (ret)
+		pr_warn("failed to enable OSI mode: %d\n", ret);
+
+	return !ret;
+}
+
 static inline bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
 				PSCI_1_0_FEATURES_CPU_SUSPEND_PF_MASK;
 }
 
-static inline bool psci_has_osi_support(void)
+bool psci_has_osi_support(void)
 {
 	return psci_cpu_suspend_feature & PSCI_1_0_OS_INITIATED;
 }
@@ -285,10 +299,7 @@ static int __init psci_features(u32 psci_func_id)
 			      psci_func_id, 0, 0);
 }
 
-#ifdef CONFIG_CPU_IDLE
-static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
-
-static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
+int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 {
 	int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
 
@@ -305,6 +316,9 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 	return 0;
 }
 
+#ifdef CONFIG_CPU_IDLE
+static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+
 static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 			struct device_node *cpu_node, int cpu)
 {
diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
new file mode 100644
index 000000000000..7d9d38fd57e1
--- /dev/null
+++ b/drivers/firmware/psci/psci.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __PSCI_H
+#define __PSCI_H
+
+struct device_node;
+
+bool psci_set_osi_mode(void);
+u32 psci_get_domain_state(void);
+void psci_set_domain_state(u32 state);
+bool psci_has_osi_support(void);
+int psci_dt_parse_state_node(struct device_node *np, u32 *state);
+
+#endif /* __PSCI_H */
-- 
2.17.1

