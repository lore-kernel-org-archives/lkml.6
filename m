Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B4FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BA72081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 14:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BA72081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbeKJACo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 19:02:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:21407 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727735AbeKJACo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 19:02:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2018 06:21:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,483,1534834800"; 
   d="scan'208";a="106729701"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 09 Nov 2018 06:21:52 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v2 4/6] drivers: base: Introducing software nodes to the firmware node framework
Date:   Fri,  9 Nov 2018 17:21:36 +0300
Message-Id: <20181109142138.54770-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181109142138.54770-1-heikki.krogerus@linux.intel.com>
References: <20181109142138.54770-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Software node is a new struct fwnode_handle type that can be
used to describe devices in kernel (software). It is meant
to complement fwnodes representing real firmware nodes when
they are incomplete (for example missing device properties)
and to supply the primary fwnode when the firmware lacks
hardware description for a device completely.

The software node type is really meant to replace the
currently used "property_set" struct fwnode_handle type. The
handling of struct property_set is glued to the generic
device property handling code, and it is not possible to
create a struct property_set independently from the device
that it is bind to. struct property_set is only created when
device properties are added to already initialized struct
device, and control of it is only possible from the generic
property handling code.

Software nodes are instead designed to be created
independently from the device entries (struct device). It
makes them much more flexible, as then the device meant to
be bind to the node can be created at a later time, and from
another location. It is also possible to bind multiple
devices to a single software node if needed.

The software node implementation also includes support for
node hierarchy, which was the main motivation for this
commit. The node hierarchy was something that was requested
for the struct property_set, but it did not seem reasonable
to try to extend the property_set support for that purpose.
struct property_set was really meant only for device
property handling like the name suggests.

Support for struct property_set is not yet removed in this
commit, but it will be in the following one.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 .../ABI/testing/sysfs-devices-software_node   |  10 +
 drivers/base/Makefile                         |   2 +-
 drivers/base/core.c                           |   4 +
 drivers/base/swnode.c                         | 494 ++++++++++++++++++
 include/linux/property.h                      |  12 +
 5 files changed, 521 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-software_node
 create mode 100644 drivers/base/swnode.c

diff --git a/Documentation/ABI/testing/sysfs-devices-software_node b/Documentation/ABI/testing/sysfs-devices-software_node
new file mode 100644
index 000000000000..85df37de359f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-software_node
@@ -0,0 +1,10 @@
+What:		/sys/devices/.../software_node/
+Date:		January 2019
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		This directory contains the details about the device that are
+		assigned in kernel (i.e. software), as opposed to the
+		firmware_node directory which contains the details that are
+		assigned for the device in firmware. The main attributes in the
+		directory will show the properties the device has, and the
+		relationship it has to some of the other devices.
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 704f44295810..157452080f3d 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -6,7 +6,7 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   cpu.o firmware.o init.o map.o devres.o \
 			   attribute_container.o transport_class.o \
 			   topology.o container.o property.o cacheinfo.o \
-			   devcon.o
+			   devcon.o swnode.o
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
 obj-y			+= power/
 obj-$(CONFIG_ISA_BUS_API)	+= isa.o
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 260cbdf44f1d..a2f14098663f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -738,6 +738,10 @@ device_platform_notify(struct device *dev, enum kobject_action action)
 	if (ret)
 		return ret;
 
