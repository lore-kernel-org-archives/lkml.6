Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeCIMTS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 07:19:18 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55201 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbeCIMTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 07:19:16 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180309121913euoutp029c5f1e3530ff6bde8cd4bc40c12fb7d1~aP8hMpQKW2741227412euoutp02a
X-AuditID: cbfec7f5-b45ff700000028a9-e4-5aa27bc04e24
From: Maciej Purski <m.purski@samsung.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Doug Anderson <dianders@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v6 1/6] regulator: core: Make locks re-entrant
Date: Fri, 09 Mar 2018 13:19:06 +0100
Message-id: <1520597946-11579-1-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7djP87oHqhdFGbxpE7XYOGM9q8XUh0/Y
        LOYfOcdqcXbZQTaLh1f9Lb5d6WCyuLxrDpvFgpe3WCzWHrnLbrH0+kUmi9a9R9gt9l/xcuDx
        WDNvDaPHt6+TWDxmN1xk8dg56y67x6ZVnWwefVtWMXp83iQXwB7FZZOSmpNZllqkb5fAlbFt
        skNBT2LF1TOCDYwv/bsYOTkkBEwkpn6dw9bFyMUhJLCCUeLLuuvMEM5nRomF3w6zw1R9OfyD
        CcQWEljGKPH3RDaE/Z9R4sZszy5GDg42AS2JNe3xIGERARuJtzcOMILMYRboZ5aY3NTKApIQ
        FrCTmNP3jBHEZhFQlVg47zsbiM0r4CIxY/INNohdchI3z3WCHSEhMIdN4v/8s4wgCySAirau
        1oeoEZZ4dXwL1G0yEp0dB5kg7GqJi193Qc2pkWi8vQGqxlri86QtzCA2swCfxKRt05khRvJK
        dLQJQZR4SGy7fwpqjKPE2q/9UO/GStw6d4ltAqPkAkaGVYziqaXFuempxcZ5qeV6xYm5xaV5
        6XrJ+bmbGIFxe/rf8a87GPf9STrEKMDBqMTD+8BxYZQQa2JZcWXuIUYJDmYlEd6qikVRQrwp
        iZVVqUX58UWlOanFhxilOViUxHnjNOqihATSE0tSs1NTC1KLYLJMHJxSDYwrDr1MZLytMf11
        S2jL7PXCLXOmZYtyn6/LkHBmvPB/gdqsd4cfrD3R0HBEWflz6v19pe+t+PqYAp6kVoV7H8h4
        +qE9ZNOh3684ZHzaO2cJfuotUHHZvkfyoLLErQs6oYusTkft/q+8Wb1+S75q8cYHkr3R/yb9
        cS2accX1EmtJ9NFvc+weCykosRRnJBpqMRcVJwIA5QF5p9cCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42I5/e/4Nd391YuiDBrmmFhsnLGe1WLqwyds
        FvOPnGO1OLvsIJvFw6v+Ft+udDBZXN41h81iwctbLBZrj9xlt1h6/SKTReveI+wW+694OfB4
        rJm3htHj29dJLB6zGy6yeOycdZfdY9OqTjaPvi2rGD0+b5ILYI/isklJzcksSy3St0vgytg2
        2aGgJ7Hi6hnBBsaX/l2MnBwSAiYSXw7/YOpi5OIQEljCKNEy6RcjhNPIJPHv722WLkYODjYB
        LYk17fEgDSICNhJvbxwAq2EWmMgssXDxFVaQhLCAncScvmeMIDaLgKrEwnnf2UBsXgEXiRmT
        b7BBbJOTuHmuk3kCI9cCRoZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgaG07djPzTsYL20M
        PsQowMGoxMP7wHFhlBBrYllxZe4hRgkOZiUR3qqKRVFCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
        ec8bVEYJCaQnlqRmp6YWpBbBZJk4OKUaGLkvbnydn++/pNlR9+va6ennNV16L/kyzm6ozHOo
        bOj1N1nKyZXv/XmFuYZjs33q7ZOJt0rFvzncXci/3FTpr7CrX8gj/7MSLqZeymud9ihPPhoQ
        x3RX8aaZlZf7XUM+A83XYpyni35tPBdxbtv+07o/Lvp03nSpjdVPDs3JOqrOLaLzJ8lJiaU4
        I9FQi7moOBEAUgR3RCECAAA=
