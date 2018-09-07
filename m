Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EED4C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F1D2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:35:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F1D2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbeIGPPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:15:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728619AbeIGPPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:15:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E516D4025082;
        Fri,  7 Sep 2018 10:35:01 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-25.ams2.redhat.com [10.36.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9039063F4A;
        Fri,  7 Sep 2018 10:35:00 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Simon Wood <simon@mungewell.org>,
        Olivier Gay <ogay@logitech.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4/7] HID: logitech-hidpp: get the name and serial of the other non-HID++ node
Date:   Fri,  7 Sep 2018 12:34:47 +0200
Message-Id: <20180907103450.13890-5-benjamin.tissoires@redhat.com>
In-Reply-To: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
References: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 07 Sep 2018 10:35:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 07 Sep 2018 10:35:02 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The non-Unifying receivers forward the input events over one HID++
capable node (the second one) and one which is not HID++ capable (the
first one, the keyboard). We can use the HID++ information to know
which device name and serial is connected to the first node. For that,
delay the probe of the non-HID++ node, retrieve the information when
available and then authorize the non-HID++ node to appear.

Bonus point, this allows gaming mice to have both input nodes named
after the mouse, and not one called "Logitech USB Receiver".

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 193 +++++++++++++++++++++++++++++++++------
 1 file changed, 166 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 315ef209a0c4..5f96e63dbd87 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -137,6 +137,16 @@ struct hidpp_battery {
 	bool online;
 };
 
+struct hidpp_shared {
+	struct list_head list;
+	char name[128];		/* Device name */
+	char phys[64];		/* Device physical location */
+	char uniq[64];		/* Device unique identifier (serial #) */
+};
+
+static LIST_HEAD(hidpp_shared_list);
+static DEFINE_MUTEX(hidpp_shared_list_lock);
+
 struct hidpp_device {
 	struct hid_device *hid_dev;
 	struct mutex send_mutex;
@@ -160,6 +170,8 @@ struct hidpp_device {
 
 	struct hidpp_battery battery;
 	struct hid_scroll_counter vertical_wheel_counter;
+
+	struct hidpp_shared *shared;
 };
 
 /* HID++ 1.0 error codes */
@@ -398,6 +410,81 @@ static void hidpp_prefix_name(char **name, int name_length)
 	*name = new_name;
 }
 
+static void hidpp_remove_shared_data(void *res)
+{
+	struct hidpp_device *hidpp = res;
+
+	mutex_lock(&hidpp_shared_list_lock);
+
+	if (hidpp->shared) {
+		list_del(&hidpp->shared->list);
+		kfree(hidpp->shared);
+	}
+	hidpp->shared = NULL;
+
+	mutex_unlock(&hidpp_shared_list_lock);
+}
+
+static bool hidpp_compare_device_paths(const char *hdev_a, const char *hdev_b)
+{
+	const char separator = '/';
+	int n1 = strrchr(hdev_a, separator) - hdev_a;
+	int n2 = strrchr(hdev_b, separator) - hdev_b;
+
+	if (n1 != n2 || n1 <= 0 || n2 <= 0)
+		return false;
+
+	return !strncmp(hdev_a, hdev_b, n1);
+}
+
+static int hidpp_allocate_shared_data(struct hidpp_device *hidpp)
+{
+	struct hid_device *hdev = hidpp->hid_dev;
+	struct hidpp_shared *shared = NULL;
+
+	mutex_lock(&hidpp_shared_list_lock);
+
+	shared = kzalloc(sizeof(struct hidpp_shared), GFP_KERNEL);
+	if (!shared) {
+		mutex_unlock(&hidpp_shared_list_lock);
+		return -ENOMEM;
+	}
+	memcpy(shared->name, hdev->name, sizeof(shared->name));
+	memcpy(shared->uniq, hdev->uniq, sizeof(shared->uniq));
+	memcpy(shared->phys, hdev->phys, sizeof(shared->phys));
+	list_add_tail(&shared->list, &hidpp_shared_list);
+
+	hidpp->shared = shared;
+
+	mutex_unlock(&hidpp_shared_list_lock);
+
+	return devm_add_action_or_reset(&hidpp->hid_dev->dev,
+					hidpp_remove_shared_data, hidpp);
+}
+
+static int hidpp_get_shared_data(struct hid_device *hdev)
+{
+	struct hidpp_shared *s, *shared = NULL;
+
+	mutex_lock(&hidpp_shared_list_lock);
+
+	list_for_each_entry(s, &hidpp_shared_list, list) {
+		if (hidpp_compare_device_paths(s->phys, hdev->phys))
+			shared = s;
+	}
+
+	if (!shared) {
+		mutex_unlock(&hidpp_shared_list_lock);
+		return -EPROBE_DEFER;
+	}
+
+	memcpy(hdev->name, shared->name, sizeof(hdev->name));
+	memcpy(hdev->uniq, shared->uniq, sizeof(hdev->uniq));
+
+	mutex_unlock(&hidpp_shared_list_lock);
+	return 0;
+}
+
 /* -------------------------------------------------------------------------- */
 /* HIDP++ 1.0 commands                                                        */
 /* -------------------------------------------------------------------------- */
