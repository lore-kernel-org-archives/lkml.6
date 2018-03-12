Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932540AbeCLQ3T (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:29:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45178 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932494AbeCLQ3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:29:08 -0400
From: Mark Brown <broonie@kernel.org>
To: Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regulator: make regulator voltage be an array to support more states" to the regulator tree
In-Reply-To: <20171215151114.CFA5344006B@finisterre.ee.mobilebroadband>
Message-Id: <20180312162904.B4AF0440079@finisterre.ee.mobilebroadband>
Date: Mon, 12 Mar 2018 16:29:04 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: make regulator voltage be an array to support more states

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

>From 56a24f8b97fc71889a196eb5295d7f5f83618f86 Mon Sep 17 00:00:00 2001
From: Chunyan Zhang <zhang.chunyan@linaro.org>
Date: Fri, 15 Dec 2017 21:43:46 +0800
Subject: [PATCH] regulator: make regulator voltage be an array to support more
 states

Some regulator consumers would like to make the regulator device
keeping a voltage range output when the system entering into
suspend states.

Making regulator voltage be an array can allow consumers to set voltage
for normal state as well as for suspend states through the same code.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c     | 63 ++++++++++++++++++++++++--------------------
 drivers/regulator/internal.h | 18 +++++++++++--
 2 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index b64b7916507f..97bc9f7adf2f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -240,22 +240,25 @@ static int regulator_check_voltage(struct regulator_dev *rdev,
  * regulator consumers
  */
 static int regulator_check_consumers(struct regulator_dev *rdev,
-				     int *min_uV, int *max_uV)
+				     int *min_uV, int *max_uV,
+				     suspend_state_t state)
 {
 	struct regulator *regulator;
+	struct regulator_voltage *voltage;
 
 	list_for_each_entry(regulator, &rdev->consumer_list, list) {
+		voltage = &regulator->voltage[state];
 		/*
 		 * Assume consumers that didn't say anything are OK
 		 * with anything in the constraint range.
 		 */
-		if (!regulator->min_uV && !regulator->max_uV)
+		if (!voltage->min_uV && !voltage->max_uV)
 			continue;
 
-		if (*max_uV > regulator->max_uV)
-			*max_uV = regulator->max_uV;
-		if (*min_uV < regulator->min_uV)
-			*min_uV = regulator->min_uV;
+		if (*max_uV > voltage->max_uV)
+			*max_uV = voltage->max_uV;
+		if (*min_uV < voltage->min_uV)
+			*min_uV = voltage->min_uV;
 	}
 
 	if (*min_uV > *max_uV) {
@@ -1356,9 +1359,9 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 		debugfs_create_u32("uA_load", 0444, regulator->debugfs,
 				   &regulator->uA_load);
 		debugfs_create_u32("min_uV", 0444, regulator->debugfs,
-				   &regulator->min_uV);
+				   &regulator->voltage[PM_SUSPEND_ON].min_uV);
 		debugfs_create_u32("max_uV", 0444, regulator->debugfs,
-				   &regulator->max_uV);
+				   &regulator->voltage[PM_SUSPEND_ON].max_uV);
 		debugfs_create_file("constraint_flags", 0444,
 				    regulator->debugfs, regulator,
 				    &constraint_flags_fops);
@@ -2898,9 +2901,11 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 }
 
 static int regulator_set_voltage_unlocked(struct regulator *regulator,
-					  int min_uV, int max_uV)
+					  int min_uV, int max_uV,
+					  suspend_state_t state)
 {
 	struct regulator_dev *rdev = regulator->rdev;
+	struct regulator_voltage *voltage = &regulator->voltage[state];
 	int ret = 0;
 	int old_min_uV, old_max_uV;
 	int current_uV;
@@ -2911,7 +2916,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	 * should be a noop (some cpufreq implementations use the same
 	 * voltage for multiple frequencies, for example).
 	 */
-	if (regulator->min_uV == min_uV && regulator->max_uV == max_uV)
+	if (voltage->min_uV == min_uV && voltage->max_uV == max_uV)
 		goto out;
 
 	/* If we're trying to set a range that overlaps the current voltage,
@@ -2921,8 +2926,8 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_VOLTAGE)) {
 		current_uV = _regulator_get_voltage(rdev);
 		if (min_uV <= current_uV && current_uV <= max_uV) {
-			regulator->min_uV = min_uV;
-			regulator->max_uV = max_uV;
+			voltage->min_uV = min_uV;
+			voltage->max_uV = max_uV;
 			goto out;
 		}
 	}
@@ -2940,12 +2945,12 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		goto out;
 
 	/* restore original values in case of error */
-	old_min_uV = regulator->min_uV;
-	old_max_uV = regulator->max_uV;
-	regulator->min_uV = min_uV;
-	regulator->max_uV = max_uV;
+	old_min_uV = voltage->min_uV;
+	old_max_uV = voltage->max_uV;
+	voltage->min_uV = min_uV;
+	voltage->max_uV = max_uV;
 
-	ret = regulator_check_consumers(rdev, &min_uV, &max_uV);
+	ret = regulator_check_consumers(rdev, &min_uV, &max_uV, state);
 	if (ret < 0)
 		goto out2;
 
@@ -2982,7 +2987,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 
 	if (supply_change_uV > 0) {
 		ret = regulator_set_voltage_unlocked(rdev->supply,
-				best_supply_uV, INT_MAX);
+				best_supply_uV, INT_MAX, state);
 		if (ret) {
 			dev_err(&rdev->dev, "Failed to increase supply voltage: %d\n",
 					ret);
@@ -2996,7 +3001,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 
 	if (supply_change_uV < 0) {
 		ret = regulator_set_voltage_unlocked(rdev->supply,
-				best_supply_uV, INT_MAX);
+				best_supply_uV, INT_MAX, state);
 		if (ret)
 			dev_warn(&rdev->dev, "Failed to decrease supply voltage: %d\n",
 					ret);
@@ -3007,8 +3012,8 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 out:
 	return ret;
 out2:
-	regulator->min_uV = old_min_uV;
-	regulator->max_uV = old_max_uV;
+	voltage->min_uV = old_min_uV;
+	voltage->max_uV = old_max_uV;
 
 	return ret;
 }
@@ -3037,7 +3042,8 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 
 	regulator_lock_supply(regulator->rdev);
 
-	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV);
+	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV,
+					     PM_SUSPEND_ON);
 
 	regulator_unlock_supply(regulator->rdev);
 