X-CMS-MailID: 20180309121911eucas1p2e096c2f5aed2afd79718b4a52e402b0f
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180309121911eucas1p2e096c2f5aed2afd79718b4a52e402b0f
X-RootMTR: 20180309121911eucas1p2e096c2f5aed2afd79718b4a52e402b0f
References: <CGME20180309121911eucas1p2e096c2f5aed2afd79718b4a52e402b0f@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting voltage, enabling/disabling regulators requires operations on
all regulators related with the regulator being changed. Therefore,
all of them should be locked for the whole operation. With the current
locking implementation, adding additional dependency (regulators
coupling) causes deadlocks in some cases.

Introduce a possibility to attempt to lock a mutex multiple times
by the same task without waiting on a mutex. This should handle all
reasonable coupling-supplying combinations, especially when two coupled
regulators share common supplies. The only situation that should be
forbidden is simultaneous coupling and supplying between a pair of
regulators.

The idea is based on clk core.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
---
 drivers/regulator/core.c         | 132 +++++++++++++++++++++++++++------------
 include/linux/regulator/driver.h |   2 +
 2 files changed, 93 insertions(+), 41 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5494189..f6e784c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -147,6 +147,56 @@ static inline struct regulator_dev *rdev_get_supply(struct regulator_dev *rdev)
 }
 
 /**
+ * regulator_lock_nested - lock a single regulator
+ * @rdev:		regulator source
+ * @subclass:		mutex subclass used for lockdep
+ *
+ * This function can be called many times by one task on
+ * a single regulator and its mutex will be locked only
+ * once. If a task, which is calling this function is other
+ * than the one, which initially locked the mutex, it will
+ * wait on mutex.
+ */
+static void regulator_lock_nested(struct regulator_dev *rdev,
+				  unsigned int subclass)
+{
+	if (!mutex_trylock(&rdev->mutex)) {
+		if (rdev->mutex_owner == current) {
+			rdev->ref_cnt++;
+			return;
+		}
+		mutex_lock_nested(&rdev->mutex, subclass);
+	}
+
+	rdev->ref_cnt = 1;
+	rdev->mutex_owner = current;
+}
+
+static inline void regulator_lock(struct regulator_dev *rdev)
+{
+	regulator_lock_nested(rdev, 0);
+}
+
+/**
+ * regulator_unlock - unlock a single regulator
+ * @rdev:		regulator_source
+ *
+ * This function unlocks the mutex when the
+ * reference counter reaches 0.
+ */
+static void regulator_unlock(struct regulator_dev *rdev)
+{
+	if (rdev->ref_cnt != 0) {
+		rdev->ref_cnt--;
+
+		if (!rdev->ref_cnt) {
+			rdev->mutex_owner = NULL;
+			mutex_unlock(&rdev->mutex);
+		}
+	}
+}
+
+/**
  * regulator_lock_supply - lock a regulator and its supplies
  * @rdev:         regulator source
  */
@@ -155,7 +205,7 @@ static void regulator_lock_supply(struct regulator_dev *rdev)
 	int i;
 
 	for (i = 0; rdev; rdev = rdev_get_supply(rdev), i++)
