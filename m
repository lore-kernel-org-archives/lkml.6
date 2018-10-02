Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDA4C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC928206B5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 01:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCWRSLtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC928206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJBHqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 03:46:10 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43833 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJBHqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 03:46:09 -0400
Received: by mail-io1-f66.google.com with SMTP id y10-v6so271299ioa.10;
        Mon, 01 Oct 2018 18:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CamCYASmNVC5I7z4MWa62B544VFKOVcnPZqCCdVxT74=;
        b=VCWRSLtnmDeCGeI39K3puPs+RWYHyP+tg9bV/fNIpZWfB6DM5Bvk8nzarVammQHz0J
         yRv/2aeKbRAHdebgZdhDTTcF1G46k5vR8EMKdSv8rHORVu5L/BBDbqol8ImX4JQcdGOL
         NnG985yix7+waSaUuBmSfi5mSsjHDfgqthDucFTdW/VRb7yaBTMYd93DMEbvekay8/hz
         c8DbVtv2rj5e9KSQfjisj3blnbeWP+/h6ohKZ6xQCiraFOAbR+94YgCQCGmE6u0eQGPq
         Bh8gqLD4WVVGII0r64wm3Gv6A64GuJf8QaFuNHfmgSErtCczZ5WNXVG1taUL8KdmZb/x
         01fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CamCYASmNVC5I7z4MWa62B544VFKOVcnPZqCCdVxT74=;
        b=Ai/YCL7Cm1KTjAxgzfxRNyg2c7WUeS5V6qhw2w++iSDNYq00TZf2SBs4nSc9hCJD/e
         lqzSoOn1ZCVrp5PBCRgOsuuZf6srSnt+hObsWn2XUutcIqrgQXuS+sQioFD/C3ipgCCc
         hNGwlnsi61LldWkegApLzcmH8syqukOG8YhhHRD57rRsJ5/BJugQkfpwZuASzusfz06m
         SfHmt0fA1Jg7bDwTwKT1vmkNSIORkJ19m+y8kpntk6E7t+9bzFQHJSSV4HpWrSyY/fud
         Jk3Mrnhe0M5lrwOT96B6WCj2RxpWaHg0kU0dCrbhHhgYZ4TXoRu3CB2YBUD0SWR/g/im
         Efpw==
X-Gm-Message-State: ABuFfohSbKKuylOHU5iY5FpTmHyeJMi/RhiPzibGZiJhxuui/UkwBdrf
        QpDUQVdgnRAHZf3V11zDaZw=
X-Google-Smtp-Source: ACcGV6164XtN9TjcGn/5XFxRdl7zABG3DPq6AXCTO9iXh0rQBrBhMLCmqBulztYd86v/gtNz3HjoVw==
X-Received: by 2002:a62:509a:: with SMTP id g26-v6mr12460423pfj.62.1538442336473;
        Mon, 01 Oct 2018 18:05:36 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id x20-v6sm26084959pfe.131.2018.10.01.18.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:05:35 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v9 2/2] hwmon: (ina3221) Read channel input source info from DT
Date:   Mon,  1 Oct 2018 18:05:23 -0700
Message-Id: <20181002010523.2019-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002010523.2019-1-nicoleotsuka@gmail.com>
References: <20181002010523.2019-1-nicoleotsuka@gmail.com>
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
v8->v9:
 * Renamed the subject by following hwmon naming convention
 * Rebased the patch after the merged ina3221 changes
 * Fixed the potential race condition in ina3221_set_enable()
v7->v8:
 * Rebased the change after the new suspend-resume patch
 * * Please apply suspend-resume patch prior to this one
 * Renamed ina3221_is_enable() to ina3221_is_enabled()
 * Removed "> 0" check in the is_enabled() function
 * Replaced regmap_read() with ina->reg_config in is_enabled()
 * Used kstrtobool() in the ina3221_set_enable() function
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
 drivers/hwmon/ina3221.c     | 235 +++++++++++++++++++++++++++++++++---
 2 files changed, 223 insertions(+), 14 deletions(-)

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
index 1e38b4c43fbf..88e65d2b4fa5 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -43,6 +43,7 @@
 #define INA3221_CONFIG_MODE_SHUNT	BIT(0)
 #define INA3221_CONFIG_MODE_BUS		BIT(1)
 #define INA3221_CONFIG_MODE_CONTINUOUS	BIT(2)
