Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427962AbeCBM4B (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 07:56:01 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57260 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423162AbeCBMz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 07:55:27 -0500
From: Mark Brown <broonie@kernel.org>
To: Maciej Purski <m.purski@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Parse coupled regulators properties" to the regulator tree
In-Reply-To: 
Message-Id: <E1erkDc-0004Xj-5f@debutante>
Date: Fri, 02 Mar 2018 12:55:24 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Parse coupled regulators properties

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0c551039dddd5bac73ec15107850afff3cf2dbdc Mon Sep 17 00:00:00 2001
From: Maciej Purski <m.purski@samsung.com>
Date: Fri, 2 Mar 2018 09:42:46 +0100
Subject: [PATCH] regulator: core: Parse coupled regulators properties

On Odroid XU3/4 and other Exynos5422 based boards there is a case, that
different devices on the board are supplied by different regulators
with non-fixed voltages. If one of these devices temporarily requires
higher voltage, there might occur a situation that the spread between
devices' voltages is so high, that there is a risk of changing
'high' and 'low' states on the interconnection between devices powered
by those regulators.

Add new structure "coupling_desc" to regulator_dev, which contains
pointers to all coupled regulators including the owner of the structure,
number of coupled regulators and counter of currently resolved
regulators.

Add of_functions to parse all data needed in regulator coupling.
Provide method to check DTS data consistency. Check if each coupled
regulator's max_spread is equal and if their lists of regulators match.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/internal.h      |   6 ++
 drivers/regulator/of_regulator.c  | 149 ++++++++++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h  |  18 +++++
 include/linux/regulator/machine.h |   4 +
 4 files changed, 177 insertions(+)

diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index abfd56e8c78a..f253a47b9a99 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -84,4 +84,10 @@ enum regulator_get_type {
 struct regulator *_regulator_get(struct device *dev, const char *id,
 				 enum regulator_get_type get_type);
 
+struct regulator_dev *of_parse_coupled_regulator(struct regulator_dev *rdev,
+						 int index);
+
+int of_get_n_coupled(struct regulator_dev *rdev);
+
+bool of_check_coupling_data(struct regulator_dev *rdev);
 #endif
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 092ed6efb3ec..7df3a46908f1 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -138,6 +138,10 @@ static void of_get_regulation_constraints(struct device_node *np,
 	if (!of_property_read_u32(np, "regulator-system-load", &pval))
 		constraints->system_load = pval;
 
+	if (!of_property_read_u32(np, "regulator-coupled-max-spread",
+				  &pval))
+		constraints->max_spread = pval;
+
 	constraints->over_current_protection = of_property_read_bool(np,
 					"regulator-over-current-protection");
 
@@ -406,3 +410,148 @@ struct regulator_dev *of_find_regulator_by_node(struct device_node *np)
 
 	return dev ? dev_to_rdev(dev) : NULL;
 }
+
+/*
+ * Returns number of regulators coupled with rdev.
+ */
+int of_get_n_coupled(struct regulator_dev *rdev)
+{
+	struct device_node *node = rdev->dev.of_node;
+	int n_phandles;
+
+	n_phandles = of_count_phandle_with_args(node,
+						"regulator-coupled-with", 0);
+
+	return (n_phandles > 0) ? n_phandles : 0;
+}
+
+/* Looks for "to_find" device_node in src's "regulator-coupled-with" property */
+static bool of_coupling_find_node(struct device_node *src,
+				  struct device_node *to_find)
+{
+	int n_phandles, i;
+	bool found = false;
+
+	n_phandles = of_count_phandle_with_args(src,
+						"regulator-coupled-with", 0);
+
+	for (i = 0; i < n_phandles; i++) {
+		struct device_node *tmp = of_parse_phandle(src,
+					   "regulator-coupled-with", i);
+
+		if (!tmp)
+			break;
+
+		/* found */
+		if (tmp == to_find)
+			found = true;
+
+		of_node_put(tmp);
+
+		if (found)
+			break;
+	}
+
+	return found;
+}
+
+/**
+ * of_check_coupling_data - Parse rdev's coupling properties and check data
+ *			    consistency
+ * @rdev - pointer to regulator_dev whose data is checked
+ *
+ * Function checks if all the following conditions are met:
+ * - rdev's max_spread is greater than 0
+ * - all coupled regulators have the same max_spread
+ * - all coupled regulators have the same number of regulator_dev phandles
+ * - all regulators are linked to each other
+ *
+ * Returns true if all conditions are met.
+ */
+bool of_check_coupling_data(struct regulator_dev *rdev)
+{
+	int max_spread = rdev->constraints->max_spread;
+	struct device_node *node = rdev->dev.of_node;
+	int n_phandles = of_get_n_coupled(rdev);
+	struct device_node *c_node;
+	int i;
+	bool ret = true;
+
+	if (max_spread <= 0) {
+		dev_err(&rdev->dev, "max_spread value invalid\n");
+		return false;
+	}
+
+	/* iterate over rdev's phandles */
+	for (i = 0; i < n_phandles; i++) {
+		int c_max_spread, c_n_phandles;
+
+		c_node = of_parse_phandle(node,
+					  "regulator-coupled-with", i);
+
+		if (!c_node)
+			ret = false;
+
+		c_n_phandles = of_count_phandle_with_args(c_node,
+							  "regulator-coupled-with",
+							  0);
+
+		if (c_n_phandles != n_phandles) {
+			dev_err(&rdev->dev, "number of couped reg phandles mismatch\n");
+			ret = false;
+			goto clean;
+		}
+
+		if (of_property_read_u32(c_node, "regulator-coupled-max-spread",
+					 &c_max_spread)) {
+			ret = false;
+			goto clean;
+		}
+
+		if (c_max_spread != max_spread) {
+			dev_err(&rdev->dev,
+				"coupled regulators max_spread mismatch\n");
+			ret = false;
+			goto clean;
+		}
+
+		if (!of_coupling_find_node(c_node, node)) {
+			dev_err(&rdev->dev, "missing 2-way linking for coupled regulators\n");
+			ret = false;
+		}
+
+clean:
+		of_node_put(c_node);
+		if (!ret)
+			break;
+	}
+
+	return ret;
+}
+
+/**
+ * of_parse_coupled regulator - Get regulator_dev pointer from rdev's property
+ * @rdev: Pointer to regulator_dev, whose DTS is used as a source to parse
+ *	  "regulator-coupled-with" property
+ * @index: Index in phandles array
+ *
+ * Returns the regulator_dev pointer parsed from DTS. If it has not been yet
+ * registered, returns NULL
+ */
+struct regulator_dev *of_parse_coupled_regulator(struct regulator_dev *rdev,
+						 int index)
+{
+	struct device_node *node = rdev->dev.of_node;
+	struct device_node *c_node;
+	struct regulator_dev *c_rdev;
+
+	c_node = of_parse_phandle(node, "regulator-coupled-with", index);
+	if (!c_node)
+		return NULL;
+
+	c_rdev = of_find_regulator_by_node(c_node);
+
+	of_node_put(c_node);
+
+	return c_rdev;
+}
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4c00486b7a78..85452bb81a44 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -15,6 +15,8 @@
 #ifndef __LINUX_REGULATOR_DRIVER_H_
 #define __LINUX_REGULATOR_DRIVER_H_
 
+#define MAX_COUPLED		10
+
 #include <linux/device.h>
 #include <linux/notifier.h>
 #include <linux/regulator/consumer.h>
@@ -403,6 +405,20 @@ struct regulator_config {
 	unsigned int ena_gpio_flags;
 };
 
+/*
+ * struct coupling_desc
+ *
+ * Describes coupling of regulators. Each regulator should have
+ * at least a pointer to itself in coupled_rdevs array.
+ * When a new coupled regulator is resolved, n_resolved is
+ * incremented.
+ */
+struct coupling_desc {
+	struct regulator_dev *coupled_rdevs[MAX_COUPLED];
+	int n_resolved;
+	int n_coupled;
+};
+
 /*
  * struct regulator_dev
  *
@@ -426,6 +442,8 @@ struct regulator_dev {
 	/* lists we own */
 	struct list_head consumer_list; /* consumers we supply */
 
+	struct coupling_desc coupling_desc;
+
 	struct blocking_notifier_head notifier;
 	struct mutex mutex; /* consumer lock */
 	struct module *owner;
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/machine.h
index 93a04893c739..3468703d663a 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -103,6 +103,7 @@ struct regulator_state {
  * @ilim_uA: Maximum input current.
  * @system_load: Load that isn't captured by any consumer requests.
  *
+ * @max_spread: Max possible spread between coupled regulators
  * @valid_modes_mask: Mask of modes which may be configured by consumers.
  * @valid_ops_mask: Operations which may be performed by consumers.
  *
@@ -154,6 +155,9 @@ struct regulation_constraints {
 
 	int system_load;
 
+	/* used for coupled regulators */
+	int max_spread;
+
 	/* valid regulator operating modes for this machine */
 	unsigned int valid_modes_mask;
 
-- 
2.16.2
