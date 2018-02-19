Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753455AbeBSQ6p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:58:45 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32812 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753346AbeBSQ6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:58:41 -0500
X-Google-Smtp-Source: AH8x227GRzGlIAW6m7Kl5ZCAagvxmyeE16q6MvVWwIXDsDMale13zLMxEZWdQZ5bUAJhKrxu0AivIg==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        David Lechner <david@lechnology.com>
Subject: [PATCH v4] reset: add support for non-DT systems
Date: Mon, 19 Feb 2018 17:58:37 +0100
Message-Id: <20180219165837.28913-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The reset framework only supports device-tree. There are some platforms
however, which need to use it even in legacy, board-file based mode.

An example of such architecture is the DaVinci family of SoCs which
supports both device tree and legacy boot modes and we don't want to
introduce any regressions.

We're currently working on converting the platform from its hand-crafted
clock API to using the common clock framework. Part of the overhaul will
be representing the chip's power sleep controller's reset lines using
the reset framework.

This changeset extends the core reset code with new reset lookup
structures. Each lookup table contains a set of lookup entries which
allow the reset core to associate reset lines with devices (by
comparing the dev_id and con_id strings).

Machine code can register a set of reset lines using this lookup table
and concerned devices can access them using the regular reset_control
API.

The new lookup function is only called as a fallback in case the
of_node field is NULL and doesn't change anything for current users.

Tested with a dummy reset driver with several lookup entries.

An example lookup table can be found below:

static struct platform_device foobar_reset_dev = {
        .name = "foobar-reset",
};

static struct reset_lookup_entry foobar_reset_lookup_entries[] = {
        { .con_id = "foo",    id = 15 },
        { .con_id = "bar",    id = 5  },
};

static struct reset_lookup_table foobar_reset_lookup_table = {
        .dev_id = "foobar-device",
        .entries = foobar_reset_lookup_entries,
        .num_entries = ARRAY_SIZE(foobar_reset_lookup_entries),
        .dev = &foobar_reset_dev.dev,
};

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: David Lechner <david@lechnology.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
v1 -> v2:
- renamed the new function to __reset_control_get_from_lookup()
- added a missing break; when a matching entry is found
- rearranged the code in __reset_control_get() - we can no longer get to the
  return at the bottom, so remove it and return from
  __reset_control_get_from_lookup() if __of_reset_control_get() fails
- return -ENOENT from reset_contol_get() if we can't find a matching entry,
  prevously returned -EINVAL referred to the fact that we passed a device
  without the of_node which is no longer an error condition
- add a comment about needing a sentinel in the lookup table

v2 -> v3:
- added the reset id number field to the lookup struct so that we don't need
  to rely on the array index

v3 -> v4:
- separated the driver and lookup table registration logic by adding a
  function meant to be called by machine-specific code that adds a lookup
  table to the internal list
- the correct reset controller is now found by first finding the lookup
  table associated with it, then finding the actual reset controller by
  the associated device

 drivers/reset/core.c             | 75 +++++++++++++++++++++++++++++++++++++++-
 include/linux/reset-controller.h | 32 +++++++++++++++++
 2 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index da4292e9de97..fc6abdaf44f2 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -23,6 +23,9 @@
 static DEFINE_MUTEX(reset_list_mutex);
 static LIST_HEAD(reset_controller_list);
 