@@ -3138,6 +3144,7 @@ EXPORT_SYMBOL_GPL(regulator_set_voltage_time_sel);
 int regulator_sync_voltage(struct regulator *regulator)
 {
 	struct regulator_dev *rdev = regulator->rdev;
+	struct regulator_voltage *voltage = &regulator->voltage[PM_SUSPEND_ON];
 	int ret, min_uV, max_uV;
 
 	mutex_lock(&rdev->mutex);
@@ -3149,20 +3156,20 @@ int regulator_sync_voltage(struct regulator *regulator)
 	}
 
 	/* This is only going to work if we've had a voltage configured. */
-	if (!regulator->min_uV && !regulator->max_uV) {
+	if (!voltage->min_uV && !voltage->max_uV) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	min_uV = regulator->min_uV;
-	max_uV = regulator->max_uV;
+	min_uV = voltage->min_uV;
+	max_uV = voltage->max_uV;
 
 	/* This should be a paranoia check... */
 	ret = regulator_check_voltage(rdev, &min_uV, &max_uV);
 	if (ret < 0)
 		goto out;
 
-	ret = regulator_check_consumers(rdev, &min_uV, &max_uV);
+	ret = regulator_check_consumers(rdev, &min_uV, &max_uV, 0);
 	if (ret < 0)
 		goto out;
 
@@ -4424,8 +4431,8 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 		switch (rdev->desc->type) {
 		case REGULATOR_VOLTAGE:
 			seq_printf(s, "%37dmV %5dmV",
-				   consumer->min_uV / 1000,
-				   consumer->max_uV / 1000);
+				   consumer->voltage[PM_SUSPEND_ON].min_uV / 1000,
+				   consumer->voltage[PM_SUSPEND_ON].max_uV / 1000);
 			break;
 		case REGULATOR_CURRENT:
 			break;
diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index 66a8ea0c8386..aba8e4149838 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -16,10 +16,25 @@
 #ifndef __REGULATOR_INTERNAL_H
 #define __REGULATOR_INTERNAL_H
 
+#include <linux/suspend.h>
+
+#define REGULATOR_STATES_NUM	(PM_SUSPEND_MAX + 1)
+
+struct regulator_voltage {
+	int min_uV;
+	int max_uV;
+};
+
 /*
  * struct regulator
  *
  * One for each consumer device.
+ * @voltage - a voltage array for each state of runtime, i.e.:
+ *            PM_SUSPEND_ON
+ *            PM_SUSPEND_TO_IDLE
+ *            PM_SUSPEND_STANDBY
+ *            PM_SUSPEND_MEM
+ *            PM_SUSPEND_MAX
  */
 struct regulator {
 	struct device *dev;
@@ -27,8 +42,7 @@ struct regulator {
 	unsigned int always_on:1;
 	unsigned int bypass:1;
 	int uA_load;
-	int min_uV;
-	int max_uV;
+	struct regulator_voltage voltage[REGULATOR_STATES_NUM];
 	const char *supply_name;
 	struct device_attribute dev_attr;
 	struct regulator_dev *rdev;
-- 
2.16.2
