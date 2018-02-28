Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933291AbeB1Sol (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 13:44:41 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44970 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933123AbeB1Snr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 13:43:47 -0500
X-Google-Smtp-Source: AH8x225AD6wb14/V1PiXm6r9vQc9RgabX9yzY9p5k1NIsqQiwDSBqHul/BnVWBcWHEoYBNNwrd9nxQ==
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Cameron Gutman <aicommander@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH v4 3/4] HID: steam: command to check wireless connection
Date: Wed, 28 Feb 2018 19:43:21 +0100
Message-Id: <20180228184322.29636-4-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180228184322.29636-1-rodrigorivascosta@gmail.com>
References: <20180228184322.29636-1-rodrigorivascosta@gmail.com>
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
index 9e4b1f640bef..894b678685d3 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -114,6 +114,11 @@ static int steam_send_report(struct steam_device *steam,
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
@@ -135,6 +140,16 @@ static int steam_get_serial(struct steam_device *steam)
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
@@ -363,6 +378,7 @@ static int steam_probe(struct hid_device *hdev,
 			goto hid_hw_open_fail;
 		}
 		hid_info(hdev, "Steam wireless receiver connected");
+		steam_request_conn_status(steam);
 	} else {
 		ret = steam_register(steam);
 		if (ret) {
-- 
2.16.2
