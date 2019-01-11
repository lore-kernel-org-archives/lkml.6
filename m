Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C31CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3CB42146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ea+tXU+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbfAKJSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:18:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45369 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731454AbfAKJSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:18:48 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so6675257pfd.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qmq0f5XeDVJLjRVWj3N8YMq3dm8lgjl/oG94/lty/m4=;
        b=ea+tXU+xB7CQSE6gnYzh5+nAGW4qw2MFg6UD6edhWrTrc8fSOySy2pu71i7U4OXfn1
         TsrwerDLeLosFOg5FWQD6UBiGQSqEDht9ZwnpOVQkuAVoCeQTuFeirI+ag1ZEOB40aGx
         7xtpNBkRWJQ/IZWfOaPtE4ML86oYQDFVG3Z1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qmq0f5XeDVJLjRVWj3N8YMq3dm8lgjl/oG94/lty/m4=;
        b=Db5cLVPlP4/eqGlbRaK/PpMZYD2boS0GatrPNzMJKgRKkypiEoEYxAGClrsqDy7kHq
         3NexXAZcCM+xw7hdn3jJnpXQx8lJaWQJI7V9pe7YpI+fURRd9DdwxjWzzxEgXyZ6aJXC
         Tm25CRVkYNLd8IoCvw6KWZ0exB+ENB08VH7wCktubpn3j3/keAPJayoaAwbdphgHPIrV
         ox6ybgKktYkVDe3spcH23T+DE9NpZ6c5XIduH+NNv5/78DBZhnxgMj2DfRXGHvWB+OIE
         2jo0B4t0Z5B+uWKUNE98+vDQ3OwFOJnfIT3PjtsVafge8zvF0TRXYK3jbBuj8V244RzW
         9jTA==
X-Gm-Message-State: AJcUukcyXEQjBWfU6vbZPMxipTEwsL4Fi25pvEehZYd0cNgBQaXvTGGl
        Z/LcWIatwfXms2pvQr6hlbe8+A==
X-Google-Smtp-Source: ALg8bN54ooSDkzWwvL8IbZC7Y2SKOH4buhJuYDzCdmRn/RIcd8UxGd2E3EAFK9eL5BEGnC4Q2itPFw==
X-Received: by 2002:a62:cec6:: with SMTP id y189mr14283106pfg.100.1547198327462;
        Fri, 11 Jan 2019 01:18:47 -0800 (PST)
Received: from localhost ([122.172.34.203])
        by smtp.gmail.com with ESMTPSA id 84sm275652286pfa.115.2019.01.11.01.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 01:18:46 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drivers: base: Add frequency constraint infrastructure
Date:   Fri, 11 Jan 2019 14:48:34 +0530
Message-Id: <f3980beb6f2c02427d892a4bc4a04989544a3952.1547197612.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce00
In-Reply-To: <cover.1547197612.git.viresh.kumar@linaro.org>
References: <cover.1547197612.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit introduces the frequency constraint infrastructure, which
provides a generic interface for parts of the kernel to constraint the
working frequency range of a device.

The primary users of this are the cpufreq and devfreq frameworks. The
cpufreq framework already implements such constraints with help of
notifier chains (for thermal and other constraints) and some local code
(for user-space constraints). The devfreq framework developers have also
shown interest in such a framework, which may use it at a later point of
time.

The idea here is to provide a generic interface and get rid of the
notifier based mechanism.

Frameworks like cpufreq and devfreq need to provide a callback, which
the freq-constraint core will call on updates to the constraints, with
the help of freq_constraint_{set|remove}_dev_callback() OR
freq_constraint_{set|remove}_cpumask_callback() helpers.

Individual constraints can be managed by any part of the kernel with the
help of freq_constraint_{add|remove|update}() helpers.

Whenever a device constraint is added, removed or updated, the
freq-constraint core re-calculates the aggregated constraints on the
device and calls the callback if the min-max range has changed.

The current constraints on a device can be read using
freq_constraints_get().

Co-developed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 MAINTAINERS                     |   8 +
 drivers/base/Kconfig            |   5 +
 drivers/base/Makefile           |   1 +
 drivers/base/freq_constraint.c  | 633 ++++++++++++++++++++++++++++++++++++++++
 include/linux/freq_constraint.h |  45 +++
 5 files changed, 692 insertions(+)
 create mode 100644 drivers/base/freq_constraint.c
 create mode 100644 include/linux/freq_constraint.h

