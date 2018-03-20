Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeCTLFL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:05:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752785AbeCTLFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:05:06 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 5/7] HID: core: remove the need for HID_QUIRK_NO_EMPTY_INPUT
Date: Tue, 20 Mar 2018 12:04:49 +0100
Message-Id: <20180320110451.16582-6-benjamin.tissoires@redhat.com>
In-Reply-To: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
References: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no real point of registering an empty input node.
This should be default, but given some drivers need the blank input
node to set it up during input_configured, we need to postpone
the check for hidinput_has_been_populated().

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-asus.c       |  3 +--
 drivers/hid/hid-input.c      | 10 +++++-----
 drivers/hid/hid-multitouch.c |  1 -
 drivers/hid/hid-uclogic.c    |  1 -
 include/linux/hid.h          |  2 +-
 5 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index d92f8aa2876b..88a5672f42cd 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -646,8 +646,7 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		 * All functionality is on a single HID interface and for
 		 * userspace the touchpad must be a separate input_dev.
 		 */
-		hdev->quirks |= HID_QUIRK_MULTI_INPUT |
-				HID_QUIRK_NO_EMPTY_INPUT;
+		hdev->quirks |= HID_QUIRK_MULTI_INPUT;
 		drvdata->tp = &asus_t100chi_tp;
 	}
 
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d86398755b0d..6836a856c243 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1657,16 +1657,16 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 	}
 
 	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
-		if ((hid->quirks & HID_QUIRK_NO_EMPTY_INPUT) &&
-		    !hidinput_has_been_populated(hidinput)) {
+		if (drv->input_configured &&
+		    drv->input_configured(hid, hidinput))
+			goto out_unwind;
+
+		if (!hidinput_has_been_populated(hidinput)) {
 			/* no need to register an input device not populated */
 			hidinput_cleanup_hidinput(hid, hidinput);
 			continue;
 		}
 
-		if (drv->input_configured &&
-		    drv->input_configured(hid, hidinput))
-			goto out_unwind;
 		if (input_register_device(hidinput->input))
 			goto out_unwind;
 		hidinput->registered = true;
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 520cb5e2c5c3..03d00e477d0e 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1470,7 +1470,6 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	 * device.
 	 */
 	hdev->quirks |= HID_QUIRK_MULTI_INPUT;
-	hdev->quirks |= HID_QUIRK_NO_EMPTY_INPUT;
 
 	/*
 	 * Some multitouch screens do not like to be polled for input
diff --git a/drivers/hid/hid-uclogic.c b/drivers/hid/hid-uclogic.c
index e3e6e5c893cc..56b196d60041 100644
--- a/drivers/hid/hid-uclogic.c
+++ b/drivers/hid/hid-uclogic.c
@@ -946,7 +946,6 @@ static int uclogic_probe(struct hid_device *hdev,
 	 * than the pen, so use QUIRK_MULTI_INPUT for all tablets.
 	 */
 	hdev->quirks |= HID_QUIRK_MULTI_INPUT;
-	hdev->quirks |= HID_QUIRK_NO_EMPTY_INPUT;
 
 	/* Allocate and assign driver data */
 	drvdata = devm_kzalloc(&hdev->dev, sizeof(*drvdata), GFP_KERNEL);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 3ad758dc285c..8da3e1f48195 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -338,7 +338,7 @@ struct hid_item {
 #define HID_QUIRK_BADPAD			BIT(5)
 #define HID_QUIRK_MULTI_INPUT			BIT(6)
 #define HID_QUIRK_HIDINPUT_FORCE		BIT(7)
-#define HID_QUIRK_NO_EMPTY_INPUT		BIT(8)
+/* BIT(8) reserved for backward compatibility, was HID_QUIRK_NO_EMPTY_INPUT */
 /* BIT(9) reserved for backward compatibility, was NO_INIT_INPUT_REPORTS */
 #define HID_QUIRK_ALWAYS_POLL			BIT(10)
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		BIT(16)
-- 
2.14.3
