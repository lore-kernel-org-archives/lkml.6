Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB25ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36BB21479
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 10:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HofzYi17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36BB21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeJSS7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 14:59:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38106 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727243AbeJSS7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 14:59:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id f8-v6so15616451pgq.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 03:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=p6TlAN3GTA2O6epc7Pk4ZVf3tcYffw0peZEOU8J4CQY=;
        b=HofzYi17kZQEvO7dVoZkzmqbZ7LmHhfp/AriMH7A5Lwv9BORkx6lqoGusD7pbcnjNE
         7QHniuAYV+BEYSfBYeiFN4mVT05bvOXCo3v9lL2rbXLKo5QezombFAhmEfv4mTQOpCEe
         lncWmcT5wewPnDMOb0yHRpTUbvVW4NWXP4L1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=p6TlAN3GTA2O6epc7Pk4ZVf3tcYffw0peZEOU8J4CQY=;
        b=nQ6n9y1qKxztfhT0vsNw2DDnODfGteugNOq9XNXpqaW5hjbfopG+ZAluabtiWuDp+X
         u0D0UrrtySYoPDlU5mXg8KZ6GUtNwL2mTpYRRNKYdMFfpMBLgb7jeUFiqckYfPoXGTta
         OfoQfnu+J7PoHpvvit48xv3MU51nRzX1Cilc925gx+ZBGyal03Kdax5RHqQH82xOP+C4
         IbeDxCTM1Q62s+qJkBb3CAjKe0tJfgk06kiJxh5VLCTfzl1t1kq5meKa7c6dayGuapLO
         xqNAd57+V3EsvvxXtFBnjvZ0Imp+fPq/1ui79p+Bq2Oqt+7oiYxnbALf7v8/kMdvMDM1
         9E5g==
X-Gm-Message-State: ABuFfohhUl8nDaG93OAMhsPSxi4ZMtRJvKZ304MYh6JZxJnccBNfE+Fs
        E3KUrS3uF4qqlBtApg1GIZ23hA==
X-Google-Smtp-Source: ACcGV61ru+3mRoLSsbAYMGKeNMqsbCJO6/uvdAXcP7sQm7sVjLdrXQIyqKEGj2bbI/2es36T9Sv/Kw==
X-Received: by 2002:aa7:88c2:: with SMTP id p2-v6mr26545651pfo.32.1539946424585;
        Fri, 19 Oct 2018 03:53:44 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id m67-v6sm54918pfm.13.2018.10.19.03.53.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 03:53:43 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org, ctatlor97@gmail.com,
        linus.walleij@linaro.org
Subject: [PATCH v5 4/6] power: supply: core: Add some helpers to use the battery OCV capacity table
Date:   Fri, 19 Oct 2018 18:53:13 +0800
Message-Id: <f1529c567a340e4d31354a4b117954eeebf89942.1539915051.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
In-Reply-To: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1539915051.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have introduced some battery properties to present the OCV table
temperatures and OCV capacity table values. Thus this patch add OCV
temperature and OCV table for battery information, as well as providing
some helper functions to use the OCV capacity table for users.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes from v4:
 - None.

Changes from v3:
 - Split core modification into one separate patch.
 - Rename ocv-capacity-table-temperatures to ocv-capacity-celsius.

Changes from v2:
 - Use type __be32 to calculate the table length.
 - Update error messages.
 - Add some helper functions.

Changes from v1:
 - New patch in v2.
---
 drivers/power/supply/power_supply_core.c |  123 +++++++++++++++++++++++++++++-
 include/linux/power_supply.h             |   19 +++++
 2 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 307e0995..58c4309 100644
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
@@ -620,10 +626,125 @@ int power_supply_get_battery_info(struct power_supply *psy,
 	of_property_read_u32(battery_np, "factory-internal-resistance-micro-ohms",
 			     &info->factory_internal_resistance_uohm);
 
+	len = of_property_count_u32_elems(battery_np, "ocv-capacity-celsius");
+	if (len < 0 && len != -EINVAL) {
+		return len;
+	} else if (len > POWER_SUPPLY_OCV_TEMP_MAX) {
+		dev_err(&psy->dev, "Too many temperature values\n");
+		return -EINVAL;
+	} else if (len > 0) {
+		of_property_read_u32_array(battery_np, "ocv-capacity-celsius",
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

