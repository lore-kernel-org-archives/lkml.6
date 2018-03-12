Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932451AbeCLTJP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 15:09:15 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41867 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbeCLTJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 15:09:13 -0400
X-Google-Smtp-Source: AG47ELvJVNJtlZ1YuvKhOL1samVkRf5yAWgSaKpfAp9EOnHEnNbku75R3ciI/BJm0/G5pwn21SMIEw==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] Input: atmel_mxt_ts - do not pass suspend mode in platform data
Date: Mon, 12 Mar 2018 12:08:54 -0700
Message-Id: <20180312190907.174301-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
In-Reply-To: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
References: <20180312190907.174301-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way we are supposed to put controller to sleep and wake it up does not
depend on the platform, but rather on controller itself. Controllers using
T9 require manipulating T9 control register, while others, using newer
T100, should be put to sleep by adjusting T7 power config.

We'll keep pdata->suspend_mode for now and remove it when we rework
chromeos-laptop driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 7659bc48f1db8..1aabfae1297ba 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -2868,8 +2868,8 @@ static const struct attribute_group mxt_attr_group = {
 
 static void mxt_start(struct mxt_data *data)
 {
-	switch (data->pdata->suspend_mode) {
-	case MXT_SUSPEND_T9_CTRL:
+	switch (data->multitouch) {
+	case MXT_TOUCH_MULTI_T9:
 		mxt_soft_reset(data);
 
 		/* Touch enable */
@@ -2878,7 +2878,7 @@ static void mxt_start(struct mxt_data *data)
 				MXT_TOUCH_MULTI_T9, MXT_T9_CTRL, 0x83);
 		break;
 
-	case MXT_SUSPEND_DEEP_SLEEP:
+	case MXT_TOUCH_MULTITOUCHSCREEN_T100:
 	default:
 		mxt_set_t7_power_cfg(data, MXT_POWER_CFG_RUN);
 
@@ -2886,19 +2886,18 @@ static void mxt_start(struct mxt_data *data)
 		mxt_t6_command(data, MXT_COMMAND_CALIBRATE, 1, false);
 		break;
 	}
-
 }
 
 static void mxt_stop(struct mxt_data *data)
 {
-	switch (data->pdata->suspend_mode) {
-	case MXT_SUSPEND_T9_CTRL:
+	switch (data->multitouch) {
+	case MXT_TOUCH_MULTI_T9:
 		/* Touch disable */
 		mxt_write_object(data,
 				MXT_TOUCH_MULTI_T9, MXT_T9_CTRL, 0);
 		break;
 
-	case MXT_SUSPEND_DEEP_SLEEP:
+	case MXT_TOUCH_MULTITOUCHSCREEN_T100:
 	default:
 		mxt_set_t7_power_cfg(data, MXT_POWER_CFG_DEEPSLEEP);
 		break;
@@ -2954,8 +2953,6 @@ static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
 		pdata->t19_keymap = keymap;
 	}
 
-	pdata->suspend_mode = MXT_SUSPEND_DEEP_SLEEP;
-
 	return pdata;
 }
 #else
-- 
2.16.2.660.g709887971b-goog
