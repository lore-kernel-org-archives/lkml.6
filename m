Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932407AbeCKT71 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 15:59:27 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39569 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932331AbeCKT7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 15:59:00 -0400
X-Google-Smtp-Source: AG47ELuXfZnhzINF5cvsgwQhLjD4FeT5hEu/AHDTm7L5Jk7IZs8f+jqLhzK5saDahE6p0+djXGNHTA==
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Cameron Gutman <aicommander@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH v5 4/4] HID: steam: add battery device.
Date: Sun, 11 Mar 2018 20:58:42 +0100
Message-Id: <20180311195842.5551-5-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180311195842.5551-1-rodrigorivascosta@gmail.com>
References: <20180311195842.5551-1-rodrigorivascosta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wireless Steam Controller is battery operated, so add the battery
device and power information.

Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
---
 drivers/hid/hid-steam.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 140 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 3d34716ae55f..188d8c1a69d7 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -19,6 +19,7 @@
 #include <linux/workqueue.h>
 #include <linux/rcupdate.h>
 #include <linux/delay.h>
+#include <linux/power_supply.h>
 #include "hid-ids.h"
 
 MODULE_LICENSE("GPL");
@@ -44,6 +45,10 @@ struct steam_device {
 	struct work_struct work_connect;
 	bool connected;
 	char serial_no[STEAM_SERIAL_LEN + 1];
+	struct power_supply_desc battery_desc;
+	struct power_supply __rcu *battery;
+	u8 battery_charge;
+	u16 voltage;
 };
 
 static int steam_recv_report(struct steam_device *steam,
@@ -168,6 +173,85 @@ static void steam_input_close(struct input_dev *dev)
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
@@ -255,6 +339,10 @@ static int steam_register(struct steam_device *steam)
 
 	rcu_assign_pointer(steam->input, input);
 
+	/* ignore battery errors, we can live without it */
+	if (steam->quirks & STEAM_QUIRK_WIRELESS)
+		steam_battery_register(steam);
+
 	return 0;
 
 input_register_fail:
@@ -265,11 +353,18 @@ static int steam_register(struct steam_device *steam)
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
@@ -565,12 +660,44 @@ static void steam_do_input_event(struct steam_device *steam,
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
+	s16 volts = le16_to_cpup((__le16 *)(data + 12));
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
@@ -623,7 +750,19 @@ static int steam_raw_event(struct hid_device *hdev,
 		}
 		break;
 	case 0x04:
-		/* TODO battery status */
+		if (steam->quirks & STEAM_QUIRK_WIRELESS) {
+			rcu_read_lock();
+			battery = rcu_dereference(steam->battery);
+			if (likely(battery)) {
+				steam_do_battery_event(steam, battery, data);
+			} else {
+				dbg_hid(
+				  "%s: battery data without connect event\n",
+				  __func__);
+				steam_do_connect_event(steam, true);
+			}
+			rcu_read_unlock();
+		}
 		break;
 	}
 	return 0;
-- 
2.16.2
