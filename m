Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF32AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574E8214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="hMLePX9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574E8214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbeKVAFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:05:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60062 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730630AbeKVAFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=VER2LfcqzGCOwbllZeTYKHqcKrm7wVOtL0ptIeq+A88=; b=hMLePX9TfSQj
        kFJxtcWKX32i6thfBtG7izO592DyZN0TKUP7HyEzPE3kyQ7nMQJV4ttabMQm4JKToeVjDmO2STYQz
        id7SxF+LLZjMUTYR43eOx7Jm5/2CCPUK3AGVKKjd9nPAI9RlUrBu1xlic+a08hXL43ousoUZz9SIt
        o4CMw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gPSaa-0003a3-AX; Wed, 21 Nov 2018 13:30:44 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0BFEF11250AE; Wed, 21 Nov 2018 13:30:44 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: core: Only count load for enabled consumers" to the regulator tree
In-Reply-To: 
Message-Id: <20181121133044.0BFEF11250AE@debutante.sirena.org.uk>
Date:   Wed, 21 Nov 2018 13:30:44 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: core: Only count load for enabled consumers

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

From fe115f7fd44b66e5a457857ef79744cac64868c3 Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Tue, 20 Nov 2018 09:52:53 -0800
Subject: [PATCH] regulator: core: Only count load for enabled consumers

In general when the consumer of a regulator requests that the
regulator be disabled it no longer will be drawing much load from the
regulator--it should just be the leakage current and that should be
very close to 0.

Up to this point the regulator framework has continued to count a
consumer's load request for disabled regulators.  This has led to code
patterns that look like this:

  enable_my_thing():
    regular_set_load(reg, load_uA)
    regulator_enable(reg)

  disable_my_thing():
    regulator_disable(reg)
    regulator_set_load(reg, 0)

Sometimes disable_my_thing() sets a nominal (<= 100 uA) load instead
of setting a 0 uA load.  I will make the assertion that nearly all (if
not all) places where we set a nominal load of 100 uA or less we end
up with a result that is the same as if we had set a load of 0 uA.
Specifically:
- The whole point of setting the load is to help set the operating
  mode of the regulator.  Higher loads may need less efficient
  operating modes.
- The only time this matters at all is if there is another consumer of
  the regulator that wants the regulator on.  If there are no other
  consumers of the regulator then the regulator will turn off and we
  don't care about the operating mode.
- If there's another consumer that actually wants the regulator on
  then presumably it is requesting a load that makes our nominal
  <= 100 uA load insignificant.

A quick survey of the existing callers to regulator_set_load() to see
how everyone uses it:

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/core.c         | 193 +++++++++++++++++++++++--------
 drivers/regulator/internal.h     |   2 +
 include/linux/regulator/driver.h |   1 -
 3 files changed, 144 insertions(+), 52 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index ff5ca185bb8f..26a0c523ed86 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -99,7 +99,7 @@ struct regulator_supply_alias {
 };
 
 static int _regulator_is_enabled(struct regulator_dev *rdev);
-static int _regulator_disable(struct regulator_dev *rdev);
+static int _regulator_disable(struct regulator *regulator);
 static int _regulator_get_voltage(struct regulator_dev *rdev);
 static int _regulator_get_current_limit(struct regulator_dev *rdev);
 static unsigned int _regulator_get_mode(struct regulator_dev *rdev);
@@ -764,8 +764,10 @@ static ssize_t regulator_total_uA_show(struct device *dev,
 	int uA = 0;
 
 	regulator_lock(rdev);
-	list_for_each_entry(regulator, &rdev->consumer_list, list)
-		uA += regulator->uA_load;
+	list_for_each_entry(regulator, &rdev->consumer_list, list) {
+		if (regulator->enable_count)
+			uA += regulator->uA_load;
+	}
 	regulator_unlock(rdev);
 	return sprintf(buf, "%d\n", uA);
 }
@@ -938,8 +940,10 @@ static int drms_uA_update(struct regulator_dev *rdev)
 		return -EINVAL;
 
 	/* calc total requested load */
-	list_for_each_entry(sibling, &rdev->consumer_list, list)
-		current_uA += sibling->uA_load;
+	list_for_each_entry(sibling, &rdev->consumer_list, list) {
+		if (sibling->enable_count)
+			current_uA += sibling->uA_load;
+	}
 
 	current_uA += rdev->constraints->system_load;
 
