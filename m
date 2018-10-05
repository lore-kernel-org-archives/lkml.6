Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D3DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4262087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y44eH0w2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4262087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbeJEWhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:37:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37200 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbeJEWhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:37:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id a82-v6so9672189lfa.4;
        Fri, 05 Oct 2018 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FdUkeSjiaiJwF8K+QGC+weaHs0MXhzDTELNH8Q0WqMo=;
        b=Y44eH0w2mnpCITqqApZac0ub6AkWeU4Ubf43qxkyAd6mUHmV43X8B9sSafaSu0YUrd
         HbcwI3UrnWbrA+Ca56pXzwg0/zqenf/m0MqY0LlbprPKwmkF+IJFpSLomtpLi6xTKnAa
         /9WjhAiCLY6JStlr/tqHAF2T2Yyd3jhG9Cyf3gzIBS1Fyfmsi+hfuPVeOIuNnGgtZAcz
         B1r8WLxNynV7CTq6HpcvaO2rMyD9ua0FNdU1eu03rV7wwPnIMxvk8aoHB4pHOIrtvjTN
         h327/rxGmb66DW8raJL3FArPL+CKaoxP6gOuvIaSH4TkXDPfYkFuRcWVBN8WN7lmPtg8
         RnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FdUkeSjiaiJwF8K+QGC+weaHs0MXhzDTELNH8Q0WqMo=;
        b=svaoFKwDu89PXUsuBUaxVVimO1qK1hcVDroed7LfkvW/Z0K2ERsVdiGlfkhAxSasBL
         zFBXJX8GxTCh+pGU/ilFUbZdjpaungl8mxgzjaHBZoN2jodIOO4NlmIQ7WVghV9WVTvH
         vieta/Z+2qvMAcjJ56Mdz/L5Eor2RH17kjVcoGprsA3AcD8KNSlvCZOqtt23HBACJJyJ
         gyKn777bFPluD74T8AcnytUHzQPjccDXpEvk7rtKCQLOX6Zvet40Z72rpnV3pQ+oxKdc
         m1NM//zcuCsrvLdkniKpqVQXx5y6yAWpK2j+6HXtPAAIX1v4Ne/agFqQj/XWHbI8lI0N
         sJ9A==
X-Gm-Message-State: ABuFfojzssfGP72UMNqQfJKxbnx5boLGErPp16BpU52aCgq/j4l1ZbER
        GTd165V0WS3kC2A7jkAYHoA=
X-Google-Smtp-Source: ACcGV62SPuTiYB3ucXCSKhzqasjrqNeooUixrKFjMr++qA8NKwUjGnu3ABYDGz6htQcDBwAnO5wpgw==
X-Received: by 2002:a19:645e:: with SMTP id b30-v6mr7009127lfj.5.1538753874945;
        Fri, 05 Oct 2018 08:37:54 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id w22-v6sm1879373lfd.72.2018.10.05.08.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 08:37:54 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maciej Purski <m.purski@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v1 02/11] regulator: core: Change voltage setting path
Date:   Fri,  5 Oct 2018 18:36:29 +0300
Message-Id: <20181005153638.1886-3-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Purski <m.purski@samsung.com>

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
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 145 ++++++++++++++++++++++++++-------------
 1 file changed, 99 insertions(+), 46 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a2a513780fd7..5105eaaf3cef 100644
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
 
-		rdev = supply->rdev;
+		regulator_unlock(c_rdev);
+
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
@@ -2289,9 +2321,16 @@ int regulator_enable(struct regulator *regulator)
 			return ret;
 	}
 
-	mutex_lock(&rdev->mutex);
+	regulator_lock_dependent(rdev);
+	/* balance only if there are regulators coupled */
+	if (rdev->coupling_desc.n_coupled > 1) {
+		ret = regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+		if (ret != 0)
+			goto unlock;
+	}
 	ret = _regulator_enable(rdev);
-	mutex_unlock(&rdev->mutex);
+unlock:
+	regulator_unlock_dependent(rdev);
 
 	if (ret != 0 && rdev->supply)
 		regulator_disable(rdev->supply);
@@ -2397,9 +2436,11 @@ int regulator_disable(struct regulator *regulator)
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
@@ -2448,10 +2489,12 @@ int regulator_force_disable(struct regulator *regulator)
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
@@ -2599,9 +2642,9 @@ int regulator_is_enabled(struct regulator *regulator)
 	if (regulator->always_on)
 		return 1;
 
-	mutex_lock(&regulator->rdev->mutex);
+	regulator_lock_dependent(regulator->rdev);
 	ret = _regulator_is_enabled(regulator->rdev);
-	mutex_unlock(&regulator->rdev->mutex);
+	regulator_unlock_dependent(regulator->rdev);
 
 	return ret;
 }
@@ -3015,8 +3058,6 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	int ret = 0;
 	int old_min_uV, old_max_uV;
 	int current_uV;
-	int best_supply_uV = 0;
-	int supply_change_uV = 0;
 
 	/* If we're setting the same range as last time the change
 	 * should be a noop (some cpufreq implementations use the same
@@ -3056,10 +3097,27 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	voltage->min_uV = min_uV;
 	voltage->max_uV = max_uV;
 
-	ret = regulator_check_consumers(rdev, &min_uV, &max_uV, state);
+	/* for not coupled regulators this will just set the voltage */
+	ret = regulator_balance_voltage(rdev, state);
 	if (ret < 0)
 		goto out2;
 
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
@@ -3071,13 +3129,13 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
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
@@ -3085,7 +3143,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		current_supply_uV = _regulator_get_voltage(rdev->supply->rdev);
 		if (current_supply_uV < 0) {
 			ret = current_supply_uV;
-			goto out2;
+			goto out;
 		}
 
 		supply_change_uV = best_supply_uV - current_supply_uV;
@@ -3097,7 +3155,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		if (ret) {
 			dev_err(&rdev->dev, "Failed to increase supply voltage: %d\n",
 					ret);
-			goto out2;
+			goto out;
 		}
 	}
 
@@ -3107,7 +3165,7 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 		ret = _regulator_do_set_suspend_voltage(rdev, min_uV,
 							max_uV, state);
 	if (ret < 0)
-		goto out2;
+		goto out;
 
 	if (supply_change_uV < 0) {
 		ret = regulator_set_voltage_unlocked(rdev->supply,
@@ -3120,11 +3178,6 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	}
 
 out:
-	return ret;
-out2:
-	voltage->min_uV = old_min_uV;
-	voltage->max_uV = old_max_uV;
-
 	return ret;
 }
 
@@ -3340,10 +3393,10 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 			ret = 0;
 			goto out;
 		}
-#if 0
+
 		ret = regulator_set_voltage_rdev(best_rdev, best_min_uV,
 						 best_max_uV, state);
-#endif
+
 		if (ret < 0)
 			goto out;
 
@@ -3377,12 +3430,12 @@ int regulator_set_voltage(struct regulator *regulator, int min_uV, int max_uV)
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
@@ -3460,12 +3513,12 @@ int regulator_set_suspend_voltage(struct regulator *regulator, int min_uV,
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
@@ -3657,11 +3710,11 @@ int regulator_get_voltage(struct regulator *regulator)
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
2.19.0

