Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A56CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309AD20843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqlbfqTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309AD20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeIZMy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:54:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47099 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeIZMyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:54:25 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so13382645pga.13;
        Tue, 25 Sep 2018 23:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o7s/I/J2d8DTZzq/9p3rNAbym0cArQaKgYfnOK1mWxU=;
        b=mqlbfqTFA95S/qt/wtmsdsNjrAzknlA2IRm6blVfKFcV2NPkw7FwTCBYdf/bk7plfP
         cuJJCJk+kDbxJZiVg68LINRB7y2+VJMeCKFc4f6pyLhZUIulXel+Ig9VMfLeuWEOs0Wu
         N9pJ8bVjucnphERLr2dx9jx2a7YGEphOj8QFoz1j4ma3QMAS+L4iFu6uHfdSPVfSF0LS
         K0ZYVi8TQRj+FJpixOqM0JTo3Yi6xmODqq97Q3kOG26Zrhv4JKOz8HKAla18MG6lS8ri
         lezzdcF9KNGZzD+nk6r8PqXO0G3kLFwU9HGCgTwPmtLzuXgbs4m+bgEPBNPdqsSvoAD5
         BDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o7s/I/J2d8DTZzq/9p3rNAbym0cArQaKgYfnOK1mWxU=;
        b=YpzpgjERn3iLVkwEMRAALyzE5U4NQhFzc3rZuOKFqqeMB4Ow/kby1WhyBVUMu70QDt
         wQczsiaHdiGiMJs2BaqibuA+8bgkQPoU2WyP1XJTv8vUHcLudS3i6jJozNjUkmsm5p+R
         5zJ4ISWzjtYXYNwLvLaBr4ZQYEoEx9T2It+OD40PuZUCVokHJpG68SsxocQBqwfLUJVq
         4tgCB8p53KfwjDpd8moE5Ln11m4ag7rTVbm56tDfpxdDQ+JWGuDDdrnTv1BmvlkfVmRP
         s4qDIMtjhwpNixfoQDuKmApAgemtzqTxYqtaVYxB8uGCzmRKS3wK0l6hp+qMR74NfGCz
         MPyA==
X-Gm-Message-State: ABuFfojWA/A6VYIaU7KVFgehQvAfmf4q7iQKZHEtpuxY1FCuQxPMnYfm
        L87Rj02Jm17U4McSq2WTqgI=
X-Google-Smtp-Source: ACcGV63poHSZWs95//t6Ex2HLHTMcCesbZmHzV4P1/bLmsqKGJMxQtcdJe3gQS4O38KoE7dAfsmMag==
X-Received: by 2002:a62:d286:: with SMTP id c128-v6mr3344146pfg.14.1537944181720;
        Tue, 25 Sep 2018 23:43:01 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 71-v6sm5574861pfx.182.2018.09.25.23.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 23:43:01 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 1/2] hwmon: ina3221: Add power sysfs nodes
Date:   Tue, 25 Sep 2018 23:42:44 -0700
Message-Id: <20180926064245.4091-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926064245.4091-1-nicoleotsuka@gmail.com>
References: <20180926064245.4091-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hwmon sysfs ABI supports powerX_input and powerX_crit. This
can ease user space programs who care more about power in total
than voltage or current individually.

So this patch adds these two sysfs nodes for INA3221 driver.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 Documentation/hwmon/ina3221 |   4 +
 drivers/hwmon/ina3221.c     | 145 ++++++++++++++++++++++++++++++++----
 2 files changed, 133 insertions(+), 16 deletions(-)

diff --git a/Documentation/hwmon/ina3221 b/Documentation/hwmon/ina3221
index 2726038be5bd..6be64b553cd0 100644
--- a/Documentation/hwmon/ina3221
+++ b/Documentation/hwmon/ina3221
@@ -34,3 +34,7 @@ curr[123]_max           Warning alert current(mA) setting, activates the
                           average is above this value.
 curr[123]_max_alarm     Warning alert current limit exceeded
 in[456]_input           Shunt voltage(uV) for channels 1, 2, and 3 respectively