@@ -2024,6 +2028,9 @@ static void _regulator_put(struct regulator *regulator)
 
 	lockdep_assert_held_once(&regulator_list_mutex);
 
+	/* Docs say you must disable before calling regulator_put() */
+	WARN_ON(regulator->enable_count);
+
 	rdev = regulator->rdev;
 
 	debugfs_remove_recursive(regulator->debugfs);
@@ -2417,15 +2424,75 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
 	return 0;
 }
 
+/**
+ * _regulator_handle_consumer_enable - handle that a consumer enabled
+ * @regulator: regulator source
+ *
+ * Some things on a regulator consumer (like the contribution towards total
+ * load on the regulator) only have an effect when the consumer wants the
+ * regulator enabled.  Explained in example with two consumers of the same
+ * regulator:
+ *   consumer A: set_load(100);       => total load = 0
+ *   consumer A: regulator_enable();  => total load = 100
+ *   consumer B: set_load(1000);      => total load = 100
+ *   consumer B: regulator_enable();  => total load = 1100
+ *   consumer A: regulator_disable(); => total_load = 1000
+ *
+ * This function (together with _regulator_handle_consumer_disable) is
+ * responsible for keeping track of the refcount for a given regulator consumer
+ * and applying / unapplying these things.
+ *
+ * Returns 0 upon no error; -error upon error.
+ */
+static int _regulator_handle_consumer_enable(struct regulator *regulator)
+{
+	struct regulator_dev *rdev = regulator->rdev;
+
+	lockdep_assert_held_once(&rdev->mutex.base);
+
+	regulator->enable_count++;
+	if (regulator->uA_load && regulator->enable_count == 1)
+		return drms_uA_update(rdev);
+
+	return 0;
+}
+
+/**
+ * _regulator_handle_consumer_disable - handle that a consumer disabled
+ * @regulator: regulator source
+ *
+ * The opposite of _regulator_handle_consumer_enable().
+ *
+ * Returns 0 upon no error; -error upon error.
+ */
+static int _regulator_handle_consumer_disable(struct regulator *regulator)
+{
+	struct regulator_dev *rdev = regulator->rdev;
+
+	lockdep_assert_held_once(&rdev->mutex.base);
+
+	if (!regulator->enable_count) {
+		rdev_err(rdev, "Underflow of regulator enable count\n");
+		return -EINVAL;
+	}
+
+	regulator->enable_count--;
+	if (regulator->uA_load && regulator->enable_count == 0)
+		return drms_uA_update(rdev);
+
+	return 0;
+}
+
 /* locks held by regulator_enable() */
-static int _regulator_enable(struct regulator_dev *rdev)
+static int _regulator_enable(struct regulator *regulator)
 {
+	struct regulator_dev *rdev = regulator->rdev;
 	int ret;
 
 	lockdep_assert_held_once(&rdev->mutex.base);
 
 	if (rdev->supply) {
-		ret = _regulator_enable(rdev->supply->rdev);
+		ret = _regulator_enable(rdev->supply);
 		if (ret < 0)
 			return ret;
 	}
@@ -2437,9 +2504,9 @@ static int _regulator_enable(struct regulator_dev *rdev)
 			goto err_disable_supply;
 	}
 
-	/* check voltage and requested load before enabling */
-	if (regulator_ops_is_valid(rdev, REGULATOR_CHANGE_DRMS))
-		drms_uA_update(rdev);
+	ret = _regulator_handle_consumer_enable(regulator);
+	if (ret < 0)
+		goto err_disable_supply;
 
 	if (rdev->use_count == 0) {
 		/* The regulator may on if it's not switchable or left on */
@@ -2448,18 +2515,18 @@ static int _regulator_enable(struct regulator_dev *rdev)
 			if (!regulator_ops_is_valid(rdev,
 					REGULATOR_CHANGE_STATUS)) {
 				ret = -EPERM;
-				goto err_disable_supply;
+				goto err_consumer_disable;
 			}
 
 			ret = _regulator_do_enable(rdev);
 			if (ret < 0)
-				goto err_disable_supply;
+				goto err_consumer_disable;
 
 			_notifier_call_chain(rdev, REGULATOR_EVENT_ENABLE,
 					     NULL);
 		} else if (ret < 0) {
 			rdev_err(rdev, "is_enabled() failed: %d\n", ret);
-			goto err_disable_supply;
+			goto err_consumer_disable;
 		}
 		/* Fallthrough on positive return values - already enabled */
 	}
