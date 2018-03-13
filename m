Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753260AbeCMU76 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:59:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42842 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753215AbeCMU7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:59:18 -0400
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        joel@jms.id.au, Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] hwmon: (ucd9000) Add gpio chip interface
Date: Tue, 13 Mar 2018 15:59:08 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1520974749-5372-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1520974749-5372-1-git-send-email-eajames@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18031320-0056-0000-0000-0000042D0EBE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008667; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01002601; UDB=6.00510170; IPR=6.00781931;
 MB=3.00020014; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-13 20:59:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031320-0057-0000-0000-0000086F0ED1
Message-Id: <1520974749-5372-2-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130233
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christopher Bostic <cbostic@linux.vnet.ibm.com>

Add a struct gpio_chip and define some methods so that this device's
I/O can be accessed via /sys/class/gpio.

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
 drivers/hwmon/pmbus/ucd9000.c | 201 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
index b74dbec..023fb9e 100644
--- a/drivers/hwmon/pmbus/ucd9000.c
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/i2c.h>
 #include <linux/pmbus.h>
+#include <linux/gpio.h>
 #include "pmbus.h"
 
 enum chips { ucd9000, ucd90120, ucd90124, ucd90160, ucd9090, ucd90910 };
@@ -35,8 +36,18 @@
 #define UCD9000_NUM_PAGES		0xd6
 #define UCD9000_FAN_CONFIG_INDEX	0xe7
 #define UCD9000_FAN_CONFIG		0xe8
+#define UCD9000_GPIO_SELECT		0xfa
+#define UCD9000_GPIO_CONFIG		0xfb
 #define UCD9000_DEVICE_ID		0xfd
 
+/* GPIO CONFIG bits */
+#define UCD9000_GPIO_CONFIG_ENABLE	BIT(0)
+#define UCD9000_GPIO_CONFIG_OUT_ENABLE	BIT(1)
+#define UCD9000_GPIO_CONFIG_OUT_VALUE	BIT(2)
+#define UCD9000_GPIO_CONFIG_STATUS	BIT(3)
+#define UCD9000_GPIO_INPUT		0
+#define UCD9000_GPIO_OUTPUT		1
+
 #define UCD9000_MON_TYPE(x)	(((x) >> 5) & 0x07)
 #define UCD9000_MON_PAGE(x)	((x) & 0x0f)
 
@@ -47,9 +58,15 @@
 
 #define UCD9000_NUM_FAN		4
 
+#define UCD9000_GPIO_NAME_LEN	16
+#define UCD9090_NUM_GPIOS	23
+#define UCD901XX_NUM_GPIOS	26
+#define UCD90910_NUM_GPIOS	26
+
 struct ucd9000_data {
 	u8 fan_data[UCD9000_NUM_FAN][I2C_SMBUS_BLOCK_MAX];
 	struct pmbus_driver_info info;
+	struct gpio_chip gpio;
 };
 #define to_ucd9000_data(_info) container_of(_info, struct ucd9000_data, info)
 
@@ -149,6 +166,146 @@ static int ucd9000_read_byte_data(struct i2c_client *client, int page, int reg)
 };
 MODULE_DEVICE_TABLE(of, ucd9000_of_match);
 
