Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965497AbeBMSjx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:39:53 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39031 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965344AbeBMSjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:39:51 -0500
X-Google-Smtp-Source: AH8x227xl4GwMFYeYEecLBElhKDXIEy5jcKngbdYReQAYaKz30KKn2tCRlfSJ+cTcdIrPr3OCzjUvg==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        David Lechner <david@lechnology.com>
Subject: [PATCH v2] reset: add support for non-DT systems
Date: Tue, 13 Feb 2018 19:39:46 +0100
Message-Id: <20180213183946.1662-1-brgl@bgdev.pl>
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
entry contains the device name and an additional, optional identifier
string.

Drivers can register a set of reset lines using this lookup table and
concerned devices can access them using the regular reset_control API.

This new function is only called as a fallback in case the of_node
field is NULL and doesn't change anything for current users.

Tested with a dummy reset driver with several lookup entries.

An example lookup table can look like this:

static const struct reset_lookup foobar_reset_lookup[] = {
	[FOO_RESET] = { .dev = "foo", .id = "foo_id" },
	[BAR_RESET] = { .dev = "bar", .id = NULL },
	{ }
};

where FOO_RESET and BAR_RESET will correspond with the id parameters
of reset callbacks.

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

 drivers/reset/core.c             | 40 +++++++++++++++++++++++++++++++++++++++-
 include/linux/reset-controller.h | 14 ++++++++++++++
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index da4292e9de97..b104a0c5c511 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -493,6 +493,44 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(__of_reset_control_get);
 
+static struct reset_control *
+__reset_control_get_from_lookup(struct device *dev, const char *id,
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
+			if ((!id && !lookup->id) ||
+			    (id && lookup->id && !strcmp(id, lookup->id))) {
+				rstc = __reset_control_get_internal(rcdev,
+								index, shared);
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
index adb88f8cefbc..4cc52b4a4d27 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -22,6 +22,17 @@ struct reset_control_ops {
 	int (*status)(struct reset_controller_dev *rcdev, unsigned long id);
 };
 
+/**
+ * struct reset_lookup - a single entry in a reset lookup table
+ *
+ * @dev: name of the device associated with this reset
+ * @id: additional reset identifier (if the device uses multiple reset lines)
+ */
+struct reset_lookup {
+	const char *dev;
+	const char *id;
+};
+
 struct module;
 struct device_node;
 struct of_phandle_args;
@@ -34,6 +45,8 @@ struct of_phandle_args;
  * @list: internal list of reset controller devices
  * @reset_control_head: head of internal list of requested reset controls
  * @of_node: corresponding device tree node as phandle target
+ * @lookup: array of lookup entries associated with this request controller,
+ *          must end with a zeroed sentinel entry
  * @of_reset_n_cells: number of cells in reset line specifiers
  * @of_xlate: translation function to translate from specifier as found in the
  *            device tree to id as given to the reset control ops
@@ -45,6 +58,7 @@ struct reset_controller_dev {
 	struct list_head list;
 	struct list_head reset_control_head;
 	struct device_node *of_node;
+	const struct reset_lookup *lookup;
 	int of_reset_n_cells;
 	int (*of_xlate)(struct reset_controller_dev *rcdev,
 			const struct of_phandle_args *reset_spec);
-- 
2.16.1
