Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D873C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248DE214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248DE214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeHVO3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:29:47 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39543 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbeHVO3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:29:47 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so1113321lji.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 04:05:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nm+cjGvH3GcfbKN4L3K8/xz2Q52E2KsiK5w4T56I9PM=;
        b=RZpzSY4e22Zkje0DrjkDQkmgTH8mwVXZpL0c3hAihy9I2uOszlyk9g6E9SHuJ3DoMm
         C66OtzORdQ5Wh6Rzn+VYVEAqCbcPLd4LmLr2Cu/WuvYFrZ+581JXk3GdO2+5P0PdiAAV
         40hC+4d/Z83wSdXDVziE52U+9XxPjfr1vTGm/ZzO285kSMXsk/AT75hH/RqW2EyOgbBv
         q18GD+Ne//Kov6WCCwAdd9VKxC4uFRKaQgs+JvAIoZeC3Q29ATrNgQ0V/qzvzI0VMecz
         yyovEmfxpHggiNnpO9UdzN544ez6aGuJVZbBhRFEESakMQkFVoHSkuBMv5w9Nzjbl8Ua
         WFLw==
X-Gm-Message-State: AOUpUlE//NzJ8tXlLRP9UxvXXHvDwWuicp/olKQ2KMUCJi0EKLVbkaWT
        b6C8zytGBYtjfu5E1C3UjJc=
X-Google-Smtp-Source: AA+uWPy/Zo2Ll5BwTZ/+AJ9bQkwzyR2rh8Ka96BWVNvC7c2miFbYPr62X01bwaFKp+zbg+H0nNNUOg==
X-Received: by 2002:a2e:1c4:: with SMTP id f65-v6mr33205130lji.58.1534935918846;
        Wed, 22 Aug 2018 04:05:18 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id p9-v6sm247280ljh.0.2018.08.22.04.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 04:05:18 -0700 (PDT)
Date:   Wed, 22 Aug 2018 14:05:07 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com
Cc:     mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com,
        matti.vaittinen@fi.rohmeurope.com, linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] regulator: Support regulators where voltage ranges are
 selectable
Message-ID: <20180822110507.GA6177@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For example ROHM BD71837 and ROHM BD71847 Power management ICs have
regulators which provide multiple linear ranges. Ranges can be
selected by individual non contagious bit in vsel register. Add
regmap helper functions for selecting ranges.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
For example the BD71847 has BUCK which vsel register consists of bits
[7:6] voltage range selection
[2:0] voltage selection from used range

We can't use table based mapping or linear range mapping and hide
range selection in voltage selection because current table based
mapping or linear range mapping options can't cope with the non
contagious vsel_mask (because that would lead selector to be
greater than n_voltages).

So here idea is to do simple 'selector to range' - mapping by assigning
selector 0 as first selector for first voltage in firsr range and selector
equal to "voltages in first range" as selector for first voltage in
second range etc.

 drivers/regulator/core.c         |   5 +
 drivers/regulator/helpers.c      | 232 +++++++++++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h |  20 +++-
 3 files changed, 256 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index bb1324f93143..be19163048f4 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2783,6 +2783,11 @@ static int regulator_map_voltage(struct regulator_dev *rdev, int min_uV,
 	if (desc->ops->list_voltage == regulator_list_voltage_linear_range)
 		return regulator_map_voltage_linear_range(rdev, min_uV, max_uV);
 
+	if (desc->ops->list_voltage ==
+		regulator_list_voltage_pickable_linear_range)
+		return regulator_map_voltage_pickable_linear_range(rdev,
+							min_uV, max_uV);
+
 	return regulator_map_voltage_iterate(rdev, min_uV, max_uV);
 }
 
diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 2ae7c3ac5940..b55c43d236d0 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -103,6 +103,128 @@ int regulator_disable_regmap(struct regulator_dev *rdev)
 }
 EXPORT_SYMBOL_GPL(regulator_disable_regmap);
 
