Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeEQQth (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 12:49:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52916 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752321AbeEQQl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 12:41:28 -0400
From: Mark Brown <broonie@kernel.org>
To: Maciej Purski <m.purski@samsung.com>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Change voltage setting path" to the regulator tree
In-Reply-To: 
Message-Id: <20180517164122.17A8B44007E@finisterre.ee.mobilebroadband>
Date: Thu, 17 May 2018 17:41:22 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Change voltage setting path

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

>From 456e7cdf3b1a14e2606b8b687385ab2e3f23a49a Mon Sep 17 00:00:00 2001
From: Maciej Purski <m.purski@samsung.com>
Date: Mon, 23 Apr 2018 16:33:42 +0200
Subject: [PATCH] regulator: core: Change voltage setting path

On Odroid XU3/4 and other Exynos5422 based boards there is a case, that
different devices on the board are supplied by different regulators
with non-fixed voltages. If one of these devices temporarily requires
higher voltage, there might occur a situation that the spread between
two devices' voltages is so high, that there is a risk of changing
'high' and 'low' states on the interconnection between devices powered
by those regulators.

Uncoupled regulators should be a special case of coupled regulators, so
they should share a common voltage setting path. When enabling,
disabling or setting voltage of a coupled regulator, all coupled
regulators should be locked. Regulator's supplies should be locked, when
setting voltage of a single regulator. Enabling a coupled regulator or
setting its voltage should not be possible if some of its coupled
regulators, has not been registered.

Add function for locking coupled regulators and supplies. Extract
a new function regulator_set_voltage_rdev() from
regulator_set_voltage_unlocked(), which is called when setting
voltage of a single regulator.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 159 ++++++++++++++++++++++++++-------------
 1 file changed, 107 insertions(+), 52 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 225eaca24921..ac97e21bff10 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -107,6 +107,9 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				     int min_uV, int max_uV);
 static int regulator_balance_voltage(struct regulator_dev *rdev,
 				     suspend_state_t state);
+static int regulator_set_voltage_rdev(struct regulator_dev *rdev,
+				      int min_uV, int max_uV,
+				      suspend_state_t state);
 static struct regulator *create_regulator(struct regulator_dev *rdev,
 					  struct device *dev,
 					  const char *supply_name);
@@ -198,37 +201,66 @@ static void regulator_unlock(struct regulator_dev *rdev)
 	}
 }
 
-/**
- * regulator_lock_supply - lock a regulator and its supplies
- * @rdev:         regulator source
- */
-static void regulator_lock_supply(struct regulator_dev *rdev)
+static int regulator_lock_recursive(struct regulator_dev *rdev,
+				    unsigned int subclass)
 {
+	struct regulator_dev *c_rdev;
 	int i;
 
-	for (i = 0; rdev; rdev = rdev_get_supply(rdev), i++)
-		regulator_lock_nested(rdev, i);
+	for (i = 0; i < rdev->coupling_desc.n_coupled; i++) {
+		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
+
+		if (!c_rdev)
+			continue;
+
+		regulator_lock_nested(c_rdev, subclass++);
+
+		if (c_rdev->supply)
+			subclass =
+				regulator_lock_recursive(c_rdev->supply->rdev,
+							 subclass);
+	}
+
+	return subclass;
 }
 
 /**
- * regulator_unlock_supply - unlock a regulator and its supplies
- * @rdev:         regulator source
+ * regulator_unlock_dependent - unlock regulator's suppliers and coupled
+ *				regulators
+ * @rdev:			regulator source
+ *
+ * Unlock all regulators related with rdev by coupling or suppling.
  */
