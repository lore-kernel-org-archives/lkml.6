Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BFFC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1EE2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1EE2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbeIGPP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:15:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728685AbeIGPP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:15:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C8DF40261AE;
        Fri,  7 Sep 2018 10:35:07 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-25.ams2.redhat.com [10.36.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E083F63F4A;
        Fri,  7 Sep 2018 10:35:05 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Simon Wood <simon@mungewell.org>,
        Olivier Gay <ogay@logitech.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 7/7] HID: logitech-hidpp: support the G900 over wireless
Date:   Fri,  7 Sep 2018 12:34:50 +0200
Message-Id: <20180907103450.13890-8-benjamin.tissoires@redhat.com>
In-Reply-To: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
References: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 07 Sep 2018 10:35:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 07 Sep 2018 10:35:07 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The receiver of the G900 is similar to a Unifying one. However,
if we switch the receiver into the DJ mode through hid-logitech-dj,
the reports emitted by the mouse are from a new kind. Instead of finding
out what they are, and given that only one device should be connected
to the receiver, just use hid-logitech-hidpp.

The battery is not yet supported in the kernel, but at least the
input nodes are now named after the mouse.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-ids.h            |  1 +
 drivers/hid/hid-logitech-hidpp.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b366976e928c..f3de8562a92b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -745,6 +745,7 @@
 #define USB_DEVICE_ID_LOGITECH_G700_RECEIVER		0xc531
 #define USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER_2	0xc532
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2		0xc534
+#define USB_DEVICE_ID_LOGITECH_G900_RECEIVER		0xc539
 #define USB_DEVICE_ID_SPACETRAVELLER	0xc623
 #define USB_DEVICE_ID_SPACENAVIGATOR	0xc626
 #define USB_DEVICE_ID_DINOVO_DESKTOP	0xc704
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0ab7f8b66b83..2e264869b096 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -68,6 +68,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_HI_RES_SCROLL_X2120		BIT(27)
 #define HIDPP_QUIRK_HI_RES_SCROLL_X2121		BIT(28)
 #define HIDPP_QUIRK_RECEIVER			BIT(29)
+#define HIDPP_QUIRK_FORCE_OPEN			BIT(30)
 
 /* Convenience constant to check for any high-res support. */
 #define HIDPP_QUIRK_HI_RES_SCROLL	(HIDPP_QUIRK_HI_RES_SCROLL_1P0 | \
@@ -3584,6 +3585,12 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto hid_hw_start_fail;
 	}
 
+	if (hidpp->quirks & HIDPP_QUIRK_FORCE_OPEN) {
+		ret = hid_hw_open(hdev);
+		if (ret)
+			goto hid_hw_open_fail;
+	}
+
 	return ret;
 
 hid_hw_init_fail:
@@ -3608,6 +3615,9 @@ static void hidpp_remove(struct hid_device *hdev)
 
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 
+	if (hidpp->quirks & HIDPP_QUIRK_FORCE_OPEN)
+		hid_hw_close(hdev);
+
 	if (hidpp->quirks & HIDPP_QUIRK_CLASS_G920)
 		hidpp_ff_deinit(hdev);
 
@@ -3674,6 +3684,11 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* G700 over Wireless */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G700_RECEIVER),
 	  .driver_data = HIDPP_QUIRK_RECEIVER | HIDPP_QUIRK_UNIFYING },
+	{ /* G900 over Wireless */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
+		USB_DEVICE_ID_LOGITECH_G900_RECEIVER),
+	  .driver_data = HIDPP_QUIRK_RECEIVER | HIDPP_QUIRK_UNIFYING |
+			 HIDPP_QUIRK_FORCE_OPEN},
 
 	{ LDJ_DEVICE(HID_ANY_ID) },
 
-- 
2.14.3

