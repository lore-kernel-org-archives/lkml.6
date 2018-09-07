Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2329CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBAE82077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBAE82077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbeIGPPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:15:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728619AbeIGPPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:15:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF5CB8575A;
        Fri,  7 Sep 2018 10:34:58 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-25.ams2.redhat.com [10.36.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F31D63F4A;
        Fri,  7 Sep 2018 10:34:57 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Simon Wood <simon@mungewell.org>,
        Olivier Gay <ogay@logitech.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/7] HID: logitech-hidpp: make .probe usbhid capable
Date:   Fri,  7 Sep 2018 12:34:45 +0200
Message-Id: <20180907103450.13890-3-benjamin.tissoires@redhat.com>
In-Reply-To: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
References: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 07 Sep 2018 10:34:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 07 Sep 2018 10:34:58 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current custom solution for the G920 is not the best because
hid_hw_start() is not called at the end of the .probe().
It means that any configuration retrieved after the initial hid_hw_start
would not be exposed to user space without races.

We can simply force hid_hw_start to just enable the transport layer by
not using a connect_mask. This way, we can have a common path between
USB, Unifying and Bluetooth devices.

Tested with a M185 with the non unifying receiver, a T650 and many other
unifying devices, and the T651 over Bluetooth.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-ids.h            |  2 +
 drivers/hid/hid-logitech-hidpp.c | 85 +++++++++++++++++++++-------------------
 2 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e254ae802688..537223086d6b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -741,7 +741,9 @@
 #define USB_DEVICE_ID_LOGITECH_CORDLESS_DESKTOP_LX500	0xc512
 #define USB_DEVICE_ID_MX3000_RECEIVER	0xc513
 #define USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER	0xc52b
+#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER		0xc52f
 #define USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER_2	0xc532
+#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2		0xc534
 #define USB_DEVICE_ID_SPACETRAVELLER	0xc623
 #define USB_DEVICE_ID_SPACENAVIGATOR	0xc626
 #define USB_DEVICE_ID_DINOVO_DESKTOP	0xc704
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 37abae63bb1a..d635e9685581 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3268,24 +3268,23 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hid_warn(hdev, "Cannot allocate sysfs group for %s\n",
 			 hdev->name);
 
-	if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
-		connect_mask &= ~HID_CONNECT_HIDINPUT;
-
-	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
-		ret = hid_hw_start(hdev, connect_mask);
-		if (ret) {
-			hid_err(hdev, "hw start failed\n");
-			goto hid_hw_start_fail;
-		}
-		ret = hid_hw_open(hdev);
-		if (ret < 0) {
-			dev_err(&hdev->dev, "%s:hid_hw_open returned error:%d\n",
-				__func__, ret);
-			hid_hw_stop(hdev);
-			goto hid_hw_start_fail;
-		}
+	/*
+	 * Plain USB connections need to actually call start and open
+	 * on the transport driver to allow incoming data.
+	 */
+	ret = hid_hw_start(hdev, 0);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		goto hid_hw_start_fail;
 	}
 
+	ret = hid_hw_open(hdev);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "%s:hid_hw_open returned error:%d\n",
+			__func__, ret);
+		hid_hw_stop(hdev);
+		goto hid_hw_open_fail;
+	}
 
 	/* Allow incoming packets */
 	hid_device_io_start(hdev);
@@ -3299,7 +3298,7 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		if (!connected) {
 			ret = -ENODEV;
 			hid_err(hdev, "Device not connected");
-			goto hid_hw_open_failed;
+			goto hid_hw_init_fail;
 		}
 
 		hid_info(hdev, "HID++ %u.%u device connected.\n",
@@ -3311,37 +3310,36 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_WTP)) {
 		ret = wtp_get_config(hidpp);
 		if (ret)
-			goto hid_hw_open_failed;
+			goto hid_hw_init_fail;
 	} else if (connected && (hidpp->quirks & HIDPP_QUIRK_CLASS_G920)) {
 		ret = g920_get_config(hidpp);
 		if (ret)
-			goto hid_hw_open_failed;
+			goto hid_hw_init_fail;
 	}
 
-	/* Block incoming packets */
-	hid_device_io_stop(hdev);
+	hidpp_connect_event(hidpp);
 
-	if (!(hidpp->quirks & HIDPP_QUIRK_CLASS_G920)) {
-		ret = hid_hw_start(hdev, connect_mask);
-		if (ret) {
-			hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
-			goto hid_hw_start_fail;
-		}
-	}
+	/* Reset the HID node state */
+	hid_device_io_stop(hdev);
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
 
-	/* Allow incoming packets */
-	hid_device_io_start(hdev);
+	if (hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT)
+		connect_mask &= ~HID_CONNECT_HIDINPUT;
 
-	hidpp_connect_event(hidpp);
+	/* Now export the actual inputs and hidraw nodes to the world */
+	ret = hid_hw_start(hdev, connect_mask);
+	if (ret) {
+		hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
+		goto hid_hw_start_fail;
+	}
 
 	return ret;
 
-hid_hw_open_failed:
-	hid_device_io_stop(hdev);
-	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
-		hid_hw_close(hdev);
-		hid_hw_stop(hdev);
-	}
+hid_hw_init_fail:
+	hid_hw_close(hdev);
+hid_hw_open_fail:
+	hid_hw_stop(hdev);
 hid_hw_start_fail:
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 	cancel_work_sync(&hidpp->work);
@@ -3360,10 +3358,9 @@ static void hidpp_remove(struct hid_device *hdev)
 
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 
-	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920) {
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920)
 		hidpp_ff_deinit(hdev);
-		hid_hw_close(hdev);
-	}
+
 	hid_hw_stop(hdev);
 	cancel_work_sync(&hidpp->work);
 	mutex_destroy(&hidpp->send_mutex);
@@ -3427,6 +3424,14 @@ static const struct hid_device_id hidpp_devices[] = {
 
 	{ LDJ_DEVICE(HID_ANY_ID) },
 
+	{ /* Logitech Nano (non DJ) receiver */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+			 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER) },
+
+	{ /* Logitech Nano (non DJ) receiver */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+			 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2) },
+
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
 		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
 	{}
-- 
2.14.3

