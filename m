Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AG47ELvf4DF5sh2DAn39mVFqWNNGifZ9k89ZZQRbGF+Ilsp6Too5qRMzMPQb3qGuF0mnqFj+zjyx
ARC-Seal: i=1; a=rsa-sha256; t=1519636177; cv=none;
        d=google.com; s=arc-20160816;
        b=H1iBlOjZRJvdY3MQXvU0ejB2er4Lsjwm98ieWHx0i35eCkuTeO5k5nU13lqayKpUJw
         CeqxWc4m4xPDq3YivNIqXX2b82hsjSBpFObDSak/uyKynkspNIUAfzPBkX6047oxxUHO
         V+ncSTJzMZJa7j1Ng6NzWprPOx7GSzTiDzPKNaEPPEfTITE0YQrKu+V8tpBbY7c/RHkJ
         FeHFcuLvDuXniRYaVr7lxj8kDyqBvXVlvZRo2SFm0a5N/8x5KH/Kz6K9g0DjY/3NXov9
         qWhTCnWsLEGpa5FDq2Cp14kuW8MzMsDp3SqBc8YAP9YhmN4M7tT+sCS7tRTvb8H3/2O9
         Vb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=egWn7Opvg+LBb+pXxv+5/VK/9UYfGT+EH8vjowK0d+M=;
        b=R9i95a9KAjaiJ0CfuKYFkjAtHTWa/5eASD26l3ABThMKr0GG38SSFwQWv3QagGYcOC
         ovX5ejlcc0My1XoGrOxDFtx0rfK7tr6mjk4xLdnNdouATN5XuLEppCKtKfg64+snqyjK
         xgiDr087yJiSE/Iv9dzh2iPefsFT+J3sdIQ9EPHYWlvkPyE1ydod/GpzH9wEtMpwX3b5
         2iXMUZNkOAr9ZK/ZVgeWOV50B2OOcgz+tpzCqqxHmsqEC9XYLXgTSMzfBy771Vq6B+5S
         bLJ2mea+h8soqi37wrtbEa09RFaTaeUxmFI/ahiC9BxyeodwwHHHranIqcI9bNgKFqfx
         kKhA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v3 04/12] usb: common: Small class for USB role switches
Date: Mon, 26 Feb 2018 10:09:17 +0100
Message-Id: <20180226090925.29436-5-hdegoede@redhat.com>
In-Reply-To: <20180226090925.29436-1-hdegoede@redhat.com>
References: <20180226090925.29436-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593454024376318409?=
X-GMAIL-MSGID: =?utf-8?q?1593454024376318409?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

USB role switch is a device that can be used to choose the
data role for USB connector. With dual-role capable USB
controllers, the controller itself will be the switch, but
on some platforms the USB host and device controllers are
separate IPs and there is a mux between them and the
connector. On those platforms the mux driver will need to
register the switch.

With USB Type-C connectors, the host-to-device relationship
is negotiated over the Configuration Channel (CC). That
means the USB Type-C drivers need to be in control of the
role switch. The class provides a simple API for the USB
Type-C drivers for the control.

For other types of USB connectors (mainly microAB) the class
provides user space control via sysfs attribute file that
can be used to request role swapping from the switch.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Minor style fixes from review of v1
---
 Documentation/ABI/testing/sysfs-class-usb_role |  21 ++
 drivers/usb/Kconfig                            |   3 +
 drivers/usb/common/Makefile                    |   1 +
 drivers/usb/common/roles.c                     | 305 +++++++++++++++++++++++++
 include/linux/usb/role.h                       |  51 +++++
 5 files changed, 381 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-usb_role
 create mode 100644 drivers/usb/common/roles.c
 create mode 100644 include/linux/usb/role.h

