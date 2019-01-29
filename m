Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD1DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2B120989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfA2U7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:59:43 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:42247 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727686AbfA2U7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:59:42 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from lsun@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 29 Jan 2019 22:59:38 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x0TKxZ2c020181;
        Tue, 29 Jan 2019 15:59:35 -0500
Received: (from lsun@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x0TKxULk005661;
        Tue, 29 Jan 2019 15:59:30 -0500
From:   Liming Sun <lsun@mellanox.com>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>
Cc:     Liming Sun <lsun@mellanox.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] platform/mellanox: Add bootctl driver for Mellanox BlueField Soc
Date:   Tue, 29 Jan 2019 15:59:21 -0500
Message-Id: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the bootctl platform driver for Mellanox BlueField
Soc, which controls the eMMC boot partition swapping and related
watchdog configuration.

Reviewed-by: David Woods <dwoods@mellanox.com>
Signed-off-by: Liming Sun <lsun@mellanox.com>
---
 drivers/platform/mellanox/Kconfig         |  15 +-
 drivers/platform/mellanox/Makefile        |   1 +
 drivers/platform/mellanox/mlxbf-bootctl.c | 317 ++++++++++++++++++++++++++++++
 drivers/platform/mellanox/mlxbf-bootctl.h | 108 ++++++++++
 4 files changed, 440 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/mellanox/mlxbf-bootctl.c
 create mode 100644 drivers/platform/mellanox/mlxbf-bootctl.h

diff --git a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
index cd8a908..580901f 100644
--- a/drivers/platform/mellanox/Kconfig
+++ b/drivers/platform/mellanox/Kconfig
@@ -5,7 +5,7 @@
 
 menuconfig MELLANOX_PLATFORM
 	bool "Platform support for Mellanox hardware"
-	depends on X86 || ARM || COMPILE_TEST
+	depends on X86 || ARM || ARM64 || COMPILE_TEST
 	---help---
 	  Say Y here to get to see options for platform support for
 	  Mellanox systems. This option alone does not add any kernel code.
@@ -34,4 +34,17 @@ config MLXREG_IO
 	  to system resets operation, system reset causes monitoring and some
 	  kinds of mux selection.
 
+config MLXBF_BOOTCTL
+	tristate "Mellanox BlueField Firmware Boot Control driver"
+	depends on ARM64
+	default m
+	help
+          The Mellanox BlueField firmware implements functionality to
+          request swapping the primary and alternate eMMC boot
+          partition, and to set up a watchdog that can undo that swap
+          if the system does not boot up correctly.  This driver
+          provides sysfs access to the firmware, to be used in
+          conjunction with the eMMC device driver to do any necessary
+          initial swap of the boot partition.
+
 endif # MELLANOX_PLATFORM
diff --git a/drivers/platform/mellanox/Makefile b/drivers/platform/mellanox/Makefile
index 57074d9c..76b0370 100644
--- a/drivers/platform/mellanox/Makefile
+++ b/drivers/platform/mellanox/Makefile
@@ -5,3 +5,4 @@
 #
 obj-$(CONFIG_MLXREG_HOTPLUG)	+= mlxreg-hotplug.o
 obj-$(CONFIG_MLXREG_IO) += mlxreg-io.o
