Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbeCPMud (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:50:33 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61360 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeCPMub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:50:31 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] ACPI: Add Time and Alarm Device (TAD) driver
Date: Fri, 16 Mar 2018 13:51:01 +0100
Message-ID: <6419044.RXe4JATo1K@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a driver for the ACPI Time and Alarm Device (TAD) based on
Section 9.18 of ACPI 6.2.

This driver only supports the system wakeup capabilities of the TAD
which are mandatory.  Support for the RTC capabilities of the TAD
will be added to it in the future.

This driver is entirely sysfs-based.  It provides attributes (under
the TAD platform device) to allow user space to manage the AC and DC
wakeup timers of the TAD: set and read their values, set and check
their expire timer wake policies, check and clear their status and
check the capabilities of the TAD reported by AML.  The DC timer
attributes are only present if the TAD supports a separate DC alarm
timer.

The wakeup events handling and power management of the TAD is
expected to be taken care of by the ACPI PM domain attached to its
platform device.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD |  113 +++
 drivers/acpi/Kconfig                                      |   14 
 drivers/acpi/Makefile                                     |    1 
 drivers/acpi/acpi_tad.c                                   |  473 ++++++++++++++
 4 files changed, 601 insertions(+)

Index: linux-pm/drivers/acpi/Kconfig
===================================================================
--- linux-pm.orig/drivers/acpi/Kconfig
+++ linux-pm/drivers/acpi/Kconfig
@@ -217,6 +217,20 @@ config ACPI_FAN
 	  To compile this driver as a module, choose M here:
 	  the module will be called fan.
 
+config ACPI_TAD
+	tristate "ACPI Time and Alarm (TAD) Device Support"
+	depends on SYSFS && PM_SLEEP
+	default n
+	help
+	  The ACPI Time and Alarm (TAD) device is an alternative to the Real
+	  Time Clock (RTC).  Its wake timers allow the system to transition from
+	  the S3 (or optionally S4/S5) state to S0 state after a time period
+	  elapses.  In comparison with the RTC Alarm, the TAD provides a larger
+	  scale of flexibility in the wake timers.  The time capabilities of the
+	  TAD maintain the time of day information across platform power
+	  transitions, and keep track of time even when the platform is turned
+	  off.
+
 config ACPI_DOCK
 	bool "Dock"
 	help
Index: linux-pm/drivers/acpi/Makefile
===================================================================
--- linux-pm.orig/drivers/acpi/Makefile
+++ linux-pm/drivers/acpi/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
 obj-$(CONFIG_ACPI_FAN)		+= fan.o
 obj-$(CONFIG_ACPI_VIDEO)	+= video.o
+obj-$(CONFIG_ACPI_TAD)		+= acpi_tad.o
 obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI)		+= container.o