+power[123]_input        Power(uW) measurement channels
+power[123]_crit         Critical alert power(uW) setting, activates the
+                          corresponding alarm when the respective power
+                          is above this value
diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index ce4d1f55e9cd..5890a2da3bfe 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -38,6 +38,8 @@
 #define INA3221_WARN3			0x0c
 #define INA3221_MASK_ENABLE		0x0f
 
+#define INA3221_BUS(x)			(INA3221_BUS1 + ((x) << 1))
+
 #define INA3221_CONFIG_MODE_SHUNT	BIT(1)
 #define INA3221_CONFIG_MODE_BUS		BIT(2)
 #define INA3221_CONFIG_MODE_CONTINUOUS	BIT(3)
@@ -172,43 +174,50 @@ static ssize_t ina3221_show_shunt_voltage(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", voltage_uv);
 }
 
-static ssize_t ina3221_show_current(struct device *dev,
-				    struct device_attribute *attr, char *buf)
+static int __ina3221_show_current(struct ina3221_data *ina,
+				  unsigned int reg, int *current_ma)
 {
-	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
-	struct ina3221_data *ina = dev_get_drvdata(dev);
-	unsigned int reg = sd_attr->index;
 	unsigned int channel = register_channel[reg];
 	struct ina3221_input *input = &ina->inputs[channel];
 	int resistance_uo = input->shunt_resistor;
-	int val, current_ma, voltage_nv, ret;
+	int val, voltage_nv, ret;
 
+	/* Read bus shunt voltage */
 	ret = ina3221_read_value(ina, reg, &val);
 	if (ret)
 		return ret;
+
+	/* LSB (4th bit) is 40 uV (40000 nV) */
 	voltage_nv = val * 40000;
 
-	current_ma = DIV_ROUND_CLOSEST(voltage_nv, resistance_uo);
+	*current_ma = DIV_ROUND_CLOSEST(voltage_nv, resistance_uo);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", current_ma);
+	return 0;
 }
 
