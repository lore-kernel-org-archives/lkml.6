Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BCDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2555F2159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+hLIrjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2555F2159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbeI1DO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:14:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45332 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1DO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:14:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id a23-v6so2701514pfi.12;
        Thu, 27 Sep 2018 13:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZZf+19amkxO0pvg7G7Zq6Lg+mCp1ZDrZlGUzoQb4Z10=;
        b=B+hLIrjp+Bgvg12NNgefT5og547MeczlIQ4J5vAK0V5BEdcYUv5C2Cto0wwtIXlYg7
         Nu5Aau0o5U3BYiaLMbBNfq/HhwZ3HqRtb4XEwfrBlOFAMmIjMFAAvPzRFRuCBABu2tgN
         itUb8XDOyCKmqKu8B1RE/fM32N9qx+n/QgFXHHlPrS4NYdJa6B/Jc17+VzzAgFW+ZoxE
         CqRf2j9Y5bsLKD9OSTwsC0VEHyo2zy9l3QRVbJn5oTnLOmIfOaSczlE7zZfBUBAHfgnz
         gVII3WbDCmwV2MQkvobcTWcX7KOTsgO4F6V8qiK1pryjWV603moDyfdMi44DdB0PKqCK
         pG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZZf+19amkxO0pvg7G7Zq6Lg+mCp1ZDrZlGUzoQb4Z10=;
        b=gHMMzjbNUUUIAlcLr2jGPwltqUhXPGdkFIEJsTgye8yAmCa/TrOvLmTauNfevgBkre
         8LoQ/LRT8TGJLedb//2tOYap31p38VRPgIRCndpusS3RalcZyu6BoNNBoHC8hFkpdupr
         EX0ZsB886HzvS1AqJx4fSjV79VQ/CxwUUGPwWZJ55jlOL2TXtnX5WAjTG5u3v64RtKQw
         qykE8fhpWlLyqz5fzbA8cZ39g4IYeEfsG6BQQLHh9FMqxtQ0/huohOjruAosXBnVJ4FP
         3RSr6dAgZCuQ+V42EdC/kS33UhOGL67O3SKpu8dttfslqCuVJc6EUQy9Lu67rR42NK2q
         4pFg==
X-Gm-Message-State: ABuFfogoQbaVMcL+E4Hw/XL8zbOU4wsMlZgO0iaQGkXRJRUfNIHHwfml
        OnwH1K6wYYtsDnxFVL8LMd0=
X-Google-Smtp-Source: ACcGV619AMCBfeZd+wxsZRznuapKLF/GuTuYfRvU4wRUXd3XyJduahwCGk8Gds9C4y5HpBnezcIX1Q==
X-Received: by 2002:a17:902:3183:: with SMTP id x3-v6mr230071plb.105.1538081655669;
        Thu, 27 Sep 2018 13:54:15 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id v26-v6sm4354101pfe.57.2018.09.27.13.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:54:14 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v7 2/2] hwmon: ina3221: Read channel input source info from DT
Date:   Thu, 27 Sep 2018 13:54:06 -0700
Message-Id: <20180927205406.21932-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927205406.21932-1-nicoleotsuka@gmail.com>
References: <20180927205406.21932-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An ina3221 chip has three input ports. Each port is used
to measure the voltage and current of its input source.

The DT binding now has defined bindings for their input
sources, so the driver should read these information and
handle accordingly.

This patch adds a new structure of input source specific
information including input source label, shunt resistor
value and its connection status. It exposes these labels
via in[123]_label sysfs nodes upon available, and also
disables those channels where there are no input source
being connected. Meanwhile, it also adds in[123]_enable
sysfs nodes for users to get control of three channels,
and returns -ENODATA code for any sensor read according
to hwmon ABI.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v6->v7:
 * N/A
v5->v6:
 * Removed the code of hiding disconnected channels
 * Added in[123]_label sysfs nodes to control channels
 * Added -ENODATA return for sensor read at disabled channels
v4->v5:
 * Replaced "shunt-resistor" with "shunt-resistor-micro-ohms"
 * Replaced "input-label" with "label"
 * Replaced "input-id" with "reg"
 * Simplified is_visible() by using index of the attr
 * Moved inX_label to index-0 and added comments for safety
v3->v4:
 * Added is_visible callback function to hide sysfs nodes
v2->v3:
 * N/A
v1->v2:
 * Added a structure for input source corresponding to DT bindings
 * Moved shunt resistor value to the structure
 * Defined in[123]_label sysfs nodes instead of name[123]_input
 * Updated probe() function to get information from DT
 * Updated ina3221 hwmon documentation for the labels
 * Dropped dynamical group definition to keep all groups as they were

 Documentation/hwmon/ina3221 |   2 +
 drivers/hwmon/ina3221.c     | 237 +++++++++++++++++++++++++++++++++---
 2 files changed, 225 insertions(+), 14 deletions(-)

