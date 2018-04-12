Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbeDLLP2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 07:15:28 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45744 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbeDLLPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 07:15:17 -0400
X-Google-Smtp-Source: AIpwx4/8ymmQwjHjuavmhtWzR0YzoPugxpuzJRCkBA/y9gVfbnzt2+5U24v02c77GQXeFHvn0IbT1g==
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
Subject: [PATCH v7 21/26] drivers: firmware: psci: Add support for PM domains using genpd
Date: Thu, 12 Apr 2018 13:14:26 +0200
Message-Id: <1523531671-27491-22-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
References: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the hierarchical layout is used in DT, as to describe the PM topology
for the CPUs, which are managed by PSCI, we want to be able to initialize
and setup the corresponding PM domain data structures.

Let's make this possible via adding a new file, psci_pm_domains.c and
implement the needed interface towards the generic PM domain (aka genpd).
Share a helper function, psci_dt_init_pm_domains(), which the regular PSCI
firmware driver may call when it needs to initialize the PM topology using
genpd.

In principle, the implementation consists of allocating/initializing the
genpd data structures, parsing the domain-idle states DT bindings via
calling of_genpd_parse_idle_states() and to call pm_genpd_init() for the
allocated genpds.

Finally, one genpd OF provider is added per genpd. Via DT, this enables
devices, including CPU devices, to be attached to the created genpds.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci/Makefile         |   2 +-
 drivers/firmware/psci/psci.h           |   6 ++
 drivers/firmware/psci/psci_pm_domain.c | 180 +++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/psci/psci_pm_domain.c

diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
index 1956b88..ff300f1 100644
--- a/drivers/firmware/psci/Makefile
+++ b/drivers/firmware/psci/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
+obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o psci_pm_domain.o
 obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
index a2b4be5..8b6fe51 100644
--- a/drivers/firmware/psci/psci.h
+++ b/drivers/firmware/psci/psci.h
@@ -10,4 +10,10 @@ void psci_set_domain_state(u32 state);
 
 int psci_dt_parse_state_node(struct device_node *np, u32 *state);
 
+#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
+int psci_dt_init_pm_domains(struct device_node *np);
+#else
+static inline int psci_dt_init_pm_domains(struct device_node *np) { return 0; }
+#endif
+
 #endif /* __PSCI_H */
diff --git a/drivers/firmware/psci/psci_pm_domain.c b/drivers/firmware/psci/psci_pm_domain.c
new file mode 100644
index 0000000..f54819e
--- /dev/null
+++ b/drivers/firmware/psci/psci_pm_domain.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PM domains for CPUs via genpd - managed by PSCI.
+ *
+ * Copyright (C) 2018 Linaro Ltd.
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ */
+
+#define pr_fmt(fmt) "psci: " fmt
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "psci.h"
+
+#ifdef CONFIG_PM_GENERIC_DOMAINS_OF
+static int psci_pd_power_off(struct generic_pm_domain *pd)
+{
+	struct genpd_power_state *state = &pd->states[pd->state_idx];
+	u32 *pd_state;
+	u32 composite_pd_state;
+
+	if (!state->data)
+		return 0;
+
+	pd_state = state->data;
+	composite_pd_state = *pd_state | psci_get_domain_state();
+	psci_set_domain_state(composite_pd_state);
+
+	return 0;
+}
+
+static int psci_dt_parse_pd_states(struct genpd_power_state *states,
+				   int state_count)
+{
+	int i, err;
+	u32 *psci_states;
+
+	if (!state_count)
+		return 0;
+
+	psci_states = kcalloc(state_count, sizeof(psci_states), GFP_KERNEL);
+	if (!psci_states)
+		return -ENOMEM;
+
+	for (i = 0; i < state_count; i++) {
+		err = psci_dt_parse_state_node(to_of_node(states[i].fwnode),
+					       &psci_states[i]);
+		if (err) {
+			kfree(psci_states);
+			return err;
+		}
+	}
+
+	for (i = 0; i < state_count; i++)
+		states[i].data = &psci_states[i];
+
+	return 0;
+}
+
+static int psci_dt_init_genpd(struct device_node *np,
+			      struct genpd_power_state *states,
+			      unsigned int state_count)
+{
+	struct generic_pm_domain *pd;
+	struct dev_power_governor *pd_gov;
+	int ret = -ENOMEM;
+
+	pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	pd->name = kasprintf(GFP_KERNEL, "%pOF", np);
+	if (!pd->name)
+		goto free_pd;
+
+	pd->name = kbasename(pd->name);
+	pd->power_off = psci_pd_power_off;
+	pd->states = states;
+	pd->state_count = state_count;
+	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
+
+	/* Use governor for CPU PM domains if it has some states to manage. */
+	pd_gov = state_count > 0 ? &pm_domain_cpu_gov : NULL;
+
+	ret = pm_genpd_init(pd, pd_gov, false);
+	if (ret)
+		goto free_name;
+
+	ret = of_genpd_add_provider_simple(np, pd);
+	if (ret)
+		goto remove_pd;
+
+	pr_info("init PM domain %s\n", pd->name);
+	return 0;
+
+remove_pd:
+	pm_genpd_remove(pd);
+free_name:
+	kfree(pd->name);
+free_pd:
+	kfree(pd);
+	pr_err("failed to init PM domain ret=%d %pOF\n", ret, np);
+	return ret;
+}
+
+static int psci_dt_set_genpd_topology(struct device_node *np)
+{
+	struct device_node *node;
+	struct of_phandle_args child, parent;
+	int ret;
+
+	for_each_child_of_node(np, node) {
+		if (of_parse_phandle_with_args(node, "power-domains",
+					       "#power-domain-cells", 0,
+					       &parent))
+			continue;
+
+		child.np = node;
+		child.args_count = 0;
+
+		ret = of_genpd_add_subdomain(&parent, &child);
+		of_node_put(parent.np);
+		if (ret) {
+			of_node_put(node);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int psci_dt_init_pm_domains(struct device_node *np)
+{
+	struct device_node *node;
+	struct genpd_power_state *states;
+	int state_count;
+	int pd_count = 0;
+	int ret;
+
+	/* Parse child nodes for "#power-domain-cells". */
+	for_each_child_of_node(np, node) {
+		if (!of_find_property(node, "#power-domain-cells", NULL))
+			continue;
+
+		ret = of_genpd_parse_idle_states(node, &states, &state_count);
+		if (ret)
+			goto err_put;
+
+		ret = psci_dt_parse_pd_states(states, state_count);
+		if (ret)
+			goto err_put;
+
+		ret = psci_dt_init_genpd(node, states, state_count);
+		if (ret)
+			goto err_put;
+
+		pd_count++;
+	}
+
+	if (!pd_count)
+		return 0;
+
+	ret = psci_dt_set_genpd_topology(np);
+	if (ret)
+		goto err_msg;
+
+	return pd_count;
+
+err_put:
+	of_node_put(node);
+err_msg:
+	pr_err("failed to create PM domains ret=%d\n", ret);
+	return ret;
+}
+#endif
-- 
2.7.4
