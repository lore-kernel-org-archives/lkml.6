Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbeCKT7n (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 15:59:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36925 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932235AbeCKT66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 15:58:58 -0400
X-Google-Smtp-Source: AG47ELuvqempIF62fFahQkaP0SyxRZ5oBfT9HtZOI3ygwXcGEwzN4LzGHUjTQBR7uUVwWIKbdFccHA==
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Cameron Gutman <aicommander@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH v5 3/4] HID: steam: command to check wireless connection
Date: Sun, 11 Mar 2018 20:58:41 +0100
Message-Id: <20180311195842.5551-4-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180311195842.5551-1-rodrigorivascosta@gmail.com>
References: <20180311195842.5551-1-rodrigorivascosta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wireless adaptor does not tell if a device is already connected when
steam_probe() is run.
Use a command to request the connection status.

Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
---
 drivers/hid/hid-steam.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 03eebc4c28ba..3d34716ae55f 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -118,6 +118,11 @@ static int steam_send_report(struct steam_device *steam,
 	return ret;
 }
 
+static inline int steam_send_report_byte(struct steam_device *steam, u8 cmd)
+{
+	return steam_send_report(steam, &cmd, 1);
+}
+
 static int steam_get_serial(struct steam_device *steam)
 {
 	/*
@@ -139,6 +144,16 @@ static int steam_get_serial(struct steam_device *steam)
 	return 0;
 }
 
+/*
+ * This command requests the wireless adaptor to post an event
+ * with the connection status. Useful if this driver is loaded when
+ * the controller is already connected.
+ */
+static inline int steam_request_conn_status(struct steam_device *steam)
+{
+	return steam_send_report_byte(steam, 0xb4);
+}
+
 static int steam_input_open(struct input_dev *dev)
 {
 	struct steam_device *steam = input_get_drvdata(dev);
@@ -360,6 +375,7 @@ static int steam_probe(struct hid_device *hdev,
 			goto hid_hw_open_fail;
 		}
 		hid_info(hdev, "Steam wireless receiver connected");
+		steam_request_conn_status(steam);
 	} else {
 		ret = steam_register(steam);
 		if (ret) {
-- 
2.16.2
