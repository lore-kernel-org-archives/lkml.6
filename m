Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757417AbeD0DNQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 23:13:16 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:34101 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757354AbeD0DNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 23:13:12 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Woods <brian.woods@amd.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/2] hwmon: (k10temp) Display both Tctl and Tdie
Date: Thu, 26 Apr 2018 20:13:09 -0700
Message-Id: <1524798789-2239-2-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524798789-2239-1-git-send-email-linux@roeck-us.net>
References: <1524798789-2239-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some AMD CPUs, there is a different between the die temperature
(Tdie) and the reported temperature (Tctl). Tdie is the real measured
temperature, and Tctl is used for fan control. Lets report both for
affected CPUs.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 55 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index b06bb1f90853..1135b8f1ad0f 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -80,6 +80,7 @@ struct k10temp_data {
 	void (*read_tempreg)(struct pci_dev *pdev, u32 *regval);
 	int temp_offset;
 	u32 temp_adjust_mask;
+	bool show_tdie;
 };
 
 struct tctl_offset {
@@ -140,17 +141,24 @@ static void read_tempreg_nb_f17(struct pci_dev *pdev, u32 *regval)
 			  F17H_M01H_REPORTED_TEMP_CTRL_OFFSET, regval);
 }
 
-static ssize_t temp1_input_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
+unsigned int get_raw_temp(struct k10temp_data *data)
 {
-	struct k10temp_data *data = dev_get_drvdata(dev);
-	u32 regval;
 	unsigned int temp;
+	u32 regval;
 
 	data->read_tempreg(data->pdev, &regval);
 	temp = (regval >> 21) * 125;
 	if (regval & data->temp_adjust_mask)
 		temp -= 49000;
+	return temp;
+}
+
+static ssize_t temp1_input_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct k10temp_data *data = dev_get_drvdata(dev);
+	unsigned int temp = get_raw_temp(data);
+
 	if (temp > data->temp_offset)
 		temp -= data->temp_offset;
 	else
@@ -159,6 +167,23 @@ static ssize_t temp1_input_show(struct device *dev,
 	return sprintf(buf, "%u\n", temp);
 }
 
+static ssize_t temp2_input_show(struct device *dev,
+				struct device_attribute *devattr, char *buf)
+{
+	struct k10temp_data *data = dev_get_drvdata(dev);
+	unsigned int temp = get_raw_temp(data);
+
+	return sprintf(buf, "%u\n", temp);
+}
+
+static ssize_t temp_label_show(struct device *dev,
+			       struct device_attribute *devattr, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+
+	return sprintf(buf, "%s\n", attr->index ? "Tctl" : "Tdie");
+}
+
 static ssize_t temp1_max_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
@@ -187,16 +212,23 @@ static DEVICE_ATTR_RO(temp1_max);
 static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp_crit, NULL, 0);
 static SENSOR_DEVICE_ATTR(temp1_crit_hyst, S_IRUGO, show_temp_crit, NULL, 1);
 
+static SENSOR_DEVICE_ATTR(temp1_label, 0444, temp_label_show, NULL, 0);
+static DEVICE_ATTR_RO(temp2_input);
+static SENSOR_DEVICE_ATTR(temp2_label, 0444, temp_label_show, NULL, 1);
+
 static umode_t k10temp_is_visible(struct kobject *kobj,
 				  struct attribute *attr, int index)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct k10temp_data *data = dev_get_drvdata(dev);
 	struct pci_dev *pdev = data->pdev;
+	u32 reg;
 
-	if (index >= 2) {
-		u32 reg;
-
+	switch (index) {
+	case 0 ... 1:	/* temp1_input, temp1_max */
+	default:
+		break;
+	case 2 ... 3:	/* temp1_crit, temp1_crit_hyst */
 		if (!data->read_htcreg)
 			return 0;
 
@@ -208,6 +240,11 @@ static umode_t k10temp_is_visible(struct kobject *kobj,
 		data->read_htcreg(data->pdev, &reg);
 		if (!(reg & HTC_ENABLE))
 			return 0;
+		break;
+	case 4 ... 6:	/* temp1_label, temp2_input, temp2_label */
+		if (!data->show_tdie)
+			return 0;
+		break;
 	}
 	return attr->mode;
 }
@@ -217,6 +254,9 @@ static struct attribute *k10temp_attrs[] = {
 	&dev_attr_temp1_max.attr,
 	&sensor_dev_attr_temp1_crit.dev_attr.attr,
 	&sensor_dev_attr_temp1_crit_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp1_label.dev_attr.attr,
+	&dev_attr_temp2_input.attr,
+	&sensor_dev_attr_temp2_label.dev_attr.attr,
 	NULL
 };
 
@@ -292,6 +332,7 @@ static int k10temp_probe(struct pci_dev *pdev,
 	} else if (boot_cpu_data.x86 == 0x17) {
 		data->temp_adjust_mask = 0x80000;
 		data->read_tempreg = read_tempreg_nb_f17;
+		data->show_tdie = true;
 	} else {
 		data->read_htcreg = read_htcreg_pci;
 		data->read_tempreg = read_tempreg_pci;
-- 
2.7.4