@@ -2468,9 +2535,12 @@ static int _regulator_enable(struct regulator_dev *rdev)
 
 	return 0;
 
+err_consumer_disable:
+	_regulator_handle_consumer_disable(regulator);
+
 err_disable_supply:
 	if (rdev->supply)
-		_regulator_disable(rdev->supply->rdev);
+		_regulator_disable(rdev->supply);
 
 	return ret;
 }
@@ -2490,13 +2560,10 @@ int regulator_enable(struct regulator *regulator)
 {
 	struct regulator_dev *rdev = regulator->rdev;
 	struct ww_acquire_ctx ww_ctx;
-	int ret = 0;
-
-	if (regulator->always_on)
-		return 0;
+	int ret;
 
 	regulator_lock_dependent(rdev, &ww_ctx);
-	ret = _regulator_enable(rdev);
+	ret = _regulator_enable(regulator);
 	regulator_unlock_dependent(rdev, &ww_ctx);
 
 	return ret;
@@ -2535,8 +2602,9 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
 }
 
 /* locks held by regulator_disable() */
-static int _regulator_disable(struct regulator_dev *rdev)
+static int _regulator_disable(struct regulator *regulator)
 {
+	struct regulator_dev *rdev = regulator->rdev;
 	int ret = 0;
 
 	lockdep_assert_held_once(&rdev->mutex.base);
@@ -2571,17 +2639,17 @@ static int _regulator_disable(struct regulator_dev *rdev)
 
 		rdev->use_count = 0;
 	} else if (rdev->use_count > 1) {
-		if (regulator_ops_is_valid(rdev, REGULATOR_CHANGE_DRMS))
-			drms_uA_update(rdev);
-
 		rdev->use_count--;
 	}
 
+	if (ret == 0)
+		ret = _regulator_handle_consumer_disable(regulator);
+
 	if (ret == 0 && rdev->coupling_desc.n_coupled > 1)
 		ret = regulator_balance_voltage(rdev, PM_SUSPEND_ON);
 
 	if (ret == 0 && rdev->supply)
-		ret = _regulator_disable(rdev->supply->rdev);
+		ret = _regulator_disable(rdev->supply);
 
 	return ret;
 }
@@ -2602,13 +2670,10 @@ int regulator_disable(struct regulator *regulator)
 {
 	struct regulator_dev *rdev = regulator->rdev;
 	struct ww_acquire_ctx ww_ctx;
-	int ret = 0;
-
-	if (regulator->always_on)
-		return 0;
+	int ret;
 
 	regulator_lock_dependent(rdev, &ww_ctx);
-	ret = _regulator_disable(rdev);
+	ret = _regulator_disable(regulator);
 	regulator_unlock_dependent(rdev, &ww_ctx);
 
 	return ret;
@@ -2657,10 +2722,17 @@ int regulator_force_disable(struct regulator *regulator)
 	int ret;
 
 	regulator_lock_dependent(rdev, &ww_ctx);
-	regulator->uA_load = 0;
+
 	ret = _regulator_force_disable(regulator->rdev);
+
 	if (rdev->coupling_desc.n_coupled > 1)
 		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+
+	if (regulator->uA_load) {
+		regulator->uA_load = 0;
+		ret = drms_uA_update(rdev);
+	}
+
 	regulator_unlock_dependent(rdev, &ww_ctx);
 
 	if (rdev->supply)
@@ -2677,14 +2749,11 @@ static void regulator_disable_work(struct work_struct *work)
 						  disable_work.work);
 	struct ww_acquire_ctx ww_ctx;
 	int count, i, ret;
+	struct regulator *regulator;
+	int total_count = 0;
 
 	regulator_lock_dependent(rdev, &ww_ctx);
 
-	BUG_ON(!rdev->deferred_disables);
-
-	count = rdev->deferred_disables;
-	rdev->deferred_disables = 0;
-
 	/*
 	 * Workqueue functions queue the new work instance while the previous
 	 * work instance is being processed. Cancel the queued work instance
@@ -2693,11 +2762,22 @@ static void regulator_disable_work(struct work_struct *work)
 	 */
 	cancel_delayed_work(&rdev->disable_work);
 
