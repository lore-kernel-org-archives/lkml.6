Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEB8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2C72146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2C72146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbeKVCCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:02:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731213AbeKVCCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:02:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3184D30820F2;
        Wed, 21 Nov 2018 15:27:29 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-204-124.brq.redhat.com [10.40.204.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C229F103BAB7;
        Wed, 21 Nov 2018 15:27:26 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        torvalds@linux-foundation.org
Cc:     Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/7] Revert "HID: logitech: fix a used uninitialized GCC warning"
Date:   Wed, 21 Nov 2018 16:27:07 +0100
Message-Id: <20181121152712.6770-3-benjamin.tissoires@redhat.com>
In-Reply-To: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
References: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 21 Nov 2018 15:27:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 5fe2ccbef9d7aecf5c4402c753444f1a12096cfd.

It turns out the current API is not that compatible with
some Microsoft mice, so better start again from scratch.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index f01280898b24..5f0c080059c6 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1231,6 +1231,7 @@ static int hidpp_hrw_get_wheel_capability(struct hidpp_device *hidpp,
 	*multiplier = response.fap.params[0];
 	return 0;
 return_default:
+	*multiplier = 8;
 	hid_warn(hidpp->hid_dev,
 		 "Couldn't get wheel multiplier (error %d), assuming %d.\n",
 		 ret, *multiplier);
@@ -2695,7 +2696,7 @@ static int hi_res_scroll_look_up_microns(__u32 product_id)
 static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 {
 	int ret;
-	u8 multiplier = 8;
+	u8 multiplier;
 
 	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2121) {
 		ret = hidpp_hrw_set_wheel_mode(hidpp, false, true, false);
@@ -2703,9 +2704,10 @@ static int hi_res_scroll_enable(struct hidpp_device *hidpp)
 	} else if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_X2120) {
 		ret = hidpp_hrs_set_highres_scrolling_mode(hidpp, true,
 							   &multiplier);
-	} else /* if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_1P0) */
+	} else /* if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL_1P0) */ {
 		ret = hidpp10_enable_scrolling_acceleration(hidpp);
-
+		multiplier = 8;
+	}
 	if (ret)
 		return ret;
 
-- 
2.19.1

