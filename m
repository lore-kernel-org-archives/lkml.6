Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030395AbeEYUcV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:32:21 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33677 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030259AbeEYUb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:31:29 -0400
X-Google-Smtp-Source: AB8JxZr1nsjfhNo7D9hZ0gYttcZdihm7JgYWcnLYCwiySEHf7GNIhd0F2Qy/03WlO8RG7PN22T1+7w==
From: Matthias Kaehlcke <mka@chromium.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 09/11] misc: throttler: Add core support for non-thermal throttling
Date: Fri, 25 May 2018 13:30:41 -0700
Message-Id: <20180525203043.249193-10-mka@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <20180525203043.249193-1-mka@chromium.org>
References: <20180525203043.249193-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of the throttler is to provide support for non-thermal
throttling. Throttling is triggered by external event, e.g. the
detection of a high battery discharge current, close to the OCP limit
of the battery. The throttler is only in charge of the throttling, not
the monitoring, which is done by another (possibly platform specific)
driver.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/misc/Kconfig            |   1 +
 drivers/misc/Makefile           |   1 +
 drivers/misc/throttler/Kconfig  |  13 ++
 drivers/misc/throttler/Makefile |   1 +
 drivers/misc/throttler/core.c   | 373 ++++++++++++++++++++++++++++++++
 include/linux/throttler.h       |  10 +
 6 files changed, 399 insertions(+)
 create mode 100644 drivers/misc/throttler/Kconfig
 create mode 100644 drivers/misc/throttler/Makefile
 create mode 100644 drivers/misc/throttler/core.c
 create mode 100644 include/linux/throttler.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 5d713008749b..691d9625d83c 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -513,4 +513,5 @@ source "drivers/misc/echo/Kconfig"
 source "drivers/misc/cxl/Kconfig"
 source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
