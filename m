Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753569AbeE3Ode (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 10:33:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42582 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752995AbeE3Od2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 10:33:28 -0400
From: Mark Brown <broonie@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: Revert coupled regulator support again" to the regulator tree
In-Reply-To: 
Message-Id: <E1fO2AE-0004WM-GF@debutante>
Date: Wed, 30 May 2018 15:33:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Revert coupled regulator support again

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

>From 38de19fa7159838fbe180e859cb46501d9fca4f4 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 May 2018 15:20:03 +0100
Subject: [PATCH] regulator: Revert coupled regulator support again

Revert the last two commits of the voltage coupling mechanism patch set:

456e7cdf3b1a14e2606b8 regulator: core: Change voltage setting path
696861761a58d8c93605b regulator: core: Add voltage balancing mechanism

as they broke boot on OMAP again.

Reported-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c | 329 +++++----------------------------------
 1 file changed, 41 insertions(+), 288 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ac97e21bff10..6ed568b96c0e 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -105,11 +105,6 @@ static int _notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data);
 static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				     int min_uV, int max_uV);
-static int regulator_balance_voltage(struct regulator_dev *rdev,
-				     suspend_state_t state);
-static int regulator_set_voltage_rdev(struct regulator_dev *rdev,
-				      int min_uV, int max_uV,
-				      suspend_state_t state);
 static struct regulator *create_regulator(struct regulator_dev *rdev,
 					  struct device *dev,
 					  const char *supply_name);
@@ -201,66 +196,37 @@ static void regulator_unlock(struct regulator_dev *rdev)
 	}
 }
 
-static int regulator_lock_recursive(struct regulator_dev *rdev,
-				    unsigned int subclass)
+/**
+ * regulator_lock_supply - lock a regulator and its supplies
+ * @rdev:         regulator source
+ */
+static void regulator_lock_supply(struct regulator_dev *rdev)
 {
-	struct regulator_dev *c_rdev;
 	int i;
 
-	for (i = 0; i < rdev->coupling_desc.n_coupled; i++) {
-		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
-
-		if (!c_rdev)
-			continue;
-
-		regulator_lock_nested(c_rdev, subclass++);
-
-		if (c_rdev->supply)
-			subclass =
-				regulator_lock_recursive(c_rdev->supply->rdev,
-							 subclass);
-	}
-
-	return subclass;
+	for (i = 0; rdev; rdev = rdev_get_supply(rdev), i++)
+		regulator_lock_nested(rdev, i);
 }
 
 /**
- * regulator_unlock_dependent - unlock regulator's suppliers and coupled
- *				regulators
- * @rdev:			regulator source
- *
- * Unlock all regulators related with rdev by coupling or suppling.
+ * regulator_unlock_supply - unlock a regulator and its supplies
+ * @rdev:         regulator source
  */
