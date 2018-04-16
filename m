Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754300AbeDPM2a (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:28:30 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41173 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753931AbeDPM2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:28:24 -0400
X-Google-Smtp-Source: AIpwx4/GmpsPRL/y4p8QHrzh0bI4Du9725iBd5j8fm5Yx8rUvDYft2fjiJrb2TiVOM4m0mm4FNCwHw==
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, Cameron Gutman <aicommander@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH v9 2/2] HID: steam: add battery device.
Date: Mon, 16 Apr 2018 14:27:03 +0200
Message-Id: <20180416122703.22306-3-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180416122703.22306-1-rodrigorivascosta@gmail.com>
References: <20180416122703.22306-1-rodrigorivascosta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wireless Steam Controller is battery operated, so add the battery
device and power information.
---
 drivers/hid/hid-steam.c | 141 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 36fc85714ea5..af7ebb618867 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -40,6 +40,7 @@
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
 #include <linux/delay.h>
+#include <linux/power_supply.h>
 #include "hid-ids.h"
 
 MODULE_LICENSE("GPL");
@@ -118,6 +119,10 @@ struct steam_device {
 	struct work_struct work_connect;
 	bool connected;
 	char serial_no[STEAM_SERIAL_LEN + 1];
+	struct power_supply_desc battery_desc;
+	struct power_supply __rcu *battery;
+	u8 battery_charge;
+	u16 voltage;
 };
 
 static int steam_recv_report(struct steam_device *steam,
@@ -316,6 +321,85 @@ static void steam_input_close(struct input_dev *dev)
 	hid_hw_close(steam->hdev);
 }
 
+static enum power_supply_property steam_battery_props[] = {
+	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_VOLTAGE_NOW,
+	POWER_SUPPLY_PROP_CAPACITY,
+};
+
+static int steam_battery_get_property(struct power_supply *psy,
+				enum power_supply_property psp,
+				union power_supply_propval *val)
+{
+	struct steam_device *steam = power_supply_get_drvdata(psy);
+	unsigned long flags;
+	s16 volts;
+	u8 batt;
+	int ret = 0;
+
+	spin_lock_irqsave(&steam->lock, flags);
+	volts = steam->voltage;
+	batt = steam->battery_charge;
+	spin_unlock_irqrestore(&steam->lock, flags);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_PRESENT:
+		val->intval = 1;
+		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
+		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
+		val->intval = volts * 1000; /* mV -> uV */
+		break;
+	case POWER_SUPPLY_PROP_CAPACITY:
+		val->intval = batt;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	return ret;
+}
+
+static int steam_battery_register(struct steam_device *steam)
+{
+	struct power_supply *battery;
+	struct power_supply_config battery_cfg = { .drv_data = steam, };
+	unsigned long flags;
+	int ret;
+
+	steam->battery_desc.type = POWER_SUPPLY_TYPE_BATTERY;
+	steam->battery_desc.properties = steam_battery_props;
+	steam->battery_desc.num_properties = ARRAY_SIZE(steam_battery_props);
+	steam->battery_desc.get_property = steam_battery_get_property;
+	steam->battery_desc.name = devm_kasprintf(&steam->hdev->dev,
+			GFP_KERNEL, "steam-controller-%s-battery",
+			steam->serial_no);
+	if (!steam->battery_desc.name)
+		return -ENOMEM;
+
+	/* avoid the warning of 0% battery while waiting for the first info */
+	spin_lock_irqsave(&steam->lock, flags);
+	steam->voltage = 3000;
+	steam->battery_charge = 100;
+	spin_unlock_irqrestore(&steam->lock, flags);
+
+	battery = power_supply_register(&steam->hdev->dev,
+			&steam->battery_desc, &battery_cfg);
+	if (IS_ERR(battery)) {
+		ret = PTR_ERR(battery);
+		hid_err(steam->hdev,
+				"%s:power_supply_register failed with error %d\n",
+				__func__, ret);
+		return ret;
+	}
+	rcu_assign_pointer(steam->battery, battery);
+	power_supply_powers(battery, &steam->hdev->dev);
+	return 0;
+}
+
 static int steam_register(struct steam_device *steam)
 {
 	struct hid_device *hdev = steam->hdev;
@@ -409,6 +493,10 @@ static int steam_register(struct steam_device *steam)
 
 	rcu_assign_pointer(steam->input, input);
 
+	/* ignore battery errors, we can live without it */
+	if (steam->quirks & STEAM_QUIRK_WIRELESS)
+		steam_battery_register(steam);
+
 	return 0;
 
 input_register_fail:
@@ -419,11 +507,18 @@ static int steam_register(struct steam_device *steam)
 static void steam_unregister(struct steam_device *steam)
 {
 	struct input_dev *input;
+	struct power_supply *battery;
 
 	rcu_read_lock();
 	input = rcu_dereference(steam->input);
+	battery = rcu_dereference(steam->battery);
 	rcu_read_unlock();
 
+	if (battery) {
+		RCU_INIT_POINTER(steam->battery, NULL);
+		synchronize_rcu();
+		power_supply_unregister(battery);
+	}
 	if (input) {
 		RCU_INIT_POINTER(steam->input, NULL);
 		synchronize_rcu();
@@ -851,12 +946,44 @@ static void steam_do_input_event(struct steam_device *steam,
 	input_sync(input);
 }
 
+/*
+ * The size for this message payload is 11.
+ * The known values are:
+ *  Offset| Type  | Meaning
+ * -------+-------+---------------------------
+ *  4-7   | u32   | sequence number
+ *  8-11  | --    | always 0
+ *  12-13 | u16   | voltage (mV)
+ *  14    | u8    | battery percent
+ */
+static void steam_do_battery_event(struct steam_device *steam,
+		struct power_supply *battery, u8 *data)
+{
+	unsigned long flags;
+
+	s16 volts = steam_le16(data + 12);
+	u8 batt = data[14];
+
+	/* Creating the battery may have failed */
+	rcu_read_lock();
+	battery = rcu_dereference(steam->battery);
+	if (likely(battery)) {
+		spin_lock_irqsave(&steam->lock, flags);
+		steam->voltage = volts;
+		steam->battery_charge = batt;
+		spin_unlock_irqrestore(&steam->lock, flags);
+		power_supply_changed(battery);
+	}
+	rcu_read_unlock();
+}
+
 static int steam_raw_event(struct hid_device *hdev,
 			struct hid_report *report, u8 *data,
 			int size)
 {
 	struct steam_device *steam = hid_get_drvdata(hdev);
 	struct input_dev *input;
+	struct power_supply *battery;
 
 	if (!steam)
 		return 0;
@@ -914,7 +1041,19 @@ static int steam_raw_event(struct hid_device *hdev,
 		}
 		break;
 	case STEAM_EV_BATTERY:
-		/* TODO: battery info */
+		if (steam->quirks & STEAM_QUIRK_WIRELESS) {
+			rcu_read_lock();
+			battery = rcu_dereference(steam->battery);
+			if (likely(battery)) {
+				steam_do_battery_event(steam, battery, data);
+			} else {
+				dbg_hid(
+					"%s: battery data without connect event\n",
+					__func__);
+				steam_do_connect_event(steam, true);
+			}
+			rcu_read_unlock();
+		}
 		break;
 	}
 	return 0;
-- 
2.17.0
