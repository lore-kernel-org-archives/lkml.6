Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDB1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8699720659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8699720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbeIDR47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:56:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727057AbeIDR46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:56:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E64040241C5;
        Tue,  4 Sep 2018 13:31:49 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-25.ams2.redhat.com [10.36.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AA0EA9EF7;
        Tue,  4 Sep 2018 13:31:48 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] HID: multitouch: simplify the application retrieval
Date:   Tue,  4 Sep 2018 15:31:15 +0200
Message-Id: <20180904133115.5111-5-benjamin.tissoires@redhat.com>
In-Reply-To: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
References: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 04 Sep 2018 13:31:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 04 Sep 2018 13:31:49 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the application is simply stored in struct hid_input, we can
overwrite it in mt_input_mapping() for the faulty egalax and have a
simpler suffix processing in mt_input_configured()

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 72 ++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 40 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index da954f3f4da7..f7c6de2b6730 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1319,6 +1319,13 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		return mt_touch_input_mapping(hdev, hi, field, usage, bit, max,
 					      application);
 
+	/*
+	 * some egalax touchscreens have "application == DG_TOUCHSCREEN"
+	 * for the stylus. Overwrite the hid_input application
+	 */
+	if (field->physical == HID_DG_STYLUS)
+		hi->application = HID_DG_STYLUS;
+
 	/* let hid-core decide for the others */
 	return 0;
 }
@@ -1507,14 +1514,12 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	struct mt_device *td = hid_get_drvdata(hdev);
 	char *name;
 	const char *suffix = NULL;
-	unsigned int application = 0;
 	struct mt_report_data *rdata;
 	struct mt_application *mt_application = NULL;
 	struct hid_report *report;
 	int ret;
 
 	list_for_each_entry(report, &hi->reports, hidinput_list) {
-		application = report->application;
 		rdata = mt_find_report_data(td, report);
 		if (!rdata) {
 			hid_err(hdev, "failed to allocate data for report\n");
@@ -1529,46 +1534,33 @@ static int mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 			if (ret)
 				return ret;
 		}
-
-		/*
-		 * some egalax touchscreens have "application == DG_TOUCHSCREEN"
-		 * for the stylus. Check this first, and then rely on
-		 * the application field.
-		 */
-		if (report->field[0]->physical == HID_DG_STYLUS) {
-			suffix = "Pen";
-			/* force BTN_STYLUS to allow tablet matching in udev */
-			__set_bit(BTN_STYLUS, hi->input->keybit);
-		}
 	}
 
-	if (!suffix) {
-		switch (application) {
-		case HID_GD_KEYBOARD:
-		case HID_GD_KEYPAD:
-		case HID_GD_MOUSE:
-		case HID_DG_TOUCHPAD:
-		case HID_GD_SYSTEM_CONTROL:
-		case HID_CP_CONSUMER_CONTROL:
-		case HID_GD_WIRELESS_RADIO_CTLS:
-		case HID_GD_SYSTEM_MULTIAXIS:
-			/* already handled by hid core */
-			break;
-		case HID_DG_TOUCHSCREEN:
-			/* we do not set suffix = "Touchscreen" */
-			hi->input->name = hdev->name;
-			break;
-		case HID_DG_STYLUS:
-			/* force BTN_STYLUS to allow tablet matching in udev */
-			__set_bit(BTN_STYLUS, hi->input->keybit);
-			break;
-		case HID_VD_ASUS_CUSTOM_MEDIA_KEYS:
-			suffix = "Custom Media Keys";
-			break;
-		default:
-			suffix = "UNKNOWN";
-			break;
-		}
+	switch (hi->application) {
+	case HID_GD_KEYBOARD:
+	case HID_GD_KEYPAD:
+	case HID_GD_MOUSE:
+	case HID_DG_TOUCHPAD:
+	case HID_GD_SYSTEM_CONTROL:
+	case HID_CP_CONSUMER_CONTROL:
+	case HID_GD_WIRELESS_RADIO_CTLS:
+	case HID_GD_SYSTEM_MULTIAXIS:
+		/* already handled by hid core */
+		break;
+	case HID_DG_TOUCHSCREEN:
+		/* we do not set suffix = "Touchscreen" */
+		hi->input->name = hdev->name;
+		break;
+	case HID_DG_STYLUS:
+		/* force BTN_STYLUS to allow tablet matching in udev */
+		__set_bit(BTN_STYLUS, hi->input->keybit);
+		break;
+	case HID_VD_ASUS_CUSTOM_MEDIA_KEYS:
+		suffix = "Custom Media Keys";
+		break;
+	default:
+		suffix = "UNKNOWN";
+		break;
 	}
 
 	if (suffix) {
-- 
2.14.3