+static int regulator_range_selector_to_index(struct regulator_dev *rdev,
+					     unsigned int rval)
+{
+	int i;
+
+	if (!rdev->desc->linear_range_selectors)
+		return -EINVAL;
+
+	rval &= rdev->desc->vsel_range_mask;
+
+	for (i = 0; i < rdev->desc->n_linear_ranges; i++) {
+		if (rdev->desc->linear_range_selectors[i] == rval)
+			return i;
+	}
+	return -EINVAL;
+}
+
+/**
+ * regulator_get_voltage_sel_pickable_regmap - pickable range get_voltage_sel
+ *
+ * @rdev: regulator to operate on
+ *
+ * Regulators that use regmap for their register I/O and use pickable
+ * ranges can set the vsel_reg, vsel_mask, vsel_range_reg and vsel_range_mask
+ * fields in their descriptor and then use this as their get_voltage_vsel
+ * operation, saving some code.
+ */
+int regulator_get_voltage_sel_pickable_regmap(struct regulator_dev *rdev)
+{
+	unsigned int r_val;
+	unsigned int range;
+	unsigned int val;
+	int ret, i;
+	unsigned int voltages_in_range = 0;
+
+	if (!rdev->desc->linear_ranges)
+		return -EINVAL;
+
+	ret = regmap_read(rdev->regmap, rdev->desc->vsel_reg, &val);
+	if (ret != 0)
+		return ret;
+
+	ret = regmap_read(rdev->regmap, rdev->desc->vsel_range_reg, &r_val);
+	if (ret != 0)
+		return ret;
+
+	val &= rdev->desc->vsel_mask;
+	val >>= ffs(rdev->desc->vsel_mask) - 1;
+
+	range = regulator_range_selector_to_index(rdev, r_val);
+	if (range < 0)
+		return -EINVAL;
+
+	for (i = 0; i < range; i++)
+		voltages_in_range += (rdev->desc->linear_ranges[i].max_sel -
+				     rdev->desc->linear_ranges[i].min_sel) + 1;
+
+	return val + voltages_in_range;
+}
+EXPORT_SYMBOL_GPL(regulator_get_voltage_sel_pickable_regmap);
+
+/**
+ * regulator_set_voltage_sel_pickable_regmap - pickable range set_voltage_sel
+ *
+ * @rdev: regulator to operate on
+ * @sel: Selector to set
+ *
+ * Regulators that use regmap for their register I/O and use pickable
+ * ranges can set the vsel_reg, vsel_mask, vsel_range_reg and vsel_range_mask
+ * fields in their descriptor and then use this as their set_voltage_vsel
+ * operation, saving some code.
+ */
+int regulator_set_voltage_sel_pickable_regmap(struct regulator_dev *rdev,
+					      unsigned int sel)
+{
+	unsigned int range;
+	int ret, i;
+	unsigned int voltages_in_range = 0;
+
+	for (i = 0; i < rdev->desc->n_linear_ranges; i++) {
+		voltages_in_range = (rdev->desc->linear_ranges[i].max_sel -
+				     rdev->desc->linear_ranges[i].min_sel) + 1;
+		if (sel < voltages_in_range)
+			break;
+		sel -= voltages_in_range;
+	}
+
+	if (i == rdev->desc->n_linear_ranges)
+		return -EINVAL;
+
+	sel <<= ffs(rdev->desc->vsel_mask) - 1;
+	sel += rdev->desc->linear_ranges[i].min_sel;
+
+	range = rdev->desc->linear_range_selectors[i];
+
+	if (rdev->desc->vsel_reg == rdev->desc->vsel_range_reg) {
+		ret = regmap_update_bits(rdev->regmap,
+					 rdev->desc->vsel_reg,
+					 rdev->desc->vsel_range_mask |
+					 rdev->desc->vsel_mask, sel | range);
+	} else {
+		ret = regmap_update_bits(rdev->regmap,
+					 rdev->desc->vsel_range_reg,
+					 rdev->desc->vsel_range_mask, range);
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
+				  rdev->desc->vsel_mask, sel);
+	}
+
+	if (ret)
+		return ret;
+
+	if (rdev->desc->apply_bit)
+		ret = regmap_update_bits(rdev->regmap, rdev->desc->apply_reg,
+					 rdev->desc->apply_bit,
+					 rdev->desc->apply_bit);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regulator_set_voltage_sel_pickable_regmap);
+
 /**
  * regulator_get_voltage_sel_regmap - standard get_voltage_sel for regmap users
  *
@@ -336,6 +458,76 @@ int regulator_map_voltage_linear_range(struct regulator_dev *rdev,
 }
 EXPORT_SYMBOL_GPL(regulator_map_voltage_linear_range);
 
+/**
+ * regulator_map_voltage_pickable_linear_range - map_voltage, pickable ranges
+ *
+ * @rdev: Regulator to operate on
+ * @min_uV: Lower bound for voltage
+ * @max_uV: Upper bound for voltage
+ *
+ * Drivers providing pickable linear_ranges in their descriptor can use
+ * this as their map_voltage() callback.
+ */
+int regulator_map_voltage_pickable_linear_range(struct regulator_dev *rdev,
+						int min_uV, int max_uV)
+{
+	const struct regulator_linear_range *range;
+	int ret = -EINVAL;
+	int voltage, i;
+	unsigned int selector = 0;
+
+	if (!rdev->desc->n_linear_ranges) {
+		BUG_ON(!rdev->desc->n_linear_ranges);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < rdev->desc->n_linear_ranges; i++) {
+		int linear_max_uV;
+
+		range = &rdev->desc->linear_ranges[i];
+		linear_max_uV = range->min_uV +
+			(range->max_sel - range->min_sel) * range->uV_step;
+
+		if (!(min_uV <= linear_max_uV && max_uV >= range->min_uV)) {
+			selector += (range->max_sel - range->min_sel + 1);
+			continue;
+		}
+
+		if (min_uV <= range->min_uV)
+			min_uV = range->min_uV;
+
+		/* range->uV_step == 0 means fixed voltage range */
+		if (range->uV_step == 0) {
+			ret = 0;
+		} else {
+			ret = DIV_ROUND_UP(min_uV - range->min_uV,
+					   range->uV_step);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret += selector;
+
+		voltage = rdev->desc->ops->list_voltage(rdev, ret);
+
+		/*
+		 * Map back into a voltage to verify we're still in bounds.
+		 * We may have overlapping voltage ranges. Hence we don't
+		 * exit but retry until we have checked all ranges.
+		 */
+		if (voltage < min_uV || voltage > max_uV)
+			selector += (range->max_sel - range->min_sel + 1);
+		else
+			break;
+	}
+
+	if (i == rdev->desc->n_linear_ranges)
+		return -EINVAL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(regulator_map_voltage_pickable_linear_range);
+
 /**
  * regulator_list_voltage_linear - List voltages with simple calculation
  *
@@ -360,6 +552,46 @@ int regulator_list_voltage_linear(struct regulator_dev *rdev,
 }
 EXPORT_SYMBOL_GPL(regulator_list_voltage_linear);
 
+/**
+ * regulator_list_voltage_pickable_linear_range - pickable range list voltages
+ *
+ * @rdev: Regulator device
+ * @selector: Selector to convert into a voltage
+ *
+ * list_voltage() operation, intended to be used by drivers utilizing pickable
+ * ranges helpers.
+ */
+int regulator_list_voltage_pickable_linear_range(struct regulator_dev *rdev,
+						 unsigned int selector)
+{
+	const struct regulator_linear_range *range;
+	int i;
+	unsigned int all_sels = 0;
+
+	if (!rdev->desc->n_linear_ranges) {
+		BUG_ON(!rdev->desc->n_linear_ranges);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < rdev->desc->n_linear_ranges; i++) {
+		unsigned int sels_in_range;
+
+		range = &rdev->desc->linear_ranges[i];
+
+		sels_in_range = range->max_sel - range->min_sel;
+
+		if (all_sels + sels_in_range >= selector) {
+			selector -= all_sels;
+			return range->min_uV + (range->uV_step * selector);
+		}
+
+		all_sels += (sels_in_range + 1);
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(regulator_list_voltage_pickable_linear_range);
+
 /**
  * regulator_list_voltage_linear_range - List voltages for linear ranges
  *
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 0fd8fbb74763..a9c030192147 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -271,9 +271,16 @@ enum regulator_type {
  * @ramp_delay: Time to settle down after voltage change (unit: uV/us)
  * @min_dropout_uV: The minimum dropout voltage this regulator can handle
  * @linear_ranges: A constant table of possible voltage ranges.
- * @n_linear_ranges: Number of entries in the @linear_ranges table.
+ * @linear_range_selectors: A constant table of voltage range selectors.
+ *			    If pickable ranges are used each range must
+ *			    have corresponding selector here.
+ * @n_linear_ranges: Number of entries in the @linear_ranges (and in
+ *		     linear_range_selectors if used) table(s).
  * @volt_table: Voltage mapping table (if table based mapping)
  *
+ * @vsel_range_reg: Register for range selector when using pickable ranges
+ *		    and regulator_regmap_X_voltage_X_pickable functions.
+ * @vsel_range_mask: Mask for register bitfield used for range selector
  * @vsel_reg: Register for selector when using regulator_regmap_X_voltage_
  * @vsel_mask: Mask for register bitfield used for selector
  * @csel_reg: Register for TPS65218 LS3 current regulator
@@ -338,10 +345,14 @@ struct regulator_desc {
 	int min_dropout_uV;
 
 	const struct regulator_linear_range *linear_ranges;
+	const unsigned int *linear_range_selectors;
+
 	int n_linear_ranges;
 
 	const unsigned int *volt_table;
 
+	unsigned int vsel_range_reg;
+	unsigned int vsel_range_mask;
 	unsigned int vsel_reg;
 	unsigned int vsel_mask;
 	unsigned int csel_reg;
@@ -498,18 +509,25 @@ int regulator_mode_to_status(unsigned int);
 
 int regulator_list_voltage_linear(struct regulator_dev *rdev,
 				  unsigned int selector);
+int regulator_list_voltage_pickable_linear_range(struct regulator_dev *rdev,
+						   unsigned int selector);
 int regulator_list_voltage_linear_range(struct regulator_dev *rdev,
 					unsigned int selector);
 int regulator_list_voltage_table(struct regulator_dev *rdev,
 				  unsigned int selector);
 int regulator_map_voltage_linear(struct regulator_dev *rdev,
 				  int min_uV, int max_uV);
+int regulator_map_voltage_pickable_linear_range(struct regulator_dev *rdev,
+						  int min_uV, int max_uV);
 int regulator_map_voltage_linear_range(struct regulator_dev *rdev,
 				       int min_uV, int max_uV);
 int regulator_map_voltage_iterate(struct regulator_dev *rdev,
 				  int min_uV, int max_uV);
 int regulator_map_voltage_ascend(struct regulator_dev *rdev,
 				  int min_uV, int max_uV);
+int regulator_get_voltage_sel_pickable_regmap(struct regulator_dev *rdev);
+int regulator_set_voltage_sel_pickable_regmap(struct regulator_dev *rdev,
+						unsigned int sel);
 int regulator_get_voltage_sel_regmap(struct regulator_dev *rdev);
 int regulator_set_voltage_sel_regmap(struct regulator_dev *rdev, unsigned sel);
 int regulator_is_enabled_regmap(struct regulator_dev *rdev);
-- 
2.14.3

