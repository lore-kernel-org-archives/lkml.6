Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87F9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AF1520838
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TwLrJ0KF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF1520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeI0Nor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:44:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40070 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbeI0Noq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:44:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id n31-v6so1260828pgm.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 00:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=MKTJF5NsssoWjmjdLTmPozCalJms9vgpeT61g4PW+qo=;
        b=TwLrJ0KF8B128xtcSM9ysLHWVidRWPbe1vwZboTwrJokhsKWZc6zrL3Zo41Z23iZbO
         1WQpo9AxyFzICIbU4ys/9RH3BqcZZzbjg+OO+69sPGa+/f8eN37DKVuPZ5tpAoYuzAd8
         c0X1k6/c9ERvYGNUlyKxNGmkEh/gNm79N8PoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=MKTJF5NsssoWjmjdLTmPozCalJms9vgpeT61g4PW+qo=;
        b=Z8WNXnI07eynccbxnZ0tCxPm4WRFWOfGyvlZJ2Z1aT0xYyyQj1WH2/lXlI0AJ04Go8
         1YZmTk4TIOu/5u9deO0x825ckzZDNDeSrPuOystMTPPTP9TjEAAATXTXwX6rwtgXiWVp
         5JaB48x43EmW6fT+EJIsT7WgHzCPBtCyb9jmxFLhepn4z2v2Pa2EIgd6MUEDhVDQtBUK
         /xZjURkc87ner0fmd+I5OUklqCrqknmN9cp2+mcfCCsjTe1tL6qeZdw0RPyRWi/ZJSmH
         FoMQzvuRiURydsaJWwOlpOy5xMJ8CRoxv68YV+jylpHEcn28mL9YDrZi2AvU/9wtVwlo
         HQpg==
X-Gm-Message-State: ABuFfoiYE3vpFxfkHk8Aon4SNCHzQ4OzJQlsFvQEA22HEKMCz6UcaiAQ
        e5oZ/1TZITC6w2mnXph9KOinDg==
X-Google-Smtp-Source: ACcGV619uSU4gxCgIMNhduLMcyfTN2ubUtgPbLqRdhcU3R4BZVwJUr4h4Du2+kI0GVzfRK0i4feTKw==
X-Received: by 2002:a63:7744:: with SMTP id s65-v6mr8919317pgc.197.1538033274695;
        Thu, 27 Sep 2018 00:27:54 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h12-v6sm1835018pfo.135.2018.09.27.00.27.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 00:27:53 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: [PATCH v3 2/4] power: supply: core: Introduce properties to present the battery OCV capacity table
Date:   Thu, 27 Sep 2018 15:26:55 +0800
Message-Id: <7dccec1694a05a524710e59a63859974b4cdae89.1538033078.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <2787f18a0366576959557d05112a069dca982269.1538033078.git.baolin.wang@linaro.org>
References: <2787f18a0366576959557d05112a069dca982269.1538033078.git.baolin.wang@linaro.org>
In-Reply-To: <2787f18a0366576959557d05112a069dca982269.1538033078.git.baolin.wang@linaro.org>
References: <2787f18a0366576959557d05112a069dca982269.1538033078.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some battery driver will use the open circuit voltage (OCV) value to look
up the corresponding battery capacity percent in one certain degree Celsius.
Thus this patch provides some battery properties to present the OCV table
temperatures and OCV capacity table values. Moreover it also provides some
helper functions to use the OCV capacity table for users.

Suggested-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes from v2:
 - Use type __be32 to calculate the table length.
 - Update error messages.
 - Add some helper functions.

Changes from v1:
 - New patch in v2.
---
 .../devicetree/bindings/power/supply/battery.txt   |   14 +++
 drivers/power/supply/power_supply_core.c           |  125 +++++++++++++++++++-
 include/linux/power_supply.h                       |   19 +++
 3 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/battery.txt b/Documentation/devicetree/bindings/power/supply/battery.txt
index 938d027..cad38df 100644
--- a/Documentation/devicetree/bindings/power/supply/battery.txt
+++ b/Documentation/devicetree/bindings/power/supply/battery.txt
@@ -23,6 +23,16 @@ Optional Properties:
  - constant-charge-current-max-microamp: maximum constant input current
  - constant-charge-voltage-max-microvolt: maximum constant input voltage
  - factory-internal-resistance-micro-ohms: battery factory internal resistance