+	ret = software_node_notify(dev, action);
+	if (ret)
+		return ret;
+
 	if (platform_notify && action == KOBJ_ADD)
 		platform_notify(dev);
 	else if (platform_notify_remove && action == KOBJ_REMOVE)
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
new file mode 100644
index 000000000000..95423b72a3f4
--- /dev/null
+++ b/drivers/base/swnode.c
@@ -0,0 +1,494 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Software nodes for the firmware node framework.
+ *
+ * Copyright (C) 2018, Intel Corporation
+ * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+struct software_node {
+	int id;
+	struct kobject kobj;
+	struct fwnode_handle fwnode;
+
+	/* hierarchy */
+	struct ida child_ids;
+	struct list_head entry;
+	struct list_head children;
+	struct software_node *parent;
+
+	/* properties */
+	const struct property_entry *properties;
+};
+
+static DEFINE_IDA(swnode_root_ids);
+static struct kset *swnode_kset;
+
+#define kobj_to_swnode(_kobj_) container_of(_kobj_, struct software_node, kobj)
+
+static const struct fwnode_operations software_node_ops;
+
+bool is_software_node(const struct fwnode_handle *fwnode)
+{
+	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &software_node_ops;
+}
+
+#define to_software_node(__fwnode)					\
+	({								\
+		typeof(__fwnode) __to_software_node_fwnode = __fwnode;	\
+									\
+		is_software_node(__to_software_node_fwnode) ?		\
+			container_of(__to_software_node_fwnode,		\
+				     struct software_node, fwnode) :	\
+			NULL;						\
+	})
+
+/* -------------------------------------------------------------------------- */
+/* property_entry processing */
+
+static const struct property_entry *
+property_entry_get(const struct property_entry *prop, const char *name)
+{
+	if (!prop)
+		return NULL;
+
+	for (; prop->name; prop++)
+		if (!strcmp(name, prop->name))
+			return prop;
+
+	return NULL;
+}
+
+static const void *property_get_pointer(const struct property_entry *prop)
+{
+	switch (prop->type) {
+	case DEV_PROP_U8:
+		if (prop->is_array)
+			return prop->pointer.u8_data;
+		return &prop->value.u8_data;
+	case DEV_PROP_U16:
+		if (prop->is_array)
+			return prop->pointer.u16_data;
+		return &prop->value.u16_data;
+	case DEV_PROP_U32:
+		if (prop->is_array)
+			return prop->pointer.u32_data;
+		return &prop->value.u32_data;
+	case DEV_PROP_U64:
+		if (prop->is_array)
+			return prop->pointer.u64_data;
+		return &prop->value.u64_data;
+	case DEV_PROP_STRING:
+		if (prop->is_array)
+			return prop->pointer.str;
+		return &prop->value.str;
+	default:
+		return NULL;
+	}
+}
+
+static const void *property_entry_find(const struct property_entry *props,
+				       const char *propname, size_t length)
+{
+	const struct property_entry *prop;
+	const void *pointer;
+
+	prop = property_entry_get(props, propname);
+	if (!prop)
+		return ERR_PTR(-EINVAL);
+	pointer = property_get_pointer(prop);
+	if (!pointer)
+		return ERR_PTR(-ENODATA);
+	if (length > prop->length)
+		return ERR_PTR(-EOVERFLOW);
+	return pointer;
+}
+
+static int property_entry_read_u8_array(const struct property_entry *props,
+					const char *propname,
+					u8 *values, size_t nval)
+{
+	const void *pointer;
+	size_t length = nval * sizeof(*values);
+
+	pointer = property_entry_find(props, propname, length);
+	if (IS_ERR(pointer))
+		return PTR_ERR(pointer);
+
+	memcpy(values, pointer, length);
+	return 0;
+}
+
+static int property_entry_read_u16_array(const struct property_entry *props,
+					 const char *propname,
+					 u16 *values, size_t nval)
+{
+	const void *pointer;
+	size_t length = nval * sizeof(*values);
+
+	pointer = property_entry_find(props, propname, length);
+	if (IS_ERR(pointer))
+		return PTR_ERR(pointer);
+
+	memcpy(values, pointer, length);
+	return 0;
+}
+
+static int property_entry_read_u32_array(const struct property_entry *props,
+					 const char *propname,
+					 u32 *values, size_t nval)
+{
+	const void *pointer;
+	size_t length = nval * sizeof(*values);
+
+	pointer = property_entry_find(props, propname, length);
+	if (IS_ERR(pointer))
+		return PTR_ERR(pointer);
+
+	memcpy(values, pointer, length);
+	return 0;
+}
+
+static int property_entry_read_u64_array(const struct property_entry *props,
+					 const char *propname,
+					 u64 *values, size_t nval)
+{
+	const void *pointer;
+	size_t length = nval * sizeof(*values);
+
+	pointer = property_entry_find(props, propname, length);
+	if (IS_ERR(pointer))
+		return PTR_ERR(pointer);
+
+	memcpy(values, pointer, length);
+	return 0;
+}
+
+static int
+property_entry_count_elems_of_size(const struct property_entry *props,
+				   const char *propname, size_t length)
+{
+	const struct property_entry *prop;
+
+	prop = property_entry_get(props, propname);
+	if (!prop)
+		return -EINVAL;
+
+	return prop->length / length;
+}
+
+static int property_entry_read_int_array(const struct property_entry *props,
+					 const char *name,
+					 unsigned int elem_size, void *val,
+					 size_t nval)
+{
+	if (!val)
+		return property_entry_count_elems_of_size(props, name,
+							  elem_size);
+	switch (elem_size) {
+	case sizeof(u8):
+		return property_entry_read_u8_array(props, name, val, nval);
+	case sizeof(u16):
+		return property_entry_read_u16_array(props, name, val, nval);
+	case sizeof(u32):
+		return property_entry_read_u32_array(props, name, val, nval);
+	case sizeof(u64):
+		return property_entry_read_u64_array(props, name, val, nval);
+	}
+
+	return -ENXIO;
+}
+
+static int property_entry_read_string_array(const struct property_entry *props,
+					    const char *propname,
+					    const char **strings, size_t nval)
+{
+	const struct property_entry *prop;
+	const void *pointer;
+	size_t array_len, length;
+
+	/* Find out the array length. */
+	prop = property_entry_get(props, propname);
+	if (!prop)
+		return -EINVAL;
+
+	if (prop->is_array)
+		/* Find the length of an array. */
+		array_len = property_entry_count_elems_of_size(props, propname,
+							  sizeof(const char *));
+	else
+		/* The array length for a non-array string property is 1. */
+		array_len = 1;
+
+	/* Return how many there are if strings is NULL. */
+	if (!strings)
+		return array_len;
+
+	array_len = min(nval, array_len);
+	length = array_len * sizeof(*strings);
+
+	pointer = property_entry_find(props, propname, length);
+	if (IS_ERR(pointer))
+		return PTR_ERR(pointer);
+
+	memcpy(strings, pointer, length);
+
+	return array_len;
+}
+
+/* -------------------------------------------------------------------------- */
+/* fwnode operations */
+
+static struct fwnode_handle *software_node_get(struct fwnode_handle *fwnode)
+{
+	struct software_node *swnode = to_software_node(fwnode);
+
+	kobject_get(&swnode->kobj);
+
+	return &swnode->fwnode;
+}
+
+static void software_node_put(struct fwnode_handle *fwnode)
+{
+	struct software_node *swnode = to_software_node(fwnode);
+
+	kobject_put(&swnode->kobj);
+}
+
+static bool software_node_property_present(const struct fwnode_handle *fwnode,
+					   const char *propname)
+{
+	return !!property_entry_get(to_software_node(fwnode)->properties,
+				    propname);
+}
+
+static int software_node_read_int_array(const struct fwnode_handle *fwnode,
+					const char *propname,
+					unsigned int elem_size, void *val,
+					size_t nval)
+{
+	struct software_node *swnode = to_software_node(fwnode);
+
+	return property_entry_read_int_array(swnode->properties, propname,
+					     elem_size, val, nval);
+}
+
+static int software_node_read_string_array(const struct fwnode_handle *fwnode,
+					   const char *propname,
+					   const char **val, size_t nval)
+{
+	struct software_node *swnode = to_software_node(fwnode);
+
+	return property_entry_read_string_array(swnode->properties, propname,
+						val, nval);
+}
+
+struct fwnode_handle *
+software_node_get_parent(const struct fwnode_handle *fwnode)
+{
+	struct software_node *swnode = to_software_node(fwnode);
+
+	return swnode->parent ? &swnode->parent->fwnode : NULL;
+}
+
+struct fwnode_handle *
+software_node_get_next_child(const struct fwnode_handle *fwnode,
+			     struct fwnode_handle *child)
+{
+	struct software_node *p = to_software_node(fwnode);
+	struct software_node *c = to_software_node(child);
+
+	if (list_empty(&p->children) ||
+	    (c && list_is_last(&c->entry, &p->children)))
+		return NULL;
+
+	if (c)
+		c = list_next_entry(c, entry);
+	else
+		c = list_first_entry(&p->children, struct software_node, entry);
+	return &c->fwnode;
+}
+
+
+static const struct fwnode_operations software_node_ops = {
+	.get = software_node_get,
+	.put = software_node_put,
+	.property_present = software_node_property_present,
+	.property_read_int_array = software_node_read_int_array,
+	.property_read_string_array = software_node_read_string_array,
+	.get_parent = software_node_get_parent,
+	.get_next_child_node = software_node_get_next_child,
+};
+
+/* -------------------------------------------------------------------------- */
+
+static int
+software_node_register_properties(struct software_node *swnode,
+				  const struct property_entry *properties)
+{
+	struct property_entry *props;
+
+	props = property_entries_dup(properties);
+	if (IS_ERR(props))
+		return PTR_ERR(props);
+
+	swnode->properties = props;
+
+	return 0;
+}
+
+static void software_node_release(struct kobject *kobj)
+{
+	struct software_node *swnode = kobj_to_swnode(kobj);
+
+	if (swnode->parent) {
+		ida_simple_remove(&swnode->parent->child_ids, swnode->id);
+		list_del(&swnode->entry);
+	} else {
+		ida_simple_remove(&swnode_root_ids, swnode->id);
+	}
+
+	ida_destroy(&swnode->child_ids);
+	property_entries_free(swnode->properties);
+	kfree(swnode);
+}
+
+static struct kobj_type software_node_type = {
+	.release = software_node_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+struct fwnode_handle *
+fwnode_create_software_node(const struct property_entry *properties,
+			    const struct fwnode_handle *parent)
+{
+	struct software_node *p = NULL;
+	struct software_node *swnode;
+	char node_name[20];
+	int ret;
+
+	if (parent) {
+		if (IS_ERR(parent))
+			return ERR_CAST(parent);
+		if (!is_software_node(parent))
+			return ERR_PTR(-EINVAL);
+		p = to_software_node(parent);
+	}
+
+	swnode = kzalloc(sizeof(*swnode), GFP_KERNEL);
+	if (!swnode)
+		return ERR_PTR(-ENOMEM);
+
+	ret = ida_simple_get(p ? &p->child_ids : &swnode_root_ids, 0, 0,
+			     GFP_KERNEL);
+	if (ret < 0) {
+		kfree(swnode);
+		return ERR_PTR(ret);
+	}
+
+	swnode->id = ret;
+	sprintf(node_name, "node%d", swnode->id);
+
+	swnode->kobj.kset = swnode_kset;
+	swnode->fwnode.ops = &software_node_ops;
+
+	ida_init(&swnode->child_ids);
+	INIT_LIST_HEAD(&swnode->entry);
+	INIT_LIST_HEAD(&swnode->children);
+	swnode->parent = p;
+
+	if (p)
+		list_add_tail(&swnode->entry, &p->children);
+
+	ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
+				   p ? &p->kobj : NULL, node_name);
+	if (ret) {
+		kobject_put(&swnode->kobj);
+		return ERR_PTR(ret);
+	}
+
+	ret = software_node_register_properties(swnode, properties);
+	if (ret) {
+		kobject_put(&swnode->kobj);
+		return ERR_PTR(ret);
+	}
+
+	kobject_uevent(&swnode->kobj, KOBJ_ADD);
+	return &swnode->fwnode;
+}
+EXPORT_SYMBOL_GPL(fwnode_create_software_node);
+
+void fwnode_remove_software_node(struct fwnode_handle *fwnode)
+{
+	struct software_node *swnode = to_software_node(fwnode);
+
+	if (!swnode)
+		return;
+
+	kobject_put(&swnode->kobj);
+}
+EXPORT_SYMBOL_GPL(fwnode_remove_software_node);
+
+int software_node_notify(struct device *dev, unsigned long action)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	struct software_node *swnode;
+	int ret;
+
+	if (!fwnode)
+		return 0;
+
+	if (!is_software_node(fwnode))
+		fwnode = fwnode->secondary;
+	if (!is_software_node(fwnode))
+		return 0;
+
+	swnode = to_software_node(fwnode);
+
+	switch (action) {
+	case KOBJ_ADD:
+		ret = sysfs_create_link(&dev->kobj, &swnode->kobj,
+					"software_node");
+		if (ret)
+			break;
+
+		ret = sysfs_create_link(&swnode->kobj, &dev->kobj,
+					dev_name(dev));
+		if (ret) {
+			sysfs_remove_link(&dev->kobj, "software_node");
+			break;
+		}
+		kobject_get(&swnode->kobj);
+		break;
+	case KOBJ_REMOVE:
+		sysfs_remove_link(&swnode->kobj, dev_name(dev));
+		sysfs_remove_link(&dev->kobj, "software_node");
+		kobject_put(&swnode->kobj);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int __init software_node_init(void)
+{
+	swnode_kset = kset_create_and_add("software_nodes", NULL, kernel_kobj);
+	if (!swnode_kset)
+		return -ENOMEM;
+	return 0;
+}
+postcore_initcall(software_node_init);
+
+static void __exit software_node_exit(void)
+{
+	ida_destroy(&swnode_root_ids);
+	kset_unregister(swnode_kset);
+}
+__exitcall(software_node_exit);
diff --git a/include/linux/property.h b/include/linux/property.h
index ac8a1ebc4c1b..3789ec755fb6 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -311,4 +311,16 @@ fwnode_graph_get_remote_node(const struct fwnode_handle *fwnode, u32 port,
 int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 				struct fwnode_endpoint *endpoint);
 
+/* -------------------------------------------------------------------------- */
+/* Software fwnode support - when HW description is incomplete or missing */
+
+bool is_software_node(const struct fwnode_handle *fwnode);
+
+int software_node_notify(struct device *dev, unsigned long action);
+
+struct fwnode_handle *
+fwnode_create_software_node(const struct property_entry *properties,
+			    const struct fwnode_handle *parent);
+void fwnode_remove_software_node(struct fwnode_handle *fwnode);
+
 #endif /* _LINUX_PROPERTY_H_ */
-- 
2.19.1