+source "drivers/misc/throttler/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 20be70c3f118..01a1714dd2ad 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-$(CONFIG_MISC_RTSX)		+= cardreader/
+obj-y				+= throttler/
diff --git a/drivers/misc/throttler/Kconfig b/drivers/misc/throttler/Kconfig
new file mode 100644
index 000000000000..ef8388f6bc0a
--- /dev/null
+++ b/drivers/misc/throttler/Kconfig
@@ -0,0 +1,13 @@
+menuconfig THROTTLER
+	bool "Throttler support"
+	default n
+	depends on OF
+	select CPU_FREQ
+	select PM_DEVFREQ
+	help
+	  This option enables core support for non-thermal throttling of CPUs
+	  and devfreq devices.
+
+	  Note that you also need a event monitor module usually called
+	  *_throttler.
+
diff --git a/drivers/misc/throttler/Makefile b/drivers/misc/throttler/Makefile
new file mode 100644
index 000000000000..c8d920cee315
--- /dev/null
+++ b/drivers/misc/throttler/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_THROTTLER)		+= core.o
diff --git a/drivers/misc/throttler/core.c b/drivers/misc/throttler/core.c
new file mode 100644
index 000000000000..c058d03212b8
--- /dev/null
+++ b/drivers/misc/throttler/core.c
@@ -0,0 +1,373 @@
+/*
+ * Core code for non-thermal throttling
+ *
+ * Copyright (C) 2018 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/cpufreq.h>
+#include <linux/devfreq.h>
+#include <linux/kernel.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+/*
+ * Non-thermal throttling: throttling of system components in response to
+ * external events (e.g. high battery discharge current).
+ *
+ * The throttler supports throttling through cpufreq and devfreq. Multiple
+ * levels of throttling can be configured. At level 0 no throttling is
+ * active on behalf of the throttler, for values > 0 throttling is typically
+ * configured to be increasingly aggressive with each level.
+ * The number of throttling levels is not limited by the throttler (though
+ * it is likely limited by the throttling devices). It is not necessary to
+ * configure the same number of levels for all throttling devices. If the
+ * requested throttling level for a device is higher than the maximum level
+ * of the device the throttler will sleect the maximum throttling level of
+ * the device.
+ *
+ * Non-thermal throttling is split in two parts:
+ *
+ * - throttler core
+ *   - parses the thermal policy
+ *   - applies throttling settings for a requested level of throttling
+ *
+ * - event monitor driver
+ *   - monitors the events that trigger throttling
+ *   - determines the throttling level (often limited to on/off)
+ *   - requests throttler core to apply throttling settings
+ *
+ * It is possible for a system to have more than one throttler and the
+ * throttlers may make use of the same throttling devices, in case of
+ * conflicting settings for a device the more aggressive values will be
+ * applied.
+ *
+ */
+
+struct thrcfg {
+	uint32_t *freqs;
+	int num_levels;
+};
+
+struct cpufreq_thrdev {
+	uint32_t cpu;
+	struct thrcfg cfg;
+};
+
+struct devfreq_thrdev {
+	struct devfreq *devfreq;
+	struct thrcfg cfg;
+	struct throttler *thr;
+	struct notifier_block nb;
+};
+
+struct __thr_cpufreq {
+	struct cpufreq_thrdev *devs;
+	int ndevs;
+	struct notifier_block nb;
+};
+
+struct __thr_devfreq {
+	struct devfreq_thrdev *devs;
+	int ndevs;
+};
+
+struct throttler {
+	struct device *dev;
+	int level;
+	struct __thr_cpufreq cpufreq;
+	struct __thr_devfreq devfreq;
+};
+
+static unsigned long thr_get_throttling_freq(struct thrcfg *cfg, int level)
+{
+	if (level == 0 ) {
+		WARN(true, "level == 0");
+		return 0;
+	}
+
+	if (level <= cfg->num_levels)
+		return cfg->freqs[level - 1];
+	else
+		return cfg->freqs[cfg->num_levels - 1];
+}
+
+static int thr_cpufreq_event(struct notifier_block *nb,
+				    unsigned long event, void *data)
+{
+	struct throttler *thr =
+                container_of(nb, struct throttler, cpufreq.nb);
+        struct cpufreq_policy *policy = data;
+	struct cpufreq_thrdev *ctd;
+	int i;
+
+	if ((event != CPUFREQ_ADJUST) || (thr->level == 0))
+                return NOTIFY_DONE;
+
+	for (i = 0; i < thr->cpufreq.ndevs; i++) {
+		ctd = &thr->cpufreq.devs[i];
+
+		if (ctd->cpu == policy->cpu) {
+			unsigned long clamp_freq =
+				thr_get_throttling_freq(&ctd->cfg, thr->level);
+			if (clamp_freq < policy->max) {
+				cpufreq_verify_within_limits(policy, 0, clamp_freq);
+			}
+		}
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int thr_devfreq_event(struct notifier_block *nb,
+				    unsigned long event, void *data)
+{
+	struct devfreq_thrdev *dtd =
+		container_of(nb, struct devfreq_thrdev, nb);
+	struct throttler *thr = dtd->thr;
+	struct devfreq_policy *policy = data;
+	unsigned long clamp_freq;
+
+	if ((event != DEVFREQ_ADJUST) || (thr->level == 0))
+                return NOTIFY_DONE;
+
+	clamp_freq = thr_get_throttling_freq(&dtd->cfg, thr->level);
+	if (clamp_freq < policy->max)
+		devfreq_verify_within_limits(policy, 0, clamp_freq);
+
+	return NOTIFY_DONE;
+}
+
+static void thr_cpufreq_update_policy(struct throttler *thr)
+{
+	int i;
+
+	for (i = 0; i < thr->cpufreq.ndevs; i++) {
+		struct cpufreq_thrdev *ctd = &thr->cpufreq.devs[i];
+		struct cpufreq_policy *policy = cpufreq_cpu_get(ctd->cpu);
+
+		if (!policy) {
+			dev_warn(thr->dev, "CPU%d does have no cpufreq policy!\n", ctd->cpu);
+			continue;
+		}
+
+		cpufreq_update_policy(ctd->cpu);
+		cpufreq_cpu_put(policy);
+	}
+}
+
+static int thr_parse_thrcfg(struct throttler *thr,
+		struct device_node *np, struct thrcfg *cfg) {
+	int err;
+
+	cfg->num_levels =
+		of_property_count_u32_elems(np, "throttling-frequencies");
+	if (cfg->num_levels < 0) {
+		pr_err("%s: failed to determine number of throttling frequencies\n",
+		       np->full_name);
+		return cfg->num_levels;
+	}
+
+	cfg->freqs = devm_kzalloc(thr->dev,
+		cfg->num_levels * sizeof(u32), GFP_KERNEL);
+	if (!cfg->freqs)
+		return -ENOMEM;
+
+	err = of_property_read_u32_array(np, "throttling-frequencies",
+		 cfg->freqs, cfg->num_levels);
+	if (err) {
+		pr_err("%s: failed to read throttling frequencies\n", np->full_name);
+		return err;
+	}
+
+	return 0;
+}
+
+static struct devfreq *thr_find_devfreq_dev(struct throttler *thr,
+		struct device_node *np_df) {
+	struct device_node *node;
+	struct platform_device *pdev;
+
+	node = of_parse_phandle(np_df, "device", 0);
+	if (!node) {
+		pr_err("%s: failed to get devfreq parent device\n",
+		       np_df->full_name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	pdev = of_find_device_by_node(node);
+	if (!pdev) {
+		pr_err("%s: could not find devfreq parent device\n",
+		       node->full_name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return dev_to_devfreq(&pdev->dev);
+}
+
+static int thr_parse_dt(struct throttler *thr, struct device_node *np)
+{
+	struct device_node *node, *child;
+	int err, i;
+
+	node = of_get_child_by_name(np, "cpufreq");
+	if (node) {
+		thr->cpufreq.ndevs = of_get_child_count(node);
+		thr->cpufreq.devs = devm_kzalloc(thr->dev,
+			sizeof(*thr->cpufreq.devs) * thr->cpufreq.ndevs,
+			GFP_KERNEL);
+
+		i = 0;
+		for_each_child_of_node(node, child) {
+			struct cpufreq_thrdev *ctd = &thr->cpufreq.devs[i];
+
+			err = of_property_read_u32(child, "cpu", &ctd->cpu);
+			if (err) {
+				pr_err("%s: failed to read CPU id\n", child->full_name);
+				return err;
+			}
+
+			err = thr_parse_thrcfg(thr, child, &ctd->cfg);
+			if (err)
+				return err;
+
+			i++;
+		}
+	}
+
+	node = of_get_child_by_name(np, "devfreq");
+	if (node) {
+		thr->devfreq.ndevs = of_get_child_count(node);
+		thr->devfreq.devs = devm_kzalloc(thr->dev,
+			sizeof(*thr->devfreq.devs) * thr->devfreq.ndevs,
+			GFP_KERNEL);
+
+		i = 0;
+		for_each_child_of_node(node, child) {
+			struct devfreq_thrdev *dtd = &thr->devfreq.devs[i];
+
+			dtd->thr = thr;
+
+			dtd->devfreq = thr_find_devfreq_dev(thr, child);
+			if (IS_ERR(dtd->devfreq))
+				return PTR_ERR(dtd->devfreq);
+
+			err = thr_parse_thrcfg(thr, child, &dtd->cfg);
+			if (err)
+				return err;
+
+			i++;
+		}
+	}
+
+	return 0;
+}
+
+static void thr_update_devfreq(struct devfreq *devfreq)
+{
+	mutex_lock(&devfreq->lock);
+	update_devfreq(devfreq);
+	mutex_unlock(&devfreq->lock);
+}
+
+void throttler_set_level(struct throttler *thr, int level)
+{
+	int i;
+
+	if (level == thr->level)
+		return;
+
+	dev_dbg(thr->dev, "throttling level: %d\n", level);
+	thr->level = level;
+
+	if (thr->cpufreq.ndevs > 0)
+		thr_cpufreq_update_policy(thr);
+
+	if (thr->devfreq.ndevs > 0)
+		for (i = 0; i < thr->devfreq.ndevs; i++)
+			thr_update_devfreq(thr->devfreq.devs[i].devfreq);
+}
+EXPORT_SYMBOL_GPL(throttler_set_level);
+
+struct throttler *throttler_setup(struct device *dev)
+{
+	struct throttler *thr;
+	struct device_node *np = dev->of_node;
+	int err, i;
+
+	if (!np)
+		/* should never happen */
+		return ERR_PTR(-EINVAL);
+
+	thr = devm_kzalloc(dev, sizeof(*thr), GFP_KERNEL);
+	if (!thr)
+		return ERR_PTR(-ENOMEM);
+
+	thr->dev = dev;
+
+	err = thr_parse_dt(thr, np);
+	if (err)
+		return ERR_PTR(err);
+
+	if (thr->cpufreq.ndevs > 0) {
+		thr->cpufreq.nb.notifier_call = thr_cpufreq_event;
+		err = cpufreq_register_notifier(&thr->cpufreq.nb,
+						CPUFREQ_POLICY_NOTIFIER);
+		if (err < 0) {
+			dev_err(dev, "failed to register cpufreq notifier\n");
+			return ERR_PTR(err);
+		}
+	}
+
+	for (i = 0; i < thr->devfreq.ndevs; i++) {
+		struct devfreq_thrdev *dtd = &thr->devfreq.devs[i];
+
+		dtd->nb.notifier_call = thr_devfreq_event;
+		err = devm_devfreq_register_notifier(dev, dtd->devfreq,
+						     &dtd->nb, DEVFREQ_POLICY_NOTIFIER);
+		if (err < 0) {
+			dev_err(dev, "failed to register devfreq notifier\n");
+			goto err_cpufreq_unregister;
+		}
+	}
+
+	return thr;
+
+err_cpufreq_unregister:
+	if (thr->cpufreq.ndevs > 0)
+		cpufreq_unregister_notifier(&thr->cpufreq.nb,
+					    CPUFREQ_POLICY_NOTIFIER);
+
+	return ERR_PTR(err);
+}
+EXPORT_SYMBOL_GPL(throttler_setup);
+
+void throttler_teardown(struct throttler *thr)
+{
+	int i;
+
+	thr->level = 0;
+
+	if (thr->cpufreq.ndevs > 0) {
+		thr_cpufreq_update_policy(thr);
+
+		cpufreq_unregister_notifier(&thr->cpufreq.nb,
+					    CPUFREQ_POLICY_NOTIFIER);
+	}
+
+	if (thr->devfreq.ndevs > 0)
+		for (i = 0; i < thr->devfreq.ndevs; i++)
+			thr_update_devfreq(thr->devfreq.devs[i].devfreq);
+}
+EXPORT_SYMBOL_GPL(throttler_teardown);
diff --git a/include/linux/throttler.h b/include/linux/throttler.h
new file mode 100644
index 000000000000..cab8c466da4b
--- /dev/null
+++ b/include/linux/throttler.h
@@ -0,0 +1,10 @@
+#ifndef __LINUX_THROTTLER_H__
+#define __LINUX_THROTTLER_H__
+
+struct throttler;
+
+extern struct throttler *throttler_setup(struct device *dev);
+extern void throttler_teardown(struct throttler *thr);
+extern void throttler_set_level(struct throttler *thr, int level);
+
+#endif /* __LINUX_THROTTLER_H__ */
-- 
2.17.0.921.gf22659ad46-goog