+ - ocv-capacity-table-0: An array providing the battery capacity percent
+   with corresponding open circuit voltage (OCV) of the battery, which
+   is used to look up battery capacity according to current OCV value.
+ - ocv-capacity-table-1: Same as ocv-capacity-table-0
+ ......
+ - ocv-capacity-table-n: Same as ocv-capacity-table-0
+ - ocv-capacity-table-temperatures: An array containing the temperature
+   in degree Celsius, for each of the battery capacity lookup table.
+   The first temperature value specifies the OCV table 0, and the second
+   temperature value specifies the OCV table 1, and so on.
 
 Battery properties are named, where possible, for the corresponding
 elements in enum power_supply_property, defined in
@@ -44,6 +54,10 @@ Example:
 		constant-charge-current-max-microamp = <900000>;
 		constant-charge-voltage-max-microvolt = <4200000>;
 		factory-internal-resistance-micro-ohms = <250000>;
+		ocv-capacity-table-temperatures = <(-10) 0 10>;
+		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>, ...;
+		ocv-capacity-table-1 = <4200000 100>, <4185000 95>, <4113000 90>, ...;
+		ocv-capacity-table-2 = <4250000 100>, <4200000 95>, <4185000 90>, ...;
 	};
 
 	charger: charger@11 {
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 307e0995..7b7267c 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -570,7 +570,7 @@ int power_supply_get_battery_info(struct power_supply *psy,
 {
 	struct device_node *battery_np;
 	const char *value;
-	int err;
+	int err, len, index;
 
 	info->energy_full_design_uwh         = -EINVAL;
 	info->charge_full_design_uah         = -EINVAL;
@@ -581,6 +581,12 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	info->constant_charge_voltage_max_uv = -EINVAL;
 	info->factory_internal_resistance_uohm  = -EINVAL;
 
+	for (index = 0; index < POWER_SUPPLY_OCV_TEMP_MAX; index++) {
+		info->ocv_table[index]       = NULL;
+		info->ocv_temp[index]        = -EINVAL;
+		info->ocv_table_size[index]  = -EINVAL;
+	}
+
 	if (!psy->of_node) {
 		dev_warn(&psy->dev, "%s currently only supports devicetree\n",
 			 __func__);
@@ -620,10 +626,127 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	of_property_read_u32(battery_np, "factory-internal-resistance-micro-ohms",
 			     &info->factory_internal_resistance_uohm);
 
+	len = of_property_count_u32_elems(battery_np,
+					  "ocv-capacity-table-temperatures");
+	if (len < 0 && len != -EINVAL) {
+		return len;
+	} else if (len > POWER_SUPPLY_OCV_TEMP_MAX) {
+		dev_err(&psy->dev, "Too many temperature values\n");
+		return -EINVAL;
+	} else if (len > 0) {
+		of_property_read_u32_array(battery_np,
+					   "ocv-capacity-table-temperatures",
+					   info->ocv_temp, len);
+	}
+
+	for (index = 0; index < len; index++) {
+		struct power_supply_battery_ocv_table *table;
+		char *propname;
+		const __be32 *list;
+		int i, tab_len, size;
+
+		propname = kasprintf(GFP_KERNEL, "ocv-capacity-table-%d", index);
+		list = of_get_property(battery_np, propname, &size);
+		if (!list || !size) {
+			dev_err(&psy->dev, "failed to get %s\n", propname);
+			kfree(propname);
+			power_supply_put_battery_info(psy, info);
+			return -EINVAL;
+		}
+
+		kfree(propname);
+		tab_len = size / (2 * sizeof(__be32));
+		info->ocv_table_size[index] = tab_len;
+
+		table = info->ocv_table[index] =
+			devm_kzalloc(&psy->dev, tab_len * sizeof(*table),
+				     GFP_KERNEL);
+		if (!info->ocv_table[index]) {
+			power_supply_put_battery_info(psy, info);
+			return -ENOMEM;
+		}
+
+		for (i = 0; i < tab_len; i++) {
+			table[i].ocv = be32_to_cpu(*list++);
+			table[i].capacity = be32_to_cpu(*list++);
+		}
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(power_supply_get_battery_info);
 
+void power_supply_put_battery_info(struct power_supply *psy,
+				   struct power_supply_battery_info *info)
+{
+	int i;
+
+	for (i = 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++)
+		kfree(info->ocv_table[i]);
+}
+EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
+
+int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table *table,
+				int table_len, int ocv)
+{
+	int i, cap, tmp;
+
+	for (i = 0; i < table_len; i++)
+		if (ocv > table[i].ocv)
+			break;
+
+	if (i > 0 && i < table_len) {
+		tmp = (table[i - 1].capacity - table[i].capacity) *
+			(ocv - table[i].ocv);
+		tmp /= table[i - 1].ocv - table[i].ocv;
+		cap = tmp + table[i].capacity;
+	} else if (i == 0) {
+		cap = table[0].capacity;
+	} else {
+		cap = table[table_len - 1].capacity;
+	}
+
+	return cap;
+}
+EXPORT_SYMBOL_GPL(power_supply_ocv2cap_simple);
+
+struct power_supply_battery_ocv_table *
+power_supply_find_ocv2cap_table(struct power_supply_battery_info *info,
+				int temp, int *table_len)
+{
+	int best_temp_diff = INT_MAX, best_index = 0, temp_diff, i;
+
+	if (!info->ocv_table[0])
+		return NULL;
+
+	for (i = 0; i < POWER_SUPPLY_OCV_TEMP_MAX; i++) {
+		temp_diff = abs(info->ocv_temp[i] - temp);
+
+		if (temp_diff < best_temp_diff) {
+			best_temp_diff = temp_diff;
+			best_index = i;
+		}
+	}
+
+	*table_len = info->ocv_table_size[best_index];
+	return info->ocv_table[best_index];
+}
+EXPORT_SYMBOL_GPL(power_supply_find_ocv2cap_table);
+
+int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,
+				 int ocv, int temp)
+{
+	struct power_supply_battery_ocv_table *table;
+	int table_len;
+
+	table = power_supply_find_ocv2cap_table(info, temp, &table_len);
+	if (!table)
+		return -EINVAL;
+
+	return power_supply_ocv2cap_simple(table, table_len, ocv);
+}
+EXPORT_SYMBOL_GPL(power_supply_batinfo_ocv2cap);
+
 int power_supply_get_property(struct power_supply *psy,
 			    enum power_supply_property psp,
 			    union power_supply_propval *val)
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index d089566..84fe93f 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -309,6 +309,13 @@ struct power_supply_info {
 	int use_for_apm;
 };
 
+struct power_supply_battery_ocv_table {
+	int ocv;	/* microVolts */
+	int capacity;	/* percent */
+};
+
+#define POWER_SUPPLY_OCV_TEMP_MAX 20
+
 /*
  * This is the recommended struct to manage static battery parameters,
  * populated by power_supply_get_battery_info(). Most platform drivers should
@@ -327,6 +334,9 @@ struct power_supply_battery_info {
 	int constant_charge_current_max_ua; /* microAmps */
 	int constant_charge_voltage_max_uv; /* microVolts */
 	int factory_internal_resistance_uohm;   /* microOhms */
+	int ocv_temp[POWER_SUPPLY_OCV_TEMP_MAX];/* celsius */
+	struct power_supply_battery_ocv_table *ocv_table[POWER_SUPPLY_OCV_TEMP_MAX];
+	int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
 };
 
 extern struct atomic_notifier_head power_supply_notifier;
@@ -350,6 +360,15 @@ extern struct power_supply *devm_power_supply_get_by_phandle(
 
 extern int power_supply_get_battery_info(struct power_supply *psy,
 					 struct power_supply_battery_info *info);
+extern void power_supply_put_battery_info(struct power_supply *psy,
+					  struct power_supply_battery_info *info);
+extern int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_table *table,
+				       int table_len, int ocv);
+extern struct power_supply_battery_ocv_table *
+power_supply_find_ocv2cap_table(struct power_supply_battery_info *info,
+				int temp, int *table_len);
+extern int power_supply_batinfo_ocv2cap(struct power_supply_battery_info *info,
+					int ocv, int temp);
 extern void power_supply_changed(struct power_supply *psy);
 extern int power_supply_am_i_supplied(struct power_supply *psy);
 extern int power_supply_set_input_current_limit_from_supplier(
-- 
1.7.9.5

