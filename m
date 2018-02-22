Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeBVAFW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 19:05:22 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:54808 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeBVAE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 19:04:59 -0500
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Matt Porter <mporter@konsulko.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: [PATCH v5 4/8] of: changesets: Introduce changeset helper methods
Date: Thu, 22 Feb 2018 02:05:27 +0200
Message-Id: <20180222000531.19448-5-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180222000531.19448-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20180222000531.19448-1-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>

Changesets are very powerful, but the lack of a helper API
makes using them cumbersome. Introduce a simple copy based
API that makes things considerably easier.

To wit, adding a property using the raw API.

	struct property *prop;
	prop = kzalloc(sizeof(*prop)), GFP_KERNEL);
	prop->name = kstrdup("compatible");
	prop->value = kstrdup("foo,bar");
	prop->length = strlen(prop->value) + 1;
	of_changeset_add_property(ocs, np, prop);

while using the helper API

	of_changeset_add_property_string(ocs, np, "compatible",
			"foo,bar");

Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
[Fixed memory leak in __of_changeset_add_update_property_copy()]
[Fixed cpu to be32 conversion sparse warnings]
[Move include <linux/slab.h> to fix compilation when !CONFIG_OF_DYNAMIC]
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/of/dynamic.c | 222 ++++++++++++++++++++++++++++++++++
 include/linux/of.h   | 329 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 551 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index a2f0c45836f9..f62083921df2 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -910,3 +910,225 @@ int of_changeset_action(struct of_changeset *ocs, unsigned long action,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_changeset_action);
