Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbeCTWf2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 18:35:28 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43036 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeCTWbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 18:31:44 -0400
X-Google-Smtp-Source: AG47ELvFWmApT+p7ejiTomSCZQEKPehCc4kyIchehORbSs+UKzGvZFYW5fw1rysNCDtYGEXhOGbxLQ==
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org, Benson Leung <bleung@chromium.org>
Cc: Nick Dyer <nick@shmanahar.org>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/14] Input: atmel_mxt_ts - do not pass suspend mode in platform data
Date: Tue, 20 Mar 2018 15:31:25 -0700
Message-Id: <20180320223138.234724-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
References: <20180320223138.234724-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way we are supposed to put controller to sleep and wake it up does not
depend on the platform, but rather on controller itself, so we want to get
rid of suspend mode in platform data (and eventually get rid of platform
data completely). Unfortunately some early chromebooks (the original Pixel,
Acer C720) were shipped with config that requires manually re-enabling
touch reporting in T9. We will sort it out, but in the meantime let's
switch to a simple DMI quirk.

We'll keep pdata->suspend_mode for now and remove it when we rework
chromeos-laptop driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 27 +++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 7659bc48f1db8..20e1224d1a6db 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -324,6 +324,8 @@ struct mxt_data {
 
 	/* for config update handling */
 	struct completion crc_completion;
+
+	enum mxt_suspend_mode suspend_mode;
 };
 
 struct mxt_vb2_buffer {
@@ -2868,7 +2870,7 @@ static const struct attribute_group mxt_attr_group = {
 
 static void mxt_start(struct mxt_data *data)
 {
-	switch (data->pdata->suspend_mode) {
+	switch (data->suspend_mode) {
 	case MXT_SUSPEND_T9_CTRL:
 		mxt_soft_reset(data);
 
@@ -2886,12 +2888,11 @@ static void mxt_start(struct mxt_data *data)
 		mxt_t6_command(data, MXT_COMMAND_CALIBRATE, 1, false);
 		break;
 	}
-
 }
 
 static void mxt_stop(struct mxt_data *data)
 {
-	switch (data->pdata->suspend_mode) {
+	switch (data->suspend_mode) {
 	case MXT_SUSPEND_T9_CTRL:
 		/* Touch disable */
 		mxt_write_object(data,
@@ -2954,8 +2955,6 @@ static const struct mxt_platform_data *mxt_parse_dt(struct i2c_client *client)
 		pdata->t19_keymap = keymap;
 	}
 
-	pdata->suspend_mode = MXT_SUSPEND_DEEP_SLEEP;
-
 	return pdata;
 }
 #else
@@ -3109,6 +3108,21 @@ mxt_get_platform_data(struct i2c_client *client)
 	return ERR_PTR(-EINVAL);
 }
 
+static const struct dmi_system_id chromebook_T9_suspend_dmi[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GOOGLE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Link"),
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Peppy"),
+		},
+	},
+	{ }
+};
+
 static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct mxt_data *data;
@@ -3135,6 +3149,9 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	init_completion(&data->reset_completion);
 	init_completion(&data->crc_completion);
 
+	data->suspend_mode = dmi_check_system(chromebook_T9_suspend_dmi) ?
+		MXT_SUSPEND_T9_CTRL : MXT_SUSPEND_DEEP_SLEEP;
+
 	data->reset_gpio = devm_gpiod_get_optional(&client->dev,
 						   "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(data->reset_gpio)) {
-- 
2.16.2.804.g6dcf76e118-goog