Index: linux-pm/drivers/acpi/acpi_tad.c
===================================================================
--- /dev/null
+++ linux-pm/drivers/acpi/acpi_tad.c
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACPI Time and Alarm (TAD) Device Driver
+ *
+ * Copyright (C) 2018 Intel Corporation
+ * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+ *
+ * This driver is based on Section 9.18 of the ACPI 6.2 specification revision.
+ *
+ * It only supports the system wakeup capabilities of the TAD.
+ *
+ * Provided are sysfs attributes, available under the TAD platform device,
+ * allowing user space to manage the AC and DC wakeup timers of the TAD:
+ * set and read their values, set and check their expire timer wake policies,
+ * check and clear their status and check the capabilities of the TAD reported
+ * by AML.  The DC timer attributes are only present if the TAD supports a
+ * separate DC alarm timer.
+ *
+ * The wakeup events handling and power management of the TAD is expected to
+ * be taken care of by the ACPI PM domain attached to its platform device.
+ */
+
+#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/suspend.h>
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Rafael J. Wysocki");
+
+/* ACPI TAD capability flags (ACPI 6.2, Section 9.18.2) */
+#define ACPI_TAD_AC_WAKE	BIT(0)
+#define ACPI_TAD_DC_WAKE	BIT(1)
+#define ACPI_TAD_RT		BIT(2)
+#define ACPI_TAD_RT_IN_MS	BIT(3)
+#define ACPI_TAD_S4_S5__GWS	BIT(4)
+#define ACPI_TAD_AC_S4_WAKE	BIT(5)
+#define ACPI_TAD_AC_S5_WAKE	BIT(6)
+#define ACPI_TAD_DC_S4_WAKE	BIT(7)
+#define ACPI_TAD_DC_S5_WAKE	BIT(8)
+
+/* ACPI TAD alarm timer selection */
+#define ACPI_TAD_AC_TIMER	(u32)0
+#define ACPI_TAD_DC_TIMER	(u32)1
+
+/* Special value for disabled timer or expired timer wake policy. */
+#define ACPI_TAD_WAKE_DISABLED	(~(u32)0)
+
+struct acpi_tad_driver_data {
+	u32 capabilities;
+};
+
+static int acpi_tad_wake_set(struct device *dev, char *method, u32 timer_id,
+			     u32 value)
+{
+	acpi_handle handle = ACPI_HANDLE(dev);
+	union acpi_object args[] = {
+		{ .type = ACPI_TYPE_INTEGER, },
+		{ .type = ACPI_TYPE_INTEGER, },
+	};
+	struct acpi_object_list arg_list = {
+		.pointer = args,
+		.count = ARRAY_SIZE(args),
+	};
+	unsigned long long retval;
+	acpi_status status;
+
+	args[0].integer.value = timer_id;
+	args[1].integer.value = value;
+
+	pm_runtime_get_sync(dev);
+
+	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
+
+	pm_runtime_put_sync(dev);
+
+	if (ACPI_FAILURE(status) || retval)
+		return -EIO;
+
+	return 0;
+}
+
+static int acpi_tad_wake_write(struct device *dev, const char *buf, char *method,
+			       u32 timer_id, const char *specval)
+{
+	u32 value;
+
+	if (sysfs_streq(buf, specval)) {
+		value = ACPI_TAD_WAKE_DISABLED;
+	} else {
+		int ret = kstrtou32(buf, 0, &value);
+
+		if (ret)
+			return ret;
+
+		if (value == ACPI_TAD_WAKE_DISABLED)
+			return -EINVAL;
+	}
+
+	return acpi_tad_wake_set(dev, method, timer_id, value);
+}
+
+static ssize_t acpi_tad_wake_read(struct device *dev, char *buf, char *method,
+				  u32 timer_id, const char *specval)
+{
+	acpi_handle handle = ACPI_HANDLE(dev);
+	union acpi_object args[] = {
+		{ .type = ACPI_TYPE_INTEGER, },
+	};
+	struct acpi_object_list arg_list = {
+		.pointer = args,
+		.count = ARRAY_SIZE(args),
+	};
+	unsigned long long retval;
+	acpi_status status;
+
+	args[0].integer.value = timer_id;
+
+	pm_runtime_get_sync(dev);
+
+	status = acpi_evaluate_integer(handle, method, &arg_list, &retval);
+
+	pm_runtime_put_sync(dev);
+
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	if ((u32)retval == ACPI_TAD_WAKE_DISABLED)
+		return sprintf(buf, "%s\n", specval);
+
+	return sprintf(buf, "%u\n", (u32)retval);
+}
+
+static const char *alarm_specval = "disabled";
+
+static int acpi_tad_alarm_write(struct device *dev, const char *buf,
+				u32 timer_id)
+{
+	return acpi_tad_wake_write(dev, buf, "_STV", timer_id, alarm_specval);
+}
+
+static ssize_t acpi_tad_alarm_read(struct device *dev, char *buf, u32 timer_id)
+{
+	return acpi_tad_wake_read(dev, buf, "_TIV", timer_id, alarm_specval);
+}
+
+static const char *policy_specval = "never";
+
+static int acpi_tad_policy_write(struct device *dev, const char *buf,
+				 u32 timer_id)
+{
+	return acpi_tad_wake_write(dev, buf, "_STP", timer_id, policy_specval);
+}
+
+static ssize_t acpi_tad_policy_read(struct device *dev, char *buf, u32 timer_id)
+{
+	return acpi_tad_wake_read(dev, buf, "_TIP", timer_id, policy_specval);
+}
+
+static int acpi_tad_clear_status(struct device *dev, u32 timer_id)
+{
+	acpi_handle handle = ACPI_HANDLE(dev);
+	union acpi_object args[] = {
+		{ .type = ACPI_TYPE_INTEGER, },
+	};
+	struct acpi_object_list arg_list = {
+		.pointer = args,
+		.count = ARRAY_SIZE(args),
+	};
+	unsigned long long retval;
+	acpi_status status;
+
+	args[0].integer.value = timer_id;
+
+	pm_runtime_get_sync(dev);
+
+	status = acpi_evaluate_integer(handle, "_CWS", &arg_list, &retval);
+
+	pm_runtime_put_sync(dev);
+
+	if (ACPI_FAILURE(status) || retval)
+		return -EIO;
+
+	return 0;
+}
+
+static int acpi_tad_status_write(struct device *dev, const char *buf, u32 timer_id)
+{
+	int ret, value;
+
+	ret = kstrtoint(buf, 0, &value);
+	if (ret)
+		return ret;
+
+	if (value)
+		return -EINVAL;
+
+	return acpi_tad_clear_status(dev, timer_id);
+}
+
+static ssize_t acpi_tad_status_read(struct device *dev, char *buf, u32 timer_id)
+{
+	acpi_handle handle = ACPI_HANDLE(dev);
+	union acpi_object args[] = {
+		{ .type = ACPI_TYPE_INTEGER, },
+	};
+	struct acpi_object_list arg_list = {
+		.pointer = args,
+		.count = ARRAY_SIZE(args),
+	};
+	unsigned long long retval;
+	acpi_status status;
+
+	args[0].integer.value = timer_id;
+
+	pm_runtime_get_sync(dev);
+
+	status = acpi_evaluate_integer(handle, "_GWS", &arg_list, &retval);
+
+	pm_runtime_put_sync(dev);
+
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	return sprintf(buf, "0x%02X\n", (u32)retval);
+}
+
+static ssize_t caps_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct acpi_tad_driver_data *dd = dev_get_drvdata(dev);
+
+	return sprintf(buf, "0x%02X\n", dd->capabilities);
+}
+
+static DEVICE_ATTR_RO(caps);
+
+static ssize_t ac_alarm_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	int ret = acpi_tad_alarm_write(dev, buf, ACPI_TAD_AC_TIMER);
+
+	return ret ? ret : count;
+}
+
+static ssize_t ac_alarm_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	return acpi_tad_alarm_read(dev, buf, ACPI_TAD_AC_TIMER);
+}
+
+static DEVICE_ATTR(ac_alarm, S_IRUSR | S_IWUSR, ac_alarm_show, ac_alarm_store);
+
+static ssize_t ac_policy_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	int ret = acpi_tad_policy_write(dev, buf, ACPI_TAD_AC_TIMER);
+
+	return ret ? ret : count;
+}
+
+static ssize_t ac_policy_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return acpi_tad_policy_read(dev, buf, ACPI_TAD_AC_TIMER);
+}
+
+static DEVICE_ATTR(ac_policy, S_IRUSR | S_IWUSR, ac_policy_show, ac_policy_store);
+
+static ssize_t ac_status_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	int ret = acpi_tad_status_write(dev, buf, ACPI_TAD_AC_TIMER);
+
+	return ret ? ret : count;
+}
+
+static ssize_t ac_status_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return acpi_tad_status_read(dev, buf, ACPI_TAD_AC_TIMER);
+}
+
+static DEVICE_ATTR(ac_status, S_IRUSR | S_IWUSR, ac_status_show, ac_status_store);
+
+static struct attribute *acpi_tad_attrs[] = {
+	&dev_attr_caps.attr,
+	&dev_attr_ac_alarm.attr,
+	&dev_attr_ac_policy.attr,
+	&dev_attr_ac_status.attr,
+	NULL,
+};
+static const struct attribute_group acpi_tad_attr_group = {
+	.attrs	= acpi_tad_attrs,
+};
+
+static ssize_t dc_alarm_store(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	int ret = acpi_tad_alarm_write(dev, buf, ACPI_TAD_DC_TIMER);
+
+	return ret ? ret : count;
+}
+
+static ssize_t dc_alarm_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	return acpi_tad_alarm_read(dev, buf, ACPI_TAD_DC_TIMER);
+}
+
+static DEVICE_ATTR(dc_alarm, S_IRUSR | S_IWUSR, dc_alarm_show, dc_alarm_store);
+
+static ssize_t dc_policy_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	int ret = acpi_tad_policy_write(dev, buf, ACPI_TAD_DC_TIMER);
+
+	return ret ? ret : count;
+}
+
+static ssize_t dc_policy_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return acpi_tad_policy_read(dev, buf, ACPI_TAD_DC_TIMER);
+}
+
+static DEVICE_ATTR(dc_policy, S_IRUSR | S_IWUSR, dc_policy_show, dc_policy_store);
+
+static ssize_t dc_status_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	int ret = acpi_tad_status_write(dev, buf, ACPI_TAD_DC_TIMER);
+
+	return ret ? ret : count;
+}
+
+static ssize_t dc_status_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	return acpi_tad_status_read(dev, buf, ACPI_TAD_DC_TIMER);
+}
+
+static DEVICE_ATTR(dc_status, S_IRUSR | S_IWUSR, dc_status_show, dc_status_store);
+
+static struct attribute *acpi_tad_dc_attrs[] = {
+	&dev_attr_dc_alarm.attr,
+	&dev_attr_dc_policy.attr,
+	&dev_attr_dc_status.attr,
+	NULL,
+};
+static const struct attribute_group acpi_tad_dc_attr_group = {
+	.attrs	= acpi_tad_dc_attrs,
+};
+
+static int acpi_tad_disable_timer(struct device *dev, u32 timer_id)
+{
+	return acpi_tad_wake_set(dev, "_STV", timer_id, ACPI_TAD_WAKE_DISABLED);
+}
+
+static int acpi_tad_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct acpi_tad_driver_data *dd = dev_get_drvdata(dev);
+
+	device_init_wakeup(dev, false);
+
+	pm_runtime_get_sync(dev);
+
+	if (dd->capabilities & ACPI_TAD_DC_WAKE)
+		sysfs_remove_group(&dev->kobj, &acpi_tad_dc_attr_group);
+
+	sysfs_remove_group(&dev->kobj, &acpi_tad_attr_group);
+
+	acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
+	acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
+	if (dd->capabilities & ACPI_TAD_DC_WAKE) {
+		acpi_tad_disable_timer(dev, ACPI_TAD_DC_TIMER);
+		acpi_tad_clear_status(dev, ACPI_TAD_DC_TIMER);
+	}
+
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	return 0;
+}
+
+static int acpi_tad_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	acpi_handle handle = ACPI_HANDLE(dev);
+	struct acpi_tad_driver_data *dd;
+	acpi_status status;
+	unsigned long long caps;
+	int ret;
+
+	/*
+	 * Initialization failure messages are mostly about firmware issues, so
+	 * print them at the "info" level.
+	 */
+	status = acpi_evaluate_integer(handle, "_GCP", NULL, &caps);
+	if (ACPI_FAILURE(status)) {
+		dev_info(dev, "Unable to get capabilities\n");
+		return -ENODEV;
+	}
+
+	if (!(caps & ACPI_TAD_AC_WAKE)) {
+		dev_info(dev, "Unsupported capabilities\n");
+		return -ENODEV;
+	}
+
+	if (!acpi_has_method(handle, "_PRW")) {
+		dev_info(dev, "Missing _PRW\n");
+		return -ENODEV;
+	}
+
+	dd = devm_kzalloc(dev, sizeof(*dd), GFP_KERNEL);
+	if (!dd)
+		return -ENOMEM;
+
+	dd->capabilities = caps;
+	dev_set_drvdata(dev, dd);
+
+	/*
+	 * Assume that the ACPI PM domain has been attached to the device and
+	 * simply enable system wakeup and runtime PM and put the device into
+	 * runtime suspend.  Everything else should be taken care of by the ACPI
+	 * PM domain callbacks.
+	 */
+	device_init_wakeup(dev, true);
+	dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND |
+				     DPM_FLAG_LEAVE_SUSPENDED);
+	/*
+	 * The platform bus type layer tells the ACPI PM domain powers up the
+	 * device, so set the runtime PM status of it to "active".
+	 */
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_suspend(dev);
+
+	ret = sysfs_create_group(&dev->kobj, &acpi_tad_attr_group);
+	if (ret)
+		goto fail;
+
+	if (caps & ACPI_TAD_DC_WAKE) {
+		ret = sysfs_create_group(&dev->kobj, &acpi_tad_dc_attr_group);
+		if (ret)
+			goto fail;
+	}
+
+	return 0;
+
+fail:
+	acpi_tad_remove(pdev);
+	return ret;
+}
+
+static const struct acpi_device_id acpi_tad_ids[] = {
+	{"ACPI000E", 0},
+	{}
+};
+
+static struct platform_driver acpi_tad_driver = {
+	.driver = {
+		.name = "acpi-tad",
+		.acpi_match_table = acpi_tad_ids,
+	},
+	.probe = acpi_tad_probe,
+	.remove = acpi_tad_remove,
+};
+MODULE_DEVICE_TABLE(acpi, acpi_tad_ids);
+
+module_platform_driver(acpi_tad_driver);
Index: linux-pm/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
===================================================================
--- /dev/null
+++ linux-pm/Documentation/ABI/testing/sysfs-devices-platform-ACPI-TAD
@@ -0,0 +1,113 @@
+		ACPI Time and Alarm (TAD) device attributes.
+
+What:		/sys/bus/platform/devices/ACPI000E:00/caps
+Date:		March 2018
+Contact:	Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+Description:
+		(RO) Hexadecimal bitmask of the TAD attributes are reported by
+		the platform firmware (see ACPI 6.2, section 9.18.2):
+
+		BIT(0): AC wakeup implemented if set
+		BIT(1): DC wakeup implemented if set
+		BIT(2): Get/set real time features implemented if set
+		BIT(3): Real time accuracy in milliseconds if set
+		BIT(4): Correct status reported for wakeups from S4/S5 if set
+		BIT(5): The AC timer wakes up from S4 if set
+		BIT(6): The AC timer wakes up from S5 if set
+		BIT(7): The DC timer wakes up from S4 if set
+		BIT(8): The DC timer wakes up from S5 if set
+
+		The other bits are reserved.
+
+What:		/sys/bus/platform/devices/ACPI000E:00/ac_alarm
+Date:		March 2018
+Contact:	Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+Description:
+		(RW) The AC alarm timer value.
+
+		Reads return the current AC alarm timer value in seconds or
+		"disabled", if the AC alarm is not set to wake up the system.
+
+		Write a new AC alarm timer value in seconds or "disabled" to it
+		to set the AC alarm timer or to disable it, respectively.
+
+		If the AC alarm timer is set through this attribute and it
+		expires, it will immediately wake up the system from the S3
+		sleep state (and from S4/S5 too if supported) until its status
+		is explicitly cleared via the ac_status attribute.
+
+What:		/sys/bus/platform/devices/ACPI000E:00/ac_policy
+Date:		March 2018
+Contact:	Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+Description:
+		(RW) The AC alarm expired timer wake policy (see ACPI 6.2,
+		Section 9.18 for details).
+
+		Reads return the current expired timer wake delay for the AC
+		alarm timer or "never", if the policy is to discard AC timer
+		wakeups if the system is on DC power.
+
+		Write a new expired timer wake delay for the AC alarm timer in
+		seconds or "never" to it to set the expired timer wake delay for
+		the AC alarm timer or to set its expired wake policy to discard
+		wakeups if the system is on DC power, respectively.
+
+What:		/sys/bus/platform/devices/ACPI000E:00/ac_status
+Date:		March 2018
+Contact:	Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+Description:
+		(RW) The AC alarm status.
+
+		Reads return a hexadecimal bitmask representing the AC alarm
+		timer status with the following meaning of bits (see ACPI 6.2,
+		Section 9.18.5):
+
+		Bit(0): The timer has expired if set.
+		Bit(1): The timer has woken up the system from a sleep state
+		        (S3 or S4/S5 if supported) if set.
+
+		The other bits are reserved.
+
+		Reads also cause the AC alarm timer status to be reset.
+
+		Another way to reset the the status of the AC alarm timer is to
+		write (the number) 0 to this file.
+
+		If the status return value indicates that the timer has expired,
+		it will immediately wake up the system from the S3 sleep state
+		(and from S4/S5 too if supported) until its status is explicitly
+		cleared through this attribute.
+
+What:		/sys/bus/platform/devices/ACPI000E:00/dc_alarm
+Date:		March 2018
+Contact:	Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+Description:
+		(RW,optional) The DC alarm timer value.
+
+		This attribute is only present if the TAD supports a separate
+		DC timer.
+
+		It is analogous to the ac_alarm attribute.
+
+What:		/sys/bus/platform/devices/ACPI000E:00/dc_policy
+Date:		March 2018
+Contact:	Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+Description:
+		(RW,optional) The DC alarm expired timer wake policy.
+
+		This attribute is only present if the TAD supports a separate
+		DC timer.
+
+		It is analogous to the ac_policy attribute.
+
+What:		/sys/bus/platform/devices/ACPI000E:00/dc_status
+Date:		March 2018
+Contact:	Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+
+Description:
+		(RW,optional) The DC alarm status.
+
+		This attribute is only present if the TAD supports a separate
+		DC timer.
+
+		It is analogous to the ac_status attribute.
