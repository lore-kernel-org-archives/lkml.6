Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ysZdAJx1GVsvDgAAmS7hNA
	; Thu, 07 Jun 2018 18:14:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 531DC608B8; Thu,  7 Jun 2018 18:14:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B2336605A2;
	Thu,  7 Jun 2018 18:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B2336605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936119AbeFGSNN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:13:13 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34637 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936104AbeFGSNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:13:07 -0400
Received: by mail-pf0-f194.google.com with SMTP id a63-v6so5306064pfl.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4lkKoPI/gN05z704Jc/wmjFYv00IA9z0us6vggpY0Os=;
        b=pj+qX+0OEEDFYG4nfV4U4mx2QbGyUpY2RBxWw0lRNeH5YToTOdxfM5YWhd2DDc7UYp
         /5kOdyWZiKr98YA633VhEEYkv3tScE+2LEU6d/oSasNRKOj1wzVkQNxVFI1FnO+Ksm4g
         4tCoL5ay5ERsSS/6TIsbwpXh7MU9zk8/wpryW7yKUG58Tz6trWX9lAEih1K/TqtDApoT
         qhNQ+q76+L/vxbJG4eKEoSmUD34RmIcztzLXncm5P9fmCyjXPDH2qBL7Ys01ExvsQg6Z
         bd0GPTNadk0nE9/gEjfQEJhvXCPvtphztuJYyIPmILhdh11ciktqQkDO1FsnfUTirGWl
         cKXQ==
X-Gm-Message-State: APt69E1AQ/FhbgXT3Xwtep49Q3Sono9ZRXmXD+1n2iNXiVJgK2uFORbq
        Ycudira1LKmJm7iOLEN5QagonQ==
X-Google-Smtp-Source: ADUXVKJPqzXo4hi3zbE+YJWTVtubffqaqjAlImS1xfPqDHAqYxBMiOwB/AJBFbtfZemB40kuCA/1Zw==
X-Received: by 2002:a62:b02:: with SMTP id t2-v6mr2756464pfi.36.1528395185827;
        Thu, 07 Jun 2018 11:13:05 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id z3-v6sm5029002pfn.36.2018.06.07.11.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:13:04 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 09/11] misc: throttler: Add core support for non-thermal throttling
Date: Thu,  7 Jun 2018 11:12:12 -0700
Message-Id: <20180607181214.30338-10-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180607181214.30338-1-mka@chromium.org>
References: <20180607181214.30338-1-mka@chromium.org>
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
---
Changes in v2:
- completely reworked the driver to support configuration through OPPs, which
  requires a more dynamic handling