-static void regulator_unlock_supply(struct regulator_dev *rdev)
+static void regulator_unlock_dependent(struct regulator_dev *rdev)
 {
-	struct regulator *supply;
+	struct regulator_dev *c_rdev;
+	int i;
 
-	while (1) {
-		regulator_unlock(rdev);
-		supply = rdev->supply;
+	for (i = 0; i < rdev->coupling_desc.n_coupled; i++) {
+		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
 
-		if (!rdev->supply)
-			return;
+		if (!c_rdev)
+			continue;
+
+		regulator_unlock(c_rdev);
 
-		rdev = supply->rdev;
+		if (c_rdev->supply)
+			regulator_unlock_dependent(c_rdev->supply->rdev);
 	}
 }
 
+/**
+ * regulator_lock_dependent - lock regulator's suppliers and coupled regulators
+ * @rdev:			regulator source
+ *
+ * This function as a wrapper on regulator_lock_recursive(), which locks
+ * all regulators related with rdev by coupling or suppling.
+ */
+static inline void regulator_lock_dependent(struct regulator_dev *rdev)
+{
+	regulator_lock_recursive(rdev, 0);
+}
+
 /**
  * of_get_regulator - get a regulator device node based on supply name
  * @dev: Device pointer for the consumer (of regulator) device
@@ -2261,6 +2293,11 @@ int regulator_enable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
+	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
+		rdev_err(rdev, "not all coupled regulators registered\n");
+		return -EPERM;
+	}
+
 	if (regulator->always_on)
 		return 0;
 
@@ -2270,9 +2307,12 @@ int regulator_enable(struct regulator *regulator)
 			return ret;
 	}
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock_dependent(rdev);
 	ret = _regulator_enable(rdev);
-	mutex_unlock(&rdev->mutex);
+	/* balance only if there are regulators coupled */
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+	regulator_unlock_dependent(rdev);
 
 	if (ret != 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2378,9 +2418,11 @@ int regulator_disable(struct regulator *regulator)
 	if (regulator->always_on)
 		return 0;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock_dependent(rdev);
 	ret = _regulator_disable(rdev);
-	mutex_unlock(&rdev->mutex);
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+	regulator_unlock_dependent(rdev);
 
 	if (ret == 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2429,10 +2471,12 @@ int regulator_force_disable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock_dependent(rdev);
 	regulator->uA_load = 0;
 	ret = _regulator_force_disable(regulator->rdev);
-	mutex_unlock(&rdev->mutex);
+	if (rdev->coupling_desc.n_coupled > 1)
+		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+	regulator_unlock_dependent(rdev);
 
 	if (rdev->supply)
 		while (rdev->open_count--)
@@ -2580,9 +2624,9 @@ int regulator_is_enabled(struct regulator *regulator)
 	if (regulator->always_on)
 		return 1;
 
-	mutex_lock(&regulator->rdev->mutex);
+	regulator_lock_dependent(regulator->rdev);
 	ret = _regulator_is_enabled(regulator->rdev);
-	mutex_unlock(&regulator->rdev->mutex);
+	regulator_unlock_dependent(regulator->rdev);
 
 	return ret;
 }
@@ -2991,8 +3035,12 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	int ret = 0;
 	int old_min_uV, old_max_uV;
 	int current_uV;
-	int best_supply_uV = 0;
-	int supply_change_uV = 0;
+
+	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
+		rdev_err(rdev, "not all coupled regulators registered\n");
+		ret = -EPERM;
+		goto out;
+	}
 
 	/* If we're setting the same range as last time the change
 	 * should be a noop (some cpufreq implementations use the same
@@ -3036,6 +3084,27 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	if (ret < 0)
 		goto out2;
 
+	/* for not coupled regulators this will just set the voltage */
+	ret = regulator_balance_voltage(rdev, state);
+	if (ret < 0)
+		goto out2;
+
+out:
+	return 0;
+out2:
+	voltage->min_uV = old_min_uV;
+	voltage->max_uV = old_max_uV;
+
+	return ret;
+}
+
+static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
+				      int max_uV, suspend_state_t state)
+{
+	int best_supply_uV = 0;
+	int supply_change_uV = 0;
+	int ret;
+
 	if (rdev->supply &&
 	    regulator_ops_is_valid(rdev->supply->rdev,
 				   REGULATOR_CHANGE_VOLTAGE) &&
@@ -3047,13 +3116,13 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		selector = regulator_map_voltage(rdev, min_uV, max_uV);
 		if (selector < 0) {
 			ret = selector;
-			goto out2;
+			goto out;
 		}
 
 		best_supply_uV = _regulator_list_voltage(rdev, selector, 0);
 		if (best_supply_uV < 0) {
 			ret = best_supply_uV;
-			goto out2;
+			goto out;
 		}
 
 		best_supply_uV += rdev->desc->min_dropout_uV;
@@ -3061,7 +3130,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		current_supply_uV = _regulator_get_voltage(rdev->supply->rdev);
 		if (current_supply_uV < 0) {
 			ret = current_supply_uV;
-			goto out2;
+			goto out;
 		}
 
 		supply_change_uV = best_supply_uV - current_supply_uV;
@@ -3073,7 +3142,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		if (ret) {
 			dev_err(&rdev->dev, "Failed to increase supply voltage: %d\n",
 					ret);
-			goto out2;
+			goto out;
 		}
 	}
 
@@ -3083,7 +3152,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		ret = _regulator_do_set_suspend_voltage(rdev, min_uV,
 							max_uV, state);
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	if (supply_change_uV < 0) {
 		ret = regulator_set_voltage_unlocked(rdev->supply,
@@ -3096,11 +3165,6 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	}
 
 out:
-	return ret;
-out2:
-	voltage->min_uV = old_min_uV;
-	voltage->max_uV = old_max_uV;
-
 	return ret;
 }
 
@@ -3274,17 +3338,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 			goto out;
 		}
 
-		/*
-		 * Lock just the supply regulators, as the regulator itself
-		 * is already locked by regulator_lock_coupled().
-		 */
-		if (best_rdev->supply)
-			regulator_lock_supply(best_rdev->supply->rdev);
-
 		ret = regulator_set_voltage_rdev(best_rdev, best_uV,
 						 best_uV, state);
-		if (best_rdev->supply)
-			regulator_unlock_supply(best_rdev->supply->rdev);
 
 		if (ret < 0)
 			goto out;
@@ -3316,12 +3371,12 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 {
 	int ret = 0;
 
-	regulator_lock_supply(regulator->rdev);
+	regulator_lock_dependent(regulator->rdev);
 
 	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV,
 					     PM_SUSPEND_ON);
 
-	regulator_unlock_supply(regulator->rdev);
+	regulator_unlock_dependent(regulator->rdev);
 
 	return ret;
 }
@@ -3399,12 +3454,12 @@ int regulator_set_suspend_voltage(struct regulator *regulator, int min_uV,
 	if (regulator_check_states(state) || state == PM_SUSPEND_ON)
 		return -EINVAL;
 
-	regulator_lock_supply(regulator->rdev);
+	regulator_lock_dependent(regulator->rdev);
 
 	ret = _regulator_set_suspend_voltage(regulator, min_uV,
 					     max_uV, state);
 
-	regulator_unlock_supply(regulator->rdev);
+	regulator_unlock_dependent(regulator->rdev);
 
 	return ret;
 }
@@ -3596,11 +3651,11 @@ int regulator_get_voltage(struct regulator *regulator)
 {
 	int ret;
 
-	regulator_lock_supply(regulator->rdev);
+	regulator_lock_dependent(regulator->rdev);
 
 	ret = _regulator_get_voltage(regulator->rdev);
 
-	regulator_unlock_supply(regulator->rdev);
+	regulator_unlock_dependent(regulator->rdev);
 
 	return ret;
 }
-- 
2.17.0
