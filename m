Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeBYSxW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 13:53:22 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37320 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeBYSxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 13:53:10 -0500
X-Google-Smtp-Source: AG47ELv2mulU+/gnuSbT4XfFM/FGrJNVp5beRfQR3paY1SDWp4loStsrkPiCM+kkII/5P0B0F1ldcQ==
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Cameron Gutman <aicommander@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH v3 2/3] HID: steam: add serial number information.
Date: Sun, 25 Feb 2018 19:52:49 +0100
Message-Id: <20180225185250.10759-3-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180225185250.10759-1-rodrigorivascosta@gmail.com>
References: <20180225185250.10759-1-rodrigorivascosta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device has a feature report to send and receive commands.
Use it to get the serial number and set the device's uniq value.

Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
---
 drivers/hid/hid-steam.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index 59dbcb95f349..405fae2d2e4b 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -17,6 +17,8 @@
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/workqueue.h>
+#include <linux/delay.h>
+#include <linux/rcupdate.h>
 #include "hid-ids.h"
 
 MODULE_LICENSE("GPL");
@@ -40,8 +42,99 @@ struct steam_device {
 	unsigned long quirks;
 	struct work_struct work_connect;
 	bool connected;
+	char serial_no[11];
 };
 
+static int steam_recv_report(struct steam_device *steam,
+		u8 *data, int size)
+{
+	struct hid_report *r;
+	u8 *buf;
+	int ret;
+
+	r = steam->hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0];
+	if (hid_report_len(r) < 64)
+		return -EINVAL;
+	buf = hid_alloc_report_buf(r, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/*
+	 * The report ID is always 0, so strip the first byte from the output.
+	 * hid_report_len() is not counting the report ID, so +1 to the length
+	 * or else we get a EOVERFLOW. We are safe from a buffer overflow
+	 * because hid_alloc_report_buf() allocates +7 bytes.
+	 */
+	ret = hid_hw_raw_request(steam->hdev, 0x00,
+			buf, hid_report_len(r) + 1,
+			HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+	if (ret > 0)
+		memcpy(data, buf + 1, min(size, ret - 1));
+	kfree(buf);
+	return ret;
+}
+
+static int steam_send_report(struct steam_device *steam,
+		u8 *cmd, int size)
+{
+	struct hid_report *r;
+	u8 *buf;
+	int retry;
+	int ret;
+
+	r = steam->hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0];
+	if (hid_report_len(r) < 64)
+		return -EINVAL;
+	buf = hid_alloc_report_buf(r, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	/* The report ID is always 0 */
+	memcpy(buf + 1, cmd, size);
+
+	/*
+	 * Sometimes the wireless controller fails with EPIPE
+	 * when sending a feature report.
+	 * Doing a HID_REQ_GET_REPORT and waiting for a while
+	 * seems to fix that.
+	 */
+	for (retry = 0; retry < 10; ++retry) {
+		ret = hid_hw_raw_request(steam->hdev, 0,
+				buf, size + 1,
+				HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+		if (ret != -EPIPE)
+			break;
+		steam_recv_report(steam, NULL, 0);
+		msleep(50);
+	}
+	kfree(buf);
+	if (ret < 0)
+		hid_err(steam->hdev, "%s: error %d (%*ph)\n", __func__,
+				ret, size, cmd);
+	return ret;
+}
+
+static int steam_get_serial(struct steam_device *steam)
+{
+	/*
+	 * Send: 0xae 0x15 0x01
+	 * Recv: 0xae 0x15 0x01 serialnumber (10 chars)
+	 */
+	int ret;
+	u8 cmd[] = {0xae, 0x15, 0x01};
+	u8 reply[14];
+
+	ret = steam_send_report(steam, cmd, sizeof(cmd));
+	if (ret < 0)
+		return ret;
+	ret = steam_recv_report(steam, reply, sizeof(reply));
+	if (ret < 0)
+		return ret;
+	reply[13] = 0;
+	strcpy(steam->serial_no, reply + 3);
+	return 0;
+}
+
 static int steam_input_open(struct input_dev *dev)
 {
 	struct steam_device *steam = input_get_drvdata(dev);
@@ -70,7 +163,12 @@ static int steam_register(struct steam_device *steam)
 		return -ENODEV;
 	}
 
-	hid_info(hdev, "Steam Controller connected");
+	ret = steam_get_serial(steam);
+	if (ret)
+		return ret;
+
+	hid_info(hdev, "Steam Controller '%s' connected",
+			steam->serial_no);
 
 	input = input_allocate_device();
 	if (!input)
@@ -85,7 +183,7 @@ static int steam_register(struct steam_device *steam)
 		"Wireless Steam Controller" :
 		"Steam Controller";
 	input->phys = hdev->phys;
-	input->uniq = hdev->uniq;
+	input->uniq = steam->serial_no;
 	input->id.bustype = hdev->bus;
 	input->id.vendor = hdev->vendor;
 	input->id.product = hdev->product;
@@ -154,7 +252,8 @@ static void steam_unregister(struct steam_device *steam)
 	if (input) {
 		RCU_INIT_POINTER(steam->input, NULL);
 		synchronize_rcu();
-		hid_info(steam->hdev, "Steam Controller disconnected");
+		hid_info(steam->hdev, "Steam Controller '%s' disconnected",
+				steam->serial_no);
 		input_unregister_device(input);
 	}
 }
-- 
2.16.2
