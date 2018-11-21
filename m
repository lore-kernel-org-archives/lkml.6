Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A538DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789712146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789712146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbeKVCCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:02:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35234 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731213AbeKVCCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:02:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64602307CDD6;
        Wed, 21 Nov 2018 15:27:26 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-204-124.brq.redhat.com [10.40.204.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 032DD103BAB7;
        Wed, 21 Nov 2018 15:27:23 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        torvalds@linux-foundation.org
Cc:     Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/7] Revert "HID: input: simplify/fix high-res scroll event handling"
Date:   Wed, 21 Nov 2018 16:27:06 +0100
Message-Id: <20181121152712.6770-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
References: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 21 Nov 2018 15:27:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 044ee890286153a1aefb40cb8b6659921aecb38b.

It turns out the current API is not that compatible with
some Microsoft mice, so better start again from scratch.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 43 +++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 44ea8e7c71a9..28ee2ed88a1a 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1858,30 +1858,31 @@ EXPORT_SYMBOL_GPL(hidinput_disconnect);
 void hid_scroll_counter_handle_scroll(struct hid_scroll_counter *counter,
 				      int hi_res_value)
 {
-	int low_res_value, remainder, multiplier;
+	int low_res_scroll_amount;
+	/* Some wheels will rest 7/8ths of a notch from the previous notch
+	 * after slow movement, so we want the threshold for low-res events to
+	 * be in the middle of the notches (e.g. after 4/8ths) as opposed to on
+	 * the notches themselves (8/8ths).
+	 */
+	int threshold = counter->resolution_multiplier / 2;
 
 	input_report_rel(counter->dev, REL_WHEEL_HI_RES,
 			 hi_res_value * counter->microns_per_hi_res_unit);
 
-	/*
-	 * Update the low-res remainder with the high-res value,
-	 * but reset if the direction has changed.
-	 */
-	remainder = counter->remainder;
-	if ((remainder ^ hi_res_value) < 0)
-		remainder = 0;
-	remainder += hi_res_value;
-
-	/*
-	 * Then just use the resolution multiplier to see if
-	 * we should send a low-res (aka regular wheel) event.
-	 */
-	multiplier = counter->resolution_multiplier;
-	low_res_value = remainder / multiplier;
-	remainder -= low_res_value * multiplier;
-	counter->remainder = remainder;
-
-	if (low_res_value)
-		input_report_rel(counter->dev, REL_WHEEL, low_res_value);
+	counter->remainder += hi_res_value;
+	if (abs(counter->remainder) >= threshold) {
+		/* Add (or subtract) 1 because we want to trigger when the wheel
+		 * is half-way to the next notch (i.e. scroll 1 notch after a
+		 * 1/2 notch movement, 2 notches after a 1 1/2 notch movement,
+		 * etc.).
+		 */
+		low_res_scroll_amount =
+			counter->remainder / counter->resolution_multiplier
+			+ (hi_res_value > 0 ? 1 : -1);
+		input_report_rel(counter->dev, REL_WHEEL,
+				 low_res_scroll_amount);
+		counter->remainder -=
+			low_res_scroll_amount * counter->resolution_multiplier;
+	}
 }
 EXPORT_SYMBOL_GPL(hid_scroll_counter_handle_scroll);
-- 
2.19.1

