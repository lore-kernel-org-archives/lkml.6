Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11D1C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643722146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XpRbVs3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643722146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbeLFDVF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:21:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34948 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbeLFDVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:21:04 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so11090934plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 19:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=h2KSnIAlk7pCL7epeA9wqI/dn+NWpdOYjtJjFjbxWQo=;
        b=XpRbVs3IwSfy9RQTl+eNF/lJWAP/7YeOnmSw84XAvkd2MWrmJKKUlbR6kuGZUj/TvC
         GAUG4e0bhePhZyUVCCUBVeIUKnB3CkrHs5wx3NDoD+pYAJocx0w/Ro5BcO/LpGPQ6jos
         OkDyRvRxndUQHno+0XK8xP2TFjEwQpdgF4bC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h2KSnIAlk7pCL7epeA9wqI/dn+NWpdOYjtJjFjbxWQo=;
        b=feYKujXtcugxQAbVQUeBPxmkx3YDc0LBlHCjNSmQRdi8Nm2DGdJ3CY47vOY/uUmzjM
         8V97nu3UFL3t1Dhz/MgpR9oqDIY8lZGHC1it9rCHyzw+kBzrRpQpLwkp5/QJRICncQsH
         LtNAxnrLH2/o+JFfS8FdbntKJtQqgRO1NtU1o54DCrbHf88RcU4Pbc1DJJ0uc4Q1GVYr
         ZOoZ0EkUH09uOC1lE+BsyzAMr2GiDRpQMllGCezKeD9P81DrVKROS/Zj4qC1PY9zfL2I
         FYiMMsE7fhf4KjSOdtqkezFrJAOJ8Nfa5uJfOTKmMQV61tpkW3PVqIrANaWxI6a2/kNN
         4J1w==
X-Gm-Message-State: AA+aEWag2AQ4kScSGwJhQEeASGeXAYzKQIShgWN09JrZKR2EhBamoIiv
        QJHB32sq+JO4ThSwbaLMIhtfyA==
X-Google-Smtp-Source: AFSGD/UVB7Fkxkz13X7TagQRFwNgXXeVJWh/vRCJmBjdw3++QlShsoJvyUwawUWg7DmOmjHwKW7wbg==
X-Received: by 2002:a17:902:5a86:: with SMTP id r6mr25635770pli.301.1544066463875;
        Wed, 05 Dec 2018 19:21:03 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id o189sm33258819pfg.117.2018.12.05.19.21.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 19:21:02 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, baolin.wang@linaro.org,
        broonie@kernel.org, pavel@ucw.cz
Subject: [PATCH v2] power: supply: sc27xx: Save last battery capacity
Date:   Thu,  6 Dec 2018 11:20:39 +0800
Message-Id: <271ebbae85bc544cbcb6925a10de30267f8eb3ee.1544066225.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuanjiang Yu <yuanjiang.yu@unisoc.com>

Our charger manager can optimize the battery capacity periodically, so
we can save last battery capacity into registers. Then next system
power-on, we can read the last saved battery capacity as the initial
battery capacity, which can make the battery capacity more accurate.

Signed-off-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Simplify the logics for sc27xx_fgu_set_property() and
   sc27xx_fgu_property_is_writeable().
---
 drivers/power/supply/sc27xx_fuel_gauge.c |  135 +++++++++++++++++++++++++++++-
 1 file changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 8c52e29..76da189 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -39,6 +39,9 @@
 #define SC27XX_FGU_CLBCNT_VALH		0x68
 #define SC27XX_FGU_CLBCNT_VALL		0x6c
 #define SC27XX_FGU_CLBCNT_QMAXL		0x74
+#define SC27XX_FGU_USER_AREA_SET	0xa0
+#define SC27XX_FGU_USER_AREA_CLEAR	0xa4
+#define SC27XX_FGU_USER_AREA_STATUS	0xa8
 
 #define SC27XX_WRITE_SELCLB_EN		BIT(0)
 #define SC27XX_FGU_CLBCNT_MASK		GENMASK(15, 0)