-		mutex_lock_nested(&rdev->mutex, i);
+		regulator_lock_nested(rdev, i);
 }
 
 /**
@@ -167,7 +217,7 @@ static void regulator_unlock_supply(struct regulator_dev *rdev)
 	struct regulator *supply;
 
 	while (1) {
-		mutex_unlock(&rdev->mutex);
+		regulator_unlock(rdev);
 		supply = rdev->supply;
 
 		if (!rdev->supply)
@@ -350,9 +400,9 @@ static ssize_t regulator_uV_show(struct device *dev,
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 	ssize_t ret;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 	ret = sprintf(buf, "%d\n", _regulator_get_voltage(rdev));
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 
 	return ret;
 }
@@ -416,9 +466,9 @@ static ssize_t regulator_state_show(struct device *dev,
 	struct regulator_dev *rdev = dev_get_drvdata(dev);
 	ssize_t ret;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 	ret = regulator_print_state(buf, _regulator_is_enabled(rdev));
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 
 	return ret;
 }
@@ -526,10 +576,10 @@ static ssize_t regulator_total_uA_show(struct device *dev,
 	struct regulator *regulator;
 	int uA = 0;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 	list_for_each_entry(regulator, &rdev->consumer_list, list)
 		uA += regulator->uA_load;
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 	return sprintf(buf, "%d\n", uA);
 }
 static DEVICE_ATTR(requested_microamps, 0444, regulator_total_uA_show, NULL);
@@ -1321,7 +1371,7 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	if (regulator == NULL)
 		return NULL;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 	regulator->rdev = rdev;
 	list_add(&regulator->list, &rdev->consumer_list);
 
@@ -1376,12 +1426,12 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	    _regulator_is_enabled(rdev))
 		regulator->always_on = true;
 
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 	return regulator;
 overflow_err:
 	list_del(&regulator->list);
 	kfree(regulator);
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 	return NULL;
 }
 
@@ -1770,13 +1820,13 @@ static void _regulator_put(struct regulator *regulator)
 	/* remove any sysfs entries */
 	if (regulator->dev)
 		sysfs_remove_link(&rdev->dev.kobj, regulator->supply_name);
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 	list_del(&regulator->list);
 
 	rdev->open_count--;
 	rdev->exclusive = 0;
 	put_device(&rdev->dev);
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 
 	kfree_const(regulator->supply_name);
 	kfree(regulator);
@@ -2384,7 +2434,7 @@ static void regulator_disable_work(struct work_struct *work)
 						  disable_work.work);
 	int count, i, ret;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 
 	BUG_ON(!rdev->deferred_disables);
 
