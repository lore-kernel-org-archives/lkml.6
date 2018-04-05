Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751495AbeDENZy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:25:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751437AbeDENZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:25:51 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>,
        Benjamin Berg <bberg@redhat.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 3/8] Input: elan_i2c - add trackstick report
Date: Thu,  5 Apr 2018 15:25:32 +0200
Message-Id: <20180405132537.3218-4-benjamin.tissoires@redhat.com>
In-Reply-To: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
References: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
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
- renamed ETP_PT_REPORT_ID into ETP_TP_REPORT_ID (pass-through to track-point)
  to stay more in line with the rest
- removed Host Notify support so amended to match parent
---
 drivers/input/mouse/elan_i2c.h      | 10 ++++
 drivers/input/mouse/elan_i2c_core.c | 91 +++++++++++++++++++++++++++++++++++--
 2 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c.h b/drivers/input/mouse/elan_i2c.h
index 599544c1a91c..8f9c97267bc9 100644
--- a/drivers/input/mouse/elan_i2c.h
+++ b/drivers/input/mouse/elan_i2c.h
@@ -87,4 +87,14 @@ struct elan_transport_ops {
 
 extern const struct elan_transport_ops elan_smbus_ops, elan_i2c_ops;
 
+/**
+ * struct elan_platform_data - system specific configuration info.
+ *
+ * @trackpoint - specify whether or not you want the trackstick input node to
+ * be created and handled by the driver.
+ */
+struct elan_platform_data {
+	bool trackpoint;
+};
+
 #endif /* _ELAN_I2C_H */
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 75e757520ef0..8ed1e2a8a4dd 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -51,6 +51,7 @@
 #define ETP_MAX_FINGERS		5
 #define ETP_FINGER_DATA_LEN	5
 #define ETP_REPORT_ID		0x5D
+#define ETP_TP_REPORT_ID	0x5E
 #define ETP_REPORT_ID_OFFSET	2
 #define ETP_TOUCH_INFO_OFFSET	3
 #define ETP_FINGER_DATA_OFFSET	4
@@ -61,6 +62,7 @@
 struct elan_tp_data {
 	struct i2c_client	*client;
 	struct input_dev	*input;
+	struct input_dev	*tp_input; /* trackpoint input node */
 	struct regulator	*vcc;
 
 	const struct elan_transport_ops *ops;
@@ -930,6 +932,34 @@ static void elan_report_absolute(struct elan_tp_data *data, u8 *packet)
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
@@ -951,11 +981,17 @@ static irqreturn_t elan_isr(int irq, void *dev_id)
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
@@ -966,6 +1002,37 @@ static irqreturn_t elan_isr(int irq, void *dev_id)
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
@@ -1042,10 +1109,12 @@ static void elan_remove_sysfs_groups(void *_data)
 static int elan_probe(struct i2c_client *client,
 		      const struct i2c_device_id *dev_id)
 {
+	struct elan_platform_data *pdata = dev_get_platdata(&client->dev);
 	const struct elan_transport_ops *transport_ops;
 	struct device *dev = &client->dev;
 	struct elan_tp_data *data;
 	unsigned long irqflags;
+	bool has_trackpoint = pdata && pdata->trackpoint;
 	int error;
 
 	if (IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_I2C) &&
@@ -1140,6 +1209,12 @@ static int elan_probe(struct i2c_client *client,
 	if (error)
 		return error;
 
+	if (has_trackpoint) {
+		error = elan_setup_trackpoint_input_device(data);
+		if (error)
+			return error;
+	}
+
 	/*
 	 * Platform code (ACPI, DTS) should normally set up interrupt
 	 * for us, but in case it did not let's fall back to using falling
@@ -1177,6 +1252,16 @@ static int elan_probe(struct i2c_client *client,
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