+obj-$(CONFIG_MLXBF_BOOTCTL)	+= mlxbf-bootctl.o
diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
new file mode 100644
index 0000000..90a655b
--- /dev/null
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Mellanox boot control driver
+ * This driver provides a sysfs interface for systems management
+ * software to manage reset-time actions.
+ *
+ * Copyright (C) 2019 Mellanox Technologies
+ */
+
+#include <linux/acpi.h>
+#include <linux/arm-smccc.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include "mlxbf-bootctl.h"
+
+#define MLXBF_BOOTCTL_DRIVER_NAME		"mlxbf-bootctl"
+#define MLXBF_BOOTCTL_DRIVER_VERSION		"1.2"
+#define MLXBF_BOOTCTL_DRIVER_DESCRIPTION	"Mellanox boot control driver"
+
+#define MLXBF_BOOTCTL_SB_MODE_SECURE_MASK	0x03
+#define MLXBF_BOOTCTL_SB_MODE_TEST_MASK		0x0c
+
+#define MLXBF_SB_KEY_NUM			4
+
+struct mlxbf_bootctl_name {
+	int value;
+	const char name[12];
+};
+
+static struct mlxbf_bootctl_name boot_names[] = {
+	{ MLXBF_BOOTCTL_EXTERNAL,	"external"	},
+	{ MLXBF_BOOTCTL_EMMC,		"emmc"		},
+	{ MLNX_BOOTCTL_SWAP_EMMC,	"swap_emmc"	},
+	{ MLXBF_BOOTCTL_EMMC_LEGACY,	"emmc_legacy"	},
+	{ MLXBF_BOOTCTL_NONE,		"none"		},
+	{ -1,				""		}
+};
+
+static char mlxbf_bootctl_lifecycle_states[][16] = {
+	[0] = "soft_non_secure",
+	[1] = "secure",
+	[2] = "hard_non_secure",
+	[3] = "rma",
+};
+
+/* The SMC calls in question are atomic, so we don't have to lock here. */
+static int mlxbf_bootctl_smc_call1(unsigned int smc_op, int smc_arg)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(smc_op, smc_arg, 0, 0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+/* Syntactic sugar to avoid having to specify an unused argument. */
+#define mlxbf_bootctl_smc_call0(smc_op) mlxbf_bootctl_smc_call1(smc_op, 0)
+
+static int reset_action_to_val(const char *action, size_t len)
+{
+	struct mlxbf_bootctl_name *bn;
+
+	/* Accept string either with or without a newline terminator */
+	if (action[len-1] == '\n')
+		--len;
+
+	for (bn = boot_names; bn->value >= 0; ++bn)
+		if (strncmp(bn->name, action, len) == 0)
+			break;
+
+	return bn->value;
+}
+
+static const char *reset_action_to_string(int action)
+{
+	struct mlxbf_bootctl_name *bn;
+
+	for (bn = boot_names; bn->value >= 0; ++bn)
+		if (bn->value == action)
+			break;
+
+	return bn->name;
+}
+
+static ssize_t post_reset_wdog_show(struct device_driver *drv, char *buf)
+{
+	return sprintf(buf, "%d\n",
+		mlxbf_bootctl_smc_call0(MLXBF_BOOTCTL_GET_POST_RESET_WDOG));
+}
+
+static ssize_t post_reset_wdog_store(struct device_driver *drv,
+				     const char *buf, size_t count)
+{
+	int err;
+	unsigned long watchdog;
+
+	err = kstrtoul(buf, 10, &watchdog);
+	if (err)
+		return err;
+
+	if (mlxbf_bootctl_smc_call1(MLXBF_BOOTCTL_SET_POST_RESET_WDOG,
+				    watchdog) < 0)
+		return -EINVAL;
+
+	return count;
+}
+
+static ssize_t reset_action_show(struct device_driver *drv, char *buf)
+{
+	return sprintf(buf, "%s\n", reset_action_to_string(
+		mlxbf_bootctl_smc_call0(MLXBF_BOOTCTL_GET_RESET_ACTION)));
+}
+
+static ssize_t reset_action_store(struct device_driver *drv,
+				  const char *buf, size_t count)
+{
+	int action = reset_action_to_val(buf, count);
+
+	if (action < 0 || action == MLXBF_BOOTCTL_NONE)
+		return -EINVAL;
+
+	if (mlxbf_bootctl_smc_call1(MLXBF_BOOTCTL_SET_RESET_ACTION, action) < 0)
+		return -EINVAL;
+
+	return count;
+}
+
+static ssize_t second_reset_action_show(struct device_driver *drv, char *buf)
+{
+	return sprintf(buf, "%s\n", reset_action_to_string(
+		mlxbf_bootctl_smc_call0(
+			MLXBF_BOOTCTL_GET_SECOND_RESET_ACTION)));
+}
+
+static ssize_t second_reset_action_store(struct device_driver *drv,
+					 const char *buf, size_t count)
+{
+	int action = reset_action_to_val(buf, count);
+
+	if (action < 0)
+		return -EINVAL;
+
+	if (mlxbf_bootctl_smc_call1(MLXBF_BOOTCTL_SET_SECOND_RESET_ACTION,
+				    action) < 0)
+		return -EINVAL;
+
+	return count;
+}
+
+static ssize_t lifecycle_state_show(struct device_driver *drv, char *buf)
+{
+	int lc_state = mlxbf_bootctl_smc_call1(
+				MLXBF_BOOTCTL_GET_TBB_FUSE_STATUS,
+				MLXBF_BOOTCTL_FUSE_STATUS_LIFECYCLE);
+
+	if (lc_state < 0)
+		return -EINVAL;
+
+	lc_state &= (MLXBF_BOOTCTL_SB_MODE_TEST_MASK |
+		     MLXBF_BOOTCTL_SB_MODE_SECURE_MASK);
+	/*
+	 * If the test bits are set, we specify that the current state may be
+	 * due to using the test bits.
+	 */
+	if ((lc_state & MLXBF_BOOTCTL_SB_MODE_TEST_MASK) != 0) {
+
+		lc_state &= MLXBF_BOOTCTL_SB_MODE_SECURE_MASK;
+
+		return sprintf(buf, "%s(test)\n",
+			       mlxbf_bootctl_lifecycle_states[lc_state]);
+	}
+
+	return sprintf(buf, "%s\n", mlxbf_bootctl_lifecycle_states[lc_state]);
+}
+
+static ssize_t secure_boot_fuse_state_show(struct device_driver *drv, char *buf)
+{
+	int key;
+	int buf_len = 0;
+	int upper_key_used = 0;
+	int sb_key_state = mlxbf_bootctl_smc_call1(
+				MLXBF_BOOTCTL_GET_TBB_FUSE_STATUS,
+				MLXBF_BOOTCTL_FUSE_STATUS_KEYS);
+
+	if (sb_key_state < 0)
+		return -EINVAL;
+
+	for (key = MLXBF_SB_KEY_NUM - 1; key >= 0; key--) {
+		int burnt = ((sb_key_state & (1 << key)) != 0);
+		int valid = ((sb_key_state &
+			      (1 << (key + MLXBF_SB_KEY_NUM))) != 0);
+
+		buf_len += sprintf(buf + buf_len, "Ver%d:", key);
+		if (upper_key_used) {
+			if (burnt) {
+				if (valid)
+					buf_len += sprintf(buf + buf_len,
+							  "Used");
+				else
+					buf_len += sprintf(buf + buf_len,
+							  "Wasted");
+			} else {
+				if (valid)
+					buf_len += sprintf(buf + buf_len,
+							  "Invalid");
+				else
+					buf_len += sprintf(buf + buf_len,
+							  "Skipped");
+			}
+		} else {
+			if (burnt) {
+				if (valid) {
+					upper_key_used = 1;
+					buf_len += sprintf(buf + buf_len,
+							  "In use");
+				} else
+					buf_len += sprintf(buf + buf_len,
+							  "Burn incomplete");
+			} else {
+				if (valid)
+					buf_len += sprintf(buf + buf_len,
+							  "Invalid");
+				else
+					buf_len += sprintf(buf + buf_len,
+							  "Free");
+			}
+		}
+		buf_len += sprintf(buf + buf_len, "\n");
+	}
+
+	return buf_len;
+}
+
+#define MLXBF_BOOTCTL_DRV_ATTR(_name) DRIVER_ATTR_RW(_name)
+
+static MLXBF_BOOTCTL_DRV_ATTR(post_reset_wdog);
+static MLXBF_BOOTCTL_DRV_ATTR(reset_action);
+static MLXBF_BOOTCTL_DRV_ATTR(second_reset_action);
+static DRIVER_ATTR_RO(lifecycle_state);
+static DRIVER_ATTR_RO(secure_boot_fuse_state);
+
+static struct attribute *mlxbf_bootctl_dev_attrs[] = {
+	&driver_attr_post_reset_wdog.attr,
+	&driver_attr_reset_action.attr,
+	&driver_attr_second_reset_action.attr,
+	&driver_attr_lifecycle_state.attr,
+	&driver_attr_secure_boot_fuse_state.attr,
+	NULL
+};
+
+static struct attribute_group mlxbf_bootctl_attr_group = {
+	.attrs = mlxbf_bootctl_dev_attrs
+};
+
+static const struct attribute_group *mlxbf_bootctl_attr_groups[] = {
+	&mlxbf_bootctl_attr_group,
+	NULL
+};
+
+static const struct acpi_device_id mlxbf_bootctl_acpi_ids[] = {
+	{"MLNXBF04", 0},
+	{},
+};
+
+MODULE_DEVICE_TABLE(acpi, mlxbf_bootctl_acpi_ids);
+
+static int mlxbf_bootctl_probe(struct platform_device *pdev)
+{
+	struct arm_smccc_res res;
+
+	/*
+	 * Ensure we have the UUID we expect for this service.
+	 * Note that the functionality we want is present in the first
+	 * released version of this service, so we don't check the version.
+	 */
+	arm_smccc_smc(MLXBF_BOOTCTL_SIP_SVC_UID, 0, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 != 0x89c036b4 || res.a1 != 0x11e6e7d7 ||
+	    res.a2 != 0x1a009787 || res.a3 != 0xc4bf00ca)
+		return -ENODEV;
+
+	/*
+	 * When watchdog is used, it sets boot mode to MLXBF_BOOTCTL_SWAP_EMMC
+	 * in case of boot failures. However it doesn't clear the state if there
+	 * is no failure. Restore the default boot mode here to avoid any
+	 * unnecessary boot partition swapping.
+	 */
+	if (mlxbf_bootctl_smc_call1(MLXBF_BOOTCTL_SET_RESET_ACTION,
+				    MLXBF_BOOTCTL_EMMC) < 0)
+		pr_err("Unable to reset the EMMC boot mode\n");
+
+	pr_info("%s (version %s)\n", MLXBF_BOOTCTL_DRIVER_DESCRIPTION,
+		MLXBF_BOOTCTL_DRIVER_VERSION);
+
+	return 0;
+}
+
+static int mlxbf_bootctl_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver mlxbf_bootctl_driver = {
+	.probe = mlxbf_bootctl_probe,
+	.remove = mlxbf_bootctl_remove,
+	.driver = {
+		.name = MLXBF_BOOTCTL_DRIVER_NAME,
+		.groups = mlxbf_bootctl_attr_groups,
+		.acpi_match_table = ACPI_PTR(mlxbf_bootctl_acpi_ids),
+	}
+};
+
+module_platform_driver(mlxbf_bootctl_driver);
+
+MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
+MODULE_VERSION(MLXBF_BOOTCTL_DRIVER_VERSION);
+MODULE_AUTHOR("Mellanox Technologies");
+MODULE_LICENSE("GPL");
diff --git a/drivers/platform/mellanox/mlxbf-bootctl.h b/drivers/platform/mellanox/mlxbf-bootctl.h
new file mode 100644
index 0000000..0592ce4
--- /dev/null
+++ b/drivers/platform/mellanox/mlxbf-bootctl.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, Mellanox Technologies. All rights reserved.
+ */
+
+#ifndef __MLXBF_BOOTCTL_H__
+#define __MLXBF_BOOTCTL_H__
+
+/*
+ * Request that the on-chip watchdog be enabled, or disabled, after
+ * the next chip soft reset. This call does not affect the current
+ * status of the on-chip watchdog. If non-zero, the argument
+ * specifies the watchdog interval in seconds. If zero, the watchdog
+ * will not be enabled after the next soft reset. Non-zero errors are
+ * returned as documented below.
+ */
+#define MLXBF_BOOTCTL_SET_POST_RESET_WDOG	0x82000000
+
+/*
+ * Query the status which has been requested for the on-chip watchdog
+ * after the next chip soft reset. Returns the interval as set by
+ * MLXBF_BOOTCTL_SET_POST_RESET_WDOG.
+ */
+#define MLXBF_BOOTCTL_GET_POST_RESET_WDOG	0x82000001
+
+/*
+ * Request that a specific boot action be taken at the next soft
+ * reset. By default, the boot action is set by external chip pins,
+ * which are sampled on hard reset. Note that the boot action
+ * requested by this call will persist on subsequent resets unless
+ * this service, or the MLNX_SET_SECOND_RESET_ACTION service, is
+ * invoked. See below for the available MLNX_BOOT_xxx parameter
+ * values. Non-zero errors are returned as documented below.
+ */
+#define MLXBF_BOOTCTL_SET_RESET_ACTION		0x82000002
+
+/*
+ * Return the specific boot action which will be taken at the next
+ * soft reset. Returns the reset action (see below for the parameter
+ * values for MLXBF_BOOTCTL_SET_RESET_ACTION).
+ */
+#define MLXBF_BOOTCTL_GET_RESET_ACTION		0x82000003
+
+/*
+ * Request that a specific boot action be taken at the soft reset
+ * after the next soft reset. For a specified valid boot mode, the
+ * effect of this call is identical to that of invoking
+ * MLXBF_BOOTCTL_SET_RESET_ACTION after the next chip soft reset; in
+ * particular, after that reset, the action for the now next reset can
+ * be queried with MLXBF_BOOTCTL_GET_RESET_ACTION and modified with
+ * MLXBF_BOOTCTL_SET_RESET_ACTION. You may also specify the parameter as
+ * MLNX_BOOT_NONE, which is equivalent to specifying that no call to
+ * MLXBF_BOOTCTL_SET_RESET_ACTION be taken after the next chip soft reset.
+ * This call does not affect the action to be taken at the next soft
+ * reset. Non-zero errors are returned as documented below.
+ */
+#define MLXBF_BOOTCTL_SET_SECOND_RESET_ACTION	0x82000004
+
+/*
+ * Return the specific boot action which will be taken at the soft
+ * reset after the next soft reset; this will be one of the valid
+ * actions for MLXBF_BOOTCTL_SET_SECOND_RESET_ACTION.
+ */
+#define MLXBF_BOOTCTL_GET_SECOND_RESET_ACTION	0x82000005
+
+/*
+ * Return the fuse status of the current chip. The caller should specify
+ * with the second argument if the state of the lifecycle fuses or the
+ * version of secure boot fuse keys left should be returned.
+ */
+#define MLXBF_BOOTCTL_GET_TBB_FUSE_STATUS	0x82000006
+
+/*
+ * Reset eMMC by programming the RST_N register.
+ */
+#define MLXBF_BOOTCTL_SET_EMMC_RST_N		0x82000007
+
+#define MLXBF_BOOTCTL_GET_DIMM_INFO		0x82000008
+
+/* SMC function IDs for SiP Service queries */
+#define MLXBF_BOOTCTL_SIP_SVC_CALL_COUNT	0x8200ff00
+#define MLXBF_BOOTCTL_SIP_SVC_UID		0x8200ff01
+#define MLXBF_BOOTCTL_SIP_SVC_VERSION		0x8200ff03
+
+/* ARM Standard Service Calls version numbers */
+#define MLXBF_BOOTCTL_SVC_VERSION_MAJOR		0x0
+#define MLXBF_BOOTCTL_SVC_VERSION_MINOR		0x2
+
+/* Number of svc calls defined. */
+#define MLXBF_BOOTCTL_NUM_SVC_CALLS 12
+
+/* Valid reset actions for MLXBF_BOOTCTL_SET_RESET_ACTION. */
+#define MLXBF_BOOTCTL_EXTERNAL	0 /* Not boot from eMMC */
+#define MLXBF_BOOTCTL_EMMC	1 /* From primary eMMC boot partition */
+#define MLNX_BOOTCTL_SWAP_EMMC	2 /* Swap eMMC boot partitions and reboot */
+#define MLXBF_BOOTCTL_EMMC_LEGACY	3 /* From primary eMMC in legacy mode */
+
+/* Valid arguments for requesting the fuse status. */
+#define MLXBF_BOOTCTL_FUSE_STATUS_LIFECYCLE	0 /* Return lifecycle status. */
+#define MLXBF_BOOTCTL_FUSE_STATUS_KEYS	1 /* Return secure boot key status */
+
+/* Additional value to disable the MLXBF_BOOTCTL_SET_SECOND_RESET_ACTION. */
+#define MLXBF_BOOTCTL_NONE	0x7fffffff /* Don't change next boot action */
+
+/* Error values (non-zero). */
+#define MLXBF_BOOTCTL_SMCCC_INVALID_PARAMETERS	-2
+
+#endif /* __MLXBF_BOOTCTL_H__ */
-- 
1.8.3.1