-static ssize_t ina3221_set_current(struct device *dev,
-				   struct device_attribute *attr,
-				   const char *buf, size_t count)
+static ssize_t ina3221_show_current(struct device *dev,
+				    struct device_attribute *attr, char *buf)
 {
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int reg = sd_attr->index;
-	unsigned int channel = register_channel[reg];
-	struct ina3221_input *input = &ina->inputs[channel];
-	int resistance_uo = input->shunt_resistor;
-	int val, current_ma, voltage_uv, ret;
+	int current_ma, ret;
 
-	ret = kstrtoint(buf, 0, &current_ma);
+	ret = __ina3221_show_current(ina, reg, &current_ma);
 	if (ret)
 		return ret;
 
+	return snprintf(buf, PAGE_SIZE, "%d\n", current_ma);
+}
+
+static int __ina3221_set_current(struct ina3221_data *ina,
+				 unsigned int reg, int current_ma)
+{
+	unsigned int channel = register_channel[reg];
+	struct ina3221_input *input = &ina->inputs[channel];
+	int resistance_uo = input->shunt_resistor;
+	int val, voltage_uv, ret;
+
 	/* clamp current */
 	current_ma = clamp_val(current_ma,
 			       INT_MIN / resistance_uo,
@@ -226,6 +235,26 @@ static ssize_t ina3221_set_current(struct device *dev,
 	if (ret)
 		return ret;
 
+	return 0;
+}
+
+static ssize_t ina3221_set_current(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	unsigned int reg = sd_attr->index;
+	int current_ma, ret;
+
+	ret = kstrtoint(buf, 0, &current_ma);
+	if (ret)
+		return ret;
+
+	ret = __ina3221_set_current(ina, reg, current_ma);
+	if (ret)
+		return ret;
+
 	return count;
 }
 
@@ -278,6 +307,68 @@ static ssize_t ina3221_show_alert(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", regval);
 }
 
+static ssize_t ina3221_show_power(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	unsigned int reg = sd_attr->index;
+	unsigned int channel = register_channel[reg];
+	unsigned int reg_bus = INA3221_BUS(channel);
+	int val, current_ma, voltage_mv, ret;
+	s64 power_uw;
+
+	/* Read bus voltage */
+	ret = ina3221_read_value(ina, reg_bus, &val);
+	if (ret)
+		return ret;
+
+	/* LSB (4th bit) is 8 mV */
+	voltage_mv = val * 8;
+
+	/* Read calculated current */
+	ret = __ina3221_show_current(ina, reg, &current_ma);
+	if (ret)
+		return ret;
+
+	power_uw = (s64)voltage_mv * current_ma;
+
+	return snprintf(buf, PAGE_SIZE, "%lld\n", power_uw);
+}
+
+static ssize_t ina3221_set_power(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	unsigned int reg = sd_attr->index;
+	unsigned int channel = register_channel[reg];
+	unsigned int reg_bus = INA3221_BUS(channel);
+	int val, current_ma, voltage_mv, ret;
+	s64 power_uw;
+
+	ret = kstrtos64(buf, 0, &power_uw);
+	if (ret)
+		return ret;
+
+	/* Read bus voltage */
+	ret = ina3221_read_value(ina, reg_bus, &val);
+	if (ret)
+		return ret;
+
+	/* LSB (4th bit) is 8 mV */
+	voltage_mv = val * 8;
+
+	current_ma = DIV_ROUND_CLOSEST(power_uw, voltage_mv);
+
+	ret = __ina3221_set_current(ina, reg, current_ma);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 /* input channel label */
 static SENSOR_DEVICE_ATTR(in1_label, 0444,
 		ina3221_show_label, NULL, INA3221_CHANNEL1);
@@ -350,6 +441,22 @@ static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO,
 static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO,
 		ina3221_show_shunt_voltage, NULL, INA3221_SHUNT3);
 
+/* calculated power */
+static SENSOR_DEVICE_ATTR(power1_input, 0444,
+		ina3221_show_power, NULL, INA3221_SHUNT1);
+static SENSOR_DEVICE_ATTR(power2_input, 0444,
+		ina3221_show_power, NULL, INA3221_SHUNT2);
+static SENSOR_DEVICE_ATTR(power3_input, 0444,
+		ina3221_show_power, NULL, INA3221_SHUNT3);
+
+/* critical power */
+static SENSOR_DEVICE_ATTR(power1_crit, 0644,
+		ina3221_show_power, ina3221_set_power, INA3221_CRIT1);
+static SENSOR_DEVICE_ATTR(power2_crit, 0644,
+		ina3221_show_power, ina3221_set_power, INA3221_CRIT2);
+static SENSOR_DEVICE_ATTR(power3_crit, 0644,
+		ina3221_show_power, ina3221_set_power, INA3221_CRIT3);
+
 static struct attribute *ina3221_attrs[] = {
 	/* channel 1 -- make sure label at first */
 	&sensor_dev_attr_in1_label.dev_attr.attr,
@@ -361,6 +468,8 @@ static struct attribute *ina3221_attrs[] = {
 	&sensor_dev_attr_curr1_max.dev_attr.attr,
 	&sensor_dev_attr_curr1_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_power1_input.dev_attr.attr,
+	&sensor_dev_attr_power1_crit.dev_attr.attr,
 
 	/* channel 2 -- make sure label at first */
 	&sensor_dev_attr_in2_label.dev_attr.attr,
@@ -372,6 +481,8 @@ static struct attribute *ina3221_attrs[] = {
 	&sensor_dev_attr_curr2_max.dev_attr.attr,
 	&sensor_dev_attr_curr2_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_power2_input.dev_attr.attr,
+	&sensor_dev_attr_power2_crit.dev_attr.attr,
 
 	/* channel 3 -- make sure label at first */
 	&sensor_dev_attr_in3_label.dev_attr.attr,
@@ -383,6 +494,8 @@ static struct attribute *ina3221_attrs[] = {
 	&sensor_dev_attr_curr3_max.dev_attr.attr,
 	&sensor_dev_attr_curr3_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_in6_input.dev_attr.attr,
+	&sensor_dev_attr_power3_input.dev_attr.attr,
+	&sensor_dev_attr_power3_crit.dev_attr.attr,
 
 	NULL,
 };
-- 
2.17.1

