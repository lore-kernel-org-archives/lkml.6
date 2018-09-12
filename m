Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F7FC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228AF2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228AF2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeILQzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 12:55:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44801 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbeILQzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 12:55:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id g6-v6so1394649lfb.11;
        Wed, 12 Sep 2018 04:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=05EA8QTt/58+Fvd/V7F9qvQUwtbuaOjF4e31NaPjYEA=;
        b=opvqlk/CBCejjRYJaJ4BvLgXcosYfith3rbJAJBB96I8PN2Z/NJkXsv7TD+EwhS5Om
         J7VS8Sslq4zHsDJN8TJ8S4U1N+Gik5GR3TIZNRkmM1NF+JK8/LJlPuCcUFpEdkiAXf7t
         Gj5RhptNK+WrfWzg/4eggcG6b2dRAj386pxhjNGIyyf+S959PbLhjF/SuwRkyvRTsYdu
         WezcWwaA6wY8j6L6540gZql8op0IM9K+nBfDQBtIj4lFEI+2Le7yuRLCKy1qNv4sPrRB
         5qFMPJC3Nv0NxwcC/jfKu8K6E/FwRnUo9lWTV2ckZ6VdhznrmW2AoQ3HTC7iQNIiNB3d
         6AIw==
X-Gm-Message-State: APzg51D9syz+kQGjY35LCnI2RRrL53xFYYzOrS2+ZYBNapbBwZ5K1CwS
        83EIWVAONveVCOwMtvrMC+0=
X-Google-Smtp-Source: ANB0VdZAmI7ntGbgcWqYs3KsCUqTDVfbqLqnY5DUHRpct9DVLMVQO97WDvHkFSp+6w3lfPpxjsh9JA==
X-Received: by 2002:a19:73c5:: with SMTP id h66-v6mr1251498lfk.22.1536753056776;
        Wed, 12 Sep 2018 04:50:56 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g133-v6sm146425lfg.81.2018.09.12.04.50.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 04:50:56 -0700 (PDT)
Date:   Wed, 12 Sep 2018 14:50:41 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, mazziesaccount@gmail.com,
        matti.vaittinen@fi.rohmeurope.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        sboyd@kernel.org
Subject: [PATCH v2 4/7] regulator: Support regulators where voltage ranges
 are selectable
Message-ID: <3714c1b58d90b188abd1de2bb4e58a9e5ad3bd9b.1536750863.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1536750863.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1536750863.git.matti.vaittinen@fi.rohmeurope.com>
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
 drivers/regulator/core.c         |   5 +
 drivers/regulator/helpers.c      | 232 +++++++++++++++++++++++++++++++++++++++
 include/linux/regulator/driver.h |  20 +++-
 3 files changed, 256 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5f2218c67edf..b836a129288a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2788,6 +2788,11 @@ static int regulator_map_voltage(struct regulator_dev *rdev, int min_uV,
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
index ef09021dc46e..5686a1335bd3 100644
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
+	int range;
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
@@ -337,6 +459,76 @@ int regulator_map_voltage_linear_range(struct regulator_dev *rdev,
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
@@ -361,6 +553,46 @@ int regulator_list_voltage_linear(struct regulator_dev *rdev,
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

