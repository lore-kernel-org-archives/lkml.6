Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9DBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2AD2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2AD2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbeKVCCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:02:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731213AbeKVCCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 21:02:36 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C8F989ACC;
        Wed, 21 Nov 2018 15:27:43 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-204-124.brq.redhat.com [10.40.204.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 388DE1054FD3;
        Wed, 21 Nov 2018 15:27:35 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        torvalds@linux-foundation.org
Cc:     Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 5/7] Revert "HID: logitech: Add function to enable HID++ 1.0 "scrolling acceleration""
Date:   Wed, 21 Nov 2018 16:27:10 +0100
Message-Id: <20181121152712.6770-6-benjamin.tissoires@redhat.com>
In-Reply-To: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
References: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 21 Nov 2018 15:27:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 051dc9b0579602bd63e9df74d0879b5293e71581.

It turns out the current API is not that compatible with
some Microsoft mice, so better start again from scratch.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 47 +++++++++-----------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 7f8218f6ff56..19cc980eebce 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -400,53 +400,32 @@ static void hidpp_prefix_name(char **name, int name_length)
 #define HIDPP_SET_LONG_REGISTER				0x82
 #define HIDPP_GET_LONG_REGISTER				0x83
 
-/**
- * hidpp10_set_register_bit() - Sets a single bit in a HID++ 1.0 register.
- * @hidpp_dev: the device to set the register on.
- * @register_address: the address of the register to modify.
- * @byte: the byte of the register to modify. Should be less than 3.
- * Return: 0 if successful, otherwise a negative error code.
- */
-static int hidpp10_set_register_bit(struct hidpp_device *hidpp_dev,
-	u8 register_address, u8 byte, u8 bit)
+#define HIDPP_REG_GENERAL				0x00
+
+static int hidpp10_enable_battery_reporting(struct hidpp_device *hidpp_dev)
 {
 	struct hidpp_report response;
 	int ret;
 	u8 params[3] = { 0 };
 
 	ret = hidpp_send_rap_command_sync(hidpp_dev,
-					  REPORT_ID_HIDPP_SHORT,
-					  HIDPP_GET_REGISTER,
-					  register_address,
-					  NULL, 0, &response);
+					REPORT_ID_HIDPP_SHORT,
+					HIDPP_GET_REGISTER,
+					HIDPP_REG_GENERAL,
+					NULL, 0, &response);
 	if (ret)
 		return ret;
 
 	memcpy(params, response.rap.params, 3);
 
-	params[byte] |= BIT(bit);
+	/* Set the battery bit */
+	params[0] |= BIT(4);
 
 	return hidpp_send_rap_command_sync(hidpp_dev,
-					   REPORT_ID_HIDPP_SHORT,
-					   HIDPP_SET_REGISTER,
-					   register_address,
-					   params, 3, &response);
-}
-
-
-#define HIDPP_REG_GENERAL				0x00
-
-static int hidpp10_enable_battery_reporting(struct hidpp_device *hidpp_dev)
-{
-	return hidpp10_set_register_bit(hidpp_dev, HIDPP_REG_GENERAL, 0, 4);
-}
-
-#define HIDPP_REG_FEATURES				0x01
-
-/* On HID++ 1.0 devices, high-res scroll was called "scrolling acceleration". */
-static int hidpp10_enable_scrolling_acceleration(struct hidpp_device *hidpp_dev)
-{
-	return hidpp10_set_register_bit(hidpp_dev, HIDPP_REG_FEATURES, 0, 6);
+					REPORT_ID_HIDPP_SHORT,
+					HIDPP_SET_REGISTER,
+					HIDPP_REG_GENERAL,
+					params, 3, &response);
 }
 
 #define HIDPP_REG_BATTERY_STATUS			0x07
-- 
2.19.1