+static DEFINE_MUTEX(reset_lookup_mutex);
+static LIST_HEAD(reset_lookup_list);
+
 /**
  * struct reset_control - a reset control
  * @rcdev: a pointer to the reset controller device
@@ -493,6 +496,76 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(__of_reset_control_get);
 
+/**
+ * reset_add_lookup_table - add a new reset lookup table
+ * @table: new reset lookup table
+ */
+void reset_add_lookup_table(struct reset_lookup_table *table)
+{
+	mutex_lock(&reset_lookup_mutex);
+	list_add_tail(&table->list, &reset_lookup_list);
+	mutex_unlock(&reset_lookup_mutex);
+}
+EXPORT_SYMBOL_GPL(reset_add_lookup_table);
+
+static struct reset_control *
+reset_control_find_device(struct device *dev, unsigned int id, bool shared)
+{
+	struct reset_controller_dev *rcdev;
+	struct reset_control *rstc = NULL;
+
+	mutex_lock(&reset_list_mutex);
+
+	list_for_each_entry(rcdev, &reset_controller_list, list) {
+		if (rcdev->dev == dev) {
+			rstc = __reset_control_get_internal(rcdev, id, shared);
+			break;
+		}
+	}
+
+	mutex_unlock(&reset_list_mutex);
+
+	return rstc;
+}
+
+static struct reset_control *
+__reset_control_get_from_lookup(struct device *dev, const char *con_id,
+				bool shared, bool optional)
+{
+	const struct reset_lookup_entry *entry;
+	const char *dev_id = dev_name(dev);
+	struct reset_control *rstc = NULL;
+	struct reset_lookup_table *table;
+	int i;
+
+	mutex_lock(&reset_lookup_mutex);
+
+	list_for_each_entry(table, &reset_lookup_list, list) {
+		if (strcmp(table->dev_id, dev_id))
+			continue;
+
+		for (i = 0; i < table->num_entries; i++) {
+			entry = &table->entries[i];
+
+			if ((!con_id && !entry->con_id) ||
+			    !strcmp(con_id, entry->con_id)) {
+				rstc = reset_control_find_device(table->dev,
+								 entry->id,
+								 shared);
+				goto out;
+			}
+		}
+	}
+
+out:
+	mutex_unlock(&reset_lookup_mutex);
+
+	if (!rstc)
+		return optional ? NULL : ERR_PTR(-ENOENT);
+
+	return rstc;
+}
+
 struct reset_control *__reset_control_get(struct device *dev, const char *id,
 					  int index, bool shared, bool optional)
 {
@@ -500,7 +573,7 @@ struct reset_control *__reset_control_get(struct device *dev, const char *id,
 		return __of_reset_control_get(dev->of_node, id, index, shared,
 					      optional);
 
-	return optional ? NULL : ERR_PTR(-EINVAL);
+	return __reset_control_get_from_lookup(dev, id, shared, optional);
 }
 EXPORT_SYMBOL_GPL(__reset_control_get);
 
diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index adb88f8cefbc..b92090b177b7 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -22,6 +22,36 @@ struct reset_control_ops {
 	int (*status)(struct reset_controller_dev *rcdev, unsigned long id);
 };
 
+/**
+ * struct reset_lookup_entry - a single entry in a reset lookup table
+ *
+ * @con_id: name of the reset line (can be NULL)
+ * @id: ID of the reset controller in the reset controller device
+ */
+struct reset_lookup_entry {
+	const char *con_id;
+	unsigned long id;
+};
+
+/**
+ * struct reset_lookup_table - reset controller lookup table
+ *
+ * @list: internal list of lookup tables
+ * @dev: reset controller device associated with this table
+ * @dev_id: name of the device associated with the resets in this table
+ * @entries: list of reset lookup entries
+ * @num_entries: number of reset lookup entries
+ */
+struct reset_lookup_table {
+	struct list_head list;
+	struct device *dev;
+	const char *dev_id;
+	struct reset_lookup_entry *entries;
+	size_t num_entries;
+};
+
+void reset_add_lookup_table(struct reset_lookup_table *table);
+
 struct module;
 struct device_node;
 struct of_phandle_args;
@@ -34,6 +64,7 @@ struct of_phandle_args;
  * @list: internal list of reset controller devices
  * @reset_control_head: head of internal list of requested reset controls
  * @of_node: corresponding device tree node as phandle target
+ * @dev: corresponding device (as fallback when not using OF)
  * @of_reset_n_cells: number of cells in reset line specifiers
  * @of_xlate: translation function to translate from specifier as found in the
  *            device tree to id as given to the reset control ops
@@ -45,6 +76,7 @@ struct reset_controller_dev {
 	struct list_head list;
 	struct list_head reset_control_head;
 	struct device_node *of_node;
+	struct device *dev;
 	int of_reset_n_cells;
 	int (*of_xlate)(struct reset_controller_dev *rcdev,
 			const struct of_phandle_args *reset_spec);
-- 
2.16.1
