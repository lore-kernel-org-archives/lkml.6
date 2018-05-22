Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeEVUKQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 16:10:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39505 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752634AbeEVUKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 16:10:15 -0400
X-Google-Smtp-Source: AB8JxZp5ldCXhs5K+6w/ZVMKpha+lXtVUIG6oJNIVeYbOiW/mspREQIZeqLeTtKTeS9oi+3KJzDxqg==
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        =?UTF-8?q?Cl=C3=A9ment=20VUCHENER?= <clement.vuchener@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH] HID: steam: use hid_device.driver_data instead of hid_set_drvdata()
Date: Tue, 22 May 2018 22:10:06 +0200
Message-Id: <20180522201006.14003-1-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When creating the low-level hidraw device, the reference to steam_device
was stored using hid_set_drvdata(). But this value is not guaranteed to
be kept when set before calling probe. If this pointer is reset, it
crashes when opening the emulated hidraw device.

It looks like hid_set_drvdata() is for users "avobe" this hid_device,
while hid_device.driver_data it for users "below" this one.

In this case, we are creating a virtual hidraw device, so we must use
hid_device.driver_data.

Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
---

This patch is to be applied over hid/for-4.18/hid-steam. Is this the
proper way to signal it?

I don't know exactly when the problem started. I am pretty sure that it
worked with 4.16.2, but it failed with 4.16.9. Or maybe it is caused by
upgrading the firmware of the controller, although the protocol seems
identical.

 drivers/hid/hid-steam.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index cb86cc834201..0422ec2b13d2 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -573,7 +573,7 @@ static bool steam_is_valve_interface(struct hid_device *hdev)
 
 static int steam_client_ll_parse(struct hid_device *hdev)
 {
-	struct steam_device *steam = hid_get_drvdata(hdev);
+	struct steam_device *steam = hdev->driver_data;
 
 	return hid_parse_report(hdev, steam->hdev->dev_rdesc,
 			steam->hdev->dev_rsize);
@@ -590,7 +590,7 @@ static void steam_client_ll_stop(struct hid_device *hdev)
 
 static int steam_client_ll_open(struct hid_device *hdev)
 {
-	struct steam_device *steam = hid_get_drvdata(hdev);
+	struct steam_device *steam = hdev->driver_data;
 	int ret;
 
 	ret = hid_hw_open(steam->hdev);
@@ -605,7 +605,7 @@ static int steam_client_ll_open(struct hid_device *hdev)
 
 static void steam_client_ll_close(struct hid_device *hdev)
 {
-	struct steam_device *steam = hid_get_drvdata(hdev);
+	struct steam_device *steam = hdev->driver_data;
 
 	mutex_lock(&steam->mutex);
 	steam->client_opened = false;
@@ -623,7 +623,7 @@ static int steam_client_ll_raw_request(struct hid_device *hdev,
 				size_t count, unsigned char report_type,
 				int reqtype)
 {
-	struct steam_device *steam = hid_get_drvdata(hdev);
+	struct steam_device *steam = hdev->driver_data;
 
 	return hid_hw_raw_request(steam->hdev, reportnum, buf, count,
 			report_type, reqtype);
@@ -710,7 +710,7 @@ static int steam_probe(struct hid_device *hdev,
 		ret = PTR_ERR(steam->client_hdev);
 		goto client_hdev_fail;
 	}
-	hid_set_drvdata(steam->client_hdev, steam);
+	steam->client_hdev->driver_data = steam;
 
 	/*
 	 * With the real steam controller interface, do not connect hidraw.
-- 
2.17.0
