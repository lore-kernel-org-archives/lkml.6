Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753012AbeCTLJI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:09:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752794AbeCTLFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:05:08 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 7/7] HID: core: reset the quirks before calling probe again
Date: Tue, 20 Mar 2018 12:04:51 +0100
Message-Id: <20180320110451.16582-8-benjamin.tissoires@redhat.com>
In-Reply-To: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
References: <20180320110451.16582-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that now the quirk handling is done in hid-quirk.c, we can actually
reset the quirks before calling .probe(), so that the drivers do not need
to keep track of initial quirks.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c       | 2 ++
 drivers/hid/hid-multitouch.c | 7 -------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 36af26c2565b..5d7cc6bbbac6 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1966,6 +1966,8 @@ static int hid_device_probe(struct device *dev)
 			}
 		}
 
+		/* reset the quirks that has been previously set */
+		hdev->quirks = hid_lookup_quirk(hdev);
 		hdev->driver = hdrv;
 		if (hdrv->probe) {
 			ret = hdrv->probe(hdev, id);
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 639c44fc0691..dad2fbb0e3f8 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -127,7 +127,6 @@ struct mt_device {
 	int left_button_state;	/* left button state */
 	unsigned last_slot_field;	/* the last field of a slot */
 	unsigned mt_report_id;	/* the report ID of the multitouch device */
-	unsigned long initial_quirks;	/* initial quirks state */
 	__s16 inputmode;	/* InputMode HID feature, -1 if non-existent */
 	__s16 inputmode_index;	/* InputMode HID feature index in the report */
 	__s16 maxcontact_report_id;	/* Maximum Contact Number HID feature,
@@ -1453,11 +1452,6 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (id->vendor == HID_ANY_ID && id->product == HID_ANY_ID)
 		td->serial_maybe = true;
 
-	/*
-	 * Store the initial quirk state
-	 */
-	td->initial_quirks = hdev->quirks;
-
 	/* This allows the driver to correctly support devices
 	 * that emit events over several HID messages.
 	 */
@@ -1527,7 +1521,6 @@ static void mt_remove(struct hid_device *hdev)
 
 	sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
 	hid_hw_stop(hdev);
-	hdev->quirks = td->initial_quirks;
 }
 
 /*
-- 
2.14.3
