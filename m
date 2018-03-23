Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbeCWJil (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:38:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55089 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751861AbeCWJgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:36:17 -0400
X-Google-Smtp-Source: AG47ELvljEfaunVqgoY9OiK9p0haQ8aiRvH84WmbF3fSqCG/4VyvNWA3g7el8StSbPNq7iCr3N39yg==
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
Subject: [PATCH v2 1/8] reset: modify the way reset lookup works for board files
Date: Fri, 23 Mar 2018 10:36:02 +0100
Message-Id: <20180323093609.24576-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180323093609.24576-1-brgl@bgdev.pl>
References: <20180323093609.24576-1-brgl@bgdev.pl>
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
 drivers/reset/core.c             | 33 +++++++++++++++++++++++++++++----
 include/linux/reset-controller.h |  8 +++++---
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 06fa4907afc4..f37048e55336 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -153,11 +153,11 @@ EXPORT_SYMBOL_GPL(devm_reset_controller_register);
 
 /**
  * reset_controller_add_lookup - register a set of lookup entries
- * @rcdev: initialized reset controller device owning the reset line
+ * @provider: name of the reset controller provider
  * @lookup: array of reset lookup entries
  * @num_entries: number of entries in the lookup array
  */
-void reset_controller_add_lookup(struct reset_controller_dev *rcdev,
+void reset_controller_add_lookup(const char *provider,
 				 struct reset_control_lookup *lookup,
 				 unsigned int num_entries)
 {
@@ -174,7 +174,7 @@ void reset_controller_add_lookup(struct reset_controller_dev *rcdev,
 			continue;
 		}
 
-		entry->rcdev = rcdev;
+		entry->provider = provider;
 		list_add_tail(&entry->list, &reset_lookup_list);
 	}
 	mutex_unlock(&reset_lookup_mutex);
@@ -526,11 +526,30 @@ struct reset_control *__of_reset_control_get(struct device_node *node,
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
 
@@ -547,7 +566,13 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 		    ((con_id && lookup->con_id) &&
 		     !strcmp(con_id, lookup->con_id))) {
 			mutex_lock(&reset_list_mutex);
-			rstc = __reset_control_get_internal(lookup->rcdev,
+			rcdev = __reset_controller_by_name(lookup->provider);
+			if (!rcdev) {
+				mutex_unlock(&reset_list_mutex);
+				continue;
+			}
+
+			rstc = __reset_control_get_internal(rcdev,
 							    lookup->index,
 							    shared);
 			mutex_unlock(&reset_list_mutex);
diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index 25698f6c1fae..1a6c25d825d3 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -30,14 +30,14 @@ struct of_phandle_args;
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
@@ -57,6 +57,7 @@ struct reset_control_lookup {
  * @owner: kernel module of the reset controller driver
  * @list: internal list of reset controller devices
  * @reset_control_head: head of internal list of requested reset controls
+ * @dev: corresponding driver model device struct
  * @of_node: corresponding device tree node as phandle target
  * @of_reset_n_cells: number of cells in reset line specifiers
  * @of_xlate: translation function to translate from specifier as found in the
@@ -68,6 +69,7 @@ struct reset_controller_dev {
 	struct module *owner;
 	struct list_head list;
 	struct list_head reset_control_head;
+	struct device *dev;
 	struct device_node *of_node;
 	int of_reset_n_cells;
 	int (*of_xlate)(struct reset_controller_dev *rcdev,
@@ -82,7 +84,7 @@ struct device;
 int devm_reset_controller_register(struct device *dev,
 				   struct reset_controller_dev *rcdev);
 
-void reset_controller_add_lookup(struct reset_controller_dev *rcdev,
+void reset_controller_add_lookup(const char *provider,
 				 struct reset_control_lookup *lookup,
 				 unsigned int num_entries);
 
-- 
2.16.1