@@ -49,6 +52,14 @@
 #define SC27XX_FGU_LOW_OVERLOAD_INT	BIT(0)
 #define SC27XX_FGU_CLBCNT_DELTA_INT	BIT(2)
 
+#define SC27XX_FGU_MODE_AREA_MASK	GENMASK(15, 12)
+#define SC27XX_FGU_CAP_AREA_MASK	GENMASK(11, 0)
+#define SC27XX_FGU_MODE_AREA_SHIFT	12
+
+#define SC27XX_FGU_FIRST_POWERTON	GENMASK(3, 0)
+#define SC27XX_FGU_DEFAULT_CAP		GENMASK(11, 0)
+#define SC27XX_FGU_NORMAIL_POWERTON	0x5
+
 #define SC27XX_FGU_CUR_BASIC_ADC	8192
 #define SC27XX_FGU_SAMPLE_HZ		2
 
@@ -119,6 +130,80 @@ static int sc27xx_fgu_voltage_to_adc(struct sc27xx_fgu_data *data, int vol)
 	return DIV_ROUND_CLOSEST(vol * data->vol_1000mv_adc, 1000);
 }
 
+static bool sc27xx_fgu_is_first_poweron(struct sc27xx_fgu_data *data)
+{
+	int ret, status, cap, mode;
+
+	ret = regmap_read(data->regmap,
+			  data->base + SC27XX_FGU_USER_AREA_STATUS, &status);
+	if (ret)
+		return false;
+
+	/*
+	 * We use low 4 bits to save the last battery capacity and high 12 bits
+	 * to save the system boot mode.
+	 */
+	mode = (status & SC27XX_FGU_MODE_AREA_MASK) >> SC27XX_FGU_MODE_AREA_SHIFT;
+	cap = status & SC27XX_FGU_CAP_AREA_MASK;
+
+	/*
+	 * When FGU has been powered down, the user area registers became
+	 * default value (0xffff), which can be used to valid if the system is
+	 * first power on or not.
+	 */
+	if (mode == SC27XX_FGU_FIRST_POWERTON || cap == SC27XX_FGU_DEFAULT_CAP)
+		return true;
+
+	return false;
+}
+
+static int sc27xx_fgu_save_boot_mode(struct sc27xx_fgu_data *data,
+				     int boot_mode)
+{
+	int ret;
+
+	ret = regmap_update_bits(data->regmap,
+				 data->base + SC27XX_FGU_USER_AREA_CLEAR,
+				 SC27XX_FGU_MODE_AREA_MASK,
+				 SC27XX_FGU_MODE_AREA_MASK);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap,
+				  data->base + SC27XX_FGU_USER_AREA_SET,
+				  SC27XX_FGU_MODE_AREA_MASK,
+				  boot_mode << SC27XX_FGU_MODE_AREA_SHIFT);
+}
+
+static int sc27xx_fgu_save_last_cap(struct sc27xx_fgu_data *data, int cap)
+{
+	int ret;
+
+	ret = regmap_update_bits(data->regmap,
+				 data->base + SC27XX_FGU_USER_AREA_CLEAR,
+				 SC27XX_FGU_CAP_AREA_MASK,
+				 SC27XX_FGU_CAP_AREA_MASK);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap,
+				  data->base + SC27XX_FGU_USER_AREA_SET,
+				  SC27XX_FGU_CAP_AREA_MASK, cap);
+}
+
+static int sc27xx_fgu_read_last_cap(struct sc27xx_fgu_data *data, int *cap)
+{
+	int ret, value;
+
+	ret = regmap_read(data->regmap,
+			  data->base + SC27XX_FGU_USER_AREA_STATUS, &value);
+	if (ret)
+		return ret;
+
+	*cap = value & SC27XX_FGU_CAP_AREA_MASK;
+	return 0;
+}
+
 /*
  * When system boots on, we can not read battery capacity from coulomb
  * registers, since now the coulomb registers are invalid. So we should
@@ -128,6 +213,20 @@ static int sc27xx_fgu_voltage_to_adc(struct sc27xx_fgu_data *data, int vol)
 static int sc27xx_fgu_get_boot_capacity(struct sc27xx_fgu_data *data, int *cap)
 {
 	int volt, cur, oci, ocv, ret;
+	bool is_first_poweron = sc27xx_fgu_is_first_poweron(data);
+
+	/*
+	 * If system is not the first power on, we should use the last saved
+	 * battery capacity as the initial battery capacity. Otherwise we should
+	 * re-calculate the initial battery capacity.
+	 */
+	if (!is_first_poweron) {
+		ret = sc27xx_fgu_read_last_cap(data, cap);
+		if (ret)
+			return ret;
+
+		return sc27xx_fgu_save_boot_mode(data, SC27XX_FGU_NORMAIL_POWERTON);
+	}
 
 	/*
 	 * After system booting on, the SC27XX_FGU_CLBCNT_QMAXL register saved
@@ -160,7 +259,11 @@ static int sc27xx_fgu_get_boot_capacity(struct sc27xx_fgu_data *data, int *cap)
 	*cap = power_supply_ocv2cap_simple(data->cap_table, data->table_len,
 					   ocv);
 
-	return 0;
+	ret = sc27xx_fgu_save_last_cap(data, *cap);
+	if (ret)
+		return ret;
+
+	return sc27xx_fgu_save_boot_mode(data, SC27XX_FGU_NORMAIL_POWERTON);
 }
 
 static int sc27xx_fgu_set_clbcnt(struct sc27xx_fgu_data *data, int clbcnt)
@@ -418,6 +521,28 @@ static int sc27xx_fgu_get_property(struct power_supply *psy,
 	return ret;
 }
 
+static int sc27xx_fgu_set_property(struct power_supply *psy,
+				   enum power_supply_property psp,
+				   const union power_supply_propval *val)
+{
+	struct sc27xx_fgu_data *data = power_supply_get_drvdata(psy);
+	int ret;
+
+	if (psp != POWER_SUPPLY_PROP_CAPACITY)
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+
+	ret = sc27xx_fgu_save_last_cap(data, val->intval);
+
+	mutex_unlock(&data->lock);
+
+	if (ret < 0)
+		dev_err(data->dev, "failed to save battery capacity\n");
+
+	return ret;
+}
+
 static void sc27xx_fgu_external_power_changed(struct power_supply *psy)
 {
 	struct sc27xx_fgu_data *data = power_supply_get_drvdata(psy);
@@ -425,6 +550,12 @@ static void sc27xx_fgu_external_power_changed(struct power_supply *psy)
 	power_supply_changed(data->battery);
 }
 
+static int sc27xx_fgu_property_is_writeable(struct power_supply *psy,
+					    enum power_supply_property psp)
+{
+	return psp == POWER_SUPPLY_PROP_CAPACITY;
+}
+
 static enum power_supply_property sc27xx_fgu_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_HEALTH,
@@ -444,7 +575,9 @@ static void sc27xx_fgu_external_power_changed(struct power_supply *psy)
 	.properties		= sc27xx_fgu_props,
 	.num_properties		= ARRAY_SIZE(sc27xx_fgu_props),
 	.get_property		= sc27xx_fgu_get_property,
+	.set_property		= sc27xx_fgu_set_property,
 	.external_power_changed	= sc27xx_fgu_external_power_changed,
+	.property_is_writeable	= sc27xx_fgu_property_is_writeable,
 };
 
 static void sc27xx_fgu_adjust_cap(struct sc27xx_fgu_data *data, int cap)
-- 
1.7.9.5

