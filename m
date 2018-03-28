Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbeC1GQS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 02:16:18 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32873 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbeC1GQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 02:16:16 -0400
X-Google-Smtp-Source: AIpwx4+nJgR4fijrVYaD9fw/m3VlU9hq1uEMvksdFmuje14/7ecZMAAcUabwyPeZ/7HqB2dlhzKVRA==
From: Nicolas Boichat <drinkcat@chromium.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        groeck@chromium.org, dtor@chromium.org,
        Haridhar Kalvala <haridhar.kalvala@intel.com>
Subject: [PATCH] HID: google: Enable PM Full On mode when adjusting backlight
Date: Wed, 28 Mar 2018 14:16:10 +0800
Message-Id: <20180328061610.206090-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.17.0.rc1.321.gba9d0f2565-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haridhar Kalvala <haridhar.kalvala@intel.com>

hammer LED backlight brightness is not getting set when USB
device is in suspend state.

This patch fixes the issue by requesting USB HID device to be
in FULLON mode, so that sending hardware output report and
hardware raw request won't fail to set brightness, and set
device back to NORMAL mode once this call returns.

Signed-off-by: Haridhar Kalvala <haridhar.kalvala@intel.com>
Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 drivers/hid/hid-google-hammer.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

Changes from version on Chromium OS gerrit
(https://chromium-review.googlesource.com/735259):
 - Reworded and reflowed commit message, as well as comment in code.

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 6486469ce0f64..7b8e17b03cb86 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -41,6 +41,16 @@ static int hammer_kbd_brightness_set_blocking(struct led_classdev *cdev,
 	led->buf[0] = 0;
 	led->buf[1] = br;
 
+	/*
+	 * Request USB HID device to be in Full On mode, so that sending
+	 * hardware output report and hardware raw request won't fail.
+	 */
+	ret = hid_hw_power(led->hdev, PM_HINT_FULLON);
+	if (ret < 0) {
+		hid_err(led->hdev, "failed: device not resumed %d\n", ret);
+		return ret;
+	}
+
 	ret = hid_hw_output_report(led->hdev, led->buf, sizeof(led->buf));
 	if (ret == -ENOSYS)
 		ret = hid_hw_raw_request(led->hdev, 0, led->buf,
@@ -50,6 +60,10 @@ static int hammer_kbd_brightness_set_blocking(struct led_classdev *cdev,
 	if (ret < 0)
 		hid_err(led->hdev, "failed to set keyboard backlight: %d\n",
 			ret);
+
+	/* Request USB HID device back to Normal Mode. */
+	hid_hw_power(led->hdev, PM_HINT_NORMAL);
+
 	return ret;
 }
 
-- 
2.17.0.rc1.321.gba9d0f2565-goog
