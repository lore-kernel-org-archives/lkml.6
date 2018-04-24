Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932911AbeDXIFv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:05:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932822AbeDXIEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:04:53 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>, Mario.Limonciello@dell.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 6/6] HID: multitouch: implement precision touchpad latency and switches
Date: Tue, 24 Apr 2018 10:04:37 +0200
Message-Id: <20180424080437.21367-7-benjamin.tissoires@redhat.com>
In-Reply-To: <20180424080437.21367-1-benjamin.tissoires@redhat.com>
References: <20180424080437.21367-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Win 8.1 precision touchpad spec introduce new modes for touchpads
that can come in handy[1].

Implement the settings of these modes, so we are not taken off-guard if
a firmware decides to enforce them.

[1] https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/windows-precision-touchpad-required-hid-top-level-collections

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 34 +++++++++++++++++++++++++++++-----
 include/linux/hid.h          |  3 +++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 8878de9eedba..82c98bf14d60 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -81,6 +81,11 @@ MODULE_LICENSE("GPL");
 
 #define MT_BUTTONTYPE_CLICKPAD		0
 
+enum latency_mode {
+	HID_LATENCY_NORMAL = 0,
+	HID_LATENCY_HIGH = 1,
+};
+
 #define MT_IO_FLAGS_RUNNING		0
 #define MT_IO_FLAGS_ACTIVE_SLOTS	1
 #define MT_IO_FLAGS_PENDING_SLOTS	2
@@ -1156,7 +1161,10 @@ static void mt_report(struct hid_device *hid, struct hid_report *report)
 
 static bool mt_need_to_apply_feature(struct hid_device *hdev,
 				     struct hid_field *field,
-				     struct hid_usage *usage)
+				     struct hid_usage *usage,
+				     enum latency_mode latency,
+				     bool surface_switch,
+				     bool button_switch)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
 	struct mt_class *cls = &td->mtclass;
@@ -1195,12 +1203,25 @@ static bool mt_need_to_apply_feature(struct hid_device *hdev,
 			}
 		}
 		break;
+
+	case HID_DG_LATENCYMODE:
+		field->value[index] = latency;
+		return 1;
+
+	case HID_DG_SURFACESWITCH:
+		field->value[index] = surface_switch;
+		return 1;
+
+	case HID_DG_BUTTONSWITCH:
+		field->value[index] = button_switch;
+		return 1;
 	}
 
 	return false; /* no need to update the report */
 }
 
-static void mt_set_modes(struct hid_device *hdev)
+static void mt_set_modes(struct hid_device *hdev, enum latency_mode latency,
+			 bool surface_switch, bool button_switch)
 {
 	struct hid_report_enum *rep_enum;
 	struct hid_report *rep;
@@ -1222,7 +1243,10 @@ static void mt_set_modes(struct hid_device *hdev)
 
 				if (mt_need_to_apply_feature(hdev,
 							     rep->field[i],
-							     usage))
+							     usage,
+							     latency,
+							     surface_switch,
+							     button_switch))
 					update_report = true;
 			}
 		}
@@ -1467,7 +1491,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		dev_warn(&hdev->dev, "Cannot allocate sysfs group for %s\n",
 				hdev->name);
 
-	mt_set_modes(hdev);
+	mt_set_modes(hdev, HID_LATENCY_NORMAL, true, true);
 
 	/* release .fields memory as it is not used anymore */
 	devm_kfree(&hdev->dev, td->fields);
@@ -1480,7 +1504,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 static int mt_reset_resume(struct hid_device *hdev)
 {
 	mt_release_contacts(hdev);
-	mt_set_modes(hdev);
+	mt_set_modes(hdev, HID_LATENCY_NORMAL, true, true);
 	return 0;
 }
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index d3bd83d9127f..d65ce4ab82d6 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -292,9 +292,12 @@ struct hid_item {
 #define HID_DG_CONTACTCOUNT	0x000d0054
 #define HID_DG_CONTACTMAX	0x000d0055
 #define HID_DG_SCANTIME		0x000d0056
+#define HID_DG_SURFACESWITCH	0x000d0057
+#define HID_DG_BUTTONSWITCH	0x000d0058
 #define HID_DG_BUTTONTYPE	0x000d0059
 #define HID_DG_BARRELSWITCH2	0x000d005a
 #define HID_DG_TOOLSERIALNUMBER	0x000d005b
+#define HID_DG_LATENCYMODE	0x000d0060
 
 #define HID_VD_ASUS_CUSTOM_MEDIA_KEYS	0xff310076
 /*
-- 
2.14.3
