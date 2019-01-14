Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABE1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FABB2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfANOmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:42:54 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:48730 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726624AbfANOmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:42:46 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0EEaY83017086;
        Mon, 14 Jan 2019 15:42:40 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2pybyw8mu8-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 14 Jan 2019 15:42:40 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E2E7A31;
        Mon, 14 Jan 2019 14:42:39 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C11CD52AB;
        Mon, 14 Jan 2019 14:42:39 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 14 Jan
 2019 15:42:39 +0100
Received: from localhost (10.201.20.122) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 14 Jan 2019 15:42:38
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <broonie@kernel.org>, <robh@kernel.org>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <loic.pallardy@st.com>,
        <benjamin.gaignard@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [RFC 2/7] domainsctrl: Introduce domains controller framework
Date:   Mon, 14 Jan 2019 15:41:57 +0100
Message-ID: <20190114144202.27315-3-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190114144202.27315-1-benjamin.gaignard@st.com>
References: <20190114144202.27315-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.122]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this framework is to offer an interface for the
hardware blocks controlling bus accesses rights.

Bus domains controllers are typically used to control if a
hardware block can perform read or write operations on bus.

Smarter domains controllers could be able to define accesses
rights per hardware blocks to control where they can read
or write.

Domains controller configurations are provided in device node,
parsed by the framework and send to the driver to apply them.
Each controller may need different number and type of inputs
to configure a domain so device-tree properties size have to
be define by using "#domainctrl-cells".
Domains configurations properties have to be named "domainsctrl-X"
on device node.
"domainsctrl-names" keyword can also be used to give a name to
a specific configuration.

Example of device-tree:
ctrl0: domainsctrl@0 {
	#domainctrl-cells = <2>;
      };

foo: foo@0 {
	domainsctrl-names = "default", "setting1";
	domainsctrl-0 = <&ctrl0 1 2>;
	domainsctrl-1 = <&ctrl0 3 4>;
};

Configurations could be applied with functions like
domainsctrl_set_config_by_index() or domainsctrl_set_config_by_name().

domainsctrl_set_default_config() function will apply the
configuration named "default" (if existing) or the configuration
with index 0 (i.e. domainsctrl-0).

Drivers could register/unregister themselves be calling
domainsctrl_register/domainsctrl_unregister functions.

When a configuration has to be applied the driver callback,
provided in the ops at registration time, set_config is called
by the framework.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/bus/Kconfig               |   2 +
 drivers/bus/Makefile              |   2 +
 drivers/bus/domains/Kconfig       |   7 ++
 drivers/bus/domains/Makefile      |   1 +
 drivers/bus/domains/domainsctrl.c | 234 ++++++++++++++++++++++++++++++++++++++
 include/linux/domainsctrl.h       |  70 ++++++++++++
 6 files changed, 316 insertions(+)
 create mode 100644 drivers/bus/domains/Kconfig
 create mode 100644 drivers/bus/domains/Makefile
 create mode 100644 drivers/bus/domains/domainsctrl.c
 create mode 100644 include/linux/domainsctrl.h

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 1851112ccc29..a0f7a67c1296 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -183,4 +183,6 @@ config DA8XX_MSTPRI
 
 source "drivers/bus/fsl-mc/Kconfig"
 
+source "drivers/bus/domains/Kconfig"
+
 endmenu
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index ca300b1914ce..d7e95edba33d 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -32,3 +32,5 @@ obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
 
 obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o