diff --git a/Documentation/ABI/testing/sysfs-class-usb_role b/Documentation/ABI/testing/sysfs-class-usb_role
new file mode 100644
index 000000000000..3b810a425a52
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-usb_role
@@ -0,0 +1,21 @@
+What:		/sys/class/usb_role/
+Date:		Jan 2018
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Place in sysfs for USB Role Switches. USB Role Switch is a
+		device that can select the data role (host or device) for USB
+		port.
+
+What:		/sys/class/usb_role/<switch>/role
+Date:		Jan 2018
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		The current role of the switch. This attribute can be used for
+		requesting role swapping with non-USB Type-C ports. With USB
+		Type-C ports, the ABI defined for USB Type-C connector class
+		must be used.
+
+		Valid values:
+		- none
+		- host
+		- device
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 148f3ee70286..f278958e04ca 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -203,4 +203,7 @@ config USB_ULPI_BUS
 	  To compile this driver as a module, choose M here: the module will
 	  be called ulpi.
 
+config USB_ROLE_SWITCH
+	tristate
+
 endif # USB_SUPPORT
diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
index 0a7c45e85481..fb4d5ef4165c 100644
--- a/drivers/usb/common/Makefile
+++ b/drivers/usb/common/Makefile
@@ -9,3 +9,4 @@ usb-common-$(CONFIG_USB_LED_TRIG) += led.o
 
 obj-$(CONFIG_USB_OTG_FSM) += usb-otg-fsm.o
 obj-$(CONFIG_USB_ULPI_BUS)	+= ulpi.o