-	for (i = 0; i < count; i++) {
-		ret = _regulator_disable(rdev);
-		if (ret != 0)
-			rdev_err(rdev, "Deferred disable failed: %d\n", ret);
+	list_for_each_entry(regulator, &rdev->consumer_list, list) {
+		count = regulator->deferred_disables;
+
+		if (!count)
+			continue;
+
+		total_count += count;
+		regulator->deferred_disables = 0;
+
+		for (i = 0; i < count; i++) {
+			ret = _regulator_disable(regulator);
+			if (ret != 0)
+				rdev_err(rdev, "Deferred disable failed: %d\n", ret);
+		}
 	}
+	WARN_ON(!total_count);
 
 	if (rdev->coupling_desc.n_coupled > 1)
 		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
@@ -2731,14 +2811,11 @@ int regulator_disable_deferred(struct regulator *regulator, int ms)
 {
 	struct regulator_dev *rdev = regulator->rdev;
 
-	if (regulator->always_on)
-		return 0;
-
 	if (!ms)
 		return regulator_disable(regulator);
 
 	regulator_lock(rdev);
-	rdev->deferred_disables++;
+	regulator->deferred_disables++;
 	mod_delayed_work(system_power_efficient_wq, &rdev->disable_work,
 			 msecs_to_jiffies(ms));
 	regulator_unlock(rdev);
@@ -4145,16 +4222,30 @@ EXPORT_SYMBOL_GPL(regulator_get_error_flags);
  * DRMS will sum the total requested load on the regulator and change
  * to the most efficient operating mode if platform constraints allow.
  *
+ * NOTE: when a regulator consumer requests to have a regulator
+ * disabled then any load that consumer requested no longer counts
+ * toward the total requested load.  If the regulator is re-enabled
+ * then the previously requested load will start counting again.
+ *
+ * If a regulator is an always-on regulator then an individual consumer's
+ * load will still be removed if that consumer is fully disabled.
+ *
  * On error a negative errno is returned.
  */
 int regulator_set_load(struct regulator *regulator, int uA_load)
 {
 	struct regulator_dev *rdev = regulator->rdev;
-	int ret;
+	int old_uA_load;
+	int ret = 0;
 
 	regulator_lock(rdev);
+	old_uA_load = regulator->uA_load;
 	regulator->uA_load = uA_load;
-	ret = drms_uA_update(rdev);
+	if (regulator->enable_count && old_uA_load != uA_load) {
+		ret = drms_uA_update(rdev);
+		if (ret < 0)
+			regulator->uA_load = old_uA_load;
+	}
 	regulator_unlock(rdev);
 
 	return ret;
@@ -4325,11 +4416,8 @@ int regulator_bulk_enable(int num_consumers,
 	int ret = 0;
 
 	for (i = 0; i < num_consumers; i++) {
-		if (consumers[i].consumer->always_on)
-			consumers[i].ret = 0;
-		else
-			async_schedule_domain(regulator_bulk_enable_async,
-					      &consumers[i], &async_domain);
+		async_schedule_domain(regulator_bulk_enable_async,
+				      &consumers[i], &async_domain);
 	}
 
 	async_synchronize_full_domain(&async_domain);
@@ -5225,8 +5313,11 @@ static void regulator_summary_show_subtree(struct seq_file *s,
 
 		switch (rdev->desc->type) {
 		case REGULATOR_VOLTAGE:
-			seq_printf(s, "%37dmA %5dmV %5dmV",
+			seq_printf(s, "%3d %33dmA%c%5dmV %5dmV",
+				   consumer->enable_count,
 				   consumer->uA_load / 1000,
+				   consumer->uA_load && !consumer->enable_count ?
+				   '*' : ' ',
 				   consumer->voltage[PM_SUSPEND_ON].min_uV / 1000,
 				   consumer->voltage[PM_SUSPEND_ON].max_uV / 1000);
 			break;
diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index 943926a156f2..6017f15c5d75 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -42,6 +42,8 @@ struct regulator {
 	unsigned int always_on:1;
 	unsigned int bypass:1;
 	int uA_load;
+	unsigned int enable_count;
+	unsigned int deferred_disables;
 	struct regulator_voltage voltage[REGULATOR_STATES_NUM];
 	const char *supply_name;
 	struct device_attribute dev_attr;
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 7065031f0846..389bcaf7900f 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -474,7 +474,6 @@ struct regulator_dev {
 	struct regmap *regmap;
 
 	struct delayed_work disable_work;
-	int deferred_disables;
 
 	void *reg_data;		/* regulator_dev data */
 
-- 
2.19.0.rc2

