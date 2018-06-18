Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441BBC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D2020864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D2020864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967187AbeFRIbs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:31:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34194 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936853AbeFRIbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:31:44 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BDCFFBAD;
        Mon, 18 Jun 2018 08:31:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ganzhorn <peter.ganzhorn@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter De Wachter <pdewacht@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 061/189] HID: lenovo: Add support for IBM/Lenovo Scrollpoint mice
Date:   Mon, 18 Jun 2018 10:12:37 +0200
Message-Id: <20180618081211.763477785@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: pgzh <peter.ganzhorn@gmail.com>

[ Upstream commit a230cd52b8a2be39cd6e9a13b3e62af57f21372a ]

The IBM/Lenovo Scrollpoint mice feature a trackpoint-like stick instead of a
scrolling wheel capable of 2-D (vertical+horizontal) scrolling.  hid-generic
does only expose 1-D (vertical) scrolling functionality for these mice.  This
patch adds support for horizontal scrolling for the IBM/Lenovo Scrollpoint mice
to hid-lenovo.

[jkosina@suse.cz: remove change versioning from git changelog]
Signed-off-by: Peter Ganzhorn <peter.ganzhorn@gmail.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Peter De Wachter <pdewacht@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/Kconfig      |    7 ++++---
 drivers/hid/hid-ids.h    |    8 ++++++++
 drivers/hid/hid-lenovo.c |   36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 3 deletions(-)

--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -436,10 +436,11 @@ config HID_LENOVO
 	select NEW_LEDS
 	select LEDS_CLASS
 	---help---
-	Support for Lenovo devices that are not fully compliant with HID standard.
+	Support for IBM/Lenovo devices that are not fully compliant with HID standard.
 
-	Say Y if you want support for the non-compliant features of the Lenovo
-	Thinkpad standalone keyboards, e.g:
+	Say Y if you want support for horizontal scrolling of the IBM/Lenovo
+	Scrollpoint mice or the non-compliant features of the Lenovo Thinkpad
+	standalone keyboards, e.g:
 	- ThinkPad USB Keyboard with TrackPoint (supports extra LEDs and trackpoint
 	  configuration)
 	- ThinkPad Compact Bluetooth Keyboard with TrackPoint (supports Fn keys)
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -532,6 +532,13 @@
 #define USB_VENDOR_ID_HUION		0x256c
 #define USB_DEVICE_ID_HUION_TABLET	0x006e
 
+#define USB_VENDOR_ID_IBM					0x04b3
+#define USB_DEVICE_ID_IBM_SCROLLPOINT_III			0x3100
+#define USB_DEVICE_ID_IBM_SCROLLPOINT_PRO			0x3103
+#define USB_DEVICE_ID_IBM_SCROLLPOINT_OPTICAL			0x3105
+#define USB_DEVICE_ID_IBM_SCROLLPOINT_800DPI_OPTICAL		0x3108
+#define USB_DEVICE_ID_IBM_SCROLLPOINT_800DPI_OPTICAL_PRO	0x3109
+
 #define USB_VENDOR_ID_IDEACOM		0x1cb6
 #define USB_DEVICE_ID_IDEACOM_IDC6650	0x6650
 #define USB_DEVICE_ID_IDEACOM_IDC6651	0x6651
@@ -664,6 +671,7 @@
 #define USB_DEVICE_ID_LENOVO_TPKBD	0x6009
 #define USB_DEVICE_ID_LENOVO_CUSBKBD	0x6047
 #define USB_DEVICE_ID_LENOVO_CBTKBD	0x6048
+#define USB_DEVICE_ID_LENOVO_SCROLLPOINT_OPTICAL	0x6049
 #define USB_DEVICE_ID_LENOVO_TPPRODOCK	0x6067
 #define USB_DEVICE_ID_LENOVO_X1_COVER	0x6085
 #define USB_DEVICE_ID_LENOVO_X1_TAB	0x60a3
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -6,6 +6,17 @@
  *
  *  Copyright (c) 2012 Bernhard Seibold
  *  Copyright (c) 2014 Jamie Lentin <jm@lentin.co.uk>
+ *
+ * Linux IBM/Lenovo Scrollpoint mouse driver:
+ * - IBM Scrollpoint III
+ * - IBM Scrollpoint Pro
+ * - IBM Scrollpoint Optical
+ * - IBM Scrollpoint Optical 800dpi
+ * - IBM Scrollpoint Optical 800dpi Pro
+ * - Lenovo Scrollpoint Optical
+ *
+ *  Copyright (c) 2012 Peter De Wachter <pdewacht@gmail.com>
+ *  Copyright (c) 2018 Peter Ganzhorn <peter.ganzhorn@gmail.com>
  */
 
 /*
@@ -160,6 +171,17 @@ static int lenovo_input_mapping_cptkbd(s
 	return 0;
 }
 
+static int lenovo_input_mapping_scrollpoint(struct hid_device *hdev,
+		struct hid_input *hi, struct hid_field *field,
+		struct hid_usage *usage, unsigned long **bit, int *max)
+{
+	if (usage->hid == HID_GD_Z) {
+		hid_map_usage(hi, usage, bit, max, EV_REL, REL_HWHEEL);
+		return 1;
+	}
+	return 0;
+}
+
 static int lenovo_input_mapping(struct hid_device *hdev,
 		struct hid_input *hi, struct hid_field *field,
 		struct hid_usage *usage, unsigned long **bit, int *max)
@@ -172,6 +194,14 @@ static int lenovo_input_mapping(struct h
 	case USB_DEVICE_ID_LENOVO_CBTKBD:
 		return lenovo_input_mapping_cptkbd(hdev, hi, field,
 							usage, bit, max);
+	case USB_DEVICE_ID_IBM_SCROLLPOINT_III:
+	case USB_DEVICE_ID_IBM_SCROLLPOINT_PRO:
+	case USB_DEVICE_ID_IBM_SCROLLPOINT_OPTICAL:
+	case USB_DEVICE_ID_IBM_SCROLLPOINT_800DPI_OPTICAL:
+	case USB_DEVICE_ID_IBM_SCROLLPOINT_800DPI_OPTICAL_PRO:
+	case USB_DEVICE_ID_LENOVO_SCROLLPOINT_OPTICAL:
+		return lenovo_input_mapping_scrollpoint(hdev, hi, field,
+							usage, bit, max);
 	default:
 		return 0;
 	}
@@ -883,6 +913,12 @@ static const struct hid_device_id lenovo
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CUSBKBD) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_CBTKBD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_TPPRODOCK) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_IBM, USB_DEVICE_ID_IBM_SCROLLPOINT_III) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_IBM, USB_DEVICE_ID_IBM_SCROLLPOINT_PRO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_IBM, USB_DEVICE_ID_IBM_SCROLLPOINT_OPTICAL) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_IBM, USB_DEVICE_ID_IBM_SCROLLPOINT_800DPI_OPTICAL) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_IBM, USB_DEVICE_ID_IBM_SCROLLPOINT_800DPI_OPTICAL_PRO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_SCROLLPOINT_OPTICAL) },
 	{ }
 };
 


