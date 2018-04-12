Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753316AbeDLLPX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 07:15:23 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41084 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753217AbeDLLPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 07:15:19 -0400
X-Google-Smtp-Source: AIpwx4+C7PjClXuqUwftpnZzR/2DE/kVp24K5WNvnaedGYhtjGzgPg/0lnI2ea4EpLYSZwN/+7h93w==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 22/26] drivers: firmware: psci: Introduce psci_dt_topology_init()
Date: Thu, 12 Apr 2018 13:14:27 +0200
Message-Id: <1523531671-27491-23-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
References: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
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
 drivers/firmware/psci/psci.c | 38 +++++++++++++++++++++++++++++++++++++-
 include/linux/psci.h         |  2 ++
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 463f78c..80c286d 100644
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
index 8b1b3b5..298a044 100644
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
2.7.4
