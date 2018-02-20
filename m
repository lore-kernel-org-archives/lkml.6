Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753263AbeBTTdv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 14:33:51 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36451 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752441AbeBTTdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 14:33:43 -0500
X-Google-Smtp-Source: AH8x227UpalGJpcmyMa4gZ4MDzGWFf68UFA7eLuVSB2iF//gBSv4MKxN3R4fCS+c7xTw/eALZn6u2w==
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH v2 3/3] HID: steam: add battery device
Date: Tue, 20 Feb 2018 20:33:06 +0100
Message-Id: <20180220193306.28748-4-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220193306.28748-1-rodrigorivascosta@gmail.com>
References: <20180220193306.28748-1-rodrigorivascosta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wireless Steam Controller is battery operated, so add the battery
device and power information.

Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
---
 drivers/hid/hid-steam.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index c9d0f909c8a0..d6926e86d664 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -34,6 +34,10 @@ struct steam_device {
 	struct work_struct work_connect;
 	bool connected;
 	char serial_no[11];
+	struct power_supply_desc battery_desc;
+	struct power_supply *battery;
+	u8 battery_charge;
+	u16 voltage;
 };
 
 static int steam_recv_report(struct steam_device *steam,
@@ -140,6 +144,85 @@ static void steam_input_close(struct input_dev *dev)
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
+	steam->battery = battery;
+	power_supply_powers(steam->battery, &steam->hdev->dev);
+	return 0;
+}
+
 static int steam_register(struct steam_device *steam)
 {
 	struct hid_device *hdev = steam->hdev;
@@ -209,6 +292,10 @@ static int steam_register(struct steam_device *steam)
 
 	steam->input = input;
 
+	/* ignore battery errors, we can live without it */
+	if (steam->quirks & STEAM_QUIRK_WIRELESS)
+		steam_battery_register(steam);
+
 	return 0;
 
 input_register_fail:
@@ -218,6 +305,10 @@ static int steam_register(struct steam_device *steam)
 
 static void steam_unregister(struct steam_device *steam)
 {
+	if (steam->battery) {
+		power_supply_unregister(steam->battery);
+		steam->battery = NULL;
+	}
 	if (steam->input) {
 		hid_info(steam->hdev, "Steam Controller '%s' disconnected",
 				steam->serial_no);
@@ -500,6 +591,40 @@ static void steam_do_input_event(struct steam_device *steam, u8 *data)
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
+static void steam_do_battery_event(struct steam_device *steam, u8 *data)
+{
+	unsigned long flags;
+	s16 volts = le16_to_cpup((__le16 *)(data + 12));
+	u8 batt = data[14];
+
+	if (unlikely(!steam->input)) {
+		dbg_hid("%s: battery data without connect event\n", __func__);
+		steam_do_connect_event(steam, true);
+		return;
+	}
+
+	/* Creating the battery may have failed */
+	if (unlikely(!steam->battery))
+		return;
+
+	spin_lock_irqsave(&steam->lock, flags);
+	steam->voltage = volts;
+	steam->battery_charge = batt;
+	spin_unlock_irqrestore(&steam->lock, flags);
+
+	power_supply_changed(steam->battery);
+}
+
 static int steam_raw_event(struct hid_device *hdev,
 			struct hid_report *report, u8 *data,
 			int size)
@@ -545,7 +670,8 @@ static int steam_raw_event(struct hid_device *hdev,
 		}
 		break;
 	case 0x04:
-		/* TODO battery status */
+		if (steam->quirks & STEAM_QUIRK_WIRELESS)
+			steam_do_battery_event(steam, data);
 		break;
 	}
 	return 0;
-- 
2.16.1
