Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D61C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4916214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4916214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbeKVCCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:02:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731213AbeKVCCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:02:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CD363154866;
        Wed, 21 Nov 2018 15:27:46 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-204-124.brq.redhat.com [10.40.204.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EACF41054FD3;
        Wed, 21 Nov 2018 15:27:43 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        torvalds@linux-foundation.org
Cc:     Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 6/7] Revert "HID: input: Create a utility class for counting scroll events"
Date:   Wed, 21 Nov 2018 16:27:11 +0100
Message-Id: <20181121152712.6770-7-benjamin.tissoires@redhat.com>
In-Reply-To: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
References: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 21 Nov 2018 15:27:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 1ff2e1a44e02d4bdbb9be67c7d9acc240a67141f.

It turns out the current API is not that compatible with
some Microsoft mice, so better start again from scratch.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 45 -----------------------------------------
 include/linux/hid.h     | 28 -------------------------
 2 files changed, 73 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 28ee2ed88a1a..d6fab5798487 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1841,48 +1841,3 @@ void hidinput_disconnect(struct hid_device *hid)
 }
 EXPORT_SYMBOL_GPL(hidinput_disconnect);
 
-/**
- * hid_scroll_counter_handle_scroll() - Send high- and low-resolution scroll
- *                                      events given a high-resolution wheel
- *                                      movement.
- * @counter: a hid_scroll_counter struct describing the wheel.
- * @hi_res_value: the movement of the wheel, in the mouse's high-resolution
- *                units.
- *
- * Given a high-resolution movement, this function converts the movement into
- * microns and emits high-resolution scroll events for the input device. It also
- * uses the multiplier from &struct hid_scroll_counter to emit low-resolution
- * scroll events when appropriate for backwards-compatibility with userspace
- * input libraries.
- */
-void hid_scroll_counter_handle_scroll(struct hid_scroll_counter *counter,
-				      int hi_res_value)
-{
-	int low_res_scroll_amount;
-	/* Some wheels will rest 7/8ths of a notch from the previous notch
-	 * after slow movement, so we want the threshold for low-res events to
-	 * be in the middle of the notches (e.g. after 4/8ths) as opposed to on
-	 * the notches themselves (8/8ths).
-	 */
-	int threshold = counter->resolution_multiplier / 2;
-
-	input_report_rel(counter->dev, REL_WHEEL_HI_RES,
-			 hi_res_value * counter->microns_per_hi_res_unit);
-
-	counter->remainder += hi_res_value;
-	if (abs(counter->remainder) >= threshold) {
-		/* Add (or subtract) 1 because we want to trigger when the wheel
-		 * is half-way to the next notch (i.e. scroll 1 notch after a
-		 * 1/2 notch movement, 2 notches after a 1 1/2 notch movement,
-		 * etc.).
-		 */
-		low_res_scroll_amount =
-			counter->remainder / counter->resolution_multiplier
-			+ (hi_res_value > 0 ? 1 : -1);
-		input_report_rel(counter->dev, REL_WHEEL,
-				 low_res_scroll_amount);
-		counter->remainder -=
-			low_res_scroll_amount * counter->resolution_multiplier;
-	}
-}
-EXPORT_SYMBOL_GPL(hid_scroll_counter_handle_scroll);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 387c70df6f29..a355d61940f2 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1139,34 +1139,6 @@ static inline u32 hid_report_len(struct hid_report *report)
 int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 		int interrupt);
 
-
-/**
- * struct hid_scroll_counter - Utility class for processing high-resolution
- *                             scroll events.
- * @dev: the input device for which events should be reported.
- * @microns_per_hi_res_unit: the amount moved by the user's finger for each
- *                           high-resolution unit reported by the mouse, in
- *                           microns.
- * @resolution_multiplier: the wheel's resolution in high-resolution mode as a
- *                         multiple of its lower resolution. For example, if
- *                         moving the wheel by one "notch" would result in a
- *                         value of 1 in low-resolution mode but 8 in
- *                         high-resolution, the multiplier is 8.
- * @remainder: counts the number of high-resolution units moved since the last
- *             low-resolution event (REL_WHEEL or REL_HWHEEL) was sent. Should
- *             only be used by class methods.
- */
-struct hid_scroll_counter {
-	struct input_dev *dev;
-	int microns_per_hi_res_unit;
-	int resolution_multiplier;
-
-	int remainder;
-};
-
-void hid_scroll_counter_handle_scroll(struct hid_scroll_counter *counter,
-				      int hi_res_value);
-
 /* HID quirks API */
 unsigned long hid_lookup_quirk(const struct hid_device *hdev);
 int hid_quirks_init(char **quirks_param, __u16 bus, int count);
-- 
2.19.1

