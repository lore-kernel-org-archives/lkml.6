Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932443AbeCNQ7w (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:59:52 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:46461 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752391AbeCNQ7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:59:42 -0400
X-Google-Smtp-Source: AG47ELuYlZZaBkRXPbOX1Fpim8g97uwbyhYbBN1X56jiw2zEsXIKehlMJoRu8yX9/6I448tp/xIzqw==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
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
Subject: [PATCH v6 21/25] drivers: firmware: psci: Try to attach CPU devices to their PM domains
Date: Wed, 14 Mar 2018 17:58:31 +0100
Message-Id: <1521046715-30683-22-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the OS initiated CPU suspend mode have been enabled, the PM domain
topology for CPUs have earlier been created by PSCI. Let's use this
information in psci_dt_cpu_init_idle() as a condition for when it makes
sense to try to attach the CPU to its corresponding PM domain, via calling
of_genpd_attach_cpu().

If the CPU is attached successfully to its PM domain, idle management is
now fully prepared to be controlled through runtime PM for the CPU.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 45d55fc..944d6f6 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -20,6 +20,7 @@
 #include <linux/linkage.h>
 #include <linux/of.h>
 #include <linux/pm.h>
+#include <linux/pm_domain.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
 #include <linux/reboot.h>
@@ -91,6 +92,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
 
 static DEFINE_PER_CPU(u32, domain_state);
 static u32 psci_cpu_suspend_feature;
+static bool psci_osi_mode_enabled;
 
 u32 psci_get_domain_state(void)
 {
@@ -339,6 +341,14 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 
 	/* Idle states parsed correctly, initialize per-cpu pointer */
 	per_cpu(psci_power_state, cpu) = psci_states;
+
+	/* If running OSI mode, attach the CPU device to its PM domain. */
+	if (psci_osi_mode_enabled) {
+		ret = of_genpd_attach_cpu(cpu);
+		if (ret)
+			goto free_mem;
+	}
+
 	return 0;
 
 free_mem:
@@ -748,6 +758,7 @@ int __init psci_dt_topology_init(void)
 		goto out;
 	}
 
+	psci_osi_mode_enabled = true;
 	pr_info("OSI mode enabled.\n");
 out:
 	of_node_put(np);
-- 
2.7.4
