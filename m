Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933014AbeE2KDf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:03:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57462 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932828AbeE2J6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:58:09 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com, Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/9] Input: mt - export MT_TOOL in input_mt_init_slot()
Date: Tue, 29 May 2018 11:57:52 +0200
Message-Id: <20180529095800.13504-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
References: <20180529095800.13504-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like we require users to set a tool but input_mt_init_slots() never
set the tool bit for us. Meaning that this is a useless information the
driver tries to forward.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/input-mt.c                 | 1 +
 drivers/input/rmi4/rmi_2d_sensor.c       | 2 --
 drivers/input/touchscreen/atmel_mxt_ts.c | 2 --
 drivers/input/touchscreen/hideep.c       | 2 --
 drivers/input/touchscreen/wacom_w8001.c  | 2 --
 5 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index a1bbec9cda8d..3900686c5d0f 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -57,6 +57,7 @@ int input_mt_init_slots(struct input_dev *dev, unsigned int num_slots,
 	mt->flags = flags;
 	input_set_abs_params(dev, ABS_MT_SLOT, 0, num_slots - 1, 0, 0);
 	input_set_abs_params(dev, ABS_MT_TRACKING_ID, 0, TRKID_MAX, 0, 0);
+	input_set_abs_params(dev, ABS_MT_TOOL_TYPE, 0, MT_TOOL_MAX, 0, 0);
 
 	if (flags & (INPUT_MT_POINTER | INPUT_MT_DIRECT)) {
 		__set_bit(EV_KEY, dev->evbit);
diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
index 8bb866c7b985..23e666bd2539 100644
--- a/drivers/input/rmi4/rmi_2d_sensor.c
+++ b/drivers/input/rmi4/rmi_2d_sensor.c
@@ -186,8 +186,6 @@ static void rmi_2d_sensor_set_input_params(struct rmi_2d_sensor *sensor)
 		input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 0x0f, 0, 0);
 		input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 0x0f, 0, 0);
 		input_set_abs_params(input, ABS_MT_ORIENTATION, 0, 1, 0, 0);
-		input_set_abs_params(input, ABS_MT_TOOL_TYPE,
-				     0, MT_TOOL_MAX, 0, 0);
 
 		if (sensor->sensor_type == rmi_sensor_touchpad)
 			input_flags = INPUT_MT_POINTER;
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 54fe190fd4bc..0dcf48100dc1 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2021,8 +2021,6 @@ static int mxt_initialize_input_device(struct mxt_data *data)
 	}
 
 	if (data->multitouch == MXT_TOUCH_MULTITOUCHSCREEN_T100) {
-		input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE,
-				     0, MT_TOOL_MAX, 0, 0);
 		input_set_abs_params(input_dev, ABS_MT_DISTANCE,
 				     MXT_DISTANCE_ACTIVE_TOUCH,
 				     MXT_DISTANCE_HOVERING,
diff --git a/drivers/input/touchscreen/hideep.c b/drivers/input/touchscreen/hideep.c
index f1cd4dd9a4a3..980539d8d551 100644
--- a/drivers/input/touchscreen/hideep.c
+++ b/drivers/input/touchscreen/hideep.c
@@ -799,8 +799,6 @@ static int hideep_init_input(struct hideep_ts *ts)
 	input_set_capability(ts->input_dev, EV_ABS, ABS_MT_POSITION_Y);
 	input_set_abs_params(ts->input_dev, ABS_MT_PRESSURE, 0, 65535, 0, 0);
 	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
-	input_set_abs_params(ts->input_dev, ABS_MT_TOOL_TYPE,
-			     0, MT_TOOL_MAX, 0, 0);
 	touchscreen_parse_properties(ts->input_dev, true, &ts->prop);
 
 	if (ts->prop.max_x == 0 || ts->prop.max_y == 0) {
diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 3715d1eace92..946dca30560b 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -529,8 +529,6 @@ static int w8001_setup_touch(struct w8001 *w8001, char *basename,
 					0, touch.x, 0, 0);
 		input_set_abs_params(dev, ABS_MT_POSITION_Y,
 					0, touch.y, 0, 0);
-		input_set_abs_params(dev, ABS_MT_TOOL_TYPE,
-					0, MT_TOOL_MAX, 0, 0);
 		input_abs_set_res(dev, ABS_MT_POSITION_X, touch.panel_res);
 		input_abs_set_res(dev, ABS_MT_POSITION_Y, touch.panel_res);
 
-- 
2.14.3