+#define INA3221_CONFIG_CHx_EN(x)	BIT(14 - (x))
 
 #define INA3221_RSHUNT_DEFAULT		10000
 
@@ -77,6 +78,9 @@ enum ina3221_channels {
 };
 
 static const unsigned int register_channel[] = {
+	[INA3221_BUS1] = INA3221_CHANNEL1,
+	[INA3221_BUS2] = INA3221_CHANNEL2,
+	[INA3221_BUS3] = INA3221_CHANNEL3,
 	[INA3221_SHUNT1] = INA3221_CHANNEL1,
 	[INA3221_SHUNT2] = INA3221_CHANNEL2,
 	[INA3221_SHUNT3] = INA3221_CHANNEL3,
@@ -88,20 +92,89 @@ static const unsigned int register_channel[] = {
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
  * @reg_config: Register value of INA3221_CONFIG
  */
 struct ina3221_data {
 	struct regmap *regmap;
 	struct regmap_field *fields[F_MAX_FIELDS];
-	int shunt_resistors[INA3221_NUM_CHANNELS];
+	struct ina3221_input inputs[INA3221_NUM_CHANNELS];
 	u32 reg_config;
 };
 
+static inline bool ina3221_is_enabled(struct ina3221_data *ina, int channel)
+{
+	return ina->reg_config & INA3221_CONFIG_CHx_EN(channel);
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
+			ina3221_is_enabled(ina, channel));
+}
+
+static ssize_t ina3221_set_enable(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
+	struct ina3221_data *ina = dev_get_drvdata(dev);
+	unsigned int channel = sd_attr->index;
+	u16 config, mask = INA3221_CONFIG_CHx_EN(channel);
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret)
+		return ret;
+
+	config = enable ? mask : 0;
+
+	/* Enable or disable the channel */
+	ret = regmap_update_bits(ina->regmap, INA3221_CONFIG, mask, config);
+	if (ret)
+		return ret;
+
+	/* Cache the latest config register value */
+	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 static int ina3221_read_value(struct ina3221_data *ina, unsigned int reg,
 			      int *val)
 {
@@ -124,8 +197,13 @@ static ssize_t ina3221_show_bus_voltage(struct device *dev,
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int reg = sd_attr->index;
+	unsigned int channel = register_channel[reg];
 	int val, voltage_mv, ret;
 
+	/* No data for read-only attribute if channel is disabled */
+	if (!attr->store && !ina3221_is_enabled(ina, channel))
+		return -ENODATA;
+
 	ret = ina3221_read_value(ina, reg, &val);
 	if (ret)
 		return ret;
@@ -142,8 +220,13 @@ static ssize_t ina3221_show_shunt_voltage(struct device *dev,
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int reg = sd_attr->index;
+	unsigned int channel = register_channel[reg];
 	int val, voltage_uv, ret;
 
+	/* No data for read-only attribute if channel is disabled */
+	if (!attr->store && !ina3221_is_enabled(ina, channel))
+		return -ENODATA;
+
 	ret = ina3221_read_value(ina, reg, &val);
 	if (ret)
 		return ret;
@@ -159,9 +242,14 @@ static ssize_t ina3221_show_current(struct device *dev,
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int reg = sd_attr->index;
 	unsigned int channel = register_channel[reg];
-	int resistance_uo = ina->shunt_resistors[channel];
+	struct ina3221_input *input = &ina->inputs[channel];
+	int resistance_uo = input->shunt_resistor;
 	int val, current_ma, voltage_nv, ret;
 
+	/* No data for read-only attribute if channel is disabled */
+	if (!attr->store && !ina3221_is_enabled(ina, channel))
+		return -ENODATA;
+
 	ret = ina3221_read_value(ina, reg, &val);
 	if (ret)
 		return ret;
@@ -180,7 +268,8 @@ static ssize_t ina3221_set_current(struct device *dev,
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int reg = sd_attr->index;
 	unsigned int channel = register_channel[reg];
-	int resistance_uo = ina->shunt_resistors[channel];
+	struct ina3221_input *input = &ina->inputs[channel];
+	int resistance_uo = input->shunt_resistor;
 	int val, current_ma, voltage_uv, ret;
 
 	ret = kstrtoint(buf, 0, &current_ma);
@@ -213,11 +302,9 @@ static ssize_t ina3221_show_shunt(struct device *dev,
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
@@ -227,6 +314,7 @@ static ssize_t ina3221_set_shunt(struct device *dev,
 	struct sensor_device_attribute *sd_attr = to_sensor_dev_attr(attr);
 	struct ina3221_data *ina = dev_get_drvdata(dev);
 	unsigned int channel = sd_attr->index;
+	struct ina3221_input *input = &ina->inputs[channel];
 	int val;
 	int ret;
 
@@ -236,7 +324,7 @@ static ssize_t ina3221_set_shunt(struct device *dev,
 
 	val = clamp_val(val, 1, INT_MAX);
 
-	ina->shunt_resistors[channel] = val;
+	input->shunt_resistor = val;
 
 	return count;
 }
@@ -257,6 +345,22 @@ static ssize_t ina3221_show_alert(struct device *dev,
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
@@ -322,7 +426,9 @@ static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO,
 		ina3221_show_shunt_voltage, NULL, INA3221_SHUNT3);
 
 static struct attribute *ina3221_attrs[] = {
-	/* channel 1 */
+	/* channel 1 -- make sure label at first */
+	&sensor_dev_attr_in1_label.dev_attr.attr,
+	&sensor_dev_attr_in1_enable.dev_attr.attr,
 	&sensor_dev_attr_in1_input.dev_attr.attr,
 	&sensor_dev_attr_curr1_input.dev_attr.attr,
 	&sensor_dev_attr_shunt1_resistor.dev_attr.attr,
@@ -332,7 +438,9 @@ static struct attribute *ina3221_attrs[] = {
 	&sensor_dev_attr_curr1_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_in4_input.dev_attr.attr,
 
-	/* channel 2 */
+	/* channel 2 -- make sure label at first */
+	&sensor_dev_attr_in2_label.dev_attr.attr,
+	&sensor_dev_attr_in2_enable.dev_attr.attr,
 	&sensor_dev_attr_in2_input.dev_attr.attr,
 	&sensor_dev_attr_curr2_input.dev_attr.attr,
 	&sensor_dev_attr_shunt2_resistor.dev_attr.attr,
@@ -342,7 +450,9 @@ static struct attribute *ina3221_attrs[] = {
 	&sensor_dev_attr_curr2_max_alarm.dev_attr.attr,
 	&sensor_dev_attr_in5_input.dev_attr.attr,
 
-	/* channel 3 */
+	/* channel 3 -- make sure label at first */
+	&sensor_dev_attr_in3_label.dev_attr.attr,
+	&sensor_dev_attr_in3_enable.dev_attr.attr,
 	&sensor_dev_attr_in3_input.dev_attr.attr,
 	&sensor_dev_attr_curr3_input.dev_attr.attr,
 	&sensor_dev_attr_shunt3_resistor.dev_attr.attr,
@@ -354,7 +464,30 @@ static struct attribute *ina3221_attrs[] = {
 
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
 	regmap_reg_range(INA3221_CONFIG, INA3221_BUS3),
@@ -374,6 +507,60 @@ static const struct regmap_config ina3221_regmap_config = {
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
@@ -403,7 +590,13 @@ static int ina3221_probe(struct i2c_client *client,
 	}
 
 	for (i = 0; i < INA3221_NUM_CHANNELS; i++)
-		ina->shunt_resistors[i] = INA3221_RSHUNT_DEFAULT;
+		ina->inputs[i].shunt_resistor = INA3221_RSHUNT_DEFAULT;
+
+	ret = ina3221_probe_from_dt(dev, ina);
+	if (ret) {
+		dev_err(dev, "Unable to probe from device tree\n");
+		return ret;
+	}
 
 	ret = regmap_field_write(ina->fields[F_RST], true);
 	if (ret) {
@@ -411,6 +604,20 @@ static int ina3221_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	/* Sync config register after reset */
+	ret = regmap_read(ina->regmap, INA3221_CONFIG, &ina->reg_config);
+	if (ret)
+		return ret;
+
+	/* Disable channels if their inputs are disconnected */
+	for (i = 0; i < INA3221_NUM_CHANNELS; i++) {
+		if (ina->inputs[i].disconnected)
+			ina->reg_config &= ~INA3221_CONFIG_CHx_EN(i);
+	}
+	ret = regmap_write(ina->regmap, INA3221_CONFIG, ina->reg_config);
+	if (ret)
+		return ret;
+
 	dev_set_drvdata(dev, ina);
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
-- 
2.17.1

