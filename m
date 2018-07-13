Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB532ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7BD2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7BD2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbeGMO3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:29:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41118 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729998AbeGMO3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:29:09 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2E2C94072CFB;
        Fri, 13 Jul 2018 14:14:19 +0000 (UTC)
Received: from plouf.banquise.eu.com (ovpn-116-134.ams2.redhat.com [10.36.116.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31EDD1C67D;
        Fri, 13 Jul 2018 14:14:16 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mario.Limonciello@dell.com,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 10/12] HID: multitouch: report MT_TOOL_PALM for non-confident touches
Date:   Fri, 13 Jul 2018 16:13:52 +0200
Message-Id: <20180713141354.7286-11-benjamin.tissoires@redhat.com>
In-Reply-To: <20180713141354.7286-1-benjamin.tissoires@redhat.com>
References: <20180713141354.7286-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 13 Jul 2018 14:14:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 13 Jul 2018 14:14:19 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

According to Microsoft specification [1] for Precision Touchpads (and
Touchscreens) the devices use "confidence" reports to signal accidental
touches, or contacts that are "too large to be a finger". Instead of
simply marking contact inactive in this case (which causes issues if
contact was originally proper and we lost confidence in it later, as
this results in accidental clicks, drags, etc), let's report such
contacts as MT_TOOL_PALM and let userspace decide what to do.

[1] https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/touchpad-windows-precision-touchpad-collection

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[splitted and rebased]
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v4:
- dropped the touch major/minor modifications for palm events

no changes in v3

changes in v2:
- dropped the delayed release in case of palm detection. This is
  a FW bug for PTP devices, and should only happen with touchscreens
- move input_set_abs_params(hi->input, ABS_MT_TOOL_TYPE,...) into
  its own test so other devices can add MT_QUIRK_CONFIDENCE to their
  quirks.
---
 drivers/hid/hid-multitouch.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index a4a274ebfbef..587369443f50 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -736,6 +736,13 @@ static int mt_touch_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 				cls->name == MT_CLS_WIN_8_DUAL) &&
 				field->application == HID_DG_TOUCHPAD)
 				app->quirks |= MT_QUIRK_CONFIDENCE;
+
+			if (app->quirks & MT_QUIRK_CONFIDENCE)
+				input_set_abs_params(hi->input,
+						     ABS_MT_TOOL_TYPE,
+						     MT_TOOL_FINGER,
+						     MT_TOOL_PALM, 0, 0);
+
 			MT_STORE_FIELD(confidence_state);
 			return 1;
 		case HID_DG_TIPSWITCH:
@@ -958,10 +965,12 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 	if (quirks & MT_QUIRK_HOVERING)
 		inrange_state = *slot->inrange_state;
 
-	active = (*slot->tip_state || inrange_state) && confidence_state;
+	active = *slot->tip_state || inrange_state;
 
 	if (app->application == HID_GD_SYSTEM_MULTIAXIS)
 		tool = MT_TOOL_DIAL;
+	else if (unlikely(!confidence_state))
+		tool = MT_TOOL_PALM;
 
 	input_mt_slot(input, slotnum);
 	input_mt_report_slot_state(input, tool, active);
@@ -993,11 +1002,11 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 			orientation = -azimuth;
 		}
 
-		/*
-		 * divided by two to match visual scale of touch
-		 * for devices with this quirk
-		 */
 		if (quirks & MT_QUIRK_TOUCH_SIZE_SCALING) {
+			/*
+			 * divided by two to match visual scale of touch
+			 * for devices with this quirk
+			 */
 			major = major >> 1;
 			minor = minor >> 1;
 		}
-- 
2.14.3

