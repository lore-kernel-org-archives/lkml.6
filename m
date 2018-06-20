Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14E1C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E0220836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eg0M4K1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E0220836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932881AbeFTRXT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:23:19 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40178 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932743AbeFTRXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:23:15 -0400
Received: by mail-lf0-f68.google.com with SMTP id q11-v6so469815lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dpRzWZ1lRV3PUFVF54+RtopoI+Qxx4PQOSnHva5FuG0=;
        b=Eg0M4K1y1jPCN7GIdZAXDgAVpLPggcUYsLLm8zmicBLw9lxb5F2rFzBE/Il1E3g8NP
         2plsB85rwB3kEaChU/AkeAoo4cKWGeyImYGUir3Nl/kOY9eC7esYJbCMcVJnQS+qccXh
         0HOpUo0XXP0iPIig7ion/ai28kav03/03ZtiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dpRzWZ1lRV3PUFVF54+RtopoI+Qxx4PQOSnHva5FuG0=;
        b=EnDp9fp131umorLTdhhE163PBBZMw6YnZphzkFNz2mXnUHh3q+7JCBBSHVJ74w2VPG
         vY2uk4NfiFPJP0BsTczo2xzLn/7a2LZ1FgJRRHp5nAzCLyaj558gObeI+NibkDIb+bBC
         UrzaEJSvTgLxBXFZ8nP86QJAQ98EPzyvjFpHhmC7UkD+XufWgjU4JwEI80obq4+abE6H
         oKz8xK9xzgw1c+qQtnWiIVvejFi7FtngDGRMSmVcONGFOroKSgn6ZCTI7c3Zem2191nI
         VXSB2zSmdS8/U0i1RJj45c9G4WT2FWuyX9R/46mh5ID1lCFJPBZJ8gH3D/yK9g+xhrdL
         BOQA==
X-Gm-Message-State: APt69E1E2i3107/Go0G865EPdl/cErNw8WhbH/+DkQbSsLr8wvxIgtfU
        Kjar7wPIyLeUakI9p2c1yWKJiw==
X-Google-Smtp-Source: ADUXVKLVvZTFdpj3qKwzqzeDJnvXHNUoiFXlfoS4PQuZNDvYr6YFwfV+WCqsLUvtvRFLb00abw1Qng==
X-Received: by 2002:a2e:428e:: with SMTP id h14-v6mr15515102ljf.136.1529515393686;
        Wed, 20 Jun 2018 10:23:13 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:23:13 -0700 (PDT)
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
Subject: [PATCH v8 21/26] drivers: firmware: psci: Add support for PM domains using genpd
Date:   Wed, 20 Jun 2018 19:22:21 +0200
Message-Id: <20180620172226.15012-22-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
 drivers/firmware/psci/psci.h           |   6 +
 drivers/firmware/psci/psci_pm_domain.c | 180 +++++++++++++++++++++++++
 3 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/psci/psci_pm_domain.c

diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
index 1956b882470f..ff300f1fec86 100644
--- a/drivers/firmware/psci/Makefile
+++ b/drivers/firmware/psci/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
+obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o psci_pm_domain.o
 obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
index dc7b596daa2b..a22684b24902 100644
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
index 000000000000..f54819e7e487
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
2.17.1