- added sysfs attribute to set the level for debugging and testing
- Makefile: depend on Kconfig option to traverse throttler directory
- Kconfig: removed 'default n'
- added SPDX line instead of license boiler-plate
- added entry to MAINTAINERS file


 MAINTAINERS                     |   7 +
 drivers/misc/Kconfig            |   1 +
 drivers/misc/Makefile           |   1 +
 drivers/misc/throttler/Kconfig  |  14 +
 drivers/misc/throttler/Makefile |   1 +
 drivers/misc/throttler/core.c   | 642 ++++++++++++++++++++++++++++++++
 include/linux/throttler.h       |  11 +
 7 files changed, 677 insertions(+)
 create mode 100644 drivers/misc/throttler/Kconfig
 create mode 100644 drivers/misc/throttler/Makefile
 create mode 100644 drivers/misc/throttler/core.c
 create mode 100644 include/linux/throttler.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 92e47b5b0480..f9550e5680ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13938,6 +13938,13 @@ T:	git git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
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
index 20be70c3f118..b549ccad5215 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_ASPEED_LPC_SNOOP)	+= aspeed-lpc-snoop.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-$(CONFIG_MISC_RTSX)		+= cardreader/
+obj-$(CONFIG_THROTTLER)		+= throttler/
diff --git a/drivers/misc/throttler/Kconfig b/drivers/misc/throttler/Kconfig
new file mode 100644
index 000000000000..e561f1df5085
--- /dev/null
+++ b/drivers/misc/throttler/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menuconfig THROTTLER
+	bool "Throttler support"
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
index 000000000000..15b50c111032
--- /dev/null
+++ b/drivers/misc/throttler/core.c
@@ -0,0 +1,642 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Core code for non-thermal throttling
+ *
+ * Copyright (C) 2018 Google, Inc.
+ */
+
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/devfreq.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/sort.h>
+#include <linux/slab.h>
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
+// #define DEBUG_THROTTLER
+
+struct thr_freq_table {
+	uint32_t *freqs;
+	int n_entries;
+};
+
+struct cpufreq_thrdev {
+	uint32_t cpu;
+	struct thr_freq_table freq_table;
+	struct list_head node;
+};
+
+struct devfreq_thrdev {
+	struct devfreq *devfreq;
+	struct thr_freq_table freq_table;
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
+struct throttler {
+	struct device *dev;
+	int level;
+	struct __thr_cpufreq cpufreq;
+	struct __thr_devfreq devfreq;
+	struct mutex lock;
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
+					     int level)
+{
+	if (level == 0) {
+		WARN(true, "level == 0");
+		return ULONG_MAX;
+	}
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
+	struct device_node *np_opp_desc, *np_opp;
+	int nchilds;
+	uint32_t *freqs;
+	int nfreqs = 0;
+	int err = 0;
+
+	np_opp_desc = dev_pm_opp_of_get_opp_desc_node(opp_dev);
+	if (!np_opp_desc)
+		return -EINVAL;
+
+	nchilds = of_get_child_count(np_opp_desc);
+	if (!nchilds) {
+		err = -EINVAL;
+		goto out_node_put;
+	}
+
+	freqs = kzalloc(nchilds * sizeof(uint32_t), GFP_KERNEL);
+	if (!freqs) {
+		err = -ENOMEM;
+		goto out_node_put;
+	}
+
+	/* determine which OPPs are used by this throttler (if any) */
+	for_each_child_of_node(np_opp_desc, np_opp) {
+		int num_thr;
+		int i;
+
+		num_thr = of_property_count_u32_elems(np_opp, "opp-throttlers");
+		if (num_thr < 0)
+			continue;
+
+		for (i = 0; i < num_thr; i++) {
+			struct device_node *np_thr;
+			struct platform_device *pdev;
+
+			np_thr = of_parse_phandle(np_opp, "opp-throttlers", i);
+			if (!np_thr) {
+				dev_err(thr->dev,
+					"failed to parse phandle %d: %s\n", i,
+					np_opp->full_name);
+				continue;
+			}
+
+			pdev = of_find_device_by_node(np_thr);
+			if (!pdev) {
+				dev_err(thr->dev,
+					"could not find throttler dev: %s\n",
+					 np_thr->full_name);
+				of_node_put(np_thr);
+				continue;
+			}
+
+			/* OPP is used by this throttler */
+			if (&pdev->dev == thr->dev) {
+				u64 rate;
+
+				err = of_property_read_u64(np_opp, "opp-hz",
+							   &rate);
+				if (!err) {
+					freqs[nfreqs] = rate;
+					nfreqs++;
+				} else {
+					dev_err(thr->dev,
+						"opp-hz not found: %s\n",
+						np_opp->full_name);
+				}
+			}
+
+			of_node_put(np_thr);
+			put_device(&pdev->dev);
+		}
+	}
+
+	if (nfreqs > 0) {
+		/* sort frequencies in descending order */
+		sort(freqs, nfreqs, sizeof(*freqs), cmp_freqs, NULL);
+
+		ft->n_entries = nfreqs;
+		ft->freqs = devm_kzalloc(thr->dev,
+				  nfreqs * sizeof(*freqs), GFP_KERNEL);
+		if (!ft->freqs) {
+			err = -ENOMEM;
+			goto out_free;
+		}
+
+		memcpy(ft->freqs, freqs, nfreqs * sizeof(*freqs));
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
+			dev_err(thr->dev,
+				"failed to initialize CPU %d: %d", cpu, err);
+
+		cpumask_set_cpu(cpu, &thr->cpufreq.cm_ignore);
+		return;
+	}
+
+	cpufreq_dev = devm_kzalloc(thr->dev, sizeof(*cpufreq_dev), GFP_KERNEL);
+	if (!cpufreq_dev) {
+		dev_err(thr->dev, "%s: out of memory\n", __func__);
+		return;
+	}
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
+			/* devfreq device not throttled */
+			return;
+
+		dev_err(thr->dev,
+			"failed to init frequency table of device %s: %d",
+			dev_name(dev), err);
+		return;
+	}
+
+	dftd = devm_kzalloc(thr->dev, sizeof(*dftd), GFP_KERNEL);
+	if (!dftd) {
+		dev_err(thr->dev, "%s: out of memory\n", __func__);
+		return;
+	}
+
+	dftd->thr = thr;
+	dftd->devfreq = container_of(dev, struct devfreq, dev);
+	memcpy(&dftd->freq_table, &ft, sizeof(ft));
+
+	dftd->nb.notifier_call = thr_handle_devfreq_event;
+	err = devm_devfreq_register_notifier(thr->dev, dftd->devfreq,
+				     &dftd->nb, DEVFREQ_POLICY_NOTIFIER);
+	if (err < 0) {
+		dev_err(dev, "failed to register devfreq notifier\n");
+		devm_kfree(thr->dev, dftd);
+		return;
+	}
+
+	list_add_tail(&dftd->node, &thr->devfreq.list);
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
+	if (event != CPUFREQ_ADJUST)
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
+	}
+
+	/*
+	 * Can't do this check earlier, otherwise we might miss CPU policies
+	 * that are added after setup().
+	 */
+	if (thr->level == 0)
+		goto out;
+
+	list_for_each_entry(cftd, &thr->cpufreq.list, node) {
+		unsigned long clamp_freq;
+
+		if (cftd->cpu != policy->cpu)
+			continue;
+
+		clamp_freq = thr_get_throttling_freq(&cftd->freq_table,
+						     thr->level) / 1000;
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
+	unsigned long clamp_freq;
+
+	if ((event != DEVFREQ_ADJUST) || (thr->level == 0))
+		return NOTIFY_DONE;
+
+	clamp_freq = thr_get_throttling_freq(&dftd->freq_table, thr->level);
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
+			dev_warn(thr->dev,
+				 "CPU%d does have no cpufreq policy!\n",
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
+void throttler_set_level(struct throttler *thr, int level)
+{
+	struct devfreq_thrdev *dftd;
+
+	if (level == thr->level)
+		return;
+
+	mutex_lock(&thr->lock);
+
+	dev_dbg(thr->dev, "throttling level: %d\n", level);
+	thr->level = level;
+
+	if (!list_empty(&thr->cpufreq.list))
+		thr_cpufreq_update_policy(thr);
+
+	list_for_each_entry(dftd, &thr->devfreq.list, node) {
+		mutex_lock(&dftd->devfreq->lock);
+		update_devfreq(dftd->devfreq);
+		mutex_unlock(&dftd->devfreq->lock);
+	}
+
+	mutex_unlock(&thr->lock);
+}
+EXPORT_SYMBOL_GPL(throttler_set_level);
+
+#ifdef DEBUG_THROTTLER
+
+static ssize_t thr_show_level(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct dev_ext_attribute *ea =
+		container_of(attr, struct dev_ext_attribute, attr);
+	struct throttler *thr = ea->var;
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", thr->level);
+}
+
+static ssize_t thr_store_level(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct dev_ext_attribute *ea =
+		container_of(attr, struct dev_ext_attribute, attr);
+	struct throttler *thr = ea->var;
+	int level;
+
+	if (!kstrtoint(buf, 10, &level))
+		return -EINVAL;
+
+	throttler_set_level(thr, level);
+
+	return count;
+}
+
+#endif /* DEBUG_THROTTLER */
+
+struct throttler *throttler_setup(struct device *dev)
+{
+	struct throttler *thr;
+	struct device_node *np = dev->of_node;
+	struct class_interface *ci;
+#ifdef DEBUG_THROTTLER
+	struct dev_ext_attribute *attr;
+#endif
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
+		dev_err(dev, "failed to register cpufreq notifier\n");
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
+		dev_err(thr->dev,
+			"failed to register devfreq class interface: %d\n",
+			err);
+		cpufreq_unregister_notifier(&thr->cpufreq.nb,
+					    CPUFREQ_POLICY_NOTIFIER);
+		return ERR_PTR(err);
+	}
+
+#ifdef DEBUG_THROTTLER
+	attr = devm_kzalloc(thr->dev, sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		goto skip_attr;
+
+	attr->attr.attr.name = "level";
+	sysfs_attr_init(&attr->attr);
+	attr->attr.attr.mode = 0644;
+	attr->attr.show	= thr_show_level;
+	attr->attr.store = thr_store_level;
+	attr->var = thr;
+
+	device_create_file(thr->dev, &attr->attr);
+
+skip_attr:
+#endif
+
+	return thr;
+}
+EXPORT_SYMBOL_GPL(throttler_setup);
+
+void throttler_teardown(struct throttler *thr)
+{
+	struct devfreq_thrdev *dftd;
+	int level;
+
+	mutex_lock(&thr->lock);
+
+	level = thr->level;
+	thr->level = 0;
+
+	class_interface_unregister(&thr->devfreq.class_iface);
+
+	if (level) {
+		/* unthrottle CPUs */
+		if (!list_empty(&thr->cpufreq.list))
+			thr_cpufreq_update_policy(thr);
+
+		/* unthrottle devfreq devices */
+		list_for_each_entry(dftd, &thr->devfreq.list, node) {
+			mutex_lock(&dftd->devfreq->lock);
+			update_devfreq(dftd->devfreq);
+			mutex_unlock(&dftd->devfreq->lock);
+		}
+	}
+
+	cpufreq_unregister_notifier(&thr->cpufreq.nb,
+				    CPUFREQ_POLICY_NOTIFIER);
+
+	mutex_unlock(&thr->lock);
+}
+EXPORT_SYMBOL_GPL(throttler_teardown);
diff --git a/include/linux/throttler.h b/include/linux/throttler.h
new file mode 100644
index 000000000000..3c06054ab39c
--- /dev/null
+++ b/include/linux/throttler.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
2.18.0.rc1.242.g61856ae69a-goog
