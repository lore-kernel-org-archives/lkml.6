Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeDIJLR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 05:11:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751348AbeDIJLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 05:11:13 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>,
        Benjamin Berg <bberg@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 6/9] Input: elantech - query the resolution in query_info
Date: Mon,  9 Apr 2018 11:10:48 +0200
Message-Id: <20180409091051.2944-7-benjamin.tissoires@redhat.com>
In-Reply-To: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
References: <20180409091051.2944-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command ETP_RESOLUTION_QUERY also contains the bus information.
It is better to fetch it once, while we are querying for device
information.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
no changes in v2

 drivers/input/mouse/elantech.c | 27 +++++++++++++++------------
 drivers/input/mouse/elantech.h |  2 ++
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 980dfd7e861e..a2a14a31edb5 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1179,7 +1179,6 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 	struct elantech_data *etd = psmouse->private;
 	struct elantech_device_info *info = &etd->info;
 	unsigned int x_min = 0, y_min = 0, x_max = 0, y_max = 0, width = 0;
-	unsigned int x_res = 31, y_res = 31;
 
 	if (elantech_set_range(psmouse, &x_min, &y_min, &x_max, &y_max, &width))
 		return -1;
@@ -1232,13 +1231,6 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 		break;
 
 	case 4:
-		if (elantech_get_resolution_v4(psmouse, &x_res, &y_res)) {
-			/*
-			 * if query failed, print a warning and leave the values
-			 * zero to resemble synaptics.c behavior.
-			 */
-			psmouse_warn(psmouse, "couldn't query resolution data.\n");
-		}
 		elantech_set_buttonpad_prop(psmouse);
 		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
 		/* For X to recognize me as touchpad. */
@@ -1267,11 +1259,11 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 		break;
 	}
 
-	input_abs_set_res(dev, ABS_X, x_res);
-	input_abs_set_res(dev, ABS_Y, y_res);
+	input_abs_set_res(dev, ABS_X, info->x_res);
+	input_abs_set_res(dev, ABS_Y, info->y_res);
 	if (info->hw_version > 1) {
-		input_abs_set_res(dev, ABS_MT_POSITION_X, x_res);
-		input_abs_set_res(dev, ABS_MT_POSITION_Y, y_res);
+		input_abs_set_res(dev, ABS_MT_POSITION_X, info->x_res);
+		input_abs_set_res(dev, ABS_MT_POSITION_Y, info->y_res);
 	}
 
 	etd->y_max = y_max;
@@ -1720,6 +1712,17 @@ static int elantech_query_info(struct psmouse *psmouse,
 	/* The MSB indicates the presence of the trackpoint */
 	info->has_trackpoint = (info->capabilities[0] & 0x80) == 0x80;
 
+	info->x_res = 31;
+	info->y_res = 31;
+	if (info->hw_version == 4) {
+		if (elantech_get_resolution_v4(psmouse,
+					       &info->x_res,
+					       &info->y_res)) {
+			psmouse_warn(psmouse,
+				     "failed to query resolution data.\n");
+		}
+	}
+
 	return 0;
 }
 
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index d8ac27fe4597..851df4ce6232 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -120,6 +120,8 @@ struct elantech_device_info {
 	unsigned char debug;
 	unsigned char hw_version;
 	unsigned int fw_version;
+	unsigned int x_res;
+	unsigned int y_res;
 	bool paritycheck;
 	bool jumpy_cursor;
 	bool reports_pressure;
-- 
2.14.3
