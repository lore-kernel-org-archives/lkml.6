Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A41C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE61247DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE61247DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753713AbeGCXrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:47:42 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39282 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753652AbeGCXrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:47:39 -0400
Received: by mail-pg0-f66.google.com with SMTP id n2-v6so1646560pgq.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 16:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NWwXjvW3N03Qf5bHcBG0zkkPddP9CQl1aW5gXRol8YQ=;
        b=CpHMndKkSHJy9+Vjrnnh4hD+kQx4uRwgIdmjSIyixKJmOzfps9TyT599BZ5ia4E47a
         Y/hbmFm4zmH3u0bay54i3baHIxf0qByndCm+5ldWGbPbWQFOQr0LKo+Cl/fzmk53Uw9k
         joSYchgN4uhNUmiemt66kO6SLfZ7EOLbwq9aYO152C+4mBoBoWdYODlcn2n/NWNvUFY6
         1zQEZzXaJHf9k1kFqjuS7ElSW+IBPdev46hDC6TDXlDS5odUdroefOKtug7xTCHb29TA
         enwGammSV5rElozSUmmXbP9ZlBCj/mhk2HvVUOI1PsaQPzhPJgHDRoAWEZRgQAIpQE5B
         TF2w==
X-Gm-Message-State: APt69E2e+xwWxjFgvdkoLZI36sXjdUxYzhet5XyQYo+TBmwfrZckt6sI
        1Anm/I4JsSM9j0cwuQ2lVgEunw==
X-Google-Smtp-Source: ADUXVKIwRupbDqcNPOvv64TyH9pkVsWlFs7nYxhlAqa8wWqY0CcwY2/+hrqF+yl7uUuCF5vefLh3Cw==
X-Received: by 2002:a65:44c3:: with SMTP id g3-v6mr27238666pgs.231.1530661657695;
        Tue, 03 Jul 2018 16:47:37 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id l85-v6sm6608562pfk.79.2018.07.03.16.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 16:47:36 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 10/12] misc: throttler: Add core support for non-thermal throttling
Date:   Tue,  3 Jul 2018 16:47:03 -0700
Message-Id: <20180703234705.227473-11-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180703234705.227473-1-mka@chromium.org>
References: <20180703234705.227473-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of the throttler is to provide support for non-thermal
throttling. Throttling is triggered by external event, e.g. the
detection of a high battery discharge current, close to the OCP limit
of the battery. The throttler is only in charge of the throttling, not
the monitoring, which is done by another (possibly platform specific)
driver.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
--
Changes in v5:
- read throttling OPPs using new device tree binding (throttler-opps = <...>)
- thr_get_throttling_freq(): removed warning
- thr_handle_cpufreq_event(): merged similar loops
- thr_handle_devfreq_event(): read level once and save it in
  local variable
- thr_init_freq_table(): renamed nchilds to n_opps and nfreqs to n_freqs

Changes in v4:
- remove OOM logs
- "does have no" => "has no" in log message
- changed 'level' to unsigned int
- hold mutex in throttler_set_level() when checking if level has changed
- remove debugfs dir in throttler_teardown()
- consolidated update of all devfreq devices in thr_update_devfreq()
- added field 'shutting_down' to struct throttler
- refactored teardown to avoid deadlocks

Changes in v3:
- Kconfig: don't select CPU_FREQ and PM_DEVFREQ
- added CONFIG_THROTTLER_DEBUG option
- changed 'level' sysfs attribute to debugfs
- introduced thr_<level> macros for logging
- added debug logs
- added field clamp_freq to struct cpufreq_thrdev and devfreq_thrdev
  to keep track of the current frequency limits and avoid spammy logs

Changes in v2:
- completely reworked the driver to support configuration through OPPs, which
  requires a more dynamic handling
- added sysfs attribute to set the level for debugging and testing
- Makefile: depend on Kconfig option to traverse throttler directory
- Kconfig: removed 'default n'
- added SPDX line instead of license boiler-plate
- added entry to MAINTAINERS file
---
 MAINTAINERS                     |   7 +
 drivers/misc/Kconfig            |   1 +
 drivers/misc/Makefile           |   1 +
 drivers/misc/throttler/Kconfig  |  23 ++
 drivers/misc/throttler/Makefile |   1 +
 drivers/misc/throttler/core.c   | 697 ++++++++++++++++++++++++++++++++
 include/linux/throttler.h       |  21 +
 7 files changed, 751 insertions(+)
 create mode 100644 drivers/misc/throttler/Kconfig
 create mode 100644 drivers/misc/throttler/Makefile
 create mode 100644 drivers/misc/throttler/core.c
 create mode 100644 include/linux/throttler.h