+
+/* changeset helpers */
+
+/**
+ * of_changeset_create_device_node - Create an empty device node
+ *
+ * @ocs:	changeset pointer
+ * @parent:	parent device node
+ * @fmt:	format string for the node's full_name
+ * @args:	argument list for the format string
+ *
+ * Create an empty device node, marking it as detached and allocated.
+ *
+ * Returns a device node on success, an error encoded pointer otherwise
+ */
+struct device_node *of_changeset_create_device_nodev(
+	struct of_changeset *ocs, struct device_node *parent,
+	const char *fmt, va_list vargs)
+{
+	struct device_node *node;
+
+	node = __of_node_dupv(NULL, fmt, vargs);
+	if (!node)
+		return ERR_PTR(-ENOMEM);
+
+	node->parent = parent;
+	return node;
+}
+EXPORT_SYMBOL_GPL(of_changeset_create_device_nodev);
+
+/**
+ * of_changeset_create_device_node - Create an empty device node
+ *
+ * @ocs:	changeset pointer
+ * @parent:	parent device node
+ * @fmt:	Format string for the node's full_name
+ * ...		Arguments
+ *
+ * Create an empty device node, marking it as detached and allocated.
+ *
+ * Returns a device node on success, an error encoded pointer otherwise
+ */
+__printf(3, 4) struct device_node *
+of_changeset_create_device_node(struct of_changeset *ocs,
+	struct device_node *parent, const char *fmt, ...)
+{
+	va_list vargs;
+	struct device_node *node;
+
+	va_start(vargs, fmt);
+	node = of_changeset_create_device_nodev(ocs, parent, fmt, vargs);
+	va_end(vargs);
+	return node;
+}
+EXPORT_SYMBOL_GPL(of_changeset_create_device_node);
+
+/**
+ * __of_changeset_add_property_copy - Create/update a new property copying
+ *                                    name & value
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @name:	name of the property
+ * @value:	pointer to the value data
+ * @length:	length of the value in bytes
+ * @update:	True on update operation
+ *
+ * Adds/updates a property to the changeset by making copies of the name & value
+ * entries. The @update parameter controls whether an add or update takes place.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+int __of_changeset_add_update_property_copy(struct of_changeset *ocs,
+		struct device_node *np, const char *name, const void *value,
+		int length, bool update)
+{
+	struct property *prop;
+	int ret = -ENOMEM;
+
+	prop = kzalloc(sizeof(*prop), GFP_KERNEL);
+	if (!prop)
+		return -ENOMEM;
+
+	prop->name = kstrdup(name, GFP_KERNEL);
+	if (!prop->name)
+		goto out_err;
+
+	/*
+	 * NOTE: There is no check for zero length value.
+	 * In case of a boolean property, this will allocate a value
+	 * of zero bytes. We do this to work around the use
+	 * of of_get_property() calls on boolean values.
+	 */
+	prop->value = kmemdup(value, length, GFP_KERNEL);
+	if (!prop->value)
+		goto out_err;
+
+	of_property_set_flag(prop, OF_DYNAMIC);
+
+	prop->length = length;
+
+	if (!update)
+		ret = of_changeset_add_property(ocs, np, prop);
+	else
+		ret = of_changeset_update_property(ocs, np, prop);
+
+	if (!ret)
+		return 0;
+
+out_err:
+	kfree(prop->value);
+	kfree(prop->name);
+	kfree(prop);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__of_changeset_add_update_property_copy);
+
+/**
+ * of_changeset_add_property_stringf - Create a new formatted string property
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @name:	name of the property
+ * @fmt:	format of string property
+ * ...		arguments of the format string
+ *
+ * Adds a string property to the changeset by making copies of the name
+ * and the formatted value.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+__printf(4, 5) int of_changeset_add_property_stringf(
+		struct of_changeset *ocs, struct device_node *np,
+		const char *name, const char *fmt, ...)
+{
+	va_list vargs;
+	int ret;
+
+	va_start(vargs, fmt);
+	ret = __of_changeset_add_update_property_stringv(ocs, np, name, fmt,
+			vargs, false);
+	va_end(vargs);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_changeset_add_property_stringf);
+
+/**
+ * of_changeset_update_property_stringf - Update formatted string property
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @name:	name of the property
+ * @fmt:	format of string property
+ * ...		arguments of the format string
+ *
+ * Updates a string property to the changeset by making copies of the name
+ * and the formatted value.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+int of_changeset_update_property_stringf(
+	struct of_changeset *ocs, struct device_node *np,
+	const char *name, const char *fmt, ...)
+{
+	va_list vargs;
+	int ret;
+
+	va_start(vargs, fmt);
+	ret = __of_changeset_add_update_property_stringv(ocs, np, name, fmt,
+			vargs, true);
+	va_end(vargs);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(of_changeset_update_property_stringf);
+
+/**
+ * __of_changeset_add_update_property_string_list - Create/update a string
+ *                                                  list property
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @name:	name of the property
+ * @strs:	pointer to the string list
+ * @count:	string count
+ * @update:	True on update operation
+ *
+ * Adds a string list property to the changeset.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+int __of_changeset_add_update_property_string_list(
+		struct of_changeset *ocs, struct device_node *np,
+		const char *name, const char **strs, int count, bool update)
+{
+	int total = 0, i, ret;
+	char *value, *s;
+
+	for (i = 0; i < count; i++) {
+		/* check if  it's NULL */
+		if (!strs[i])
+			return -EINVAL;
+		total += strlen(strs[i]) + 1;
+	}
+
+	value = kmalloc(total, GFP_KERNEL);
+	if (!value)
+		return -ENOMEM;
+
+	for (i = 0, s = value; i < count; i++) {
+		/* no need to check for NULL, check above */
+		strcpy(s, strs[i]);
+		s += strlen(strs[i]) + 1;
+	}
+
+	ret = __of_changeset_add_update_property_copy(ocs, np, name, value,
+			total, update);
+
+	kfree(value);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(__of_changeset_add_update_property_string_list);
diff --git a/include/linux/of.h b/include/linux/of.h
index da1ee95241c1..f8decae8bd31 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -16,6 +16,7 @@
 #include <linux/errno.h>
 #include <linux/kobject.h>
 #include <linux/mod_devicetable.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/topology.h>
 #include <linux/notifier.h>
