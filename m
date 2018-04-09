Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeDIJLN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:11:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751348AbeDIJLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:11:08 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>,
        Benjamin Berg <bberg@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 3/9] Input: elan_i2c - add trackstick report
Date: Mon,  9 Apr 2018 11:10:45 +0200
Message-Id: <20180409091051.2944-4-benjamin.tissoires@redhat.com>
In-Reply-To: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
References: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Elan touchpads over I2C/SMBus also can handle a
trackstick. Unfortunately, nothing tells us if the
device supports trackstick (the information lies in
the PS/2 node), so rely on a platform data to enable
or not the trackstick node.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1313939

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v2:
- use of generic device property instead of platform data so
  device tree can also make use of it
---
 .../devicetree/bindings/input/elan_i2c.txt         |  1 +
 drivers/input/mouse/elan_i2c_core.c                | 90 +++++++++++++++++++++-
 2 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/elan_i2c.txt b/Documentation/devicetree/bindings/input/elan_i2c.txt
index ee3242c4ba67..d80a83583238 100644
--- a/Documentation/devicetree/bindings/input/elan_i2c.txt
+++ b/Documentation/devicetree/bindings/input/elan_i2c.txt
@@ -14,6 +14,7 @@ Optional properties:
 - pinctrl-0: a phandle pointing to the pin settings for the device (see
   pinctrl binding [1]).
 - vcc-supply: a phandle for the regulator supplying 3.3V power.
+- elan,trackpoint: touchpad can support a trackpoint (boolean)
 
 [0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 [1]: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 75e757520ef0..44e970931926 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -36,6 +36,7 @@
 #include <linux/jiffies.h>
 #include <linux/completion.h>
 #include <linux/of.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <asm/unaligned.h>
 
@@ -51,6 +52,7 @@
 #define ETP_MAX_FINGERS		5
 #define ETP_FINGER_DATA_LEN	5
 #define ETP_REPORT_ID		0x5D
+#define ETP_TP_REPORT_ID	0x5E
 #define ETP_REPORT_ID_OFFSET	2
 #define ETP_TOUCH_INFO_OFFSET	3
 #define ETP_FINGER_DATA_OFFSET	4
@@ -61,6 +63,7 @@
 struct elan_tp_data {
 	struct i2c_client	*client;
 	struct input_dev	*input;
+	struct input_dev	*tp_input; /* trackpoint input node */
 	struct regulator	*vcc;
 
 	const struct elan_transport_ops *ops;
@@ -930,6 +933,34 @@ static void elan_report_absolute(struct elan_tp_data *data, u8 *packet)
 	input_sync(input);
 }
 
+static void elan_report_trackpoint(struct elan_tp_data *data, u8 *report)
+{
+	struct input_dev *input = data->tp_input;
+	u8 *packet = &report[ETP_REPORT_ID_OFFSET + 1];
+	int x, y;
+
+	if (!data->tp_input) {
+		dev_warn_once(&data->client->dev,
+			      "received a trackpoint report while no trackpoint device has been created.\n"
+			      "Please report upstream.\n");
+		return;
+	}
+
+	input_report_key(input, BTN_LEFT, packet[0] & 0x01);
+	input_report_key(input, BTN_RIGHT, packet[0] & 0x02);
+	input_report_key(input, BTN_MIDDLE, packet[0] & 0x04);
+
+	if ((packet[3] & 0x0F) == 0x06) {
+		x = packet[4] - (int)((packet[1]^0x80) << 1);
+		y = (int)((packet[2]^0x80) << 1) - packet[5];
+
+		input_report_rel(input, REL_X, x);
+		input_report_rel(input, REL_Y, y);
+	}
+
+	input_sync(input);
+}
+
 static irqreturn_t elan_isr(int irq, void *dev_id)
 {
 	struct elan_tp_data *data = dev_id;
@@ -951,11 +982,17 @@ static irqreturn_t elan_isr(int irq, void *dev_id)
 	if (error)
 		goto out;
 
-	if (report[ETP_REPORT_ID_OFFSET] != ETP_REPORT_ID)
+	switch (report[ETP_REPORT_ID_OFFSET]) {
+	case ETP_REPORT_ID:
+		elan_report_absolute(data, report);
+		break;
+	case ETP_TP_REPORT_ID:
+		elan_report_trackpoint(data, report);
+		break;
+	default:
 		dev_err(dev, "invalid report id data (%x)\n",
 			report[ETP_REPORT_ID_OFFSET]);
-	else
-		elan_report_absolute(data, report);
+	}
 
 out:
 	return IRQ_HANDLED;
@@ -966,6 +1003,37 @@ static irqreturn_t elan_isr(int irq, void *dev_id)
  * Elan initialization functions
  ******************************************************************
  */
+
+static int elan_setup_trackpoint_input_device(struct elan_tp_data *data)
+{
+	struct device *dev = &data->client->dev;
+	struct input_dev *input;
+
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+
+	input->name = "Elan TrackPoint";
+	input->id.bustype = BUS_I2C;
+	input->id.vendor = ELAN_VENDOR_ID;
+	input->id.product = data->product_id;
+	input_set_drvdata(input, data);
+
+	input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
+	input->relbit[BIT_WORD(REL_X)] =
+		BIT_MASK(REL_X) | BIT_MASK(REL_Y);
+	input->keybit[BIT_WORD(BTN_LEFT)] =
+		BIT_MASK(BTN_LEFT) | BIT_MASK(BTN_MIDDLE) |
+		BIT_MASK(BTN_RIGHT);
+
+	__set_bit(INPUT_PROP_POINTER, input->propbit);
+	__set_bit(INPUT_PROP_POINTING_STICK, input->propbit);
+
+	data->tp_input = input;
+
+	return 0;
+}
+
 static int elan_setup_input_device(struct elan_tp_data *data)
 {
 	struct device *dev = &data->client->dev;
@@ -1140,6 +1208,12 @@ static int elan_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
+	if (device_property_read_bool(&client->dev, "elan,trackpoint")) {
+		error = elan_setup_trackpoint_input_device(data);
+		if (error)
+			return error;
+	}
+
 	/*
 	 * Platform code (ACPI, DTS) should normally set up interrupt
 	 * for us, but in case it did not let's fall back to using falling
@@ -1177,6 +1251,16 @@ static int elan_probe(struct i2c_client *client,
 		return error;
 	}
 
+	if (data->tp_input) {
+		error = input_register_device(data->tp_input);
+		if (error) {
+			dev_err(&client->dev,
+				"failed to register TrackPoint input device: %d\n",
+				error);
+			return error;
+		}
+	}
+
 	/*
 	 * Systems using device tree should set up wakeup via DTS,
 	 * the rest will configure device as wakeup source by default.
-- 
2.14.3
