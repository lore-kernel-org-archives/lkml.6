Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98CBECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E8B22087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E8B22087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387818AbeGMO3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:29:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387749AbeGMO3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:29:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60D5114B39A;
        Fri, 13 Jul 2018 14:14:22 +0000 (UTC)
Received: from plouf.banquise.eu.com (ovpn-116-134.ams2.redhat.com [10.36.116.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 139711C67D;
        Fri, 13 Jul 2018 14:14:20 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mario.Limonciello@dell.com,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 12/12] HID: multitouch: handle palm for touchscreens
Date:   Fri, 13 Jul 2018 16:13:54 +0200
Message-Id: <20180713141354.7286-13-benjamin.tissoires@redhat.com>
In-Reply-To: <20180713141354.7286-1-benjamin.tissoires@redhat.com>
References: <20180713141354.7286-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 13 Jul 2018 14:14:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 13 Jul 2018 14:14:22 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Usually, there is no palm rejection for touchscreens. You don't rest
your palm on the touchscreen while interacting with it.
However, some wacom devices do so because you can rest your palm while
interacting with the stylus.

Unfortunately, the spec for touchscreens[1] is less precise than the one
for touchpads[2]. This leads to a situation where it's 'legitimate'
for a touchscreen to provide both tipswitch off and confidence off in the
same report.

Work around that by keeping the slot active for one frame where we report
MT_TOOL_PALM, and then synthesizing the release event in a separate frame.
frame

Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[rebased and new commit message]
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v4
no changes in v3

changes in v2 (compared to Dmitry's initial submission):
- extracted from the initial submission in a separate patch
- rebased on top of my current series
- add an extra input_mt_sync_frame(input); to release the single touch
  emulation
---
 drivers/hid/hid-multitouch.c | 52 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 3464adab0085..40fbb7c52723 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -118,6 +118,9 @@ struct mt_application {
 	int left_button_state;		/* left button state */
 	unsigned int mt_flags;		/* flags to pass to input-mt */
 
+	unsigned long *pending_palm_slots;	/* slots where we reported palm
+						 * and need to release */
+
 	__u8 num_received;	/* how many contacts we received */
 	__u8 num_expected;	/* expected last contact index */
 	__u8 buttons_count;	/* number of physical buttons per touchpad */
@@ -863,6 +866,28 @@ static int mt_compute_slot(struct mt_device *td, struct mt_application *app,
 	return input_mt_get_slot_by_key(input, *slot->contactid);
 }
 
+static void mt_release_pending_palms(struct mt_device *td,
+				     struct mt_application *app,
+				     struct input_dev *input)
+{
+	int slotnum;
+	bool need_sync = false;
+
+	for_each_set_bit(slotnum, app->pending_palm_slots, td->maxcontacts) {
+		clear_bit(slotnum, app->pending_palm_slots);
+
+		input_mt_slot(input, slotnum);
+		input_mt_report_slot_state(input, MT_TOOL_PALM, false);
+
+		need_sync = true;
+	}
+
+	if (need_sync) {
+		input_mt_sync_frame(input);
+		input_sync(input);
+	}
+}
+
 /*
  * this function is called when a whole packet has been received and processed,
  * so that it can decide what to send to the input layer.
@@ -876,6 +901,9 @@ static void mt_sync_frame(struct mt_device *td, struct mt_application *app,
 	input_mt_sync_frame(input);
 	input_event(input, EV_MSC, MSC_TIMESTAMP, app->timestamp);
 	input_sync(input);
+
+	mt_release_pending_palms(td, app, input);
+
 	app->num_received = 0;
 	app->left_button_state = 0;
 
@@ -970,8 +998,23 @@ static int mt_process_slot(struct mt_device *td, struct input_dev *input,
 
 	if (app->application == HID_GD_SYSTEM_MULTIAXIS)
 		tool = MT_TOOL_DIAL;
-	else if (unlikely(!confidence_state))
+	else if (unlikely(!confidence_state)) {
 		tool = MT_TOOL_PALM;
+		if (!active &&
+		    input_mt_is_active(&mt->slots[slotnum])) {
+			/*
+			 * The non-confidence was reported for
+			 * previously valid contact that is also no
+			 * longer valid. We can't simply report
+			 * lift-off as userspace will not be aware
+			 * of non-confidence, so we need to split
+			 * it into 2 events: active MT_TOOL_PALM
+			 * and a separate liftoff.
+			 */
+			active = true;
+			set_bit(slotnum, app->pending_palm_slots);
+		}
+	}
 
 	input_mt_slot(input, slotnum);
 	input_mt_report_slot_state(input, tool, active);
@@ -1197,6 +1240,13 @@ static int mt_touch_input_configured(struct hid_device *hdev,
 	if (td->is_buttonpad)
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
 
+	app->pending_palm_slots = devm_kcalloc(&hi->input->dev,
+					       BITS_TO_LONGS(td->maxcontacts),
+					       sizeof(long),
+					       GFP_KERNEL);
+	if (!app->pending_palm_slots)
+		return -ENOMEM;
+
 	ret = input_mt_init_slots(input, td->maxcontacts, app->mt_flags);
 	if (ret)
 		return ret;
-- 
2.14.3