diff --git a/MAINTAINERS b/MAINTAINERS
index f6fc1b9dc00b..5b0ad4956d31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6176,6 +6176,14 @@ F:	Documentation/power/freezing-of-tasks.txt
 F:	include/linux/freezer.h
 F:	kernel/freezer.c
 
+FREQUENCY CONSTRAINTS
+M:	Viresh Kumar <vireshk@kernel.org>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
+F:	drivers/base/freq_constraint.c
+F:	include/linux/freq_constraint.h
+
 FRONTSWAP API
 M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 3e63a900b330..d53eb18ab732 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -26,6 +26,11 @@ config UEVENT_HELPER_PATH
 	  via /proc/sys/kernel/hotplug or via /sys/kernel/uevent_helper
 	  later at runtime.
 
+config DEVICE_FREQ_CONSTRAINT
+	bool
+	help
+	  Enable support for device frequency constraints.
+
 config DEVTMPFS
 	bool "Maintain a devtmpfs filesystem to mount at /dev"
 	help
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 157452080f3d..7530cbfd3cf8 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_PINCTRL) += pinctrl.o
 obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
 obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
+obj-$(CONFIG_DEVICE_FREQ_CONSTRAINT) += freq_constraint.o
 
 obj-y			+= test/
 
diff --git a/drivers/base/freq_constraint.c b/drivers/base/freq_constraint.c
new file mode 100644
index 000000000000..91356bae1af8
--- /dev/null
+++ b/drivers/base/freq_constraint.c
@@ -0,0 +1,633 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This manages frequency constraints on devices.
+ *
+ * Copyright (C) 2019 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpu.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/freq_constraint.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+
+struct freq_constraint_dev {
+	struct list_head node;
+	struct device *dev;
+};
+
+struct freq_pair {
+	unsigned long min;
+	unsigned long max;
+};
+
+struct freq_constraint {
+	struct list_head node;
+	enum freq_constraint_type type;
+	struct freq_pair freq;
+};
+
+struct freq_constraints {
+	struct list_head node;
+	struct list_head devices;
+	struct list_head constraints;
+	void (*callback)(void *param);
+	void *callback_param;
+	struct kref kref;
+	struct mutex lock;
+	struct work_struct work;
+
+	/* Aggregated constraint values */
+	struct freq_pair freq;
+};
+
+enum fc_event {
+	ADD,
+	REMOVE,
+	UPDATE
+};
+
+/* List of all frequency constraints */
+static LIST_HEAD(fcs_list);
+static DEFINE_MUTEX(fc_mutex);
+
+/* Return true if aggregated constraints are updated, else false */
+static bool fcs_reevaluate(struct freq_constraints *fcs)
+{
+	struct freq_pair limits[FREQ_CONSTRAINT_MAX] = {
+			[0 ... FREQ_CONSTRAINT_MAX - 1] = {0, ULONG_MAX} };
+	struct freq_constraint *constraint;
+	unsigned long min = 0, max = ULONG_MAX;
+	bool updated = false;
+	int i;
+
+	/* Find min/max freq under each constraint type */
+	list_for_each_entry(constraint, &fcs->constraints, node) {
+		if (constraint->freq.min > limits[constraint->type].min)
+			limits[constraint->type].min = constraint->freq.min;
+
+		if (constraint->freq.max < limits[constraint->type].max)
+			limits[constraint->type].max = constraint->freq.max;
+	}
+
+	/*
+	 * Resolve possible 'internal' conflicts for each constraint type,
+	 * the max limit wins over the min.
+	 */
+	for (i = 0; i < FREQ_CONSTRAINT_MAX; i++) {
+		if (limits[i].min > limits[i].max)
+			limits[i].min = limits[i].max;
+	}
+
+	/*
+	 * Thermal constraints are always honored, adjust conflicting other
+	 * constraints.
+	 */
+	if (limits[FREQ_CONSTRAINT_USER].min > limits[FREQ_CONSTRAINT_THERMAL].max)
+		limits[FREQ_CONSTRAINT_USER].min = 0;
+
+	if (limits[FREQ_CONSTRAINT_USER].max < limits[FREQ_CONSTRAINT_THERMAL].min)
+		limits[FREQ_CONSTRAINT_USER].max = ULONG_MAX;
+
+	for (i = 0; i < FREQ_CONSTRAINT_MAX; i++) {
+		min = max(min, limits[i].min);
+		max = min(max, limits[i].max);
+	}
+
+	WARN_ON(min > max);
+
+	if (fcs->freq.min != min) {
+		fcs->freq.min = min;
+		updated = true;
+	}
+
+	if (fcs->freq.max != max) {
+		fcs->freq.max = max;
+		updated = true;
+	}
+
+	return updated;
+}
+
+/* Return true if aggregated constraints are updated, else false */
+static bool _fcs_update(struct freq_constraints *fcs, struct freq_pair *freq,
+			enum fc_event event)
+{
+	bool updated = false;
+
+	switch (event) {
+	case ADD:
+		if (freq->min > fcs->freq.max || freq->max < fcs->freq.min)
+			return fcs_reevaluate(fcs);
+
+		if (freq->min > fcs->freq.min) {
+			fcs->freq.min = freq->min;
+			updated = true;
+		}
+
+		if (freq->max < fcs->freq.max) {
+			fcs->freq.max = freq->max;
+			updated = true;
+		}
+
+		return updated;
+
+	case REMOVE:
+		if (freq->min == fcs->freq.min || freq->max == fcs->freq.max)
+			return fcs_reevaluate(fcs);
+
+		return false;
+
+	case UPDATE:
+		return fcs_reevaluate(fcs);
+
+	default:
+		WARN_ON(1);
+		return false;
+	}
+}
+
+static void fcs_update(struct freq_constraints *fcs, struct freq_pair *freq,
+		       enum fc_event event)
+{
+	mutex_lock(&fcs->lock);
+
+	if (_fcs_update(fcs, freq, event)) {
+		if (fcs->callback)
+			schedule_work(&fcs->work);
+	}
+
+	mutex_unlock(&fcs->lock);
+}
+
+static void fcs_work_handler(struct work_struct *work)
+{
+	struct freq_constraints *fcs = container_of(work,
+			struct freq_constraints, work);
+
+	fcs->callback(fcs->callback_param);
+}
+
+static void free_fcdev(struct freq_constraint_dev *fcdev,
+		       struct freq_constraints *fcs)
+{
+	mutex_lock(&fcs->lock);
+	list_del(&fcdev->node);
+	mutex_unlock(&fcs->lock);
+
+	kfree(fcdev);
+}
+
+static struct freq_constraint_dev *alloc_fcdev(struct device *dev,
+					       struct freq_constraints *fcs)
+{
+	struct freq_constraint_dev *fcdev;
+
+	fcdev = kzalloc(sizeof(*fcdev), GFP_KERNEL);
+	if (!fcdev)
+		return ERR_PTR(-ENOMEM);
+
+	fcdev->dev = dev;
+
+	mutex_lock(&fcs->lock);
+	list_add(&fcdev->node, &fcs->devices);
+	mutex_unlock(&fcs->lock);
+
+	return fcdev;
+}
+
+static struct freq_constraint_dev *find_fcdev(struct device *dev,
+					      struct freq_constraints *fcs)
+{
+	struct freq_constraint_dev *fcdev;
+
+	mutex_lock(&fcs->lock);
+	list_for_each_entry(fcdev, &fcs->devices, node) {
+		if (fcdev->dev == dev) {
+			mutex_unlock(&fcs->lock);
+			return fcdev;
+		}
+	}
+	mutex_unlock(&fcs->lock);
+
+	return NULL;
+}
+
+static void free_constraint(struct freq_constraints *fcs,
+			    struct freq_constraint *constraint)
+{
+	mutex_lock(&fcs->lock);
+	list_del(&constraint->node);
+	mutex_unlock(&fcs->lock);
+
+	kfree(constraint);
+}
+
+static struct freq_constraint *alloc_constraint(struct freq_constraints *fcs,
+						enum freq_constraint_type type,
+						unsigned long min_freq,
+						unsigned long max_freq)
+{
+	struct freq_constraint *constraint;
+
+	constraint = kzalloc(sizeof(*constraint), GFP_KERNEL);
+	if (!constraint)
+		return ERR_PTR(-ENOMEM);
+
+	constraint->type = type;
+	constraint->freq.min = min_freq;
+	constraint->freq.max = max_freq;
+
+	mutex_lock(&fcs->lock);
+	list_add(&constraint->node, &fcs->constraints);
+	mutex_unlock(&fcs->lock);
+
+	return constraint;
+}
+
+static void free_fcs(struct freq_constraints *fcs)
+{
+	list_del(&fcs->node);
+	mutex_destroy(&fcs->lock);
+	kfree(fcs);
+}
+
+static void fcs_kref_release(struct kref *kref)
+{
+	struct freq_constraints *fcs = container_of(kref, struct freq_constraints, kref);
+	struct freq_constraint_dev *fcdev, *temp;
+
+	WARN_ON(!list_empty(&fcs->constraints));
+
+	list_for_each_entry_safe(fcdev, temp, &fcs->devices, node)
+		free_fcdev(fcdev, fcs);
+
+	free_fcs(fcs);
+	mutex_unlock(&fc_mutex);
+}
+
+static void put_fcs(struct freq_constraints *fcs)
+{
+	kref_put_mutex(&fcs->kref, fcs_kref_release, &fc_mutex);
+}
+
+static struct freq_constraints *alloc_fcs(struct device *dev)
+{
+	struct freq_constraints *fcs;
+	struct freq_constraint_dev *fcdev;
+
+	fcs = kzalloc(sizeof(*fcs), GFP_KERNEL);
+	if (!fcs)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&fcs->lock);
+	INIT_LIST_HEAD(&fcs->devices);
+	INIT_LIST_HEAD(&fcs->constraints);
+	INIT_WORK(&fcs->work, fcs_work_handler);
+	kref_init(&fcs->kref);
+
+	fcs->freq.min = 0;
+	fcs->freq.max = ULONG_MAX;
+
+	fcdev = alloc_fcdev(dev, fcs);
+	if (IS_ERR(fcdev)) {
+		free_fcs(fcs);
+		return ERR_CAST(fcdev);
+	}
+
+	mutex_lock(&fc_mutex);
+	list_add(&fcs->node, &fcs_list);
+	mutex_unlock(&fc_mutex);
+
+	return fcs;
+}
+
+static struct freq_constraints *find_fcs(struct device *dev)
+{
+	struct freq_constraints *fcs;
+
+	mutex_lock(&fc_mutex);
+	list_for_each_entry(fcs, &fcs_list, node) {
+		if (find_fcdev(dev, fcs)) {
+			kref_get(&fcs->kref);
+			mutex_unlock(&fc_mutex);
+			return fcs;
+		}
+	}
+	mutex_unlock(&fc_mutex);
+
+	return ERR_PTR(-ENODEV);
+}
+
+static struct freq_constraints *get_fcs(struct device *dev)
+{
+	struct freq_constraints *fcs;
+
+	fcs = find_fcs(dev);
+	if (!IS_ERR(fcs))
+		return fcs;
+
+	return alloc_fcs(dev);
+}
+
+struct freq_constraint *freq_constraint_add(struct device *dev,
+					    enum freq_constraint_type type,
+					    unsigned long min_freq,
+					    unsigned long max_freq)
+{
+	struct freq_constraints *fcs;
+	struct freq_constraint *constraint;
+
+	if (!max_freq || min_freq > max_freq) {
+		dev_err(dev, "freq-constraints: Invalid min/max frequency\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	fcs = get_fcs(dev);
+	if (IS_ERR(fcs))
+		return ERR_CAST(fcs);
+
+	constraint = alloc_constraint(fcs, type, min_freq, max_freq);
+	if (IS_ERR(constraint)) {
+		put_fcs(fcs);
+		return constraint;
+	}
+
+	fcs_update(fcs, &constraint->freq, ADD);
+
+	return constraint;
+}
+EXPORT_SYMBOL_GPL(freq_constraint_add);
+
+void freq_constraint_remove(struct device *dev,
+			    struct freq_constraint *constraint)
+{
+	struct freq_constraints *fcs;
+	struct freq_pair freq = constraint->freq;
+
+	fcs = find_fcs(dev);
+	if (IS_ERR(fcs)) {
+		dev_err(dev, "Failed to find freq-constraint\n");
+		return;
+	}
+
+	free_constraint(fcs, constraint);
+	fcs_update(fcs, &freq, REMOVE);
+
+	/*
+	 * Put the reference twice, once for the freed constraint and one for
+	 * the above call to find_fcs().
+	 */
+	put_fcs(fcs);
+	put_fcs(fcs);
+}
+EXPORT_SYMBOL_GPL(freq_constraint_remove);
+
+int freq_constraint_update(struct device *dev,
+			   struct freq_constraint *constraint,
+			   unsigned long min_freq,
+			   unsigned long max_freq)
+{
+	struct freq_constraints *fcs;
+
+	if (!max_freq || min_freq > max_freq) {
+		dev_err(dev, "freq-constraints: Invalid min/max frequency\n");
+		return -EINVAL;
+	}
+
+	fcs = find_fcs(dev);
+	if (IS_ERR(fcs)) {
+		dev_err(dev, "Failed to find freq-constraint\n");
+		return -ENODEV;
+	}
+
+	mutex_lock(&fcs->lock);
+	constraint->freq.min = min_freq;
+	constraint->freq.max = max_freq;
+	mutex_unlock(&fcs->lock);
+
+	fcs_update(fcs, &constraint->freq, UPDATE);
+
+	put_fcs(fcs);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(freq_constraint_update);
+
+int freq_constraints_get(struct device *dev, unsigned long *min_freq,
+			 unsigned long *max_freq)
+{
+	struct freq_constraints *fcs;
+
+	fcs = find_fcs(dev);
+	if (IS_ERR(fcs))
+		return -ENODEV;
+
+	mutex_lock(&fcs->lock);
+	*min_freq = fcs->freq.min;
+	*max_freq = fcs->freq.max;
+	mutex_unlock(&fcs->lock);
+
+	put_fcs(fcs);
+	return 0;
+}
+
+static int set_fcs_callback(struct device *dev, struct freq_constraints *fcs,
+			    void (*callback)(void *param), void *callback_param)
+{
+	if (unlikely(fcs->callback)) {
+		dev_err(dev, "freq-constraint: callback already registered\n");
+		return -EBUSY;
+	}
+
+	fcs->callback = callback;
+	fcs->callback_param = callback_param;
+	return 0;
+}
+
+int freq_constraint_set_dev_callback(struct device *dev,
+				     void (*callback)(void *param),
+				     void *callback_param)
+{
+	struct freq_constraints *fcs;
+	int ret;
+
+	if (WARN_ON(!callback))
+		return -ENODEV;
+
+	fcs = get_fcs(dev);
+	if (IS_ERR(fcs))
+		return PTR_ERR(fcs);
+
+	mutex_lock(&fcs->lock);
+	ret = set_fcs_callback(dev, fcs, callback, callback_param);
+	mutex_unlock(&fcs->lock);
+
+	if (ret)
+		put_fcs(fcs);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(freq_constraint_set_dev_callback);
+
+/* Caller must call put_fcs() after using it */
+static struct freq_constraints *remove_callback(struct device *dev)
+{
+	struct freq_constraints *fcs;
+
+	fcs = find_fcs(dev);
+	if (IS_ERR(fcs)) {
+		dev_err(dev, "freq-constraint: device not registered\n");
+		return fcs;
+	}
+
+	mutex_lock(&fcs->lock);
+
+	cancel_work_sync(&fcs->work);
+
+	if (fcs->callback) {
+		fcs->callback = NULL;
+		fcs->callback_param = NULL;
+	} else {
+		dev_err(dev, "freq-constraint: Call back not registered for device\n");
+	}
+	mutex_unlock(&fcs->lock);
+
+	return fcs;
+}
+
+void freq_constraint_remove_dev_callback(struct device *dev)
+{
+	struct freq_constraints *fcs;
+
+	fcs = remove_callback(dev);
+	if (IS_ERR(fcs))
+		return;
+
+	/*
+	 * Put the reference twice, once for the callback removal and one for
+	 * the above call to remove_callback().
+	 */
+	put_fcs(fcs);
+	put_fcs(fcs);
+}
+EXPORT_SYMBOL_GPL(freq_constraint_remove_dev_callback);
+
+#ifdef CONFIG_CPU_FREQ
+static void remove_cpumask_fcs(struct freq_constraints *fcs,
+			       const struct cpumask *cpumask, int stop_cpu)
+{
+	struct device *cpu_dev;
+	int cpu;
+
+	for_each_cpu(cpu, cpumask) {
+		if (unlikely(cpu == stop_cpu))
+			return;
+
+		cpu_dev = get_cpu_device(cpu);
+		if (unlikely(!cpu_dev))
+			continue;
+
+		put_fcs(fcs);
+	}
+}
+
+int freq_constraint_set_cpumask_callback(const struct cpumask *cpumask,
+					 void (*callback)(void *param),
+					 void *callback_param)
+{
+	struct freq_constraints *fcs = ERR_PTR(-ENODEV);
+	struct device *cpu_dev, *first_cpu_dev = NULL;
+	struct freq_constraint_dev *fcdev;
+	int cpu, ret;
+
+	if (WARN_ON(cpumask_empty(cpumask) || !callback))
+		return -ENODEV;
+
+	/* Find a CPU for which fcs already exists */
+	for_each_cpu(cpu, cpumask) {
+		cpu_dev = get_cpu_device(cpu);
+		if (unlikely(!cpu_dev))
+			continue;
+
+		if (unlikely(!first_cpu_dev))
+			first_cpu_dev = cpu_dev;
+
+		fcs = find_fcs(cpu_dev);
+		if (!IS_ERR(fcs))
+			break;
+	}
+
+	/* Allocate fcs if it wasn't already present */
+	if (IS_ERR(fcs)) {
+		if (unlikely(!first_cpu_dev)) {
+			pr_err("device structure not available for any CPU\n");
+			return -ENODEV;
+		}
+
+		fcs = alloc_fcs(first_cpu_dev);
+		if (IS_ERR(fcs))
+			return PTR_ERR(fcs);
+	}
+
+	for_each_cpu(cpu, cpumask) {
+		cpu_dev = get_cpu_device(cpu);
+		if (unlikely(!cpu_dev))
+			continue;
+
+		if (!find_fcdev(cpu_dev, fcs)) {
+			fcdev = alloc_fcdev(cpu_dev, fcs);
+			if (IS_ERR(fcdev)) {
+				remove_cpumask_fcs(fcs, cpumask, cpu);
+				put_fcs(fcs);
+				return PTR_ERR(fcdev);
+			}
+		}
+
+		kref_get(&fcs->kref);
+	}
+
+	mutex_lock(&fcs->lock);
+	ret = set_fcs_callback(first_cpu_dev, fcs, callback, callback_param);
+	mutex_unlock(&fcs->lock);
+
+	if (ret)
+		remove_cpumask_fcs(fcs, cpumask, cpu);
+
+	put_fcs(fcs);
+
+	return ret;
+}
+
+void freq_constraint_remove_cpumask_callback(const struct cpumask *cpumask)
+{
+	struct freq_constraints *fcs;
+	struct device *cpu_dev = NULL;
+	int cpu;
+
+	for_each_cpu(cpu, cpumask) {
+		cpu_dev = get_cpu_device(cpu);
+		if (likely(cpu_dev))
+			break;
+	}
+
+	if (!cpu_dev)
+		return;
+
+	fcs = remove_callback(cpu_dev);
+	if (IS_ERR(fcs))
+		return;
+
+	remove_cpumask_fcs(fcs, cpumask, -1);
+
+	put_fcs(fcs);
+}
+#endif /* CONFIG_CPU_FREQ */
diff --git a/include/linux/freq_constraint.h b/include/linux/freq_constraint.h
new file mode 100644
index 000000000000..628dca3ef646
--- /dev/null
+++ b/include/linux/freq_constraint.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Frequency constraints header.
+ *
+ * Copyright (C) 2019 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ */
+#ifndef _LINUX_FREQ_CONSTRAINT_H
+#define _LINUX_FREQ_CONSTRAINT_H
+
+struct device;
+struct freq_constraint;
+
+enum freq_constraint_type {
+	FREQ_CONSTRAINT_THERMAL,
+	FREQ_CONSTRAINT_USER,
+	FREQ_CONSTRAINT_MAX
+};
+
+struct freq_constraint *freq_constraint_add(struct device *dev,
+					    enum freq_constraint_type type,
+					    unsigned long min_freq,
+					    unsigned long max_freq);
+void freq_constraint_remove(struct device *dev,
+			    struct freq_constraint *constraint);
+int freq_constraint_update(struct device *dev,
+			   struct freq_constraint *constraint,
+			   unsigned long min_freq,
+			   unsigned long max_freq);
+
+int freq_constraint_set_dev_callback(struct device *dev,
+				     void (*callback)(void *param),
+				     void *callback_param);
+void freq_constraint_remove_dev_callback(struct device *dev);
+int freq_constraints_get(struct device *dev, unsigned long *min_freq,
+			 unsigned long *max_freq);
+
+#ifdef CONFIG_CPU_FREQ
+int freq_constraint_set_cpumask_callback(const struct cpumask *cpumask,
+					 void (*callback)(void *param),
+					 void *callback_param);
+void freq_constraint_remove_cpumask_callback(const struct cpumask *cpumask);
+#endif /* CONFIG_CPU_FREQ */
+
+#endif /* _LINUX_FREQ_CONSTRAINT_H */
-- 
2.7.4

