Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nVPGEdfkGFtUJwAAmS7hNA
	; Thu, 07 Jun 2018 07:56:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BE3426089E; Thu,  7 Jun 2018 07:56:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3F129605A2;
	Thu,  7 Jun 2018 07:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3F129605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753592AbeFGH4P (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:56:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753550AbeFGHzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:55:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D066F4007391;
        Thu,  7 Jun 2018 07:55:09 +0000 (UTC)
Received: from plouf.banquise.eu.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CB582026993;
        Thu,  7 Jun 2018 07:55:08 +0000 (UTC)
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 10/13] HID: microsoft: support the Surface Dial
Date: Thu,  7 Jun 2018 09:54:45 +0200
Message-Id: <20180607075448.5706-11-benjamin.tissoires@redhat.com>
In-Reply-To: <20180607075448.5706-1-benjamin.tissoires@redhat.com>
References: <20180607075448.5706-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 07 Jun 2018 07:55:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 07 Jun 2018 07:55:09 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tool works nicely with hid-generic, but it ends up creating 9
different input nodes with most of them only having ABS_MISC set.

Filter the axis out, which reduces the amount of devices to 2. One is
the proper System Multi-axis collection, the other exported device
seems to provide SLEEP and POWER Key, not sure how one can trigger
those events though.

Filtering the ABS_X and ABS_Y axes also prevents udev to detect this as
a touchscreen.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2
---
 drivers/hid/hid-microsoft.c | 49 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 96e7d3231d2f..72d983626afd 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -22,12 +22,13 @@
 
 #include "hid-ids.h"
 
-#define MS_HIDINPUT		0x01
-#define MS_ERGONOMY		0x02
-#define MS_PRESENTER		0x04
-#define MS_RDESC		0x08
-#define MS_NOGET		0x10
-#define MS_DUPLICATE_USAGES	0x20
+#define MS_HIDINPUT		BIT(0)
+#define MS_ERGONOMY		BIT(1)
+#define MS_PRESENTER		BIT(2)
+#define MS_RDESC		BIT(3)
+#define MS_NOGET		BIT(4)
+#define MS_DUPLICATE_USAGES	BIT(5)
+#define MS_SURFACE_DIAL		BIT(6)
 
 static __u8 *ms_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
@@ -130,6 +131,30 @@ static int ms_presenter_8k_quirk(struct hid_input *hi, struct hid_usage *usage,
 	return 1;
 }
 
+static int ms_surface_dial_quirk(struct hid_input *hi, struct hid_field *field,
+		struct hid_usage *usage, unsigned long **bit, int *max)
+{
+	switch (usage->hid & HID_USAGE_PAGE) {
+	case 0xff070000:
+		/* fall-through */
+	case HID_UP_DIGITIZER:
+		/* ignore those axis */
+		return -1;
+	case HID_UP_GENDESK:
+		switch (usage->hid) {
+		case HID_GD_X:
+			/* fall-through */
+		case HID_GD_Y:
+			/* fall-through */
+		case HID_GD_RFKILL_BTN:
+			/* ignore those axis */
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
 static int ms_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
@@ -146,6 +171,13 @@ static int ms_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 			ms_presenter_8k_quirk(hi, usage, bit, max))
 		return 1;
 
+	if (quirks & MS_SURFACE_DIAL) {
+		int ret = ms_surface_dial_quirk(hi, field, usage, bit, max);
+
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -229,6 +261,9 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (quirks & MS_NOGET)
 		hdev->quirks |= HID_QUIRK_NOGET;
 
+	if (quirks & MS_SURFACE_DIAL)
+		hdev->quirks |= HID_QUIRK_INPUT_PER_APP;
+
 	ret = hid_parse(hdev);
 	if (ret) {
 		hid_err(hdev, "parse failed\n");
@@ -281,6 +316,8 @@ static const struct hid_device_id ms_devices[] = {
 
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT),
 		.driver_data = MS_PRESENTER },
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, 0x091B),
+		.driver_data = MS_SURFACE_DIAL },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, ms_devices);
-- 
2.14.3