@@ -1309,6 +1310,23 @@ static inline int of_changeset_update_property(struct of_changeset *ocs,
 {
 	return of_changeset_action(ocs, OF_RECONFIG_UPDATE_PROPERTY, np, prop);
 }
+
+struct device_node *of_changeset_create_device_nodev(
+	struct of_changeset *ocs, struct device_node *parent,
+	const char *fmt, va_list vargs);
+
+__printf(3, 4) struct device_node *
+of_changeset_create_device_node(struct of_changeset *ocs,
+	struct device_node *parent, const char *fmt, ...);
+
+int __of_changeset_add_update_property_copy(struct of_changeset *ocs,
+		struct device_node *np, const char *name, const void *value,
+		int length, bool update);
+
+int __of_changeset_add_update_property_string_list(
+		struct of_changeset *ocs, struct device_node *np,
+		const char *name, const char **strs, int count, bool update);
+
 #else /* CONFIG_OF_DYNAMIC */
 static inline int of_reconfig_notifier_register(struct notifier_block *nb)
 {
@@ -1328,8 +1346,319 @@ static inline int of_reconfig_get_state_change(unsigned long action,
 {
 	return -EINVAL;
 }
+
+static inline struct device_node *of_changeset_create_device_nodev(
+	struct of_changeset *ocs, struct device_node *parent,
+	const char *fmt, va_list vargs)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline __printf(3, 4) struct device_node *
+of_changeset_create_device_node(struct of_changeset *ocs,
+	struct device_node *parent, const char *fmt, ...)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline int __of_changeset_add_update_property_copy(
+	struct of_changeset *ocs, struct device_node *np,
+	const char *name, const void *value, int length, bool update)
+{
+	return -EINVAL;
+}
+
+static inline __printf(4, 5) int of_changeset_add_property_stringf(
+		struct of_changeset *ocs, struct device_node *np,
+		const char *name, const char *fmt, ...)
+{
+	return -EINVAL;
+}
+
+static inline int of_changeset_update_property_stringf(
+	struct of_changeset *ocs, struct device_node *np,
+	const char *name, const char *fmt, ...)
+{
+	return -EINVAL;
+}
+
+static inline int __of_changeset_add_update_property_string_list(
+		struct of_changeset *ocs, struct device_node *np,
+		const char *name, const char **strs, int count, bool update)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_OF_DYNAMIC */
 
+/**
+ * of_changeset_add_property_copy - Create a new property copying name & value
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @name:	name of the property
+ * @value:	pointer to the value data
+ * @length:	length of the value in bytes
+ *
+ * Adds a property to the changeset by making copies of the name & value
+ * entries.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+static inline int of_changeset_add_property_copy(struct of_changeset *ocs,
+	struct device_node *np, const char *name,
+	const void *value, int length)
+{
+	return __of_changeset_add_update_property_copy(ocs, np, name, value,
+			length, false);
+}
+
+/**
+ * of_changeset_update_property_copy - Update a property copying name & value
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @name:	name of the property
+ * @value:	pointer to the value data
+ * @length:	length of the value in bytes
+ *
+ * Update a property to the changeset by making copies of the name & value
+ * entries.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+static inline int of_changeset_update_property_copy(struct of_changeset *ocs,
+	struct device_node *np, const char *name,
+	const void *value, int length)
+{
+	return __of_changeset_add_update_property_copy(ocs, np, name, value,
+			length, true);
+}
+
+/**
+ * __of_changeset_add_update_property_string - Create/update a string property
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @name:	name of the property
+ * @str:	string property value
+ * @update:	True on update operation
+ *
+ * Adds/updates a string property to the changeset by making copies of the name
+ * and the given value. The @update parameter controls whether an add or
+ * update takes place.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+static inline int __of_changeset_add_update_property_string(
+	struct of_changeset *ocs, struct device_node *np, const char *name,
+	const char *str, bool update)
+{
+	return __of_changeset_add_update_property_copy(ocs, np, name, str,
+			strlen(str) + 1, update);
+}
+
+/**
+ * __of_changeset_add_update_property_stringv - Create/update a formatted
+ *						string property
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @name:	name of the property
+ * @fmt:	format of string property
+ * @vargs:	arguments of the format string
+ * @update:	True on update operation
+ *
+ * Adds/updates a string property to the changeset by making copies of the name
+ * and the formatted value. The @update parameter controls whether an add or
+ * update takes place.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+static inline int __of_changeset_add_update_property_stringv(
+	struct of_changeset *ocs, struct device_node *np, const char *name,
+	const char *fmt, va_list vargs, bool update)
+{
+	char *str;
+	int ret;
+
+	str = kvasprintf(GFP_KERNEL, fmt, vargs);
+	if (!str)
+		return -ENOMEM;
+	ret = __of_changeset_add_update_property_string(ocs, np, name, str,
+			update);
+	kfree(str);
+
+	return ret;
+}
+
+/**
+ * of_changeset_add_property_string_list - Create a new string list property
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @name:	name of the property
+ * @strs:	pointer to the string list
+ * @count:	string count
+ *
+ * Adds a string list property to the changeset.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+static inline int of_changeset_add_property_string_list(
+	struct of_changeset *ocs, struct device_node *np, const char *name,
+	const char **strs, int count)
+{
+	return __of_changeset_add_update_property_string_list(ocs, np, name,
+			strs, count, false);
+}
+
+/**
+ * of_changeset_update_property_string_list - Update string list property
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @name:	name of the property
+ * @strs:	pointer to the string list
+ * @count:	string count
+ *
+ * Updates a string list property to the changeset.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+static inline int of_changeset_update_property_string_list(
+	struct of_changeset *ocs, struct device_node *np,
+	const char *name, const char **strs, int count)
+{
+	return __of_changeset_add_update_property_string_list(ocs, np, name,
+			strs, count, true);
+}
+
+/**
+ * of_changeset_add_property_string - Adds a string property
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @name:	name of the property
+ * @str:	string property
+ *
+ * Adds a string property to the changeset by making copies of the name
+ * and the string value.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+static inline int of_changeset_add_property_string(
+	struct of_changeset *ocs, struct device_node *np,
+	const char *name, const char *str)
+{
+	return __of_changeset_add_update_property_string(ocs, np, name, str,
+			false);
+}
+
+/**
+ * of_changeset_update_property_string - Update a string property
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @name:	name of the property
+ * @str:	string property
+ *
+ * Updates a string property to the changeset by making copies of the name
+ * and the string value.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+static inline int of_changeset_update_property_string(
+	struct of_changeset *ocs, struct device_node *np,
+	const char *name, const char *str)
+{
+	return __of_changeset_add_update_property_string(ocs, np, name, str,
+			true);
+}
+
+/**
+ * of_changeset_add_property_u32 - Create a new u32 property
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @name:	name of the property
+ * @val:	value in host endian format
+ *
+ * Adds a u32 property to the changeset.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+static inline int of_changeset_add_property_u32(struct of_changeset *ocs,
+		struct device_node *np, const char *name, u32 val)
+{
+	__be32 v = cpu_to_be32(val);
+
+	return __of_changeset_add_update_property_copy(ocs, np, name, &v,
+			sizeof(v), false);
+}
+
+/**
+ * of_changeset_update_property_u32 - Update u32 property
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @name:	name of the property
+ * @val:	value in host endian format
+ *
+ * Updates a u32 property to the changeset.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+static inline int of_changeset_update_property_u32(
+	struct of_changeset *ocs, struct device_node *np,
+	const char *name, u32 val)
+{
+	__be32 v = cpu_to_be32(val);
+
+	return __of_changeset_add_update_property_copy(ocs, np, name, &v,
+			sizeof(v), true);
+}
+
+/**
+ * of_changeset_add_property_bool - Create a new u32 property
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @name:	name of the property
+ *
+ * Adds a bool property to the changeset. Note that there is
+ * no option to set the value to false, since the property
+ * existing sets it to true.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+static inline int of_changeset_add_property_bool(
+	struct of_changeset *ocs, struct device_node *np, const char *name)
+{
+	return __of_changeset_add_update_property_copy(ocs, np, name, "", 0,
+			false);
+}
+
+/**
+ * of_changeset_update_property_bool - Update a bool property
+ *
+ * @ocs:	changeset pointer
+ * @np:		device node pointer
+ * @name:	name of the property
+ *
+ * Updates a property to the changeset. Note that there is
+ * no option to set the value to false, since the property
+ * existing sets it to true.
+ *
+ * Returns zero on success, a negative error value otherwise.
+ */
+static inline int of_changeset_update_property_bool(struct of_changeset *ocs,
+		struct device_node *np, const char *name)
+{
+	return __of_changeset_add_update_property_copy(ocs, np, name, "", 0,
+			true);
+}
+
 /**
  * of_device_is_system_power_controller - Tells if system-power-controller is found for device_node
  * @np: Pointer to the given device_node
-- 
Regards,

Laurent Pinchart
