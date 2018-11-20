Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E7FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E7B2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 00:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PULIRjQJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E7B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732442AbeKTKx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:53:29 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46542 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeKTKx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 05:53:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so61780ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 16:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l0KPxu423nkJrvWHrXaqQd/NDLL/uyUiE93Qp6lhuXo=;
        b=PULIRjQJtlcwccq6cSG1GPcDj0S1lLtRTQvLz/rT1pZJbjZexaRpBiaArQkFSllgX7
         UgMb2SToJA1zugs7L1PRcbltVYt7bqDcWpMsbaIPO/vizSj1q3X5sAWMzt1VqDDyBeay
         AWo7KMke3TkbRPXaXJp/iRk7CAGaiDAB/tBd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l0KPxu423nkJrvWHrXaqQd/NDLL/uyUiE93Qp6lhuXo=;
        b=UC89x1iWENG61mEx8a2efmP42yvOdqPm/IFCMPcQgNxdhIksfbI4ejAczRSYNeBhKa
         ol19S3Er8/Hh2YfQ4WodO8y5yrGpj8mWNksv5ONMGx8o1MwTM4RK63btB1bYmICZtTIg
         CszUxI+PKrmhVGTzbj9PYKEYEdhk5XO0Eo1mL/hpyPvFu86tJq5qX98QmkfJlMJJD6G1
         G83Ybq2TpAcBXHUx9KKK4S1UEV/YIi6lR6qIuSEX/tkhViX7I2m/+RILOABns3s04kFp
         2g6rj2ZDu/cyZFvi1JxMCLBbpx9cOOxbdCkzj7Rd4G93DpINWhfL8u8EievlgEzrQdBW
         rcUg==
X-Gm-Message-State: AGRZ1gKKAY1WAgiZRPO0xm93rkV6rogc2Aml9DrZleEFXskl1rim736T
        GNi4qRCGj/vjhcQtk6+2/77UXg==
X-Google-Smtp-Source: AJdET5eYjBs3XnVvoDi2TVLL33SpKjkDrV+yf+ZLLCCDjEAnYzqJqdP+/ACPTqbsmX2G1KvyBcENyQ==
X-Received: by 2002:a17:902:9a91:: with SMTP id w17-v6mr23710378plp.274.1542673630508;
        Mon, 19 Nov 2018 16:27:10 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id z83-v6sm55240218pfi.4.2018.11.19.16.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 16:27:09 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, evgreen@chromium.org,
        swboyd@chromium.org, Dmitry Osipenko <digetx@gmail.com>,
        ryandcase@chromium.org, David Collins <collinsd@codeaurora.org>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] regulator: core: Only count load for enabled consumers
Date:   Mon, 19 Nov 2018 16:26:51 -0800
Message-Id: <20181120002654.1891-4-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181120002654.1891-1-dianders@chromium.org>
References: <20181120002654.1891-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Sometimgs disable_my_thing() sets a nominal (<= 100 uA) load instead
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

--

Places that set a load of 0 on every disable:
  drivers/bluetooth/hci_qca.c
  drivers/net/wireless/ath/ath10k/snoc.c
  drivers/remoteproc/qcom_q6v5_mss.c
  drivers/scsi/ufs/ufshcd.c

Places that set a nominal disable load (<= 100 uA):
  drivers/gpu/drm/msm/dsi/dsi_host.c:
    git grep -A10 'struct msm_dsi_config' | grep -A10 regs | grep '{.*}'
  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c:
    git grep -A10 'struct msm_dsi_phy_cfg' | grep -A10 regs | grep '{.*}'
  drivers/gpu/drm/msm/edp/edp_ctrl.c

Places that appear to continue to request load when disabled; I
believe this is not intentional and is a bug.  AKA: either the
regulator will be left in a higher power operating mode sometimes when
it doesn't need to or it is understood that there are no other
consumers of these rails and thus the regulator_set_load() shouldn't
have been needed at all (we should just force the regulator to high
power all the time in that case):
  drivers/phy/qualcomm/phy-qcom-ufs.c
  drivers/phy/qualcomm/phy-qcom-usb-hs.c
  drivers/remoteproc/qcom_q6v5_pas.c
  drivers/remoteproc/qcom_wcnss.c (*)
  drivers/remoteproc/qcom_wcnss_iris.c

(*) Quick glace makes me feel like this driver is buggy since
wcnss_start() enables regulators but wcnss_stop() doesn't disable
them.

--

Given the above argument, I propose changing the regulator core to
only consider loads from consumers that are currently enabled.  If
later we find a use case where we really need to count a non-zero load
when a consumer requests that a regulator be disabled we could just
count load like this in the system_load for the regulator.  If somehow
that's not possible I suppose we could add consider adding a new API
regulator_set_disabled_load().

In order to accomplish the above, we need to start tracking the enable
count per regulator consumer (it used to be tracked only globally
across all consumers of a given regulator).  This means:
- We can (and will) spit errors out for code that used to be invalid
  but was never caught before.  Specifically if someone leaves a
  regulator enabled and calls regulator_put() we'll yell.  We'll also
  yell if a single consumer calls more disables than enables.
- We now need to deal with "always-on" regulators slightly
  differently.  It's assumed that an always-on regulator could still
  transition between power modes, so if all of the active consumers of
  an always-on regulator don't need the regulator on we should still
  remove their requested load from the total.  The core used to have
  some optimizations where it didn't bother keeping track of the
  enable counts for always-on regulators because they were, well,
  always on.  While we could keep the optimization still for some
  cases, it's cleaner to just remove it.  A later patch will attempt
  to get some efficiency back by not propogating enables up
  unnecessarily.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Please give this patch lots of extra review.  It seems to work for me,
but I haven't done massive amounts of stress testing on it and I don't
touch every use case of the regulator core.  Thanks!

 drivers/regulator/core.c         | 190 +++++++++++++++++++++++--------
 drivers/regulator/internal.h     |   2 +
 include/linux/regulator/driver.h |   1 -
 3 files changed, 142 insertions(+), 51 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 63a8af1e2256..c5da6079e1cb 100644
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
@@ -2654,13 +2719,22 @@ int regulator_force_disable(struct regulator *regulator)
 {
 	struct regulator_dev *rdev = regulator->rdev;
 	struct ww_acquire_ctx ww_ctx;
+	bool update_uA;
 	int ret;
 
 	regulator_lock_dependent(rdev, &ww_ctx);
-	regulator->uA_load = 0;
+
 	ret = _regulator_force_disable(regulator->rdev);
+
 	if (rdev->coupling_desc.n_coupled > 1)
 		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+
+	update_uA = regulator->enable_count && regulator->uA_load;
+	regulator->enable_count = 0;
+	regulator->uA_load = 0;
+	if (update_uA)
+		ret = drms_uA_update(rdev);
+
 	regulator_unlock_dependent(rdev, &ww_ctx);
 
 	if (rdev->supply)
@@ -2677,14 +2751,11 @@ static void regulator_disable_work(struct work_struct *work)
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
@@ -2693,11 +2764,22 @@ static void regulator_disable_work(struct work_struct *work)
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
@@ -2721,14 +2803,11 @@ int regulator_disable_deferred(struct regulator *regulator, int ms)
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
@@ -4135,16 +4214,30 @@ EXPORT_SYMBOL_GPL(regulator_get_error_flags);
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
@@ -4315,11 +4408,8 @@ int regulator_bulk_enable(int num_consumers,
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
2.19.1.1215.g8438c0b245-goog

