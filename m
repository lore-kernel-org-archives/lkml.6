Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965181AbeEITMW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 15:12:22 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38116 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965026AbeEITMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 15:12:20 -0400
X-Google-Smtp-Source: AB8JxZpR6VxXumKmC3MV1e39Giiyo7iYmpyXBou3VD8Nk8Gw9GzWtLeBm9OgKOj1JEA0ezGi4tkMkw==
From: Dmitry Torokhov <dtor@google.com>
X-Google-Original-From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] HID: i2c-hid: check if device is there before really probing
Date: Wed,  9 May 2018 12:12:15 -0700
Message-Id: <20180509191215.77406-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dtor@chromium.org>

On many Chromebooks touch devices are multi-sourced; the components are
electrically compatible and one can be freely swapped for another without
changing the OS image or firmware.

To avoid bunch of scary messages when device is not actually present in the
system let's try testing basic communication with it and if there is no
response terminate probe early with -ENXIO.

Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
---
 drivers/hid/i2c-hid/i2c-hid.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 7230243b94d30..a59d483ff316a 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -1048,6 +1048,14 @@ static int i2c_hid_probe(struct i2c_client *client,
 	pm_runtime_enable(&client->dev);
 	device_enable_async_suspend(&client->dev);
 
+	/* Make sure there is something at this address */
+	ret = i2c_smbus_read_byte(client);
+	if (ret < 0) {
+		dev_dbg(&client->dev, "nothing at this address: %d\n", ret);
+		ret = -ENXIO;
+		goto err_pm;
+	}
+
 	ret = i2c_hid_fetch_hid_descriptor(ihid);
 	if (ret < 0)
 		goto err_pm;
-- 
2.17.0.441.gb46fe60e1d-goog