+obj-$(CONFIG_USB_ROLE_SWITCH)	+= roles.o
diff --git a/drivers/usb/common/roles.c b/drivers/usb/common/roles.c
new file mode 100644
index 000000000000..c46b7fb4718d
--- /dev/null
+++ b/drivers/usb/common/roles.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USB Role Switch Support
+ *
+ * Copyright (C) 2018 Intel Corporation
+ * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
+ *         Hans de Goede <hdegoede@redhat.com>
+ */
+
+#include <linux/connection.h>
+#include <linux/usb/role.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+static struct class *role_class;
+
+struct usb_role_switch {
+	struct device dev;
+	struct mutex lock; /* device lock*/
+	enum usb_role role;
+
+	/* From descriptor */
+	struct device *usb2_port;
+	struct device *usb3_port;
+	struct device *udc;
+	usb_role_switch_set_t set;
+	usb_role_switch_get_t get;
+	bool allow_userspace_control;
+};
+
+#define to_role_switch(d)	container_of(d, struct usb_role_switch, dev)
+
+/**
+ * usb_role_switch_set_role - Set USB role for a switch
+ * @sw: USB role switch
+ * @role: USB role to be switched to
+ *
+ * Set USB role @role for @sw.
+ */
+int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
+{
+	int ret;
+
+	if (!sw || IS_ERR(sw))
+		return 0;
+
+	mutex_lock(&sw->lock);
+
+	ret = sw->set(sw->dev.parent, role);
+	if (!ret)
+		sw->role = role;
+
+	mutex_unlock(&sw->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_set_role);
+
+/**
+ * usb_role_switch_get_role - Get the USB role for a switch
+ * @sw: USB role switch
+ *
+ * Depending on the role-switch-driver this function returns either a cached
+ * value of the last set role, or reads back the actual value from the hardware.
+ */
+enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
+{
+	enum usb_role role;
+
+	if (IS_ERR_OR_NULL(sw))
+		return USB_ROLE_NONE;
+
+	mutex_lock(&sw->lock);
+
+	if (sw->get)
+		role = sw->get(sw->dev.parent);
+	else
+		role = sw->role;
+
+	mutex_unlock(&sw->lock);
+
+	return role;
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
+
+static int __switch_match(struct device *dev, const void *name)
+{
+	return !strcmp((const char *)name, dev_name(dev));
+}
+
+static void *usb_role_switch_match(struct devcon *con, int ep, void *data)
+{
+	struct device *dev;
+
+	dev = class_find_device(role_class, NULL, con->endpoint[ep],
+				__switch_match);
+
+	return dev ? to_role_switch(dev) : ERR_PTR(-EPROBE_DEFER);
+}
+
+/**
+ * usb_role_switch_get - Find USB role switch linked with the caller
+ * @dev: The caller device
+ *
+ * Finds and returns role switch linked with @dev. The reference count for the
+ * found switch is incremented.
+ */
+struct usb_role_switch *usb_role_switch_get(struct device *dev)
+{
+	return __device_find_connection(dev, "usb-role-switch", NULL,
+					usb_role_switch_match);
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_get);
+
+/**
+ * usb_role_switch_put - Release handle to a switch
+ * @sw: USB Role Switch
+ *
+ * Decrement reference count for @sw.
+ */
+void usb_role_switch_put(struct usb_role_switch *sw)
+{
+	if (!IS_ERR_OR_NULL(sw))
+		put_device(&sw->dev);
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_put);
+
+static umode_t
+usb_role_switch_is_visible(struct kobject *kobj, struct attribute *attr, int n)
+{
+	struct device *dev = container_of(kobj, typeof(*dev), kobj);
+	struct usb_role_switch *sw = to_role_switch(dev);
+
+	if (sw->allow_userspace_control)
+		return attr->mode;
+
+	return 0;
+}
+
+static const char * const usb_roles[] = {
+	[USB_ROLE_NONE]		= "none",
+	[USB_ROLE_HOST]		= "host",
+	[USB_ROLE_DEVICE]	= "device",
+};
+
+static ssize_t
+role_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct usb_role_switch *sw = to_role_switch(dev);
+	enum usb_role role = usb_role_switch_get_role(sw);
+
+	return sprintf(buf, "%s\n", usb_roles[role]);
+}
+
+static ssize_t role_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t size)
+{
+	struct usb_role_switch *sw = to_role_switch(dev);
+	int ret;
+
+	ret = sysfs_match_string(usb_roles, buf);
+	if (ret < 0) {
+		bool res;
+
+		/* Extra check if the user wants to disable the switch */
+		ret = kstrtobool(buf, &res);
+		if (ret || res)
+			return -EINVAL;
+	}
+
+	ret = usb_role_switch_set_role(sw, ret);
+	if (ret)
+		return ret;
+
+	return size;
+}
+static DEVICE_ATTR_RW(role);
+
+static struct attribute *usb_role_switch_attrs[] = {
+	&dev_attr_role.attr,
+	NULL,
+};
+
+static const struct attribute_group usb_role_switch_group = {
+	.is_visible = usb_role_switch_is_visible,
+	.attrs = usb_role_switch_attrs,
+};
+
+static const struct attribute_group *usb_role_switch_groups[] = {
+	&usb_role_switch_group,
+	NULL,
+};
+
+static int
+usb_role_switch_uevent(struct device *dev, struct kobj_uevent_env *env)
+{
+	int ret;
+
+	ret = add_uevent_var(env, "USB_ROLE_SWITCH=%s", dev_name(dev));
+	if (ret)
+		dev_err(dev, "failed to add uevent USB_ROLE_SWITCH\n");
+
+	return ret;
+}
+
+static void usb_role_switch_release(struct device *dev)
+{
+	struct usb_role_switch *sw = to_role_switch(dev);
+
+	kfree(sw);
+}
+
+static const struct device_type usb_role_dev_type = {
+	.name = "usb_role_switch",
+	.groups = usb_role_switch_groups,
+	.uevent = usb_role_switch_uevent,
+	.release = usb_role_switch_release,
+};
+
+/**
+ * usb_role_switch_register - Register USB Role Switch
+ * @parent: Parent device for the switch
+ * @desc: Description of the switch
+ *
+ * USB Role Switch is a device capable or choosing the role for USB connector.
+ * On platforms where the USB controller is dual-role capable, the controller
+ * driver will need to register the switch. On platforms where the USB host and
+ * USB device controllers behind the connector are separate, there will be a
+ * mux, and the driver for that mux will need to register the switch.
+ *
+ * Returns handle to a new role switch or ERR_PTR. The content of @desc is
+ * copied.
+ */
+struct usb_role_switch *
+usb_role_switch_register(struct device *parent,
+			 const struct usb_role_switch_desc *desc)
+{
+	struct usb_role_switch *sw;
+	int ret;
+
+	if (!desc || !desc->set)
+		return ERR_PTR(-EINVAL);
+
+	sw = kzalloc(sizeof(*sw), GFP_KERNEL);
+	if (!sw)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&sw->lock);
+
+	sw->allow_userspace_control = desc->allow_userspace_control;
+	sw->usb2_port = desc->usb2_port;
+	sw->usb3_port = desc->usb3_port;
+	sw->udc = desc->udc;
+	sw->set = desc->set;
+	sw->get = desc->get;
+
+	sw->dev.parent = parent;
+	sw->dev.class = role_class;
+	sw->dev.type = &usb_role_dev_type;
+	dev_set_name(&sw->dev, "%s-role-switch", dev_name(parent));
+
+	ret = device_register(&sw->dev);
+	if (ret) {
+		put_device(&sw->dev);
+		return ERR_PTR(ret);
+	}
+
+	/* TODO: Symlinks for the host port and the device controller. */
+
+	return sw;
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_register);
+
+/**
+ * usb_role_switch_unregister - Unregsiter USB Role Switch
+ * @sw: USB Role Switch
+ *
+ * Unregister switch that was registered with usb_role_switch_register().
+ */
+void usb_role_switch_unregister(struct usb_role_switch *sw)
+{
+	if (sw && !IS_ERR(sw))
+		device_unregister(&sw->dev);
+}
+EXPORT_SYMBOL_GPL(usb_role_switch_unregister);
+
+static int __init usb_roles_init(void)
+{
+	role_class = class_create(THIS_MODULE, "usb_role");
+	return PTR_ERR_OR_ZERO(role_class);
+}
+subsys_initcall(usb_roles_init);
+
+static void __exit usb_roles_exit(void)
+{
+	class_destroy(role_class);
+}
+module_exit(usb_roles_exit);
+
+MODULE_AUTHOR("Heikki Krogerus <heikki.krogerus@linux.intel.com>");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("USB Role Class");
diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
new file mode 100644
index 000000000000..2ef347bd1fdb
--- /dev/null
+++ b/include/linux/usb/role.h
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __LINUX_USB_ROLE_H
+#define __LINUX_USB_ROLE_H
+
+struct usb_role_switch;
+
+enum usb_role {
+	USB_ROLE_NONE,
+	USB_ROLE_HOST,
+	USB_ROLE_DEVICE,
+};
+
+typedef int (*usb_role_switch_set_t)(struct device *dev, enum usb_role role);
+typedef enum usb_role (*usb_role_switch_get_t)(struct device *dev);
+
+/**
+ * struct usb_role_switch_desc - USB Role Switch Descriptor
+ * @usb2_port: Optional reference to the host controller port device (USB2)
+ * @usb3_port: Optional reference to the host controller port device (USB3)
+ * @udc: Optional reference to the peripheral controller device
+ * @set: Callback for setting the role
+ * @get: Callback for getting the role (optional)
+ * @allow_userspace_control: If true userspace may change the role through sysfs
+ *
+ * @usb2_port and @usb3_port will point to the USB host port and @udc to the USB
+ * device controller behind the USB connector with the role switch. If
+ * @usb2_port, @usb3_port and @udc are included in the description, the
+ * reference count for them should be incremented by the caller of
+ * usb_role_switch_register() before registering the switch.
+ */
+struct usb_role_switch_desc {
+	struct device *usb2_port;
+	struct device *usb3_port;
+	struct device *udc;
+	usb_role_switch_set_t set;
+	usb_role_switch_get_t get;
+	bool allow_userspace_control;
+};
+
+int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role);
+enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw);
+struct usb_role_switch *usb_role_switch_get(struct device *dev);
+void usb_role_switch_put(struct usb_role_switch *sw);
+
+struct usb_role_switch *
+usb_role_switch_register(struct device *parent,
+			 const struct usb_role_switch_desc *desc);
+void usb_role_switch_unregister(struct usb_role_switch *sw);
+
+#endif /* __LINUX_USB_ROLE_H */
-- 
2.14.3