diff --git a/MAINTAINERS b/MAINTAINERS
index dc241b04d1bd..df974c0d85a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14057,6 +14057,13 @@ T:	git git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
 S:	Maintained
 F:	drivers/platform/x86/thinkpad_acpi.c
 
+THROTTLER DRIVERS
+M:	Matthias Kaehlcke <mka@chromium.org>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/misc/throttler/
+F:	include/linux/throttler.h
+
 THUNDERBOLT DRIVER
 M:	Andreas Noever <andreas.noever@gmail.com>
 M:	Michael Jamet <michael.jamet@intel.com>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 3726eacdf65d..717fa3bd0e09 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -527,4 +527,5 @@ source "drivers/misc/echo/Kconfig"
 source "drivers/misc/cxl/Kconfig"
 source "drivers/misc/ocxl/Kconfig"
 source "drivers/misc/cardreader/Kconfig"
+source "drivers/misc/throttler/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index af22bbc3d00c..0f4ecc6a7532 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -58,3 +58,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-$(CONFIG_MISC_RTSX)		+= cardreader/
+obj-$(CONFIG_THROTTLER)		+= throttler/
diff --git a/drivers/misc/throttler/Kconfig b/drivers/misc/throttler/Kconfig
new file mode 100644
index 000000000000..8b2e63b2ef48
--- /dev/null
+++ b/drivers/misc/throttler/Kconfig
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menuconfig THROTTLER
+	bool "Throttler support"
+	depends on OF
+	help
+	  This option enables core support for non-thermal throttling of CPUs
+	  and devfreq devices.
+
+	  Note that you also need a event monitor module usually called
+	  *_throttler.
+
+if THROTTLER
+
+menuconfig THROTTLER_DEBUG
+	bool "Enable throttler debugging"
+	help
+	  This option enables throttler debugging features like additional
+	  logging and a debugfs attribute for setting the logging level.
+
+	  Choose N unless you want to debug throttler drivers.
+
+endif # THROTTLER
diff --git a/drivers/misc/throttler/Makefile b/drivers/misc/throttler/Makefile
new file mode 100644
index 000000000000..c8d920cee315
--- /dev/null
+++ b/drivers/misc/throttler/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_THROTTLER)		+= core.o
diff --git a/drivers/misc/throttler/core.c b/drivers/misc/throttler/core.c
new file mode 100644
index 000000000000..44c99e380aa0
--- /dev/null
+++ b/drivers/misc/throttler/core.c
@@ -0,0 +1,697 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Core code for non-thermal throttling
+ *
+ * Copyright (C) 2018 Google, Inc.
+ */
+
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/debugfs.h>
+#include <linux/devfreq.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+#include <linux/sort.h>
+#include <linux/throttler.h>
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
+ * of the device the throttler will select the maximum throttling level of
+ * the device.
+ *
+ * Non-thermal throttling is split in two parts:
+ *
+ * - throttler core
+ *   - parses the thermal policy
+ *   - applies throttling settings for a requested level of throttling
+ *
+ * - event monitor driver
+ *   - monitors events that trigger throttling
+ *   - determines the throttling level (often limited to on/off)
+ *   - asks throttler core to apply throttling settings
+ *
+ * It is possible for a system to have more than one throttler and the
+ * throttlers may make use of the same throttling devices, in case of
+ * conflicting settings for a device the more aggressive values will be
+ * applied.
+ *
+ */
+
+#define ci_to_throttler(ci) \
+	container_of(ci, struct throttler, devfreq.class_iface)
+
+struct thr_freq_table {
+	uint32_t *freqs;
+	int n_entries;
+};
+
+struct cpufreq_thrdev {
+	uint32_t cpu;
+	struct thr_freq_table freq_table;
+	uint32_t clamp_freq;
+	struct list_head node;
+};
+
+struct devfreq_thrdev {
+	struct devfreq *devfreq;
+	struct thr_freq_table freq_table;
+	uint32_t clamp_freq;
+	struct throttler *thr;
+	struct notifier_block nb;
+	struct list_head node;
+};
+
+struct __thr_cpufreq {
+	struct list_head list;
+	cpumask_t cm_initialized;
+	cpumask_t cm_ignore;
+	struct notifier_block nb;
+};
+
+struct __thr_devfreq {
+	struct list_head list;
+	struct class_interface class_iface;
+};
+
+struct __thr_debugfs {
+	struct dentry *dir;
+	struct dentry *attr_level;
+};
+
+struct throttler {
+	struct device *dev;
+	unsigned int level;
+	struct __thr_cpufreq cpufreq;
+	struct __thr_devfreq devfreq;
+	struct mutex lock;
+	bool shutting_down;
+#ifdef CONFIG_THROTTLER_DEBUG
+	struct __thr_debugfs debugfs;
+#endif
+};
+
+static inline int cmp_freqs(const void *a, const void *b)
+{
+	const uint32_t *pa = a, *pb = b;
+
+	if (*pa < *pb)
+		return 1;
+	else if (*pa > *pb)
+		return -1;
+
+	return 0;
+}
+
+static int thr_handle_devfreq_event(struct notifier_block *nb,
+				    unsigned long event, void *data);
+
+static unsigned long thr_get_throttling_freq(struct thr_freq_table *ft,
+					     unsigned int level)
+{
+	if (level == 0)
+		return ULONG_MAX;
+
+	if (level <= ft->n_entries)
+		return ft->freqs[level - 1];
+	else
+		return ft->freqs[ft->n_entries - 1];
+}
+
+static int thr_init_freq_table(struct throttler *thr, struct device *opp_dev,
+			       struct thr_freq_table *ft)
+{
+	struct device_node *np_opp_desc;
+	int n_opps;
+	int n_thr_opps;
+	int i;
+	uint32_t *freqs;
+	int n_freqs = 0;
+	int err = 0;
+
+	np_opp_desc = dev_pm_opp_of_get_opp_desc_node(opp_dev);
+	if (!np_opp_desc)
+		return -EINVAL;
+
+	n_opps = of_get_child_count(np_opp_desc);
+	if (!n_opps) {
+		err = -EINVAL;
+		goto out_node_put;
+	}
+
+	freqs = kzalloc(n_opps * sizeof(uint32_t), GFP_KERNEL);
+	if (!freqs) {
+		err = -ENOMEM;
+		goto out_node_put;
+	}
+
+	n_thr_opps = of_property_count_u32_elems(thr->dev->of_node,
+						 "throttler-opps");
+	if (n_thr_opps <= 0) {
+		thr_err(thr, "No OPPs configured for throttling\n");
+		err = -EINVAL;
+		goto out_free;
+	}
+
+	for (i = 0; i < n_thr_opps; i++) {
+		struct device_node *np_opp;
+		u64 rate;
+
+		np_opp = of_parse_phandle(thr->dev->of_node, "throttler-opps",
+					  i);
+		if (!np_opp) {
+			thr_err(thr,
+				"failed to parse phandle %d: %s\n", i,
+				np_opp->full_name);
+			continue;
+		}
+
+		if (of_get_parent(np_opp) != np_opp_desc) {
+			of_node_put(np_opp);
+			continue;
+		}
+
+		err = of_property_read_u64(np_opp, "opp-hz",
+					   &rate);
+		if (!err) {
+			freqs[n_freqs] = rate;
+			n_freqs++;
+
+			thr_dbg(thr,
+				"OPP %s (%llu MHz) is used for throttling\n",
+				np_opp->full_name,
+				rate / 1000000);
+		} else {
+			thr_err(thr, "opp-hz not found: %s\n",
+				np_opp->full_name);
+		}
+
+		of_node_put(np_opp);
+	}
+
+	if (n_freqs > 0) {
+		/* sort frequencies in descending order */
+		sort(freqs, n_freqs, sizeof(*freqs), cmp_freqs, NULL);
+
+		ft->n_entries = n_freqs;
+		ft->freqs = devm_kzalloc(thr->dev,
+				  n_freqs * sizeof(*freqs), GFP_KERNEL);
+		if (!ft->freqs) {
+			err = -ENOMEM;
+			goto out_free;
+		}
+
+		memcpy(ft->freqs, freqs, n_freqs * sizeof(*freqs));
+	} else {
+		err = -ENODEV;
+	}
+
+out_free:
+	kfree(freqs);
+
+out_node_put:
+	of_node_put(np_opp_desc);
+
+	return err;
+}
+
+static void thr_cpufreq_init(struct throttler *thr, int cpu)
+{
+	struct device *cpu_dev;
+	struct thr_freq_table ft;
+	struct cpufreq_thrdev *cpufreq_dev;
+	int err;
+
+	WARN_ON(!mutex_is_locked(&thr->lock));
+
+	cpu_dev = get_cpu_device(cpu);
+	if (!cpu_dev) {
+		dev_err_ratelimited(thr->dev, "failed to get CPU %d\n", cpu);
+		return;
+	}
+
+	err = thr_init_freq_table(thr, cpu_dev, &ft);
+	if (err) {
+		/* CPU is not throttled or initialization failed */
+		if (err != -ENODEV)
+			thr_err(thr, "failed to initialize CPU %d: %d", cpu,
+				err);
+
+		cpumask_set_cpu(cpu, &thr->cpufreq.cm_ignore);
+		return;
+	}
+
+	cpufreq_dev = devm_kzalloc(thr->dev, sizeof(*cpufreq_dev), GFP_KERNEL);
+	if (!cpufreq_dev)
+		return;
+
+	cpufreq_dev->cpu = cpu;
+	memcpy(&cpufreq_dev->freq_table, &ft, sizeof(ft));
+	list_add_tail(&cpufreq_dev->node, &thr->cpufreq.list);
+
+	cpumask_set_cpu(cpu, &thr->cpufreq.cm_initialized);
+}
+
+static void thr_devfreq_init(struct device *dev, void *data)
+{
+	struct throttler *thr = data;
+	struct thr_freq_table ft;
+	struct devfreq_thrdev *dftd;
+	int err;
+
+	WARN_ON(!mutex_is_locked(&thr->lock));
+
+	err = thr_init_freq_table(thr, dev->parent, &ft);
+	if (err) {
+		if (err == -ENODEV)
+			return;
+
+		thr_err(thr, "failed to init frequency table of device %s: %d",
+			dev_name(dev), err);
+		return;
+	}
+
+	dftd = devm_kzalloc(thr->dev, sizeof(*dftd), GFP_KERNEL);
+	if (!dftd)
+		return;
+
+	dftd->thr = thr;
+	dftd->devfreq = container_of(dev, struct devfreq, dev);
+	memcpy(&dftd->freq_table, &ft, sizeof(ft));
+
+	dftd->nb.notifier_call = thr_handle_devfreq_event;
+	err = devm_devfreq_register_notifier(thr->dev, dftd->devfreq,
+				     &dftd->nb, DEVFREQ_POLICY_NOTIFIER);
+	if (err < 0) {
+		thr_err(thr, "failed to register devfreq notifier\n");
+		devm_kfree(thr->dev, dftd);
+		return;
+	}
+
+	list_add_tail(&dftd->node, &thr->devfreq.list);
+
+	thr_dbg(thr, "device '%s' is used for throttling\n",
+		dev_name(dev));
+}
+
+static int thr_handle_cpufreq_event(struct notifier_block *nb,
+				unsigned long event, void *data)
+{
+	struct throttler *thr =
+		container_of(nb, struct throttler, cpufreq.nb);
+	struct cpufreq_policy *policy = data;
+	struct cpufreq_thrdev *cftd;
+
+	if ((event != CPUFREQ_ADJUST) || thr->shutting_down)
+		return 0;
+
+	mutex_lock(&thr->lock);
+
+	if (cpumask_test_cpu(policy->cpu, &thr->cpufreq.cm_ignore))
+		goto out;
+
+	if (!cpumask_test_cpu(policy->cpu, &thr->cpufreq.cm_initialized)) {
+		thr_cpufreq_init(thr, policy->cpu);
+
+		if (cpumask_test_cpu(policy->cpu, &thr->cpufreq.cm_ignore))
+			goto out;
+
+		thr_dbg(thr, "CPU%d is used for throttling\n", policy->cpu);
+	}
+
+	list_for_each_entry(cftd, &thr->cpufreq.list, node) {
+		unsigned long clamp_freq;
+
+		if (cftd->cpu != policy->cpu)
+			continue;
+
+		if (thr->level == 0) {
+			if (cftd->clamp_freq != 0) {
+				thr_dbg(thr, "unthrottling CPU%d\n", cftd->cpu);
+				cftd->clamp_freq = 0;
+			}
+
+			continue;
+		}
+
+		clamp_freq = thr_get_throttling_freq(&cftd->freq_table,
+						     thr->level) / 1000;
+		if (cftd->clamp_freq != clamp_freq) {
+			thr_dbg(thr, "throttling CPU%d to %lu MHz\n", cftd->cpu,
+				clamp_freq / 1000);
+			cftd->clamp_freq = clamp_freq;
+		}
+
+		if (clamp_freq < policy->max)
+			cpufreq_verify_within_limits(policy, 0, clamp_freq);
+	}
+
+out:
+	mutex_unlock(&thr->lock);
+
+	return NOTIFY_DONE;
+}
+
+/*
+ * Notifier called by devfreq. Can't acquire thr->lock since it might
+ * already be held by throttler_set_level(). It isn't necessary to
+ * acquire the lock for the following reasons:
+ *
+ * Only the devfreq_thrdev and thr->level are accessed in this function.
+ * The devfreq device won't go away (or change) during the execution of
+ * this function, since we are called from the devfreq core. Theoretically
+ * thr->level could change and we'd apply an outdated setting, however in
+ * this case the function would run again shortly after and apply the
+ * correct value.
+ */
+static int thr_handle_devfreq_event(struct notifier_block *nb,
+				    unsigned long event, void *data)
+{
+	struct devfreq_thrdev *dftd =
+		container_of(nb, struct devfreq_thrdev, nb);
+	struct throttler *thr = dftd->thr;
+	struct devfreq_policy *policy = data;
+	int level = READ_ONCE(thr->level);
+	unsigned long clamp_freq;
+
+	if ((event != DEVFREQ_ADJUST) || thr->shutting_down)
+		return NOTIFY_DONE;
+
+	if (level == 0) {
+		if (dftd->clamp_freq != 0) {
+			thr_dbg(thr, "unthrottling '%s'\n",
+				dev_name(&dftd->devfreq->dev));
+			dftd->clamp_freq = 0;
+		}
+
+		return NOTIFY_DONE;
+	}
+
+	clamp_freq = thr_get_throttling_freq(&dftd->freq_table, level);
+	if (clamp_freq != dftd->clamp_freq) {
+		thr_dbg(thr, "throttling '%s' to %lu MHz\n",
+			dev_name(&dftd->devfreq->dev), clamp_freq / 1000000);
+		dftd->clamp_freq = clamp_freq;
+	}
+
+	if (clamp_freq < policy->max)
+		devfreq_verify_within_limits(policy, 0, clamp_freq);
+
+	return NOTIFY_DONE;
+}
+
+static void thr_cpufreq_update_policy(struct throttler *thr)
+{
+	struct cpufreq_thrdev *cftd;
+
+	WARN_ON(!mutex_is_locked(&thr->lock));
+
+	list_for_each_entry(cftd, &thr->cpufreq.list, node) {
+		struct cpufreq_policy *policy = cpufreq_cpu_get(cftd->cpu);
+
+		if (!policy) {
+			thr_warn(thr, "CPU%d has no cpufreq policy!\n",
+				 cftd->cpu);
+			continue;
+		}
+
+		/*
+		 * The lock isn't really needed in this function, the list
+		 * of cpufreq devices can be extended, but no items are
+		 * deleted during the lifetime of the throttler. Releasing
+		 * the lock is necessary since cpufreq_update_policy() ends
+		 * up calling thr_handle_cpufreq_event(), which needs to
+		 * acquire the lock.
+		 */
+		mutex_unlock(&thr->lock);
+		cpufreq_update_policy(cftd->cpu);
+		mutex_lock(&thr->lock);
+
+		cpufreq_cpu_put(policy);
+	}
+}
+
+static void thr_update_devfreq(struct throttler *thr)
+{
+	struct devfreq_thrdev *dftd;
+
+	WARN_ON(!mutex_is_locked(&thr->lock));
+
+	list_for_each_entry(dftd, &thr->devfreq.list, node) {
+		mutex_lock(&dftd->devfreq->lock);
+		update_devfreq(dftd->devfreq);
+		mutex_unlock(&dftd->devfreq->lock);
+	}
+}
+
+static int thr_handle_devfreq_added(struct device *dev,
+				    struct class_interface *ci)
+{
+	struct throttler *thr = ci_to_throttler(ci);
+
+	mutex_lock(&thr->lock);
+	thr_devfreq_init(dev, thr);
+	mutex_unlock(&thr->lock);
+
+	return 0;
+}
+
+static void thr_handle_devfreq_removed(struct device *dev,
+				       struct class_interface *ci)
+{
+	struct devfreq_thrdev *dftd;
+	struct throttler *thr = ci_to_throttler(ci);
+
+	mutex_lock(&thr->lock);
+
+	list_for_each_entry(dftd, &thr->devfreq.list, node) {
+		if (dev == &dftd->devfreq->dev) {
+			list_del(&dftd->node);
+			devm_kfree(thr->dev, dftd->freq_table.freqs);
+			devm_kfree(thr->dev, dftd);
+			break;
+		}
+	}
+
+	mutex_unlock(&thr->lock);
+}
+
+void throttler_set_level(struct throttler *thr, unsigned int level)
+{
+	mutex_lock(&thr->lock);
+
+	if ((level == thr->level) || thr->shutting_down) {
+		mutex_unlock(&thr->lock);
+		return;
+	}
+
+	thr_dbg(thr, "throttling level: %u\n", level);
+	thr->level = level;
+
+	if (!list_empty(&thr->cpufreq.list))
+		thr_cpufreq_update_policy(thr);
+
+	thr_update_devfreq(thr);
+
+	mutex_unlock(&thr->lock);
+}
+EXPORT_SYMBOL_GPL(throttler_set_level);
+
+#ifdef CONFIG_THROTTLER_DEBUG
+
+static ssize_t thr_level_read(struct file *file, char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	struct throttler *thr = file->f_inode->i_private;
+	char buf[5];
+	int len;
+
+	len = scnprintf(buf, sizeof(buf), "%u\n", thr->level);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t thr_level_write(struct file *file,
+				 const char __user *user_buf,
+				 size_t count, loff_t *ppos)
+{
+	int rc;
+	unsigned int level;
+	struct throttler *thr = file->f_inode->i_private;
+
+	rc = kstrtouint_from_user(user_buf, count, 10, &level);
+	if (rc)
+		return rc;
+
+	throttler_set_level(thr, level);
+
+	return count;
+}
+
+static const struct file_operations level_debugfs_ops = {
+	.owner = THIS_MODULE,
+	.read = thr_level_read,
+	.write = thr_level_write,
+};
+#endif
+
+struct throttler *throttler_setup(struct device *dev)
+{
+	struct throttler *thr;
+	struct device_node *np = dev->of_node;
+	struct class_interface *ci;
+	int cpu;
+	int err;
+
+	if (!np)
+		/* should never happen */
+		return ERR_PTR(-EINVAL);
+
+	thr = devm_kzalloc(dev, sizeof(*thr), GFP_KERNEL);
+	if (!thr)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&thr->lock);
+	thr->dev = dev;
+
+	cpumask_clear(&thr->cpufreq.cm_ignore);
+	cpumask_clear(&thr->cpufreq.cm_initialized);
+
+	INIT_LIST_HEAD(&thr->cpufreq.list);
+	INIT_LIST_HEAD(&thr->devfreq.list);
+
+	thr->cpufreq.nb.notifier_call = thr_handle_cpufreq_event;
+	err = cpufreq_register_notifier(&thr->cpufreq.nb,
+					CPUFREQ_POLICY_NOTIFIER);
+	if (err < 0) {
+		thr_err(thr, "failed to register cpufreq notifier\n");
+		return ERR_PTR(err);
+	}
+
+	/*
+	 * The CPU throttling configuration is parsed at runtime, when the
+	 * cpufreq policy notifier is called for a CPU that hasn't been
+	 * initialized yet.
+	 *
+	 * This is done for two reasons:
+	 * -  when the throttler is probed the CPU might not yet have a policy
+	 * -  CPUs that were offline at probe time might be hotplugged
+	 *
+	 * The notifier is called then the policy is added/set
+	 */
+	for_each_online_cpu(cpu) {
+		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+
+		if (!policy)
+			continue;
+
+		cpufreq_update_policy(cpu);
+		cpufreq_cpu_put(policy);
+	}
+
+	/*
+	 * devfreq devices can be added and removed at runtime, hence they
+	 * must also be handled dynamically. The class_interface notifies us
+	 * whenever a device is added or removed. When the interface is
+	 * registered ci->add_dev() is called for all existing devfreq
+	 * devices.
+	 */
+	ci = &thr->devfreq.class_iface;
+	ci->class = devfreq_class;
+	ci->add_dev = thr_handle_devfreq_added;
+	ci->remove_dev = thr_handle_devfreq_removed;
+
+	err = class_interface_register(ci);
+	if (err) {
+		thr_err(thr, "failed to register devfreq class interface: %d\n",
+			err);
+		cpufreq_unregister_notifier(&thr->cpufreq.nb,
+					    CPUFREQ_POLICY_NOTIFIER);
+		return ERR_PTR(err);
+	}
+
+#ifdef CONFIG_THROTTLER_DEBUG
+	thr->debugfs.dir = debugfs_create_dir(dev_name(thr->dev), NULL);
+	if (IS_ERR(thr->debugfs.dir)) {
+		thr_warn(thr, "failed to create debugfs directory: %ld\n",
+			 PTR_ERR(thr->debugfs.dir));
+		thr->debugfs.dir = NULL;
+		goto skip_debugfs;
+	}
+
+	thr->debugfs.attr_level = debugfs_create_file("level", 0644,
+						      thr->debugfs.dir, thr,
+						      &level_debugfs_ops);
+	if (IS_ERR(thr->debugfs.dir)) {
+		thr_warn(thr, "failed to create debugfs attribute: %ld\n",
+			 PTR_ERR(thr->debugfs.attr_level));
+		debugfs_remove(thr->debugfs.dir);
+		thr->debugfs.dir = NULL;
+	}
+
+skip_debugfs:
+#endif
+
+	return thr;
+}
+EXPORT_SYMBOL_GPL(throttler_setup);
+
+void throttler_teardown(struct throttler *thr)
+{
+#ifdef CONFIG_THROTTLER_DEBUG
+	debugfs_remove_recursive(thr->debugfs.dir);
+#endif
+
+	/*
+	 * Indicate notifiers and _set_level() that we are shutting down.
+	 * If a notifier starts before the flag is set it may still apply
+	 * throttling settings. This is not a  problem since we explicitly
+	 * trigger the notifiers (again) below to unthrottle CPUs and
+	 * devfreq devices.
+	 */
+	 thr->shutting_down = true;
+
+	/*
+	 * Unregister without the lock being held to avoid possible
+	 * deadlock with notifier calls.
+	 */
+	cpufreq_unregister_notifier(&thr->cpufreq.nb,
+				    CPUFREQ_POLICY_NOTIFIER);
+
+	mutex_lock(&thr->lock);
+
+	if (thr->level) {
+		/* Unthrottle CPUs */
+		if (!list_empty(&thr->cpufreq.list))
+			thr_cpufreq_update_policy(thr);
+
+		/* Unthrottle devfreq devices */
+		thr_update_devfreq(thr);
+	}
+
+	mutex_unlock(&thr->lock);
+
+	/*
+	 * Unregistering the class interface must be done without holding the
+	 * lock, since it results in calling thr_handle_devfreq_removed(),
+	 * which acquires the lock.
+	 */
+	class_interface_unregister(&thr->devfreq.class_iface);
+}
+EXPORT_SYMBOL_GPL(throttler_teardown);
diff --git a/include/linux/throttler.h b/include/linux/throttler.h
new file mode 100644
index 000000000000..c43ab1acd96b
--- /dev/null
+++ b/include/linux/throttler.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_THROTTLER_H__
+#define __LINUX_THROTTLER_H__
+
+struct throttler;
+
+extern struct throttler *throttler_setup(struct device *dev);
+extern void throttler_teardown(struct throttler *thr);
+extern void throttler_set_level(struct throttler *thr, unsigned int level);
+
+#ifdef CONFIG_THROTTLER_DEBUG
+#define thr_dbg(thr, fmt, ...) dev_info(thr->dev, fmt, ##__VA_ARGS__)
+#else
+#define thr_dbg(thr, fmt, ...) dev_dbg(thr->dev, fmt, ##__VA_ARGS__)
+#endif
+
+#define thr_info(thr, fmt, ...) dev_info(thr->dev, fmt, ##__VA_ARGS__)
+#define thr_warn(thr, fmt, ...) dev_warn(thr->dev, fmt, ##__VA_ARGS__)
+#define thr_err(thr, fmt, ...) dev_warn(thr->dev, fmt, ##__VA_ARGS__)
+
+#endif /* __LINUX_THROTTLER_H__ */
-- 
2.18.0.203.gfac676dfb9-goog

