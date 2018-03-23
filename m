Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754405AbeCWLtS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 07:49:18 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53740 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754493AbeCWLrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 07:47:16 -0400
X-Google-Smtp-Source: AG47ELv2pJaByClODsiVs7TXy0coBXhDuvHkc2AaJFd6Qnetv73SwXcHP5EP4o9Wa9Ol/+B0yFO3fQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 1/8] reset: modify the way reset lookup works for board files
Date: Fri, 23 Mar 2018 12:47:02 +0100
Message-Id: <20180323114709.20330-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180323114709.20330-1-brgl@bgdev.pl>
References: <20180323114709.20330-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Commit 7af1bb19f1d7 ("reset: add support for non-DT systems")
introduced reset control lookup mechanism for boards that still use
board files.

The routine used to register lookup entries takes the corresponding
reset_controlled_dev structure as argument.

It's been determined however that for the first user of this new
interface - davinci psc driver - it will be easier to register the
lookup entries using the reset controller device name.

This patch changes the way lookup entries are added.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/reset/core.c             | 38 +++++++++++++++++++++++++++++++-------
 include/linux/reset-controller.h | 12 +++++++-----
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 06fa4907afc4..f4a29c046995 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -153,12 +153,10 @@ EXPORT_SYMBOL_GPL(devm_reset_controller_register);
 
 /**
  * reset_controller_add_lookup - register a set of lookup entries
- * @rcdev: initialized reset controller device owning the reset line
  * @lookup: array of reset lookup entries
  * @num_entries: number of entries in the lookup array
  */
-void reset_controller_add_lookup(struct reset_controller_dev *rcdev,
-				 struct reset_control_lookup *lookup,
+void reset_controller_add_lookup(struct reset_control_lookup *lookup,
 				 unsigned int num_entries)
 {
 	struct reset_control_lookup *entry;
@@ -168,13 +166,12 @@ void reset_controller_add_lookup(struct reset_controller_dev *rcdev,
 	for (i = 0; i < num_entries; i++) {
 		entry = &lookup[i];
 
-		if (!entry->dev_id) {
-			pr_warn("%s(): reset lookup entry has no dev_id, skipping\n",
+		if (!entry->dev_id || !entry->provider) {
+			pr_warn("%s(): reset lookup entry badly specified, skipping\n",
 				__func__);
 			continue;
 		}
 
-		entry->rcdev = rcdev;
 		list_add_tail(&entry->list, &reset_lookup_list);
 	}
 	mutex_unlock(&reset_lookup_mutex);
@@ -526,11 +523,30 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(__of_reset_control_get);
 
+static struct reset_controller_dev *
+__reset_controller_by_name(const char *name)
+{
+	struct reset_controller_dev *rcdev;
+
+	lockdep_assert_held(&reset_list_mutex);
+
+	list_for_each_entry(rcdev, &reset_controller_list, list) {
+		if (!rcdev->dev)
+			continue;
+
+		if (!strcmp(name, dev_name(rcdev->dev)))
+			return rcdev;
+	}
+
+	return NULL;
+}
+
 static struct reset_control *
 __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 				bool shared, bool optional)
 {
 	const struct reset_control_lookup *lookup;
+	struct reset_controller_dev *rcdev;
 	const char *dev_id = dev_name(dev);
 	struct reset_control *rstc = NULL;
 
@@ -547,7 +563,15 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 		    ((con_id && lookup->con_id) &&
 		     !strcmp(con_id, lookup->con_id))) {
 			mutex_lock(&reset_list_mutex);
-			rstc = __reset_control_get_internal(lookup->rcdev,
+			rcdev = __reset_controller_by_name(lookup->provider);
+			if (!rcdev) {
+				mutex_unlock(&reset_list_mutex);
+				mutex_unlock(&reset_lookup_mutex);
+				/* Reset provider may not be ready yet. */
+				return -EPROBE_DEFER;
+			}
+
+			rstc = __reset_control_get_internal(rcdev,
 							    lookup->index,
 							    shared);
 			mutex_unlock(&reset_list_mutex);
diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index 25698f6c1fae..c870acaa2e07 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -30,21 +30,22 @@ struct of_phandle_args;
  * struct reset_control_lookup - represents a single lookup entry
  *
  * @list: internal list of all reset lookup entries
- * @rcdev: reset controller device controlling this reset line
+ * @provider: name of the reset controller device controlling this reset line
  * @index: ID of the reset controller in the reset controller device
  * @dev_id: name of the device associated with this reset line
  * @con_id name of the reset line (can be NULL)
  */
 struct reset_control_lookup {
 	struct list_head list;
-	struct reset_controller_dev *rcdev;
+	const char *provider;
 	unsigned int index;
 	const char *dev_id;
 	const char *con_id;
 };
 
-#define RESET_LOOKUP(_dev_id, _con_id, _index)				\
+#define RESET_LOOKUP(_provider, _dev_id, _con_id, _index)		\
 	{								\
+		.provider = _provider,					\
 		.dev_id = _dev_id,					\
 		.con_id = _con_id,					\
 		.index = _index,					\
@@ -57,6 +58,7 @@ struct reset_control_lookup {
  * @owner: kernel module of the reset controller driver
  * @list: internal list of reset controller devices
  * @reset_control_head: head of internal list of requested reset controls
+ * @dev: corresponding driver model device struct
  * @of_node: corresponding device tree node as phandle target
  * @of_reset_n_cells: number of cells in reset line specifiers
  * @of_xlate: translation function to translate from specifier as found in the
@@ -68,6 +70,7 @@ struct reset_controller_dev {
 	struct module *owner;
 	struct list_head list;
 	struct list_head reset_control_head;
+	struct device *dev;
 	struct device_node *of_node;
 	int of_reset_n_cells;
 	int (*of_xlate)(struct reset_controller_dev *rcdev,
@@ -82,8 +85,7 @@ struct device;
 int devm_reset_controller_register(struct device *dev,
 				   struct reset_controller_dev *rcdev);
 
-void reset_controller_add_lookup(struct reset_controller_dev *rcdev,
-				 struct reset_control_lookup *lookup,
+void reset_controller_add_lookup(struct reset_control_lookup *lookup,
 				 unsigned int num_entries);
 
 #endif
-- 
2.16.1