@@ -750,48 +837,90 @@ static int hidpp_unifying_get_serial(struct hidpp_device *hidpp, int index,
 	return 0;
 }
 
+static int hidpp_unifying_get_name_and_uniq(struct hidpp_device *hidpp,
+		int device_index, u16 quadid, char name[128], char uniq[64])
+{
+	const char *hidpp_name;
+	u32 serial;
+	int ret;
+
+	ret = hidpp_unifying_get_serial(hidpp, device_index, &serial);
+	if (ret)
+		return ret;
+
+	snprintf(uniq, 64, "%04x-%4phD", quadid, &serial);
+	dbg_hid("HID++ Unifying: Got serial: '%s' for device %d\n", uniq,
+		device_index);
+
+	hidpp_name = hidpp_unifying_get_name(hidpp, device_index);
+	if (!hidpp_name)
+		return -EIO;
+
+	snprintf(name, 128, "%s", hidpp_name);
+	dbg_hid("HID++ Unifying: Got name: '%s' for device %d\n", name,
+		device_index);
+
+	kfree(hidpp_name);
+	return 0;
+}
+
 static int hidpp_unifying_init(struct hidpp_device *hidpp)
 {
 	struct hid_device *hdev = hidpp->hid_dev;
-	const char *name;
-	u32 serial;
 	u16 quadid, q;
-	int device_index, ret;
+	int device_index, i, ret;
 	u8 type = 0;
 
 	device_index = 0;
 	quadid = hdev->product;
 
 	if (hidpp->quirks & HIDPP_QUIRK_RECEIVER) {
-		/*
-		 * On the receiver, the HID++ collection is on the mouse
-		 * interface, so match only there.
-		 */
-		ret = hidpp_unifying_get_quadid(hidpp, 2, &q, &type);
-		if (!ret && !hidpp_unifying_type_is_keyboard(type)) {
-			device_index = 2;
-			quadid = q;
+		ret = hidpp_allocate_shared_data(hidpp);
+		if (ret)
+			return ret;
+
+		/* The device indexes go from 1 to 2 */
+		for (i = 1; i <= 2; i++) {
+			ret = hidpp_unifying_get_quadid(hidpp, i, &q, &type);
+			if (ret)
+				continue;
+			/*
+			 * On the receiver, the HID++ collection is on the mouse
+			 * interface, so match only there.
+			 */
+			if (!hidpp_unifying_type_is_keyboard(type)) {
+				device_index = i;
+				quadid = q;
+			}
+
+			/*
+			 * The first device will be reported through the
+			 * first hidraw node (the non HID++ one).
+			 */
+			if (i == 1) {
+				ret = hidpp_unifying_get_name_and_uniq(hidpp, i,
+							q, hidpp->shared->name,
+							hidpp->shared->uniq);
+				if (ret)
+					return ret;
+			}
 		}
 		hidpp_unifying_enable_notifications(hidpp);
 	}
 
-	ret = hidpp_unifying_get_serial(hidpp, device_index, &serial);
-	if (ret)
-		return ret;
-
-	snprintf(hdev->uniq, sizeof(hdev->uniq), "%04x-%4phD", quadid, &serial);
-	dbg_hid("HID++ Unifying: Got serial: %s\n", hdev->uniq);
-
-	name = hidpp_unifying_get_name(hidpp, device_index);
-	if (!name)
-		return -EIO;
-
-	snprintf(hdev->name, sizeof(hdev->name), "%s", name);
-	dbg_hid("HID++ Unifying: Got name: %s\n", name);
+	if (device_index != 1) {
+		ret = hidpp_unifying_get_name_and_uniq(hidpp, device_index,
+						       quadid, hdev->name,
+						       hdev->uniq);
+		if (ret)
+			return ret;
+	} else {
+		memcpy(hdev->name, hidpp->shared->name, sizeof(hdev->name));
+		memcpy(hdev->uniq, hidpp->shared->uniq, sizeof(hdev->uniq));
+	}
 
 	hidpp->device_index = device_index;
 
-	kfree(name);
 	return 0;
 }
 
@@ -3299,10 +3428,20 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	/*
-	 * Make sure the device is HID++ capable, otherwise treat as generic HID
+	 * Make sure the device is HID++ capable, otherwise treat as generic
+	 * HID.
+	 * Special case for manually affected Non Unifying receiver where we
+	 * want to link the interfaces together to have a proper name instead
+	 * of "Logitech USB Receiver".
 	 */
-	if (!hidpp_validate_device(hdev))
+	if (!hidpp_validate_device(hdev)) {
+		if (id->driver_data & HIDPP_QUIRK_RECEIVER) {
+			ret = hidpp_get_shared_data(hdev);
+			if (ret)
+				return ret;
+		}
 		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	}
 
 	hidpp = devm_kzalloc(&hdev->dev, sizeof(struct hidpp_device),
 			GFP_KERNEL);
-- 
2.14.3

