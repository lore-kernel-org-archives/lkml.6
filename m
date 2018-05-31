Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754861AbeEaLtj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:49:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754828AbeEaLtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:49:35 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>, Mario.Limonciello@dell.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: core: allow concurrent registration of drivers
Date: Thu, 31 May 2018 13:49:29 +0200
Message-Id: <20180531114929.30545-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detected on the Dell XPS 9365.
The laptop has 2 devices that benefit from the hid-generic auto-unbinding.
When those 2 devices are presented to the userspace, udev loads both
wacom and hid-multitouch. When this happens, the code in
__hid_bus_reprobe_drivers() is called concurrently and the second device
gets reprobed twice.
An other bug in the power_supply subsystem prevent to remove the wacom
driver if it just finished its initialization, which basically kills
the wacom node.

Fixes c17a7476e4c4 ("HID: core: rewrite the hid-generic automatic unbind")

Cc: stable@vger.kernel.org # v4.17
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi Mario,

can you please test this on your faulty XPS?
I think it'll fix the issue, but I can not reproduce, so better wait for
your confirmation.

Jiri, ideally I would love to see this in v4.17 final, but Mario seems
to be on PTO until next week. I guess we'll just push this in v4.17.1
then. Also, if you can double check that it makes sense, that would be
nice :)

Cheers,
Benjamin

 drivers/hid/hid-core.c | 5 ++++-
 include/linux/hid.h    | 3 ++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 2f7367b1de00..7afed0c0f9e5 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1960,6 +1960,8 @@ static int hid_device_probe(struct device *dev)
 	}
 	hdev->io_started = false;
 
+	clear_bit(ffs(HID_STAT_REPROBED), &hdev->status);
+
 	if (!hdev->driver) {
 		id = hid_match_device(hdev, hdrv);
 		if (id == NULL) {
@@ -2223,7 +2225,8 @@ static int __hid_bus_reprobe_drivers(struct device *dev, void *data)
 	struct hid_device *hdev = to_hid_device(dev);
 
 	if (hdev->driver == hdrv &&
-	    !hdrv->match(hdev, hid_ignore_special_drivers))
+	    !hdrv->match(hdev, hid_ignore_special_drivers) &&
+	    !test_and_set_bit(ffs(HID_STAT_REPROBED), &hdev->status))
 		return device_reprobe(dev);
 
 	return 0;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index ee2510019033..aee281522c6d 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -517,6 +517,7 @@ struct hid_output_fifo {
 #define HID_STAT_ADDED		BIT(0)
 #define HID_STAT_PARSED		BIT(1)
 #define HID_STAT_DUP_DETECTED	BIT(2)
+#define HID_STAT_REPROBED	BIT(3)
 
 struct hid_input {
 	struct list_head list;
@@ -585,7 +586,7 @@ struct hid_device {							/* device report descriptor */
 	bool battery_avoid_query;
 #endif
 
-	unsigned int status;						/* see STAT flags above */
+	unsigned long status;						/* see STAT flags above */
 	unsigned claimed;						/* Claimed by hidinput, hiddev? */
 	unsigned quirks;						/* Various quirks the device can pull on us */
 	bool io_started;						/* If IO has started */
-- 
2.14.3