diff --git a/Documentation/hwmon/ina3221 b/Documentation/hwmon/ina3221
index 0ff74854cb2e..4b82cbfb551c 100644
--- a/Documentation/hwmon/ina3221
+++ b/Documentation/hwmon/ina3221
@@ -21,6 +21,8 @@ and power are calculated host-side from these.
 Sysfs entries
 -------------
 
+in[123]_label           Voltage channel labels
+in[123]_enable          Voltage channel enable controls
 in[123]_input           Bus voltage(mV) channels
 curr[123]_input         Current(mA) measurement channels
 shunt[123]_resistor     Shunt resistance(uOhm) channels
diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index e6b49500c52a..5c16d78e7482 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -41,6 +41,7 @@
 #define INA3221_CONFIG_MODE_SHUNT	BIT(1)
 #define INA3221_CONFIG_MODE_BUS		BIT(2)
 #define INA3221_CONFIG_MODE_CONTINUOUS	BIT(3)
+#define INA3221_CONFIG_CHx_EN(x)	BIT(14 - (x))
 
 #define INA3221_RSHUNT_DEFAULT		10000
 
@@ -75,6 +76,9 @@ enum ina3221_channels {
 };
 
 static const unsigned int register_channel[] = {
+	[INA3221_BUS1] = INA3221_CHANNEL1,
+	[INA3221_BUS2] = INA3221_CHANNEL2,
+	[INA3221_BUS3] = INA3221_CHANNEL3,
 	[INA3221_SHUNT1] = INA3221_CHANNEL1,
 	[INA3221_SHUNT2] = INA3221_CHANNEL2,
 	[INA3221_SHUNT3] = INA3221_CHANNEL3,
@@ -86,18 +90,93 @@ static const unsigned int register_channel[] = {
 	[INA3221_WARN3] = INA3221_CHANNEL3,
 };
 
+/**
+ * struct ina3221_input - channel input source specific information
+ * @label: label of channel input source
+ * @shunt_resistor: shunt resistor value of channel input source
+ * @disconnected: connection status of channel input source
+ */
+struct ina3221_input {
+	const char *label;
+	int shunt_resistor;
+	bool disconnected;
+};
+
 /**
  * struct ina3221_data - device specific information
  * @regmap: Register map of the device
  * @fields: Register fields of the device
- * @shunt_resistors: Array of resistor values per channel
+ * @inputs: Array of channel input source specific structures
  */
 struct ina3221_data {
 	struct regmap *regmap;
 	struct regmap_field *fields[F_MAX_FIELDS];
-	int shunt_resistors[INA3221_NUM_CHANNELS];
+	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
 };
 
+static inline bool ina3221_is_enable(struct ina3221_data *ina, int channel)
+{
+	unsigned int config;
+	int ret;
+
+	/* Return false to reject further read */
+	ret = regmap_read(ina->regmap, INA3221_CONFIG, &config);
+	if (ret)
+		return false;
+
+	return (config & INA3221_CONFIG_CHx_EN(channel)) > 0;
+}
+
+static ssize_t ina3221_show_label(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	unsigned int channel = sd_attr->index;
+	struct ina3221_input *input = &ina->inputs[channel];
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", input->label);
+}
+
+static ssize_t ina3221_show_enable(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	unsigned int channel = sd_attr->index;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			ina3221_is_enable(ina, channel));
+}
+
+static ssize_t ina3221_set_enable(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	unsigned int channel = sd_attr->index;
+	unsigned int mask = INA3221_CONFIG_CHx_EN(channel);
+	unsigned int config;
+	int val, ret;
+
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+
+	/* inX_enable only accepts 1 for enabling or 0 for disabling */
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	config = val ? mask : 0;
+
+	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, config);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
 			      int *val)
 {
@@ -120,8 +199,13 @@ static ssize_t ina3221_show_bus_voltage(struct device *dev,
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int reg = sd_attr->index;
+	unsigned int channel = register_channel[reg];
 	int val, voltage_mv, ret;
 
+	/* No data for read-only attribute if channel is disabled */
+	if (!attr->store && !ina3221_is_enable(ina, channel))
+		return -ENODATA;
+
 	ret = ina3221_read_value(ina, reg, &val);
 	if (ret)
 		return ret;
@@ -138,8 +222,13 @@ static ssize_t ina3221_show_shunt_voltage(struct device *dev,
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int reg = sd_attr->index;
+	unsigned int channel = register_channel[reg];
 	int val, voltage_uv, ret;
 
+	/* No data for read-only attribute if channel is disabled */
+	if (!attr->store && !ina3221_is_enable(ina, channel))
+		return -ENODATA;
+
 	ret = ina3221_read_value(ina, reg, &val);
 	if (ret)
 		return ret;
@@ -155,9 +244,14 @@ static ssize_t ina3221_show_current(struct device *dev,
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int reg = sd_attr->index;
 	unsigned int channel = register_channel[reg];
-	int resistance_uo = ina->shunt_resistors[channel];
+	struct ina3221_input *input = &ina->inputs[channel];
+	int resistance_uo = input->shunt_resistor;
 	int val, current_ma, voltage_nv, ret;
 
+	/* No data for read-only attribute if channel is disabled */
+	if (!attr->store && !ina3221_is_enable(ina, channel))
+		return -ENODATA;
+
 	ret = ina3221_read_value(ina, reg, &val);
 	if (ret)
 		return ret;
@@ -176,7 +270,8 @@ static ssize_t ina3221_set_current(struct device *dev,
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int reg = sd_attr->index;
 	unsigned int channel = register_channel[reg];
-	int resistance_uo = ina->shunt_resistors[channel];
+	struct ina3221_input *input = &ina->inputs[channel];
+	int resistance_uo = input->shunt_resistor;
 	int val, current_ma, voltage_uv, ret;
 
 	ret = kstrtoint(buf, 0, &current_ma);
@@ -209,11 +304,9 @@ static ssize_t ina3221_show_shunt(struct device *dev,
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int channel = sd_attr->index;
-	unsigned int resistance_uo;
-
-	resistance_uo = ina->shunt_resistors[channel];
+	struct ina3221_input *input = &ina->inputs[channel];
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", resistance_uo);
+	return snprintf(buf, PAGE_SIZE, "%d\n", input->shunt_resistor);
 }
 
 static ssize_t ina3221_set_shunt(struct device *dev,
@@ -223,6 +316,7 @@ static ssize_t ina3221_set_shunt(struct device *dev,
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int channel = sd_attr->index;
+	struct ina3221_input *input = &ina->inputs[channel];
 	int val;
 	int ret;
 
@@ -232,7 +326,7 @@ static ssize_t ina3221_set_shunt(struct device *dev,
 
 	val = clamp_val(val, 1, INT_MAX);
 
-	ina->shunt_resistors[channel] = val;
+	input->shunt_resistor = val;
 
 	return count;
 }
@@ -253,6 +347,22 @@ static ssize_t ina3221_show_alert(struct device *dev,
 	return snprintf(buf, PAGE_SIZE, "%d\n", regval);
 }
 
+/* input channel label */
+static SENSOR_DEVICE_ATTR(in1_label, 0444,
+		ina3221_show_label, NULL, INA3221_CHANNEL1);
+static SENSOR_DEVICE_ATTR(in2_label, 0444,
+		ina3221_show_label, NULL, INA3221_CHANNEL2);
+static SENSOR_DEVICE_ATTR(in3_label, 0444,
+		ina3221_show_label, NULL, INA3221_CHANNEL3);
+
+/* voltage channel enable */
+static SENSOR_DEVICE_ATTR(in1_enable, 0644,
+		ina3221_show_enable, ina3221_set_enable, INA3221_CHANNEL1);
+static SENSOR_DEVICE_ATTR(in2_enable, 0644,
+		ina3221_show_enable, ina3221_set_enable, INA3221_CHANNEL2);
+static SENSOR_DEVICE_ATTR(in3_enable, 0644,
+		ina3221_show_enable, ina3221_set_enable, INA3221_CHANNEL3);
+
 /* bus voltage */
 static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO,
 		ina3221_show_bus_voltage, NULL, INA3221_BUS1);
@@ -318,7 +428,9 @@ static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO,
 		ina3221_show_shunt_voltage, NULL, INA3221_SHUNT3);
 
 static struct attribute *ina3221_attrs[] = {
-	/* channel 1 */
+	/* channel 1 -- make sure label at first */
+	&sensor_dev_attr_in1_label.dev_attr.attr,
+	&sensor_dev_attr_in1_enable.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_curr1_input.dev_attr.attr,
 	&sensor_dev_attr_shunt1_resistor.dev_attr.attr,
@@ -328,7 +440,9 @@ static struct attribute *ina3221_attrs[] = {
 	&sensor_dev_attr_curr1_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 
-	/* channel 2 */
+	/* channel 2 -- make sure label at first */
+	&sensor_dev_attr_in2_label.dev_attr.attr,
+	&sensor_dev_attr_in2_enable.dev_attr.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
 	&sensor_dev_attr_curr2_input.dev_attr.attr,
 	&sensor_dev_attr_shunt2_resistor.dev_attr.attr,
@@ -338,7 +452,9 @@ static struct attribute *ina3221_attrs[] = {
 	&sensor_dev_attr_curr2_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_in5_input.dev_attr.attr,
 
-	/* channel 3 */
+	/* channel 3 -- make sure label at first */
+	&sensor_dev_attr_in3_label.dev_attr.attr,
+	&sensor_dev_attr_in3_enable.dev_attr.attr,
 	&sensor_dev_attr_in3_input.dev_attr.attr,
 	&sensor_dev_attr_curr3_input.dev_attr.attr,
 	&sensor_dev_attr_shunt3_resistor.dev_attr.attr,
@@ -350,7 +466,30 @@ static struct attribute *ina3221_attrs[] = {
 
 	NULL,
 };
-ATTRIBUTE_GROUPS(ina3221);
+
+static umode_t ina3221_attr_is_visible(struct kobject *kobj,
+				       struct attribute *attr, int n)
+{
+	const int max_attrs = ARRAY_SIZE(ina3221_attrs) - 1;
+	const int num_attrs = max_attrs / INA3221_NUM_CHANNELS;
+	struct device *dev = kobj_to_dev(kobj);
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	enum ina3221_channels channel = n / num_attrs;
+	struct ina3221_input *input = &ina->inputs[channel];
+	int index = n % num_attrs;
+
+	/* Hide label node if label is not provided */
+	if (index == 0 && !input->label)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group ina3221_group = {
+	.is_visible = ina3221_attr_is_visible,
+	.attrs = ina3221_attrs,
+};
+__ATTRIBUTE_GROUPS(ina3221);
 
 static const struct regmap_range ina3221_yes_ranges[] = {
 	regmap_reg_range(INA3221_SHUNT1, INA3221_BUS3),
@@ -370,6 +509,60 @@ static const struct regmap_config ina3221_regmap_config = {
 	.volatile_table = &ina3221_volatile_table,
 };
 
+static int ina3221_probe_child_from_dt(struct device *dev,
+				       struct device_node *child,
+				       struct ina3221_data *ina)
+{
+	struct ina3221_input *input;
+	u32 val;
+	int ret;
+
+	ret = of_property_read_u32(child, "reg", &val);
+	if (ret) {
+		dev_err(dev, "missing reg property of %s\n", child->name);
+		return ret;
+	} else if (val > INA3221_CHANNEL3) {
+		dev_err(dev, "invalid reg %d of %s\n", val, child->name);
+		return ret;
+	}
+
+	input = &ina->inputs[val];
+
+	/* Log the disconnected channel input */
+	if (!of_device_is_available(child)) {
+		input->disconnected = true;
+		return 0;
+	}
+
+	/* Save the connected input label if available */
+	of_property_read_string(child, "label", &input->label);
+
+	/* Overwrite default shunt resistor value optionally */
+	if (!of_property_read_u32(child, "shunt-resistor-micro-ohms", &val))
+		input->shunt_resistor = val;
+
+	return 0;
+}
+
+static int ina3221_probe_from_dt(struct device *dev, struct ina3221_data *ina)
+{
+	const struct device_node *np = dev->of_node;
+	struct device_node *child;
+	int ret;
+
+	/* Compatible with non-DT platforms */
+	if (!np)
+		return 0;
+
+	for_each_child_of_node(np, child) {
+		ret = ina3221_probe_child_from_dt(dev, child, ina);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int ina3221_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -377,6 +570,7 @@ static int ina3221_probe(struct i2c_client *client,
 	struct ina3221_data *ina;
 	struct device *hwmon_dev;
 	int i, ret;
+	u16 mask;
 
 	ina = devm_kzalloc(dev, sizeof(*ina), GFP_KERNEL);
 	if (!ina)
@@ -399,7 +593,13 @@ static int ina3221_probe(struct i2c_client *client,
 	}
 
 	for (i = 0; i < INA3221_NUM_CHANNELS; i++)
-		ina->shunt_resistors[i] = INA3221_RSHUNT_DEFAULT;
+		ina->inputs[i].shunt_resistor = INA3221_RSHUNT_DEFAULT;
+
+	ret = ina3221_probe_from_dt(dev, ina);
+	if (ret) {
+		dev_err(dev, "Unable to probe from device treee\n");
+		return ret;
+	}
 
 	ret = regmap_field_write(ina->fields[F_RST], true);
 	if (ret) {
@@ -407,6 +607,15 @@ static int ina3221_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	/* Disable channels if their inputs are disconnected */
+	for (i = 0, mask = 0; i < INA3221_NUM_CHANNELS; i++) {
+		if (ina->inputs[i].disconnected)
+			mask |= INA3221_CONFIG_CHx_EN(i);
+	}
+	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, 0);
+	if (ret)
+		return ret;
+
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
 							   client->name,
 							   ina, ina3221_groups);
-- 
2.17.1

