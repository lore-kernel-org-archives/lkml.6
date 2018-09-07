Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A24C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8946020861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8946020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeIGPP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 11:15:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32830 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728685AbeIGPPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 11:15:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00E89807A0D0;
        Fri,  7 Sep 2018 10:35:04 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-25.ams2.redhat.com [10.36.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32F4842227;
        Fri,  7 Sep 2018 10:35:02 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Simon Wood <simon@mungewell.org>,
        Olivier Gay <ogay@logitech.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 5/7] HID: logitech-hidpp: create a name based on the type if non available
Date:   Fri,  7 Sep 2018 12:34:48 +0200
Message-Id: <20180907103450.13890-6-benjamin.tissoires@redhat.com>
In-Reply-To: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
References: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 07 Sep 2018 10:35:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 07 Sep 2018 10:35:04 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some low cost devices don't even have a name (nor a serial) registered
in the receiver. In those case, create a better name that "Logitech
USB Receiver" or even "Logitech  " if we try to get their name.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 5f96e63dbd87..a09509fdb746 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -802,6 +802,9 @@ static char *hidpp_unifying_get_name(struct hidpp_device *hidpp_dev, int index)
 	if (2 + len > sizeof(response.rap.params))
 		return NULL;
 
+	if (len < 4) /* logitech devices are usually at least Xddd */
+		return NULL;
+
 	name = kzalloc(len + 1, GFP_KERNEL);
 	if (!name)
 		return NULL;
@@ -838,7 +841,8 @@ static int hidpp_unifying_get_serial(struct hidpp_device *hidpp, int index,
 }
 
 static int hidpp_unifying_get_name_and_uniq(struct hidpp_device *hidpp,
-		int device_index, u16 quadid, char name[128], char uniq[64])
+		int device_index, u16 quadid, u8 type, char name[128],
+		char uniq[64])
 {
 	const char *hidpp_name;
 	u32 serial;
@@ -853,8 +857,29 @@ static int hidpp_unifying_get_name_and_uniq(struct hidpp_device *hidpp,
 		device_index);
 
 	hidpp_name = hidpp_unifying_get_name(hidpp, device_index);
-	if (!hidpp_name)
-		return -EIO;
+	if (!hidpp_name) {
+		switch (type) {
+		case 0x01:
+			snprintf(name, 128, "Logitech Wireless Keyboard");
+			break;
+		case 0x02:
+			snprintf(name, 128, "Logitech Wireless Mouse");
+			break;
+		case 0x03:
+			snprintf(name, 128, "Logitech Wireless Numpad");
+			break;
+		case 0x04:
+			snprintf(name, 128, "Logitech Wireless Presenter");
+			break;
+		case 0x08:
+			snprintf(name, 128, "Logitech Wireless Trackball");
+			break;
+		case 0x09:
+			snprintf(name, 128, "Logitech Wireless Touchpad");
+			break;
+		}
+		return 0;
+	}
 
 	snprintf(name, 128, "%s", hidpp_name);
 	dbg_hid("HID++ Unifying: Got name: '%s' for device %d\n", name,
@@ -899,7 +924,8 @@ static int hidpp_unifying_init(struct hidpp_device *hidpp)
 			 */
 			if (i == 1) {
 				ret = hidpp_unifying_get_name_and_uniq(hidpp, i,
-							q, hidpp->shared->name,
+							q, type,
+							hidpp->shared->name,
 							hidpp->shared->uniq);
 				if (ret)
 					return ret;
@@ -910,7 +936,7 @@ static int hidpp_unifying_init(struct hidpp_device *hidpp)
 
 	if (device_index != 1) {
 		ret = hidpp_unifying_get_name_and_uniq(hidpp, device_index,
-						       quadid, hdev->name,
+						       quadid, type, hdev->name,
 						       hdev->uniq);
 		if (ret)
 			return ret;
-- 
2.14.3