+
+obj-$(CONFIG_DOMAINS_CONTROLLERS) 	+= domains/
diff --git a/drivers/bus/domains/Kconfig b/drivers/bus/domains/Kconfig
new file mode 100644
index 000000000000..5ba15f750bee
--- /dev/null
+++ b/drivers/bus/domains/Kconfig
@@ -0,0 +1,7 @@
+menu "Bus Domains Controllers"
+
+config DOMAINS_CONTROLLERS
+	bool "Support of bus domains controllers"
+	depends on OF
+
+endmenu
diff --git a/drivers/bus/domains/Makefile b/drivers/bus/domains/Makefile
new file mode 100644
index 000000000000..262338b7cad5
--- /dev/null
+++ b/drivers/bus/domains/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_DOMAINS_CONTROLLERS) += domainsctrl.o
diff --git a/drivers/bus/domains/domainsctrl.c b/drivers/bus/domains/domainsctrl.c
new file mode 100644
index 000000000000..bbadf8165bc8
--- /dev/null
+++ b/drivers/bus/domains/domainsctrl.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
+ */
+
+#include <linux/device.h>
+#include <linux/domainsctrl.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+
+/* Mutex taken to protect domainctrl_list */
+static DEFINE_MUTEX(domainctrl_list_mutex);
+
+/* Global list of domain control devices (struct domains_ctrl) */
+static LIST_HEAD(domainctrl_list);
+
+struct domains_ctrl {
+	struct list_head node;
+	struct device *dev;
+	struct domains_ctrl_ops *ops;
+};
+
+static struct domains_ctrl *get_domainctrl_from_node(struct device_node *np)
+{
+	struct domains_ctrl *ctrl;
+
+	mutex_lock(&domainctrl_list_mutex);
+
+	list_for_each_entry(ctrl, &domainctrl_list, node) {
+		if (ctrl->dev->of_node == np) {
+			mutex_unlock(&domainctrl_list_mutex);
+			return ctrl;
+		}
+	}
+
+	mutex_unlock(&domainctrl_list_mutex);
+
+	return NULL;
+}
+
+/**
+ * domainsctrl_set_config_by_index
+ *
+ * Set a domains controller configuration based on given index.
+ *
+ * @dev: device with domain configuration to apply.
+ * @index: the index of the configuration in device node.
+ *
+ * Returns 0 if OK, -EPROBE_DEFER if waiting for domains controller to be
+ * registered or negative value on other errors.
+ */
+int domainsctrl_set_config_by_index(struct device *dev, int index)
+{
+	struct device_node *np = dev->of_node;
+	char *propname;
+	int configs, i, err = 0;
+
+	if (!np)
+		return 0;
+
+	propname = kasprintf(GFP_KERNEL, "domainctrl-%d", index);
+	configs = of_count_phandle_with_args(np, propname, "#domainctrl-cells");
+	if (configs < 0) {
+		err = -EINVAL;
+		goto error;
+	}
+
+	for (i = 0; i < configs; i++) {
+		struct domains_ctrl *ctrl;
+		struct of_phandle_args args;
+
+		err = of_parse_phandle_with_args(np, propname,
+						 "#domainctrl-cells",
+						 i, &args);
+		if (err)
+			goto error;
+
+		/* Test if the controller is (or will be) available */
+		if (!of_device_is_available(args.np)) {
+			of_node_put(args.np);
+			continue;
+		}
+
+		ctrl = get_domainctrl_from_node(args.np);
+		of_node_put(args.np);
+
+		/* Controller is not yet registered */
+		if (!ctrl) {
+			err = -EPROBE_DEFER;
+			goto error;
+		}
+
+		err = ctrl->ops->set_config(ctrl->dev, &args);
+		if (err)
+			goto error;
+	}
+
+error:
+	kfree(propname);
+	return err;
+}
+EXPORT_SYMBOL_GPL(domainsctrl_set_config_by_index);
+
+/**
+ * domainsctrl_set_config_by_name
+ *
+ * Set a domains controller configuration based on given name.
+ *
+ * @dev: device with domain configuration to apply.
+ * @name: the name of the configuration in device node.
+ *
+ * Returns 0 if OK, -EPROBE_DEFER if waiting for domains controller to be
+ * registered or negative value on other errors.
+ */
+int domainsctrl_set_config_by_name(struct device *dev, char *name)
+{
+	const char *configname;
+	int count, i;
+
+	count = of_property_count_strings(dev->of_node, "domainctrl-names");
+	for (i = 0; i < count; i++) {
+		int err;
+
+		err = of_property_read_string_index(dev->of_node,
+						    "domainctrl-names",
+						    i, &configname);
+		if (err)
+			return err;
+
+		if (strcmp(name, configname))
+			continue;
+
+		return domainsctrl_set_config_by_index(dev, i);
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(domainsctrl_set_config_by_name);
+
+/**
+ * domainsctrl_set_default_config
+ *
+ * Set the default configuration for device.
+ * First try to apply configuration named "default", if it fails
+ * or doesn't exist, try to apply domainsctrl-0 configuration.
+ *
+ * @dev: device with domain configuration to apply.
+ *
+ * Returns 0 if OK, -EPROBE_DEFER if waiting for domains controller to be
+ * registered or negative value on other errors.
+ */
+int domainsctrl_set_default_config(struct device *dev)
+{
+	int ret;
+
+	ret = domainsctrl_set_config_by_name(dev, "default");
+	if (!ret || (ret == -EPROBE_DEFER))
+		return ret;
+
+	return domainsctrl_set_config_by_index(dev, 0);
+}
+EXPORT_SYMBOL_GPL(domainsctrl_set_default_config);
+
+/**
+ * domainsctrl_register
+ *
+ * Register a domains controller device.
+ *
+ * @dev: device implementing domains controller.
+ * @ops: domains controller operations.
+ *
+ * Returns 0 if OK or negative value on error.
+ */
+int domainsctrl_register(struct device *dev,
+			 struct domains_ctrl_ops *ops)
+{
+	struct domains_ctrl *ctrl;
+
+	if (!dev || !ops || !ops->set_config)
+		return -EINVAL;
+
+	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&ctrl->node);
+
+	ctrl->dev = dev;
+	ctrl->ops = ops;
+
+	mutex_lock(&domainctrl_list_mutex);
+	list_add_tail(&ctrl->node, &domainctrl_list);
+	mutex_unlock(&domainctrl_list_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(domainsctrl_register);
+
+/**
+ * domainsctrl_unregister
+ *
+ * Unregister a domains controller device.
+ *
+ * @dev: device implementing domains controller.
+ */
+void domainsctrl_unregister(struct device *dev)
+{
+	struct domains_ctrl *ctrl;
+
+	ctrl = get_domainctrl_from_node(dev->of_node);
+	if (!ctrl)
+		return;
+
+	mutex_lock(&domainctrl_list_mutex);
+	list_del(&ctrl->node);
+	mutex_unlock(&domainctrl_list_mutex);
+
+	kfree(ctrl);
+}
+EXPORT_SYMBOL_GPL(domainsctrl_unregister);
+
+static int __init domainsctrl_init(void)
+{
+	pr_info("initialized bus domain controller subsystem\n");
+	return 0;
+}
+
+/* Init early since drivers really need to configure domains early */
+core_initcall(domainsctrl_init);
diff --git a/include/linux/domainsctrl.h b/include/linux/domainsctrl.h
new file mode 100644
index 000000000000..1d1960175342
--- /dev/null
+++ b/include/linux/domainsctrl.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Benjamin Gaignard <benjamin.gaignard@st.com> for STMicroelectronics.
+ */
+
+#ifndef _DOMAINSCTRL_H_
+#define _DOMAINSCTRL_H_
+
+#include <linux/device.h>
+#include <linux/of.h>
+
+/**
+ * struct domains_ctrl_ops
+ *
+ * Domains controller operations structure to be filled by drivers.
+ */
+struct domains_ctrl_ops {
+	/**
+	 * @set_config:
+	 *
+	 * Driver callback to set a domain configuration on a domain controller.
+	 * Configuration arguments are provided in out_args parameter.
+	 *
+	 * Returns 0 on success, a negative error code on failure.
+	 */
+	int (*set_config)(struct device *dev, struct of_phandle_args *out_args);
+};
+
+#ifdef CONFIG_DOMAINS_CONTROLLERS
+
+int domainsctrl_set_config_by_index(struct device *dev, int index);
+int domainsctrl_set_config_by_name(struct device *dev, char *name);
+int domainsctrl_set_default_config(struct device *dev);
+
+int domainsctrl_register(struct device *dev, struct domains_ctrl_ops *ops);
+
+void domainsctrl_unregister(struct device *dev);
+
+#else
+
+static inline int domainsctrl_set_config_by_index(struct device *dev, int index)
+{
+	return 0;
+}
+
+static inline int domainsctrl_set_config_by_name(struct device *dev, char *name)
+{
+	return 0;
+}
+
+static inline int domainsctrl_set_default_config(struct device *dev)
+{
+	return 0;
+}
+
+static inline int domainsctrl_register(struct device *dev,
+				       struct domains_ctrl_ops *ops)
+{
+	return 0;
+}
+
+static inline void domainsctrl_unregister(struct device *dev)
+{
+	/* Empty */
+}
+
+#endif
+
+#endif /* _DOMAINSCTRL_H_ */
-- 
2.15.0