-static void regulator_unlock_dependent(struct regulator_dev *rdev)
+static void regulator_unlock_supply(struct regulator_dev *rdev)
 {
-	struct regulator_dev *c_rdev;
-	int i;
+	struct regulator *supply;
 
-	for (i = 0; i < rdev->coupling_desc.n_coupled; i++) {
-		c_rdev = rdev->coupling_desc.coupled_rdevs[i];
-
-		if (!c_rdev)
-			continue;
+	while (1) {
+		regulator_unlock(rdev);
+		supply = rdev->supply;
 
-		regulator_unlock(c_rdev);
+		if (!rdev->supply)
+			return;
 
-		if (c_rdev->supply)
-			regulator_unlock_dependent(c_rdev->supply->rdev);
+		rdev = supply->rdev;
 	}
 }
 
-/**
- * regulator_lock_dependent - lock regulator's suppliers and coupled regulators
- * @rdev:			regulator source
- *
- * This function as a wrapper on regulator_lock_recursive(), which locks
- * all regulators related with rdev by coupling or suppling.
- */
-static inline void regulator_lock_dependent(struct regulator_dev *rdev)
-{
-	regulator_lock_recursive(rdev, 0);
-}
-
 /**
  * of_get_regulator - get a regulator device node based on supply name
  * @dev: Device pointer for the consumer (of regulator) device
@@ -2293,11 +2259,6 @@ int regulator_enable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
-	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
-		rdev_err(rdev, "not all coupled regulators registered\n");
-		return -EPERM;
-	}
-
 	if (regulator->always_on)
 		return 0;
 
@@ -2307,12 +2268,9 @@ int regulator_enable(struct regulator *regulator)
 			return ret;
 	}
 
-	regulator_lock_dependent(rdev);
+	mutex_lock(&rdev->mutex);
 	ret = _regulator_enable(rdev);
-	/* balance only if there are regulators coupled */
-	if (rdev->coupling_desc.n_coupled > 1)
-		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
-	regulator_unlock_dependent(rdev);
+	mutex_unlock(&rdev->mutex);
 
 	if (ret != 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2418,11 +2376,9 @@ int regulator_disable(struct regulator *regulator)
 	if (regulator->always_on)
 		return 0;
 
-	regulator_lock_dependent(rdev);
+	mutex_lock(&rdev->mutex);
 	ret = _regulator_disable(rdev);
-	if (rdev->coupling_desc.n_coupled > 1)
-		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
-	regulator_unlock_dependent(rdev);
+	mutex_unlock(&rdev->mutex);
 
 	if (ret == 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2471,12 +2427,10 @@ int regulator_force_disable(struct regulator *regulator)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
 
-	regulator_lock_dependent(rdev);
+	mutex_lock(&rdev->mutex);
 	regulator->uA_load = 0;
 	ret = _regulator_force_disable(regulator->rdev);
-	if (rdev->coupling_desc.n_coupled > 1)
-		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
-	regulator_unlock_dependent(rdev);
+	mutex_unlock(&rdev->mutex);
 
 	if (rdev->supply)
 		while (rdev->open_count--)
@@ -2624,9 +2578,9 @@ int regulator_is_enabled(struct regulator *regulator)
 	if (regulator->always_on)
 		return 1;
 
-	regulator_lock_dependent(regulator->rdev);
+	mutex_lock(&regulator->rdev->mutex);
 	ret = _regulator_is_enabled(regulator->rdev);
-	regulator_unlock_dependent(regulator->rdev);
+	mutex_unlock(&regulator->rdev->mutex);
 
 	return ret;
 }
@@ -3035,12 +2989,8 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	int ret = 0;
 	int old_min_uV, old_max_uV;
 	int current_uV;
-
-	if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
-		rdev_err(rdev, "not all coupled regulators registered\n");
-		ret = -EPERM;
-		goto out;
-	}
+	int best_supply_uV = 0;
+	int supply_change_uV = 0;
 
 	/* If we're setting the same range as last time the change
 	 * should be a noop (some cpufreq implementations use the same
@@ -3084,27 +3034,6 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	if (ret < 0)
 		goto out2;
 
-	/* for not coupled regulators this will just set the voltage */
-	ret = regulator_balance_voltage(rdev, state);
-	if (ret < 0)
-		goto out2;
-
-out:
-	return 0;
-out2:
-	voltage->min_uV = old_min_uV;
-	voltage->max_uV = old_max_uV;
-
-	return ret;
-}
-
-static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
-				      int max_uV, suspend_state_t state)
-{
-	int best_supply_uV = 0;
-	int supply_change_uV = 0;
-	int ret;
-
 	if (rdev->supply &&
 	    regulator_ops_is_valid(rdev->supply->rdev,
 				   REGULATOR_CHANGE_VOLTAGE) &&
@@ -3116,13 +3045,13 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 		selector = regulator_map_voltage(rdev, min_uV, max_uV);
 		if (selector < 0) {
 			ret = selector;
-			goto out;
+			goto out2;
 		}
 
 		best_supply_uV = _regulator_list_voltage(rdev, selector, 0);
 		if (best_supply_uV < 0) {
 			ret = best_supply_uV;
-			goto out;
+			goto out2;
 		}
 
 		best_supply_uV += rdev->desc->min_dropout_uV;
@@ -3130,7 +3059,7 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 		current_supply_uV = _regulator_get_voltage(rdev->supply->rdev);
 		if (current_supply_uV < 0) {
 			ret = current_supply_uV;
-			goto out;
+			goto out2;
 		}
 
 		supply_change_uV = best_supply_uV - current_supply_uV;
@@ -3142,7 +3071,7 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 		if (ret) {
 			dev_err(&rdev->dev, "Failed to increase supply voltage: %d\n",
 					ret);
-			goto out;
+			goto out2;
 		}
 	}
 
@@ -3152,7 +3081,7 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 		ret = _regulator_do_set_suspend_voltage(rdev, min_uV,
 							max_uV, state);
 	if (ret < 0)
-		goto out;
+		goto out2;
 
 	if (supply_change_uV < 0) {
 		ret = regulator_set_voltage_unlocked(rdev->supply,
@@ -3166,186 +3095,10 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 
 out:
 	return ret;
-}
-
-static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
-{
-	struct coupling_desc *c_desc = &rdev->coupling_desc;
-	struct regulator_dev **c_rdevs = c_desc->coupled_rdevs;
-	int max_spread = rdev->constraints->max_spread;
-	int n_coupled = c_desc->n_coupled;
-	int desired_min_uV, desired_max_uV, min_current_uV = INT_MAX;
-	int max_current_uV = 0, highest_min_uV = 0, target_uV, possible_uV;
-	int i, ret;
-
-	/* If consumers don't provide any demands, set voltage to min_uV */
-	desired_min_uV = rdev->constraints->min_uV;
-	desired_max_uV = rdev->constraints->max_uV;
-	ret = regulator_check_consumers(rdev,
-					&desired_min_uV,
-					&desired_max_uV, PM_SUSPEND_ON);
-	if (ret < 0)
-		goto out;
-
-	/*
-	 * If there are no coupled regulators, simply set the voltage demanded
-	 * by consumers.
-	 */
-	if (n_coupled == 1) {
-		ret = desired_min_uV;
-		goto out;
-	}
-
-	/* Find highest min desired voltage */
-	for (i = 0; i < n_coupled; i++) {
-		int tmp_min = 0;
-		int tmp_max = INT_MAX;
-
-		if (!_regulator_is_enabled(c_rdevs[i]))
-			continue;
-
-		ret = regulator_check_consumers(c_rdevs[i],
-						&tmp_min,
-						&tmp_max, PM_SUSPEND_ON);
-		if (ret < 0)
-			goto out;
-
-		if (tmp_min > highest_min_uV)
-			highest_min_uV = tmp_min;
-	}
-
-	/*
-	 * Let target_uV be equal to the desired one if possible.
-	 * If not, set it to minimum voltage, allowed by other coupled
-	 * regulators.
-	 */
-	target_uV = max(desired_min_uV,  highest_min_uV - max_spread);
-
-	/*
-	 * Find min and max voltages, which currently aren't
-	 * violating max_spread
-	 */
-	for (i = 0; i < n_coupled; i++) {
-		int tmp_act;
-
-		/*
-		 * Don't check the regulator, which is about
-		 * to change voltage
-		 */
-		if (c_rdevs[i] == rdev)
-			continue;
-		if (!_regulator_is_enabled(c_rdevs[i]))
-			continue;
-
-		tmp_act = _regulator_get_voltage(c_rdevs[i]);
-		if (tmp_act < 0) {
-			ret = tmp_act;
-			goto out;
-		}
-
-		if (tmp_act < min_current_uV)
-			min_current_uV = tmp_act;
-
-		if (tmp_act > max_current_uV)
-			max_current_uV = tmp_act;
-	}
-
-	/* There aren't any other regulators enabled */
-	if (max_current_uV == 0) {
-		possible_uV = target_uV;
-	} else {
-		/*
-		 * Correct target voltage, so as it currently isn't
-		 * violating max_spread
-		 */
-		possible_uV = max(target_uV, max_current_uV - max_spread);
-		possible_uV = min(possible_uV, min_current_uV + max_spread);
-	}
-
-	if (possible_uV > desired_max_uV) {
-		ret = -EINVAL;
-		goto out;
-	}
-	ret = possible_uV;
-
-out:
-	return ret;
-}
-
-static int regulator_balance_voltage(struct regulator_dev *rdev,
-				     suspend_state_t state)
-{
-	struct regulator_dev **c_rdevs;
-	struct regulator_dev *best_rdev;
-	struct coupling_desc *c_desc = &rdev->coupling_desc;
-	int n_coupled;
-	int i, best_delta, best_uV, ret = 1;
-
-	c_rdevs = c_desc->coupled_rdevs;
-	n_coupled = c_desc->n_coupled;
-
-	/*
-	 * if system is in a state other than PM_SUSPEND_ON, don't check
-	 * other coupled regulators
-	 */
-	if (state != PM_SUSPEND_ON)
-		n_coupled = 1;
-
-	/*
-	 * Find the best possible voltage change on each loop. Leave the loop
-	 * if there isn't any possible change.
-	 */
-	while (1) {
-		best_delta = 0;
-		best_uV = 0;
-		best_rdev = NULL;
-
-		/*
-		 * Find highest difference between optimal voltage
-		 * and current voltage.
-		 */
-		for (i = 0; i < n_coupled; i++) {
-			/*
-			 * optimal_uV is the best voltage that can be set for
-			 * i-th regulator at the moment without violating
-			 * max_spread constraint in order to balance
-			 * the coupled voltages.
-			 */
-			int optimal_uV, current_uV;
-
-			optimal_uV = regulator_get_optimal_voltage(c_rdevs[i]);
-			if (optimal_uV < 0) {
-				ret = optimal_uV;
-				goto out;
-			}
-
-			current_uV = _regulator_get_voltage(c_rdevs[i]);
-			if (current_uV < 0) {
-				ret = optimal_uV;
-				goto out;
-			}
-
-			if (abs(best_delta) < abs(optimal_uV - current_uV)) {
-				best_delta = optimal_uV - current_uV;
-				best_rdev = c_rdevs[i];
-				best_uV = optimal_uV;
-			}
-		}
-
-		/* Nothing to change, return successfully */
-		if (!best_rdev) {
-			ret = 0;
-			goto out;
-		}
-
-		ret = regulator_set_voltage_rdev(best_rdev, best_uV,
-						 best_uV, state);
-
-		if (ret < 0)
-			goto out;
-	}
+out2:
+	voltage->min_uV = old_min_uV;
+	voltage->max_uV = old_max_uV;
 
-out:
 	return ret;
 }
 
@@ -3371,12 +3124,12 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
 {
 	int ret = 0;
 
-	regulator_lock_dependent(regulator->rdev);
+	regulator_lock_supply(regulator->rdev);
 
 	ret = regulator_set_voltage_unlocked(regulator, min_uV, max_uV,
 					     PM_SUSPEND_ON);
 
-	regulator_unlock_dependent(regulator->rdev);
+	regulator_unlock_supply(regulator->rdev);
 
 	return ret;
 }
@@ -3454,12 +3207,12 @@ int regulator_set_suspend_voltage(struct regulator *regulator, int min_uV,
 	if (regulator_check_states(state) || state == PM_SUSPEND_ON)
 		return -EINVAL;
 
-	regulator_lock_dependent(regulator->rdev);
+	regulator_lock_supply(regulator->rdev);
 
 	ret = _regulator_set_suspend_voltage(regulator, min_uV,
 					     max_uV, state);
 
-	regulator_unlock_dependent(regulator->rdev);
+	regulator_unlock_supply(regulator->rdev);
 
 	return ret;
 }
@@ -3651,11 +3404,11 @@ int regulator_get_voltage(struct regulator *regulator)
 {
 	int ret;
 
-	regulator_lock_dependent(regulator->rdev);
+	regulator_lock_supply(regulator->rdev);
 
 	ret = _regulator_get_voltage(regulator->rdev);
 
-	regulator_unlock_dependent(regulator->rdev);
+	regulator_unlock_supply(regulator->rdev);
 
 	return ret;
 }
-- 
2.17.0
