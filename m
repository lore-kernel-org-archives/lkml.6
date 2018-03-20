Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752842AbeCTLFR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:05:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752753AbeCTLFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:05:07 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 6/7] HID: multitouch: do not set HID_QUIRK_NO_INIT_REPORTS
Date: Tue, 20 Mar 2018 12:04:50 +0100
Message-Id: <20180320110451.16582-7-benjamin.tissoires@redhat.com>
In-Reply-To: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
References: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is set by default now, so there is no point setting it in the driver

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 03d00e477d0e..639c44fc0691 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -380,7 +380,6 @@ static const struct attribute_group mt_attribute_group = {
 
 static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 {
-	struct mt_device *td = hid_get_drvdata(hdev);
 	int ret;
 	u32 size = hid_report_len(report);
 	u8 *buf;
@@ -389,7 +388,7 @@ static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 	 * Do not fetch the feature report if the device has been explicitly
 	 * marked as non-capable.
 	 */
-	if (td->initial_quirks & HID_QUIRK_NO_INIT_REPORTS)
+	if (hdev->quirks & HID_QUIRK_NO_INIT_REPORTS)
 		return;
 
 	buf = hid_alloc_report_buf(report, GFP_KERNEL);
@@ -1471,21 +1470,6 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	 */
 	hdev->quirks |= HID_QUIRK_MULTI_INPUT;
 
-	/*
-	 * Some multitouch screens do not like to be polled for input
-	 * reports. Fortunately, the Win8 spec says that all touches
-	 * should be sent during each report, making the initialization
-	 * of input reports unnecessary. For Win7 devices, well, let's hope
-	 * they will still be happy (this is only be a problem if a touch
-	 * was already there while probing the device).
-	 *
-	 * In addition some touchpads do not behave well if we read
-	 * all feature reports from them. Instead we prevent
-	 * initial report fetching and then selectively fetch each
-	 * report we are interested in.
-	 */
-	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
-
 	timer_setup(&td->release_timer, mt_expired_timeout, 0);
 
 	ret = hid_parse(hdev);
-- 
2.14.3