+static int ucd9000_gpio_read_config(struct i2c_client *client,
+				    unsigned int offset)
+{
+	int ret;
+
+	/* No page set required */
+	ret = i2c_smbus_write_byte_data(client, UCD9000_GPIO_SELECT, offset);
+	if (ret < 0)
+		return ret;
+
+	return i2c_smbus_read_byte_data(client, UCD9000_GPIO_CONFIG);
+}
+
+static int ucd9000_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct i2c_client *client  = gpiochip_get_data(gc);
+	int ret;
+
+	ret = ucd9000_gpio_read_config(client, offset);
+	if (ret < 0)
+		return ret;
+
+	return !!(ret & UCD9000_GPIO_CONFIG_STATUS);
+}
+
+static void ucd9000_gpio_set(struct gpio_chip *gc, unsigned int offset,
+			     int value)
+{
+	struct i2c_client *client = gpiochip_get_data(gc);
+	int ret;
+
+	ret = ucd9000_gpio_read_config(client, offset);
+	if (ret < 0) {
+		dev_dbg(&client->dev, "failed to read GPIO %d config: %d\n",
+			offset, ret);
+		return;
+	}
+
+	if (value) {
+		if (ret & UCD9000_GPIO_CONFIG_STATUS)
+			return;
+
+		ret |= UCD9000_GPIO_CONFIG_STATUS;
+	} else {
+		if (!(ret & UCD9000_GPIO_CONFIG_STATUS))
+			return;
+
+		ret &= ~UCD9000_GPIO_CONFIG_STATUS;
+	}
+
+	ret |= UCD9000_GPIO_CONFIG_ENABLE;
+
+	/* Page set not required */
+	ret = i2c_smbus_write_byte_data(client, UCD9000_GPIO_CONFIG, ret);
+	if (ret < 0) {
+		dev_dbg(&client->dev, "Failed to write GPIO %d config: %d\n",
+			offset, ret);
+		return;
+	}
+
+	ret &= ~UCD9000_GPIO_CONFIG_ENABLE;
+
+	ret = i2c_smbus_write_byte_data(client, UCD9000_GPIO_CONFIG, ret);
+	if (ret < 0)
+		dev_dbg(&client->dev, "Failed to write GPIO %d config: %d\n",
+			offset, ret);
+}
+
+static int ucd9000_gpio_get_direction(struct gpio_chip *gc,
+				      unsigned int offset)
+{
+	struct i2c_client *client = gpiochip_get_data(gc);
+	int ret;
+
+	ret = ucd9000_gpio_read_config(client, offset);
+	if (ret < 0)
+		return ret;
+
+	return !(ret & UCD9000_GPIO_CONFIG_OUT_ENABLE);
+}
+
+static int ucd9000_gpio_set_direction(struct gpio_chip *gc,
+				      unsigned int offset, bool direction_out,
+				      int requested_out)
+{
+	struct i2c_client *client = gpiochip_get_data(gc);
+	int ret, config, out_val;
+
+	ret = ucd9000_gpio_read_config(client, offset);
+	if (ret < 0)
+		return ret;
+
+	if (direction_out) {
+		out_val = requested_out ? UCD9000_GPIO_CONFIG_OUT_VALUE : 0;
+
+		if (ret & UCD9000_GPIO_CONFIG_OUT_ENABLE) {
+			if ((ret & UCD9000_GPIO_CONFIG_OUT_VALUE) == out_val)
+				return 0;
+		} else {
+			ret |= UCD9000_GPIO_CONFIG_OUT_ENABLE;
+		}
+
+		if (out_val)
+			ret |= UCD9000_GPIO_CONFIG_OUT_VALUE;
+		else
+			ret &= ~UCD9000_GPIO_CONFIG_OUT_VALUE;
+
+	} else {
+		if (!(ret & UCD9000_GPIO_CONFIG_OUT_ENABLE))
+			return 0;
+
+		ret &= ~UCD9000_GPIO_CONFIG_OUT_ENABLE;
+	}
+
+	ret |= UCD9000_GPIO_CONFIG_ENABLE;
+	config = ret;
+
+	/* Page set not required */
+	ret = i2c_smbus_write_byte_data(client, UCD9000_GPIO_CONFIG, config);
+	if (ret < 0)
+		return ret;
+
+	config &= ~UCD9000_GPIO_CONFIG_ENABLE;
+
+	return i2c_smbus_write_byte_data(client, UCD9000_GPIO_CONFIG, config);
+}
+
+static int ucd9000_gpio_direction_input(struct gpio_chip *gc,
+					unsigned int offset)
+{
+	return ucd9000_gpio_set_direction(gc, offset, UCD9000_GPIO_INPUT, 0);
+}
+
+static int ucd9000_gpio_direction_output(struct gpio_chip *gc,
+					 unsigned int offset, int val)
+{
+	return ucd9000_gpio_set_direction(gc, offset, UCD9000_GPIO_OUTPUT,
+					  val);
+}
+
 static int ucd9000_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -263,6 +420,50 @@ static int ucd9000_probe(struct i2c_client *client,
 		  | PMBUS_HAVE_FAN34 | PMBUS_HAVE_STATUS_FAN34;
 	}
 
+	/*
+	 * Note:
+	 *
+	 * Pinmux support has not been added to the new gpio_chip.
+	 * This support should be added when possible given the mux
+	 * behavior of these IO devices.
+	 */
+	data->gpio.label = (const char *)&client->name;
+	data->gpio.get_direction = ucd9000_gpio_get_direction;
+	data->gpio.direction_input = ucd9000_gpio_direction_input;
+	data->gpio.direction_output = ucd9000_gpio_direction_output;
+	data->gpio.get = ucd9000_gpio_get;
+	data->gpio.set = ucd9000_gpio_set;
+	data->gpio.can_sleep = 1;
+	data->gpio.base = -1;
+
+	switch (mid->driver_data) {
+	case ucd9090:
+		data->gpio.ngpio = UCD9090_NUM_GPIOS;
+		break;
+	case ucd90120:
+	case ucd90124:
+	case ucd90160:
+		data->gpio.ngpio = UCD901XX_NUM_GPIOS;
+		break;
+	case ucd90910:
+		data->gpio.ngpio = UCD90910_NUM_GPIOS;
+		break;
+	default:
+		break;
+	}
+
+	data->gpio.parent = &client->dev;
+	data->gpio.owner = THIS_MODULE;
+	data->gpio.of_node = client->dev.of_node;
+
+	if (data->gpio.ngpio) {
+		ret = devm_gpiochip_add_data(&client->dev, &data->gpio,
+					     client);
+		if (ret)
+			dev_warn(&client->dev, "Could not add gpiochip: %d\n",
+				 ret);
+	}
+
 	return pmbus_do_probe(client, mid, info);
 }
 
-- 
1.8.3.1
