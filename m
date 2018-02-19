Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeBSMem (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 07:34:42 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41560 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752638AbeBSMel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 07:34:41 -0500
X-Google-Smtp-Source: AH8x224QfPvPS7dTCf5/+f8QL6rCgxGXYf4w4+2ZHib9rwtRYOn7vc+FLM+9NMXzcrv3YcqchcXYeQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        David Lechner <david@lechnology.com>
Subject: [PATCH v3] reset: add support for non-DT systems
Date: Mon, 19 Feb 2018 13:34:35 +0100
Message-Id: <20180219123435.12007-1-brgl@bgdev.pl>
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

This changeset extends the core reset code with a new field in the
reset controller struct which contains an array of lookup entries. Each
entry contains the device name, an additional, optional identifier
string and the reset id number.

Drivers can register a set of reset lines using this lookup table and
concerned devices can access them using the regular reset_control API.

This new function is only called as a fallback in case the of_node
field is NULL and doesn't change anything for current users.

Tested with a dummy reset driver with several lookup entries.

An example lookup table can look like this:

static const struct reset_lookup foobar_reset_lookup[] = {
	{ .dev = "foo",   .reset_id = "foo_id",    .id = 14 },
	{ .dev = "bar",   .id = NULL,              .id = 3  },
	{ }
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

 drivers/reset/core.c             | 40 +++++++++++++++++++++++++++++++++++++++-
 include/linux/reset-controller.h | 17 +++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index da4292e9de97..7dceab1012a6 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -493,6 +493,44 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(__of_reset_control_get);
 
+static struct reset_control *
+__reset_control_get_from_lookup(struct device *dev, const char *reset_id,
+				bool shared, bool optional)
+{
+	struct reset_controller_dev *rcdev;
+	const char *dev_id = dev_name(dev);
+	struct reset_control *rstc = NULL;
+	const struct reset_lookup *lookup;
+	int index;
+
+	mutex_lock(&reset_list_mutex);
+
+	list_for_each_entry(rcdev, &reset_controller_list, list) {
+		if (!rcdev->lookup)
+			continue;
+
+		lookup = rcdev->lookup;
+		for (index = 0; lookup->dev; index++, lookup++) {
+			if (strcmp(dev_id, lookup->dev))
+				continue;
+
+			if ((!reset_id && !lookup->reset_id) ||
+			    !strcmp(reset_id, lookup->reset_id)) {
+				rstc = __reset_control_get_internal(rcdev,
+							lookup->id, shared);
+				break;
+			}
+		}
+	}
+
+	mutex_unlock(&reset_list_mutex);
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
@@ -500,7 +538,7 @@ struct reset_control *__reset_control_get(struct device *dev, const char *id,
 		return __of_reset_control_get(dev->of_node, id, index, shared,
 					      optional);
 
-	return optional ? NULL : ERR_PTR(-EINVAL);
+	return __reset_control_get_from_lookup(dev, id, shared, optional);
 }
 EXPORT_SYMBOL_GPL(__reset_control_get);
 
diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index adb88f8cefbc..345fd9a760f7 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -22,6 +22,20 @@ struct reset_control_ops {
 	int (*status)(struct reset_controller_dev *rcdev, unsigned long id);
 };
 
+/**
+ * struct reset_lookup - a single entry in a reset lookup table
+ *
+ * @dev: name of the device associated with this reset
+ * @reset_id: additional reset identifier (if the device uses multiple
+ *            reset lines)
+ * @id: ID of the reset controller in the reset controller device
+ */
+struct reset_lookup {
+	const char *dev;
+	const char *reset_id;
+	unsigned long id;
+};
+
 struct module;
 struct device_node;
 struct of_phandle_args;
@@ -34,6 +48,8 @@ struct of_phandle_args;
  * @list: internal list of reset controller devices
  * @reset_control_head: head of internal list of requested reset controls
  * @of_node: corresponding device tree node as phandle target
+ * @lookup: array of lookup entries associated with this request controller,
+ *          must end with a zeroed sentinel entry
  * @of_reset_n_cells: number of cells in reset line specifiers
  * @of_xlate: translation function to translate from specifier as found in the
  *            device tree to id as given to the reset control ops
@@ -45,6 +61,7 @@ struct reset_controller_dev {
 	struct list_head list;
 	struct list_head reset_control_head;
 	struct device_node *of_node;
+	const struct reset_lookup *lookup;
 	int of_reset_n_cells;
 	int (*of_xlate)(struct reset_controller_dev *rcdev,
 			const struct of_phandle_args *reset_spec);
-- 
2.16.1