@@ -2405,7 +2455,7 @@ static void regulator_disable_work(struct work_struct *work)
 			rdev_err(rdev, "Deferred disable failed: %d\n", ret);
 	}
 
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 
 	if (rdev->supply) {
 		for (i = 0; i < count; i++) {
@@ -2440,11 +2490,11 @@ int regulator_disable_deferred(struct regulator *regulator, int ms)
 	if (!ms)
 		return regulator_disable(regulator);
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 	rdev->deferred_disables++;
 	mod_delayed_work(system_power_efficient_wq, &rdev->disable_work,
 			 msecs_to_jiffies(ms));
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 
 	return 0;
 }
@@ -2476,10 +2526,10 @@ static int _regulator_list_voltage(struct regulator_dev *rdev,
 		if (selector >= rdev->desc->n_voltages)
 			return -EINVAL;
 		if (lock)
-			mutex_lock(&rdev->mutex);
+			regulator_lock(rdev);
 		ret = ops->list_voltage(rdev, selector);
 		if (lock)
-			mutex_unlock(&rdev->mutex);
+			regulator_unlock(rdev);
 	} else if (rdev->is_switch && rdev->supply) {
 		ret = _regulator_list_voltage(rdev->supply->rdev,
 					      selector, lock);
@@ -3252,7 +3302,7 @@ int regulator_sync_voltage(struct regulator *regulator)
 	struct regulator_voltage *voltage = &regulator->voltage[PM_SUSPEND_ON];
 	int ret, min_uV, max_uV;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 
 	if (!rdev->desc->ops->set_voltage &&
 	    !rdev->desc->ops->set_voltage_sel) {
@@ -3281,7 +3331,7 @@ int regulator_sync_voltage(struct regulator *regulator)
 	ret = _regulator_do_set_voltage(rdev, min_uV, max_uV);
 
 out:
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_sync_voltage);
@@ -3374,7 +3424,7 @@ int regulator_set_current_limit(struct regulator *regulator,
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 
 	/* sanity check */
 	if (!rdev->desc->ops->set_current_limit) {
@@ -3389,7 +3439,7 @@ int regulator_set_current_limit(struct regulator *regulator,
 
 	ret = rdev->desc->ops->set_current_limit(rdev, min_uA, max_uA);
 out:
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_set_current_limit);
@@ -3398,7 +3448,7 @@ static int _regulator_get_current_limit(struct regulator_dev *rdev)
 {
 	int ret;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 
 	/* sanity check */
 	if (!rdev->desc->ops->get_current_limit) {
@@ -3408,7 +3458,7 @@ static int _regulator_get_current_limit(struct regulator_dev *rdev)
 
 	ret = rdev->desc->ops->get_current_limit(rdev);
 out:
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 	return ret;
 }
 
@@ -3444,7 +3494,7 @@ int regulator_set_mode(struct regulator *regulator, unsigned int mode)
 	int ret;
 	int regulator_curr_mode;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 
 	/* sanity check */
 	if (!rdev->desc->ops->set_mode) {
@@ -3468,7 +3518,7 @@ int regulator_set_mode(struct regulator *regulator, unsigned int mode)
 
 	ret = rdev->desc->ops->set_mode(rdev, mode);
 out:
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(regulator_set_mode);
@@ -3477,7 +3527,7 @@ static unsigned int _regulator_get_mode(struct regulator_dev *rdev)
 {
 	int ret;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 
 	/* sanity check */
 	if (!rdev->desc->ops->get_mode) {
@@ -3487,7 +3537,7 @@ static unsigned int _regulator_get_mode(struct regulator_dev *rdev)
 
 	ret = rdev->desc->ops->get_mode(rdev);
 out:
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 	return ret;
 }
 
@@ -3508,7 +3558,7 @@ static int _regulator_get_error_flags(struct regulator_dev *rdev,
 {
 	int ret;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 
 	/* sanity check */
 	if (!rdev->desc->ops->get_error_flags) {
@@ -3518,7 +3568,7 @@ static int _regulator_get_error_flags(struct regulator_dev *rdev,
 
 	ret = rdev->desc->ops->get_error_flags(rdev, flags);
 out:
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 	return ret;
 }
 
@@ -3567,10 +3617,10 @@ int regulator_set_load(struct regulator *regulator, int uA_load)
 	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 	regulator->uA_load = uA_load;
 	ret = drms_uA_update(rdev);
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 
 	return ret;
 }
@@ -3598,7 +3648,7 @@ int regulator_allow_bypass(struct regulator *regulator, bool enable)
 	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_BYPASS))
 		return 0;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 
 	if (enable && !regulator->bypass) {
 		rdev->bypass_count++;
@@ -3622,7 +3672,7 @@ int regulator_allow_bypass(struct regulator *regulator, bool enable)
 	if (ret == 0)
 		regulator->bypass = enable;
 
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 
 	return ret;
 }
@@ -4288,9 +4338,9 @@ static int _regulator_suspend_late(struct device *dev, void *data)
 	suspend_state_t *state = data;
 	int ret;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 	ret = suspend_set_state(rdev, *state);
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 
 	return ret;
 }
@@ -4319,14 +4369,14 @@ static int _regulator_resume_early(struct device *dev, void *data)
 	if (rstate == NULL)
 		return 0;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 
 	if (rdev->desc->ops->resume_early &&
 	    (rstate->enabled == ENABLE_IN_SUSPEND ||
 	     rstate->enabled == DISABLE_IN_SUSPEND))
 		ret = rdev->desc->ops->resume_early(rdev);
 
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 
 	return ret;
 }
@@ -4628,7 +4678,7 @@ static int __init regulator_late_cleanup(struct device *dev, void *data)
 	if (!regulator_ops_is_valid(rdev, REGULATOR_CHANGE_STATUS))
 		return 0;
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock(rdev);
 
 	if (rdev->use_count)
 		goto unlock;
@@ -4659,7 +4709,7 @@ static int __init regulator_late_cleanup(struct device *dev, void *data)
 	}
 
 unlock:
-	mutex_unlock(&rdev->mutex);
+	regulator_unlock(rdev);
 
 	return 0;
 }
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4fc96cb..659a031 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -431,6 +431,8 @@ struct regulator_dev {
 
 	struct blocking_notifier_head notifier;
 	struct mutex mutex; /* consumer lock */
+	struct task_struct *mutex_owner;
+	int ref_cnt;
 	struct module *owner;
 	struct device dev;
 	struct regulation_constraints *constraints;
-- 
2.7.4
